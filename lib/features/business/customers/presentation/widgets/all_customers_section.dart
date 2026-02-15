import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/customers/domain/entities/business_customer.dart';
import 'package:honak/features/business/customers/presentation/providers/customers_provider.dart';
import 'package:honak/features/business/customers/presentation/widgets/customer_detail_sheet.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/empty_state.dart';

/// AllCustomersSection — search, sort, customer card list.
/// Matches Figma BizCustomersTab.tsx lines 597-729.
class AllCustomersSection extends StatefulWidget {
  final BizCustomersData data;

  const AllCustomersSection({super.key, required this.data});

  @override
  State<AllCustomersSection> createState() => _AllCustomersSectionState();
}

class _AllCustomersSectionState extends State<AllCustomersSection> {
  String _searchQuery = '';
  String _sortBy = 'recent'; // recent, orders, value

  List<BusinessCustomer> get _filteredCustomers {
    var list = [...widget.data.customers];

    // Sort
    switch (_sortBy) {
      case 'orders':
        list.sort((a, b) => b.totalOrders.compareTo(a.totalOrders));
      case 'value':
        list.sort((a, b) => b.totalSpent.compareTo(a.totalSpent));
      default: // recent
        list.sort((a, b) {
          final dateA = a.lastActivityDate ?? '';
          final dateB = b.lastActivityDate ?? '';
          return dateB.compareTo(dateA);
        });
    }

    // Filter by search
    if (_searchQuery.trim().isNotEmpty) {
      final q = _searchQuery.trim();
      list = list.where((c) {
        return c.name.contains(q) ||
            (c.phone?.contains(q) ?? false) ||
            (c.area?.contains(q) ?? false);
      }).toList();
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final customers = _filteredCustomers;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Search ──
        _SearchInput(
          value: _searchQuery,
          hint: l10n.bizCustomerSearchHint,
          onChanged: (v) => setState(() => _searchQuery = v),
        ),
        const SizedBox(height: AppSpacing.md),

        // ── Sort chips ──
        Row(
          children: [
            _SortChip(
              label: l10n.bizCustomerSortRecent,
              isSelected: _sortBy == 'recent',
              onTap: () => setState(() => _sortBy = 'recent'),
            ),
            const SizedBox(width: AppSpacing.sm),
            _SortChip(
              label: l10n.bizCustomerSortOrders,
              isSelected: _sortBy == 'orders',
              onTap: () => setState(() => _sortBy = 'orders'),
            ),
            const SizedBox(width: AppSpacing.sm),
            _SortChip(
              label: l10n.bizCustomerSortValue,
              isSelected: _sortBy == 'value',
              onTap: () => setState(() => _sortBy = 'value'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // ── Customer list ──
        if (customers.isEmpty)
          EmptyState(
            icon: Icons.people_outlined,
            title: l10n.bizCustomerNoCustomers,
          )
        else
          ...customers.map(
            (c) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _CustomerCard(
                customer: c,
                onTap: () => _showCustomerDetail(context, c),
              ),
            ),
          ),
      ],
    );
  }

  void _showCustomerDetail(BuildContext context, BusinessCustomer customer) {
    showCustomerDetailSheet(context, customer: customer);
  }
}

// ═══════════════════════════════════════════════════════════════
// Search Input
// ═══════════════════════════════════════════════════════════════

class _SearchInput extends StatelessWidget {
  final String value;
  final String hint;
  final ValueChanged<String> onChanged;

  const _SearchInput({
    required this.value,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      textDirection: TextDirection.rtl,
      style: const TextStyle(fontSize: 14), // text-sm
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: AppColors.textHint,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.md, // pl
          10, // py-2.5
          36, // pr-9 (icon space)
          10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // rounded-xl
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsetsDirectional.only(start: 12),
          child: Icon(Icons.search, size: 14, color: AppColors.textHint),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 32,
          minHeight: 0,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Sort Chip
// ═══════════════════════════════════════════════════════════════

class _SortChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SortChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, // px-3
          vertical: 6, // py-1.5
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(9999), // rounded-full
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12, // text-xs
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Customer Card
// ═══════════════════════════════════════════════════════════════

/// Badge config matching Figma BADGE_CONFIG.
const _badgeConfig = <CustomerBadge, _BadgeStyle>{
  CustomerBadge.newCustomer: _BadgeStyle(
    color: Color(0xFF2563EB), // blue-600
    bgColor: Color(0xFFEFF6FF), // blue-50
  ),
  CustomerBadge.active: _BadgeStyle(
    color: Color(0xFF43A047), // green
    bgColor: Color(0xFFF0FDF4), // green-50
  ),
  CustomerBadge.repeat: _BadgeStyle(
    color: Color(0xFF9333EA), // purple-600
    bgColor: Color(0xFFFAF5FF), // purple-50
  ),
  CustomerBadge.interested: _BadgeStyle(
    color: Color(0xFFD97706), // amber-600
    bgColor: Color(0xFFFFFBEB), // amber-50
  ),
  CustomerBadge.past: _BadgeStyle(
    color: Color(0xFF6B7280), // gray-500
    bgColor: Color(0xFFF3F4F6), // gray-100
  ),
};

class _BadgeStyle {
  final Color color;
  final Color bgColor;
  const _BadgeStyle({required this.color, required this.bgColor});
}

String _badgeLabel(BuildContext context, CustomerBadge badge) {
  final l10n = context.l10n;
  return switch (badge) {
    CustomerBadge.newCustomer => l10n.bizCustomerBadgeNew,
    CustomerBadge.active => l10n.bizCustomerBadgeActive,
    CustomerBadge.repeat => l10n.bizCustomerBadgeRepeat,
    CustomerBadge.interested => l10n.bizCustomerBadgeInterested,
    CustomerBadge.past => l10n.bizCustomerBadgePast,
  };
}

class _CustomerCard extends StatelessWidget {
  final BusinessCustomer customer;
  final VoidCallback onTap;

  const _CustomerCard({required this.customer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = customer;
    final badge = _badgeConfig[c.badge] ?? _badgeConfig[CustomerBadge.newCustomer]!;
    final l10n = context.l10n;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md), // p-3
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12), // rounded-xl
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trailing chevron (visually leading in RTL)
            Padding(
              padding: const EdgeInsetsDirectional.only(
                end: AppSpacing.md,
                top: AppSpacing.sm,
              ),
              child: Icon(
                Icons.chevron_left,
                size: 14,
                color: AppColors.textHint.withValues(alpha: 0.5),
              ),
            ),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Name + badge row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6, // px-1.5
                          vertical: 2, // py-0.5
                        ),
                        decoration: BoxDecoration(
                          color: badge.bgColor,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          _badgeLabel(context, c.badge),
                          style: TextStyle(
                            fontSize: 9, // text-[9px]
                            color: badge.color,
                          ),
                        ),
                      ),
                      // Name
                      Text(
                        c.name,
                        style: const TextStyle(
                          fontSize: 14, // text-sm
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  // Phone + area
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (c.phone != null) ...[
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            c.phone!,
                            style: const TextStyle(
                              fontSize: 10, // text-[10px]
                              color: AppColors.textHint,
                            ),
                          ),
                        ),
                      ],
                      if (c.phone != null && c.area != null)
                        const SizedBox(width: AppSpacing.sm),
                      if (c.area != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 8,
                              color: AppColors.textHint,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              c.area!,
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.textHint,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  // Orders + spent + payment
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (c.totalOrders > 0) ...[
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 9,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${c.totalOrders} ${l10n.bizCustomerOrders}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                      if (c.totalOrders == 0) ...[
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 9,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          l10n.bizCustomerChatOnly,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                      if (c.totalSpent > 0) ...[
                        const SizedBox(width: AppSpacing.md),
                        Text(
                          '${c.totalSpentJod.toStringAsFixed(2)} د.أ',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                      if (c.usualPayment != null) ...[
                        const SizedBox(width: AppSpacing.md),
                        Text(
                          c.usualPayment!,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),

                  // Active subscription indicator
                  if (c.hasActiveSubscription && c.subscription != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.credit_card_outlined,
                          size: 9,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${l10n.bizCustomerSubscribed} (${c.subscription!.remainingCredits ?? 0}/${c.subscription!.totalCredits ?? 0})',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(width: AppSpacing.md),

            // Avatar
            AppImage.avatar(
              url: c.avatar,
              name: c.name,
              radius: 20, // 40x40
            ),
          ],
        ),
      ),
    );
  }
}
