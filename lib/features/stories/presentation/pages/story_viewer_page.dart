import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/features/stories/domain/entities/story_content.dart';
import 'package:honak/features/stories/presentation/widgets/story_header.dart';
import 'package:honak/features/stories/presentation/widgets/story_progress_bar.dart';
import 'package:honak/features/stories/presentation/widgets/story_reply_input.dart';
import 'package:honak/features/stories/presentation/widgets/story_slide_view.dart';

/// Full-screen story viewer opened as a modal.
///
/// Gesture system:
/// - Tap left/right zones → previous/next slide
/// - Long press → pause/resume
/// - Horizontal swipe → change business
/// - Vertical swipe down → close
class StoryViewerPage extends ConsumerStatefulWidget {
  final List<StoryContent> businesses;
  final int initialIndex;

  /// Admin preview mode — hides reply input (used from StoryManager).
  final bool isAdminPreview;

  const StoryViewerPage({
    super.key,
    required this.businesses,
    this.initialIndex = 0,
    this.isAdminPreview = false,
  });

  @override
  ConsumerState<StoryViewerPage> createState() => _StoryViewerPageState();
}

class _StoryViewerPageState extends ConsumerState<StoryViewerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late PageController _pageController;
  int _businessIndex = 0;
  int _slideIndex = 0;
  bool _isPaused = false;
  bool _closing = false;

  @override
  void initState() {
    super.initState();
    _businessIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _businessIndex);
    _progressController = AnimationController(vsync: this)
      ..addStatusListener(_onProgressComplete);
    _startSlideTimer();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  StoryContent get _currentBusiness => widget.businesses[_businessIndex];

  int get _slideCount => _currentBusiness.stories.length;

  void _startSlideTimer() {
    if (_currentBusiness.stories.isEmpty) return;
    final slide = _currentBusiness.stories[_slideIndex];
    _progressController
      ..reset()
      ..duration = Duration(seconds: slide.duration)
      ..forward();
  }

  void _onProgressComplete(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    _nextSlide();
  }

  void _nextSlide() {
    if (_slideIndex < _slideCount - 1) {
      setState(() => _slideIndex++);
      _startSlideTimer();
    } else {
      _nextBusiness();
    }
  }

  void _previousSlide() {
    if (_slideIndex > 0) {
      setState(() => _slideIndex--);
      _startSlideTimer();
    } else {
      _previousBusiness();
    }
  }

  void _nextBusiness() {
    if (_businessIndex < widget.businesses.length - 1) {
      setState(() {
        _businessIndex++;
        _slideIndex = 0;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _startSlideTimer();
    } else {
      _close();
    }
  }

  void _previousBusiness() {
    if (_businessIndex > 0) {
      setState(() {
        _businessIndex--;
        _slideIndex = 0;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _startSlideTimer();
    }
  }

  void _pause() {
    if (!_isPaused) {
      setState(() => _isPaused = true);
      _progressController.stop();
    }
  }

  void _resume() {
    if (_isPaused) {
      setState(() => _isPaused = false);
      _progressController.forward();
    }
  }

  void _close() {
    if (_closing) return;
    _closing = true;
    _progressController.stop();
    Navigator.of(context).pop();
  }

  void _onTapDown(TapDownDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (details.globalPosition.dx < screenWidth * 0.3) {
      _previousSlide();
    } else {
      _nextSlide();
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _businessIndex = index;
      _slideIndex = 0;
    });
    _startSlideTimer();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTapDown: _onTapDown,
          onLongPressStart: (_) => _pause(),
          onLongPressEnd: (_) => _resume(),
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity != null &&
                details.primaryVelocity! > 300) {
              _close();
            }
          },
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.businesses.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final business = widget.businesses[index];
              if (business.stories.isEmpty) {
                return const SizedBox.shrink();
              }

              final slideIdx =
                  index == _businessIndex ? _slideIndex : 0;
              final safeSlideIdx = slideIdx.clamp(0, business.stories.length - 1);
              final slide = business.stories[safeSlideIdx];

              return Stack(
                children: [
                  // Full-screen story slide (behind everything)
                  Positioned.fill(
                    child: StorySlideView(slide: slide),
                  ),

                  // Overlaid UI: progress bars, header, spacer, reply
                  Positioned.fill(
                    child: SafeArea(
                      child: Column(
                        children: [
                          // Progress bars
                          if (index == _businessIndex)
                            AnimatedBuilder(
                              animation: _progressController,
                              builder: (context, _) => StoryProgressBar(
                                count: business.stories.length,
                                current: _slideIndex,
                                progress: _progressController.value,
                              ),
                            )
                          else
                            StoryProgressBar(
                              count: business.stories.length,
                              current: 0,
                              progress: 0,
                            ),

                          // Header
                          StoryHeader(
                            name: business.name,
                            avatarUrl: business.avatar,
                            createdAt: slide.createdAt,
                            onClose: _close,
                            onProfileTap: () {
                              _close();
                              context.push(Routes.pagePath(business.id));
                            },
                          ),

                          const Spacer(),

                          // Reply input (disabled in admin preview)
                          StoryReplyInput(
                            enabled: !widget.isAdminPreview,
                            onPause: _pause,
                            onResume: _resume,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
