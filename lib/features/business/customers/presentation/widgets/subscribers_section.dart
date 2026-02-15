import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/customers/domain/entities/business_customer.dart';
import 'package:honak/features/business/customers/presentation/providers/customers_provider.dart';
import 'package:honak/features/business/customers/presentation/widgets/manage_subscription_sheet.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/empty_state.dart';

/// SubscribersSection — filter chips, today's auto-orders, subscriber cards.
/// Matches Figma BizCustomersTab.tsx lines 152-481.
class SubscribersSection extends StatefulWidget {
  final BizCustomersData data;

  const SubscribersSection({super.key, required this.data});

  @override
  State<SubscribersSection> createState() => _SubscribersSectionState();
}

class _SubscribersSectionState extends State<SubscribersSection> {
  String _filter = 'all';
  late List<TodaysAutoOrder> _autoOrders;

  @override
  void initState() {
    super.initState();
    _autoOrders = [...widget.data.autoOrders];
  }

  @override
  void didUpdateWidget(SubscribersSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data.autoOrders != widget.data.autoOrders) {
      _autoOrders = [...widget.data.autoOrders];
    }
  }

  List<BusinessCustomer> get _filtered {
    final subs = widget.data.subscribers;
    switch (_filter) {
      case 'active':
        return subs
            .where((c) =>
                c.subscription?.status == 'active' &&
                c.subscription?.recurringMode == 'auto_send')
            .toList();
      case 'remind':
        return subs
            .where((c) => c.subscription?.recurringMode == 'remind')
            .toList();
      case 'low':
        return subs
            .where((c) =>
                c.subscription != null &&
                (c.subscription!.remainingCredits ?? 0) <= 2 &&
                c.subscription!.status != 'depleted')
            .toList();
      default:
        return subs;
    }
  }

  void _confirmAutoOrder(int index) {
    final order = _autoOrders[index];
    setState(() {
      _autoOrders[index] = order.copyWith(status: 'confirmed');
    });
    context.showSnackBar(context.l10n.bizSubOrderConfirmed(order.customer));
  }

  void _skipAutoOrder(int index) {
    final order = _autoOrders[index];
    setState(() {
      _autoOrders[index] = order.copyWith(status: 'skipped');
    });
    context.showSnackBar(context.l10n.bizSubOrderSkipped(order.customer));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final filtered = _filtered;
    final pendingAuto =
        _autoOrders.where((o) => o.status == 'pending').toList();

    final filters = [
      _FilterDef(id: 'all', label: l10n.bizSubFilterAll),
      _FilterDef(id: 'active', label: l10n.bizSubFilterAuto),
      _FilterDef(id: 'remind', label: l10n.bizSubFilterRemind),
      _FilterDef(id: 'low', label: l10n.bizSubFilterLow),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Filter chips ──
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filters.map((f) {
              final isSelected = f.id == _filter;
              return Padding(
                padding:
                    const EdgeInsetsDirectional.only(end: AppSpacing.sm),
                child: GestureDetector(
                  onTap: () => setState(() => _filter = f.id),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      f.label,
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // ── Today's auto-orders ──
        if (pendingAuto.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${l10n.bizSubTodayAutoOrders} (${pendingAuto.length})',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.refresh, size: 11, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ..._autoOrders.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _AutoOrderCard(
                    order: entry.value,
                    onConfirm: () => _confirmAutoOrder(entry.key),
                    onSkip: () => _skipAutoOrder(entry.key),
                  ),
                ),
              ),
          const SizedBox(height: AppSpacing.sm),
        ],

        // ── Subscriber cards ──
        if (filtered.isEmpty)
          EmptyState(
            icon: Icons.credit_card_outlined,
            title: l10n.bizSubNoSubscribers,
          )
        else
          ...filtered.map(
            (c) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _SubscriberCard(
                customer: c,
                onTap: () => showManageSubscriptionSheet(
                  context,
                  customer: c,
                ),
                onRenewReminder: () {
                  context.showSnackBar(
                    l10n.bizSubReminderSent(c.name),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Auto-Order Card
// ═══════════════════════════════════════════════════════════════

class _AutoOrderCard extends StatelessWidget {
  final TodaysAutoOrder order;
  final VoidCallback onConfirm;
  final VoidCallback onSkip;

  const _AutoOrderCard({
    required this.order,
    required this.onConfirm,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isPending = order.status == 'pending';

    return Opacity(
      opacity: isPending ? 1.0 : 0.5,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Refresh icon circle
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF), // blue-50
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.refresh,
                    size: 14,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        order.customer,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      if (order.items != null)
                        Text(
                          order.items!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      if (order.creditsBefore != null &&
                          order.creditsAfter != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            l10n.bizSubCreditsBefore(
                              order.creditsBefore!,
                              order.creditsAfter!,
                            ),
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            // Action buttons or status label
            if (isPending) ...[
              const SizedBox(height: AppSpacing.sm),
              Row(
                textDirection: TextDirection.ltr,
                children: [
                  // Chat button
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      size: 12,
                      color: AppColors.textHint,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),

                  // Skip
                  Expanded(
                    child: GestureDetector(
                      onTap: onSkip,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.divider),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.skip_next, size: 12,
                                color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              l10n.bizSubSkip,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),

                  // Confirm
                  Expanded(
                    child: GestureDetector(
                      onTap: onConfirm,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check, size: 12,
                                color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              l10n.bizSubConfirm,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            if (order.status == 'confirmed')
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: Text(
                  '✓ ${l10n.bizSubConfirmedLabel}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.success,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            if (order.status == 'skipped')
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: Text(
                  l10n.bizSubSkippedLabel,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Subscriber Card
// ═══════════════════════════════════════════════════════════════

class _SubscriberCard extends StatelessWidget {
  final BusinessCustomer customer;
  final VoidCallback onTap;
  final VoidCallback onRenewReminder;

  const _SubscriberCard({
    required this.customer,
    required this.onTap,
    required this.onRenewReminder,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = customer;
    final sub = c.subscription;
    if (sub == null) return const SizedBox.shrink();

    final (String statusLabel, Color statusColor, Color dotColor) =
        switch (sub.status) {
      'active' => (
        l10n.bizSubStatusActive,
        AppColors.success,
        AppColors.success,
      ),
      'depleted' => (
        l10n.bizSubStatusDepleted,
        const Color(0xFFE53935),
        const Color(0xFFE53935),
      ),
      'paused' => (
        l10n.bizSubStatusPaused,
        const Color(0xFFF59E0B), // amber-500
        const Color(0xFFFBBF24), // amber-400
      ),
      _ => (
        l10n.bizSubStatusEnded,
        AppColors.textHint,
        AppColors.textHint,
      ),
    };

    final remaining = sub.remainingCredits ?? 0;
    final total = sub.totalCredits ?? 0;
    final progressFraction = total > 0 ? remaining / total : 0.0;
    final isLow = remaining <= 2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                AppImage.avatar(
                  url: c.avatar,
                  name: c.name,
                  radius: 20,
                ),
                const SizedBox(width: AppSpacing.md),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Name + status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Status badge with dot
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: dotColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                statusLabel,
                                style: TextStyle(
                                  fontSize: 9,
                                  color: statusColor,
                                ),
                              ),
                            ],
                          ),
                          // Name
                          Text(
                            c.name,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 2),

                      // Phone + area
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (c.phone != null)
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                c.phone!,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textHint,
                                ),
                              ),
                            ),
                          if (c.phone != null && c.area != null)
                            const SizedBox(width: AppSpacing.sm),
                          if (c.area != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 8,
                                  color: AppColors.textHint,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  c.area!,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: AppColors.textHint,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),

                      const SizedBox(height: 2),

                      // Package + credits + expiry
                      Text(
                        '${sub.packageName}'
                        '${total > 0 ? ' · $remaining/$total' : ''}'
                        '${sub.expiresAt != null ? ' · ${l10n.bizSubExpiresAt(_formatDate(sub.expiresAt!))}' : ''}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.end,
                      ),

                      // Frequency + mode
                      if (sub.recurringFrequency != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            '${sub.recurringFrequency} · ${sub.recurringMode == 'auto_send' ? l10n.bizSubAutoMode : l10n.bizSubRemindMode}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.textHint,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),

                      // Progress bar
                      if (total > 0) ...[
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(9999),
                          child: SizedBox(
                            height: 4,
                            child: LinearProgressIndicator(
                              value: progressFraction,
                              backgroundColor: const Color(0xFFF3F4F6),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isLow
                                    ? const Color(0xFFFF9800) // amber
                                    : AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            // Renewal reminder button for depleted subscribers
            if (remaining == 0) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: onRenewReminder,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB), // amber-50
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.send, size: 9,
                              color: Color(0xFFFF9800)),
                          const SizedBox(width: 4),
                          Text(
                            l10n.bizSubRenewReminder,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFFFF9800),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Helpers
// ═══════════════════════════════════════════════════════════════

class _FilterDef {
  final String id;
  final String label;

  const _FilterDef({required this.id, required this.label});
}

String _formatDate(String isoDate) {
  try {
    final date = DateTime.parse(isoDate);
    return '${date.day}/${date.month}';
  } catch (_) {
    return isoDate;
  }
}
