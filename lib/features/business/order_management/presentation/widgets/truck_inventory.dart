import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_shadows.dart';
import 'package:honak/core/theme/app_spacing.dart';

// ═══════════════════════════════════════════════════════════════
// TruckInventory — Full/empty/reserved counter widget.
// Compact variant: horizontal row for dashboard / truck cards.
// Expanded variant: two columns with +/- for DrivingMode.
// ═══════════════════════════════════════════════════════════════

enum TruckInventoryVariant { compact, expanded }

class TruckInventory extends StatelessWidget {
  final int currentFull;
  final int currentEmpty;
  final int capacityFull;
  final int reserved;
  final TruckInventoryVariant variant;
  final ValueChanged<int>? onFullChange;
  final ValueChanged<int>? onEmptyChange;

  const TruckInventory({
    super.key,
    required this.currentFull,
    required this.currentEmpty,
    required this.capacityFull,
    this.reserved = 0,
    this.variant = TruckInventoryVariant.compact,
    this.onFullChange,
    this.onEmptyChange,
  });

  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      TruckInventoryVariant.compact => _CompactInventory(
          full: currentFull,
          empty: currentEmpty,
          capacityFull: capacityFull,
          reserved: reserved,
        ),
      TruckInventoryVariant.expanded => _ExpandedInventory(
          full: currentFull,
          empty: currentEmpty,
          capacityFull: capacityFull,
          reserved: reserved,
          onFullChange: onFullChange,
          onEmptyChange: onEmptyChange,
        ),
    };
  }
}

// ─────────────────────────────────────────────────────────────
// Compact variant — horizontal row
// ─────────────────────────────────────────────────────────────

class _CompactInventory extends StatelessWidget {
  final int full;
  final int empty;
  final int capacityFull;
  final int reserved;

  const _CompactInventory({
    required this.full,
    required this.empty,
    required this.capacityFull,
    required this.reserved,
  });

  @override
  Widget build(BuildContext context) {
    final pct = capacityFull > 0 ? (full / capacityFull).clamp(0.0, 1.0) : 0.0;

    return Row(
      children: [
        // Full count
        const Icon(Icons.water_drop_outlined, size: 12, color: AppColors.primary),
        const SizedBox(width: 6),
        Text(
          context.l10n.bizReqInvFullCount(full),
          style: TextStyle(fontSize: 12, color: context.colorScheme.onSurfaceVariant),
        ),
        const _Dot(),
        // Empty count
        Icon(Icons.inventory_2_outlined, size: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
        const SizedBox(width: 6),
        Text(
          context.l10n.bizReqInvEmptyCount(empty),
          style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        const _Dot(),
        // Reserved
        Text(
          context.l10n.bizReqInvReservedCount(reserved),
          style: TextStyle(fontSize: 12, color: context.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(width: AppSpacing.sm),
        // Progress bar
        Expanded(
          child: ClipRRect(
            borderRadius: AppRadius.pill,
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 5,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
              valueColor: AlwaysStoppedAnimation<Color>(_barColor(pct)),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Expanded variant — two columns with +/- buttons
// ─────────────────────────────────────────────────────────────

class _ExpandedInventory extends StatelessWidget {
  final int full;
  final int empty;
  final int capacityFull;
  final int reserved;
  final ValueChanged<int>? onFullChange;
  final ValueChanged<int>? onEmptyChange;

  const _ExpandedInventory({
    required this.full,
    required this.empty,
    required this.capacityFull,
    required this.reserved,
    this.onFullChange,
    this.onEmptyChange,
  });

  @override
  Widget build(BuildContext context) {
    final available = (full - reserved).clamp(0, full);

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        boxShadow: AppShadows.sm,
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Counters row ──────────────────────────────
          IntrinsicHeight(
            child: Row(
              children: [
                // Full counter
                Expanded(
                  child: _CounterColumn(
                    icon: Icons.water_drop_outlined,
                    iconColor: AppColors.primary,
                    label: context.l10n.bizReqInvFull,
                    count: full,
                    countColor: _numberColor(full),
                    subtitle: context.l10n.bizReqInvLoadedOf(capacityFull),
                    onDecrement:
                        full > 0 ? () => onFullChange?.call(-1) : null,
                    onIncrement: () => onFullChange?.call(1),
                    incrementColor: AppColors.primary,
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                ),
                // Empty counter
                Expanded(
                  child: _CounterColumn(
                    icon: Icons.inventory_2_outlined,
                    iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    label: context.l10n.bizReqInvEmpty,
                    count: empty,
                    countColor: context.colorScheme.onSurfaceVariant,
                    subtitle: context.l10n.bizReqInvCollectedToday,
                    onDecrement:
                        empty > 0 ? () => onEmptyChange?.call(-1) : null,
                    onIncrement: () => onEmptyChange?.call(1),
                    incrementColor: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),

          // ── Reserved / Available bar ──────────────────
          Container(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.bizReqInvAvailableNew(available),
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  context.l10n.bizReqInvReservedUpcoming(reserved),
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          // ── Stock warnings ────────────────────────────
          if (full == 0)
            _WarningBanner(
              message: context.l10n.bizReqInvEmptyWarning,
              color: AppColors.error,
              backgroundColor: const Color(0xFFFFF5F5),
              borderColor: const Color(0xFFFFCDD2),
            )
          else if (full > 0 && full < reserved)
            _WarningBanner(
              message: context.l10n.bizReqInvShortageWarning(reserved - full),
              color: AppColors.warning,
              backgroundColor: const Color(0xFFFFF8E1),
              borderColor: const Color(0xFFFFECB3),
            )
          else if (full > 0 && full <= 5 && full >= reserved)
            _WarningBanner(
              message: context.l10n.bizReqInvLowWarning,
              color: AppColors.warning,
              backgroundColor: const Color(0xFFFFF8E1),
              borderColor: const Color(0xFFFFECB3),
              small: true,
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Counter column (full or empty side)
// ─────────────────────────────────────────────────────────────

class _CounterColumn extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final int count;
  final Color countColor;
  final String subtitle;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;
  final Color incrementColor;

  const _CounterColumn({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.count,
    required this.countColor,
    required this.subtitle,
    this.onDecrement,
    this.onIncrement,
    required this.incrementColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        children: [
          // Label
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 4),
              Icon(icon, size: 11, color: iconColor),
            ],
          ),
          const SizedBox(height: 6),

          // Buttons + count
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Increment (visually right in RTL)
              _RoundButton(
                icon: Icons.add,
                color: incrementColor,
                foregroundColor: incrementColor == AppColors.primary
                    ? context.colorScheme.surface
                    : context.colorScheme.onSurfaceVariant,
                onTap: onIncrement,
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 40,
                child: Text(
                  '$count',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: countColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Decrement (visually left in RTL)
              _RoundButton(
                icon: Icons.remove,
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                onTap: onDecrement,
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Subtitle
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 9,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Round +/- button
// ─────────────────────────────────────────────────────────────

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color foregroundColor;
  final VoidCallback? onTap;

  const _RoundButton({
    required this.icon,
    required this.color,
    required this.foregroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        opacity: onTap != null ? 1.0 : 0.3,
        duration: const Duration(milliseconds: 150),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 14, color: foregroundColor),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Warning banner
// ─────────────────────────────────────────────────────────────

class _WarningBanner extends StatelessWidget {
  final String message;
  final Color color;
  final Color backgroundColor;
  final Color borderColor;
  final bool small;

  const _WarningBanner({
    required this.message,
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(top: BorderSide(color: borderColor)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: small ? AppSpacing.sm : 10,
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: small ? 10 : 12,
          color: color,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Text(
        '·',
        style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 14),
      ),
    );
  }
}

/// Bar color based on fill percentage.
Color _barColor(double pct) {
  if (pct > 0.25) return AppColors.success;
  if (pct > 0.10) return AppColors.warning;
  return AppColors.error;
}

/// Number color based on absolute stock level.
Color _numberColor(int full) {
  if (full > 10) return AppColors.success;
  if (full > 3) return AppColors.warning;
  return AppColors.error;
}
