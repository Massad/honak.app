import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_customer.freezed.dart';
part 'business_customer.g.dart';

@JsonEnum(valueField: 'value')
enum CustomerBadge {
  @JsonValue('new')
  newCustomer('new'),
  @JsonValue('active')
  active('active'),
  @JsonValue('repeat')
  repeat('repeat'),
  @JsonValue('interested')
  interested('interested'),
  @JsonValue('past')
  past('past');

  const CustomerBadge(this.value);
  final String value;
}

@freezed
class CustomerSubscriptionInfo with _$CustomerSubscriptionInfo {
  const factory CustomerSubscriptionInfo({
    required String id,
    @JsonKey(name: 'package_name') required String packageName,
    @JsonKey(name: 'remaining_credits') int? remainingCredits,
    @JsonKey(name: 'total_credits') int? totalCredits,
    @JsonKey(name: 'expires_at') String? expiresAt,
    required String model,
    @JsonKey(name: 'recurring_mode') String? recurringMode,
    @JsonKey(name: 'recurring_frequency') String? recurringFrequency,
    required String status,
  }) = _CustomerSubscriptionInfo;

  factory CustomerSubscriptionInfo.fromJson(Map<String, dynamic> json) =>
      _$CustomerSubscriptionInfoFromJson(json);
}

@freezed
class RecentOrder with _$RecentOrder {
  const factory RecentOrder({
    required String date,
    required String summary,
    @Default(0) int amount,
    @Default('pending') String status,
  }) = _RecentOrder;

  factory RecentOrder.fromJson(Map<String, dynamic> json) =>
      _$RecentOrderFromJson(json);
}

@freezed
class BusinessCustomer with _$BusinessCustomer {
  const BusinessCustomer._();

  const factory BusinessCustomer({
    required String id,
    required String name,
    String? phone,
    String? avatar,
    String? area,
    @Default(CustomerBadge.newCustomer) CustomerBadge badge,
    @JsonKey(name: 'total_orders') @Default(0) int totalOrders,
    @JsonKey(name: 'total_spent') @Default(0) int totalSpent,
    @JsonKey(name: 'last_order_date') String? lastOrderDate,
    @JsonKey(name: 'last_activity_date') String? lastActivityDate,
    @JsonKey(name: 'usual_payment') String? usualPayment,
    CustomerSubscriptionInfo? subscription,
    String? source,
    @JsonKey(name: 'created_at') String? createdAt,
    String? notes,
    @JsonKey(name: 'recent_orders') @Default([]) List<RecentOrder> recentOrders,
  }) = _BusinessCustomer;

  factory BusinessCustomer.fromJson(Map<String, dynamic> json) =>
      _$BusinessCustomerFromJson(json);

  /// Whether this customer has an active subscription.
  bool get hasActiveSubscription => subscription?.status == 'active';

  /// Total spent in JOD (converts from piasters).
  double get totalSpentJod => totalSpent / 100;

  /// Average order value in JOD.
  double get avgOrderJod =>
      totalOrders > 0 ? totalSpentJod / totalOrders : 0;
}
