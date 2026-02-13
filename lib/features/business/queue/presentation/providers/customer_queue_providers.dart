import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/queue/domain/entities/customer_queue_entry.dart';
import 'package:honak/features/business/queue/domain/entities/queue_add_on.dart';
import 'package:honak/features/business/queue/domain/entities/queue_source.dart';
import 'package:honak/features/business/queue/domain/entities/queue_status.dart';
import 'package:honak/shared/providers/api_provider.dart';

/// Active queue entry for customer at a specific page.
/// Returns null if no active entry exists.
final customerActiveQueueProvider =
    FutureProvider.family<CustomerQueueEntry?, String>((ref, pageId) async {
  final api = ref.watch(apiClientProvider);
  try {
    final response = await api.get<Map<String, dynamic>>(
      'queue/customer/$pageId',
      fromJson: (json) => json as Map<String, dynamic>,
    );
    final raw = response.data;
    if (raw == null || raw['entry'] == null) return null;
    return _parseCustomerEntry(raw['entry'] as Map<String, dynamic>);
  } catch (_) {
    return null;
  }
});

/// Recent completed/cancelled queue entry for post-queue banner.
final recentQueueEntryProvider =
    FutureProvider.family<CustomerQueueEntry?, String>((ref, pageId) async {
  final api = ref.watch(apiClientProvider);
  try {
    final response = await api.get<Map<String, dynamic>>(
      'queue/customer/$pageId/recent',
      fromJson: (json) => json as Map<String, dynamic>,
    );
    final raw = response.data;
    if (raw == null || raw['entry'] == null) return null;
    return _parseCustomerEntry(raw['entry'] as Map<String, dynamic>);
  } catch (_) {
    return null;
  }
});

// ═══════════════════════════════════════════════════════════════
// Parsing helpers
// ═══════════════════════════════════════════════════════════════

CustomerQueueEntry _parseCustomerEntry(Map<String, dynamic> raw) {
  final addOns = (raw['add_ons'] as List?)
          ?.cast<Map<String, dynamic>>()
          .map((a) => QueueAddOn(
                name: a['name'] as String,
                price: _jodToPiasters(a['price_cents'] ?? a['price']),
              ))
          .toList() ??
      [];

  return CustomerQueueEntry(
    id: raw['id'] as String,
    pageId: raw['page_id'] as String,
    pageName: raw['page_name'] as String,
    position: raw['position'] as int,
    status: _parseStatus(raw['status'] as String),
    source: _parseSource(raw['source'] as String),
    packageId: raw['package_id'] as String,
    packageName: raw['package_name'] as String,
    packagePriceCents: _jodToPiasters(raw['package_price']),
    addOns: addOns,
    totalPriceCents: _jodToPiasters(raw['total_price']),
    estimatedDurationMin: raw['estimated_duration_min'] as int,
    aheadCount: raw['ahead_count'] as int? ?? 0,
    estimatedWaitMin: raw['estimated_wait_min'] as int? ?? 0,
    checkedInAt: _parseTimestamp(raw['checked_in_at']),
    startedAt:
        raw['started_at'] != null ? _parseTimestamp(raw['started_at']) : null,
    completedAt: raw['completed_at'] != null
        ? _parseTimestamp(raw['completed_at'])
        : null,
    onTheWay: raw['on_the_way'] as bool? ?? false,
    modificationPending: raw['modification_pending'] as bool? ?? false,
    paymentMethods:
        (raw['payment_methods'] as List?)?.cast<String>() ?? [],
  );
}

int _jodToPiasters(dynamic value) {
  if (value == null) return 0;
  if (value is int) return (value * 100);
  if (value is double) return (value * 100).round();
  return 0;
}

int _parseTimestamp(dynamic value) {
  if (value is int) return value;
  if (value is String) {
    return DateTime.parse(value).millisecondsSinceEpoch ~/ 1000;
  }
  return 0;
}

QueueStatus _parseStatus(String raw) => switch (raw) {
      'waiting' => QueueStatus.waiting,
      'on_the_way' => QueueStatus.onTheWay,
      'in_progress' => QueueStatus.inProgress,
      'ready' => QueueStatus.ready,
      'completed' => QueueStatus.completed,
      'no_show' => QueueStatus.noShow,
      _ => QueueStatus.waiting,
    };

QueueSource _parseSource(String raw) => switch (raw) {
      'walk_in' => QueueSource.walkIn,
      'app_reserve' => QueueSource.appReserve,
      'phone' => QueueSource.phone,
      _ => QueueSource.walkIn,
    };
