import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:url_launcher/url_launcher.dart';

/// Follow-only section for pages with no catalog or ordering.
/// Used by the followOnly archetype (municipality, NGO).
/// Shows active alerts, about extended, services/links, and follow CTA.
class FollowOnlySection extends StatelessWidget {
  final PageDetail page;

  const FollowOnlySection({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    final hasAlerts = page.alerts.isNotEmpty;
    final hasAbout =
        page.aboutExtended != null && page.aboutExtended!.isNotEmpty;
    final hasLinks = page.servicesLinks.isNotEmpty;
    final hasContent = hasAlerts || hasAbout || hasLinks;

    if (!hasContent) {
      return _DefaultFollowState(pageName: page.name);
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // Active alerts
        if (hasAlerts) ...[
          Text(
            'تنبيهات',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...page.alerts.map(
            (alert) => _AlertCard(alert: alert),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],

        // About extended
        if (hasAbout) ...[
          Text(
            'عن الصفحة',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Text(
                page.aboutExtended!,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  height: 1.6,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],

        // Services & links
        if (hasLinks) ...[
          Text(
            'خدمات وروابط',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...page.servicesLinks.map(
            (link) => _ServiceLinkTile(link: link),
          ),
        ],
      ],
    );
  }
}

class _AlertCard extends StatelessWidget {
  final PageAlert alert;

  const _AlertCard({required this.alert});

  Color _priorityColor() {
    return switch (alert.priority) {
      'urgent' => Colors.red.shade500,
      'important' => Colors.amber.shade500,
      'info' => Colors.blue.shade500,
      _ => Colors.blue.shade500,
    };
  }

  Color _priorityBg() {
    return switch (alert.priority) {
      'urgent' => Colors.red.withValues(alpha: 0.08),
      'important' => Colors.amber.withValues(alpha: 0.08),
      'info' => Colors.blue.withValues(alpha: 0.08),
      _ => Colors.blue.withValues(alpha: 0.08),
    };
  }

  @override
  Widget build(BuildContext context) {
    final color = _priorityColor();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Container(
        decoration: BoxDecoration(
          color: _priorityBg(),
          borderRadius: BorderRadius.circular(12),
          border: BorderDirectional(
            start: BorderSide(
              color: color,
              width: 4,
            ),
          ),
        ),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              alert.title,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              alert.body,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            if (alert.areas.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: alert.areas
                    .map(
                      (area) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          area,
                          style:
                              context.textTheme.labelSmall?.copyWith(
                            color: color,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ServiceLinkTile extends StatelessWidget {
  final ServiceLink link;

  const _ServiceLinkTile({required this.link});

  IconData _typeIcon() {
    return switch (link.type) {
      'payment' => Icons.credit_card,
      'service' => Icons.description,
      'feedback' => Icons.feedback_outlined,
      _ => Icons.link,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Card(
        child: ListTile(
          leading: Icon(
            _typeIcon(),
            color: context.colorScheme.primary,
          ),
          title: Text(
            link.label,
            style: context.textTheme.titleSmall,
          ),
          trailing: Icon(
            Icons.open_in_new,
            size: 18,
            color: context.colorScheme.onSurfaceVariant,
          ),
          onTap: () => launchUrl(
            Uri.parse(link.url),
            mode: LaunchMode.externalApplication,
          ),
        ),
      ),
    );
  }
}

class _DefaultFollowState extends StatelessWidget {
  final String pageName;

  const _DefaultFollowState({required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.campaign_outlined,
              size: 64,
              color: context.colorScheme.primary.withValues(alpha: 0.6),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text(
              'هذه الصفحة للمتابعة فقط',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'تابع للحصول على آخر الأخبار والتحديثات',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxxl),
            FilledButton.icon(
              onPressed: () {
                // TODO: Trigger follow action
              },
              icon: const Icon(Icons.add),
              label: const Text('متابعة'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxxl,
                  vertical: AppSpacing.md,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
