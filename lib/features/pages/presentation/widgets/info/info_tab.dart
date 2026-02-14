import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/presentation/widgets/info/branches_section.dart';
import 'package:honak/features/pages/presentation/widgets/info/contact_section.dart';
import 'package:honak/features/pages/presentation/widgets/info/coverage_section.dart';
import 'package:honak/features/pages/presentation/widgets/info/return_policy_section.dart';
import 'package:honak/features/pages/presentation/widgets/info/stats_footer.dart';
import 'package:honak/shared/widgets/app_badge.dart';

/// Enriched info tab: hours, branches, coverage, payments, contact, returns, stats.
class InfoTab extends StatelessWidget {
  final PageDetail page;

  const InfoTab({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingAll(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        // Service availability
        _ServiceAvailabilityRow(page: page),

        // Delivery details
        if (page.deliveryAvailable) ...[
          SizedBox(height: AppSpacing.lg),
          _DeliveryDetailsCard(page: page),
        ],

        // Cancellation policy
        if (page.cancellationPolicy != null) ...[
          SizedBox(height: AppSpacing.lg),
          _CancellationPolicyCard(policy: page.cancellationPolicy!),
        ],

        // Working hours
        if (page.workingHours != null &&
            page.workingHours!.isNotEmpty) ...[
          SizedBox(height: AppSpacing.lg),
          _WorkingHoursSection(workingHours: page.workingHours!),
        ],

        // Branches / Location
        if (page.branches.isNotEmpty ||
            page.location != null) ...[
          SizedBox(height: AppSpacing.lg),
          BranchesSection(
            location: page.location,
            branches: page.branches,
            address: page.address,
            pageName: page.name,
          ),
        ],

        // Coverage zones
        if (page.coverageZonesStructured.isNotEmpty ||
            page.coverageZones.isNotEmpty) ...[
          SizedBox(height: AppSpacing.lg),
          CoverageSection(
            structuredZones: page.coverageZonesStructured,
            flatZones: page.coverageZones,
          ),
        ],

        // Payment methods
        if (page.paymentMethods.isNotEmpty) ...[
          SizedBox(height: AppSpacing.lg),
          _PaymentMethodsSection(page: page),
        ],

        // Contact
        SizedBox(height: AppSpacing.lg),
        ContactSection(
          phone: page.phone,
          whatsapp: page.whatsapp,
          cliqAlias: page.cliqAlias,
          externalLinks: page.externalLinks,
        ),

        // Return policy
        if (page.returnPolicy != null) ...[
          SizedBox(height: AppSpacing.lg),
          ReturnPolicySection(policy: page.returnPolicy!),
        ],

        // Stats footer
        StatsFooter(
          followersCount: page.followersCount,
          memberSince: page.memberSince,
        ),
        ],
      ),
    );
  }
}

class _ServiceAvailabilityRow extends StatelessWidget {
  final PageDetail page;

  const _ServiceAvailabilityRow({required this.page});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AvailabilityChip(
          label: context.l10n.delivery,
          icon: Icons.local_shipping_outlined,
          available: page.deliveryAvailable,
        ),
        SizedBox(width: AppSpacing.sm),
        _AvailabilityChip(
          label: context.l10n.pickup,
          icon: Icons.store_outlined,
          available: page.pickupAvailable,
        ),
        SizedBox(width: AppSpacing.sm),
        _AvailabilityChip(
          label: context.l10n.booking,
          icon: Icons.calendar_today_outlined,
          available: page.bookingAvailable,
        ),
      ],
    );
  }
}

class _AvailabilityChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool available;

  const _AvailabilityChip({
    required this.label,
    required this.icon,
    required this.available,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: available
              ? Colors.green.withValues(alpha: 0.12)
              : context.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: available
                ? Colors.green.withValues(alpha: 0.3)
                : context.colorScheme.outlineVariant,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 20,
              color: available
                  ? Colors.green
                  : context.colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: context.textTheme.labelSmall?.copyWith(
                color: available
                    ? Colors.green
                    : context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _DeliveryDetailsCard extends StatelessWidget {
  final PageDetail page;

  const _DeliveryDetailsCard({required this.page});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (page.deliveryFeeCents != null)
              _InfoRow(
                icon: Icons.local_shipping_outlined,
                label: context.l10n.deliveryFee,
                value:
                    '${(page.deliveryFeeCents! / 100).toStringAsFixed(2)} ${context.l10n.jod}',
              ),
            if (page.minimumOrderCents != null) ...[
              SizedBox(height: AppSpacing.sm),
              _InfoRow(
                icon: Icons.shopping_cart_outlined,
                label: context.l10n.minimumOrder,
                value:
                    '${(page.minimumOrderCents! / 100).toStringAsFixed(2)} ${context.l10n.jod}',
              ),
            ],
            if (page.estimatedDeliveryMinutes != null) ...[
              SizedBox(height: AppSpacing.sm),
              _InfoRow(
                icon: Icons.schedule,
                label: context.l10n.estimatedDelivery,
                value: context.l10n.minutes(page.estimatedDeliveryMinutes!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: context.colorScheme.onSurfaceVariant),
        SizedBox(width: AppSpacing.sm),
        Text(label, style: context.textTheme.bodyMedium),
        const Spacer(),
        Text(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _CancellationPolicyCard extends StatelessWidget {
  final String policy;

  const _CancellationPolicyCard({required this.policy});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('سياسة الإلغاء', style: context.textTheme.titleSmall),
        SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.amber.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, size: 18, color: Colors.amber.shade700),
              SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  policy,
                  style: context.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PaymentMethodsSection extends StatelessWidget {
  final PageDetail page;

  const _PaymentMethodsSection({required this.page});

  IconData _paymentIcon(String method) {
    final lower = method.toLowerCase();
    if (lower.contains('نقد') || lower.contains('cash')) {
      return Icons.payments_outlined;
    }
    if (lower.contains('كليك') || lower.contains('cliq')) {
      return Icons.phone_android;
    }
    if (lower.contains('تحويل') || lower.contains('bank')) {
      return Icons.account_balance_outlined;
    }
    if (lower.contains('فيزا') || lower.contains('visa') ||
        lower.contains('ماستر') || lower.contains('card')) {
      return Icons.credit_card;
    }
    return Icons.payment;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.paymentMethods, style: context.textTheme.titleSmall),
        SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: page.paymentMethods
              .map(
                (method) => AppBadge(
                  label: method,
                  color: context.colorScheme.primary,
                  icon: _paymentIcon(method),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _WorkingHoursSection extends StatelessWidget {
  final Map<String, dynamic> workingHours;

  const _WorkingHoursSection({required this.workingHours});

  static const _dayNames = {
    'sunday': 'الأحد',
    'monday': 'الاثنين',
    'tuesday': 'الثلاثاء',
    'wednesday': 'الأربعاء',
    'thursday': 'الخميس',
    'friday': 'الجمعة',
    'saturday': 'السبت',
  };

  static const _dayOrder = [
    'sunday', 'monday', 'tuesday', 'wednesday',
    'thursday', 'friday', 'saturday',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.workingHours, style: context.textTheme.titleSmall),
        SizedBox(height: AppSpacing.sm),
        Card(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: _dayOrder.map((day) {
                final hours = workingHours[day];
                final isOpen = hours != null;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.xxs),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          _dayNames[day] ?? day,
                          style: context.textTheme.bodySmall,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          isOpen
                              ? '${hours['open']} - ${hours['close']}'
                              : context.l10n.closed,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: isOpen
                                ? context.colorScheme.onSurface
                                : context.colorScheme.error,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
