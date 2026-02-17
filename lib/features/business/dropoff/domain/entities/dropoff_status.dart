import 'package:flutter/widgets.dart';

import 'package:honak/core/l10n/arb/app_localizations.dart';

enum DropoffStatus {
  received,
  processing,
  ready,
  delivered,
  cancelled;

  String get labelAr => switch (this) {
        received => 'تم الاستلام',
        processing => 'قيد المعالجة',
        ready => 'جاهز للاستلام',
        delivered => 'تم التسليم',
        cancelled => 'ملغي',
      };

  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (this) {
      received => l10n.dropoffStatusReceived,
      processing => l10n.dropoffStatusProcessing,
      ready => l10n.dropoffStatusReady,
      delivered => l10n.dropoffStatusDelivered,
      cancelled => l10n.dropoffStatusCancelled,
    };
  }
}
