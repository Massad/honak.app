import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/page_settings/data/settings_repository.dart';
import 'package:honak/features/business/page_settings/domain/entities/package_model.dart';

final _repo = SettingsRepository();

final packagesProvider =
    AsyncNotifierProvider<PackagesNotifier, List<BusinessPackage>>(() {
  return PackagesNotifier();
});

class PackagesNotifier extends AsyncNotifier<List<BusinessPackage>> {
  @override
  Future<List<BusinessPackage>> build() async {
    return _repo.getPackages();
  }

  void addPackage(BusinessPackage package) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data([...current, package]);
  }

  void updatePackage(BusinessPackage package) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((p) {
        if (p.id == package.id) return package;
        return p;
      }).toList(),
    );
  }

  void removePackage(String id) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(current.where((p) => p.id != id).toList());
  }

  void togglePackage(String id, bool active) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((p) {
        if (p.id == id) return p.copyWith(active: active);
        return p;
      }).toList(),
    );
  }
}
