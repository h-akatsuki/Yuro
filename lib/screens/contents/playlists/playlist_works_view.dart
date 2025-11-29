import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:asmrapp/data/models/my_lists/my_playlists/playlist.dart';
import 'package:asmrapp/presentation/viewmodels/playlist_works_viewmodel.dart';
import 'package:asmrapp/widgets/work_grid/enhanced_work_grid_view.dart';
import 'package:asmrapp/presentation/layouts/work_layout_strategy.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/common/utils/playlist_localizations.dart';

class PlaylistWorksView extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback onBack;
  final WorkLayoutStrategy _layoutStrategy = const WorkLayoutStrategy();

  const PlaylistWorksView({
    super.key,
    required this.playlist,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlaylistWorksViewModel(playlist)..loadWorks(),
      child: Consumer<PlaylistWorksViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              Material(
                elevation: 2,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: onBack,
                      ),
                      Expanded(
                        child: Text(
                          localizedPlaylistName(playlist.name, context.l10n),
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: EnhancedWorkGridView(
                  works: viewModel.works,
                  isLoading: viewModel.isLoading,
                  error: viewModel.error,
                  onRetry: () => viewModel.refresh(),
                  onRefresh: () => viewModel.refresh(),
                  currentPage: viewModel.currentPage,
                  totalPages: viewModel.totalPages,
                  onPageChanged: (page) => viewModel.loadWorks(page: page),
                  layoutStrategy: _layoutStrategy,
                  emptyMessage: context.l10n.emptyWorks,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
