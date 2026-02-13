import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/page_settings/data/settings_repository.dart';
import 'package:honak/features/business/page_settings/domain/entities/page_settings.dart';

final _repo = SettingsRepository();

final pageSettingsProvider =
    AsyncNotifierProvider<PageSettingsNotifier, PageSettings>(() {
  return PageSettingsNotifier();
});

class PageSettingsNotifier extends AsyncNotifier<PageSettings> {
  @override
  Future<PageSettings> build() async {
    return _repo.getPageSettings();
  }

  void updatePageStatus(String status, {String? reason, String? message}) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(
      status: status,
      closeReason: reason,
      tempClosedMessage: message,
    ));
  }

  void updateEngagement(String level) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(engagementLevel: level));
  }

  void updateOrderApproval(String mode) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(orderApproval: mode));
  }

  void updateReturnPolicy({
    int? windowDays,
    String? returnType,
    String? returnCost,
  }) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(
      returnWindowDays: windowDays ?? current.returnWindowDays,
      returnType: returnType ?? current.returnType,
      returnCost: returnCost ?? current.returnCost,
    ));
  }

  void updateCancellationPolicy({
    int? windowHours,
    String? noShowAction,
    String? feeType,
    int? feeAmount,
  }) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(
      cancelWindowHours: windowHours ?? current.cancelWindowHours,
      noShowAction: noShowAction ?? current.noShowAction,
      lateCancelFeeType: feeType ?? current.lateCancelFeeType,
      lateCancelFeeAmount: feeAmount ?? current.lateCancelFeeAmount,
    ));
  }

  void updateCatalogStrategy(String strategy) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(
      catalogStrategy: strategy,
      highlightCategories:
          strategy == 'full_catalog' ? [] : current.highlightCategories,
    ));
  }

  void updateHighlightCategories(List<String> categories) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
        current.copyWith(highlightCategories: categories));
  }

  void toggleDisclaimer(String id, bool isActive) {
    final current = state.valueOrNull;
    if (current == null) return;
    final updated = current.disclaimers.map((d) {
      if (d.id == id) return d.copyWith(isActive: isActive);
      return d;
    }).toList();
    state = AsyncValue.data(current.copyWith(disclaimers: updated));
  }

  void addDisclaimer(SafetyDisclaimer disclaimer) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.copyWith(disclaimers: [...current.disclaimers, disclaimer]),
    );
  }

  void removeDisclaimer(String id) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.copyWith(
        disclaimers: current.disclaimers.where((d) => d.id != id).toList(),
      ),
    );
  }

  void updateDisclaimerText(String id, String text) {
    final current = state.valueOrNull;
    if (current == null) return;
    final updated = current.disclaimers.map((d) {
      if (d.id == id) return d.copyWith(text: text);
      return d;
    }).toList();
    state = AsyncValue.data(current.copyWith(disclaimers: updated));
  }

  void updateDisclaimerTitle(String id, String title) {
    final current = state.valueOrNull;
    if (current == null) return;
    final updated = current.disclaimers.map((d) {
      if (d.id == id) return d.copyWith(title: title);
      return d;
    }).toList();
    state = AsyncValue.data(current.copyWith(disclaimers: updated));
  }

  void togglePostBookingStep(String id, bool isActive) {
    final current = state.valueOrNull;
    if (current == null) return;
    final updated = current.postBookingSteps.map((s) {
      if (s.id == id) return s.copyWith(isActive: isActive);
      return s;
    }).toList();
    state = AsyncValue.data(current.copyWith(postBookingSteps: updated));
  }

  void addPostBookingStep(PostBookingStep step) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.copyWith(
        postBookingSteps: [...current.postBookingSteps, step],
      ),
    );
  }

  void removePostBookingStep(String id) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.copyWith(
        postBookingSteps:
            current.postBookingSteps.where((s) => s.id != id).toList(),
      ),
    );
  }

  void reorderPostBookingSteps(List<PostBookingStep> reordered) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.copyWith(postBookingSteps: reordered),
    );
  }
}
