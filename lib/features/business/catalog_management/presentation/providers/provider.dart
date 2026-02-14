import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/catalog_management/data/repository/catalog_repository.dart';
import 'package:honak/features/business/shared/domain/entities/entities.dart';
import 'package:honak/shared/extensions/sort_extensions.dart';
import 'package:honak/shared/providers/api_provider.dart';

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  return CatalogRepository(ref.read(apiClientProvider));
});

final bizItemsProvider =
    FutureProvider.family<List<BizItem>, String>((ref, pageId) async {
  final repo = ref.read(catalogRepositoryProvider);
  final items = await repo.getItems(pageId);
  return items.sortedByOrder((i) => i.sortOrder);
});

final bizCategoriesProvider =
    FutureProvider.family<List<BizCategory>, String>((ref, pageId) async {
  final repo = ref.read(catalogRepositoryProvider);
  final categories = await repo.getCategories(pageId);
  return categories.sortedByOrder((c) => c.sortOrder);
});
