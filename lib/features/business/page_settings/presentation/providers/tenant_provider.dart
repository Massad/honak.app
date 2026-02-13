import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/page_settings/data/settings_repository.dart';
import 'package:honak/features/business/page_settings/domain/entities/tenant.dart';

final _repo = SettingsRepository();

final tenantProvider =
    AsyncNotifierProvider<TenantNotifier, List<Tenant>>(() {
  return TenantNotifier();
});

class TenantNotifier extends AsyncNotifier<List<Tenant>> {
  @override
  Future<List<Tenant>> build() async {
    return _repo.getTenants();
  }

  void addTenant(Tenant tenant) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data([...current, tenant]);
  }

  void updateTenant(Tenant tenant) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((t) {
        if (t.id == tenant.id) return tenant;
        return t;
      }).toList(),
    );
  }

  void removeTenant(String id) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(current.where((t) => t.id != id).toList());
  }
}
