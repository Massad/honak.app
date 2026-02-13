import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/order_management/data/repository/request_repository.dart';
import 'package:honak/features/business/shared/domain/entities/entities.dart';
import 'package:honak/shared/providers/api_provider.dart';

final requestRepositoryProvider = Provider<RequestRepository>((ref) {
  return RequestRepository(ref.read(apiClientProvider));
});

final bizRequestsProvider =
    FutureProvider.family<List<BizRequest>, ({String pageId, String? status})>(
        (ref, params) async {
  final repo = ref.read(requestRepositoryProvider);
  return repo.getRequests(params.pageId, status: params.status);
});
