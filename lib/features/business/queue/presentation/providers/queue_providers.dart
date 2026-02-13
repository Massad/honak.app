import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/queue/domain/entities/queue_add_on.dart';
import 'package:honak/features/business/queue/domain/entities/queue_entry.dart';
import 'package:honak/features/business/queue/domain/entities/queue_source.dart';
import 'package:honak/features/business/queue/domain/entities/queue_stats.dart';
import 'package:honak/features/business/queue/domain/entities/queue_status.dart';
import 'package:honak/features/business/queue/domain/entities/queue_subscription.dart';
import 'package:honak/features/business/queue/domain/entities/service_package.dart';
import 'package:honak/shared/providers/api_provider.dart';

/// Queue type IDs that use the queue board instead of standard requests.
const queueTypeIds = ['car_wash', 'oil_change', 'tire_shop'];

bool isQueueType(String? typeId) => queueTypeIds.contains(typeId);

/// Parsed queue data from the fixture.
class QueueData {
  final List<QueueEntry> entries;
  final QueueDayStats stats;
  final List<ServicePackage> packages;
  final List<QueueSubscription> subscriptions;

  const QueueData({
    required this.entries,
    required this.stats,
    required this.packages,
    required this.subscriptions,
  });
}

/// Loads and parses queue data for a business page (business side).
final queueDataProvider =
    FutureProvider.family<QueueData, String>((ref, pageId) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.get<Map<String, dynamic>>(
    'biz/pages/$pageId/queue',
    fromJson: (json) => json as Map<String, dynamic>,
  );
  final raw = response.data!;
  return _parseQueueData(raw);
});

/// Loads and parses queue data for a page (customer side).
final customerQueueDataProvider =
    FutureProvider.family<QueueData, String>((ref, pageId) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.get<Map<String, dynamic>>(
    'pages/$pageId/queue',
    fromJson: (json) => json as Map<String, dynamic>,
  );
  final raw = response.data!;
  return _parseQueueData(raw);
});

// ═══════════════════════════════════════════════════════════════
// Parsing helpers — convert fixture JSON to entity objects
// ═══════════════════════════════════════════════════════════════

QueueData _parseQueueData(Map<String, dynamic> raw) {
  final entries = (raw['queue'] as List? ?? [])
      .cast<Map<String, dynamic>>()
      .map(_parseEntry)
      .toList();

  final statsRaw = raw['stats'] as Map<String, dynamic>? ?? {};
  final stats = QueueDayStats(
    totalToday: statsRaw['total_today'] as int? ?? 0,
    completed: statsRaw['completed'] as int? ?? 0,
    inProgress: statsRaw['in_progress'] as int? ?? 0,
    waiting: statsRaw['waiting'] as int? ?? 0,
    noShows: statsRaw['no_shows'] as int? ?? 0,
    avgWaitMin: statsRaw['avg_wait_min'] as int? ?? 0,
    avgServiceMin: statsRaw['avg_service_min'] as int? ?? 0,
    revenueToday: _jodToPiasters(statsRaw['revenue_today']),
    subscribersToday: statsRaw['subscribers_today'] as int? ?? 0,
  );

  final packages = (raw['packages'] as List? ?? [])
      .cast<Map<String, dynamic>>()
      .map(_parsePackage)
      .toList();

  final subscriptions = (raw['subscriptions'] as List? ?? [])
      .cast<Map<String, dynamic>>()
      .map(_parseSubscription)
      .toList();

  return QueueData(
    entries: entries,
    stats: stats,
    packages: packages,
    subscriptions: subscriptions,
  );
}

QueueEntry _parseEntry(Map<String, dynamic> raw) {
  final addOns = (raw['add_ons'] as List?)
          ?.cast<Map<String, dynamic>>()
          .map((a) => QueueAddOn(
                name: a['name'] as String,
                price: _jodToPiasters(a['price']),
              ))
          .toList() ??
      [];

  return QueueEntry(
    id: raw['id'] as String,
    position: raw['position'] as int,
    status: _parseStatus(raw['status'] as String),
    source: _parseSource(raw['source'] as String),
    customerName: raw['customer_name'] as String,
    customerPhone: raw['customer_phone'] as String?,
    isSubscriber: raw['is_subscriber'] as bool? ?? false,
    vehicleType: raw['vehicle_type'] as String?,
    vehicleColor: raw['vehicle_color'] as String?,
    plateNumber: raw['plate_number'] as String?,
    packageId: raw['package_id'] as String,
    packageName: raw['package_name'] as String,
    packagePrice: _jodToPiasters(raw['package_price']),
    addOns: addOns,
    totalPrice: _jodToPiasters(raw['total_price']),
    estimatedDurationMin: raw['estimated_duration_min'] as int,
    checkedInAt: _parseTimestamp(raw['checked_in_at']),
    startedAt: raw['started_at'] != null
        ? _parseTimestamp(raw['started_at'])
        : null,
    completedAt: raw['completed_at'] != null
        ? _parseTimestamp(raw['completed_at'])
        : null,
    notes: raw['notes'] as String?,
    subscriptionPlan: raw['subscription_plan'] as String?,
  );
}

ServicePackage _parsePackage(Map<String, dynamic> raw) {
  return ServicePackage(
    id: raw['id'] as String,
    nameAr: raw['name_ar'] as String,
    nameEn: raw['name_en'] as String?,
    descriptionAr: raw['description_ar'] as String?,
    price: _jodToPiasters(raw['price']),
    durationMin: raw['duration_min'] as int,
    features: (raw['features'] as List?)?.cast<String>() ?? [],
    icon: raw['icon'] as String?,
    popular: raw['popular'] as bool? ?? false,
    color: raw['color'] as String?,
  );
}

QueueSubscription _parseSubscription(Map<String, dynamic> raw) {
  return QueueSubscription(
    id: raw['id'] as String,
    nameAr: raw['name_ar'] as String,
    washesPerMonth: raw['washes_per_month'] as int,
    pricePerMonth: _jodToPiasters(raw['price_per_month']),
    packageId: raw['package_id'] as String,
    features: (raw['features'] as List?)?.cast<String>() ?? [],
    popular: raw['popular'] as bool? ?? false,
  );
}

/// Converts a JOD amount (double or int) to piasters (integer cents).
int _jodToPiasters(dynamic value) {
  if (value == null) return 0;
  if (value is int) return (value * 100);
  if (value is double) return (value * 100).round();
  return 0;
}

/// Parses an ISO-8601 timestamp string to unix epoch seconds.
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
