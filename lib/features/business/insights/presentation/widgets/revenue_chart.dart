import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/features/business/insights/domain/entities/insight_entities.dart';

/// Revenue area chart with gradient fill, optional subscription line, and legend.
class RevenueChart extends StatelessWidget {
  final RevenueChartData data;

  const RevenueChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: _buildChart(context),
          ),
          const SizedBox(height: 12),
          _Legend(data: data),
        ],
      ),
    );
  }

  Widget _buildChart(BuildContext context) {
    if (data.data.isEmpty) {
      return Center(
        child: Text(context.l10n.insightsNoData, style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
      );
    }

    final maxRevenue = data.data.map((d) => d.revenue).reduce(max);
    final hasSubscription = data.data.any((d) => d.subscriptionRevenue != null);
    final maxY = maxRevenue * 1.2;

    final revenueSpots = data.data.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.revenue);
    }).toList();

    final subscriptionSpots = hasSubscription
        ? data.data.asMap().entries.map((e) {
            return FlSpot(e.key.toDouble(), e.value.subscriptionRevenue ?? 0);
          }).toList()
        : <FlSpot>[];

    return Directionality(
      textDirection: Directionality.of(context),
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: maxY == 0 ? 10 : maxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY > 0 ? maxY / 4 : 2.5,
            getDrawingHorizontalLine: (_) => FlLine(
              color: const Color(0xFFF3F4F6),
              strokeWidth: 1,
              dashArray: [5, 5],
            ),
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final idx = value.toInt();
                  if (idx < 0 || idx >= data.data.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      data.data[idx].label,
                      style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  if (value == meta.min || value == meta.max) {
                    return const SizedBox.shrink();
                  }
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => Colors.white,
              tooltipBorder: const BorderSide(color: Color(0xFFE5E7EB)),
              tooltipRoundedRadius: 12,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final idx = spot.spotIndex;
                  final point = data.data[idx];
                  final isRevenue = spot.barIndex == 0;
                  return LineTooltipItem(
                    isRevenue
                        ? '${data.summaryLabel}: ${point.revenue.toStringAsFixed(0)} ${context.l10n.insightsCurrencyJod}'
                        : '${data.ordersTooltip}: ${point.subscriptionRevenue?.toStringAsFixed(0) ?? ''}',
                    TextStyle(
                      fontSize: 11,
                      color: isRevenue
                          ? const Color(0xFF1A73E8)
                          : const Color(0xFF43A047),
                    ),
                    textDirection: Directionality.of(context),
                  );
                }).toList();
              },
            ),
          ),
          lineBarsData: [
            // Revenue line
            LineChartBarData(
              spots: revenueSpots,
              isCurved: true,
              color: const Color(0xFF1A73E8),
              barWidth: 2,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                  radius: 3,
                  color: const Color(0xFF1A73E8),
                  strokeWidth: 0,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x261A73E8), Color(0x001A73E8)],
                ),
              ),
            ),
            // Subscription line (if data exists)
            if (hasSubscription)
              LineChartBarData(
                spots: subscriptionSpots,
                isCurved: true,
                color: const Color(0xFF43A047),
                barWidth: 2,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                    radius: 3,
                    color: const Color(0xFF43A047),
                    strokeWidth: 0,
                  ),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x2643A047), Color(0x0043A047)],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final RevenueChartData data;

  const _Legend({required this.data});

  @override
  Widget build(BuildContext context) {
    final hasSubscription = data.data.any((d) => d.subscriptionRevenue != null);

    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFF9FAFB))),
      ),
      child: Row(
        children: [
          // Comparison text (right side in RTL)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                data.comparisonTrend == TrendDirection.up
                    ? Icons.arrow_outward
                    : Icons.south_east,
                size: 10,
                color: data.comparisonTrend == TrendDirection.up
                    ? const Color(0xFF43A047)
                    : const Color(0xFFE53935),
              ),
              const SizedBox(width: 2),
              Text(
                data.comparison,
                style: TextStyle(
                  fontSize: 10,
                  color: data.comparisonTrend == TrendDirection.up
                      ? const Color(0xFF43A047)
                      : const Color(0xFFE53935),
                ),
              ),
            ],
          ),
          const Spacer(),
          // Legend dots (left side in RTL)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LegendDot(color: const Color(0xFF1A73E8), label: data.summaryLabel),
              if (hasSubscription) ...[
                const SizedBox(width: 12),
                _LegendDot(color: const Color(0xFF43A047), label: context.l10n.insightsSubscriptions),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280))),
      ],
    );
  }
}
