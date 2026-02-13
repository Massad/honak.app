import 'package:equatable/equatable.dart';

class Money extends Equatable {
  final int cents;

  const Money(this.cents);

  const Money.zero() : cents = 0;

  factory Money.fromJod(double jod) => Money((jod * 100).round());

  double get jod => cents / 100;

  bool get isFree => cents == 0;

  String toJodString() {
    final value = jod;
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
  }

  String toFormattedArabic() {
    if (isFree) return 'مجاناً';
    return '${toJodString()} د.أ';
  }

  String toFormattedEnglish() {
    if (isFree) return 'Free';
    return '${toJodString()} JOD';
  }

  String toFormatted({String locale = 'ar'}) {
    return locale == 'ar' ? toFormattedArabic() : toFormattedEnglish();
  }

  Money operator +(Money other) => Money(cents + other.cents);
  Money operator -(Money other) => Money(cents - other.cents);
  Money operator *(int multiplier) => Money(cents * multiplier);

  @override
  List<Object?> get props => [cents];
}
