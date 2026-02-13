import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/features/home/domain/entities/post.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/shared/providers/api_provider.dart';

final pageDetailProvider =
    FutureProvider.family<PageDetail, String>((ref, handle) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get<PageDetail>(
    '/v1/pages/$handle',
    fromJson: (json) => PageDetail.fromJson(json as Map<String, dynamic>),
  );
  if (response.isSuccess && response.data != null) return response.data!;
  throw Exception(response.error?.message ?? 'Failed to load page');
});

final pageItemsProvider =
    FutureProvider.family<List<Item>, String>((ref, pageId) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get<List<Item>>(
    '/v1/pages/$pageId/items',
    fromJson: (json) => (json as List)
        .map((e) => Item.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
  if (response.isSuccess && response.data != null) return response.data!;
  throw Exception(response.error?.message ?? 'Failed to load items');
});

final pagePostsProvider =
    FutureProvider.family<List<Post>, String>((ref, pageId) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get<List<Post>>(
    '/v1/pages/$pageId/posts',
    fromJson: (json) => (json as List)
        .map((e) => Post.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
  if (response.isSuccess && response.data != null) return response.data!;
  throw Exception(response.error?.message ?? 'Failed to load posts');
});

final pageTeamMembersProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((ref, pageId) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get<List<Map<String, dynamic>>>(
    '/v1/pages/$pageId/team',
    fromJson: (json) => (json as List)
        .map((e) => e as Map<String, dynamic>)
        .toList(),
  );
  if (response.isSuccess && response.data != null) return response.data!;
  throw Exception(response.error?.message ?? 'Failed to load team');
});
