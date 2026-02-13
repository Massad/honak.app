import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/features/subscriptions/domain/entities/subscription_enums.dart';

part 'subscription_package.freezed.dart';
part 'subscription_package.g.dart';

@freezed
class SubscriptionPackage with _$SubscriptionPackage {
  const factory SubscriptionPackage({
    required String id,
    required String name,
    String? description,
    required int price,
    int? credits,
    @JsonKey(name: 'credit_label') String? creditLabel,
    @JsonKey(name: 'validity_months') @Default(1) int validityMonths,
    String? icon,
    @JsonKey(name: 'compare_single_price') int? compareSinglePrice,
    @Default(true) bool active,
    required SubscriptionModel model,
    @Default([]) List<String> items,
    @JsonKey(name: 'item_ids') @Default([]) List<String> itemIds,
    String? category,
  }) = _SubscriptionPackage;

  factory SubscriptionPackage.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPackageFromJson(json);
}
