// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directory_manage_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DirectoryManageStatsImpl _$$DirectoryManageStatsImplFromJson(
  Map<String, dynamic> json,
) => _$DirectoryManageStatsImpl(
  total: (json['total'] as num?)?.toInt() ?? 0,
  claimed: (json['claimed'] as num?)?.toInt() ?? 0,
  invited: (json['invited'] as num?)?.toInt() ?? 0,
  unclaimed: (json['unclaimed'] as num?)?.toInt() ?? 0,
  newThisWeek: (json['new_this_week'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$DirectoryManageStatsImplToJson(
  _$DirectoryManageStatsImpl instance,
) => <String, dynamic>{
  'total': instance.total,
  'claimed': instance.claimed,
  'invited': instance.invited,
  'unclaimed': instance.unclaimed,
  'new_this_week': instance.newThisWeek,
};
