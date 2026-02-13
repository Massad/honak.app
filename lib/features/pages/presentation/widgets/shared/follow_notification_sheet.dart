import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/features/pages/presentation/widgets/shared/follow_button.dart';

/// Styled bottom sheet for follow notification level selection.
/// Matches Figma FollowSettingsSheet exactly.
class FollowNotificationSheet extends StatelessWidget {
  final String pageName;
  final FollowLevel currentLevel;
  final ValueChanged<FollowLevel?> onChanged;

  const FollowNotificationSheet({
    super.key,
    required this.pageName,
    required this.currentLevel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.colorScheme.outlineVariant,
                borderRadius: AppRadius.pill,
              ),
            ),
            SizedBox(height: AppSpacing.lg),

            // Header
            Row(
              children: [
                Expanded(
                  child: Text(
                    pageName.isNotEmpty
                        ? '\u0625\u0634\u0639\u0627\u0631\u0627\u062a $pageName'
                        : '\u0625\u0634\u0639\u0627\u0631\u0627\u062a \u0647\u0630\u0647 \u0627\u0644\u0635\u0641\u062d\u0629',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainerHighest,
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
            SizedBox(height: AppSpacing.md),

            // Options
            _OptionRow(
              icon: Icons.notifications_active_outlined,
              title: '\u0627\u0644\u0643\u0644',
              description:
                  '\u0643\u0644 \u0645\u0646\u0634\u0648\u0631\u060c \u0639\u0631\u0636\u060c \u062a\u062d\u062f\u064a\u062b',
              isSelected: currentLevel == FollowLevel.all,
              onTap: () {
                onChanged(FollowLevel.all);
                Navigator.pop(context);
              },
            ),
            SizedBox(height: AppSpacing.xxs),
            _OptionRow(
              icon: Icons.notifications_outlined,
              title:
                  '\u0627\u0644\u0645\u0647\u0645 \u0641\u0642\u0637',
              description:
                  '\u0627\u0644\u0639\u0631\u0648\u0636\u060c \u0645\u0646\u062a\u062c\u0627\u062a \u062c\u062f\u064a\u062f\u0629\u060c \u0625\u0639\u0644\u0627\u0646\u0627\u062a',
              isSelected: currentLevel == FollowLevel.importantOnly,
              onTap: () {
                onChanged(FollowLevel.importantOnly);
                Navigator.pop(context);
              },
            ),
            SizedBox(height: AppSpacing.xxs),
            _OptionRow(
              icon: Icons.notifications_off_outlined,
              title:
                  '\u0628\u062f\u0648\u0646 \u0625\u0634\u0639\u0627\u0631\u0627\u062a',
              description:
                  '\u062a\u0638\u0647\u0631 \u0641\u064a \u0627\u0644\u062e\u0644\u0627\u0635\u0629 \u0641\u0642\u0637',
              isSelected: currentLevel == FollowLevel.none,
              onTap: () {
                onChanged(FollowLevel.none);
                Navigator.pop(context);
              },
            ),
            SizedBox(height: AppSpacing.md),

            // Info note
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.5),
                borderRadius: AppRadius.cardInner,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 14,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      '\u0625\u0634\u0639\u0627\u0631\u0627\u062a \u0627\u0644\u0637\u0644\u0628\u0627\u062a \u062a\u0635\u0644 \u062f\u0627\u0626\u0645\u0627\u064b \u0628\u063a\u0636 \u0627\u0644\u0646\u0638\u0631 \u0639\u0646 \u0647\u0630\u0627 \u0627\u0644\u0625\u0639\u062f\u0627\u062f',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.md),

            // Divider
            const Divider(height: 1),
            SizedBox(height: AppSpacing.md),

            // Unfollow row — matching Figma: red-50 circle + red label + gray subtitle
            GestureDetector(
              onTap: () {
                onChanged(null);
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  borderRadius: AppRadius.cardInner,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person_remove_outlined,
                        size: 18,
                        color: Colors.red.shade600,
                      ),
                    ),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\u0625\u0644\u063a\u0627\u0621 \u0627\u0644\u0645\u062a\u0627\u0628\u0639\u0629',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: Colors.red.shade600,
                            ),
                          ),
                          Text(
                            '\u0644\u0646 \u062a\u0638\u0647\u0631 \u0645\u0646\u0634\u0648\u0631\u0627\u062a\u0647\u0627 \u0641\u064a \u062e\u0644\u0627\u0635\u062a\u0643',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Option row — no border/bg when unselected, blue-50 bg when selected.
/// 36x36 circular icon, label + description, checkmark at end when selected.
class _OptionRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionRow({
    required this.icon,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected ? primary.withValues(alpha: 0.06) : null,
          borderRadius: AppRadius.cardInner,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isSelected
                    ? primary
                    : context.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 18,
                color: isSelected
                    ? Colors.white
                    : context.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: isSelected ? primary : null,
                    ),
                  ),
                  Text(
                    description,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check, color: primary, size: 18),
          ],
        ),
      ),
    );
  }
}
