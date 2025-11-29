import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:asmrapp/presentation/viewmodels/playlists_viewmodel.dart';
import 'package:asmrapp/data/models/my_lists/my_playlists/playlist.dart';
import 'package:asmrapp/widgets/pagination_controls.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/common/utils/playlist_localizations.dart';

class PlaylistsListView extends StatelessWidget {
  final Function(Playlist) onPlaylistSelected;

  const PlaylistsListView({
    super.key,
    required this.onPlaylistSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistsViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading && viewModel.playlists.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.error != null && viewModel.playlists.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(viewModel.error!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: viewModel.refresh,
                  child: Text(context.l10n.retry),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: viewModel.refresh,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.playlists.length,
                  itemBuilder: (context, index) {
                    final playlist = viewModel.playlists[index];
                    return ListTile(
                      leading: const Icon(Icons.playlist_play),
                      title: Text(
                        localizedPlaylistName(playlist.name, context.l10n),
                      ),
                      subtitle: Text(
                        context.l10n
                            .playlistWorksCount(playlist.worksCount ?? 0),
                      ),
                      onTap: () => onPlaylistSelected(playlist),
                    );
                  },
                ),
              ),
              if (viewModel.playlists.isNotEmpty)
                PaginationControls(
                  currentPage: viewModel.currentPage,
                  totalPages: viewModel.totalPages ?? 1,
                  isLoading: viewModel.isLoading,
                  onPageChanged: (page) => viewModel.loadPlaylists(page: page),
                ),
            ],
          ),
        );
      },
    );
  }
}
