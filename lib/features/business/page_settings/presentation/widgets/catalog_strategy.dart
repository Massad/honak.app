import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/presentation/providers/settings_provider.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';
import 'package:honak/shared/providers/business_page_provider.dart';
import 'package:honak/shared/widgets/button.dart';

/// Category options per business type.
const carryCategoryOptions = <String, List<String>>{
  'pharmacy': [
    'أدوية',
    'مكملات غذائية',
    'مستحضرات تجميل',
    'عناية شخصية',
    'أجهزة طبية',
    'فيتامينات',
  ],
  'supermarket': [
    'مواد غذائية',
    'مشروبات',
    'تنظيف',
    'عناية شخصية',
    'ألبان ومبردات',
    'مجمدات',
    'حلويات',
    'خضار وفواكه',
  ],
  'butcher': [
    'لحم بقر',
    'لحم غنم',
    'دجاج',
    'لحوم مصنعة',
    'مشاوي جاهزة',
  ],
  'fruit_veg': [
    'فواكه',
    'خضروات',
    'أعشاب طازجة',
    'فواكه مجففة',
    'عصائر طازجة',
  ],
  'bookstore': [
    'كتب عربية',
    'كتب إنجليزية',
    'قرطاسية',
    'ألعاب تعليمية',
    'هدايا',
  ],
  'clothes_store': [
    'رجالي',
    'نسائي',
    'أطفال',
    'إكسسوارات',
    'أحذية',
    'حقائب',
  ],
  'electronics_store': [
    'هواتف',
    'لابتوبات',
    'إكسسوارات',
    'أجهزة منزلية',
    'ألعاب',
    'كاميرات',
  ],
  'coffee_shop': [
    'مشروبات ساخنة',
    'مشروبات باردة',
    'حلويات',
    'معجنات',
    'وجبات خفيفة',
  ],
  'restaurant': [
    'أطباق رئيسية',
    'مقبلات',
    'مشروبات',
    'حلويات',
    'عروض عائلية',
  ],
  'bakery': [
    'خبز',
    'معجنات',
    'حلويات عربية',
    'كيك',
    'فطائر',
  ],
  'water_delivery': [
    'مياه معدنية',
    'مياه نقية',
    'عبوات كبيرة',
    'عبوات صغيرة',
  ],
  'grocery': [
    'مواد غذائية',
    'مشروبات',
    'وجبات خفيفة',
    'ألبان ومبردات',
    'تنظيف',
  ],
};

/// Fallback categories when business type has no specific options.
const _defaultCategories = [
  'الأكثر مبيعاً',
  'جديد',
  'عروض خاصة',
  'موصى به',
];

class CatalogStrategy extends ConsumerWidget {
  final VoidCallback onClose;

  const CatalogStrategy({super.key, required this.onClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(pageSettingsProvider);
    final strategy =
        settingsAsync.valueOrNull?.catalogStrategy ?? 'full_catalog';
    final highlightCategories =
        settingsAsync.valueOrNull?.highlightCategories ?? [];

    final bizContext = ref.watch(businessContextProvider);
    final businessTypeId = bizContext?.page.businessTypeId;
    final availableCategories =
        carryCategoryOptions[businessTypeId] ?? _defaultCategories;

    return Column(
      children: [
        SubScreenAppBar(
          title: 'استراتيجية الكتالوج',
          onClose: onClose,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              Text(
                'ماذا تعرض في صفحتك؟',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.end,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'اختر طريقة عرض منتجاتك للعملاء',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.end,
              ),
              const SizedBox(height: AppSpacing.xl),

              // Option A: Full catalog
              _StrategyCard(
                label: 'كل ما أبيعه مدرج هنا',
                desc: 'العملاء يتوقعون أن يجدوا كل منتجاتك في الصفحة',
                icon: Icons.auto_awesome_rounded,
                selected: strategy == 'full_catalog',
                onTap: () => ref
                    .read(pageSettingsProvider.notifier)
                    .updateCatalogStrategy('full_catalog'),
              ),
              const SizedBox(height: AppSpacing.md),

              // Option B: Highlights only
              _StrategyCard(
                label:
                    'أعرض المميز فقط \u2014 لدي المزيد في المتجر',
                desc:
                    'سنوضح للعملاء أن لديك منتجات أخرى متوفرة',
                icon: Icons.store_rounded,
                selected: strategy == 'highlights',
                onTap: () => ref
                    .read(pageSettingsProvider.notifier)
                    .updateCatalogStrategy('highlights'),
              ),

              // Category picker when highlights selected
              if (strategy == 'highlights') ...[
                const SizedBox(height: AppSpacing.xl),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    'ما الأقسام التي تحملها؟',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _CategoryPills(
                  available: availableCategories,
                  selected: highlightCategories,
                  onChanged: (categories) => ref
                      .read(pageSettingsProvider.notifier)
                      .updateHighlightCategories(categories),
                ),
              ],

              const SizedBox(height: AppSpacing.xl),

              // Save button
              Button(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم حفظ الإعدادات'),
                    ),
                  );
                  onClose();
                },
                label: 'حفظ',
                expand: true,
                size: ButtonSize.large,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryPills extends StatelessWidget {
  final List<String> available;
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;

  const _CategoryPills({
    required this.available,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      textDirection: Directionality.of(context),
      children: available.map((cat) {
        final isSelected = selected.contains(cat);
        return GestureDetector(
          onTap: () {
            final updated = List<String>.from(selected);
            if (isSelected) {
              updated.remove(cat);
            } else {
              updated.add(cat);
            }
            onChanged(updated);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary
                  : Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              cat,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _StrategyCard extends StatelessWidget {
  final String label;
  final String desc;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _StrategyCard({
    required this.label,
    required this.desc,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.primary.withValues(alpha: 0.04)
          : Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : Theme.of(context).colorScheme.surfaceContainerLow,
            ),
          ),
          child: Row(
            children: [
              // Blue checkbox circle
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? AppColors.primary : Colors.transparent,
                  border: Border.all(
                    color: selected
                        ? AppColors.primary
                        : Theme.of(context).colorScheme.outline,
                    width: 2,
                  ),
                ),
                child: selected
                    ? Icon(
                        Icons.check,
                        size: 14,
                        color: Theme.of(context).colorScheme.surface,
                      )
                    : null,
              ),
              const Spacer(),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      label,
                      style:
                          context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      desc,
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : Theme.of(context).colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: selected
                      ? AppColors.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
