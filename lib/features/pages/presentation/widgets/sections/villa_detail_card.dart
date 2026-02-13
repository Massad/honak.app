import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/widgets/cached_image.dart';

/// Detailed card for villa/chalet reservation pages.
/// Shows gallery, pricing, info, amenities, house rules, and CTA.
class VillaDetailCard extends StatelessWidget {
  final PageDetail page;

  const VillaDetailCard({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Gallery strip
        if (page.galleryImages.isNotEmpty)
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              itemCount: page.galleryImages.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 280,
                  child: CachedImage(
                    imageUrl: page.galleryImages[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

        const SizedBox(height: AppSpacing.lg),

        // Pricing cards
        if (page.pricing != null)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                Expanded(
                  child: _PricingCard(
                    label: 'أيام الأسبوع',
                    price: Money(page.pricing!.weekdayCents),
                    color: context.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _PricingCard(
                    label: 'نهاية الأسبوع',
                    price: Money(page.pricing!.weekendCents),
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: AppSpacing.lg),

        // Info chips
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              if (page.bedrooms != null)
                _InfoChip(
                  icon: Icons.bed_outlined,
                  label: '${page.bedrooms} غرف',
                ),
              if (page.bathrooms != null)
                _InfoChip(
                  icon: Icons.bathtub_outlined,
                  label: '${page.bathrooms} حمام',
                ),
              if (page.maxGuests != null)
                _InfoChip(
                  icon: Icons.people_outline,
                  label: '${page.maxGuests} ضيف',
                ),
              if (page.checkIn != null)
                _InfoChip(
                  icon: Icons.login,
                  label: 'دخول ${page.checkIn}',
                ),
              if (page.checkOut != null)
                _InfoChip(
                  icon: Icons.logout,
                  label: 'خروج ${page.checkOut}',
                ),
            ],
          ),
        ),

        // Amenities
        if (page.amenities.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              'المرافق',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: page.amenities
                  .map(
                    (amenity) => _AmenityBadge(amenity: amenity),
                  )
                  .toList(),
            ),
          ),
        ],

        // House rules
        if (page.houseRules.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              'قواعد المنزل',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              children: page.houseRules
                  .map(
                    (rule) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color:
                              Colors.amber.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color:
                                Colors.amber.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              size: 16,
                              color: Colors.amber.shade800,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                rule,
                                style: context.textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],

        // Book CTA
        const SizedBox(height: AppSpacing.xl),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                // TODO: Navigate to reservation request flow
              },
              icon: const Icon(Icons.calendar_today_outlined),
              label: Text(
                page.pricing != null
                    ? 'طلب حجز — من ${Money(page.pricing!.weekdayCents).toFormattedArabic()}/ليلة'
                    : 'طلب حجز',
              ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.lg,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

class _PricingCard extends StatelessWidget {
  final String label;
  final Money price;
  final Color color;

  const _PricingCard({
    required this.label,
    required this.price,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: color,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'من ${price.toFormattedArabic()}',
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            '/ ليلة',
            style: context.textTheme.labelSmall?.copyWith(
              color: color.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: context.colorScheme.onSurfaceVariant),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _AmenityBadge extends StatelessWidget {
  final Amenity amenity;

  const _AmenityBadge({required this.amenity});

  IconData _resolveIcon() {
    return switch (amenity.icon) {
      'pool' => Icons.pool,
      'wifi' => Icons.wifi,
      'parking' => Icons.local_parking,
      'ac' => Icons.ac_unit,
      'garden' => Icons.yard,
      'bbq' => Icons.outdoor_grill,
      'tv' => Icons.tv,
      'kitchen' => Icons.kitchen,
      'washer' => Icons.local_laundry_service,
      'gym' => Icons.fitness_center,
      'playground' => Icons.child_care,
      'fireplace' => Icons.fireplace,
      _ => Icons.check_circle_outline,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _resolveIcon(),
            size: 16,
            color: context.colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            amenity.label,
            style: context.textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
