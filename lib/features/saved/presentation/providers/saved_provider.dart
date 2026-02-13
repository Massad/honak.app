import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/saved/data/repository/saved_repository.dart';
import 'package:honak/features/saved/domain/entities/saved_page.dart';
import 'package:honak/shared/providers/api_provider.dart';

final savedRepositoryProvider = Provider<SavedRepository>((ref) {
  return SavedRepository(ref.read(apiClientProvider));
});

final savedPagesProvider = FutureProvider<List<SavedPage>>((ref) async {
  final repo = ref.read(savedRepositoryProvider);
  return repo.getSavedPages();
});
