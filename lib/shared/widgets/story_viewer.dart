import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// A single story item for the fullscreen viewer.
class StoryItem {
  final String id;
  final String imageUrl;
  final int duration; // seconds

  const StoryItem({
    required this.id,
    required this.imageUrl,
    this.duration = 5,
  });
}

/// Fullscreen story carousel with progress bar, tap navigation,
/// and swipe-down to close.
///
/// Show via [StoryViewer.show].
class StoryViewer extends StatefulWidget {
  final List<StoryItem> stories;
  final int initialIndex;
  final VoidCallback? onClose;

  const StoryViewer({
    super.key,
    required this.stories,
    this.initialIndex = 0,
    this.onClose,
  });

  /// Push a fullscreen story viewer.
  static Future<void> show(
    BuildContext context, {
    required List<StoryItem> stories,
    int initialIndex = 0,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => StoryViewer(
          stories: stories,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late AnimationController _progressController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.stories.length - 1);
    _progressController = AnimationController(vsync: this);
    _startStory();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    super.dispose();
  }

  void _startStory() {
    _timer?.cancel();
    final story = widget.stories[_currentIndex];
    final duration = Duration(seconds: story.duration);

    _progressController
      ..duration = duration
      ..forward(from: 0);

    _timer = Timer(duration, _nextStory);
  }

  void _nextStory() {
    if (_currentIndex < widget.stories.length - 1) {
      setState(() => _currentIndex++);
      _startStory();
    } else {
      _close();
    }
  }

  void _previousStory() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
      _startStory();
    } else {
      // Restart current story
      _startStory();
    }
  }

  void _close() {
    widget.onClose?.call();
    Navigator.of(context).pop();
  }

  void _onTapDown(TapDownDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (details.globalPosition.dx < screenWidth / 3) {
      _previousStory();
    } else {
      _nextStory();
    }
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.stories[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: _onTapDown,
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity != null &&
              details.primaryVelocity! > 300) {
            _close();
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Story image
            CachedNetworkImage(
              imageUrl: story.imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
              errorWidget: (_, __, ___) => const Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  color: Colors.white54,
                  size: 48,
                ),
              ),
            ),

            // Gradient overlay at top for progress bar visibility
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 120,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Progress bar + close button
            Positioned(
              top: MediaQuery.of(context).padding.top + AppSpacing.sm,
              left: AppSpacing.sm,
              right: AppSpacing.sm,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Segmented progress bar
                  _ProgressBar(
                    count: widget.stories.length,
                    currentIndex: _currentIndex,
                    controller: _progressController,
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Close button
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: GestureDetector(
                      onTap: _close,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Segmented progress bar for stories.
class _ProgressBar extends StatelessWidget {
  final int count;
  final int currentIndex;
  final AnimationController controller;

  const _ProgressBar({
    required this.count,
    required this.currentIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(count, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              end: index < count - 1 ? 2 : 0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1),
              child: SizedBox(
                height: 2,
                child: _buildSegment(index),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSegment(int index) {
    if (index < currentIndex) {
      // Completed — fully white
      return const DecoratedBox(
        decoration: BoxDecoration(color: Colors.white),
        child: SizedBox.expand(),
      );
    }

    if (index == currentIndex) {
      // Current — animated
      return AnimatedBuilder(
        animation: controller,
        builder: (_, __) => LinearProgressIndicator(
          value: controller.value,
          backgroundColor: Colors.white30,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          minHeight: 2,
        ),
      );
    }

    // Upcoming — dimmed
    return const DecoratedBox(
      decoration: BoxDecoration(color: Colors.white30),
      child: SizedBox.expand(),
    );
  }
}
