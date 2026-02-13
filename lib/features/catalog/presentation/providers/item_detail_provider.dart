import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/shared/providers/api_provider.dart';

final itemDetailProvider =
    FutureProvider.family<Item, String>((ref, id) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get<Item>(
    '/v1/items/$id',
    fromJson: (json) => Item.fromJson(json as Map<String, dynamic>),
  );
  if (response.isSuccess && response.data != null) return response.data!;
  throw Exception(response.error?.message ?? 'Failed to load item');
});
