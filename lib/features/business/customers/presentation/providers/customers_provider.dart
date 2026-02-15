import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/customers/domain/entities/business_customer.dart';
import 'package:honak/features/business/customers/domain/entities/customer_invite.dart';
import 'package:honak/shared/providers/api_provider.dart';

/// Today's auto-order for subscription-based businesses.
class TodaysAutoOrder {
  final String customer;
  final String? items;
  final int? creditsBefore;
  final int? creditsAfter;
  final String status; // pending, confirmed, skipped

  const TodaysAutoOrder({
    required this.customer,
    this.items,
    this.creditsBefore,
    this.creditsAfter,
    this.status = 'pending',
  });

  factory TodaysAutoOrder.fromJson(Map<String, dynamic> json) {
    return TodaysAutoOrder(
      customer: json['customer'] as String? ?? '',
      items: json['items'] as String?,
      creditsBefore: json['credits_before'] as int?,
      creditsAfter: json['credits_after'] as int?,
      status: json['status'] as String? ?? 'pending',
    );
  }

  TodaysAutoOrder copyWith({String? status}) {
    return TodaysAutoOrder(
      customer: customer,
      items: items,
      creditsBefore: creditsBefore,
      creditsAfter: creditsAfter,
      status: status ?? this.status,
    );
  }
}

/// A subscription package available for invite pre-selection.
class InvitePackage {
  final String id;
  final String name;
  final int price; // piasters

  const InvitePackage({
    required this.id,
    required this.name,
    required this.price,
  });

  factory InvitePackage.fromJson(Map<String, dynamic> json) {
    return InvitePackage(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: json['price'] as int? ?? 0,
    );
  }
}

/// Data class holding both customers and invites for a business page.
class BizCustomersData {
  final List<BusinessCustomer> customers;
  final List<CustomerInvite> invites;
  final List<TodaysAutoOrder> autoOrders;
  final List<InvitePackage> packages;

  const BizCustomersData({
    required this.customers,
    required this.invites,
    this.autoOrders = const [],
    this.packages = const [],
  });

  factory BizCustomersData.fromJson(Map<String, dynamic> json) {
    final customersList = (json['customers'] as List<dynamic>?)
            ?.map((e) =>
                BusinessCustomer.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    final invitesList = (json['invites'] as List<dynamic>?)
            ?.map(
                (e) => CustomerInvite.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    final autoOrdersList = (json['auto_orders'] as List<dynamic>?)
            ?.map(
                (e) => TodaysAutoOrder.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    final packagesList = (json['packages'] as List<dynamic>?)
            ?.map(
                (e) => InvitePackage.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return BizCustomersData(
      customers: customersList,
      invites: invitesList,
      autoOrders: autoOrdersList,
      packages: packagesList,
    );
  }

  /// Customers with active subscriptions.
  List<BusinessCustomer> get subscribers =>
      customers.where((c) => c.subscription != null).toList();

  /// Active subscribers only.
  List<BusinessCustomer> get activeSubscribers =>
      subscribers.where((c) => c.hasActiveSubscription).toList();

  /// Total orders across all customers.
  int get totalOrders =>
      customers.fold(0, (sum, c) => sum + c.totalOrders);

  /// Average orders per customer.
  double get avgOrdersPerCustomer =>
      customers.isEmpty ? 0 : totalOrders / customers.length;

  /// Return rate (customers with >= 3 orders).
  int get repeatRatePercent {
    if (customers.isEmpty) return 0;
    final repeat = customers.where((c) => c.totalOrders >= 3).length;
    return (repeat / customers.length * 100).round();
  }

  /// Pending invites.
  List<CustomerInvite> get pendingInvites =>
      invites.where((i) => i.status == InviteStatus.pending).toList();
}

/// Fetches business customers + invites for a page.
final bizCustomersProvider =
    FutureProvider.family<BizCustomersData, String>((ref, pageId) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.get(
    '/v1/biz/customers',
    queryParams: {'page_id': pageId},
  );
  if (response.data != null && response.data is Map<String, dynamic>) {
    return BizCustomersData.fromJson(
        response.data as Map<String, dynamic>);
  }
  return const BizCustomersData(customers: [], invites: []);
});
