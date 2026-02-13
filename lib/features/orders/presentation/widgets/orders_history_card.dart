import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/domain/entities/entities.dart';

/// Card for a completed/cancelled order.
class HistoryCard extends StatelessWidget {
  final CustomerRequest request;

  const HistoryCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final isCompleted =
        request.status == 'completed' || request.status == 'delivered';

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              context.showSnackBar(
                  '\u062a\u0641\u0627\u0635\u064a\u0644: ${request.id}');
            },
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  _HistoryAvatar(
                    request: request,
                    isCompleted: isCompleted,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.businessName,
                          style: context.textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _buildSummary(),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (request.total != null)
                    Text(
                      request.total!.toFormattedArabic(),
                      style: context.textTheme.titleSmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (isCompleted) _HistoryActions(request: request),
        ],
      ),
    );
  }

  String _buildSummary() {
    switch (request.type) {
      case 'order':
        final count = request.itemsCount > 0
            ? request.itemsCount
            : request.items.length;
        return '$count \u0623\u0635\u0646\u0627\u0641';
      case 'booking':
        if (request.timeSlot != null) return request.timeSlot!;
        return '\u062d\u062c\u0632';
      case 'quote':
      case 'inquiry':
        return request.description ?? '';
      case 'reservation':
        return request.dateRange ?? '\u062d\u062c\u0632 \u0645\u0643\u0627\u0646';
      default:
        return '';
    }
  }
}

class _HistoryAvatar extends StatelessWidget {
  final CustomerRequest request;
  final bool isCompleted;

  const _HistoryAvatar({required this.request, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: request.businessAvatarUrl != null
              ? NetworkImage(request.businessAvatarUrl!)
              : null,
          child: request.businessAvatarUrl == null
              ? Text(
                  request.businessName.isNotEmpty
                      ? request.businessName[0]
                      : '?',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                )
              : null,
        ),
        if (isCompleted)
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(Icons.check, size: 9, color: Colors.white),
            ),
          ),
      ],
    );
  }
}

class _HistoryActions extends StatelessWidget {
  final CustomerRequest request;

  const _HistoryActions({required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade50)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => context.showSnackBar('\u0623\u0639\u062f \u0627\u0644\u0637\u0644\u0628'),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.replay, size: 12, color: AppColors.success),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '\u0623\u0639\u062f \u0627\u0644\u0637\u0644\u0628',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.success,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(width: 1, height: 20, color: Colors.grey.shade50),
          Expanded(
            child: GestureDetector(
              onTap: () => context.showSnackBar(
                  '\u062a\u0641\u0627\u0635\u064a\u0644: ${request.id}'),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.description_outlined,
                        size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '\u0627\u0644\u062a\u0641\u0627\u0635\u064a\u0644',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
