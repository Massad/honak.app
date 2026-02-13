import 'package:honak/features/saved/domain/entities/saved_page.dart';
import 'package:honak/shared/api/api_client.dart';

class SavedRepository {
  final ApiClient _api;

  SavedRepository(this._api);

  Future<List<SavedPage>> getSavedPages() async {
    final response = await _api.get<List<dynamic>>(
      '/v1/saved/pages',
      fromJson: (json) => json as List<dynamic>,
    );

    if (response.isSuccess && response.data != null) {
      return response.data!
          .map((e) => SavedPage.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return [];
  }
}
