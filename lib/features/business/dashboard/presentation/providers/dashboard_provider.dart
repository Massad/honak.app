import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/features/business/dashboard/data/repository/dashboard_repository.dart';
import 'package:honak/shared/providers/api_provider.dart';

final dashboardRepoProvider = Provider((ref) {
  return DashboardRepository(ref.read(apiClientProvider));
});

final dashboardStatsProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, pageId) async {
  final repo = ref.read(dashboardRepoProvider);
  return repo.getDashboardStats(pageId);
});
