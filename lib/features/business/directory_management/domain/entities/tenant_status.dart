import 'package:flutter/material.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';

enum TenantStatus {
  claimed,
  newTenant,
  invited,
  unclaimed;

  String localizedLabel(AppLocalizations l10n) {
    return switch (this) {
      TenantStatus.claimed => l10n.dirStatusClaimed,
      TenantStatus.newTenant => l10n.dirStatusNew,
      TenantStatus.invited => l10n.dirStatusInvited,
      TenantStatus.unclaimed => l10n.dirStatusUnclaimed,
    };
  }

  Color get color {
    return switch (this) {
      TenantStatus.claimed => const Color(0xFF16A34A),
      TenantStatus.newTenant => const Color(0xFF2563EB),
      TenantStatus.invited => const Color(0xFFF59E0B),
      TenantStatus.unclaimed => const Color(0xFF9CA3AF),
    };
  }

  IconData get icon {
    return switch (this) {
      TenantStatus.claimed => Icons.link,
      TenantStatus.newTenant => Icons.fiber_new,
      TenantStatus.invited => Icons.mail_outline,
      TenantStatus.unclaimed => Icons.link_off,
    };
  }
}
