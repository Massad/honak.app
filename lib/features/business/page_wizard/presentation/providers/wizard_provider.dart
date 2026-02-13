import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/page_wizard/domain/entities/wizard_state.dart';
import 'package:honak/shared/providers/api_provider.dart';

final wizardProvider =
    NotifierProvider<WizardNotifier, WizardState>(WizardNotifier.new);

class WizardNotifier extends Notifier<WizardState> {
  Timer? _handleDebounce;

  @override
  WizardState build() => const WizardState();

  // ── Navigation ──────────────────────────────────────────────────────

  void nextStep() {
    if (!canProceed) return;
    state = state.copyWith(step: state.step + 1);
  }

  void prevStep() {
    if (state.step > 1) {
      state = state.copyWith(step: state.step - 1);
    }
  }

  void goToStep(int step) {
    if (step >= 1 && step <= 7) {
      state = state.copyWith(step: step);
    }
  }

  // ── Step 1: Business Type ───────────────────────────────────────────

  void selectType(String id, String name, String archetype) {
    state = state.copyWith(
      selectedTypeId: id,
      selectedTypeName: name,
      selectedArchetype: archetype,
    );
  }

  // ── Step 2: Handle ──────────────────────────────────────────────────

  void setHandle(String value) {
    final cleaned = value.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9_-]'), '');
    state = state.copyWith(
      handle: cleaned,
      handleAvailable: false,
      handleChecking: false,
    );
    _handleDebounce?.cancel();
    if (cleaned.length >= 3) {
      state = state.copyWith(handleChecking: true);
      _handleDebounce = Timer(const Duration(milliseconds: 600), () {
        _checkHandleAvailability(cleaned);
      });
    }
  }

  Future<void> _checkHandleAvailability(String handle) async {
    try {
      final api = ref.read(apiClientProvider);
      final response = await api.get<Map<String, dynamic>>(
        '/v1/wizard/handle-check',
        queryParams: {'handle': handle},
        fromJson: (json) => json as Map<String, dynamic>,
      );
      if (state.handle != handle) return; // stale
      final available = response.data?['available'] == true;
      state = state.copyWith(
        handleAvailable: available,
        handleChecking: false,
      );
    } catch (_) {
      if (state.handle == handle) {
        state = state.copyWith(handleChecking: false, handleAvailable: false);
      }
    }
  }

  // ── Step 3: Page Info ───────────────────────────────────────────────

  void setPageName(String value) {
    state = state.copyWith(pageName: value);
  }

  void setDescription(String value) {
    state = state.copyWith(description: value);
  }

  void setPhone(String value) {
    state = state.copyWith(phone: value);
  }

  // ── Step 4: Location ────────────────────────────────────────────────

  void setAddress(String value) {
    state = state.copyWith(address: value, isOnlineOnly: false);
  }

  void setOnlineOnly(bool value) {
    state = state.copyWith(isOnlineOnly: value, address: value ? '' : state.address);
  }

  // ── Step 5: Hours ───────────────────────────────────────────────────

  void setHoursPreset(String value) {
    state = state.copyWith(hoursPreset: value);
  }

  void setCustomHours(String value) {
    state = state.copyWith(customHours: value);
  }

  // ── Step 6: Payment ─────────────────────────────────────────────────

  void togglePayment(int index) {
    final current = Set<int>.from(state.selectedPayments);
    if (current.contains(index)) {
      current.remove(index);
    } else {
      current.add(index);
    }
    state = state.copyWith(selectedPayments: current);
  }

  void setCliqAlias(String value) {
    state = state.copyWith(cliqAlias: value);
  }

  // ── Validation ──────────────────────────────────────────────────────

  bool get canProceed {
    switch (state.step) {
      case 1:
        return state.selectedTypeId != null;
      case 2:
        return state.handle.length >= 3 &&
            state.handleAvailable &&
            !state.handleChecking;
      case 3:
        return state.pageName.trim().isNotEmpty;
      case 4:
        return state.isOnlineOnly || state.address.trim().isNotEmpty;
      case 5:
        if (state.hoursPreset == 'custom') {
          return state.customHours.trim().isNotEmpty;
        }
        return true;
      case 6:
        return state.selectedPayments.isNotEmpty;
      default:
        return false;
    }
  }

  // ── Submit ──────────────────────────────────────────────────────────

  Future<void> submit() async {
    // In Phase 1, no real API call — just transition to done screen
    state = state.copyWith(step: 7);
  }
}
