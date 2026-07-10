import 'package:asmrapp/data/models/files/child.dart';
import 'package:asmrapp/l10n/app_localizations.dart';
import 'package:asmrapp/widgets/detail/download_file_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets(
    'compact selector keeps controls leading and fits narrow screens',
    (tester) async {
      tester.view.physicalSize = const Size(393, 852);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(_testApp());
      await tester.pumpAndSettle();

      expect(find.text('3件をダウンロード'), findsOneWidget);
      expect(find.text('音声 2'), findsOneWidget);
      expect(tester.takeException(), isNull);

      final checkboxX = tester.getCenter(find.byType(Checkbox).first).dx;
      final folderTitleX = tester.getCenter(find.text('Tracks')).dx;
      expect(checkboxX, lessThan(folderTitleX));
    },
  );

  testWidgets('file type filter and select all action update the selection', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_testApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('画像 1'));
    await tester.pumpAndSettle();
    expect(find.text('cover.jpg'), findsOneWidget);
    expect(find.text('track 1.mp3'), findsNothing);
    expect(find.text('1件をダウンロード'), findsOneWidget);

    await tester.tap(find.text('すべて 3'));
    await tester.pumpAndSettle();
    expect(find.text('3件をダウンロード'), findsOneWidget);
    await tester.tap(find.text('選択解除'));
    await tester.pumpAndSettle();

    final submit = tester.widget<FilledButton>(
      find.byKey(const ValueKey('download-selection-submit')),
    );
    expect(submit.onPressed, isNull);
    expect(find.text('0件をダウンロード'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('filtered folder selection only selects visible file types', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_testApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('画像 1'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('選択解除'));
    await tester.pumpAndSettle();
    expect(find.text('0件をダウンロード'), findsOneWidget);

    await tester.tap(find.text('Tracks'));
    await tester.pumpAndSettle();

    expect(find.text('1件をダウンロード'), findsOneWidget);
    expect(find.text('cover.jpg'), findsOneWidget);
    expect(find.text('track 1.mp3'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}

Widget _testApp() {
  return MaterialApp(
    locale: const Locale('ja'),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: DownloadFileSelectionDialog(
        isBottomSheet: true,
        rootFiles: [
          Child(
            type: 'folder',
            title: 'Tracks',
            children: [
              Child(
                type: 'audio',
                title: 'track 1.mp3',
                mediaDownloadUrl: 'https://example.com/1.mp3',
                size: 1024,
              ),
              Child(
                type: 'audio',
                title: 'track 2.mp3',
                mediaDownloadUrl: 'https://example.com/2.mp3',
                size: 2048,
              ),
              Child(
                type: 'image',
                title: 'cover.jpg',
                mediaDownloadUrl: 'https://example.com/cover.jpg',
                size: 4096,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
