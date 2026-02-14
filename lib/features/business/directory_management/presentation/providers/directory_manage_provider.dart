import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/directory_management/data/directory_repository.dart';
import 'package:honak/features/business/directory_management/domain/entities/directory_manage_data.dart';
import 'package:honak/shared/providers/api_provider.dart';

final directoryRepositoryProvider = Provider<DirectoryRepository>((ref) {
  return DirectoryRepository(ref.read(apiClientProvider));
});

final directoryManageDataProvider =
    FutureProvider.family<DirectoryManageData, String>((ref, pageId) async {
  final repo = ref.read(directoryRepositoryProvider);
  return repo.getDirectoryManageData(pageId);
});
