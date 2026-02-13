import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_discount.freezed.dart';
part 'queue_discount.g.dart';

@freezed
class QueueDiscount with _$QueueDiscount {
  const factory QueueDiscount({
    /// 'percentage' or 'fixed'
    required String type,

    /// Raw input: 20 (for 20%) or 150 (for 1.5 JOD in piasters)
    required int value,

    /// Calculated amount deducted (piasters)
    @JsonKey(name: 'amount_cents') required int amount,

    /// Internal reason label (عميل مميز, تعويض, عرض خاص, etc.)
    required String reason,

    /// Free-text note for "أخرى" reason
    @JsonKey(name: 'reason_note') String? reasonNote,
  }) = _QueueDiscount;

  factory QueueDiscount.fromJson(Map<String, dynamic> json) =>
      _$QueueDiscountFromJson(json);
}
