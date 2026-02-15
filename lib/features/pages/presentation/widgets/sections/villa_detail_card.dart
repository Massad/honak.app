import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:honak/features/pages/domain/entities/seasonal_pricing.dart';
import 'package:honak/features/pages/domain/seasonal_pricing_utils.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/widgets/app_image.dart';

/// Detailed card for villa/chalet reservation pages.
/// Shows gallery, pricing, info, amenities, house rules, and CTA.
class VillaDetailCard extends StatelessWidget {
  final PageDetail page;

  const VillaDetailCard({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final seasonal = page.seasonalPricing;
    final currentSeason =
        seasonal != null ? getCurrentSeason(seasonal.seasons) : null;
    final currentHoliday =
        seasonal != null ? getHolidayForDate(DateTime.now(), seasonal.holidays) : null;

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
                  child: AppImage(
                    url: page.galleryImages[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

        const SizedBox(height: AppSpacing.lg),

        // 1. Info chips — what is this place?
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

        // 2. Amenities
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

        // 3. House rules
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

        // 4. Pricing cards — only when no season card (avoids duplicate prices)
        if (page.pricing != null && currentSeason == null) ...[
          const SizedBox(height: AppSpacing.lg),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                Expanded(
                  child: _PricingCard(
                    label: 'أيام الأسبوع',
                    price: Money(
                      currentSeason?.weekdayCents ??
                          page.pricing!.weekdayCents,
                    ),
                    color: context.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _PricingCard(
                    label: 'نهاية الأسبوع',
                    price: Money(
                      currentSeason?.weekendCents ??
                          page.pricing!.weekendCents,
                    ),
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ],

        // 5. Current Season Card
        if (currentSeason != null) ...[
          const SizedBox(height: AppSpacing.md),
          _CurrentSeasonCard(
            season: currentSeason,
            holiday: currentHoliday,
            earlyBird: seasonal?.earlyBird,
          ),
        ],

        // 6. Last-Minute Deal Banner
        if (seasonal?.lastMinute != null && seasonal!.lastMinute!.active) ...[
          const SizedBox(height: AppSpacing.md),
          _LastMinuteBanner(
            deal: seasonal.lastMinute!,
            season: currentSeason,
            fallbackWeekdayCents: page.pricing?.weekdayCents ?? 0,
          ),
        ],

        // 7. Mini Season Timeline
        if (seasonal != null &&
            seasonal.seasons.where((s) => s.active).length > 1) ...[
          const SizedBox(height: AppSpacing.lg),
          _SeasonTimeline(seasons: seasonal.seasons),
        ],

        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// A. CURRENT SEASON CARD
// ─────────────────────────────────────────────────────────────

class _CurrentSeasonCard extends StatelessWidget {
  final SeasonRule season;
  final HolidaySurcharge? holiday;
  final EarlyBirdDiscount? earlyBird;

  const _CurrentSeasonCard({
    required this.season,
    this.holiday,
    this.earlyBird,
  });

  Color _parseColor() {
    try {
      final hex = season.color.replaceFirst('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _parseColor();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.12),
              color.withValues(alpha: 0.04),
            ],
            begin: AlignmentDirectional.topEnd,
            end: AlignmentDirectional.bottomStart,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Header row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'الموسم الحالي',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  season.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Icon(_resolveSeasonIcon(season.icon), size: 18, color: color),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            // Date range
            Text(
              formatSeasonRange(season),
              style: TextStyle(
                fontSize: 11,
                color: color.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // Season prices
            Row(
              children: [
                Expanded(
                  child: _SeasonPriceChip(
                    label: 'نهاية الأسبوع',
                    cents: season.weekendCents,
                    color: color,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _SeasonPriceChip(
                    label: 'أيام الأسبوع',
                    cents: season.weekdayCents,
                    color: color,
                  ),
                ),
              ],
            ),
            // Holiday notice
            if (holiday != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: Colors.orange.withValues(alpha: 0.25)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'رسوم إضافية ${holiday!.surchargePercent}٪ — ${holiday!.name}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.orange.shade800,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Icon(
                      Icons.celebration,
                      size: 14,
                      color: Colors.orange.shade700,
                    ),
                  ],
                ),
              ),
            ],
            // Early-bird notice
            if (earlyBird != null && earlyBird!.active) ...[
              const SizedBox(height: AppSpacing.sm),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: Colors.purple.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: Colors.purple.withValues(alpha: 0.2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'احجز قبل ${earlyBird!.daysAhead} يوم ووفّر ${earlyBird!.discountPercent}٪',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.purple.shade700,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: Colors.purple.shade600,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SeasonPriceChip extends StatelessWidget {
  final String label;
  final int cents;
  final Color color;

  const _SeasonPriceChip({
    required this.label,
    required this.cents,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7)),
          ),
          Text(
            Money(cents).toFormattedArabic(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            '/ ليلة',
            style: TextStyle(fontSize: 8, color: color.withValues(alpha: 0.5)),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// B. LAST-MINUTE DEAL BANNER
// ─────────────────────────────────────────────────────────────

class _LastMinuteBanner extends StatelessWidget {
  final LastMinuteDeal deal;
  final SeasonRule? season;
  final int fallbackWeekdayCents;

  const _LastMinuteBanner({
    required this.deal,
    this.season,
    required this.fallbackWeekdayCents,
  });

  @override
  Widget build(BuildContext context) {
    // Check if tomorrow qualifies as last-minute
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final daysUntil = tomorrow.difference(DateTime.now()).inDays;
    if (daysUntil > deal.daysAhead) return const SizedBox.shrink();

    final baseCents = season?.weekdayCents ?? fallbackWeekdayCents;
    final discountedCents =
        baseCents - (baseCents * deal.discountPercent / 100).round();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
            begin: AlignmentDirectional.centerStart,
            end: AlignmentDirectional.centerEnd,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Prices
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Money(baseCents).toFormattedArabic(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.white70,
                  ),
                ),
                Text(
                  Money(discountedCents).toFormattedArabic(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Deal info
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      deal.label,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    const Icon(Icons.local_fire_department,
                        size: 18, color: Colors.yellow),
                  ],
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'خصم ${deal.discountPercent}٪',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// C. MINI SEASON TIMELINE
// ─────────────────────────────────────────────────────────────

class _SeasonTimeline extends StatelessWidget {
  final List<SeasonRule> seasons;

  const _SeasonTimeline({required this.seasons});

  static const _monthLabelsAr = [
    'ينا',
    'فبر',
    'مار',
    'أبر',
    'ماي',
    'يون',
    'يول',
    'أغس',
    'سبت',
    'أكت',
    'نوف',
    'ديس',
  ];

  Color _parseColor(String hex) {
    try {
      final clean = hex.replaceFirst('#', '');
      return Color(int.parse('FF$clean', radix: 16));
    } catch (_) {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeSeasons = seasons.where((s) => s.active).toList();
    final currentMonth = DateTime.now().month;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'مواسم السنة',
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          // Month bar
          Row(
            children: List.generate(12, (i) {
              final month = i + 1;
              final season = getSeasonForMonth(month, activeSeasons);
              final isCurrent = month == currentMonth;
              final color =
                  season != null ? _parseColor(season.color) : Colors.grey.shade200;

              return Expanded(
                child: Container(
                  height: isCurrent ? 34 : 28,
                  margin: EdgeInsetsDirectional.only(
                    end: i < 11 ? 1.5 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: season != null
                        ? color.withValues(alpha: isCurrent ? 1.0 : 0.4)
                        : color,
                    borderRadius: BorderRadius.circular(3),
                    border: isCurrent
                        ? Border.all(
                            color: context.colorScheme.onSurface,
                            width: 1.5,
                          )
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _monthLabelsAr[i],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight:
                          isCurrent ? FontWeight.bold : FontWeight.normal,
                      color: season != null && isCurrent
                          ? Colors.white
                          : context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: AppSpacing.sm),
          // Legend — season name + color dot only
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.xs,
            alignment: WrapAlignment.end,
            children: activeSeasons.map((s) {
              final color = _parseColor(s.color);
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    s.name,
                    style: TextStyle(
                      fontSize: 11,
                      color: context.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// EXISTING HELPER WIDGETS
// ─────────────────────────────────────────────────────────────

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

// ─────────────────────────────────────────────────────────────
// SHARED ICON RESOLVER
// ─────────────────────────────────────────────────────────────

IconData _resolveSeasonIcon(String icon) {
  return switch (icon) {
    'wb_sunny' => Icons.wb_sunny,
    'ac_unit' => Icons.ac_unit,
    'local_florist' => Icons.local_florist,
    'park' => Icons.park,
    _ => Icons.calendar_today,
  };
}
