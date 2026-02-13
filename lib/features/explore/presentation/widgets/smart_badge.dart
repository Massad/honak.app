import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/features/explore/domain/entities/page_summary.dart';

class SmartBadgeInfo {
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;

  const SmartBadgeInfo({
    required this.text,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
  });
}

/// Returns the primary badge for a page based on archetype and engagement level.
SmartBadgeInfo? getPrimaryBadge(PageSummary page) {
  // 1. Follow-only archetype
  if (page.archetype == 'follow_only') {
    return const SmartBadgeInfo(
      text: 'حساب رسمي',
      icon: Icons.account_balance,
      backgroundColor: Color(0xFFE3F2FD),
      textColor: Color(0xFF1A73E8),
    );
  }

  // 2. Directory archetype
  if (page.archetype == 'directory') {
    return const SmartBadgeInfo(
      text: 'دليل تجاري',
      icon: Icons.account_balance,
      backgroundColor: Color(0xFFE3F2FD),
      textColor: Color(0xFF1A73E8),
    );
  }

  // 3. Showcase engagement
  if (page.engagementLevel == 'showcase') {
    return const SmartBadgeInfo(
      text: 'تصفح فقط',
      icon: Icons.visibility_outlined,
      backgroundColor: Color(0xFFF5F5F5),
      textColor: Color(0xFF9E9E9E),
    );
  }

  // 4. Visibility engagement — no badge
  if (page.engagementLevel == 'visibility') {
    return null;
  }

  // 5. Full engagement — archetype-specific
  if (page.engagementLevel == 'full') {
    switch (page.archetype) {
      case 'catalog_order':
      case 'menu_order':
        return const SmartBadgeInfo(
          text: 'اطلب أونلاين',
          icon: Icons.shopping_cart_outlined,
          backgroundColor: Color(0xFFE8F5E9),
          textColor: Color(0xFF43A047),
        );
      case 'service_booking':
        return const SmartBadgeInfo(
          text: 'احجز أونلاين',
          icon: Icons.calendar_today_outlined,
          backgroundColor: Color(0xFFE8F5E9),
          textColor: Color(0xFF43A047),
        );
      case 'quote_request':
        return const SmartBadgeInfo(
          text: 'اطلب معاينة',
          icon: Icons.message_outlined,
          backgroundColor: Color(0xFFE8F5E9),
          textColor: Color(0xFF43A047),
        );
      case 'portfolio_inquiry':
        return const SmartBadgeInfo(
          text: 'استفسر الآن',
          icon: Icons.camera_alt_outlined,
          backgroundColor: Color(0xFFE8F5E9),
          textColor: Color(0xFF43A047),
        );
      case 'reservation':
        return const SmartBadgeInfo(
          text: 'احجز الآن',
          icon: Icons.home_outlined,
          backgroundColor: Color(0xFFE8F5E9),
          textColor: Color(0xFF43A047),
        );
    }
  }

  return null;
}

/// Returns the secondary badge for a page based on store/return attributes.
SmartBadgeInfo? getSecondaryBadge(PageSummary page) {
  // 1. Accepts returns
  if (page.acceptsReturns) {
    return const SmartBadgeInfo(
      text: 'يقبل الإرجاع',
      icon: Icons.undo,
      backgroundColor: Color(0xFFFFF8E1),
      textColor: Color(0xFFFF8F00),
    );
  }

  // 2. Hybrid store
  if (page.storeType == 'hybrid') {
    return const SmartBadgeInfo(
      text: 'محل + توصيل',
      icon: Icons.local_shipping_outlined,
      backgroundColor: Color(0xFFE8EAF6),
      textColor: Color(0xFF3F51B5),
    );
  }

  // 3. Online only
  if (page.storeType == 'online') {
    return const SmartBadgeInfo(
      text: 'أونلاين فقط',
      icon: Icons.language,
      backgroundColor: Color(0xFFF3E5F5),
      textColor: Color(0xFF7B1FA2),
    );
  }

  return null;
}

/// A small rounded pill chip displaying a [SmartBadgeInfo].
class BadgeChip extends StatelessWidget {
  final SmartBadgeInfo badge;

  const BadgeChip({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: badge.backgroundColor,
        borderRadius: AppRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badge.icon, size: 10, color: badge.textColor),
          const SizedBox(width: 2),
          Text(
            badge.text,
            style: TextStyle(
              fontSize: 10,
              color: badge.textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
