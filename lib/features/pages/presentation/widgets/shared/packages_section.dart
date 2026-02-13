import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:honak/features/pages/presentation/widgets/shared/package_detail_sheet.dart';
import 'package:honak/shared/entities/money.dart';

/// Horizontal scrollable section of package cards for the customer page view.
///
/// Shown for catalog_order, menu_order, and service_booking archetypes
/// when the page has packages.
class PackagesSection extends StatelessWidget {
  final List<Package> packages;
  final String archetype;
  final String? pageName;
  final int? existingCredits;
  final String? existingCreditLabel;

  const PackagesSection({
    super.key,
    required this.packages,
    required this.archetype,
    this.pageName,
    this.existingCredits,
    this.existingCreditLabel,
  });

  @override
  Widget build(BuildContext context) {
    final active = packages.where((p) => p.active).toList();
    if (active.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.sm,
          ),
          child: Row(
            children: [
              Icon(
                Icons.card_membership_outlined,
                size: 18,
                color: context.colorScheme.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'الباقات والاشتراكات',
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        // Horizontal scroll
        SizedBox(
          height: 280,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.sm,
            ),
            itemCount: active.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
            itemBuilder: (context, index) {
              return _PackageCard(
                pkg: active[index],
                archetype: archetype,
                onTap: () => showPackageDetailSheet(
                  context,
                  pkg: active[index],
                  archetype: archetype,
                  pageName: pageName,
                  existingCredits: existingCredits,
                  existingCreditLabel: existingCreditLabel,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PackageCard extends StatelessWidget {
  final Package pkg;
  final String archetype;
  final VoidCallback onTap;

  const _PackageCard({
    required this.pkg,
    required this.archetype,
    required this.onTap,
  });

  int? get _savingsPercent {
    if (pkg.compareSinglePrice == null || pkg.compareSinglePrice == 0) {
      return null;
    }
    if (pkg.credits <= 0) return null;
    final regularTotal = pkg.compareSinglePrice! * pkg.credits;
    if (regularTotal <= pkg.priceCents) return null;
    return (((regularTotal - pkg.priceCents) / regularTotal) * 100).round();
  }

  String get _ctaLabel {
    if (pkg.model == 'bundle') {
      return archetype == 'service_booking' ? 'احجز الآن' : 'اطلب الآن';
    }
    if (pkg.model == 'date_only') return 'اشترك';
    return 'شراء الباقة';
  }

  @override
  Widget build(BuildContext context) {
    final savings = _savingsPercent;
    final price = Money(pkg.priceCents);
    final perUnit = pkg.credits > 0
        ? Money((pkg.priceCents / pkg.credits).round())
        : null;
    final isBundle = pkg.model == 'bundle';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: context.colorScheme.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF), // blue-50
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Center(
                child: Text(
                  iconEmojiForPackage(pkg.icon),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Name
            SizedBox(
              height: 34,
              child: Text(
                pkg.name,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.end,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Description
            if (pkg.description != null && pkg.description!.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xxs),
              Text(
                pkg.description!,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  fontSize: 11,
                ),
                textAlign: TextAlign.end,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            // Savings badge
            if (savings != null && savings > 0) ...[
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xxs,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: AppRadius.pill,
                ),
                child: Text(
                  'وفّر $savings%',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.success,
                  ),
                ),
              ),
            ],

            const Spacer(),

            // Price
            Text(
              price.toFormattedArabic(),
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (perUnit != null && pkg.creditLabel != null) ...[
              Text(
                '(${perUnit.toJodString()}/${pkg.creditLabel})',
                style: TextStyle(
                  fontSize: 11,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.sm),

            // CTA button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                color: isBundle ? null : AppColors.primary,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: isBundle
                    ? Border.all(color: AppColors.primary)
                    : null,
              ),
              child: Text(
                _ctaLabel,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isBundle ? AppColors.primary : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String iconEmojiForPackage(String icon) => switch (icon) {
      'water-drop' => '💧',
      'car' => '🚗',
      'fitness' => '💪',
      'restaurant' => '🍽️',
      'sparkles' => '✨',
      'coffee' => '☕',
      'scissors' => '✂️',
      'book' => '📚',
      _ => '📦',
    };
