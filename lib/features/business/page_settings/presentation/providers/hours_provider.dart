import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/page_settings/data/settings_repository.dart';
import 'package:honak/features/business/page_settings/domain/entities/business_hours.dart';

final _repo = SettingsRepository();

final hoursProvider =
    AsyncNotifierProvider<HoursNotifier, List<BusinessHours>>(() {
  return HoursNotifier();
});

final blockedDatesProvider =
    AsyncNotifierProvider<BlockedDatesNotifier, List<BlockedDate>>(() {
  return BlockedDatesNotifier();
});

class HoursNotifier extends AsyncNotifier<List<BusinessHours>> {
  @override
  Future<List<BusinessHours>> build() async {
    return _repo.getBusinessHours();
  }

  void toggleDay(String day, bool open) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((h) {
        if (h.day == day) return h.copyWith(open: open);
        return h;
      }).toList(),
    );
  }

  void addShift(String day, TimeShift shift) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((h) {
        if (h.day == day) {
          return h.copyWith(shifts: [...h.shifts, shift]);
        }
        return h;
      }).toList(),
    );
  }

  void removeShift(String day, int index) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((h) {
        if (h.day == day) {
          final shifts = List<TimeShift>.from(h.shifts);
          if (index < shifts.length) shifts.removeAt(index);
          return h.copyWith(shifts: shifts);
        }
        return h;
      }).toList(),
    );
  }

  void updateShift(String day, int index, TimeShift shift) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((h) {
        if (h.day == day) {
          final shifts = List<TimeShift>.from(h.shifts);
          if (index < shifts.length) shifts[index] = shift;
          return h.copyWith(shifts: shifts);
        }
        return h;
      }).toList(),
    );
  }
}

class BlockedDatesNotifier extends AsyncNotifier<List<BlockedDate>> {
  @override
  Future<List<BlockedDate>> build() async {
    return _repo.getBlockedDates();
  }

  void addBlockedDate(BlockedDate date) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data([...current, date]);
  }

  void removeBlockedDate(String dateStr) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.where((d) => d.date != dateStr).toList(),
    );
  }
}
