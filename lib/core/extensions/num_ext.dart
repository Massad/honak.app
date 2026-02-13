import 'package:intl/intl.dart';

extension NumExt on num {
  String toJod() {
    final jod = this / 100;
    return jod.toStringAsFixed(2);
  }

  String toJodFormatted({String locale = 'ar'}) {
    final jod = this / 100;
    if (locale == 'ar') {
      final formatter = NumberFormat('#,##0.00', 'ar');
      return '${formatter.format(jod)} \u062f.\u0623';
    }
    final formatter = NumberFormat('#,##0.00', 'en');
    return '${formatter.format(jod)} JOD';
  }
}
