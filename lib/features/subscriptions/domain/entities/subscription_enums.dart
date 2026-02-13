import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'value')
enum SubscriptionModel {
  @JsonValue('visits_and_date')
  visitsAndDate('visits_and_date'),
  @JsonValue('visits_only')
  visitsOnly('visits_only'),
  @JsonValue('date_only')
  dateOnly('date_only'),
  @JsonValue('bundle')
  bundle('bundle');

  const SubscriptionModel(this.value);
  final String value;
}

@JsonEnum(valueField: 'value')
enum SubscriptionStatus {
  @JsonValue('active')
  active('active'),
  @JsonValue('paused')
  paused('paused'),
  @JsonValue('depleted')
  depleted('depleted'),
  @JsonValue('expired')
  expired('expired'),
  @JsonValue('cancelled')
  cancelled('cancelled');

  const SubscriptionStatus(this.value);
  final String value;
}

@JsonEnum(valueField: 'value')
enum CreditHistoryType {
  @JsonValue('purchase')
  purchase('purchase'),
  @JsonValue('auto_deduct')
  autoDeduct('auto_deduct'),
  @JsonValue('adjustment')
  adjustment('adjustment'),
  @JsonValue('expired')
  expired('expired'),
  @JsonValue('pause')
  pause('pause'),
  @JsonValue('resume')
  resume('resume'),
  @JsonValue('cancel')
  cancel('cancel');

  const CreditHistoryType(this.value);
  final String value;
}
