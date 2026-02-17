import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/shared/widgets/app_list_item.dart';

class AccountMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback? onTap;

  const AccountMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppListItem(
      title: label,
      subtitle: subtitle,
      leading: Icon(
        icon,
        size: 20,
        color: context.colorScheme.onSurfaceVariant,
      ),
      titleStyle: context.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.colorScheme.onSurface,
      ),
      affordance: AppListItemAffordance.chevron,
      onTap: onTap,
    );
  }
}
