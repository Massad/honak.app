import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/subscriptions/domain/entities/entities.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:intl/intl.dart' hide TextDirection;

void showPauseSubscriptionSheet(
  BuildContext context,
  Subscription subscription,
) {
  showAppSheet(
    context,
    builder: (context) =>
        _PauseSubscriptionSheet(subscription: subscription),
  );
}

class _PauseSubscriptionSheet extends StatefulWidget {
  final Subscription subscription;

  const _PauseSubscriptionSheet({required this.subscription});

  @override
  State<_PauseSubscriptionSheet> createState() =>
      _PauseSubscriptionSheetState();
}

class _PauseSubscriptionSheetState extends State<_PauseSubscriptionSheet> {
  late double _days;
  late final int _maxDays;

  @override
  void initState() {
    super.initState();
    _maxDays = widget.subscription.policy?.pauseLimitDays ?? 30;
    _days = 1;
  }

  @override
  Widget build(BuildContext context) {
    final resumeDate = DateTime.now().add(Duration(days: _days.round()));
    final dateFormat = DateFormat('d MMMM yyyy', 'ar');

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: context.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.pause_circle_outline,
                size: 24,
                color: AppColors.warning,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'إيقاف مؤقت',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'اختر مدة الإيقاف المؤقت',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text(
              '${_days.round()} يوم',
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            Slider(
              value: _days,
              min: 1,
              max: _maxDays.toDouble(),
              divisions: _maxDays - 1 > 0 ? _maxDays - 1 : 1,
              activeColor: AppColors.primary,
              onChanged: (value) => setState(() => _days = value),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1 يوم',
                  style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant),
                ),
                Text(
                  '$_maxDays يوم',
                  style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.event, size: 16, color: AppColors.info),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'يستأنف في: ${dateFormat.format(resumeDate)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.info,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.showSnackBar('تم إيقاف الاشتراك مؤقتاً');
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.warning,
                  padding:
                      const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.button,
                  ),
                ),
                child: const Text('تأكيد الإيقاف'),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.button,
                  ),
                ),
                child: const Text('العودة'),
              ),
            ),
        ],
      ),
    );
  }
}
