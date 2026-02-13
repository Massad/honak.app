// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PageSettingsImpl _$$PageSettingsImplFromJson(Map<String, dynamic> json) =>
    _$PageSettingsImpl(
      status: json['status'] as String? ?? 'active',
      closeReason: json['close_reason'] as String?,
      tempClosedMessage: json['temp_closed_message'] as String?,
      engagementLevel: json['engagement_level'] as String? ?? 'full',
      orderApproval: json['order_approval'] as String? ?? 'manual',
      returnWindowDays: (json['return_window_days'] as num?)?.toInt() ?? 7,
      returnType: json['return_type'] as String? ?? 'both',
      returnCost: json['return_cost'] as String? ?? 'free',
      cancelWindowHours: (json['cancel_window_hours'] as num?)?.toInt() ?? 24,
      noShowAction: json['no_show_action'] as String? ?? 'warn',
      lateCancelFeeType: json['late_cancel_fee_type'] as String? ?? 'none',
      lateCancelFeeAmount:
          (json['late_cancel_fee_amount'] as num?)?.toInt() ?? 0,
      catalogStrategy: json['catalog_strategy'] as String? ?? 'full_catalog',
      highlightCategories:
          (json['highlight_categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      disclaimers:
          (json['disclaimers'] as List<dynamic>?)
              ?.map((e) => SafetyDisclaimer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      postBookingSteps:
          (json['post_booking_steps'] as List<dynamic>?)
              ?.map((e) => PostBookingStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      acceptReturns: json['accept_returns'] as bool? ?? true,
      returnConditions: json['return_conditions'] as String? ?? '',
      lateCancelMessage: json['late_cancel_message'] as String? ?? '',
      reopenDate: json['reopen_date'] as String?,
    );

Map<String, dynamic> _$$PageSettingsImplToJson(_$PageSettingsImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'close_reason': instance.closeReason,
      'temp_closed_message': instance.tempClosedMessage,
      'engagement_level': instance.engagementLevel,
      'order_approval': instance.orderApproval,
      'return_window_days': instance.returnWindowDays,
      'return_type': instance.returnType,
      'return_cost': instance.returnCost,
      'cancel_window_hours': instance.cancelWindowHours,
      'no_show_action': instance.noShowAction,
      'late_cancel_fee_type': instance.lateCancelFeeType,
      'late_cancel_fee_amount': instance.lateCancelFeeAmount,
      'catalog_strategy': instance.catalogStrategy,
      'highlight_categories': instance.highlightCategories,
      'disclaimers': instance.disclaimers,
      'post_booking_steps': instance.postBookingSteps,
      'accept_returns': instance.acceptReturns,
      'return_conditions': instance.returnConditions,
      'late_cancel_message': instance.lateCancelMessage,
      'reopen_date': instance.reopenDate,
    };

_$SafetyDisclaimerImpl _$$SafetyDisclaimerImplFromJson(
  Map<String, dynamic> json,
) => _$SafetyDisclaimerImpl(
  id: json['id'] as String,
  type: json['type'] as String? ?? 'custom',
  title: json['title'] as String? ?? '',
  text: json['text'] as String,
  isActive: json['is_active'] as bool? ?? true,
  sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$SafetyDisclaimerImplToJson(
  _$SafetyDisclaimerImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'title': instance.title,
  'text': instance.text,
  'is_active': instance.isActive,
  'sort_order': instance.sortOrder,
};

_$PostBookingStepImpl _$$PostBookingStepImplFromJson(
  Map<String, dynamic> json,
) => _$PostBookingStepImpl(
  id: json['id'] as String,
  text: json['text'] as String,
  isActive: json['is_active'] as bool? ?? true,
  sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$PostBookingStepImplToJson(
  _$PostBookingStepImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'is_active': instance.isActive,
  'sort_order': instance.sortOrder,
};
