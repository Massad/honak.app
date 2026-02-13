import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_settings.freezed.dart';
part 'page_settings.g.dart';

@freezed
class PageSettings with _$PageSettings {
  const factory PageSettings({
    @Default('active') String status,
    @JsonKey(name: 'close_reason') String? closeReason,
    @JsonKey(name: 'temp_closed_message') String? tempClosedMessage,
    @JsonKey(name: 'engagement_level') @Default('full') String engagementLevel,
    @JsonKey(name: 'order_approval') @Default('manual') String orderApproval,
    @JsonKey(name: 'return_window_days') @Default(7) int returnWindowDays,
    @JsonKey(name: 'return_type') @Default('both') String returnType,
    @JsonKey(name: 'return_cost') @Default('free') String returnCost,
    @JsonKey(name: 'cancel_window_hours') @Default(24) int cancelWindowHours,
    @JsonKey(name: 'no_show_action') @Default('warn') String noShowAction,
    @JsonKey(name: 'late_cancel_fee_type')
    @Default('none')
    String lateCancelFeeType,
    @JsonKey(name: 'late_cancel_fee_amount')
    @Default(0)
    int lateCancelFeeAmount,
    @JsonKey(name: 'catalog_strategy') @Default('full_catalog') String catalogStrategy,
    @JsonKey(name: 'highlight_categories')
    @Default([])
    List<String> highlightCategories,
    @Default([]) List<SafetyDisclaimer> disclaimers,
    @JsonKey(name: 'post_booking_steps')
    @Default([])
    List<PostBookingStep> postBookingSteps,
  }) = _PageSettings;

  factory PageSettings.fromJson(Map<String, dynamic> json) =>
      _$PageSettingsFromJson(json);
}

@freezed
class SafetyDisclaimer with _$SafetyDisclaimer {
  const factory SafetyDisclaimer({
    required String id,
    @Default('custom') String type,
    @Default('') String title,
    required String text,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
  }) = _SafetyDisclaimer;

  factory SafetyDisclaimer.fromJson(Map<String, dynamic> json) =>
      _$SafetyDisclaimerFromJson(json);
}

@freezed
class PostBookingStep with _$PostBookingStep {
  const factory PostBookingStep({
    required String id,
    required String text,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
  }) = _PostBookingStep;

  factory PostBookingStep.fromJson(Map<String, dynamic> json) =>
      _$PostBookingStepFromJson(json);
}
