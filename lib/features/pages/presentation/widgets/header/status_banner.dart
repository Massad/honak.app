import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';

/// Status banner for temporarily closed, relocated, or permanently closed pages.
class StatusBanner extends StatelessWidget {
  final TemporarilyClosed? temporarilyClosed;
  final Relocated? relocated;
  final bool permanentlyClosed;

  const StatusBanner({
    super.key,
    this.temporarilyClosed,
    this.relocated,
    this.permanentlyClosed = false,
  });

  @override
  Widget build(BuildContext context) {
    if (permanentlyClosed) {
      return _Banner(
        color: Colors.grey,
        icon: Icons.warning_amber_rounded,
        title: '\u0645\u063a\u0644\u0642 \u0646\u0647\u0627\u0626\u064a\u0627\u064b',
        subtitle: '\u0647\u0630\u0647 \u0627\u0644\u0635\u0641\u062d\u0629 \u0644\u0645 \u062a\u0639\u062f \u0646\u0634\u0637\u0629',
      );
    }

    if (temporarilyClosed != null) {
      return _Banner(
        color: Colors.orange,
        icon: Icons.lock_outlined,
        title: '\u0645\u063a\u0644\u0642 \u0645\u0624\u0642\u062a\u0627\u064b',
        subtitle: temporarilyClosed!.reason,
        trailing: temporarilyClosed!.reopenDate != null
            ? '\u064a\u0641\u062a\u062d: ${temporarilyClosed!.reopenDate}'
            : null,
      );
    }

    if (relocated != null) {
      return _Banner(
        color: Colors.blue,
        icon: Icons.pin_drop_outlined,
        title: '\u0627\u0646\u062a\u0642\u0644 \u0644\u0645\u0648\u0642\u0639 \u062c\u062f\u064a\u062f',
        subtitle: relocated!.newAddress,
        actionLabel: '\u0639\u0631\u0636 \u0627\u0644\u062e\u0631\u064a\u0637\u0629',
        onAction: () {
          // TODO: open map URL
        },
      );
    }

    return const SizedBox.shrink();
  }
}

class _Banner extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? trailing;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _Banner({
    required this.color,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: AppSpacing.xxs),
                  Text(
                    subtitle!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                if (trailing != null) ...[
                  SizedBox(height: AppSpacing.xxs),
                  Text(
                    trailing!,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (actionLabel != null)
            TextButton(
              onPressed: onAction,
              child: Text(actionLabel!, style: TextStyle(color: color)),
            ),
        ],
      ),
    );
  }
}
