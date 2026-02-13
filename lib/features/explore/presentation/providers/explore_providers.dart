import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/explore/domain/entities/category.dart';
import 'package:honak/features/explore/domain/entities/page_summary.dart';
import 'package:honak/features/home/domain/entities/nearby_page.dart';
import 'package:honak/shared/providers/api_provider.dart';

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get<List<Category>>(
    '/v1/categories',
    fromJson: (json) => (json as List)
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
  if (response.isSuccess && response.data != null) return response.data!;
  throw Exception(response.error?.message ?? 'Failed to load categories');
});

final trendingPagesProvider = FutureProvider<List<PageSummary>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get<List<PageSummary>>(
    '/v1/pages',
    fromJson: (json) => (json as List)
        .map((e) => PageSummary.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
  if (response.isSuccess && response.data != null) return response.data!;
  throw Exception(response.error?.message ?? 'Failed to load pages');
});

final nearbyExploreProvider = FutureProvider<List<NearbyPage>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get<List<NearbyPage>>(
    '/v1/feed/nearby',
    fromJson: (json) => (json as List)
        .map((e) => NearbyPage.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
  if (response.isSuccess && response.data != null) return response.data!;
  throw Exception(response.error?.message ?? 'Failed to load nearby pages');
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final selectedFilterProvider = StateProvider<String?>((ref) => null);

final searchPagesProvider =
    FutureProvider.family<List<PageSummary>, String>((ref, query) async {
  if (query.isEmpty) return [];
  final api = ref.read(apiClientProvider);
  final response = await api.get<List<PageSummary>>(
    '/v1/pages',
    queryParams: {'q': query},
    fromJson: (json) => (json as List)
        .map((e) => PageSummary.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
  if (response.isSuccess && response.data != null) return response.data!;
  return [];
});

final categoryPagesProvider =
    FutureProvider.family<List<PageSummary>, String>((ref, slug) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get<List<PageSummary>>(
    '/v1/pages',
    queryParams: {'category': slug},
    fromJson: (json) => (json as List)
        .map((e) => PageSummary.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
  if (response.isSuccess && response.data != null) return response.data!;
  return [];
});
