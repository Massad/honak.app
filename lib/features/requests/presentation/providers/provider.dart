import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/requests/data/repository/repository.dart';
import 'package:honak/features/requests/domain/entities/entities.dart';
import 'package:honak/shared/providers/api_provider.dart';

final requestRepositoryProvider = Provider<RequestRepository>((ref) {
  return RequestRepository(ref.read(apiClientProvider));
});

/// All customer requests, optionally filtered by status.
/// Pass `null` for all, or `'active'` / `'completed'` for filtered lists.
final myRequestsProvider =
    FutureProvider.family<List<CustomerRequest>, String?>((ref, status) async {
  final repo = ref.read(requestRepositoryProvider);
  return repo.getMyRequests(status: status);
});

/// Single request detail.
final requestDetailProvider =
    FutureProvider.family<CustomerRequest, String>((ref, id) async {
  final repo = ref.read(requestRepositoryProvider);
  return repo.getRequestDetail(id);
});
