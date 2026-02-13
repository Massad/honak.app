import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/page_settings/data/settings_repository.dart';
import 'package:honak/features/business/page_settings/domain/entities/intake_question.dart';

final _repo = SettingsRepository();

final intakeQuestionsProvider = AsyncNotifierProvider.family<
    IntakeQuestionsNotifier, List<IntakeQuestion>, String>(() {
  return IntakeQuestionsNotifier();
});

class IntakeQuestionsNotifier
    extends FamilyAsyncNotifier<List<IntakeQuestion>, String> {
  @override
  Future<List<IntakeQuestion>> build(String arg) async {
    return _repo.getIntakeQuestions(type: arg);
  }

  void addQuestion(IntakeQuestion question) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data([...current, question]);
  }

  void updateQuestion(IntakeQuestion question) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((q) {
        if (q.id == question.id) return question;
        return q;
      }).toList(),
    );
  }

  void removeQuestion(String id) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(current.where((q) => q.id != id).toList());
  }

  void reorderQuestions(List<IntakeQuestion> reordered) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(reordered);
  }

  void toggleQuestion(String id, bool active) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((q) {
        if (q.id == id) return q.copyWith(active: active);
        return q;
      }).toList(),
    );
  }
}
