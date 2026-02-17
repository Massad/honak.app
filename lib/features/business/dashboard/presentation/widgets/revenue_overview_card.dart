import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Revenue data for the overview card.
/// All amounts in piasters (integer cents).
class RevenueData {
  final int today;
  final int yesterday;
  final int ordersToday;
  final PaymentBreakdown? paymentBreakdown;

  const RevenueData({
    required this.today,
    required this.yesterday,
    required this.ordersToday,
    this.paymentBreakdown,
  });

  /// Week is derived from daily × 6.5 (same as Figma).
  int get week => (today * 6.5).round();
  int get lastWeek => (yesterday * 6.5).round();

  /// Month is derived from daily × 26 (same as Figma).
  int get month => today * 26;
  int get lastMonth => yesterday * 26;
}

/// Payment method breakdown, all in piasters.
class PaymentBreakdown {
  final int cash;
  final int cliq;
  final int bank;

  const PaymentBreakdown({
    required this.cash,
    required this.cliq,
    required this.bank,
  });
}

enum _RevenuePeriod { today, week, month }

/// Prominent blue gradient revenue card with period switching.
/// Matches Figma RevenueOverview.tsx.
class RevenueOverviewCard extends StatefulWidget {
  final RevenueData data;

  const RevenueOverviewCard({super.key, required this.data});

  @override
  State<RevenueOverviewCard> createState() => _RevenueOverviewCardState();
}

class _RevenueOverviewCardState extends State<RevenueOverviewCard> {
  _RevenuePeriod _period = _RevenuePeriod.today;

  Map<_RevenuePeriod, String> _periodLabels(BuildContext context) => {
    _RevenuePeriod.today: context.l10n.bizRevenuePeriodToday,
    _RevenuePeriod.week: context.l10n.bizRevenuePeriodWeek,
    _RevenuePeriod.month: context.l10n.bizRevenuePeriodMonth,
  };

  Map<_RevenuePeriod, String> _prevLabels(BuildContext context) => {
    _RevenuePeriod.today: context.l10n.bizRevenuePrevToday,
    _RevenuePeriod.week: context.l10n.bizRevenuePrevWeek,
    _RevenuePeriod.month: context.l10n.bizRevenuePrevMonth,
  };

  int _amount() => switch (_period) {
        _RevenuePeriod.today => widget.data.today,
        _RevenuePeriod.week => widget.data.week,
        _RevenuePeriod.month => widget.data.month,
      };

  int _previous() => switch (_period) {
        _RevenuePeriod.today => widget.data.yesterday,
        _RevenuePeriod.week => widget.data.lastWeek,
        _RevenuePeriod.month => widget.data.lastMonth,
      };

  int _orders() => switch (_period) {
        _RevenuePeriod.today => widget.data.ordersToday,
        _RevenuePeriod.week => (widget.data.ordersToday * 6.5).round(),
        _RevenuePeriod.month => widget.data.ordersToday * 28,
      };

  String _formatJod(int piasters) {
    final jod = piasters / 100;
    if (jod == jod.truncateToDouble()) return jod.toInt().toString();
    return jod.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final amount = _amount();
    final previous = _previous();
    final orders = _orders();
    final delta = previous > 0
        ? ((amount - previous) / previous * 100).round()
        : 0;
    final isUp = delta >= 0;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: AlignmentDirectional.centerEnd,
            end: AlignmentDirectional.centerStart,
            colors: [Color(0xFF1A73E8), Color(0xFF1E88E5)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1A73E8).withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period tabs
            _buildPeriodTabs(),
            const SizedBox(height: AppSpacing.md),

            // Main amount + delta
            _buildAmountRow(amount, previous, delta, isUp),
            const SizedBox(height: AppSpacing.sm),

            // Orders count
            _buildOrdersRow(orders, amount),

            // Payment breakdown (today only)
            if (_period == _RevenuePeriod.today &&
                widget.data.paymentBreakdown != null) ...[
              const SizedBox(height: AppSpacing.md),
              _buildPaymentBreakdown(widget.data.paymentBreakdown!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodTabs() {
    final labels = _periodLabels(context);
    return Row(
      children: _RevenuePeriod.values.map((p) {
        final selected = _period == p;
        return Padding(
          padding: const EdgeInsetsDirectional.only(end: 6),
          child: GestureDetector(
            onTap: () => setState(() => _period = p),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? Colors.white.withValues(alpha: 0.25)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                labels[p]!,
                style: TextStyle(
                  fontSize: 10,
                  color: selected
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.6),
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAmountRow(int amount, int previous, int delta, bool isUp) {
    final periodLabel = _periodLabels(context)[_period]!;
    final prevLabel = _prevLabels(context)[_period]!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Amount
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              periodLabel,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  _formatJod(amount),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  context.l10n.bizRevenueCurrency,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ],
        ),

        // Delta + previous
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isUp ? Icons.trending_up : Icons.trending_down,
                  size: 12,
                  color: isUp
                      ? const Color(0xFF81C784) // green-300
                      : const Color(0xFFEF9A9A), // red-300
                ),
                const SizedBox(width: 4),
                Text(
                  '${isUp ? '+' : ''}$delta%',
                  style: TextStyle(
                    fontSize: 11,
                    color: isUp
                        ? const Color(0xFF81C784)
                        : const Color(0xFFEF9A9A),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              context.l10n.bizRevenuePrevAmount(prevLabel, _formatJod(previous)),
              style: TextStyle(
                fontSize: 9,
                color: Colors.white.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrdersRow(int orders, int amount) {
    final avg = orders > 0
        ? (amount / orders / 100).toStringAsFixed(1)
        : '0';

    return Container(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.l10n.bizRevenueOrderCount(orders),
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          Text(
            context.l10n.bizRevenueAvgOrder(avg),
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentBreakdown(PaymentBreakdown breakdown) {
    return Container(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.bizRevenuePaymentMethods,
            style: TextStyle(
              fontSize: 9,
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              _PaymentChip(
                icon: Icons.payments_outlined,
                iconColor: const Color(0xFF81C784), // green-300
                label: context.l10n.bizRevenuePayCash,
                amount: _formatJod(breakdown.cash),
              ),
              const SizedBox(width: AppSpacing.md),
              _PaymentChip(
                icon: Icons.smartphone_outlined,
                iconColor: const Color(0xFFCE93D8), // purple-300
                label: context.l10n.bizRevenuePayCliq,
                amount: _formatJod(breakdown.cliq),
              ),
              if (breakdown.bank > 0) ...[
                const SizedBox(width: AppSpacing.md),
                _PaymentChip(
                  icon: Icons.credit_card_outlined,
                  iconColor: const Color(0xFF90CAF9), // blue-200
                  label: context.l10n.bizRevenuePayBank,
                  amount: _formatJod(breakdown.bank),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _PaymentChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String amount;

  const _PaymentChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 10, color: iconColor),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
