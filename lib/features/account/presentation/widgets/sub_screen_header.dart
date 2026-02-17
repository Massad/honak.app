import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_direction.dart';

/// Reusable header for account sub-screens.
///
/// Shows back arrow (forward arrow in RTL) + centered title + optional trailing.
class SubScreenHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback? onBack;

  const SubScreenHeader({
    super.key,
    required this.title,
    this.trailing,
    this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: context.colorScheme.outlineVariant,
                width: 1,
              ),
            ),
          ),
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.sm,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack ?? () => Navigator.of(context).pop(),
                icon: Icon(
                  AppDirection.backIcon(context),
                  size: 22,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  style: context.textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              if (trailing != null)
                trailing!
              else
                const SizedBox(width: 48),
            ],
          ),
        ),
      ),
    );
  }
}
