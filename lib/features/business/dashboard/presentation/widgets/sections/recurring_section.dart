import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

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
              '\u0627\u0644\u0639\u0645\u0644\u0627\u0621 \u0627\u0644\u0645\u062a\u0643\u0631\u0631\u0648\u0646',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            btn.Button(
              onPressed: () => _showToast(
                context,
                '\u0642\u0631\u064a\u0628\u0627\u064b \u2014 \u0639\u0631\u0636 \u0627\u0644\u0643\u0644',
              ),
              label: '\u0639\u0631\u0636 \u0627\u0644\u0643\u0644',
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
              text: '5 \u0641\u0639\u0651\u0627\u0644',
              color: AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.sm),
            _StatChip(
              text: '2 \u062a\u0644\u0642\u0627\u0626\u064a',
              color: AppColors.success,
            ),
            const SizedBox(width: AppSpacing.sm),
            _StatChip(
              text: '3 \u062a\u0630\u0643\u064a\u0631',
              color: Colors.purple,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Auto orders subtitle
        Text(
          '\u0627\u0644\u0637\u0644\u0628\u0627\u062a \u0627\u0644\u062a\u0644\u0642\u0627\u0626\u064a\u0629 \u0627\u0644\u064a\u0648\u0645',
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
          subtitle:
              '\u0637\u0644\u0628 \u062a\u0644\u0642\u0627\u0626\u064a \u2014 2 \u0642\u0648\u0627\u0631\u064a\u0631',
          avatarColor: AppColors.primary,
          actions: [
            _ActionButton(
              label: '\u062a\u0623\u0643\u064a\u062f',
              icon: Icons.check,
              color: AppColors.success,
              onTap: () => _showToast(
                context,
                '\u062a\u0645 \u062a\u0623\u0643\u064a\u062f \u0637\u0644\u0628 \u0633\u0627\u0631\u0629',
              ),
            ),
            _ActionButton(
              label: '\u062a\u062e\u0637\u064a',
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              onTap: () => _showToast(
                context,
                '\u062a\u0645 \u062a\u062e\u0637\u064a \u0637\u0644\u0628 \u0633\u0627\u0631\u0629',
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
          subtitle:
              '\u0637\u0644\u0628 \u062a\u0644\u0642\u0627\u0626\u064a \u2014 3 \u0642\u0648\u0627\u0631\u064a\u0631',
          avatarColor: Colors.teal,
          actions: [
            _ActionButton(
              label: '\u062a\u0623\u0643\u064a\u062f',
              icon: Icons.check,
              color: AppColors.success,
              onTap: () => _showToast(
                context,
                '\u062a\u0645 \u062a\u0623\u0643\u064a\u062f \u0637\u0644\u0628 \u0623\u062d\u0645\u062f',
              ),
            ),
            _ActionButton(
              label: '\u062a\u062e\u0637\u064a',
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              onTap: () => _showToast(
                context,
                '\u062a\u0645 \u062a\u062e\u0637\u064a \u0637\u0644\u0628 \u0623\u062d\u0645\u062f',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Low credit subtitle
        Text(
          '\u0631\u0635\u064a\u062f \u0645\u0646\u062e\u0641\u0636',
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
          subtitle:
              '\u0645\u062a\u0628\u0642\u064a 1 \u0645\u0646 10 \u062a\u0648\u0635\u064a\u0644\u0629',
          avatarColor: Colors.orange,
          actions: [
            _ActionButton(
              label: '\u062a\u0630\u0643\u064a\u0631',
              color: Colors.purple,
              onTap: () => _showToast(
                context,
                '\u062a\u0645 \u0625\u0631\u0633\u0627\u0644 \u062a\u0630\u0643\u064a\u0631 \u0644\u062e\u0627\u0644\u062f',
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
