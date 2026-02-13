import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/page_settings/data/settings_repository.dart';
import 'package:honak/features/business/page_settings/domain/entities/alert_model.dart';

final _repo = SettingsRepository();

final alertProvider =
    AsyncNotifierProvider<AlertNotifier, List<BusinessAlert>>(() {
  return AlertNotifier();
});

class AlertNotifier extends AsyncNotifier<List<BusinessAlert>> {
  @override
  Future<List<BusinessAlert>> build() async {
    return _repo.getAlerts();
  }

  void addAlert(BusinessAlert alert) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data([...current, alert]);
  }

  void updateAlert(BusinessAlert alert) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((a) {
        if (a.id == alert.id) return alert;
        return a;
      }).toList(),
    );
  }

  void removeAlert(String id) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(current.where((a) => a.id != id).toList());
  }

  void toggleAlert(String id, bool active) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((a) {
        if (a.id == id) return a.copyWith(active: active);
        return a;
      }).toList(),
    );
  }

  void endAlert(String id) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((a) {
        if (a.id == id) return a.copyWith(active: false);
        return a;
      }).toList(),
    );
  }
}
