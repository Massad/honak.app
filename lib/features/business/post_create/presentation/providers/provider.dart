import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/post_create/data/repository/repository.dart';
import 'package:honak/shared/providers/api_provider.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepository(ref.read(apiClientProvider));
});
