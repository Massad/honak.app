import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:honak/features/business/insights/domain/entities/insight_entities.dart';

/// Distribution donut chart with side legend.
class DistributionChart extends StatelessWidget {
  final DistributionData data;

  const DistributionChart({super.key, required this.data});

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
          if (data.segments.isEmpty)
            const _EmptyState()
          else
            Row(
              children: [
                // Legend (flex-1, right side in RTL)
                Expanded(child: _Legend(segments: data.segments)),
                const SizedBox(width: 16),
                // Donut chart (left side in RTL)
                SizedBox(
                  width: 120,
                  height: 120,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 3,
                      centerSpaceRadius: 30,
                      sections: data.segments.map((s) {
                        return PieChartSectionData(
                          value: s.value.toDouble(),
                          color: s.color,
                          radius: 25,
                          showTitle: false,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final List<DistributionDataPoint> segments;

  const _Legend({required this.segments});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: segments.map((s) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: s.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  s.name,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563)),
                ),
              ),
              Text(
                '${s.value}٪',
                style: const TextStyle(fontSize: 12, color: Color(0xFF111827)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.pie_chart_outline, size: 32, color: Color(0xFFD1D5DB)),
            SizedBox(height: 8),
            Text(
              'لا توجد بيانات كافية',
              style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ),
    );
  }
}
