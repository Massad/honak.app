import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/stories/domain/entities/my_story.dart';

final storyManagementRepositoryProvider =
    Provider<StoryManagementRepository>((ref) {
  return StoryManagementRepository();
});

class StoryManagementRepository {
  Future<List<MyStory>> getMyStories() async {
    final raw =
        await rootBundle.loadString('assets/api/stories/my_stories.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final list = json['data'] as List;
    return list
        .map((e) => MyStory.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Map<String, dynamic>> getAggregateStats() async {
    final raw =
        await rootBundle.loadString('assets/api/stories/aggregate_stats.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return json['data'] as Map<String, dynamic>;
  }
}
