import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════
// BlockedDate
// ═══════════════════════════════════════════════════════════════════

class BlockedDate {
  final String id;
  final String type; // 'specific' | 'range' | 'recurring'
  final String? date;
  final String? startDate;
  final String? endDate;
  final String? weekday;
  final String? reason;

  const BlockedDate({
    required this.id,
    required this.type,
    this.date,
    this.startDate,
    this.endDate,
    this.weekday,
    this.reason,
  });
}

// ═══════════════════════════════════════════════════════════════════
// Constants
// ═══════════════════════════════════════════════════════════════════

const weekdays = [
  (id: 'sat', label: 'السبت', short: 'سبت'),
  (id: 'sun', label: 'الأحد', short: 'أحد'),
  (id: 'mon', label: 'الاثنين', short: 'اثن'),
  (id: 'tue', label: 'الثلاثاء', short: 'ثلا'),
  (id: 'wed', label: 'الأربعاء', short: 'أرب'),
  (id: 'thu', label: 'الخميس', short: 'خمي'),
  (id: 'fri', label: 'الجمعة', short: 'جمع'),
];

const arabicMonths = [
  'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
  'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
];

const blockColors = <String, Color>{
  'specific': Color(0xFFE53935),
  'range': Color(0xFF7B1FA2),
  'recurring': Color(0xFFFF9800),
};

const blockBg = <String, Color>{
  'specific': Color(0xFFFFEBEE),
  'range': Color(0xFFF3E5F5),
  'recurring': Color(0xFFFFF3E0),
};

const blockIcons = <String, IconData>{
  'specific': Icons.event_busy,
  'range': Icons.date_range,
  'recurring': Icons.repeat,
};

const groupLabels = <String, String>{
  'recurring': 'حظر أسبوعي متكرر',
  'specific': 'أيام محددة',
  'range': 'فترات زمنية',
};

const formLabels = <String, String>{
  'specific': 'حظر يوم محدد',
  'range': 'حظر فترة زمنية',
  'recurring': 'حظر يوم أسبوعي',
};

const demoBlocks = <BlockedDate>[
  BlockedDate(
      id: 'b1', type: 'recurring', weekday: 'fri', reason: 'عطلة أسبوعية'),
  BlockedDate(
      id: 'b2', type: 'specific', date: '2026-03-15', reason: 'إجازة شخصية'),
  BlockedDate(
      id: 'b3',
      type: 'range',
      startDate: '2026-04-10',
      endDate: '2026-04-17',
      reason: 'إجازة عيد الفطر'),
];

// ═══════════════════════════════════════════════════════════════════
// Utilities
// ═══════════════════════════════════════════════════════════════════

String formatBlockDate(String dateStr) {
  if (dateStr.isEmpty) return '';
  try {
    final parts = dateStr.split('-');
    final d = int.parse(parts[2]);
    final m = int.parse(parts[1]) - 1;
    final y = parts[0];
    return '$d ${arabicMonths[m]} $y';
  } catch (_) {
    return dateStr;
  }
}

String formatIso(DateTime d) {
  return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

/// Map Dart weekday (1=Mon..7=Sun) to Saturday-first index (0=Sat..6=Fri)
int satFirstIndex(int dartWeekday) {
  const map = {6: 0, 7: 1, 1: 2, 2: 3, 3: 4, 4: 5, 5: 6};
  return map[dartWeekday]!;
}

/// Map weekday id to Dart weekday for recurring blocks
int weekdayIdToDart(String id) {
  const map = <String, int>{
    'sat': 6, 'sun': 7, 'mon': 1, 'tue': 2,
    'wed': 3, 'thu': 4, 'fri': 5,
  };
  return map[id] ?? 1;
}

/// Check if a day in a month is blocked by any block rule.
/// Returns the block type string or null.
String? isDateBlocked(int year, int month, int day, List<BlockedDate> blocks) {
  final date = DateTime(year, month, day);
  final dateStr =
      '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

  for (final block in blocks) {
    if (block.type == 'specific' && block.date == dateStr) return 'specific';
    if (block.type == 'range' &&
        block.startDate != null &&
        block.endDate != null) {
      if (dateStr.compareTo(block.startDate!) >= 0 &&
          dateStr.compareTo(block.endDate!) <= 0) {
        return 'range';
      }
    }
    if (block.type == 'recurring' && block.weekday != null) {
      if (date.weekday == weekdayIdToDart(block.weekday!)) {
        return 'recurring';
      }
    }
  }
  return null;
}
