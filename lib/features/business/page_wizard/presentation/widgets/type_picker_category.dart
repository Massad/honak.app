import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Business type data used in the wizard type picker.
class BizTypeOption {
  final String id;
  final String name;
  final String archetype;
  final String archetypeLabel;

  const BizTypeOption(this.id, this.name, this.archetype, this.archetypeLabel);
}

/// Category grouping of business types.
class BizTypeCategory {
  final String label;
  final String emoji;
  final List<BizTypeOption> types;

  const BizTypeCategory(this.label, this.emoji, this.types);
}

const archetypeLabels = {
  'catalog_order': 'طلب كتالوج',
  'menu_order': 'طلب قائمة',
  'service_booking': 'حجز خدمة',
  'quote_request': 'طلب معاينة',
  'portfolio_inquiry': 'استفسار',
  'reservation': 'حجز مكان',
  'follow_only': 'متابعة فقط',
};

const archetypeExplanations = {
  'catalog_order': 'العميل يختار منتجات من الكتالوج ويرسل طلبًا — أنت تؤكد أو تقترح بديلاً.',
  'menu_order': 'العميل يختار من القائمة ويرسل طلبًا — أنت تؤكد أو تعدّل.',
  'service_booking': 'العميل يختار خدمة ويحجز موعدًا — أنت تؤكد أو تقترح وقتًا آخر.',
  'quote_request': 'العميل يوصف مشكلته ويطلب معاينة — أنت ترد بعرض سعر.',
  'portfolio_inquiry': 'العميل يرى أعمالك ويستفسر — أنت ترد بالتفاصيل والسعر.',
  'reservation': 'العميل يحجز مكانًا أو قاعة — أنت تؤكد التوفر.',
  'follow_only': 'صفحة للمتابعة والأخبار فقط — بدون طلبات أو حجوزات.',
};

const popularTypes = [
  BizTypeOption('restaurant', 'مطعم', 'menu_order', 'طلب قائمة'),
  BizTypeOption('water_delivery', 'توصيل مياه', 'catalog_order', 'طلب كتالوج'),
  BizTypeOption('salon', 'صالون تجميل', 'service_booking', 'حجز خدمة'),
  BizTypeOption('plumber', 'سباك', 'quote_request', 'طلب معاينة'),
  BizTypeOption('retail', 'محل تجاري', 'catalog_order', 'طلب كتالوج'),
];

const bizTypeCategories = [
  BizTypeCategory('طعام ومشروبات', '\u{1F354}', [
    BizTypeOption('restaurant', 'مطعم', 'menu_order', 'طلب قائمة'),
    BizTypeOption('cafe', 'مقهى', 'menu_order', 'طلب قائمة'),
    BizTypeOption('bakery', 'مخبز', 'menu_order', 'طلب قائمة'),
    BizTypeOption('sweetshop', 'حلويات', 'menu_order', 'طلب قائمة'),
    BizTypeOption('juice_bar', 'عصائر', 'menu_order', 'طلب قائمة'),
    BizTypeOption('catering', 'تموين وولائم', 'menu_order', 'طلب قائمة'),
  ]),
  BizTypeCategory('خدمات التوصيل', '\u{1F69A}', [
    BizTypeOption('water_delivery', 'توصيل مياه', 'catalog_order', 'طلب كتالوج'),
    BizTypeOption('gas_delivery', 'توصيل غاز', 'catalog_order', 'طلب كتالوج'),
    BizTypeOption('grocery_delivery', 'توصيل بقالة', 'catalog_order', 'طلب كتالوج'),
  ]),
  BizTypeCategory('التجميل والعناية', '\u{1F487}', [
    BizTypeOption('salon', 'صالون تجميل', 'service_booking', 'حجز خدمة'),
    BizTypeOption('barber', 'حلاق', 'service_booking', 'حجز خدمة'),
    BizTypeOption('spa', 'سبا', 'service_booking', 'حجز خدمة'),
  ]),
  BizTypeCategory('خدمات منزلية', '\u{1F527}', [
    BizTypeOption('plumber', 'سباك', 'quote_request', 'طلب معاينة'),
    BizTypeOption('electrician', 'كهربائي', 'quote_request', 'طلب معاينة'),
    BizTypeOption('painter', 'دهّان', 'quote_request', 'طلب معاينة'),
    BizTypeOption('ac_repair', 'صيانة تكييف', 'quote_request', 'طلب معاينة'),
    BizTypeOption('cleaning', 'تنظيف', 'quote_request', 'طلب معاينة'),
  ]),
  BizTypeCategory('صحة وطب', '\u{1F3E5}', [
    BizTypeOption('clinic', 'عيادة', 'service_booking', 'حجز خدمة'),
    BizTypeOption('pharmacy', 'صيدلية', 'catalog_order', 'طلب كتالوج'),
    BizTypeOption('lab', 'مختبر', 'service_booking', 'حجز خدمة'),
    BizTypeOption('physiotherapy', 'علاج طبيعي', 'service_booking', 'حجز خدمة'),
  ]),
  BizTypeCategory('تجارة وتسوق', '\u{1F6D2}', [
    BizTypeOption('retail', 'محل تجاري', 'catalog_order', 'طلب كتالوج'),
    BizTypeOption('online_store', 'متجر إلكتروني', 'catalog_order', 'طلب كتالوج'),
    BizTypeOption('bookstore', 'مكتبة', 'catalog_order', 'طلب كتالوج'),
    BizTypeOption('clothes_store', 'ملابس', 'catalog_order', 'طلب كتالوج'),
  ]),
];

/// Chip for selecting popular types.
class TypeChip extends StatelessWidget {
  final BizTypeOption type;
  final bool selected;
  final VoidCallback onTap;

  const TypeChip({
    super.key,
    required this.type,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.primary.withAlpha(25) : context.colorScheme.surfaceVariant,
      borderRadius: AppRadius.pill,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.pill,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            borderRadius: AppRadius.pill,
            border: selected
                ? Border.all(color: AppColors.primary, width: 1.5)
                : null,
          ),
          child: Text(
            type.name,
            style: TextStyle(
              color: selected ? AppColors.primary : context.colorScheme.onSurface,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

/// Expandable category section in the type picker.
class CategorySection extends StatefulWidget {
  final BizTypeCategory category;
  final String? selectedTypeId;
  final ValueChanged<BizTypeOption> onSelect;

  const CategorySection({
    super.key,
    required this.category,
    required this.selectedTypeId,
    required this.onSelect,
  });

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasSelection = widget.category.types
        .any((t) => t.id == widget.selectedTypeId);

    if (hasSelection && !_expanded) {
      _expanded = true;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          borderRadius: AppRadius.cardInner,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Row(
              children: [
                Text(
                  widget.category.emoji,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    widget.category.label,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
        if (_expanded)
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: AppSpacing.xxl + AppSpacing.sm,
              bottom: AppSpacing.md,
            ),
            child: Column(
              children: widget.category.types.map((t) {
                return TypeListTile(
                  type: t,
                  selected: widget.selectedTypeId == t.id,
                  onTap: () => widget.onSelect(t),
                );
              }).toList(),
            ),
          ),
        const Divider(height: 1),
      ],
    );
  }
}

/// Single business type row in the type picker.
class TypeListTile extends StatelessWidget {
  final BizTypeOption type;
  final bool selected;
  final VoidCallback onTap;

  const TypeListTile({
    super.key,
    required this.type,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.cardInner,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withAlpha(15) : null,
          borderRadius: AppRadius.cardInner,
          border: selected
              ? Border.all(color: AppColors.primary, width: 1.5)
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                type.name,
                style: TextStyle(
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  color: selected ? AppColors.primary : context.colorScheme.onSurface,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xxs,
              ),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceVariant,
                borderRadius: AppRadius.badge,
              ),
              child: Text(
                type.archetypeLabel,
                style: TextStyle(
                  fontSize: 11,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Blue info box explaining the selected archetype.
class ArchetypeInfoBox extends StatelessWidget {
  final String archetype;

  const ArchetypeInfoBox({super.key, required this.archetype});

  @override
  Widget build(BuildContext context) {
    final label = archetypeLabels[archetype] ?? archetype;
    final explanation = archetypeExplanations[archetype] ?? '';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(15),
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: AppColors.primary.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: AppColors.primary),
              const SizedBox(width: AppSpacing.xs),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            explanation,
            style: TextStyle(
              fontSize: 13,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
