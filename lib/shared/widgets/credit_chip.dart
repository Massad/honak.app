import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Inline chip showing subscription credit status.
///
/// Color-coded by remaining percentage:
/// - Green: >50% remaining
/// - Amber: 20–50% remaining
/// - Red: <20% or depleted/expired
class CreditChip extends StatelessWidget {
  final int remainingCredits;
  final int totalCredits;
  final String creditLabel;
  final String? expiresAt;
  final String status; // active, paused, depleted, expired
  final VoidCallback? onTapHistory;
  final VoidCallback? onTapAction;

  const CreditChip({
    super.key,
    required this.remainingCredits,
    required this.totalCredits,
    required this.creditLabel,
    this.expiresAt,
    this.status = 'active',
    this.onTapHistory,
    this.onTapAction,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = _colorScheme;

    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: scheme.background,
        border: Border.all(color: scheme.border),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Icon(
            _statusIcon,
            size: 16,
            color: scheme.foreground,
          ),
          const SizedBox(width: AppSpacing.xs),

          // "N creditLabel متبقي"
          Flexible(
            child: Text(
              '$remainingCredits $creditLabel '
              // "متبقي"
              '\u0645\u062a\u0628\u0642\u064a',
              style: context.textTheme.labelSmall?.copyWith(
                color: scheme.foreground,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // CTA button
          if (onTapAction != null || onTapHistory != null) ...[
            const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: onTapHistory ?? onTapAction,
              child: Container(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.sm,
                  AppSpacing.xxs,
                  AppSpacing.sm,
                  AppSpacing.xxs,
                ),
                decoration: BoxDecoration(
                  color: scheme.foreground.withValues(alpha: 0.15),
                  borderRadius: AppRadius.pill,
                ),
                child: Text(
                  // "السجل"
                  '\u0627\u0644\u0633\u062c\u0644',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: scheme.foreground,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData get _statusIcon {
    switch (status) {
      case 'paused':
        return Icons.pause_circle_outline;
      case 'depleted':
      case 'expired':
        return Icons.error_outline;
      default:
        return Icons.check_circle_outline;
    }
  }

  _CreditColorScheme get _colorScheme {
    if (status == 'depleted' || status == 'expired') {
      return _CreditColorScheme.red;
    }

    if (totalCredits == 0) return _CreditColorScheme.red;

    final ratio = remainingCredits / totalCredits;
    if (ratio > 0.5) return _CreditColorScheme.green;
    if (ratio > 0.2) return _CreditColorScheme.amber;
    return _CreditColorScheme.red;
  }
}

class _CreditColorScheme {
  final Color background;
  final Color border;
  final Color foreground;

  const _CreditColorScheme({
    required this.background,
    required this.border,
    required this.foreground,
  });

  static const green = _CreditColorScheme(
    background: Color(0xFFF0FDF4), // green-50
    border: Color(0xFFBBF7D0), // green-200
    foreground: Color(0xFF16A34A), // green-600
  );

  static const amber = _CreditColorScheme(
    background: Color(0xFFFFFBEB), // amber-50
    border: Color(0xFFFDE68A), // amber-200
    foreground: Color(0xFFD97706), // amber-600
  );

  static const red = _CreditColorScheme(
    background: Color(0xFFFEF2F2), // red-50
    border: Color(0xFFFECACA), // red-200
    foreground: Color(0xFFDC2626), // red-600
  );
}
