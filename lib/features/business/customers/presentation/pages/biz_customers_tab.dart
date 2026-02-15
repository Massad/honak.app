import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/customers/presentation/providers/customers_provider.dart';
import 'package:honak/features/business/customers/presentation/widgets/all_customers_section.dart';
import 'package:honak/features/business/customers/presentation/widgets/invite_section.dart';
import 'package:honak/features/business/customers/presentation/widgets/subscribers_section.dart';
import 'package:honak/shared/providers/business_page_provider.dart';
import 'package:honak/shared/widgets/error_view.dart';
import 'package:honak/shared/widgets/loading_indicator.dart';

/// Business Customers tab — 3 sub-sections: مشتركون, جميع العملاء, دعوة
/// Matches Figma BizCustomersTab.tsx
class BizCustomersTab extends ConsumerStatefulWidget {
  const BizCustomersTab({super.key});

  @override
  ConsumerState<BizCustomersTab> createState() => _BizCustomersTabState();
}

class _BizCustomersTabState extends ConsumerState<BizCustomersTab> {
  String _section = 'all'; // subscribers, all, invite

  @override
  void initState() {
    super.initState();
    // Will be set to 'subscribers' if page has subscriptions feature
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bizContext = ref.read(businessContextProvider);
      final hasSubscriptions =
          bizContext?.config?.features.contains('subscriptions') ?? false;
      if (hasSubscriptions && mounted) {
        setState(() => _section = 'subscribers');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bizContext = ref.watch(businessContextProvider);
    if (bizContext == null) return const SizedBox.shrink();

    final pageId = bizContext.page.id;
    final hasSubscriptions =
        bizContext.config?.features.contains('subscriptions') ?? false;
    final customersAsync = ref.watch(bizCustomersProvider(pageId));

    return customersAsync.when(
      loading: () => const LoadingIndicator(),
      error: (err, _) => ErrorView(
        message: err.toString(),
        onRetry: () => ref.invalidate(bizCustomersProvider(pageId)),
      ),
      data: (data) => _buildContent(
        context, data, hasSubscriptions, bizContext.page.slug,
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    BizCustomersData data,
    bool hasSubscriptions,
    String pageSlug,
  ) {
    final sections = <_SectionDef>[
      if (hasSubscriptions)
        _SectionDef(
          id: 'subscribers',
          label: context.l10n.bizCustomerSubscribers,
          icon: Icons.credit_card_outlined,
          count: data.activeSubscribers.length,
        ),
      _SectionDef(
        id: 'all',
        label: context.l10n.bizCustomerAllCustomers,
        icon: Icons.people_outlined,
        count: data.customers.length,
      ),
      _SectionDef(
        id: 'invite',
        label: context.l10n.bizCustomerInvite,
        icon: Icons.person_add_outlined,
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Summary stats bar ──
          _SummaryStatsBar(data: data, hasSubscriptions: hasSubscriptions),
          const SizedBox(height: AppSpacing.lg),

          // ── Segmented control ──
          _SegmentedControl(
            sections: sections,
            selected: _section,
            onChanged: (id) => setState(() => _section = id),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Section content ──
          if (_section == 'all')
            AllCustomersSection(data: data),
          if (_section == 'invite')
            InviteSection(
              data: data,
              pageSlug: pageSlug,
              packages: data.packages,
            ),
          if (_section == 'subscribers')
            SubscribersSection(data: data),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Summary Stats Bar
// ═══════════════════════════════════════════════════════════════

class _SummaryStatsBar extends StatelessWidget {
  final BizCustomersData data;
  final bool hasSubscriptions;

  const _SummaryStatsBar({
    required this.data,
    required this.hasSubscriptions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (hasSubscriptions)
          Expanded(
            child: _StatChip(
              value: data.activeSubscribers.length.toString(),
              label: context.l10n.bizCustomerActiveSubscribers,
              color: AppColors.primary,
              bgColor: const Color(0xFFEFF6FF), // blue-50
            ),
          ),
        if (hasSubscriptions) const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatChip(
            value: data.customers.length.toString(),
            label: context.l10n.bizCustomerTotal,
            color: AppColors.success,
            bgColor: const Color(0xFFF0FDF4), // green-50
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatChip(
            value: '${data.repeatRatePercent}%',
            label: context.l10n.bizCustomerReturnRate,
            color: const Color(0xFF9333EA), // purple-600
            bgColor: const Color(0xFFFAF5FF), // purple-50
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatChip(
            value: data.avgOrdersPerCustomer.toStringAsFixed(1),
            label: context.l10n.bizCustomerOrdersPerCustomer,
            color: const Color(0xFF374151), // gray-700
            bgColor: const Color(0xFFF9FAFB), // gray-50
          ),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final Color bgColor;

  const _StatChip({
    required this.value,
    required this.label,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10), // p-2.5
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12), // rounded-xl
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 14, // text-sm
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9, // text-[9px]
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Segmented Control
// ═══════════════════════════════════════════════════════════════

class _SectionDef {
  final String id;
  final String label;
  final IconData icon;
  final int? count;

  const _SectionDef({
    required this.id,
    required this.label,
    required this.icon,
    this.count,
  });
}

class _SegmentedControl extends StatelessWidget {
  final List<_SectionDef> sections;
  final String selected;
  final ValueChanged<String> onChanged;

  const _SegmentedControl({
    required this.sections,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4), // p-1
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6), // gray-100
        borderRadius: BorderRadius.circular(12), // rounded-xl
      ),
      child: Row(
        children: sections.map((s) {
          final isSelected = s.id == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(s.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 8), // py-2
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(8), // rounded-lg
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      s.icon,
                      size: 14,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textHint,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        s.label,
                        style: TextStyle(
                          fontSize: 12, // text-xs
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.normal,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (s.count != null && s.count! > 0) ...[
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6, // px-1.5
                          vertical: 2, // py-0.5
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFEFF6FF) // blue-50
                              : const Color(0xFFE5E7EB), // gray-200
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          '${s.count}',
                          style: TextStyle(
                            fontSize: 9, // text-[9px]
                            color: isSelected
                                ? const Color(0xFF2563EB) // blue-600
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
