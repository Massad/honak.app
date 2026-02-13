part of 'customer_queue_view.dart';

/// Collapsible subscription plans section within [CustomerQueueView].
class _QueueSubscriptionsSection extends StatefulWidget {
  final List<QueueSubscription> subscriptions;

  const _QueueSubscriptionsSection({required this.subscriptions});

  @override
  State<_QueueSubscriptionsSection> createState() =>
      _QueueSubscriptionsSectionState();
}

class _QueueSubscriptionsSectionState
    extends State<_QueueSubscriptionsSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Column(
        children: [
          // Toggle button
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Row(
              children: [
                Icon(
                  Icons.workspace_premium,
                  size: 14,
                  color: AppColors.secondary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'اشتراكات شهرية — أولوية بالدور',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: _expanded ? 0.25 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.chevron_left,
                    size: 14,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
          // Subscription cards
          if (_expanded) ...[
            const SizedBox(height: AppSpacing.sm),
            ...widget.subscriptions.map(
              (sub) => _buildSubscriptionCard(context, sub),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(
    BuildContext context,
    QueueSubscription sub,
  ) {
    final price = Money(sub.pricePerMonth);

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.secondary.withValues(alpha: 0.3),
          ),
          color: AppColors.secondary.withValues(alpha: 0.05),
          borderRadius: AppRadius.cardInner,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sub.nameAr,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: price.toJodString(),
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                      TextSpan(
                        text: ' د.أ/شهر',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.secondary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (sub.features.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: sub.features
                    .map((f) => Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(AppRadius.xxs),
                          ),
                          child: Text(
                            f,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: AppColors.secondary,
                              fontSize: 9,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
