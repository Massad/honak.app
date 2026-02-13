import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Amber/orange warning strip indicating the business does not cover the
/// user's area. Shows up to 5 coverage area pills and a "show map" link.
class CoverageBanner extends StatelessWidget {
  final List<String> coverageAreas;
  final String? userArea;
  final VoidCallback? onShowMap;

  const CoverageBanner({
    super.key,
    required this.coverageAreas,
    this.userArea,
    this.onShowMap,
  });

  @override
  Widget build(BuildContext context) {
    if (coverageAreas.isEmpty) return const SizedBox.shrink();

    final visibleAreas = coverageAreas.take(5).toList();
    final remaining = coverageAreas.length - visibleAreas.length;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB), // amber-50
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(AppRadius.sm),
          bottomEnd: Radius.circular(AppRadius.sm),
        ),
        border: BorderDirectional(
          start: BorderSide(
            color: const Color(0xFFF59E0B), // amber-500
            width: 4,
          ),
        ),
      ),
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Warning text
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 18,
                color: const Color(0xFFD97706), // amber-600
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  userArea != null
                      // "لا يغطي منطقتك حالياً ({userArea})"
                      ? '\u0644\u0627 \u064a\u063a\u0637\u064a \u0645\u0646\u0637\u0642\u062a\u0643 \u062d\u0627\u0644\u064a\u0627\u064b ($userArea)'
                      // "لا يغطي منطقتك حالياً"
                      : '\u0644\u0627 \u064a\u063a\u0637\u064a \u0645\u0646\u0637\u0642\u062a\u0643 \u062d\u0627\u0644\u064a\u0627\u064b',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF92400E), // amber-800
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // Coverage area pills
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              for (final area in visibleAreas) _AreaPill(name: area),
              if (remaining > 0)
                _AreaPill(name: '+$remaining', isOverflow: true),
            ],
          ),

          // "Show coverage map" link
          if (onShowMap != null) ...[
            const SizedBox(height: AppSpacing.sm),
            GestureDetector(
              onTap: onShowMap,
              child: Text(
                // "عرض خريطة التغطية"
                '\u0639\u0631\u0636 \u062e\u0631\u064a\u0637\u0629 \u0627\u0644\u062a\u063a\u0637\u064a\u0629',
                style: context.textTheme.labelSmall?.copyWith(
                  color: const Color(0xFFD97706), // amber-600
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFFD97706),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AreaPill extends StatelessWidget {
  final String name;
  final bool isOverflow;

  const _AreaPill({required this.name, this.isOverflow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.sm,
        AppSpacing.xxs,
        AppSpacing.sm,
        AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: isOverflow
            ? const Color(0xFFFDE68A) // amber-200
            : const Color(0xFFFEF3C7), // amber-100
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        name,
        style: context.textTheme.labelSmall?.copyWith(
          color: const Color(0xFF92400E), // amber-800
          fontSize: 11,
        ),
      ),
    );
  }
}
