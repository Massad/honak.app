import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/page_settings/data/settings_repository.dart';
import 'package:honak/features/business/page_settings/domain/entities/coverage_zone.dart';

final _repo = SettingsRepository();

typedef CoverageState = ({int defaultFee, List<CoverageZone> zones});

final coverageProvider =
    AsyncNotifierProvider<CoverageNotifier, CoverageState>(() {
  return CoverageNotifier();
});

class CoverageNotifier extends AsyncNotifier<CoverageState> {
  @override
  Future<CoverageState> build() async {
    return _repo.getCoverageZones();
  }

  void toggleZone(String id) {
    final current = state.valueOrNull;
    if (current == null) return;
    final updated = current.zones.map((z) {
      if (z.id == id) return z.copyWith(active: !z.active);
      return z;
    }).toList();
    state = AsyncValue.data((defaultFee: current.defaultFee, zones: updated));
  }

  void updateZoneFee(String id, int? fee) {
    final current = state.valueOrNull;
    if (current == null) return;
    final updated = current.zones.map((z) {
      if (z.id == id) return z.copyWith(deliveryFee: fee);
      return z;
    }).toList();
    state = AsyncValue.data((defaultFee: current.defaultFee, zones: updated));
  }

  void updateDefaultFee(int fee) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data((defaultFee: fee, zones: current.zones));
  }
}
