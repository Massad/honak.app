// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryStatsImpl _$$StoryStatsImplFromJson(Map<String, dynamic> json) =>
    _$StoryStatsImpl(
      views: (json['views'] as num?)?.toInt() ?? 0,
      uniqueReach: (json['unique_reach'] as num?)?.toInt() ?? 0,
      shares: (json['shares'] as num?)?.toInt() ?? 0,
      messages: (json['messages'] as num?)?.toInt() ?? 0,
      profileVisits: (json['profile_visits'] as num?)?.toInt() ?? 0,
      linkClicks: (json['link_clicks'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$StoryStatsImplToJson(_$StoryStatsImpl instance) =>
    <String, dynamic>{
      'views': instance.views,
      'unique_reach': instance.uniqueReach,
      'shares': instance.shares,
      'messages': instance.messages,
      'profile_visits': instance.profileVisits,
      'link_clicks': instance.linkClicks,
    };
