import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/home/domain/entities/post.dart';
import 'package:honak/shared/providers/api_provider.dart';

final postDetailProvider =
    FutureProvider.family<Post, String>((ref, id) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get<Post>(
    '/v1/posts/$id',
    fromJson: (json) => Post.fromJson(json as Map<String, dynamic>),
  );
  if (response.isSuccess && response.data != null) return response.data!;
  throw Exception(response.error?.message ?? 'Failed to load post');
});
