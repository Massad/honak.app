import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/subscriptions/domain/entities/entities.dart';
import 'package:intl/intl.dart' hide TextDirection;

void showCreditHistorySheet(
  BuildContext context,
  Subscription subscription,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => _CreditHistoryContent(
        subscription: subscription,
        scrollController: scrollController,
      ),
    ),
  );
}

class _CreditHistoryContent extends StatelessWidget {
  final Subscription subscription;
  final ScrollController scrollController;

  const _CreditHistoryContent({
    required this.subscription,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final history = subscription.history;

    return Column(
      children: [
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: 36,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Text(
                subscription.packageName,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _balanceSummary(),
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: history.isEmpty
              ? _EmptyHistory()
              : ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: history.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) =>
                      _HistoryEntry(entry: history[index]),
                ),
        ),
      ],
    );
  }

  String _balanceSummary() {
    if (subscription.model == SubscriptionModel.dateOnly) {
      return 'اشتراك غير محدود';
    }
    return 'الرصيد: ${subscription.remainingCredits ?? 0} / ${subscription.totalCredits ?? 0}';
  }
}

class _EmptyHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 40,
            color: Colors.grey.shade200,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'لا يوجد سجل استخدام',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryEntry extends StatelessWidget {
  final CreditHistoryEntry entry;

  const _HistoryEntry({required this.entry});

  @override
  Widget build(BuildContext context) {
    final config = _configForType(entry.type);
    final dateFormat = DateFormat('d MMM yyyy, h:mm a', 'ar');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: config.color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(config.icon, size: 16, color: config.color),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.note ?? config.defaultLabel,
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                dateFormat.format(DateTime.parse(entry.date)),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
        if (entry.amount != 0)
          Text(
            _formatAmount(entry.amount, entry.type),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: config.color,
            ),
          ),
      ],
    );
  }

  String _formatAmount(int amount, CreditHistoryType type) {
    switch (type) {
      case CreditHistoryType.purchase:
      case CreditHistoryType.resume:
        return '+$amount';
      case CreditHistoryType.autoDeduct:
      case CreditHistoryType.expired:
      case CreditHistoryType.cancel:
        return '-$amount';
      case CreditHistoryType.adjustment:
        return amount >= 0 ? '+$amount' : '$amount';
      case CreditHistoryType.pause:
        return '';
    }
  }

  _EntryConfig _configForType(CreditHistoryType type) {
    switch (type) {
      case CreditHistoryType.purchase:
        return _EntryConfig(
          icon: Icons.add_circle,
          color: AppColors.success,
          defaultLabel: 'شراء رصيد',
        );
      case CreditHistoryType.autoDeduct:
        return _EntryConfig(
          icon: Icons.remove_circle,
          color: AppColors.info,
          defaultLabel: 'خصم تلقائي',
        );
      case CreditHistoryType.adjustment:
        return _EntryConfig(
          icon: Icons.swap_horiz,
          color: AppColors.warning,
          defaultLabel: 'تعديل',
        );
      case CreditHistoryType.expired:
        return _EntryConfig(
          icon: Icons.cancel,
          color: AppColors.error,
          defaultLabel: 'انتهاء صلاحية',
        );
      case CreditHistoryType.pause:
        return _EntryConfig(
          icon: Icons.pause_circle,
          color: Colors.grey,
          defaultLabel: 'إيقاف مؤقت',
        );
      case CreditHistoryType.resume:
        return _EntryConfig(
          icon: Icons.play_circle,
          color: AppColors.success,
          defaultLabel: 'استئناف',
        );
      case CreditHistoryType.cancel:
        return _EntryConfig(
          icon: Icons.cancel,
          color: AppColors.error,
          defaultLabel: 'إلغاء',
        );
    }
  }
}

class _EntryConfig {
  final IconData icon;
  final Color color;
  final String defaultLabel;

  const _EntryConfig({
    required this.icon,
    required this.color,
    required this.defaultLabel,
  });
}
