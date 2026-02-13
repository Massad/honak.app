import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/shared/entities/money.dart';

class MoneyConverter implements JsonConverter<Money, int> {
  const MoneyConverter();

  @override
  Money fromJson(int json) => Money(json);

  @override
  int toJson(Money object) => object.cents;
}

class MoneyNullableConverter implements JsonConverter<Money?, int?> {
  const MoneyNullableConverter();

  @override
  Money? fromJson(int? json) => json != null ? Money(json) : null;

  @override
  int? toJson(Money? object) => object?.cents;
}
