import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_subscription.freezed.dart';
part 'queue_subscription.g.dart';

@freezed
class QueueSubscription with _$QueueSubscription {
  const factory QueueSubscription({
    required String id,
    @JsonKey(name: 'name_ar') required String nameAr,
    @JsonKey(name: 'washes_per_month') required int washesPerMonth,
    @JsonKey(name: 'price_per_month_cents') required int pricePerMonth,
    @JsonKey(name: 'package_id') required String packageId,
    @Default([]) List<String> features,
    @Default(false) bool popular,
  }) = _QueueSubscription;

  factory QueueSubscription.fromJson(Map<String, dynamic> json) =>
      _$QueueSubscriptionFromJson(json);
}
