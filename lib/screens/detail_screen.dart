import 'package:asmrapp/common/utils/file_preview_utils.dart';
import 'package:asmrapp/data/models/files/child.dart';
import 'package:asmrapp/data/models/works/work.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/presentation/viewmodels/detail_viewmodel.dart';
import 'package:asmrapp/screens/similar_works_screen.dart';
import 'package:asmrapp/widgets/detail/file_preview_dialog.dart';
import 'package:asmrapp/widgets/detail/work_action_buttons.dart';
import 'package:asmrapp/widgets/detail/work_cover.dart';
import 'package:asmrapp/widgets/detail/work_files_list.dart';
import 'package:asmrapp/widgets/detail/work_files_skeleton.dart';
import 'package:asmrapp/widgets/detail/work_info.dart';
import 'package:asmrapp/widgets/mini_player/mini_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final Work work;
  final bool fromPlayer;

  const DetailScreen({
    super.key,
    required this.work,
    this.fromPlayer = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailViewModel(
        work: work,
      )..loadFiles(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(work.sourceId ?? ''),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WorkCover(
                imageUrl: work.mainCoverUrl ?? '',
                workId: work.id ?? 0,
                sourceId: work.sourceId ?? '',
                releaseDate: work.release,
                heroTag: 'work-cover-${work.id}',
              ),
              WorkInfo(work: work),
              Consumer<DetailViewModel>(
                builder: (context, viewModel, _) => WorkActionButtons(
                  hasRecommendations: viewModel.hasRecommendations,
                  checkingRecommendations: viewModel.checkingRecommendations,
                  onRecommendationsTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            SimilarWorksScreen(work: work),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end).chain(
                            CurveTween(curve: curve),
                          );
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  onFavoriteTap: () => viewModel.showPlaylistsDialog(context),
                  loadingFavorite: viewModel.loadingFavorite,
                  onMarkTap: () => viewModel.showMarkDialog(context),
                  currentMarkStatus: viewModel.currentMarkStatus,
                  loadingMark: viewModel.loadingMark,
                ),
              ),
              Consumer<DetailViewModel>(
                builder: (context, viewModel, _) {
                  if (viewModel.isLoading) {
                    return const WorkFilesSkeleton();
                  }

                  if (viewModel.error != null) {
                    return Center(
                      child: Text(
                        viewModel.error!,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    );
                  }

                  if (viewModel.files != null) {
                    return WorkFilesList(
                      files: viewModel.files!,
                      onFileTap: (file) =>
                          _handleFileTap(context, viewModel, file),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: const MiniPlayer(),
      ),
    );
  }

  Future<void> _handleFileTap(
    BuildContext context,
    DetailViewModel viewModel,
    Child file,
  ) async {
    if (FilePreviewUtils.isAudio(file)) {
      try {
        await viewModel.playFile(file, context);
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                _playbackErrorMessage(context, e),
              ),
            ),
          );
        }
      }
      return;
    }

    if (viewModel.canPreviewFile(file)) {
      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => FilePreviewDialog(
          file: file,
          loadTextPreview: viewModel.loadTextPreview,
        ),
      );
      return;
    }

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          context.l10n.playUnsupportedFileType(file.type ?? file.title ?? ''),
        ),
      ),
    );
  }

  String _playbackErrorMessage(BuildContext context, Object error) {
    if (error is PlaybackException) {
      switch (error.error) {
        case PlaybackError.unsupportedType:
          return context.l10n.playUnsupportedFileType(error.detail ?? '');
        case PlaybackError.missingUrl:
          return context.l10n.playUrlMissing;
        case PlaybackError.filesNotLoaded:
          return context.l10n.playFilesNotLoaded;
        case PlaybackError.failed:
          return context.l10n.playFailed(error.detail ?? '');
      }
    }
    return context.l10n.playFailed(error.toString());
  }
}
