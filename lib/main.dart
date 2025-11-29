import 'package:flutter/material.dart';
import 'package:asmrapp/presentation/viewmodels/auth_viewmodel.dart';
import 'core/di/service_locator.dart';
import 'package:provider/provider.dart';
import 'screens/main_screen.dart';
import 'package:asmrapp/core/theme/app_theme.dart';
import 'package:asmrapp/core/theme/theme_controller.dart';
import 'screens/search_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:asmrapp/l10n/app_localizations.dart';
import 'package:asmrapp/l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      ],
      child: Consumer<ThemeController>(
        builder: (context, themeController, child) {
          return MaterialApp(
            onGenerateTitle: (context) => context.l10n.appName,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
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
