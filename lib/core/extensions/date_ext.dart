import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DateExt on DateTime {
  String toRelative({String locale = 'ar'}) {
    return timeago.format(this, locale: locale);
  }

  String toFormatted({String locale = 'ar'}) {
    final pattern = locale == 'ar' ? 'dd MMMM yyyy' : 'MMMM dd, yyyy';
    return DateFormat(pattern, locale).format(this);
  }

  String toTimeString() {
    return DateFormat('HH:mm').format(this);
  }

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    return isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
        isBefore(endOfWeek);
  }
}
