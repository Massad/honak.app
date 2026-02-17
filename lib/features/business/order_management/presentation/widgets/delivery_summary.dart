import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/domain/entities/truck.dart';
import 'package:honak/features/business/order_management/presentation/widgets/driving_mode_sheets.dart';
import 'package:honak/shared/widgets/button.dart';
import 'package:intl/intl.dart' hide TextDirection;

/// End-of-route summary report showing stats, inventory, revenue, sources.
class DeliverySummary extends StatelessWidget {
  final Truck truck;
  final List<QueueItem> queue;
  final String startedAt;
  final int reloads;
  final VoidCallback onEndRoute;

  const DeliverySummary({
    super.key,
    required this.truck,
    required this.queue,
    required this.startedAt,
    required this.reloads,
    required this.onEndRoute,
  });

  @override
  Widget build(BuildContext context) {
    final delivered = queue.where((q) => q.status == QueueItemStatus.delivered).toList();
    final skipped = queue.where((q) => q.status == QueueItemStatus.skipped).toList();
    final failed = queue.where((q) => q.status == QueueItemStatus.failed).toList();
    final pending = queue.where(
      (q) => q.status == QueueItemStatus.pending || q.status == QueueItemStatus.current,
    ).toList();

    final totalDelivered = delivered.fold<int>(0, (s, q) => s + (q.fullDelivered ?? 0));
    final totalEmpties = delivered.fold<int>(0, (s, q) => s + (q.emptiesCollected ?? 0));

    // Revenue
    final creditUnits = delivered
        .where((q) => (q.actualPayment ?? q.payment) == PaymentType.credits)
        .fold<int>(0, (s, q) => s + q.items.fold<int>(0, (a, i) => a + i.qty));
    final cashUnits = delivered
        .where((q) => (q.actualPayment ?? q.payment) == PaymentType.cash)
        .fold<int>(0, (s, q) => s + q.items.fold<int>(0, (a, i) => a + i.qty));
    final accountUnits = delivered
        .where((q) => (q.actualPayment ?? q.payment) == PaymentType.onAccount)
        .fold<int>(0, (s, q) => s + q.items.fold<int>(0, (a, i) => a + i.qty));

    // Payment changes
    final paymentChanges =
        delivered.where((q) => q.actualPayment != null && q.actualPayment != q.payment).toList();

    // Driver notes
    final itemsWithNotes = delivered.where((q) => q.deliveryNote != null && q.deliveryNote!.isNotEmpty).toList();

    // Sources
    final sources = <OrderSource, int>{};
    for (final q in delivered) {
      sources[q.source] = (sources[q.source] ?? 0) + 1;
    }

    // Duration
    final start = DateTime.tryParse(startedAt) ?? DateTime.now();
    final durationMin = DateTime.now().difference(start).inMinutes;
    final hours = durationMin ~/ 60;
    final mins = durationMin % 60;

    final today = DateFormat.yMMMMEEEEd('ar').format(DateTime.now());

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.xl,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.bizReqSumTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      '${truck.name} \u2014 ${truck.driverName} \u00B7 $today',
                      style: TextStyle(
                        fontSize: 10,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 14,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1, color: context.colorScheme.outlineVariant),
        // Content
        Flexible(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(AppSpacing.lg),
                  children: [
                    // Duration
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          mins > 0
                              ? context.l10n.bizReqSumDurationMinutes(hours, mins)
                              : context.l10n.bizReqSumDuration(hours),
                          style: TextStyle(
                            fontSize: 14,
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    // Main stats — 3 column
                    Row(
                      children: [
                        _StatCard(
                          icon: Icons.check,
                          iconColor: AppColors.success,
                          bgColor: AppColors.success.withAlpha(20),
                          count: delivered.length,
                          label: context.l10n.bizReqSumDelivered,
                        ),
                        const SizedBox(width: 8),
                        _StatCard(
                          icon: Icons.skip_next,
                          iconColor: AppColors.secondary,
                          bgColor: AppColors.secondary.withAlpha(20),
                          count: skipped.length,
                          label: context.l10n.bizReqSumSkipped,
                        ),
                        const SizedBox(width: 8),
                        _StatCard(
                          icon: Icons.cancel_outlined,
                          iconColor: AppColors.error,
                          bgColor: AppColors.error.withAlpha(20),
                          count: failed.length + pending.length,
                          label: context.l10n.bizReqSumNotDelivered,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    // Inventory
                    _SectionCard(
                      icon: Icons.inventory_2_outlined,
                      iconColor: AppColors.primary,
                      title: context.l10n.bizReqSumInventory,
                      children: [
                        _Row(label: context.l10n.bizReqSumStartedWith, value: context.l10n.bizReqSumFullCount(truck.capacityFull)),
                        if (reloads > 0)
                          _Row(
                            label: context.l10n.bizReqSumReloads,
                            value: context.l10n.bizReqSumReloadTimes(reloads),
                            valueColor: AppColors.primary,
                          ),
                        _Row(
                          label: context.l10n.bizReqSumDelivered,
                          value: context.l10n.bizReqSumDeliveredCount(totalDelivered),
                          valueColor: AppColors.success,
                        ),
                        _Row(
                          label: context.l10n.bizReqSumRemaining,
                          value: context.l10n.bizReqSumFullCount(truck.today.currentFull),
                        ),
                        const Divider(height: 16),
                        _Row(label: context.l10n.bizReqSumEmptiesCollected, value: '$totalEmpties'),
                        // Exchange vs new breakdown
                        Builder(
                          builder: (context) {
                            final totalExchange = delivered.fold<int>(
                              0,
                              (s, q) => s + (q.fullDelivered ?? 0).clamp(0, q.emptiesCollected ?? 0),
                            );
                            final totalNew = delivered.fold<int>(
                              0,
                              (s, q) => s + ((q.fullDelivered ?? 0) - (q.emptiesCollected ?? 0)).clamp(0, 9999),
                            );
                            if (totalNew <= 0) {
                              return const SizedBox.shrink();
                            }
                            return Column(
                              children: [
                                const Divider(height: 16),
                                _Row(
                                  label: context.l10n.bizReqSheetExchange,
                                  value: context.l10n.bizReqSheetUnitCount(totalExchange),
                                  valueColor: AppColors.success,
                                ),
                                _Row(
                                  label: context.l10n.bizReqSheetNewNoEmpty,
                                  value: context.l10n.bizReqSheetUnitCount(totalNew),
                                  valueColor: AppColors.secondary,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Revenue
                    _SectionCard(
                      icon: Icons.payments_outlined,
                      iconColor: AppColors.success,
                      title: context.l10n.bizReqSumRevenue,
                      children: [
                        _Row(
                          label: context.l10n.bizReqSumPrepaid,
                          value: context.l10n.bizReqSheetUnitCount(creditUnits),
                          leadingIcon: Icons.credit_card,
                          leadingIconColor: AppColors.primary,
                        ),
                        _Row(
                          label: context.l10n.bizReqSumCash,
                          value: context.l10n.bizReqSheetUnitCount(cashUnits),
                          leadingIcon: Icons.payments_outlined,
                          leadingIconColor: AppColors.success,
                        ),
                        _Row(
                          label: context.l10n.bizReqSumOnAccount,
                          value: context.l10n.bizReqSheetUnitCount(accountUnits),
                          leadingIcon: Icons.description_outlined,
                          leadingIconColor: context.colorScheme.onSurfaceVariant,
                        ),
                        const Divider(height: 16),
                        _Row(
                          label: context.l10n.bizReqSumTotalUnits,
                          value: '${creditUnits + cashUnits + accountUnits}',
                          bold: true,
                        ),
                      ],
                    ),
                    // Payment changes
                    if (paymentChanges.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.md),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(15),
                          border: Border.all(
                            color: AppColors.primary.withAlpha(30),
                          ),
                          borderRadius: AppRadius.cardInner,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.bizReqSumPaymentChanges,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            ...paymentChanges.map(
                              (q) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      q.customerName,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: context.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    Text(
                                      '${paymentLabel(q.payment, context.l10n)} \u2190 ${paymentLabel(q.actualPayment!, context.l10n)}',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    // Driver notes
                    if (itemsWithNotes.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.md),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: context.colorScheme.surfaceVariant,
                          border: Border.all(color: context.colorScheme.outlineVariant),
                          borderRadius: AppRadius.cardInner,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.bizReqSumDriverNotes,
                              style: TextStyle(
                                fontSize: 12,
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            ...itemsWithNotes.map(
                              (q) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${q.customerName}: ',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: context.colorScheme.onSurface,
                                        ),
                                      ),
                                      TextSpan(
                                        text: q.deliveryNote,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: context.colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.md),
                    // Sources
                    _SectionCard(
                      icon: Icons.local_shipping_outlined,
                      iconColor: AppColors.secondary,
                      title: context.l10n.bizReqSumSources,
                      children: sources.entries
                          .toList()
                        ..sort((a, b) => b.value.compareTo(a.value)),
                      customChildBuilder: (entries) {
                        return Column(
                          children: (entries as List<MapEntry<OrderSource, int>>)
                              .map((e) {
                            final pct = delivered.isNotEmpty
                                ? (e.value / delivered.length * 100).round()
                                : 0;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SourceBadge(source: e.key),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${sourceLabels(context.l10n)[e.key] ?? e.key.name}: ${e.value}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: context.colorScheme.onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '$pct%',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: context.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    // Skipped details
                    if (skipped.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.md),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withAlpha(20),
                          border: Border.all(
                            color: AppColors.secondary.withAlpha(40),
                          ),
                          borderRadius: AppRadius.cardInner,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.bizReqSumSkippedList,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.secondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            ...skipped.map(
                              (q) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${q.customerName} \u2014 ${_skipReasonLabel(q.skipReason, context.l10n)}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: context.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    Text(
                                      q.rescheduledTo != null
                                          ? '\u2190 ${q.rescheduledTo == 'tomorrow' ? context.l10n.bizReqSumTomorrow : q.rescheduledTo}'
                                          : context.l10n.bizReqSumRemoved,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: AppColors.secondary.withAlpha(200),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xl),
                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: Button(
                            onPressed: () {
                              Navigator.pop(context);
                              onEndRoute();
                            },
                            label: context.l10n.bizReqSumEndRoute,
                            icon: const ButtonIcon(Icons.check),
                            size: ButtonSize.large,
                            expand: true,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(context.l10n.bizReqDmComingSoon),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              border: Border.all(color: context.colorScheme.outlineVariant),
                              borderRadius: AppRadius.cardInner,
                            ),
                            child: Icon(
                              Icons.share,
                              size: 16,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ],
          );
  }

  String _skipReasonLabel(String? reason, AppLocalizations l10n) {
    if (reason == null) return '';
    for (final r in skipReasons(l10n)) {
      if (r.$1 == reason) return r.$2;
    }
    return reason;
  }
}

// ── Helper widgets ──────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final int count;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: AppRadius.cardInner,
        ),
        child: Column(
          children: [
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(height: 4),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: iconColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final List<dynamic> children;
  final Widget Function(List<dynamic>)? customChildBuilder;

  const _SectionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.children,
    this.customChildBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border.all(color: context.colorScheme.outlineVariant.withAlpha(100)),
        borderRadius: AppRadius.cardInner,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(8),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 13, color: iconColor),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (customChildBuilder != null)
            customChildBuilder!(children)
          else
            ...children.whereType<Widget>(),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool bold;
  final IconData? leadingIcon;
  final Color? leadingIconColor;

  const _Row({
    required this.label,
    required this.value,
    this.valueColor,
    this.bold = false,
    this.leadingIcon,
    this.leadingIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (leadingIcon != null) ...[
                Icon(leadingIcon, size: 11, color: leadingIconColor),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: context.colorScheme.onSurface,
                  fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: valueColor ?? context.colorScheme.onSurfaceVariant,
              fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
