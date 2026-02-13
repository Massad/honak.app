import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/features/subscriptions/domain/entities/subscription_enums.dart';

part 'credit_history_entry.freezed.dart';
part 'credit_history_entry.g.dart';

@freezed
class CreditHistoryEntry with _$CreditHistoryEntry {
  const factory CreditHistoryEntry({
    required String date,
    required CreditHistoryType type,
    @Default(0) int amount,
    String? note,
  }) = _CreditHistoryEntry;

  factory CreditHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$CreditHistoryEntryFromJson(json);
}
