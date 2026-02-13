import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/page_settings/data/settings_repository.dart';
import 'package:honak/features/business/page_settings/domain/entities/team_member.dart';
import 'package:honak/shared/providers/business_page_provider.dart';

final _repo = SettingsRepository();

final teamProvider =
    AsyncNotifierProvider<TeamNotifier, List<TeamMember>>(() {
  return TeamNotifier();
});

class TeamNotifier extends AsyncNotifier<List<TeamMember>> {
  @override
  Future<List<TeamMember>> build() async {
    final bizContext = ref.watch(businessContextProvider);
    final pageType = bizContext?.config?.id;
    return _repo.getTeamMembers(pageType: pageType);
  }

  void addMember(TeamMember member) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data([...current, member]);
  }

  void removeMember(String id) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(current.where((m) => m.id != id).toList());
  }

  void toggleMember(String id, bool active) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((m) {
        if (m.id == id) return m.copyWith(active: active);
        return m;
      }).toList(),
    );
  }

  void updatePermissions(String id, List<String> permissions) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((m) {
        if (m.id == id) return m.copyWith(permissions: permissions);
        return m;
      }).toList(),
    );
  }

  void updateRole(String id, String role) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((m) {
        if (m.id == id) return m.copyWith(role: role);
        return m;
      }).toList(),
    );
  }

  void updateLocationIds(String id, List<String> locationIds) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((m) {
        if (m.id == id) return m.copyWith(locationIds: locationIds);
        return m;
      }).toList(),
    );
  }

  void updateServiceIds(String id, List<String> serviceIds) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((m) {
        if (m.id == id) return m.copyWith(serviceIds: serviceIds);
        return m;
      }).toList(),
    );
  }
}
