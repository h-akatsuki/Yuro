import 'package:asmrapp/core/download/download_directory_controller.dart';
import 'package:asmrapp/core/locale/locale_controller.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/screens/settings/cache_manager_screen.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _updatingDirectory = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: Consumer<DownloadDirectoryController>(
        builder: (context, downloadController, _) {
          final path = downloadController.customDirectoryPath;
          final localeController = context.watch<LocaleController>();
          final selectedLanguageCode =
              localeController.locale?.languageCode ?? 'system';
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.downloadDirectoryTitle,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.downloadDirectoryDescription,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                              .withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          path?.isNotEmpty == true
                              ? path!
                              : l10n.downloadDirectoryDefaultValue,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.downloadDirectoryPermissionHint,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          FilledButton.icon(
                            onPressed: _updatingDirectory
                                ? null
                                : () => _pickDownloadDirectory(
                                      context,
                                      downloadController,
                                    ),
                            icon: const Icon(Icons.folder_open),
                            label: Text(l10n.downloadDirectoryPick),
                          ),
                          OutlinedButton.icon(
                            onPressed: _updatingDirectory ||
                                    !downloadController.hasCustomDirectory
                                ? null
                                : () => _resetDownloadDirectory(
                                      context,
                                      downloadController,
                                    ),
                            icon: const Icon(Icons.undo),
                            label: Text(l10n.downloadDirectoryReset),
                          ),
                        ],
                      ),
                      if (downloadController.lastError != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          downloadController.lastError!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.languageTitle,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.languageDescription,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: selectedLanguageCode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'system',
                            child: Text(l10n.languageSystem),
                          ),
                          DropdownMenuItem(
                            value: 'en',
                            child: Text(l10n.languageEnglish),
                          ),
                          DropdownMenuItem(
                            value: 'ja',
                            child: Text(l10n.languageJapanese),
                          ),
                          DropdownMenuItem(
                            value: 'zh',
                            child: Text(l10n.languageChinese),
                          ),
                        ],
                        onChanged: (value) async {
                          if (value == null) {
                            return;
                          }
                          final nextLocale =
                              value == 'system' ? null : Locale(value);
                          await localeController.setLocale(nextLocale);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.storage),
                  title: Text(l10n.cacheManager),
                  subtitle: Text(l10n.cacheDescription),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CacheManagerScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _pickDownloadDirectory(
    BuildContext context,
    DownloadDirectoryController controller,
  ) async {
    final l10n = context.l10n;
    setState(() => _updatingDirectory = true);
    try {
      final selectedPath = await getDirectoryPath(
        confirmButtonText: l10n.confirm,
      );
      if (selectedPath == null || selectedPath.trim().isEmpty) {
        return;
      }

      await controller.setCustomDirectoryPath(selectedPath);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.downloadDirectoryUpdated(selectedPath))),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.operationFailed(e.toString()))),
      );
    } finally {
      if (mounted) {
        setState(() => _updatingDirectory = false);
      }
    }
  }

  Future<void> _resetDownloadDirectory(
    BuildContext context,
    DownloadDirectoryController controller,
  ) async {
    final l10n = context.l10n;
    setState(() => _updatingDirectory = true);
    try {
      await controller.clearCustomDirectoryPath();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.downloadDirectoryResetSuccess)),
      );
    } finally {
      if (mounted) {
        setState(() => _updatingDirectory = false);
      }
    }
  }
}
