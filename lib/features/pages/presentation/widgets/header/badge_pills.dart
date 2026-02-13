import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/theme/app_radius.dart';

/// Row of badge pills: business type, category, approval, store type.
/// Business type and category pills are tappable and navigate to explore.
class BadgePills extends StatelessWidget {
  final String? businessTypeName;
  final String? categoryName;
  final bool requiresApproval;
  final String? storeType;
  final ValueChanged<String>? onSearchType;
  final ValueChanged<String>? onSearchCategory;

  const BadgePills({
    super.key,
    this.businessTypeName,
    this.categoryName,
    this.requiresApproval = false,
    this.storeType,
    this.onSearchType,
    this.onSearchCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.xs,
      children: [
        if (businessTypeName != null)
          _Pill(
            color: context.colorScheme.primary,
            label: businessTypeName!,
            icon: Icons.storefront,
            showTrailingSearch: onSearchType != null,
            onTap: onSearchType != null
                ? () => onSearchType!(businessTypeName!)
                : null,
          ),
        if (categoryName != null)
          _Pill(
            color: Colors.grey.shade600,
            label: categoryName!,
            showTrailingSearch: onSearchCategory != null,
            onTap: onSearchCategory != null
                ? () => onSearchCategory!(categoryName!)
                : null,
          ),
        if (requiresApproval)
          _Pill(
            color: Colors.amber.shade700,
            label: '\u064a\u062d\u062a\u0627\u062c \u0645\u0648\u0627\u0641\u0642\u0629',
            icon: Icons.assignment_outlined,
          ),
        if (storeType != null)
          _Pill(
            color: _storeTypeColor(storeType!),
            label: _storeTypeLabel(storeType!),
          ),
      ],
    );
  }

  static Color _storeTypeColor(String type) => switch (type) {
    'online' => Colors.purple,
    'hybrid' => Colors.indigo,
    _ => Colors.grey.shade600,
  };

  static String _storeTypeLabel(String type) => switch (type) {
    'physical' => '\u0645\u062d\u0644',
    'online' => '\u0623\u0648\u0646\u0644\u0627\u064a\u0646',
    'hybrid' => '\u0645\u062d\u0644 + \u0623\u0648\u0646\u0644\u0627\u064a\u0646',
    _ => type,
  };
}

class _Pill extends StatelessWidget {
  final Color color;
  final String label;
  final IconData? icon;
  final bool showTrailingSearch;
  final VoidCallback? onTap;

  const _Pill({
    required this.color,
    required this.label,
    this.icon,
    this.showTrailingSearch = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final pill = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: AppRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          if (showTrailingSearch) ...[
            SizedBox(width: AppSpacing.xs),
            Icon(Icons.search, size: 8, color: color),
          ],
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: pill);
    }
    return pill;
  }
}
