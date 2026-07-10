import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:asmrapp/common/utils/work_localizations.dart';
import 'package:asmrapp/core/download/bulk_save_path_utils.dart';
import 'package:asmrapp/core/download/download_directory_controller.dart';
import 'package:asmrapp/data/models/files/child.dart';
import 'package:asmrapp/data/models/my_lists/my_playlists/playlist.dart';
import 'package:asmrapp/data/models/works/work.dart';
import 'package:asmrapp/data/services/api_service.dart';
import 'package:asmrapp/utils/logger.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

enum BulkSaveRunState { idle, running, completed, cancelled, failed }

class BulkSaveResult {
  final int savedWorks;
  final int skippedWorks;
  final int failedWorks;
  final int reusedFiles;
  final int downloadedFiles;

  const BulkSaveResult({
    required this.savedWorks,
    required this.skippedWorks,
    required this.failedWorks,
    required this.reusedFiles,
    required this.downloadedFiles,
  });
}

class BulkSaveController extends ChangeNotifier {
  static const String _completeMarkerName = '.yuro-complete.json';
  static const String _partialMarkerName = '.yuro-partial.json';
  static const int _pageSize = 100;

  final ApiService _apiService;
  final DownloadDirectoryController _directoryController;

  BulkSaveRunState _state = BulkSaveRunState.idle;
  CancelToken? _cancelToken;
  BulkSaveResult? _result;
  String? _error;
  String? _currentWorkCode;
  String? _currentFileName;
  int _totalWorks = 0;
  int _processedWorks = 0;
  double? _currentFileProgress;
  DateTime _lastProgressNotification = DateTime.fromMillisecondsSinceEpoch(0);

  BulkSaveController({
    required ApiService apiService,
    required DownloadDirectoryController directoryController,
  }) : _apiService = apiService,
       _directoryController = directoryController;

  BulkSaveRunState get state => _state;
  bool get isRunning => _state == BulkSaveRunState.running;
  BulkSaveResult? get result => _result;
  String? get error => _error;
  String? get currentWorkCode => _currentWorkCode;
  String? get currentFileName => _currentFileName;
  int get totalWorks => _totalWorks;
  int get processedWorks => _processedWorks;
  double? get currentFileProgress => _currentFileProgress;
  double? get overallProgress =>
      _totalWorks <= 0 ? null : (_processedWorks / _totalWorks).clamp(0, 1);

  Future<void> saveLikes({required Locale locale}) async {
    await _start(
      locale: locale,
      loadCollections: () async => <_CollectionSavePlan>[
        _CollectionSavePlan(
          collectionDirectory: 'likes',
          works: await _loadAllLikes(),
        ),
      ],
    );
  }

  Future<void> savePlaylist({
    required Playlist playlist,
    required String playlistName,
    required Locale locale,
  }) async {
    final playlistId = playlist.id?.trim();
    if (playlistId == null || playlistId.isEmpty) {
      throw StateError('プレイリストIDがありません');
    }
    final safePlaylistName = BulkSavePathUtils.sanitizePathSegment(
      playlistName,
      fallback: playlistId,
    );
    await _start(
      locale: locale,
      loadCollections: () async => <_CollectionSavePlan>[
        _CollectionSavePlan(
          collectionDirectory: <String>[
            'playlists',
            safePlaylistName,
          ].join(Platform.pathSeparator),
          works: await _loadAllPlaylistWorks(playlistId),
        ),
      ],
    );
  }

  Future<void> saveAllPlaylists({
    required Locale locale,
    required String Function(Playlist playlist) playlistNameFor,
  }) async {
    await _start(
      locale: locale,
      loadCollections: () => _loadAllPlaylistCollections(playlistNameFor),
    );
  }

  void cancel() {
    if (!isRunning) return;
    _cancelToken?.cancel('Bulk save cancelled');
  }

  Future<void> _start({
    required Locale locale,
    required Future<List<_CollectionSavePlan>> Function() loadCollections,
  }) async {
    if (isRunning) return;

    _state = BulkSaveRunState.running;
    _result = null;
    _error = null;
    _currentWorkCode = null;
    _currentFileName = null;
    _totalWorks = 0;
    _processedWorks = 0;
    _currentFileProgress = null;
    _cancelToken = CancelToken();
    notifyListeners();

    var savedWorks = 0;
    var skippedWorks = 0;
    var failedWorks = 0;
    var reusedFiles = 0;
    var downloadedFiles = 0;

    try {
      final rootDirectory = await _directoryController
          .resolveBulkSaveRootDirectory();
      final collections = await loadCollections();
      _throwIfCancelled();
      final tasks = <_CollectionWorkSaveTask>[
        for (final collection in collections)
          for (final work in _deduplicateWorks(collection.works))
            _CollectionWorkSaveTask(collection: collection, work: work),
      ];
      _totalWorks = tasks.length;
      notifyListeners();

      final destinationRoots = <_CollectionSavePlan, Directory>{};
      for (final collection in collections) {
        final destinationRoot = Directory(
          '${rootDirectory.path}${Platform.pathSeparator}'
          '${collection.collectionDirectory}',
        );
        await destinationRoot.create(recursive: true);
        destinationRoots[collection] = destinationRoot;
      }

      Directory? legacyDownloadRoot;
      try {
        legacyDownloadRoot = await _directoryController
            .resolveDownloadRootDirectory();
      } catch (error) {
        AppLogger.info('既存ダウンロード先の再利用をスキップ: $error');
      }

      final candidateIndex = await _buildCandidateIndex(
        rootDirectory,
        legacyDownloadRoot,
        tasks.map((task) => BulkSavePathUtils.workCode(task.work)).toSet(),
      );

      for (final task in tasks) {
        _throwIfCancelled();
        final work = task.work;
        final code = BulkSavePathUtils.workCode(work);
        final normalizedCode = BulkSavePathUtils.normalizeCode(code);
        _currentWorkCode = code;
        _currentFileName = null;
        _currentFileProgress = null;
        notifyListeners();

        try {
          final outcome = await _saveWork(
            work: work,
            title: work.localizedTitle(locale),
            code: code,
            destinationRoot: destinationRoots[task.collection]!,
            candidateDirectories:
                candidateIndex[normalizedCode] ?? const <Directory>[],
          );
          if (outcome.skipped) {
            skippedWorks++;
          } else {
            savedWorks++;
          }
          reusedFiles += outcome.reusedFiles;
          downloadedFiles += outcome.downloadedFiles;
          final candidates = candidateIndex.putIfAbsent(
            normalizedCode,
            () => <Directory>[],
          );
          if (!candidates.any(
            (directory) => directory.path == outcome.directory.path,
          )) {
            candidates.add(outcome.directory);
          }
        } catch (error, stackTrace) {
          if (_isCancellation(error)) rethrow;
          failedWorks++;
          AppLogger.error('一括保存に失敗: $code', error, stackTrace);
        }

        _processedWorks++;
        _currentFileName = null;
        _currentFileProgress = null;
        notifyListeners();
      }

      _result = BulkSaveResult(
        savedWorks: savedWorks,
        skippedWorks: skippedWorks,
        failedWorks: failedWorks,
        reusedFiles: reusedFiles,
        downloadedFiles: downloadedFiles,
      );
      _state = BulkSaveRunState.completed;
    } catch (error, stackTrace) {
      _result = BulkSaveResult(
        savedWorks: savedWorks,
        skippedWorks: skippedWorks,
        failedWorks: failedWorks,
        reusedFiles: reusedFiles,
        downloadedFiles: downloadedFiles,
      );
      if (_isCancellation(error)) {
        _state = BulkSaveRunState.cancelled;
      } else {
        _state = BulkSaveRunState.failed;
        _error = error.toString();
        AppLogger.error('一括保存の開始に失敗', error, stackTrace);
      }
    } finally {
      _cancelToken = null;
      _currentFileName = null;
      _currentFileProgress = null;
      notifyListeners();
    }
  }

  Future<List<Work>> _loadAllLikes() async {
    final first = await _apiService.getFavorites(
      page: 1,
      pageSize: _pageSize,
      cancelToken: _cancelToken,
    );
    return _loadRemainingPages(
      first: first,
      loadPage: (page) => _apiService.getFavorites(
        page: page,
        pageSize: _pageSize,
        cancelToken: _cancelToken,
      ),
    );
  }

  Future<List<_CollectionSavePlan>> _loadAllPlaylistCollections(
    String Function(Playlist playlist) playlistNameFor,
  ) async {
    final playlists = await _loadAllPlaylists();
    final usedDirectoryNames = <String>{};
    final collections = <_CollectionSavePlan>[];
    for (final playlist in playlists) {
      _throwIfCancelled();
      final playlistId = playlist.id?.trim();
      if (playlistId == null || playlistId.isEmpty) {
        AppLogger.info('IDのないプレイリストを一括保存から除外しました');
        continue;
      }
      final directoryName = _uniqueDirectoryName(
        BulkSavePathUtils.sanitizePathSegment(
          playlistNameFor(playlist),
          fallback: playlistId,
        ),
        usedDirectoryNames,
      );
      collections.add(
        _CollectionSavePlan(
          collectionDirectory: <String>[
            'playlists',
            directoryName,
          ].join(Platform.pathSeparator),
          works: await _loadAllPlaylistWorks(playlistId),
        ),
      );
    }
    return collections;
  }

  Future<List<Playlist>> _loadAllPlaylists() async {
    final first = await _apiService.getMyPlaylists(
      page: 1,
      cancelToken: _cancelToken,
    );
    final playlists = <Playlist>[...?first.playlists];
    final pageSize = first.pagination?.pageSize ?? playlists.length;
    final totalCount = first.pagination?.totalCount ?? playlists.length;
    if (pageSize > 0 && totalCount > playlists.length) {
      final totalPages = (totalCount / pageSize).ceil();
      for (var page = 2; page <= totalPages; page++) {
        _throwIfCancelled();
        final response = await _apiService.getMyPlaylists(
          page: page,
          cancelToken: _cancelToken,
        );
        playlists.addAll(response.playlists ?? const <Playlist>[]);
      }
    }

    final byId = <String, Playlist>{};
    for (final playlist in playlists) {
      final id = playlist.id?.trim();
      if (id != null && id.isNotEmpty) {
        byId.putIfAbsent(id, () => playlist);
      }
    }
    return byId.values.toList(growable: false);
  }

  Future<List<Work>> _loadAllPlaylistWorks(String playlistId) async {
    final first = await _apiService.getPlaylistWorks(
      playlistId: playlistId,
      page: 1,
      pageSize: _pageSize,
      cancelToken: _cancelToken,
    );
    return _loadRemainingPages(
      first: first,
      loadPage: (page) => _apiService.getPlaylistWorks(
        playlistId: playlistId,
        page: page,
        pageSize: _pageSize,
        cancelToken: _cancelToken,
      ),
    );
  }

  Future<List<Work>> _loadRemainingPages({
    required WorksResponse first,
    required Future<WorksResponse> Function(int page) loadPage,
  }) async {
    final works = <Work>[...first.works];
    final pageSize = first.pagination.pageSize ?? first.works.length;
    final totalCount = first.pagination.totalCount ?? first.works.length;
    if (pageSize <= 0 || totalCount <= works.length) return works;

    final totalPages = (totalCount / pageSize).ceil();
    for (var page = 2; page <= totalPages; page++) {
      _throwIfCancelled();
      final response = await loadPage(page);
      works.addAll(response.works);
    }
    return works;
  }

  List<Work> _deduplicateWorks(List<Work> works) {
    final byCode = <String, Work>{};
    for (final work in works) {
      byCode.putIfAbsent(
        BulkSavePathUtils.normalizeCode(BulkSavePathUtils.workCode(work)),
        () => work,
      );
    }
    return byCode.values.toList(growable: false);
  }

  Future<_WorkSaveOutcome> _saveWork({
    required Work work,
    required String title,
    required String code,
    required Directory destinationRoot,
    required List<Directory> candidateDirectories,
  }) async {
    final files = await _apiService.getWorkFiles(
      work.id.toString(),
      cancelToken: _cancelToken,
    );
    _throwIfCancelled();

    final specs = _collectFileSpecs(files.children ?? const <Child>[]);
    final signature = _signatureFor(specs);
    final targetDirectory = await _resolveTargetDirectory(
      destinationRoot,
      code,
      title,
    );

    final completeManifest = await _readManifest(
      File(
        '${targetDirectory.path}${Platform.pathSeparator}'
        '$_completeMarkerName',
      ),
    );
    if (completeManifest?.code == BulkSavePathUtils.normalizeCode(code) &&
        completeManifest?.signature == signature &&
        await _allFilesValid(targetDirectory, specs)) {
      return _WorkSaveOutcome(skipped: true, directory: targetDirectory);
    }

    final stageDirectory = Directory(
      '${destinationRoot.path}${Platform.pathSeparator}'
      '.${_baseName(targetDirectory.path)}.yuro-partial',
    );
    final partialMarker = File(
      '${stageDirectory.path}${Platform.pathSeparator}$_partialMarkerName',
    );
    final previousPlan = await _readManifest(partialMarker);
    if (await stageDirectory.exists() &&
        (previousPlan?.code != BulkSavePathUtils.normalizeCode(code) ||
            previousPlan?.signature != signature)) {
      await stageDirectory.delete(recursive: true);
    }
    await stageDirectory.create(recursive: true);
    await _writeManifest(
      partialMarker,
      _BulkManifest.fromSpecs(code: code, title: title, specs: specs),
    );

    final candidatePaths = <String>{
      targetDirectory.path,
      stageDirectory.path,
      ...candidateDirectories.map((directory) => directory.path),
    };
    final candidates = <_CandidateDirectory>[];
    for (final path in candidatePaths) {
      final directory = Directory(path);
      if (!await directory.exists()) continue;
      candidates.add(await _CandidateDirectory.load(directory));
    }

    var reusedFiles = 0;
    var downloadedFiles = 0;
    for (final spec in specs) {
      _throwIfCancelled();
      _currentFileName = spec.displayName;
      _currentFileProgress = null;
      notifyListeners();

      final stagedFile = File(_filePath(stageDirectory, spec));
      if (await _fileIsValid(stagedFile, spec)) {
        reusedFiles++;
        continue;
      }
      if (await stagedFile.exists()) await stagedFile.delete();
      await stagedFile.parent.create(recursive: true);

      _CandidateDirectory? reusableCandidate;
      for (final candidate in candidates) {
        if (candidate.directory.path == stageDirectory.path) continue;
        if (await candidate.canReuse(spec)) {
          reusableCandidate = candidate;
          break;
        }
      }

      if (reusableCandidate != null) {
        final source = File(_filePath(reusableCandidate.directory, spec));
        final copyingFile = File('${stagedFile.path}.yuro-copying');
        if (await copyingFile.exists()) await copyingFile.delete();
        await source.copy(copyingFile.path);
        if (!await _fileIsValid(copyingFile, spec)) {
          await copyingFile.delete();
          throw FileSystemException('コピーしたファイルを検証できません', source.path);
        }
        await copyingFile.rename(stagedFile.path);
        reusedFiles++;
        continue;
      }

      final downloadingFile = File('${stagedFile.path}.yuro-downloading');
      if (await downloadingFile.exists()) await downloadingFile.delete();
      await _apiService.downloadFile(
        spec.url,
        downloadingFile.path,
        cancelToken: _cancelToken,
        onReceiveProgress: (received, total) {
          final denominator = total > 0 ? total : spec.size;
          _currentFileProgress = denominator > 0
              ? (received / denominator).clamp(0, 1)
              : null;
          _notifyProgressThrottled();
        },
      );
      _throwIfCancelled();
      if (!await _fileIsValid(downloadingFile, spec)) {
        if (await downloadingFile.exists()) await downloadingFile.delete();
        throw FileSystemException('ダウンロードしたファイルのサイズが一致しません', spec.relativePath);
      }
      await downloadingFile.rename(stagedFile.path);
      downloadedFiles++;
    }

    if (!await _allFilesValid(stageDirectory, specs)) {
      throw FileSystemException('作品内のファイル検証に失敗しました', code);
    }
    await _pruneUnexpectedFiles(stageDirectory, specs);
    if (await partialMarker.exists()) await partialMarker.delete();
    await _finalizeWorkDirectory(
      stageDirectory: stageDirectory,
      targetDirectory: targetDirectory,
      manifest: _BulkManifest.fromSpecs(code: code, title: title, specs: specs),
    );

    return _WorkSaveOutcome(
      skipped: false,
      directory: targetDirectory,
      reusedFiles: reusedFiles,
      downloadedFiles: downloadedFiles,
    );
  }

  Future<Map<String, List<Directory>>> _buildCandidateIndex(
    Directory bulkRoot,
    Directory? legacyRoot,
    Set<String> codes,
  ) async {
    final normalizedCodes = <String, String>{
      for (final code in codes) BulkSavePathUtils.normalizeCode(code): code,
    };
    final result = <String, List<Directory>>{};

    Future<void> addCandidate(Directory directory) async {
      String? normalizedCode;
      final manifest = await _readManifest(
        File('${directory.path}${Platform.pathSeparator}$_completeMarkerName'),
      );
      if (manifest != null && normalizedCodes.containsKey(manifest.code)) {
        normalizedCode = manifest.code;
      } else {
        final name = _baseName(directory.path);
        for (final entry in normalizedCodes.entries) {
          if (BulkSavePathUtils.directoryNameMatchesCode(name, entry.value)) {
            normalizedCode = entry.key;
            break;
          }
        }
      }
      if (normalizedCode != null) {
        result.putIfAbsent(normalizedCode, () => <Directory>[]).add(directory);
      }
    }

    final likesRoot = Directory(
      '${bulkRoot.path}${Platform.pathSeparator}likes',
    );
    for (final directory in await _childDirectories(likesRoot)) {
      await addCandidate(directory);
    }

    final playlistsRoot = Directory(
      '${bulkRoot.path}${Platform.pathSeparator}playlists',
    );
    for (final playlistDirectory in await _childDirectories(playlistsRoot)) {
      for (final directory in await _childDirectories(playlistDirectory)) {
        await addCandidate(directory);
      }
    }

    if (legacyRoot != null) {
      for (final directory in await _childDirectories(legacyRoot)) {
        await addCandidate(directory);
      }
    }
    return result;
  }

  Future<Directory> _resolveTargetDirectory(
    Directory destinationRoot,
    String code,
    String title,
  ) async {
    for (final directory in await _childDirectories(destinationRoot)) {
      final name = _baseName(directory.path);
      if (!name.endsWith('.yuro-partial') &&
          !name.endsWith('.yuro-backup') &&
          BulkSavePathUtils.directoryNameMatchesCode(name, code)) {
        return directory;
      }
    }

    final folderName = BulkSavePathUtils.workFolderName(
      code: code,
      title: title,
    );
    return Directory(
      '${destinationRoot.path}${Platform.pathSeparator}$folderName',
    );
  }

  List<_BulkFileSpec> _collectFileSpecs(List<Child> nodes) {
    final specs = <_BulkFileSpec>[];

    void walk(List<Child> children, List<String> parents) {
      final usedNames = <String>{};
      for (final child in children) {
        final isFolder = child.type?.toLowerCase() == 'folder';
        final fallback = isFolder ? 'folder' : 'file';
        var name = BulkSavePathUtils.sanitizePathSegment(
          child.title,
          fallback: fallback,
        );
        name = _uniqueName(name, usedNames);

        if (isFolder) {
          walk(child.children ?? const <Child>[], <String>[...parents, name]);
          continue;
        }

        final url = child.mediaDownloadUrl?.trim();
        if (url == null || url.isEmpty) continue;
        specs.add(
          _BulkFileSpec(
            relativeSegments: <String>[...parents, name],
            url: url,
            size: (child.size ?? 0) > 0 ? child.size! : 0,
            remoteHash: child.hash,
          ),
        );
      }
    }

    walk(nodes, const <String>[]);
    return specs;
  }

  String _uniqueName(String name, Set<String> usedNames) {
    if (usedNames.add(name.toLowerCase())) return name;
    final dotIndex = name.lastIndexOf('.');
    final baseName = dotIndex > 0 ? name.substring(0, dotIndex) : name;
    final extension = dotIndex > 0 ? name.substring(dotIndex) : '';
    var index = 2;
    while (true) {
      final candidate = '$baseName ($index)$extension';
      if (usedNames.add(candidate.toLowerCase())) return candidate;
      index++;
    }
  }

  String _uniqueDirectoryName(String name, Set<String> usedNames) {
    if (usedNames.add(name.toLowerCase())) return name;
    var index = 2;
    while (true) {
      final candidate = '$name ($index)';
      if (usedNames.add(candidate.toLowerCase())) return candidate;
      index++;
    }
  }

  String _signatureFor(List<_BulkFileSpec> specs) {
    final descriptors = specs.map((spec) => spec.descriptor).toList()..sort();
    return sha256.convert(utf8.encode(jsonEncode(descriptors))).toString();
  }

  Future<bool> _allFilesValid(
    Directory directory,
    List<_BulkFileSpec> specs,
  ) async {
    for (final spec in specs) {
      if (!await _fileIsValid(File(_filePath(directory, spec)), spec)) {
        return false;
      }
    }
    return true;
  }

  Future<bool> _fileIsValid(File file, _BulkFileSpec spec) async {
    if (!await file.exists()) return false;
    if (spec.size <= 0) return true;
    return await file.length() == spec.size;
  }

  Future<void> _pruneUnexpectedFiles(
    Directory directory,
    List<_BulkFileSpec> specs,
  ) async {
    final expectedPaths = specs
        .map((spec) => File(_filePath(directory, spec)).absolute.path)
        .toSet();
    await for (final entity in directory.list(recursive: true)) {
      if (entity is File &&
          entity.absolute.path !=
              '${directory.absolute.path}${Platform.pathSeparator}'
                  '$_partialMarkerName' &&
          !expectedPaths.contains(entity.absolute.path)) {
        await entity.delete();
      }
    }

    final directories = <Directory>[];
    await for (final entity in directory.list(recursive: true)) {
      if (entity is Directory) directories.add(entity);
    }
    directories.sort((a, b) => b.path.length.compareTo(a.path.length));
    for (final child in directories) {
      if (await child.list().isEmpty) await child.delete();
    }
  }

  Future<void> _finalizeWorkDirectory({
    required Directory stageDirectory,
    required Directory targetDirectory,
    required _BulkManifest manifest,
  }) async {
    final backupDirectory = Directory(
      '${targetDirectory.parent.path}${Platform.pathSeparator}'
      '.${_baseName(targetDirectory.path)}.yuro-backup',
    );
    if (await backupDirectory.exists()) {
      await backupDirectory.delete(recursive: true);
    }

    var movedExistingTarget = false;
    try {
      if (await targetDirectory.exists()) {
        await targetDirectory.rename(backupDirectory.path);
        movedExistingTarget = true;
      }
      await stageDirectory.rename(targetDirectory.path);
      await _writeManifest(
        File(
          '${targetDirectory.path}${Platform.pathSeparator}'
          '$_completeMarkerName',
        ),
        manifest,
      );
      if (await backupDirectory.exists()) {
        await backupDirectory.delete(recursive: true);
      }
    } catch (_) {
      if (!await targetDirectory.exists() &&
          movedExistingTarget &&
          await backupDirectory.exists()) {
        await backupDirectory.rename(targetDirectory.path);
      }
      rethrow;
    }
  }

  Future<_BulkManifest?> _readManifest(File file) async {
    try {
      if (!await file.exists()) return null;
      final decoded = jsonDecode(await file.readAsString());
      if (decoded is! Map<String, dynamic>) return null;
      return _BulkManifest.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }

  Future<void> _writeManifest(File file, _BulkManifest manifest) async {
    await file.parent.create(recursive: true);
    final temporary = File('${file.path}.tmp');
    await temporary.writeAsString(jsonEncode(manifest.toJson()), flush: true);
    if (await file.exists()) await file.delete();
    await temporary.rename(file.path);
  }

  Future<List<Directory>> _childDirectories(Directory parent) async {
    try {
      if (!await parent.exists()) return const <Directory>[];
      return await parent
          .list()
          .where((entity) => entity is Directory)
          .cast<Directory>()
          .toList();
    } catch (_) {
      return const <Directory>[];
    }
  }

  String _filePath(Directory directory, _BulkFileSpec spec) => <String>[
    directory.path,
    ...spec.relativeSegments,
  ].join(Platform.pathSeparator);

  String _baseName(String path) =>
      path.split(RegExp(r'[/\\]')).where((part) => part.isNotEmpty).last;

  void _throwIfCancelled() {
    if (_cancelToken?.isCancelled ?? false) {
      throw DioException.requestCancelled(
        requestOptions: RequestOptions(path: 'bulk-save'),
        reason: 'Bulk save cancelled',
        stackTrace: StackTrace.current,
      );
    }
  }

  bool _isCancellation(Object error) =>
      error is DioException && error.type == DioExceptionType.cancel;

  void _notifyProgressThrottled() {
    final now = DateTime.now();
    if (now.difference(_lastProgressNotification) <
        const Duration(milliseconds: 120)) {
      return;
    }
    _lastProgressNotification = now;
    notifyListeners();
  }
}

class _WorkSaveOutcome {
  final bool skipped;
  final Directory directory;
  final int reusedFiles;
  final int downloadedFiles;

  const _WorkSaveOutcome({
    required this.skipped,
    required this.directory,
    this.reusedFiles = 0,
    this.downloadedFiles = 0,
  });
}

class _CollectionSavePlan {
  final String collectionDirectory;
  final List<Work> works;

  const _CollectionSavePlan({
    required this.collectionDirectory,
    required this.works,
  });
}

class _CollectionWorkSaveTask {
  final _CollectionSavePlan collection;
  final Work work;

  const _CollectionWorkSaveTask({required this.collection, required this.work});
}

class _BulkFileSpec {
  final List<String> relativeSegments;
  final String url;
  final int size;
  final String? remoteHash;

  const _BulkFileSpec({
    required this.relativeSegments,
    required this.url,
    required this.size,
    required this.remoteHash,
  });

  String get relativePath => relativeSegments.join('/');
  String get displayName => relativeSegments.last;
  String get descriptor => jsonEncode(<String, Object?>{
    'path': relativePath,
    'size': size,
    'hash': remoteHash,
  });
}

class _BulkManifest {
  final String code;
  final String title;
  final String signature;
  final Map<String, String> fileDescriptors;

  const _BulkManifest({
    required this.code,
    required this.title,
    required this.signature,
    required this.fileDescriptors,
  });

  factory _BulkManifest.fromSpecs({
    required String code,
    required String title,
    required List<_BulkFileSpec> specs,
  }) {
    final descriptors = specs.map((spec) => spec.descriptor).toList()..sort();
    return _BulkManifest(
      code: BulkSavePathUtils.normalizeCode(code),
      title: title,
      signature: sha256
          .convert(utf8.encode(jsonEncode(descriptors)))
          .toString(),
      fileDescriptors: <String, String>{
        for (final spec in specs) spec.relativePath: spec.descriptor,
      },
    );
  }

  factory _BulkManifest.fromJson(Map<String, dynamic> json) {
    final files = json['files'];
    return _BulkManifest(
      code: BulkSavePathUtils.normalizeCode(json['code']?.toString() ?? ''),
      title: json['title']?.toString() ?? '',
      signature: json['signature']?.toString() ?? '',
      fileDescriptors: files is Map
          ? files.map(
              (key, value) => MapEntry(key.toString(), value.toString()),
            )
          : const <String, String>{},
    );
  }

  Map<String, Object?> toJson() => <String, Object?>{
    'version': 1,
    'code': code,
    'title': title,
    'signature': signature,
    'completedAt': DateTime.now().toUtc().toIso8601String(),
    'files': fileDescriptors,
  };
}

class _CandidateDirectory {
  final Directory directory;
  final _BulkManifest? manifest;

  const _CandidateDirectory({required this.directory, this.manifest});

  static Future<_CandidateDirectory> load(Directory directory) async {
    _BulkManifest? manifest;
    for (final markerName in const <String>[
      BulkSaveController._completeMarkerName,
      BulkSaveController._partialMarkerName,
    ]) {
      final marker = File(
        '${directory.path}${Platform.pathSeparator}$markerName',
      );
      try {
        if (!await marker.exists()) continue;
        final decoded = jsonDecode(await marker.readAsString());
        if (decoded is Map<String, dynamic>) {
          manifest = _BulkManifest.fromJson(decoded);
          break;
        }
      } catch (_) {
        // A broken marker never makes a directory complete or reusable.
      }
    }
    return _CandidateDirectory(directory: directory, manifest: manifest);
  }

  Future<bool> canReuse(_BulkFileSpec spec) async {
    final descriptor = manifest?.fileDescriptors[spec.relativePath];
    if (manifest != null && descriptor != spec.descriptor) return false;
    final file = File(
      <String>[
        directory.path,
        ...spec.relativeSegments,
      ].join(Platform.pathSeparator),
    );
    if (!await file.exists()) return false;
    return spec.size <= 0 || await file.length() == spec.size;
  }
}
