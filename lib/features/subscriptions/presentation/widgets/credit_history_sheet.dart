import 'package:flutter/material.dart';
import 'package:honak/features/subscriptions/domain/entities/entities.dart';
import 'package:honak/shared/widgets/credit_history_sheet.dart' as shared;

/// Opens the unified [shared.CreditHistorySheet] for a [Subscription].
///
/// Converts the subscription's freezed [CreditHistoryEntry] objects
/// to the shared widget's simple entry model.
void showCreditHistorySheet(
  BuildContext context,
  Subscription subscription,
) {
  final entries = subscription.history
      .map((e) => shared.CreditHistoryEntry(
            date: DateTime.parse(e.date),
            description: e.note ?? _defaultLabel(e.type),
            amount: e.type == CreditHistoryType.purchase
                ? e.amount.abs()
                : e.type == CreditHistoryType.autoDeduct
                    ? -e.amount.abs()
                    : e.amount,
          ))
      .toList();

  shared.CreditHistorySheet.show(
    context,
    packageName: subscription.packageName,
    pageName: subscription.pageName,
    creditLabel: subscription.creditLabel ?? '\u0631\u0635\u064a\u062f',
    entries: entries,
    startsAt: DateTime.tryParse(subscription.startsAt),
    expiresAt: subscription.expiresAt != null
        ? DateTime.tryParse(subscription.expiresAt!)
        : null,
    remainingCredits: subscription.remainingCredits,
    totalCredits: subscription.totalCredits,
  );
}

String _defaultLabel(CreditHistoryType type) {
  switch (type) {
    case CreditHistoryType.purchase:
      return '\u0634\u0631\u0627\u0621 \u0631\u0635\u064a\u062f';
    case CreditHistoryType.autoDeduct:
      return '\u062e\u0635\u0645 \u062a\u0644\u0642\u0627\u0626\u064a';
    case CreditHistoryType.adjustment:
      return '\u062a\u0639\u062f\u064a\u0644';
    case CreditHistoryType.expired:
      return '\u0627\u0646\u062a\u0647\u0627\u0621 \u0635\u0644\u0627\u062d\u064a\u0629';
    case CreditHistoryType.pause:
      return '\u0625\u064a\u0642\u0627\u0641 \u0645\u0624\u0642\u062a';
    case CreditHistoryType.resume:
      return '\u0627\u0633\u062a\u0626\u0646\u0627\u0641';
    case CreditHistoryType.cancel:
      return '\u0625\u0644\u063a\u0627\u0621';
  }
}
