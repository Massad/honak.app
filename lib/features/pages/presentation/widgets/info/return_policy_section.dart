import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';

/// Return / exchange policy card.
class ReturnPolicySection extends StatelessWidget {
  final ReturnPolicy policy;

  const ReturnPolicySection({super.key, required this.policy});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('سياسة الاسترجاع', style: context.textTheme.titleSmall),
        SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: policy.acceptsReturns
                ? Colors.blue.withValues(alpha: 0.06)
                : Colors.red.withValues(alpha: 0.06),
            borderRadius: AppRadius.cardInner,
            border: Border.all(
              color: policy.acceptsReturns
                  ? Colors.blue.withValues(alpha: 0.2)
                  : Colors.red.withValues(alpha: 0.2),
            ),
          ),
          child: policy.acceptsReturns
              ? _AcceptsReturns(policy: policy)
              : _NoReturns(),
        ),
      ],
    );
  }
}

class _AcceptsReturns extends StatelessWidget {
  final ReturnPolicy policy;

  const _AcceptsReturns({required this.policy});

  String get _typeLabel => switch (policy.type) {
    'refund' => 'استرجاع',
    'exchange' => 'استبدال',
    'both' => 'استرجاع واستبدال',
    _ => policy.type ?? '',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle_outline, size: 18, color: Colors.blue),
            SizedBox(width: AppSpacing.sm),
            Text(
              'يقبل $_typeLabel',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
        if (policy.windowDays != null) ...[
          SizedBox(height: AppSpacing.sm),
          Text(
            'خلال ${policy.windowDays} يوم',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        if (policy.cost != null) ...[
          SizedBox(height: AppSpacing.xxs),
          Text(
            'التكلفة: ${policy.cost}',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        if (policy.conditionsAr.isNotEmpty) ...[
          SizedBox(height: AppSpacing.sm),
          ...policy.conditionsAr.map(
            (c) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.xxs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      c,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _NoReturns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.cancel_outlined, size: 18, color: Colors.red),
        SizedBox(width: AppSpacing.sm),
        Text(
          'لا يقبل الاسترجاع أو الاستبدال',
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.red.shade800,
          ),
        ),
      ],
    );
  }
}
