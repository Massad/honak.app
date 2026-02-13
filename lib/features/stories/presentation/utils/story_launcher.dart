import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/stories/presentation/pages/story_viewer_page.dart';
import 'package:honak/features/stories/presentation/providers/stories_provider.dart'
    show storyContentProvider;

/// Opens the full-screen story viewer.
///
/// Pass [pageId] to start at a specific business, or [index] to start at a
/// position in the stories list. If [pageId] is not found, falls back to 0.
void openStoryViewer(
  BuildContext context,
  WidgetRef ref, {
  String? pageId,
  int? index,
}) {
  final content = ref.read(storyContentProvider).valueOrNull;
  if (content == null || content.isEmpty) return;

  int startIndex = 0;
  if (pageId != null) {
    final found = content.indexWhere((c) => c.id == pageId);
    if (found >= 0) startIndex = found;
  } else if (index != null) {
    startIndex = index.clamp(0, content.length - 1);
  }

  Navigator.of(context, rootNavigator: true).push(
    PageRouteBuilder<void>(
      opaque: true,
      pageBuilder: (_, __, ___) => StoryViewerPage(
        businesses: content,
        initialIndex: startIndex,
      ),
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ),
  );
}

/// Checks whether a specific business has story content loaded.
bool hasStoryContent(WidgetRef ref, String pageId) {
  final content = ref.read(storyContentProvider).valueOrNull;
  if (content == null) return false;
  return content.any((c) => c.id == pageId);
}
