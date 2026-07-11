import 'dart:io';

import 'package:asmrapp/core/download/bulk_save_controller.dart';
import 'package:asmrapp/core/download/bulk_save_request_executor.dart';
import 'package:asmrapp/core/download/download_directory_controller.dart';
import 'package:asmrapp/data/models/my_lists/my_playlists/playlist.dart';
import 'package:asmrapp/data/services/api_service.dart';
import 'package:asmrapp/l10n/app_localizations.dart';
import 'package:asmrapp/widgets/download/bulk_save_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory temporaryRoot;
  late DownloadDirectoryController directoryController;

  setUp(() async {
    SharedPreferences.setMockInitialValues(const <String, Object>{});
    temporaryRoot = await Directory.systemTemp.createTemp('yuro-bulk-dialog-');
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

  testWidgets('all playlists show four progress bars', (tester) async {
    final controller = _RunningBulkSaveController(
      directoryController: directoryController,
    );

    await tester.pumpWidget(
      _testApp(
        controller: controller,
        directoryController: directoryController,
        dialog: const BulkSaveDialog(allPlaylists: true),
      ),
    );

    expect(find.byType(LinearProgressIndicator), findsNWidgets(4));
    expect(find.textContaining('作品コードで'), findsNothing);
  });

  testWidgets('a single playlist shows three progress bars', (tester) async {
    final controller = _RunningBulkSaveController(
      directoryController: directoryController,
    );

    await tester.pumpWidget(
      _testApp(
        controller: controller,
        directoryController: directoryController,
        dialog: BulkSaveDialog(
          playlist: Playlist(id: 'playlist-1', name: 'My list'),
          playlistName: 'My list',
        ),
      ),
    );

    expect(find.byType(LinearProgressIndicator), findsNWidgets(3));
  });

  testWidgets('log button opens the live log with copy and save actions', (
    tester,
  ) async {
    final controller = _RunningBulkSaveController(
      directoryController: directoryController,
    );

    await tester.pumpWidget(
      _testApp(
        controller: controller,
        directoryController: directoryController,
        dialog: const BulkSaveDialog(),
      ),
    );

    expect(find.byKey(const ValueKey('bulk-save-log')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('bulk-save-log')));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('一括保存ログ'), findsOneWidget);
    expect(find.textContaining('テストログ'), findsOneWidget);
    expect(find.byKey(const ValueKey('bulk-save-log-copy')), findsOneWidget);
    expect(find.byKey(const ValueKey('bulk-save-log-save')), findsOneWidget);
  });
}

Widget _testApp({
  required BulkSaveController controller,
  required DownloadDirectoryController directoryController,
  required Widget dialog,
}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: controller),
      ChangeNotifierProvider.value(value: directoryController),
    ],
    child: MaterialApp(
      locale: const Locale('ja'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: dialog),
    ),
  );
}

class _RunningBulkSaveController extends BulkSaveController {
  _RunningBulkSaveController({required super.directoryController})
    : super(
        apiService: ApiService(),
        requestExecutor: BulkSaveRequestExecutor(
          minimumInterval: Duration.zero,
        ),
      );

  @override
  BulkSaveRunState get state => BulkSaveRunState.running;

  @override
  bool get isRunning => true;

  @override
  int get totalPlaylists => 2;

  @override
  int get processedPlaylists => 1;

  @override
  double get playlistProgress => 0.5;

  @override
  int get totalWorks => 4;

  @override
  int get processedWorks => 2;

  @override
  double get workProgress => 0.5;

  @override
  int get totalFiles => 6;

  @override
  int get processedFiles => 3;

  @override
  double get fileProgress => 0.5;

  @override
  double get currentFileProgress => 0.5;

  @override
  List<String> get logLines => const <String>[
    '[2026-07-11T12:00:00.000] [INFO] テストログ',
  ];

  @override
  String get logText => logLines.join('\n');
}
