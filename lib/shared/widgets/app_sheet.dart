import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

// ═══════════════════════════════════════════════════════════════
// AppSheetOverlay — inline overlay positioned above bottom nav
// ═══════════════════════════════════════════════════════════════

/// A full-screen overlay that shows a bottom sheet panel **above** the
/// bottom navigation bar. Use this inside a [Stack] within any business
/// mode page. The scrim covers only the page body; the nav bar stays visible.
///
/// For modal sheets that can overlap the nav bar (e.g. in customer mode),
/// use [showAppSheet] instead.
class AppSheetOverlay extends StatelessWidget {
  final Widget child;
  final VoidCallback onDismiss;
  final bool isDismissible;

  const AppSheetOverlay({
    super.key,
    required this.child,
    required this.onDismiss,
    this.isDismissible = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDismissible ? onDismiss : null,
      child: Container(
        color: Colors.black.withValues(alpha: 0.3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {}, // absorb taps on the sheet itself
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SafeArea(top: false, child: child),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// AppSheetHeader — standard drag handle + title + close button
// ═══════════════════════════════════════════════════════════════

/// Standard header for bottom sheets: drag handle, optional title, close btn.
class AppSheetHeader extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final VoidCallback? onClose;

  const AppSheetHeader({super.key, this.title, this.leading, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: AppSpacing.lg),
            decoration: BoxDecoration(
              color: context.colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title row
          if (title != null || leading != null || onClose != null)
            Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  const SizedBox(width: AppSpacing.sm),
                ],
                if (title != null)
                  Expanded(
                    child: Text(
                      title!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  const Spacer(),
                if (onClose != null)
                  GestureDetector(
                    onTap: onClose,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerLow,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// AppSheetScaffold — standard sheet structure
// ═══════════════════════════════════════════════════════════════

/// Standardized sheet layout with optional header and sticky footer.
class AppSheetScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? footer;
  final Widget? leading;
  final VoidCallback? onClose;
  final EdgeInsetsGeometry bodyPadding;
  final EdgeInsetsGeometry footerPadding;
  final bool scrollable;
  final bool showHeader;
  final bool showBodyDivider;
  final bool showFooterDivider;
  final bool keyboardSafe;
  final double maxHeightFraction;

  const AppSheetScaffold({
    super.key,
    this.title,
    required this.body,
    this.footer,
    this.leading,
    this.onClose,
    this.bodyPadding = const EdgeInsetsDirectional.fromSTEB(
      AppSpacing.lg,
      0,
      AppSpacing.lg,
      AppSpacing.lg,
    ),
    this.footerPadding = const EdgeInsetsDirectional.fromSTEB(
      AppSpacing.lg,
      0,
      AppSpacing.lg,
      AppSpacing.lg,
    ),
    this.scrollable = true,
    this.showHeader = true,
    this.showBodyDivider = false,
    this.showFooterDivider = true,
    this.keyboardSafe = true,
    this.maxHeightFraction = 0.9,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final keyboardBottomInset = keyboardSafe
        ? mediaQuery.viewInsets.bottom
        : 0.0;
    final header = showHeader
        ? AppSheetHeader(
            title: title,
            leading: leading,
            onClose: onClose ?? () => Navigator.of(context).pop(),
          )
        : null;

    final bodyContent = scrollable
        ? SingleChildScrollView(padding: bodyPadding, child: body)
        : Padding(padding: bodyPadding, child: body);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: mediaQuery.size.height * maxHeightFraction,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (header != null) header,
          if (showBodyDivider && header != null) const Divider(height: 1),
          Flexible(fit: FlexFit.loose, child: bodyContent),
          if (footer != null) ...[
            if (showFooterDivider) const Divider(height: 1),
            AnimatedPadding(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(bottom: keyboardBottomInset),
              child: SafeArea(
                top: false,
                child: Padding(padding: footerPadding, child: footer),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// showAppSheet — modal bottom sheet with consistent styling
// ═══════════════════════════════════════════════════════════════

/// Shows a modal bottom sheet with standard app styling and auto-expand.
///
/// The sheet uses `MainAxisSize.min` + `Flexible(fit: FlexFit.loose)` so it
/// auto-sizes to its content and scrolls only when content exceeds
/// [maxHeightFraction] of the screen. When content changes (e.g. new form
/// fields appear), the sheet height adjusts automatically.
///
/// Includes rounded top corners, keyboard-aware bottom padding, and SafeArea.
Future<T?> showAppSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  bool isDismissible = true,
  bool enableDrag = true,
  double maxHeightFraction = 0.9,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      final viewInsets = MediaQuery.of(ctx).viewInsets;
      return Padding(
        padding: EdgeInsets.only(bottom: viewInsets.bottom),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(ctx).size.height * maxHeightFraction,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(ctx).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppRadius.xxl),
              ),
            ),
            child: SafeArea(top: false, child: builder(ctx)),
          ),
        ),
      );
    },
  );
}
