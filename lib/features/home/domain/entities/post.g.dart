// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
  id: json['id'] as String,
  page: PostPage.fromJson(json['page'] as Map<String, dynamic>),
  type: json['type'] as String,
  content: json['content'] as String,
  media:
      (json['media'] as List<dynamic>?)
          ?.map((e) => PostMedia.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: (json['created_at'] as num).toInt(),
  isFollowing: json['is_following'] as bool? ?? false,
  isPromoted: json['is_promoted'] as bool? ?? false,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'page': instance.page,
      'type': instance.type,
      'content': instance.content,
      'media': instance.media,
      'created_at': instance.createdAt,
      'is_following': instance.isFollowing,
      'is_promoted': instance.isPromoted,
      'metadata': instance.metadata,
    };

_$PostPageImpl _$$PostPageImplFromJson(Map<String, dynamic> json) =>
    _$PostPageImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      avatarUrl: json['avatar_url'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
    );

Map<String, dynamic> _$$PostPageImplToJson(_$PostPageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'avatar_url': instance.avatarUrl,
      'is_verified': instance.isVerified,
    };

_$PostMediaImpl _$$PostMediaImplFromJson(Map<String, dynamic> json) =>
    _$PostMediaImpl(
      url: json['url'] as String,
      type: json['type'] as String? ?? 'image',
    );

Map<String, dynamic> _$$PostMediaImplToJson(_$PostMediaImpl instance) =>
    <String, dynamic>{'url': instance.url, 'type': instance.type};
