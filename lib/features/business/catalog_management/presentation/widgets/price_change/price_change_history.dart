import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/catalog_management/domain/entities/price_change.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/price_change/price_change_banner.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';

// ── Status helpers ───────────────────────────────────────────────────────────

Color _statusColor(String status) {
  switch (status) {
    case 'active':
      return AppColors.success;
    case 'scheduled':
      return AppColors.primary;
    case 'expired':
      return Colors.grey.shade500;
    case 'cancelled':
      return AppColors.error;
    default:
      return Colors.grey.shade500;
  }
}

String _statusLabel(String status, BuildContext context) {
  switch (status) {
    case 'active':
      return context.l10n.pcStatusActive;
    case 'scheduled':
      return context.l10n.pcStatusScheduled;
    case 'expired':
      return context.l10n.pcStatusEnded;
    case 'cancelled':
      return context.l10n.pcStatusCancelled;
    default:
      return status;
  }
}

Color _directionColor(String direction) =>
    direction == 'decrease' ? AppColors.success : AppColors.warning;

IconData _directionIcon(String direction) =>
    direction == 'decrease'
        ? Icons.arrow_circle_down_outlined
        : Icons.arrow_circle_up_outlined;

String _valueText(PriceChange change) {
  final sign = change.direction == 'decrease' ? '-' : '+';
  if (change.method == 'percentage') {
    return '$sign${change.value.toStringAsFixed(0)}%';
  }
  return '$sign${(change.value / 100).toStringAsFixed(2)} د.أ';
}

String _scopeText(PriceChange change, BuildContext context) {
  switch (change.scope) {
    case 'category':
      return change.categoryNames.join('، ');
    case 'specific':
      return context.l10n.pcScopeSpecificCount(change.affectedCount);
    default:
      return context.l10n.pcAllItems;
  }
}

// ── PriceChangeHistory ───────────────────────────────────────────────────────

class PriceChangeHistory extends StatefulWidget {
  final PriceChange? activePriceChange;
  final List<PriceChange> history;
  final VoidCallback onClose;
  final VoidCallback onStopActive;
  final void Function(PriceChange) onReuse;

  const PriceChangeHistory({
    super.key,
    this.activePriceChange,
    required this.history,
    required this.onClose,
    required this.onStopActive,
    required this.onReuse,
  });

  @override
  State<PriceChangeHistory> createState() => _PriceChangeHistoryState();
}

class _PriceChangeHistoryState extends State<PriceChangeHistory> {
  PriceChange? _selectedDetail;

  @override
  Widget build(BuildContext context) {
    if (_selectedDetail != null) {
      return _ChangeDetail(
        change: _selectedDetail!,
        onBack: () => setState(() => _selectedDetail = null),
        onReuse: widget.onReuse,
      );
    }

    final activeOrScheduled = widget.activePriceChange;
    final pastChanges = widget.history
        .where((c) => c.status == 'expired' || c.status == 'cancelled')
        .toList();
    final isEmpty = activeOrScheduled == null && pastChanges.isEmpty;

    return Scaffold(

      body: Column(
        children: [
          SubScreenAppBar(
            title: context.l10n.pcHistoryTitle,
            onClose: widget.onClose,
          ),
          Expanded(
            child: isEmpty
                ? _EmptyState()
                : ListView(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    children: [
                      // Active or scheduled section
                      if (activeOrScheduled != null) ...[
                        _SectionHeader(
                          label: activeOrScheduled.status == 'scheduled'
                              ? context.l10n.pcScheduledLabel
                              : context.l10n.pcActiveNow,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        _ChangeCard(
                          change: activeOrScheduled,
                          onView: () => setState(
                            () => _selectedDetail = activeOrScheduled,
                          ),
                          onStop: isChangeActive(activeOrScheduled)
                              ? widget.onStopActive
                              : null,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                      ],
                      // Past changes section
                      if (pastChanges.isNotEmpty) ...[
                        _SectionHeader(label: context.l10n.pcPrevious),
                        const SizedBox(height: AppSpacing.sm),
                        ...pastChanges.map(
                          (c) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.sm,
                            ),
                            child: _ChangeCard(
                              change: c,
                              onView: () =>
                                  setState(() => _selectedDetail = c),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Empty State ──────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_offer_outlined, size: 48, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: AppSpacing.md),
          Text(
            context.l10n.pcNoChangesYet,
            style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

// ── Section Header ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;

  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

// ── Change Card ──────────────────────────────────────────────────────────────

class _ChangeCard extends StatelessWidget {
  final PriceChange change;
  final VoidCallback onView;
  final VoidCallback? onStop;

  const _ChangeCard({
    required this.change,
    required this.onView,
    this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    final color = _directionColor(change.direction);
    final statusCol = _statusColor(change.status);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: icon + value + scope
          Row(
            children: [
              Icon(_directionIcon(change.direction), size: 20, color: color),
              const SizedBox(width: AppSpacing.sm),
              Text(
                _valueText(change),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  _scopeText(change, context),
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Status badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: statusCol.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _statusLabel(change.status, context),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusCol,
                  ),
                ),
              ),
            ],
          ),
          // Reason
          if (change.reason.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              change.reason,
              style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          // Date range + visibility
          Row(
            children: [
              Icon(Icons.calendar_today_outlined,
                  size: 11, color: Theme.of(context).colorScheme.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(
                change.endsAt != null
                    ? '${formatDateAr(change.startsAt)} - ${formatDateAr(change.endsAt!)}'
                    : '${formatDateAr(change.startsAt)} - ${context.l10n.pcOpenEnded}',
                style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              const Spacer(),
              Icon(
                change.isPublic
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 11,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 2),
              Text(
                change.isPublic ? context.l10n.pcPublic : context.l10n.pcPrivate,
                style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Action buttons
          Row(
            children: [
              Expanded(
                child: _CardButton(
                  label: context.l10n.pcView,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  bgColor: Theme.of(context).colorScheme.surfaceContainerLowest,
                  onTap: onView,
                ),
              ),
              if (onStop != null) ...[
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _CardButton(
                    label: context.l10n.pcStop,
                    color: AppColors.error,
                    bgColor: AppColors.error.withValues(alpha: 0.08),
                    onTap: onStop!,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ── Change Detail ────────────────────────────────────────────────────────────

class _ChangeDetail extends StatelessWidget {
  final PriceChange change;
  final VoidCallback onBack;
  final void Function(PriceChange) onReuse;

  const _ChangeDetail({
    required this.change,
    required this.onBack,
    required this.onReuse,
  });

  @override
  Widget build(BuildContext context) {
    final color = _directionColor(change.direction);
    final statusCol = _statusColor(change.status);
    final canReuse =
        change.status == 'expired' || change.status == 'cancelled';

    // Calculate duration in days
    String durationText = context.l10n.pcOpenEnded;
    if (change.endsAt != null) {
      final start = DateTime.parse(change.startsAt);
      final end = DateTime.parse(change.endsAt!);
      final days = end.difference(start).inDays;
      durationText = '$days ${context.l10n.pcDays}';
    }

    return Scaffold(

      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsetsDirectional.only(
              top: MediaQuery.of(context).padding.top + AppSpacing.sm,
              start: AppSpacing.sm,
              end: AppSpacing.sm,
              bottom: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                bottom: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 48),
                const Spacer(),
                Text(
                  context.l10n.pcDetailTitle,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(width: AppSpacing.sm),
                IconButton(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_forward, size: 20),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                // Summary card
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: color.withValues(alpha: 0.15)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _directionIcon(change.direction),
                        size: 28,
                        color: color,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _valueText(change),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: color,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _scopeText(change, context),
                              style: TextStyle(
                                fontSize: 13,
                                color: color.withValues(alpha: 0.8),
                              ),
                            ),
                            if (change.reason.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                change.reason,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: color.withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                // Detail rows
                _DetailCard(
                  children: [
                    _DetailRow(
                      label: context.l10n.pcStatus,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: statusCol.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _statusLabel(change.status, context),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: statusCol,
                          ),
                        ),
                      ),
                    ),
                    _DetailDivider(),
                    _DetailRow(
                      label: context.l10n.pcPeriod,
                      value: change.endsAt != null
                          ? '${formatDateAr(change.startsAt)} - ${formatDateAr(change.endsAt!)}'
                          : '${formatDateAr(change.startsAt)} - ${context.l10n.pcOpenEnded}',
                    ),
                    _DetailDivider(),
                    _DetailRow(label: context.l10n.pcDuration, value: durationText),
                    _DetailDivider(),
                    _DetailRow(
                      label: context.l10n.pcAffectedItems,
                      value: context.l10n.pcAffectedItemsCount(change.affectedCount),
                    ),
                    _DetailDivider(),
                    _DetailRow(
                      label: context.l10n.pcVisibility,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            change.isPublic
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 14,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            change.isPublic ? context.l10n.pcPublicToCustomers : context.l10n.pcPrivateInternal,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Reuse button
                if (canReuse) ...[
                  const SizedBox(height: AppSpacing.xxl),
                  GestureDetector(
                    onTap: () => onReuse(change),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        context.l10n.pcReuseChange,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.surface,
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
    );
  }
}

// ── Detail Card Container ────────────────────────────────────────────────────

class _DetailCard extends StatelessWidget {
  final List<Widget> children;

  const _DetailCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(children: children),
    );
  }
}

// ── Detail Row ───────────────────────────────────────────────────────────────

class _DetailRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? child;

  const _DetailRow({required this.label, this.value, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          child ??
              Text(
                value ?? '',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
        ],
      ),
    );
  }
}

// ── Detail Divider ───────────────────────────────────────────────────────────

class _DetailDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant);
  }
}

// ── Card Button ──────────────────────────────────────────────────────────────

class _CardButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  const _CardButton({
    required this.label,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ),
    );
  }
}
