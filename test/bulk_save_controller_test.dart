import 'dart:io';

import 'package:asmrapp/core/download/bulk_save_controller.dart';
import 'package:asmrapp/core/download/download_directory_controller.dart';
import 'package:asmrapp/data/models/files/child.dart';
import 'package:asmrapp/data/models/files/files.dart';
import 'package:asmrapp/data/models/my_lists/my_playlists/playlist.dart';
import 'package:asmrapp/data/models/works/pagination.dart';
import 'package:asmrapp/data/models/works/work.dart';
import 'package:asmrapp/data/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory temporaryRoot;
  late DownloadDirectoryController directoryController;

  setUp(() async {
    SharedPreferences.setMockInitialValues(const <String, Object>{});
    temporaryRoot = await Directory.systemTemp.createTemp('yuro-bulk-save-');
    final preferences = await SharedPreferences.getInstance();
    directoryController = DownloadDirectoryController(preferences);
    await directoryController.setBulkSaveDirectoryPath(temporaryRoot.path);
    await directoryController.setCustomDirectoryPath(
      '${temporaryRoot.path}${Platform.pathSeparator}legacy',
    );
  });

  tearDown(() async {
    if (await temporaryRoot.exists()) {
      await temporaryRoot.delete(recursive: true);
    }
  });

  test(
    'second save skips a complete work instead of downloading it again',
    () async {
      final api = _FakeApiService();
      final controller = BulkSaveController(
        apiService: api,
        directoryController: directoryController,
      );

      await controller.saveLikes(locale: const Locale('ja'));

      final target = Directory(
        '${temporaryRoot.path}${Platform.pathSeparator}likes'
        '${Platform.pathSeparator}RJ123-Test title',
      );
      expect(controller.state, BulkSaveRunState.completed);
      expect(controller.result?.savedWorks, 1);
      expect(api.downloadCount, 2);
      expect(
        await File(
          '${target.path}${Platform.pathSeparator}.yuro-complete.json',
        ).exists(),
        isTrue,
      );

      await controller.saveLikes(locale: const Locale('ja'));

      expect(controller.result?.skippedWorks, 1);
      expect(api.downloadCount, 2);
    },
  );

  test(
    'a playlist reuses files already completed in likes by work code',
    () async {
      final api = _FakeApiService();
      final controller = BulkSaveController(
        apiService: api,
        directoryController: directoryController,
      );
      await controller.saveLikes(locale: const Locale('ja'));

      await controller.savePlaylist(
        playlist: Playlist(id: 'playlist-1', name: 'My list'),
        playlistName: 'My list',
        locale: const Locale('ja'),
      );

      expect(controller.result?.savedWorks, 1);
      expect(controller.result?.reusedFiles, 2);
      expect(controller.result?.downloadedFiles, 0);
      expect(api.downloadCount, 2);
      expect(
        await File(
          '${temporaryRoot.path}${Platform.pathSeparator}playlists'
          '${Platform.pathSeparator}My list${Platform.pathSeparator}'
          'RJ123-Test title${Platform.pathSeparator}.yuro-complete.json',
        ).exists(),
        isTrue,
      );
    },
  );

  test('a failed work stays partial and resumes its completed files', () async {
    final failingApi = _FakeApiService(failDownloadNumber: 2);
    final firstController = BulkSaveController(
      apiService: failingApi,
      directoryController: directoryController,
    );
    await firstController.saveLikes(locale: const Locale('ja'));

    final completeMarker = File(
      '${temporaryRoot.path}${Platform.pathSeparator}likes'
      '${Platform.pathSeparator}RJ123-Test title'
      '${Platform.pathSeparator}.yuro-complete.json',
    );
    final partialDirectory = Directory(
      '${temporaryRoot.path}${Platform.pathSeparator}likes'
      '${Platform.pathSeparator}.RJ123-Test title.yuro-partial',
    );
    expect(firstController.result?.failedWorks, 1);
    expect(await completeMarker.exists(), isFalse);
    expect(await partialDirectory.exists(), isTrue);

    final resumedApi = _FakeApiService();
    final resumedController = BulkSaveController(
      apiService: resumedApi,
      directoryController: directoryController,
    );
    await resumedController.saveLikes(locale: const Locale('ja'));

    expect(resumedController.result?.savedWorks, 1);
    expect(resumedController.result?.reusedFiles, 1);
    expect(resumedController.result?.downloadedFiles, 1);
    expect(await completeMarker.exists(), isTrue);
  });
}

class _FakeApiService extends ApiService {
  final int? failDownloadNumber;
  int downloadCount = 0;

  _FakeApiService({this.failDownloadNumber});

  Work get _work => Work(id: 123, sourceId: 'RJ123', title: 'Test title');

  @override
  Future<WorksResponse> getFavorites({
    int page = 1,
    int? pageSize,
    CancelToken? cancelToken,
  }) async {
    return WorksResponse(
      works: <Work>[_work],
      pagination: Pagination(currentPage: 1, pageSize: 100, totalCount: 1),
    );
  }

  @override
  Future<WorksResponse> getPlaylistWorks({
    required String playlistId,
    int page = 1,
    int pageSize = 12,
    CancelToken? cancelToken,
  }) async {
    return WorksResponse(
      works: <Work>[_work],
      pagination: Pagination(currentPage: 1, pageSize: 100, totalCount: 1),
    );
  }

  @override
  Future<Files> getWorkFiles(String workId, {CancelToken? cancelToken}) async {
    return Files(
      children: <Child>[
        Child(
          type: 'audio',
          title: 'one.mp3',
          hash: 'hash-one',
          mediaDownloadUrl: 'https://example.com/one.mp3',
          size: 4,
        ),
        Child(
          type: 'audio',
          title: 'two.mp3',
          hash: 'hash-two',
          mediaDownloadUrl: 'https://example.com/two.mp3',
          size: 6,
        ),
      ],
    );
  }

  @override
  Future<void> downloadFile(
    String url,
    String savePath, {
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    downloadCount++;
    if (downloadCount == failDownloadNumber) {
      throw Exception('simulated download failure');
    }
    final size = url.endsWith('one.mp3') ? 4 : 6;
    await File(savePath).writeAsBytes(List<int>.filled(size, downloadCount));
    onReceiveProgress?.call(size, size);
  }
}
