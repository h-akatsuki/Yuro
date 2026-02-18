import 'package:asmrapp/core/download/download_directory_controller.dart';
import 'package:asmrapp/core/download/download_progress_manager.dart';
import 'package:asmrapp/core/locale/locale_controller.dart';
import 'package:asmrapp/core/theme/app_theme.dart';
import 'package:asmrapp/core/theme/theme_controller.dart';
import 'package:asmrapp/l10n/app_localizations.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/presentation/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart';
import 'package:provider/provider.dart';

import 'core/di/service_locator.dart';
import 'screens/main_screen.dart';
import 'screens/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  JustAudioMediaKit.ensureInitialized(
    android: false,
    iOS: false,
    macOS: false,
  );

  // 初始化服务定位器
  await setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<AuthViewModel>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<ThemeController>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<LocaleController>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<DownloadDirectoryController>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<DownloadProgressManager>(),
        ),
      ],
      child: Consumer2<ThemeController, LocaleController>(
        builder: (context, themeController, localeController, child) {
          return MaterialApp(
            onGenerateTitle: (context) => context.l10n.appName,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: localeController.locale,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeController.themeMode,
            home: const MainScreen(),
            routes: {
              // '/player': (context) => const PlayerScreen(),
              '/search': (context) {
                final keyword =
                    ModalRoute.of(context)?.settings.arguments as String?;
                return SearchScreen(initialKeyword: keyword);
              },
            },
          );
        },
      ),
    );
  }
}
