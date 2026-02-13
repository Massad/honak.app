import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_item.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_service.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_source.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_stats.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_status.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_ticket.dart';
import 'package:honak/shared/providers/api_provider.dart';

/// Dropoff type IDs that use the dropoff board instead of standard requests.
const dropoffTypeIds = [
  'laundry',
  'tailor',
  'shoe_repair',
  'watch_repair',
  'mobile_repair',
];

bool isDropoffType(String? typeId) => dropoffTypeIds.contains(typeId);

/// Parsed dropoff data from the fixture.
class DropoffData {
  final List<DropoffTicket> tickets;
  final DropoffDayStats stats;
  final List<DropoffServiceCategory> serviceCategories;
  final List<DropoffAttribute> attributes;
  final List<String> itemTypes;

  const DropoffData({
    required this.tickets,
    required this.stats,
    required this.serviceCategories,
    required this.attributes,
    required this.itemTypes,
  });
}

/// Loads and parses dropoff data for a business page (business side).
final dropoffDataProvider =
    FutureProvider.family<DropoffData, String>((ref, pageId) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.get<Map<String, dynamic>>(
    'biz/pages/$pageId/dropoff',
    fromJson: (json) => json as Map<String, dynamic>,
  );
  final raw = response.data!;
  return _parseDropoffData(raw);
});

/// Loads and parses dropoff data for a page (customer side).
final customerDropoffDataProvider =
    FutureProvider.family<DropoffData, String>((ref, pageId) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.get<Map<String, dynamic>>(
    'pages/$pageId/dropoff',
    fromJson: (json) => json as Map<String, dynamic>,
  );
  final raw = response.data!;
  return _parseDropoffData(raw);
});

// ═══════════════════════════════════════════════════════════════
// Parsing helpers — convert fixture JSON to entity objects
// ═══════════════════════════════════════════════════════════════

DropoffData _parseDropoffData(Map<String, dynamic> raw) {
  final tickets = (raw['tickets'] as List? ?? [])
      .cast<Map<String, dynamic>>()
      .map(_parseTicket)
      .toList();

  final statsRaw = raw['stats'] as Map<String, dynamic>? ?? {};
  final stats = DropoffDayStats(
    totalToday: statsRaw['total_today'] as int? ?? 0,
    received: statsRaw['received'] as int? ?? 0,
    processing: statsRaw['processing'] as int? ?? 0,
    ready: statsRaw['ready'] as int? ?? 0,
    delivered: statsRaw['delivered'] as int? ?? 0,
    overdue: statsRaw['overdue'] as int? ?? 0,
    revenueToday: _jodToPiasters(statsRaw['revenue_today']),
  );

  final serviceCategories = (raw['service_categories'] as List? ?? [])
      .cast<Map<String, dynamic>>()
      .map(_parseServiceCategory)
      .toList();

  final attributes = (raw['attributes'] as List? ?? [])
      .cast<Map<String, dynamic>>()
      .map(_parseAttribute)
      .toList();

  final itemTypes = (raw['item_types'] as List? ?? []).cast<String>();

  return DropoffData(
    tickets: tickets,
    stats: stats,
    serviceCategories: serviceCategories,
    attributes: attributes,
    itemTypes: itemTypes,
  );
}

DropoffTicket _parseTicket(Map<String, dynamic> raw) {
  final items = (raw['items'] as List? ?? [])
      .cast<Map<String, dynamic>>()
      .map(_parseItem)
      .toList();

  return DropoffTicket(
    id: raw['id'] as String,
    ticketNumber: raw['ticket_number'] as String,
    status: _parseStatus(raw['status'] as String),
    source: _parseSource(raw['source'] as String),
    customerName: raw['customer_name'] as String,
    customerPhone: raw['customer_phone'] as String?,
    customerAvatar: raw['customer_avatar'] as String?,
    items: items,
    totalPrice: _jodToPiasters(raw['total_price']),
    droppedOffAt: raw['dropped_off_at'] as String,
    estimatedReadyAt: raw['estimated_ready_at'] as String,
    startedAt: raw['started_at'] as String?,
    completedAt: raw['completed_at'] as String?,
    pickedUpAt: raw['picked_up_at'] as String?,
    notes: raw['notes'] as String?,
    urgent: raw['urgent'] as bool? ?? false,
    paid: raw['paid'] as bool? ?? false,
    paymentMethod: raw['payment_method'] as String?,
  );
}

DropoffItem _parseItem(Map<String, dynamic> raw) {
  final attrs = raw['attributes'];
  final parsedAttrs = <String, String>{};
  if (attrs is Map) {
    for (final entry in attrs.entries) {
      parsedAttrs[entry.key as String] = entry.value as String;
    }
  }

  return DropoffItem(
    id: raw['id'] as String,
    name: raw['name'] as String,
    quantity: raw['quantity'] as int,
    service: raw['service'] as String,
    price: _jodToPiasters(raw['price']),
    attributes: parsedAttrs,
    notes: raw['notes'] as String?,
    photoBefore: raw['photo_before'] as String?,
    photoAfter: raw['photo_after'] as String?,
  );
}

DropoffServiceCategory _parseServiceCategory(Map<String, dynamic> raw) {
  final services = (raw['services'] as List? ?? [])
      .cast<Map<String, dynamic>>()
      .map((s) => DropoffService(
            id: s['id'] as String,
            nameAr: s['name_ar'] as String,
            price: _jodToPiasters(s['price']),
            durationDays: s['duration_days'] as int,
          ))
      .toList();

  return DropoffServiceCategory(
    id: raw['id'] as String,
    nameAr: raw['name_ar'] as String,
    icon: raw['icon'] as String,
    services: services,
  );
}

DropoffAttribute _parseAttribute(Map<String, dynamic> raw) {
  return DropoffAttribute(
    id: raw['id'] as String,
    labelAr: raw['label_ar'] as String,
    values: (raw['values'] as List).cast<String>(),
    optional: raw['optional'] as bool? ?? true,
  );
}

/// Converts a JOD amount (double or int) to piasters (integer cents).
int _jodToPiasters(dynamic value) {
  if (value == null) return 0;
  if (value is int) return (value * 100);
  if (value is double) return (value * 100).round();
  return 0;
}

DropoffStatus _parseStatus(String raw) => switch (raw) {
      'received' => DropoffStatus.received,
      'processing' => DropoffStatus.processing,
      'ready' => DropoffStatus.ready,
      'delivered' => DropoffStatus.delivered,
      'cancelled' => DropoffStatus.cancelled,
      _ => DropoffStatus.received,
    };

DropoffSource _parseSource(String raw) => switch (raw) {
      'walk_in' => DropoffSource.walkIn,
      'app_request' => DropoffSource.appRequest,
      'phone' => DropoffSource.phone,
      _ => DropoffSource.walkIn,
    };
