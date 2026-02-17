import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

// ignore_for_file: avoid_escaping_inner_quotes

class RecurringCustomersSection extends StatelessWidget {
  const RecurringCustomersSection({super.key});

  void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Row(
          children: [
            Text(
              context.l10n.bizRecurringCustomers,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            btn.Button(
              onPressed: () => _showToast(
                context,
                context.l10n.bizRecurringViewAllSoon,
              ),
              label: context.l10n.bizRecurringViewAll,
              variant: btn.Variant.text,
              size: btn.ButtonSize.small,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Stats chips row
        Row(
          children: [
            _StatChip(
              text: context.l10n.bizRecurringActiveCount(5),
              color: AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.sm),
            _StatChip(
              text: context.l10n.bizRecurringAutoCount(2),
              color: AppColors.success,
            ),
            const SizedBox(width: AppSpacing.sm),
            _StatChip(
              text: context.l10n.bizRecurringRemindCount(3),
              color: Colors.purple,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Auto orders subtitle
        Text(
          context.l10n.bizRecurringAutoOrdersToday,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Auto-order card 1
        _CustomerActionCard(
          initial: '\u0633',
          name: '\u0633\u0627\u0631\u0629 \u0639\u0645\u0631',
          subtitle: context.l10n.bizRecurringAutoOrder(2),
          avatarColor: AppColors.primary,
          actions: [
            _ActionButton(
              label: context.l10n.bizRecurringConfirm,
              icon: Icons.check,
              color: AppColors.success,
              onTap: () => _showToast(
                context,
                context.l10n.bizRecurringConfirmed('\u0633\u0627\u0631\u0629'),
              ),
            ),
            _ActionButton(
              label: context.l10n.bizRecurringSkip,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              onTap: () => _showToast(
                context,
                context.l10n.bizRecurringSkipped('\u0633\u0627\u0631\u0629'),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        // Auto-order card 2
        _CustomerActionCard(
          initial: '\u0623',
          name:
              '\u0623\u062d\u0645\u062f \u0645\u062d\u0645\u062f',
          subtitle: context.l10n.bizRecurringAutoOrder(3),
          avatarColor: Colors.teal,
          actions: [
            _ActionButton(
              label: context.l10n.bizRecurringConfirm,
              icon: Icons.check,
              color: AppColors.success,
              onTap: () => _showToast(
                context,
                context.l10n.bizRecurringConfirmed('\u0623\u062d\u0645\u062f'),
              ),
            ),
            _ActionButton(
              label: context.l10n.bizRecurringSkip,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              onTap: () => _showToast(
                context,
                context.l10n.bizRecurringSkipped('\u0623\u062d\u0645\u062f'),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Low credit subtitle
        Text(
          context.l10n.bizRecurringLowCredit,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.orange.shade700,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Low credit card
        _CustomerActionCard(
          initial: '\u062e',
          name:
              '\u062e\u0627\u0644\u062f \u0633\u0645\u064a\u0631',
          subtitle: context.l10n.bizRecurringCreditLeft(1, 10),
          avatarColor: Colors.orange,
          actions: [
            _ActionButton(
              label: context.l10n.bizRecurringRemind,
              color: Colors.purple,
              onTap: () => _showToast(
                context,
                context.l10n.bizRecurringReminderSent('\u062e\u0627\u0644\u062f'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Stat chip
// ═══════════════════════════════════════════════════════════════

class _StatChip extends StatelessWidget {
  final String text;
  final Color color;

  const _StatChip({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Customer action card
// ═══════════════════════════════════════════════════════════════

class _CustomerActionCard extends StatelessWidget {
  final String initial;
  final String name;
  final String subtitle;
  final Color avatarColor;
  final List<_ActionButton> actions;

  const _CustomerActionCard({
    required this.initial,
    required this.name,
    required this.subtitle,
    required this.avatarColor,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          // Action buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < actions.length; i++) ...[
                if (i > 0) const SizedBox(width: AppSpacing.xs),
                actions[i],
              ],
            ],
          ),
          const Spacer(),
          // Name + subtitle
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                name,
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.sm),
          // Avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: avatarColor.withValues(alpha: 0.12),
            child: Text(
              initial,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: avatarColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Action button
// ═══════════════════════════════════════════════════════════════

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 2),
              Icon(icon, size: 12, color: color),
            ],
          ],
        ),
      ),
    );
  }
}
