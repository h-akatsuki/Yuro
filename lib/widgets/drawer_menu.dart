import 'package:asmrapp/core/platform/wakelock_controller.dart';
import 'package:asmrapp/core/theme/theme_controller.dart';
import 'package:asmrapp/presentation/viewmodels/auth_viewmodel.dart';
import 'package:asmrapp/presentation/widgets/auth/login_dialog.dart';
import 'package:asmrapp/screens/favorites_screen.dart';
import 'package:asmrapp/screens/settings/cache_manager_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:asmrapp/l10n/l10n.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const LoginDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: ListTileTheme(
        style: ListTileStyle.drawer,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                dividerTheme: const DividerThemeData(color: Colors.transparent),
              ),
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
                child: Text(
                  context.l10n.appName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Consumer<AuthViewModel>(
              builder: (context, authVM, _) {
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(
                    authVM.isLoggedIn
                        ? authVM.username ?? ''
                        : context.l10n.login,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    if (authVM.isLoggedIn) {
                      authVM.logout();
                    } else {
                      _showLoginDialog(context);
                    }
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: Text(context.l10n.favoritesTitle),
              onTap: () {
                Navigator.pop(context);
                // 检查用户是否已登录
                final authVM = context.read<AuthViewModel>();
                if (!authVM.isLoggedIn) {
                  // 如果未登录，显示登录对话框
                  _showLoginDialog(context);
                  return;
                }
                // 导航到收藏页面
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoritesScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(context.l10n.settings),
              onTap: () {
                Navigator.pop(context);
                // TODO: 导航到设置页面
              },
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: Text(context.l10n.cacheManager),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CacheManagerScreen(),
                  ),
                );
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              height: 1,
            ),
            Consumer<ThemeController>(
              builder: (context, themeController, _) {
                return ListTile(
                  leading: Icon(_getThemeIcon(themeController.themeMode)),
                  title: Text(
                    _getThemeText(context, themeController.themeMode),
                  ),
                  onTap: () => themeController.toggleThemeMode(),
                );
              },
            ),
            ListenableBuilder(
              listenable: GetIt.I<WakeLockController>(),
              builder: (context, _) {
                final controller = GetIt.I<WakeLockController>();
                return SwitchListTile(
                  title: Text(context.l10n.screenAlwaysOn),
                  value: controller.enabled,
                  onChanged: (_) => controller.toggle(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return Icons.brightness_auto;
      case ThemeMode.light:
        return Icons.brightness_high;
      case ThemeMode.dark:
        return Icons.brightness_2;
    }
  }

  String _getThemeText(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return context.l10n.themeSystem;
      case ThemeMode.light:
        return context.l10n.themeLight;
      case ThemeMode.dark:
        return context.l10n.themeDark;
    }
  }
}
