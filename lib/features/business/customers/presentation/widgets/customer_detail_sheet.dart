import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/customers/domain/entities/business_customer.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:intl/intl.dart' hide TextDirection;

/// Shows a modal bottom sheet with full customer detail.
/// Matches Figma CustomerDetailSheet.tsx.
Future<void> showCustomerDetailSheet(
  BuildContext context, {
  required BusinessCustomer customer,
}) {
  return showAppSheet(
    context,
    maxHeightFraction: 0.85,
    builder: (_) => _CustomerDetailContent(customer: customer),
  );
}

class _CustomerDetailContent extends StatefulWidget {
  final BusinessCustomer customer;

  const _CustomerDetailContent({required this.customer});

  @override
  State<_CustomerDetailContent> createState() =>
      _CustomerDetailContentState();
}

class _CustomerDetailContentState extends State<_CustomerDetailContent> {
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController =
        TextEditingController(text: widget.customer.notes ?? '');
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.customer;
    final l10n = context.l10n;
    final sub = c.subscription;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Sticky header ──
        AppSheetHeader(
          title: c.name,
          onClose: () => Navigator.of(context).pop(),
        ),

        // ── Scrollable content ──
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.xxl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Identity card ──
                _IdentityCard(customer: c),
                const SizedBox(height: AppSpacing.lg),

                // ── Stats grid ──
                _StatsGrid(customer: c),
                const SizedBox(height: AppSpacing.lg),

                // ── Subscription card ──
                if (sub != null) ...[
                  _SubscriptionCard(customer: c),
                  const SizedBox(height: AppSpacing.lg),
                ],

                // ── Activity section ──
                _ActivitySection(customer: c),
                const SizedBox(height: AppSpacing.lg),

                // ── Recent orders ──
                if (c.recentOrders.isNotEmpty) ...[
                  _RecentOrdersSection(customer: c),
                  const SizedBox(height: AppSpacing.lg),
                ],

                // ── Private notes ──
                _NotesSection(controller: _notesController),
                const SizedBox(height: AppSpacing.lg),

                // ── Action buttons ──
                Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Expanded(
                      child: _ActionButton(
                        label: l10n.bizCustomerCall,
                        icon: Icons.phone_outlined,
                        isPrimary: false,
                        onTap: () {
                          Navigator.of(context).pop();
                          context.showSnackBar(l10n.comingSoon);
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _ActionButton(
                        label: l10n.bizCustomerChat,
                        icon: Icons.chat_bubble_outline,
                        isPrimary: true,
                        onTap: () {
                          Navigator.of(context).pop();
                          context.showSnackBar(l10n.comingSoon);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Identity Card
// ═══════════════════════════════════════════════════════════════

class _IdentityCard extends StatelessWidget {
  final BusinessCustomer customer;

  const _IdentityCard({required this.customer});

  @override
  Widget build(BuildContext context) {
    final c = customer;
    final l10n = context.l10n;
    final badgeLabel = _customerBadgeLabel(context, c.badge);

    final details = <String>[
      if (c.area != null) c.area!,
      badgeLabel,
      if (c.usualPayment != null) c.usualPayment!,
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Trailing order count (visually leading in RTL, but we want it on the left)
        Column(
          children: [
            Text(
              '${c.totalOrders}',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
            Text(
              l10n.bizCustomerOrders,
              style: const TextStyle(
                fontSize: 9,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const Spacer(),

        // Name + phone + detail chips
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              c.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            if (c.phone != null) ...[
              const SizedBox(height: 2),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  c.phone!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              alignment: WrapAlignment.end,
              children: details.map((d) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  d,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
        const SizedBox(width: AppSpacing.md),

        // Avatar
        AppImage.avatar(
          url: c.avatar,
          name: c.name,
          radius: 24,
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Stats Grid — 3 columns
// ═══════════════════════════════════════════════════════════════

class _StatsGrid extends StatelessWidget {
  final BusinessCustomer customer;

  const _StatsGrid({required this.customer});

  @override
  Widget build(BuildContext context) {
    final c = customer;
    final l10n = context.l10n;

    return Column(
      children: [
        Row(
          children: [
            _StatCell(
              value: '${c.totalOrders}',
              label: l10n.bizCustomerOrders,
              valueColor: AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.sm),
            _StatCell(
              value: '${c.totalSpentJod.toStringAsFixed(0)} د.أ',
              label: l10n.bizCustomerTotalSpent,
              valueColor: AppColors.success,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            _StatCell(
              value: '${c.avgOrderJod.toStringAsFixed(1)} د.أ',
              label: l10n.bizCustomerAvgOrder,
              valueColor: const Color(0xFF9333EA), // purple-600
            ),
            const SizedBox(width: AppSpacing.sm),
            _StatCell(
              value: c.createdAt != null ? _formatDate(c.createdAt!) : '—',
              label: l10n.bizCustomerMemberSince,
              valueColor: const Color(0xFF374151), // gray-700
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCell extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;

  const _StatCell({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10), // p-2.5
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB), // gray-50
          borderRadius: BorderRadius.circular(12), // rounded-xl
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: valueColor,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 9,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Subscription Card
// ═══════════════════════════════════════════════════════════════

class _SubscriptionCard extends StatelessWidget {
  final BusinessCustomer customer;

  const _SubscriptionCard({required this.customer});

  @override
  Widget build(BuildContext context) {
    final sub = customer.subscription!;
    final l10n = context.l10n;
    final isActive = sub.status == 'active';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          l10n.bizCustomerSubscription,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md), // p-3
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF), // blue-50
            borderRadius: BorderRadius.circular(12), // rounded-xl
            border: Border.all(
              color: const Color(0xFFBFDBFE), // blue-100
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Package name + status badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFFDCFCE7) // green-100
                          : const Color(0xFFFEE2E2), // red-100
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      isActive
                          ? l10n.bizCustomerActive
                          : l10n.bizCustomerEnded,
                      style: TextStyle(
                        fontSize: 9,
                        color: isActive
                            ? AppColors.success
                            : AppColors.error,
                      ),
                    ),
                  ),
                  Text(
                    sub.packageName,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),

              // Credits + frequency
              if (sub.remainingCredits != null) ...[
                const SizedBox(height: 4),
                Text(
                  '${sub.remainingCredits} / ${sub.totalCredits ?? 0}'
                  '${sub.recurringFrequency != null ? ' · ${sub.recurringFrequency}' : ''}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.primary,
                  ),
                ),
              ],

              // Expiry
              if (sub.expiresAt != null) ...[
                const SizedBox(height: 2),
                Text(
                  l10n.bizCustomerExpiresAt(_formatDate(sub.expiresAt!)),
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Activity Section
// ═══════════════════════════════════════════════════════════════

class _ActivitySection extends StatelessWidget {
  final BusinessCustomer customer;

  const _ActivitySection({required this.customer});

  @override
  Widget build(BuildContext context) {
    final c = customer;
    final l10n = context.l10n;

    final sourceLabel = switch (c.source) {
      'organic' => l10n.bizCustomerSourceOrganic,
      'invited' => l10n.bizCustomerSourceInvited,
      'manual' => l10n.bizCustomerSourceManual,
      _ => null,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          l10n.bizCustomerActivity,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              if (c.lastOrderDate != null)
                _ActivityRow(
                  label: l10n.bizCustomerLastOrder,
                  value: _formatDate(c.lastOrderDate!),
                ),
              if (c.lastActivityDate != null) ...[
                if (c.lastOrderDate != null)
                  const SizedBox(height: AppSpacing.sm),
                _ActivityRow(
                  label: l10n.bizCustomerLastActivity,
                  value: _formatDate(c.lastActivityDate!),
                ),
              ],
              if (sourceLabel != null) ...[
                const SizedBox(height: AppSpacing.sm),
                _ActivityRow(
                  label: l10n.bizCustomerSource,
                  value: sourceLabel,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final String label;
  final String value;

  const _ActivityRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.textHint,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Recent Orders Section
// ═══════════════════════════════════════════════════════════════

class _RecentOrdersSection extends StatelessWidget {
  final BusinessCustomer customer;

  const _RecentOrdersSection({required this.customer});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final orders = customer.recentOrders.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          l10n.bizCustomerRecentOrders,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              for (var i = 0; i < orders.length; i++) ...[
                if (i > 0) const Divider(height: AppSpacing.md),
                _RecentOrderRow(order: orders[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _RecentOrderRow extends StatelessWidget {
  final RecentOrder order;

  const _RecentOrderRow({required this.order});

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (order.status) {
      'delivered' || 'completed' => AppColors.success,
      'cancelled' => AppColors.error,
      _ => const Color(0xFFD97706), // amber-600 for pending
    };
    final statusBg = switch (order.status) {
      'delivered' || 'completed' => const Color(0xFFF0FDF4), // green-50
      'cancelled' => const Color(0xFFFEF2F2), // red-50
      _ => const Color(0xFFFFFBEB), // amber-50
    };

    return Row(
      children: [
        // Status badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: statusBg,
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Text(
            order.status,
            style: TextStyle(fontSize: 9, color: statusColor),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        // Amount
        if (order.amount > 0)
          Text(
            '${(order.amount / 100).toStringAsFixed(2)} د.أ',
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
        const Spacer(),
        // Summary + date
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              order.summary,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              _formatDate(order.date),
              style: const TextStyle(
                fontSize: 9,
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Notes Section
// ═══════════════════════════════════════════════════════════════

class _NotesSection extends StatelessWidget {
  final TextEditingController controller;

  const _NotesSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          l10n.bizCustomerPrivateNotes,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: controller,
          maxLines: 3,
          minLines: 2,
          style: const TextStyle(fontSize: 12),
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: l10n.bizCustomerNotesHint,
            hintStyle: const TextStyle(
              fontSize: 12,
              color: AppColors.textHint,
            ),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
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
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Action Button
// ═══════════════════════════════════════════════════════════════

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10), // py-2.5
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isPrimary
              ? null
              : Border.all(color: AppColors.divider),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 12,
              color: isPrimary ? Colors.white : AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isPrimary ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Helpers
// ═══════════════════════════════════════════════════════════════

String _formatDate(String dateStr) {
  final date = DateTime.tryParse(dateStr);
  if (date == null) return dateStr;
  return DateFormat('d MMM y', 'ar').format(date);
}

String _customerBadgeLabel(BuildContext context, CustomerBadge badge) {
  final l10n = context.l10n;
  return switch (badge) {
    CustomerBadge.newCustomer => l10n.bizCustomerBadgeNew,
    CustomerBadge.active => l10n.bizCustomerBadgeActive,
    CustomerBadge.repeat => l10n.bizCustomerBadgeRepeat,
    CustomerBadge.interested => l10n.bizCustomerBadgeInterested,
    CustomerBadge.past => l10n.bizCustomerBadgePast,
  };
}
