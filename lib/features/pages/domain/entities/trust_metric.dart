import 'package:freezed_annotation/freezed_annotation.dart';

part 'trust_metric.freezed.dart';
part 'trust_metric.g.dart';

@freezed
class TrustMetric with _$TrustMetric {
  const factory TrustMetric({
    required String label,
    required String value,
    String? icon,
  }) = _TrustMetric;

  factory TrustMetric.fromJson(Map<String, dynamic> json) =>
      _$TrustMetricFromJson(json);
}
