import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/subscriptions/data/repository/subscription_repository.dart';
import 'package:honak/features/subscriptions/domain/entities/entities.dart';
import 'package:honak/shared/providers/api_provider.dart';

final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  return SubscriptionRepository(ref.read(apiClientProvider));
});

/// All customer subscriptions from the API.
final mySubscriptionsProvider =
    FutureProvider<List<Subscription>>((ref) async {
  final repo = ref.read(subscriptionRepositoryProvider);
  return repo.getMySubscriptions();
});

/// Active + paused subscriptions.
final activeSubscriptionsProvider = Provider<List<Subscription>>((ref) {
  final subs = ref.watch(mySubscriptionsProvider).valueOrNull ?? [];
  return subs
      .where((s) =>
          s.status == SubscriptionStatus.active ||
          s.status == SubscriptionStatus.paused)
      .toList();
});

/// Inactive subscriptions (depleted, expired, cancelled).
final inactiveSubscriptionsProvider = Provider<List<Subscription>>((ref) {
  final subs = ref.watch(mySubscriptionsProvider).valueOrNull ?? [];
  return subs
      .where((s) =>
          s.status != SubscriptionStatus.active &&
          s.status != SubscriptionStatus.paused)
      .toList();
});
