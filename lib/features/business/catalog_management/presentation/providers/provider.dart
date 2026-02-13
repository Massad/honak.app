import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/catalog_management/data/repository/catalog_repository.dart';
import 'package:honak/features/business/shared/domain/entities/entities.dart';
import 'package:honak/shared/providers/api_provider.dart';

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  return CatalogRepository(ref.read(apiClientProvider));
});

final bizItemsProvider =
    FutureProvider.family<List<BizItem>, String>((ref, pageId) async {
  final repo = ref.read(catalogRepositoryProvider);
  return repo.getItems(pageId);
});

final bizCategoriesProvider =
    FutureProvider.family<List<BizCategory>, String>((ref, pageId) async {
  final repo = ref.read(catalogRepositoryProvider);
  return repo.getCategories(pageId);
});
