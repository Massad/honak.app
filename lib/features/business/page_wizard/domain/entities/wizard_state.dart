import 'package:freezed_annotation/freezed_annotation.dart';

part 'wizard_state.freezed.dart';

@freezed
class WizardState with _$WizardState {
  const factory WizardState({
    @Default(1) int step, // 1-6, 7 = done
    // Step 1: Business Type
    String? selectedTypeId,
    String? selectedTypeName,
    String? selectedArchetype,
    // Step 2: Handle
    @Default('') String handle,
    @Default(false) bool handleAvailable,
    @Default(false) bool handleChecking,
    // Step 3: Page Info
    @Default('') String pageName,
    @Default('') String description,
    @Default('') String phone,
    // Step 4: Location
    @Default('') String address,
    @Default(false) bool isOnlineOnly,
    // Step 5: Hours
    @Default('weekdays') String hoursPreset, // weekdays | 247 | custom
    @Default('') String customHours,
    // Step 6: Payment
    @Default({0}) Set<int> selectedPayments, // 0=cash, 1=cliq, 2=bank, 3=wallet
    @Default('') String cliqAlias,
  }) = _WizardState;
}
