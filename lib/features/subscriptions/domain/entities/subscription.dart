import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/features/subscriptions/domain/entities/credit_history_entry.dart';
import 'package:honak/features/subscriptions/domain/entities/subscription_enums.dart';
import 'package:honak/features/subscriptions/domain/entities/subscription_policy.dart';

part 'subscription.freezed.dart';
part 'subscription.g.dart';

@freezed
class Subscription with _$Subscription {
  const Subscription._();

  const factory Subscription({
    required String id,
    @JsonKey(name: 'page_id') required String pageId,
    @JsonKey(name: 'page_name') required String pageName,
    @JsonKey(name: 'page_logo') String? pageLogo,
    @JsonKey(name: 'package_id') required String packageId,
    @JsonKey(name: 'package_name') required String packageName,
    required SubscriptionModel model,
    @JsonKey(name: 'total_credits') int? totalCredits,
    @JsonKey(name: 'remaining_credits') int? remainingCredits,
    @JsonKey(name: 'credit_label') String? creditLabel,
    @JsonKey(name: 'starts_at') required String startsAt,
    @JsonKey(name: 'expires_at') String? expiresAt,
    required SubscriptionStatus status,
    @Default([]) List<CreditHistoryEntry> history,
    @JsonKey(name: 'item_ids') @Default([]) List<String> itemIds,
    @JsonKey(name: 'paused_at') String? pausedAt,
    SubscriptionPolicy? policy,
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);

  /// Whether this subscription has credit-based model.
  bool get hasCreditBalance =>
      model == SubscriptionModel.visitsAndDate ||
      model == SubscriptionModel.visitsOnly ||
      model == SubscriptionModel.bundle;

  /// Balance health: healthy (>30%), low (<=30% or <=7 days), depleted (0).
  BalanceHealth get balanceHealth {
    if (status == SubscriptionStatus.depleted) return BalanceHealth.depleted;
    if (hasCreditBalance && totalCredits != null && totalCredits! > 0) {
      final ratio = (remainingCredits ?? 0) / totalCredits!;
      if (ratio <= 0) return BalanceHealth.depleted;
      if (ratio <= 0.3) return BalanceHealth.low;
    }
    if (expiresAt != null) {
      final expiry = DateTime.tryParse(expiresAt!);
      if (expiry != null) {
        final daysLeft = expiry.difference(DateTime.now()).inDays;
        if (daysLeft <= 0) return BalanceHealth.depleted;
        if (daysLeft <= 7) return BalanceHealth.low;
      }
    }
    return BalanceHealth.healthy;
  }

  /// Days until expiry (null if no expiry date).
  int? get daysUntilExpiry {
    if (expiresAt == null) return null;
    final expiry = DateTime.tryParse(expiresAt!);
    if (expiry == null) return null;
    return expiry.difference(DateTime.now()).inDays;
  }
}

enum BalanceHealth { healthy, low, depleted }
