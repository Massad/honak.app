import 'package:freezed_annotation/freezed_annotation.dart';

import 'queue_add_on.dart';
import 'queue_source.dart';
import 'queue_status.dart';

part 'queue_entry.freezed.dart';
part 'queue_entry.g.dart';

@freezed
class QueueEntry with _$QueueEntry {
  const factory QueueEntry({
    required String id,
    required int position,
    required QueueStatus status,
    required QueueSource source,

    // Customer info
    @JsonKey(name: 'customer_name') required String customerName,
    @JsonKey(name: 'customer_phone') String? customerPhone,
    @JsonKey(name: 'customer_avatar') String? customerAvatar,
    @JsonKey(name: 'is_subscriber') @Default(false) bool isSubscriber,

    // Vehicle info (for car wash etc.)
    @JsonKey(name: 'vehicle_type') String? vehicleType,
    @JsonKey(name: 'vehicle_color') String? vehicleColor,
    @JsonKey(name: 'plate_number') String? plateNumber,
    @JsonKey(name: 'vehicle_label') String? vehicleLabel,

    // Service info
    @JsonKey(name: 'package_id') required String packageId,
    @JsonKey(name: 'package_name') required String packageName,
    @JsonKey(name: 'package_price_cents') required int packagePrice,
    @JsonKey(name: 'add_ons') @Default([]) List<QueueAddOn> addOns,
    @JsonKey(name: 'total_price_cents') required int totalPrice,
    @JsonKey(name: 'estimated_duration_min') required int estimatedDurationMin,

    // Timestamps (unix epoch seconds)
    @JsonKey(name: 'checked_in_at') required int checkedInAt,
    @JsonKey(name: 'started_at') int? startedAt,
    @JsonKey(name: 'completed_at') int? completedAt,
    @JsonKey(name: 'estimated_ready_at') int? estimatedReadyAt,

    // Extras
    String? notes,
    @JsonKey(name: 'photos_before') @Default([]) List<String> photosBefore,
    @JsonKey(name: 'photos_after') @Default([]) List<String> photosAfter,
    @JsonKey(name: 'subscription_plan') String? subscriptionPlan,
  }) = _QueueEntry;

  factory QueueEntry.fromJson(Map<String, dynamic> json) =>
      _$QueueEntryFromJson(json);
}
