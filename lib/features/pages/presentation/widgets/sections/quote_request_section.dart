import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/requests/presentation/widgets/quote_request_sheet.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/widgets/auth_gate.dart';

/// Data-driven overview for quote request businesses.
/// Used by the quoteRequest archetype (plumber, electrician).
/// Shows services from page data, coverage area, price range, and CTA.
class QuoteRequestSection extends ConsumerWidget {
  final String pageId;
  final PageDetail? page;

  const QuoteRequestSection({
    super.key,
    required this.pageId,
    this.page,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = page?.servicesOffered ?? [];
    final priceRange = page?.priceRange;
    final serviceAreas = page?.serviceAreas ?? [];

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // Services offered
        Text(
          'الخدمات المقدمة',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        if (services.isNotEmpty)
          ...services.map(
            (service) => _ServiceListTile(
              icon: Icons.build_outlined,
              title: service.name,
              subtitle: service.description ?? '',
            ),
          )
        else ...[
          // Fallback hardcoded services if no data
          const _ServiceListTile(
            icon: Icons.plumbing,
            title: 'صيانة عامة',
            subtitle: 'تصليح وصيانة جميع الأعطال',
          ),
          const _ServiceListTile(
            icon: Icons.build,
            title: 'تركيب وتجهيز',
            subtitle: 'تركيب أجهزة ومعدات جديدة',
          ),
          const _ServiceListTile(
            icon: Icons.home_repair_service,
            title: 'فحص وتشخيص',
            subtitle: 'فحص شامل وتحديد المشكلة',
          ),
          const _ServiceListTile(
            icon: Icons.handyman,
            title: 'أعمال طوارئ',
            subtitle: 'خدمة سريعة للحالات الطارئة',
          ),
        ],

        const SizedBox(height: AppSpacing.xxl),

        // Service areas
        if (serviceAreas.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: context.colorScheme.primary,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      'مناطق التغطية',
                      style: context.textTheme.titleSmall,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: serviceAreas
                      .map(
                        (area) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Colors.green.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color:
                                  Colors.green.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            area,
                            style:
                                context.textTheme.labelSmall?.copyWith(
                              color: Colors.green.shade800,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ] else ...[
          // Fallback coverage area
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: context.colorScheme.primary,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'منطقة التغطية',
                        style: context.textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        'عمان والمناطق المحيطة',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],

        // Price range
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.payments_outlined,
                color: context.colorScheme.primary,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الأسعار',
                      style: context.textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      priceRange != null
                          ? '${Money(priceRange.minCents).toFormattedArabic()} — ${Money(priceRange.maxCents).toFormattedArabic()}'
                          : 'يبدأ من ١٥ د.أ',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (priceRange?.note != null) ...[
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        priceRange!.note!,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.xxxl),

        // CTA button
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () {
              AuthGate.require(
                context,
                ref,
                trigger: LoginPromptTrigger.quote,
                onAuthed: () {
                  QuoteRequestSheet.show(
                    context: context,
                    pageName: page?.name ?? '',
                    onSubmit: (data) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            '\u062a\u0645 \u0625\u0631\u0633\u0627\u0644 \u0637\u0644\u0628\u0643 \u0628\u0646\u062c\u0627\u062d \u2014 \u0633\u064a\u062a\u0645 \u0627\u0644\u0631\u062f \u0642\u0631\u064a\u0628\u0627\u064b',
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
            icon: const Icon(Icons.request_quote_outlined),
            label: Text(
              page?.archetype != null
                  ? Archetype.fromKey(page!.archetype!).displayNameAr
                  : 'اطلب عرض سعر',
            ),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.lg,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ServiceListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ServiceListTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Card(
        child: ListTile(
          leading: Icon(
            icon,
            color: context.colorScheme.primary,
          ),
          title: Text(title, style: context.textTheme.titleSmall),
          subtitle: subtitle.isNotEmpty
              ? Text(
                  subtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
