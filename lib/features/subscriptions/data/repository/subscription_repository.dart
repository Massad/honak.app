import 'package:honak/features/subscriptions/domain/entities/entities.dart';
import 'package:honak/shared/api/api_client.dart';

class SubscriptionRepository {
  final ApiClient _api;

  SubscriptionRepository(this._api);

  Future<List<Subscription>> getMySubscriptions() async {
    final response = await _api.get<List<Subscription>>(
      '/v1/subscriptions',
      fromJson: (json) => (json as List)
          .map((e) => Subscription.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to load subscriptions');
  }
}
