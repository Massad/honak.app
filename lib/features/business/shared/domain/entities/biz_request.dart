import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/entities/money_converter.dart';

part 'biz_request.freezed.dart';
part 'biz_request.g.dart';

@freezed
class BizRequest with _$BizRequest {
  const factory BizRequest({
    required String id,
    required RequestCustomer customer,
    required String status,
    @Default('order') String type,
    @JsonKey(name: 'items_count') @Default(0) int itemsCount,
    @JsonKey(name: 'total_cents') @MoneyNullableConverter() Money? total,
    String? note,
    @JsonKey(name: 'decline_reason') String? declineReason,
    @JsonKey(name: 'created_at') required int createdAt,
    @Default([]) List<RequestItem> items,
    @JsonKey(name: 'conversation_id') String? conversationId,
    // Archetype-specific optional fields
    @JsonKey(name: 'preferred_date') String? preferredDate,
    @JsonKey(name: 'time_slot') String? timeSlot,
    String? description,
    @JsonKey(name: 'date_range') String? dateRange,
    @JsonKey(name: 'guest_count') int? guestCount,
    @JsonKey(name: 'service_location') String? serviceLocation,
  }) = _BizRequest;

  factory BizRequest.fromJson(Map<String, dynamic> json) =>
      _$BizRequestFromJson(json);
}

@freezed
class RequestCustomer with _$RequestCustomer {
  const factory RequestCustomer({
    required String id,
    required String name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? phone,
  }) = _RequestCustomer;

  factory RequestCustomer.fromJson(Map<String, dynamic> json) =>
      _$RequestCustomerFromJson(json);
}

@freezed
class RequestItem with _$RequestItem {
  const factory RequestItem({
    required String id,
    required String name,
    @Default(1) int quantity,
    @JsonKey(name: 'price_cents') @MoneyNullableConverter() Money? price,
    String? variation,
  }) = _RequestItem;

  factory RequestItem.fromJson(Map<String, dynamic> json) =>
      _$RequestItemFromJson(json);
}
