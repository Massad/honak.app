import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:honak/features/business/insights/presentation/widgets/directory_dashboard_section.dart';
import 'package:honak/features/business/insights/presentation/widgets/directory_insights_cards.dart';
import 'package:honak/shared/providers/business_page_provider.dart';

// Placeholder insights/analytics page for business mode.
// Will be replaced with real analytics when backend is ready.

class BusinessInsightsPage extends ConsumerWidget {
  const BusinessInsightsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bizContext = ref.watch(businessContextProvider);

    // Directory archetype gets specialized insights
    if (bizContext != null && bizContext.archetype == Archetype.directory) {
      return _DirectoryInsightsContent(pageId: bizContext.page.id);
    }

    return _DefaultInsightsContent();
  }
}

class _DirectoryInsightsContent extends ConsumerWidget {
  final String pageId;

  const _DirectoryInsightsContent({required this.pageId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashData = ref.watch(dashboardStatsProvider(pageId));

    return dashData.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const _DefaultInsightsContent(),
      data: (data) {
        return ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            DirectoryDashboardSection(data: data),
            const SizedBox(height: AppSpacing.xl),
            if (data['insights'] != null)
              DirectoryInsightsCards(
                insights: data['insights'] as Map<String, dynamic>,
              ),
          ],
        );
      },
    );
  }
}

class _DefaultInsightsContent extends StatelessWidget {
  const _DefaultInsightsContent();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        const SizedBox(height: AppSpacing.xxl),
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.bar_chart_rounded,
              size: 36,
              color: AppColors.primary.withValues(alpha: 0.4),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'إحصائيات صفحتك',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: context.colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'ستتوفر الإحصائيات والتحليلات قريباً',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: AppSpacing.xxl),

        // Preview cards to hint at upcoming features
        _PreviewCard(
          icon: Icons.visibility_outlined,
          title: 'المشاهدات',
          subtitle: 'عدد مرات مشاهدة صفحتك',
        ),
        const SizedBox(height: AppSpacing.sm),
        _PreviewCard(
          icon: Icons.people_outline,
          title: 'العملاء',
          subtitle: 'عدد العملاء الذين تواصلوا معك',
        ),
        const SizedBox(height: AppSpacing.sm),
        _PreviewCard(
          icon: Icons.trending_up,
          title: 'الطلبات',
          subtitle: 'إحصائيات الطلبات والحجوزات',
        ),
        const SizedBox(height: AppSpacing.sm),
        _PreviewCard(
          icon: Icons.star_outline,
          title: 'مؤشرات الثقة',
          subtitle: 'سرعة الرد ونسبة الإنجاز',
        ),
      ],
    );
  }
}

class _PreviewCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _PreviewCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: context.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'قريباً',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
