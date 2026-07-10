import 'dart:async';

import 'package:asmrapp/presentation/viewmodels/player_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PlayerProgress extends StatefulWidget {
  const PlayerProgress({super.key});

  @override
  State<PlayerProgress> createState() => _PlayerProgressState();
}

class _PlayerProgressState extends State<PlayerProgress> {
  double? _dragPosition;

  String _formatDuration(Duration? duration) {
    if (duration == null) return '--:--';
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  double _ensureValueInRange(double value, double min, double max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = GetIt.I<PlayerViewModel>();

    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final durationMs = viewModel.duration?.inMilliseconds.toDouble();
        final canSeek = durationMs != null && durationMs > 0;
        final max = durationMs != null && durationMs > 0 ? durationMs : 1.0;
        final playerPosition =
            viewModel.position?.inMilliseconds.toDouble() ?? 0;
        final sliderPosition = _ensureValueInRange(
          _dragPosition ?? playerPosition,
          0,
          max,
        );
        final displayedPosition = _dragPosition == null
            ? viewModel.position
            : Duration(milliseconds: _dragPosition!.round());

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 6,
                  ),
                ),
                child: Slider(
                  value: sliderPosition,
                  min: 0,
                  max: max,
                  onChanged: canSeek
                      ? (value) => setState(() => _dragPosition = value)
                      : null,
                  onChangeEnd: canSeek
                      ? (value) {
                          setState(() => _dragPosition = null);
                          unawaited(
                            viewModel.seek(
                              Duration(milliseconds: value.round()),
                            ),
                          );
                        }
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(displayedPosition),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    Text(
                      _formatDuration(viewModel.duration),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
