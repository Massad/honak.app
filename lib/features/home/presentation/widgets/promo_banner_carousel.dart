import 'dart:async';

import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_direction.dart';

class PromoBannerCarousel extends StatefulWidget {
  const PromoBannerCarousel({super.key});

  @override
  State<PromoBannerCarousel> createState() => _PromoBannerCarouselState();
}

class _PromoBannerCarouselState extends State<PromoBannerCarousel> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  static const _banners = [
    _PromoBanner(
      gradientStart: Color(0xFFE53935),
      gradientEnd: Color(0xFFFF6B47),
      titleAr: 'عروض جديدة كل يوم',
      titleEn: 'New offers every day',
      subtitleAr: 'اكتشف أفضل العروض المحلية',
      subtitleEn: 'Discover the best local offers',
      imageAsset: 'assets/images/promo_offers.png',
    ),
    _PromoBanner(
      gradientStart: Color(0xFF1A73E8),
      gradientEnd: Color(0xFF4DA3FF),
      titleAr: 'اكتشف أعمال قريبة',
      titleEn: 'Discover nearby businesses',
      subtitleAr: 'اعثر على ما تحتاجه حولك',
      subtitleEn: 'Find what you need around you',
      imageAsset: 'assets/images/promo_discover.png',
    ),
    _PromoBanner(
      gradientStart: Color(0xFFFF9800),
      gradientEnd: Color(0xFFFFB74D),
      titleAr: 'وفّر مع هناك.app',
      titleEn: 'Save with honak.app',
      subtitleAr: 'خصومات حصرية على أول طلب',
      subtitleEn: 'Exclusive discounts on first order',
      imageAsset: 'assets/images/promo_save.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoRotation();
  }

  void _startAutoRotation() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final nextPage = (_currentPage + 1) % _banners.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = context.isRtl;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        children: [
          SizedBox(
            height: 140,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemCount: _banners.length,
              itemBuilder: (context, index) {
                final banner = _banners[index];
                return _BannerCard(banner: banner, isRtl: isRtl);
              },
            ),
          ),
          SizedBox(height: AppSpacing.sm + 2), // 10px
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_banners.length, (index) {
              final isActive = index == _currentPage;
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 3),
                width: isActive ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive
                      ? context.colorScheme.primary
                      : context.colorScheme.outline,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  final _PromoBanner banner;
  final bool isRtl;

  const _BannerCard({required this.banner, required this.isRtl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [banner.gradientStart, banner.gradientEnd],
          begin: AlignmentDirectional.centerStart,
          end: AlignmentDirectional.centerEnd,
        ),
        boxShadow: [
          BoxShadow(
            color: banner.gradientStart.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          // Text side
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isCompact = constraints.maxHeight <= 110;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Icon + label
                      Row(
                        children: [
                          Icon(
                            Icons.local_offer_outlined,
                            size: isCompact ? 12 : 14,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                          SizedBox(width: AppSpacing.xs),
                          Text(
                            isRtl ? 'هناك.app' : 'honak.app',
                            style: TextStyle(
                              fontSize: isCompact ? 9 : 10,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isCompact ? 4 : 6),
                      // Title
                      Text(
                        isRtl ? banner.titleAr : banner.titleEn,
                        style: TextStyle(
                          fontSize: isCompact ? 16 : 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.1,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isCompact ? 4 : 6),
                      // Subtitle
                      Text(
                        isRtl ? banner.subtitleAr : banner.subtitleEn,
                        style: TextStyle(
                          fontSize: isCompact ? 11 : 12,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      // CTA button
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                          vertical: isCompact ? 5 : AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isRtl ? 'تصفّح الآن' : 'Browse now',
                              style: TextStyle(
                                fontSize: isCompact ? 11 : 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: AppSpacing.xs),
                            Icon(
                              AppDirection.forwardIcon(context),
                              size: isCompact ? 11 : 12,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          // Image side
          SizedBox(
            width: 120,
            child: Stack(
              children: [
                // Placeholder gradient (images may not exist yet)
                Container(
                  width: 120,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  child: Icon(
                    Icons.storefront_outlined,
                    size: 48,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
                // Edge gradient overlay
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.centerStart,
                        end: AlignmentDirectional.centerEnd,
                        colors: [
                          banner.gradientEnd.withValues(alpha: 0.8),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.4],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoBanner {
  final Color gradientStart;
  final Color gradientEnd;
  final String titleAr;
  final String titleEn;
  final String subtitleAr;
  final String subtitleEn;
  final String imageAsset;

  const _PromoBanner({
    required this.gradientStart,
    required this.gradientEnd,
    required this.titleAr,
    required this.titleEn,
    required this.subtitleAr,
    required this.subtitleEn,
    required this.imageAsset,
  });
}
