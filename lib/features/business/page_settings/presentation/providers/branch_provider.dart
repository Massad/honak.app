import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/page_settings/data/settings_repository.dart';
import 'package:honak/features/business/page_settings/domain/entities/branch.dart';

final _repo = SettingsRepository();

final branchProvider =
    AsyncNotifierProvider<BranchNotifier, List<Branch>>(() {
  return BranchNotifier();
});

class BranchNotifier extends AsyncNotifier<List<Branch>> {
  @override
  Future<List<Branch>> build() async {
    return _repo.getBranches();
  }

  void addBranch(Branch branch) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data([...current, branch]);
  }

  void removeBranch(String id) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(current.where((b) => b.id != id).toList());
  }

  void updateBranch(Branch updated) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((b) {
        if (b.id == updated.id) return updated;
        return b;
      }).toList(),
    );
  }

  void toggleBranchStatus(String id, String status) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((b) {
        if (b.id == id) return b.copyWith(status: status, active: status == 'active');
        return b;
      }).toList(),
    );
  }
}
