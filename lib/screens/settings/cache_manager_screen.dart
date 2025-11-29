import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:asmrapp/presentation/viewmodels/settings/cache_manager_viewmodel.dart';
import 'package:asmrapp/l10n/l10n.dart';

class CacheManagerScreen extends StatelessWidget {
  const CacheManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CacheManagerViewModel()..loadCacheSize(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.cacheManagerTitle),
        ),
        body: Consumer<CacheManagerViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.errorDetail != null) {
              final message = switch (viewModel.lastFailedOperation) {
                CacheOperation.load =>
                  context.l10n.cacheLoadFailed(viewModel.errorDetail!),
                _ => context.l10n.cacheClearFailed(viewModel.errorDetail!),
              };
              return Center(
                child: Text(
                  message,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              );
            }

            return ListView(
              children: [
                // 音频缓存
                ListTile(
                  title: Text(context.l10n.cacheAudio),
                  subtitle: Text(viewModel.audioCacheSizeFormatted),
                  trailing: TextButton(
                    onPressed: viewModel.isLoading
                        ? null
                        : () => viewModel.clearAudioCache(),
                    child: Text(context.l10n.cacheClear),
                  ),
                ),
                const Divider(),

                // 字幕缓存
                ListTile(
                  title: Text(context.l10n.cacheSubtitle),
                  subtitle: Text(viewModel.subtitleCacheSizeFormatted),
                  trailing: TextButton(
                    onPressed: viewModel.isLoading
                        ? null
                        : () => viewModel.clearSubtitleCache(),
                    child: Text(context.l10n.cacheClear),
                  ),
                ),
                const Divider(),

                // 总缓存大小
                ListTile(
                  title: Text(context.l10n.cacheTotal),
                  subtitle: Text(viewModel.totalCacheSizeFormatted),
                  trailing: TextButton(
                    onPressed: viewModel.isLoading
                        ? null
                        : () => viewModel.clearAllCache(),
                    child: Text(context.l10n.cacheClearAll),
                  ),
                ),
                const Divider(),

                // 缓存说明
                ListTile(
                  title: Text(context.l10n.cacheInfoTitle),
                  subtitle: Text(context.l10n.cacheDescription),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
