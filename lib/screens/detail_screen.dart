import 'package:asmrapp/common/utils/work_localizations.dart';
import 'package:asmrapp/common/utils/file_preview_utils.dart';
import 'package:asmrapp/core/download/download_request_item.dart';
import 'package:asmrapp/data/models/files/child.dart';
import 'package:asmrapp/data/models/works/work.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/presentation/viewmodels/detail_viewmodel.dart';
import 'package:asmrapp/screens/similar_works_screen.dart';
import 'package:asmrapp/widgets/detail/file_preview_dialog.dart';
import 'package:asmrapp/widgets/detail/download_file_selection_dialog.dart';
import 'package:asmrapp/widgets/detail/related_works_section.dart';
import 'package:asmrapp/widgets/detail/work_action_buttons.dart';
import 'package:asmrapp/widgets/detail/work_cover.dart';
import 'package:asmrapp/widgets/detail/work_files_list.dart';
import 'package:asmrapp/widgets/detail/work_files_skeleton.dart';
import 'package:asmrapp/widgets/detail/work_info.dart';
import 'package:asmrapp/widgets/mini_player/mini_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final Work work;
  final bool fromPlayer;
  static final RegExp _rjCodePattern = RegExp(r'(RJ\d+)', caseSensitive: false);

  const DetailScreen({
    super.key,
    required this.work,
    this.fromPlayer = false,
  });

  @override
  Widget build(BuildContext context) {
    final rjCode = _extractRjCode();
    final localizedTitle = work.localizedTitle(Localizations.localeOf(context));
    final appBarTitle = _buildAppBarTitle(rjCode, localizedTitle);

    return ChangeNotifierProvider(
      create: (_) => DetailViewModel(
        work: work,
      )..loadFiles(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          actions: [
            if (rjCode != null)
              IconButton(
                tooltip: context.l10n.openDlsiteInBrowser,
                icon: const Icon(Icons.open_in_new),
                onPressed: () => _openDlsiteInBrowser(context, rjCode),
              ),
          ],
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
                  onFavoriteTap: () => viewModel.showPlaylistsDialog(context),
                  loadingFavorite: viewModel.loadingFavorite,
                  onMarkTap: () => viewModel.showMarkDialog(context),
                  currentMarkStatus: viewModel.currentMarkStatus,
                  loadingMark: viewModel.loadingMark,
                  onRateTap: () => viewModel.showRatingDialog(context),
                  loadingRate: viewModel.loadingRating,
                  onDownloadTap: viewModel.files == null
                      ? null
                      : () => _showDownloadDialog(context, viewModel),
                  loadingDownload: viewModel.downloadingFiles,
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
              Consumer<DetailViewModel>(
                builder: (context, viewModel, _) => RelatedWorksSection(
                  works: viewModel.recommendedWorks,
                  isLoading: viewModel.loadingRecommendations,
                  error: viewModel.recommendationsError,
                  hasRecommendations: viewModel.hasRecommendations,
                  onSeeAll: () => _openSimilarWorksScreen(context),
                  onRetry: viewModel.loadRecommendationsPreview,
                  onWorkTap: (relatedWork) =>
                      _openWorkDetail(context, relatedWork),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const MiniPlayer(),
      ),
    );
  }

  String _buildAppBarTitle(String? rjCode, String title) {
    final normalizedTitle = title.trim();
    if (rjCode == null || rjCode.isEmpty) {
      return normalizedTitle;
    }
    if (normalizedTitle.isEmpty) {
      return rjCode;
    }
    if (normalizedTitle.toUpperCase() == rjCode.toUpperCase()) {
      return rjCode;
    }
    return '$rjCode - $normalizedTitle';
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
      final imageFiles = _resolveImageFilesForPreview(viewModel, file);
      final initialImageIndex = imageFiles == null
          ? null
          : _findImageIndexForPreview(imageFiles, file);

      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => FilePreviewDialog(
          file: file,
          loadTextPreview: viewModel.loadTextPreview,
          imageFiles: imageFiles,
          initialImageIndex: initialImageIndex,
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

  Future<void> _showDownloadDialog(
    BuildContext context,
    DetailViewModel viewModel,
  ) async {
    final files = viewModel.files?.children;
    if (files == null || files.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.playFilesNotLoaded)),
      );
      return;
    }

    final selectedFiles = await showDialog<List<DownloadRequestItem>>(
      context: context,
      builder: (dialogContext) => DownloadFileSelectionDialog(
        rootFiles: files,
      ),
    );

    if (selectedFiles == null) return;
    if (selectedFiles.isEmpty) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.downloadNoFilesSelected)),
      );
      return;
    }

    late final DownloadBatchResult result;
    try {
      result = await viewModel.downloadFiles(selectedFiles);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.operationFailed(e.toString()))),
      );
      return;
    }

    if (!context.mounted) return;

    if (result.successCount > 0 && result.failedCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.l10n.downloadSuccess(
              result.successCount,
              result.saveDirectoryPath,
            ),
          ),
        ),
      );
      return;
    }

    if (result.successCount > 0 && result.failedCount > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.l10n.downloadPartial(
              result.successCount,
              result.failedCount,
            ),
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.l10n.downloadAllFailed(result.failedCount)),
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

  List<Child>? _resolveImageFilesForPreview(
    DetailViewModel viewModel,
    Child file,
  ) {
    if (!FilePreviewUtils.isImage(file)) {
      return null;
    }

    final rootChildren = viewModel.files?.children;
    if (rootChildren == null || rootChildren.isEmpty) {
      return [file];
    }

    final imageFiles = _collectImageFilesFromTree(rootChildren);
    if (imageFiles.isEmpty) {
      return [file];
    }

    return imageFiles;
  }

  List<Child> _collectImageFilesFromTree(List<Child> nodes) {
    final imageFiles = <Child>[];

    for (final node in nodes) {
      if (node.type == 'folder') {
        final children = node.children;
        if (children != null && children.isNotEmpty) {
          imageFiles.addAll(_collectImageFilesFromTree(children));
        }
        continue;
      }

      if (FilePreviewUtils.isImage(node)) {
        imageFiles.add(node);
      }
    }

    return imageFiles;
  }

  int _findImageIndexForPreview(List<Child> imageFiles, Child targetFile) {
    final identityIndex =
        imageFiles.indexWhere((imageFile) => identical(imageFile, targetFile));
    if (identityIndex >= 0) {
      return identityIndex;
    }

    return imageFiles.indexOf(targetFile);
  }

  void _openWorkDetail(BuildContext context, Work targetWork) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(work: targetWork),
      ),
    );
  }

  void _openSimilarWorksScreen(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            SimilarWorksScreen(work: work),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  String? _extractRjCode() {
    final candidates = <String?>[
      work.sourceId,
      work.originalWorkno,
      work.translationInfo?.originalWorkno,
    ];

    for (final candidate in candidates) {
      if (candidate == null || candidate.trim().isEmpty) continue;
      final match = _rjCodePattern.firstMatch(candidate);
      final rjCode = match?.group(1);
      if (rjCode != null && rjCode.isNotEmpty) {
        return rjCode.toUpperCase();
      }
    }

    return null;
  }

  Future<void> _openDlsiteInBrowser(BuildContext context, String rjCode) async {
    final url = 'https://www.dlsite.com/maniax/work/=/product_id/$rjCode.html';
    final opened = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.operationFailed(url))),
      );
    }
  }
}
