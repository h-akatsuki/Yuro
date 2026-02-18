import 'dart:io';

import 'package:asmrapp/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadDirectoryController extends ChangeNotifier {
  static const String _customDirectoryKey = 'download_custom_directory';

  final SharedPreferences _prefs;

  DownloadDirectoryController(this._prefs) {
    _customDirectoryPath = _prefs.getString(_customDirectoryKey);
  }

  String? _customDirectoryPath;
  String? _lastError;

  String? get customDirectoryPath => _customDirectoryPath;
  bool get hasCustomDirectory =>
      _customDirectoryPath != null && _customDirectoryPath!.isNotEmpty;
  String? get lastError => _lastError;

  Future<bool> ensureWritePermissionIfNeeded() async {
    if (!Platform.isAndroid) {
      return true;
    }

    try {
      final storageStatus = await Permission.storage.status;
      if (storageStatus.isGranted) {
        return true;
      }

      final storageResult = await Permission.storage.request();
      if (storageResult.isGranted) {
        return true;
      }

      final manageStatus = await Permission.manageExternalStorage.status;
      if (manageStatus.isGranted) {
        return true;
      }
      final manageResult = await Permission.manageExternalStorage.request();
      return manageResult.isGranted;
    } catch (e) {
      AppLogger.error('请求存储权限失败', e);
      return false;
    }
  }

  Future<void> setCustomDirectoryPath(String path) async {
    final trimmed = path.trim();
    if (trimmed.isEmpty) {
      throw Exception('目录路径为空');
    }

    final directory = Directory(trimmed);
    await _ensureDirectoryExists(directory);

    var writable = await _checkWritable(directory);
    if (!writable) {
      final granted = await ensureWritePermissionIfNeeded();
      if (granted) {
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        writable = await _checkWritable(directory);
      }
    }
    if (!writable) {
      throw Exception('目录不可写或权限不足');
    }

    _customDirectoryPath = directory.path;
    _lastError = null;
    await _prefs.setString(_customDirectoryKey, directory.path);
    notifyListeners();
  }

  Future<void> clearCustomDirectoryPath() async {
    _customDirectoryPath = null;
    _lastError = null;
    await _prefs.remove(_customDirectoryKey);
    notifyListeners();
  }

  Future<Directory> resolveDownloadRootDirectory() async {
    if (hasCustomDirectory) {
      final custom = Directory(_customDirectoryPath!);
      await _ensureDirectoryExists(custom);

      var writable = await _checkWritable(custom);
      if (!writable) {
        final granted = await ensureWritePermissionIfNeeded();
        if (granted) {
          if (!await custom.exists()) {
            await custom.create(recursive: true);
          }
          writable = await _checkWritable(custom);
        }
      }

      if (!writable) {
        _lastError = '自定义下载目录不可写';
        notifyListeners();
        throw Exception(_lastError);
      }

      _lastError = null;
      return custom;
    }

    final candidateBaseDirectories = <Directory?>[];
    try {
      candidateBaseDirectories.add(await getDownloadsDirectory());
    } catch (_) {
      candidateBaseDirectories.add(null);
    }
    candidateBaseDirectories.add(await getApplicationDocumentsDirectory());

    for (final baseDirectory in candidateBaseDirectories) {
      if (baseDirectory == null) continue;

      try {
        final rootDirectory = Directory(
          '${baseDirectory.path}${Platform.pathSeparator}asmr_downloads',
        );
        await _ensureDirectoryExists(rootDirectory);
        var writable = await _checkWritable(rootDirectory);
        if (!writable) {
          final granted = await ensureWritePermissionIfNeeded();
          if (granted) {
            if (!await rootDirectory.exists()) {
              await rootDirectory.create(recursive: true);
            }
            writable = await _checkWritable(rootDirectory);
          }
        }
        if (writable) {
          _lastError = null;
          return rootDirectory;
        }
      } catch (e) {
        AppLogger.error('创建默认下载目录失败: ${baseDirectory.path}', e);
      }
    }

    _lastError = '无法创建下载目录';
    notifyListeners();
    throw Exception(_lastError);
  }

  Future<bool> _checkWritable(Directory directory) async {
    final probeFile = File(
      '${directory.path}${Platform.pathSeparator}.asmr_write_probe',
    );
    try {
      await probeFile.writeAsString(
        DateTime.now().microsecondsSinceEpoch.toString(),
        flush: true,
      );
      if (await probeFile.exists()) {
        await probeFile.delete();
      }
      return true;
    } catch (e) {
      AppLogger.error('目录写入检查失败: ${directory.path}', e);
      return false;
    }
  }

  Future<void> _ensureDirectoryExists(Directory directory) async {
    if (await directory.exists()) {
      return;
    }

    try {
      await directory.create(recursive: true);
      return;
    } catch (_) {
      final granted = await ensureWritePermissionIfNeeded();
      if (!granted) {
        rethrow;
      }
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
    }
  }
}
