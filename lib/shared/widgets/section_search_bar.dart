import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Unified search bar for section widgets (catalog, menu, service booking).
///
/// Renders a styled [TextField] with search icon, optional clear button,
/// and optional trailing widget (e.g. a filter button for catalog).
class SectionSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;

  /// If non-null, shows a clear button when text is non-empty.
  final VoidCallback? onClear;

  /// Trailing widget (e.g. filter button for catalog).
  final Widget? trailing;

  const SectionSearchBar({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.controller,
    this.onClear,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final textField = TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
          fontSize: 14,
        ),
        prefixIcon: Icon(
          Icons.search,
          size: 20,
          color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
        ),
        suffixIcon: _buildSuffixIcon(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor:
            context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.7),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        isDense: true,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: trailing != null
          ? Row(
              children: [
                Expanded(child: textField),
                const SizedBox(width: AppSpacing.sm),
                trailing!,
              ],
            )
          : textField,
    );
  }

  Widget? _buildSuffixIcon(BuildContext context) {
    if (onClear == null || controller == null) return null;
    if (controller!.text.isEmpty) return null;
    return IconButton(
      icon: Icon(
        Icons.close,
        size: 18,
        color: context.colorScheme.onSurfaceVariant,
      ),
      onPressed: onClear,
    );
  }
}
