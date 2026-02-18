import 'package:flutter/material.dart';
import 'package:honak/features/pages/domain/entities/trust_metric.dart';
import 'package:honak/shared/widgets/app_trust_metrics_row.dart';

/// Backward-compatible wrapper for page header usage.
class TrustMetricsRow extends StatelessWidget {
  final List<TrustMetric> metrics;
  final int trustScore;

  const TrustMetricsRow({
    super.key,
    required this.metrics,
    required this.trustScore,
  });

  @override
  Widget build(BuildContext context) {
    return AppTrustMetricsRow(metrics: metrics);
  }
}
