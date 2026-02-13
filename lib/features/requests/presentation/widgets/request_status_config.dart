import 'package:flutter/material.dart';

/// Status badge styling config.
class StatusStyle {
  final String label;
  final Color foreground;
  final Color background;

  const StatusStyle(this.label, this.foreground, this.background);
}

const requestStatusStyles = <String, StatusStyle>{
  'pending': StatusStyle(
    'بانتظار الرد',
    Color(0xFFB7791F),
    Color(0xFFFEFCBF),
  ),
  'pending_review': StatusStyle(
    'بانتظار الموافقة',
    Color(0xFFB7791F),
    Color(0xFFFEFCBF),
  ),
  'accepted': StatusStyle(
    'تم القبول',
    Color(0xFF276749),
    Color(0xFFC6F6D5),
  ),
  'in_progress': StatusStyle(
    'قيد التنفيذ',
    Color(0xFF2B6CB0),
    Color(0xFFBEE3F8),
  ),
  'preparing': StatusStyle(
    'قيد التحضير',
    Color(0xFF2B6CB0),
    Color(0xFFBEE3F8),
  ),
  'completed': StatusStyle(
    'مكتمل',
    Color(0xFF718096),
    Color(0xFFEDF2F7),
  ),
  'delivered': StatusStyle(
    'تم التوصيل',
    Color(0xFF276749),
    Color(0xFFC6F6D5),
  ),
  'declined': StatusStyle(
    'مرفوض',
    Color(0xFFC53030),
    Color(0xFFFED7D7),
  ),
  'cancelled_by_customer': StatusStyle(
    'ملغي',
    Color(0xFFC53030),
    Color(0xFFFED7D7),
  ),
  'cancelled_by_business': StatusStyle(
    'ملغي من المتجر',
    Color(0xFFC53030),
    Color(0xFFFED7D7),
  ),
  'suggested': StatusStyle(
    'بديل مقترح',
    Color(0xFF6B46C1),
    Color(0xFFE9D8FD),
  ),
  'modification_requested': StatusStyle(
    'طلب تعديل',
    Color(0xFFB7791F),
    Color(0xFFFEFCBF),
  ),
  'alternative_offered': StatusStyle(
    'عرض بديل',
    Color(0xFF6B46C1),
    Color(0xFFE9D8FD),
  ),
  'rescheduled': StatusStyle(
    'تم التأجيل',
    Color(0xFF2B6CB0),
    Color(0xFFBEE3F8),
  ),
  'pending_reschedule': StatusStyle(
    'طلب تأجيل',
    Color(0xFFB7791F),
    Color(0xFFFEFCBF),
  ),
};

const requestTypeIcons = <String, IconData>{
  'order': Icons.shopping_bag_outlined,
  'booking': Icons.content_cut_outlined,
  'quote': Icons.build_outlined,
  'inquiry': Icons.camera_alt_outlined,
  'reservation': Icons.calendar_today_outlined,
};

const requestTypeLabels = <String, String>{
  'order': '\u0637\u0644\u0628 \u0634\u0631\u0627\u0621',
  'booking': '\u062d\u062c\u0632 \u062e\u062f\u0645\u0629',
  'quote': '\u0637\u0644\u0628 \u0645\u0639\u0627\u064a\u0646\u0629',
  'inquiry': '\u0627\u0633\u062a\u0641\u0633\u0627\u0631',
  'reservation': '\u062d\u062c\u0632',
};
