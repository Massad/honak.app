import 'package:flutter/material.dart';

enum TenantStatus {
  claimed,
  newTenant,
  invited,
  unclaimed;

  String get label {
    return switch (this) {
      TenantStatus.claimed => 'مربوط',
      TenantStatus.newTenant => 'جديد',
      TenantStatus.invited => 'مدعو',
      TenantStatus.unclaimed => 'غير مربوط',
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
