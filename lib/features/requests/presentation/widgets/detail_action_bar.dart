import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_image.dart';

/// Container for action buttons at the bottom of request detail page.
class DetailActionBar extends StatelessWidget {
  final List<Widget> children;

  const DetailActionBar({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.lg,
        end: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(
          top: BorderSide(color: cs.outlineVariant, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}

/// Outlined action button (full width).
class DetailOutlinedAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const DetailOutlinedAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 16),
          label: Text(label),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.button,
            ),
          ),
        ),
      ),
    );
  }
}

/// Text action button (for destructive actions like cancel).
class DetailTextAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const DetailTextAction({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 14, color: color),
      label: Text(label, style: TextStyle(color: color)),
    );
  }
}

/// Section card with border and background.
class DetailSectionCard extends StatelessWidget {
  final Widget child;

  const DetailSectionCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: child,
    );
  }
}

/// Business info card with avatar and name.
class DetailBusinessCard extends StatelessWidget {
  final String businessName;
  final String? businessAvatarUrl;

  const DetailBusinessCard({
    super.key,
    required this.businessName,
    this.businessAvatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          AppImage.avatar(
            url: businessAvatarUrl,
            name: businessName,
            radius: 24,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              businessName,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: cs.onSurface,
                  ),
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: 20,
            color: cs.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

/// Decline / cancellation reason card (red).
class DetailDeclineCard extends StatelessWidget {
  final String reason;
  final bool isCancellation;
  final String? businessName;

  const DetailDeclineCard({
    super.key,
    required this.reason,
    this.isCancellation = false,
    this.businessName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.05),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
        borderRadius: AppRadius.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.cancel_outlined,
                size: 18,
                color: AppColors.error,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                isCancellation
                    ? 'تم الإلغاء من قبل ${businessName ?? 'المتجر'}'
                    : 'تم رفض الطلب',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.6),
              borderRadius: AppRadius.cardInner,
            ),
            child: Text(
              'السبب: $reason',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
