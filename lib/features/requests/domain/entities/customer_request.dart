import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/entities/money_converter.dart';

part 'customer_request.freezed.dart';
part 'customer_request.g.dart';

/// Customer-facing request — includes business info and timeline.
@freezed
class CustomerRequest with _$CustomerRequest {
  const CustomerRequest._();

  const factory CustomerRequest({
    required String id,
    required String type, // order | booking | quote | inquiry | reservation
    required String status,
    @JsonKey(name: 'business_page_id') required String businessPageId,
    @JsonKey(name: 'business_name') required String businessName,
    @JsonKey(name: 'business_avatar_url') String? businessAvatarUrl,
    @JsonKey(name: 'business_slug') String? businessSlug,
    @Default([]) List<OrderLineItem> items,
    @JsonKey(name: 'items_count') @Default(0) int itemsCount,
    @JsonKey(name: 'total_cents') @MoneyNullableConverter() Money? total,
    String? note,
    String? summary,
    @JsonKey(name: 'created_at') required int createdAt,
    // Status timeline
    @Default([]) List<TimelineEvent> timeline,
    // Delivery tracking (for in-progress orders)
    @JsonKey(name: 'delivery_tracking') DeliveryTracking? deliveryTracking,
    // Subscription payment info
    @JsonKey(name: 'paid_by_subscription') SubscriptionPayment? paidBySubscription,
    // Action flags
    @JsonKey(name: 'can_edit') @Default(false) bool canEdit,
    @JsonKey(name: 'can_cancel') @Default(false) bool canCancel,
    @JsonKey(name: 'can_reschedule') @Default(false) bool canReschedule,
    // Archetype-specific optionals
    @JsonKey(name: 'preferred_date') String? preferredDate,
    @JsonKey(name: 'time_slot') String? timeSlot,
    String? description,
    @JsonKey(name: 'date_range') String? dateRange,
    @JsonKey(name: 'guest_count') int? guestCount,
    @JsonKey(name: 'service_location') String? serviceLocation,
    String? urgency, // not_urgent | soon | asap
    @JsonKey(name: 'team_member') String? teamMember,
    @JsonKey(name: 'delivery_method') String? deliveryMethod, // delivery | pickup
    @JsonKey(name: 'delivery_address') String? deliveryAddress,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'decline_reason') String? declineReason,
    // Queue-specific fields
    @JsonKey(name: 'queue_position') int? queuePosition,
    @JsonKey(name: 'estimated_wait_min') int? estimatedWaitMin,
    @JsonKey(name: 'queue_status') String? queueStatus,
  }) = _CustomerRequest;

  factory CustomerRequest.fromJson(Map<String, dynamic> json) =>
      _$CustomerRequestFromJson(json);

  /// Whether this is a time-based request that can be rescheduled.
  bool get isSchedulable => type == 'booking' || type == 'reservation';

  /// Whether this request always requires manual business approval.
  bool get isManualApprovalOnly => type == 'quote' || type == 'inquiry';

  /// Whether this is an order-type request (catalog or menu).
  bool get isOrderType => type == 'order';

  /// Whether this is a reservation (as opposed to a booking).
  bool get isReservation => type == 'reservation';

  /// Whether this is a queue-type request (car wash, oil change, etc.).
  bool get isQueueType => type == 'queue_service';

  /// Short summary text for list cards — config-driven, no widget-level switch.
  String get summaryText {
    if (isQueueType) {
      if (queuePosition != null) return 'رقمك $queuePosition';
      return 'في الدور';
    }
    if (isOrderType) {
      final count = itemsCount > 0 ? itemsCount : items.length;
      return '$count أصناف';
    }
    if (isSchedulable) {
      return timeSlot ?? preferredDate ?? dateRange ?? 'حجز';
    }
    if (isManualApprovalOnly) {
      final desc = description ?? '';
      return desc.length > 50 ? '${desc.substring(0, 50)}...' : desc;
    }
    return '';
  }
}

/// Line item in a customer's order.
@freezed
class OrderLineItem with _$OrderLineItem {
  const factory OrderLineItem({
    required String id,
    required String name,
    @Default(1) int quantity,
    @JsonKey(name: 'price_cents') @MoneyNullableConverter() Money? price,
    String? variation,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _OrderLineItem;

  factory OrderLineItem.fromJson(Map<String, dynamic> json) =>
      _$OrderLineItemFromJson(json);
}

/// Single event in the request status timeline.
@freezed
class TimelineEvent with _$TimelineEvent {
  const factory TimelineEvent({
    required String status,
    required String label,
    required int timestamp,
    @Default('system') String actor, // customer | business | system
    String? detail,
    @Default(false) bool done,
  }) = _TimelineEvent;

  factory TimelineEvent.fromJson(Map<String, dynamic> json) =>
      _$TimelineEventFromJson(json);
}

/// Delivery tracking info for in-progress orders.
@freezed
class DeliveryTracking with _$DeliveryTracking {
  const factory DeliveryTracking({
    required String status, // dispatched | en_route | arriving | delivered
    @JsonKey(name: 'estimated_minutes') int? estimatedMinutes,
    @JsonKey(name: 'driver_name') String? driverName,
    @JsonKey(name: 'driver_phone') String? driverPhone,
  }) = _DeliveryTracking;

  factory DeliveryTracking.fromJson(Map<String, dynamic> json) =>
      _$DeliveryTrackingFromJson(json);
}

/// Subscription payment info when order is paid via subscription credits.
@freezed
class SubscriptionPayment with _$SubscriptionPayment {
  const factory SubscriptionPayment({
    @JsonKey(name: 'subscription_id') required String subscriptionId,
    @JsonKey(name: 'package_name') required String packageName,
    @JsonKey(name: 'credits_used') @Default(1) int creditsUsed,
    @JsonKey(name: 'remaining_after') int? remainingAfter,
  }) = _SubscriptionPayment;

  factory SubscriptionPayment.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPaymentFromJson(json);
}
