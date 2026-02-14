import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/dashboard/presentation/widgets/sections/core_sections.dart';

// ═══════════════════════════════════════════════════════════════
// Today's Schedule — timeline list
// ═══════════════════════════════════════════════════════════════

class TodayScheduleSection extends StatelessWidget {
  final List<dynamic> items;
  const TodayScheduleSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      children: items.map((item) {
        final m = item as Map<String, dynamic>;
        final status = m['status'] as String? ?? '';
        final isCompleted = status == 'completed';
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Icon(
                isCompleted ? Icons.check_circle : Icons.access_time,
                size: 16,
                color: isCompleted ? AppColors.success : AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                m['time'] as String? ?? '',
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                m['service'] as String? ?? '',
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  m['customer'] as String? ?? '',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    decoration:
                        isCompleted ? TextDecoration.lineThrough : null,
                    color: isCompleted ? Theme.of(context).colorScheme.onSurfaceVariant : null,
                  ),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Next Appointment — highlight card
// ═══════════════════════════════════════════════════════════════

class NextAppointmentSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const NextAppointmentSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                data['time'] as String? ?? '',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data['customer_name'] as String? ?? '',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  data['service'] as String? ?? '',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                if (data['provider'] != null)
                  Text(
                    'مع ${data['provider']}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Active Quotes — quote cards for service-area archetypes
// ═══════════════════════════════════════════════════════════════

class ActiveQuotesSection extends StatelessWidget {
  final List<dynamic> items;
  const ActiveQuotesSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      children: items.map((item) {
        final m = item as Map<String, dynamic>;
        final status = m['status'] as String? ?? 'pending_quote';
        final amount = m['amount'];

        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: _statusBg(status),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _statusBorder(status)),
          ),
          child: Row(
            children: [
              // Status badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: _statusColor(status).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _statusLabel(status),
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: _statusColor(status),
                  ),
                ),
              ),
              if (amount != null) ...[
                const SizedBox(width: AppSpacing.sm),
                Text(
                  '${formatJod(amount)} د.أ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _statusColor(status),
                  ),
                ),
              ],
              const Spacer(),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      m['customer'] as String? ?? '',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      m['description'] as String? ?? '',
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Color _statusColor(String status) => switch (status) {
        'pending_quote' => Colors.amber.shade700,
        'quoted' => AppColors.primary,
        'accepted' => AppColors.success,
        _ => Colors.grey.shade500,
      };

  Color _statusBg(String status) => switch (status) {
        'pending_quote' => Colors.amber.withValues(alpha: 0.05),
        'quoted' => AppColors.primary.withValues(alpha: 0.05),
        'accepted' => AppColors.success.withValues(alpha: 0.05),
        _ => Colors.grey.withValues(alpha: 0.05),
      };

  Color _statusBorder(String status) => switch (status) {
        'pending_quote' => Colors.amber.withValues(alpha: 0.2),
        'quoted' => AppColors.primary.withValues(alpha: 0.15),
        'accepted' => AppColors.success.withValues(alpha: 0.15),
        _ => Colors.grey.withValues(alpha: 0.15),
      };

  String _statusLabel(String status) => switch (status) {
        'pending_quote' => 'بانتظار السعر',
        'quoted' => 'تم التسعير',
        'accepted' => 'مقبول',
        _ => status,
      };
}
