import 'package:asmrapp/presentation/viewmodels/player_viewmodel.dart';
import 'package:asmrapp/screens/player_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:asmrapp/l10n/l10n.dart';

import 'mini_player_controls.dart';
import 'mini_player_cover.dart';
import 'mini_player_progress.dart';

class MiniPlayer extends StatelessWidget {
  static const height = 48.0;

  final bool respectSafeArea;

  const MiniPlayer({
    super.key,
    this.respectSafeArea = true,
  });

  static double heightWithSafeArea(
    BuildContext context, {
    bool respectSafeArea = true,
  }) {
    final bottomPadding =
        respectSafeArea ? MediaQuery.of(context).padding.bottom : 0.0;
    return height + bottomPadding;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = GetIt.I<PlayerViewModel>();
    final bottomPadding =
        respectSafeArea ? MediaQuery.of(context).padding.bottom : 0.0;

    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const PlayerScreen();
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  // 创建一个曲线动画
                  final curvedAnimation = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutQuart,
                  );

                  return Stack(
                    children: [
                      // 背景淡入效果
                      FadeTransition(
                        opacity: curvedAnimation,
                        child: Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                      // 内容从底部滑入并淡入
                      FadeTransition(
                        opacity: Tween<double>(
                          begin: 0.3,
                          end: 1.0,
                        ).animate(curvedAnimation),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(curvedAnimation),
                          child: child,
                        ),
                      ),
                    ],
                  );
                },
                transitionDuration: const Duration(milliseconds: 400),
              ),
            );
          },
          child: Container(
            height: height + bottomPadding,
            padding: EdgeInsets.only(bottom: bottomPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Column(
              children: [
                const MiniPlayerProgress(),
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
                        child: Hero(
                          tag: 'mini-player-cover',
                          child: MiniPlayerCover(
                            coverUrl: viewModel.currentTrackInfo?.coverUrl,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Hero(
                            tag: 'player-title',
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                viewModel.currentTrackInfo?.title ??
                                    context.l10n.noPlaying,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const MiniPlayerControls(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
