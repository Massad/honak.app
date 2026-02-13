import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/stories/domain/entities/story_content.dart';

final storiesRepositoryProvider = Provider<StoriesRepository>((ref) {
  return StoriesRepository();
});

class StoriesRepository {
  Future<List<StoryContent>> getViewerContent() async {
    final raw = await rootBundle.loadString('assets/api/stories/viewer_content.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final list = json['data'] as List;
    return list
        .map((e) => StoryContent.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
