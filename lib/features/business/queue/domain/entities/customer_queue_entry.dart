import 'package:freezed_annotation/freezed_annotation.dart';
import 'queue_add_on.dart';
import 'queue_source.dart';
import 'queue_status.dart';

part 'customer_queue_entry.freezed.dart';
part 'customer_queue_entry.g.dart';

@freezed
class CustomerQueueEntry with _$CustomerQueueEntry {
  const factory CustomerQueueEntry({
    required String id,
    @JsonKey(name: 'page_id') required String pageId,
    @JsonKey(name: 'page_name') required String pageName,
    required int position,
    required QueueStatus status,
    required QueueSource source,

    // Service details
    @JsonKey(name: 'package_id') required String packageId,
    @JsonKey(name: 'package_name') required String packageName,
    @JsonKey(name: 'package_price_cents') required int packagePriceCents,
    @JsonKey(name: 'add_ons') @Default([]) List<QueueAddOn> addOns,
    @JsonKey(name: 'total_price_cents') required int totalPriceCents,
    @JsonKey(name: 'estimated_duration_min') required int estimatedDurationMin,

    // Queue context
    @JsonKey(name: 'ahead_count') @Default(0) int aheadCount,
    @JsonKey(name: 'estimated_wait_min') @Default(0) int estimatedWaitMin,

    // Timestamps (unix epoch seconds)
    @JsonKey(name: 'checked_in_at') required int checkedInAt,
    @JsonKey(name: 'started_at') int? startedAt,
    @JsonKey(name: 'completed_at') int? completedAt,

    // Flags
    @JsonKey(name: 'on_the_way') @Default(false) bool onTheWay,
    @JsonKey(name: 'modification_pending') @Default(false) bool modificationPending,

    // Payment info (shown on ready state)
    @JsonKey(name: 'payment_methods') @Default([]) List<String> paymentMethods,
  }) = _CustomerQueueEntry;

  factory CustomerQueueEntry.fromJson(Map<String, dynamic> json) =>
      _$CustomerQueueEntryFromJson(json);
}
