import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/explore/domain/entities/page_summary.dart';
import 'package:honak/features/explore/presentation/providers/explore_providers.dart';

/// Directory-type pages available as venue options for branch linking.
final venueListProvider = FutureProvider<List<PageSummary>>((ref) async {
  final pages = await ref.watch(trendingPagesProvider.future);
  return pages.where((p) => p.archetype == 'directory').toList();
});
