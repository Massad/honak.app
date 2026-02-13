import 'package:flutter/material.dart';
import 'package:honak/features/stories/domain/entities/story_slide.dart';
import 'package:honak/features/stories/presentation/widgets/story_canvas.dart';

/// Displays a single story slide by delegating to [StoryCanvas].
class StorySlideView extends StatelessWidget {
  final StorySlide slide;

  const StorySlideView({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return StoryCanvas(
      slide: slide,
      textLayers: slide.textLayers,
      interactive: false,
    );
  }
}
