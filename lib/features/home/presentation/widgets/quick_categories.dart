import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';

class QuickCategories extends StatelessWidget {
  const QuickCategories({super.key});

  static const _categories = [
    _Category(icon: Icons.restaurant, color: Color(0xFFFF9800), labelAr: 'طعام', labelEn: 'Food'),
    _Category(icon: Icons.delivery_dining, color: Color(0xFF1A73E8), labelAr: 'توصيل', labelEn: 'Delivery'),
    _Category(icon: Icons.shopping_bag, color: Color(0xFFE91E63), labelAr: 'تسوّق', labelEn: 'Retail'),
    _Category(icon: Icons.face, color: Color(0xFF9C27B0), labelAr: 'تجميل', labelEn: 'Beauty'),
    _Category(icon: Icons.build, color: Color(0xFF43A047), labelAr: 'خدمات', labelEn: 'Services'),
    _Category(icon: Icons.local_hospital, color: Color(0xFFE53935), labelAr: 'صحة', labelEn: 'Health'),
    _Category(icon: Icons.school, color: Color(0xFF3F51B5), labelAr: 'تعليم', labelEn: 'Education'),
    _Category(icon: Icons.more_horiz, color: Color(0xFF9E9E9E), labelAr: 'المزيد', labelEn: 'More'),
  ];

  @override
  Widget build(BuildContext context) {
    final isRtl = context.isRtl;

    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.surfaceContainerHighest,
            width: 1,
          ),
        ),
      ),
      child: SizedBox(
        height: 76,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          physics: const BouncingScrollPhysics(),
          itemCount: _categories.length,
          separatorBuilder: (_, __) => SizedBox(width: AppSpacing.lg),
          itemBuilder: (context, index) {
            final cat = _categories[index];
            return _CategoryItem(
              icon: cat.icon,
              color: cat.color,
              label: isRtl ? cat.labelAr : cat.labelEn,
            );
          },
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _CategoryItem({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(height: AppSpacing.xs + 2), // 6px
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 10,
              color: context.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.visible,
            softWrap: false,
          ),
        ],
      ),
    );
  }
}

class _Category {
  final IconData icon;
  final Color color;
  final String labelAr;
  final String labelEn;

  const _Category({
    required this.icon,
    required this.color,
    required this.labelAr,
    required this.labelEn,
  });
}
