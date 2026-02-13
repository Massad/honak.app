import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_status.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_ticket.dart';
import 'package:honak/shared/entities/money.dart';

/// Customer-facing view showing dropoff ticket tracking on a business page.
///
/// Shows active tickets with 4-step progress indicator, items preview,
/// estimated ready date, and status-specific messaging.
/// Past (delivered) tickets are shown in a collapsed section at the bottom.
///
/// Does NOT use a provider. Takes tickets as a constructor param.
class CustomerDropoffView extends StatefulWidget {
  final String sectionLabel;
  final List<DropoffTicket> tickets;

  const CustomerDropoffView({
    super.key,
    this.sectionLabel = 'تتبع قطعك',
    required this.tickets,
  });

  @override
  State<CustomerDropoffView> createState() => _CustomerDropoffViewState();
}

class _CustomerDropoffViewState extends State<CustomerDropoffView> {
  final Set<String> _expandedIds = {};
  bool _showPast = false;

  List<DropoffTicket> get _activeTickets => widget.tickets
      .where((t) =>
          t.status != DropoffStatus.delivered &&
          t.status != DropoffStatus.cancelled)
      .toList();

  List<DropoffTicket> get _pastTickets => widget.tickets
      .where((t) => t.status == DropoffStatus.delivered)
      .toList();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: AppRadius.card,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          _buildHeader(context),

          // Active tickets
          if (_activeTickets.isNotEmpty)
            ..._activeTickets.map((t) => _buildActiveTicket(context, t))
          else
            _buildEmptyState(context),

          // Past tickets (collapsible)
          if (_pastTickets.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            _buildPastSection(context),
          ],

          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }

  // ── Header ──

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          Icon(
            Icons.local_laundry_service_outlined,
            size: 18,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            widget.sectionLabel,
            style: context.textTheme.titleSmall?.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
          if (_activeTickets.isNotEmpty) ...[
            const SizedBox(width: AppSpacing.sm),
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: AppRadius.pill,
              ),
              child: Text(
                '${_activeTickets.length}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: AppColors.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Empty state ──

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      child: Column(
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 36,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'لا توجد قطع قيد المعالجة حالياً',
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade400,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'يمكنك إحضار قطعك للمحل وسنتابع حالتها هنا',
            textAlign: TextAlign.center,
            style: context.textTheme.labelSmall?.copyWith(
              color: Colors.grey.shade300,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  // ── Active ticket card ──

  Widget _buildActiveTicket(BuildContext context, DropoffTicket ticket) {
    final isExpanded = _expandedIds.contains(ticket.id);
    final statusMessage = _statusMessage(ticket.status);

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _statusBorderColor(ticket.status)),
          borderRadius: AppRadius.cardInner,
        ),
        child: Column(
          children: [
            // Header row (always visible)
            GestureDetector(
              onTap: () => setState(() {
                if (isExpanded) {
                  _expandedIds.remove(ticket.id);
                } else {
                  _expandedIds.add(ticket.id);
                }
              }),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsetsDirectional.all(AppSpacing.md),
                child: Row(
                  children: [
                    // Ticket number
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xxs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: AppRadius.pill,
                      ),
                      child: Text(
                        ticket.ticketNumber,
                        textDirection: TextDirection.ltr,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        '${ticket.items.length} قطع',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: Colors.grey.shade500,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    _StatusBadge(status: ticket.status),
                    const SizedBox(width: AppSpacing.xs),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
            ),

            // 4-step progress indicator
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: _buildProgressIndicator(context, ticket.status),
            ),

            // Status message
            Container(
              width: double.infinity,
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: _statusBgColor(ticket.status),
              ),
              child: Text(
                statusMessage,
                style: context.textTheme.bodySmall?.copyWith(
                  color: _statusTextColor(ticket.status),
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Expanded details
            if (isExpanded) ...[
              Padding(
                padding: const EdgeInsetsDirectional.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Items preview
                    ...ticket.items.take(3).map((item) => Padding(
                      padding: const EdgeInsetsDirectional.only(
                        bottom: AppSpacing.xs,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.checkroom_rounded,
                            size: 12,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              '${item.name} × ${item.quantity}',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: Colors.grey.shade600,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Text(
                            item.service,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: Colors.grey.shade400,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    )),
                    if (ticket.items.length > 3)
                      Text(
                        '+${ticket.items.length - 3} قطع أخرى',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.primary,
                          fontSize: 10,
                        ),
                      ),
                    const SizedBox(height: AppSpacing.sm),

                    // Estimated ready
                    Row(
                      children: [
                        Icon(
                          Icons.event_rounded,
                          size: 12,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          'الموعد المتوقع: ${_formatDate(ticket.estimatedReadyAt)}',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.grey.shade500,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),

                    // Total
                    Row(
                      children: [
                        Icon(
                          Icons.payments_outlined,
                          size: 12,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          'الإجمالي: ${Money(ticket.totalPrice).toFormattedArabic()}',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.grey.shade500,
                            fontSize: 10,
                          ),
                        ),
                        if (ticket.paid) ...[
                          const SizedBox(width: AppSpacing.sm),
                          Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0FDF4),
                              borderRadius: AppRadius.pill,
                            ),
                            child: Text(
                              'مدفوع',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: AppColors.success,
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ── Progress indicator ──

  Widget _buildProgressIndicator(BuildContext context, DropoffStatus status) {
    final steps = [
      DropoffStatus.received,
      DropoffStatus.processing,
      DropoffStatus.ready,
      DropoffStatus.delivered,
    ];
    final activeIdx = steps.indexOf(status);

    return Row(
      children: List.generate(steps.length * 2 - 1, (i) {
        if (i.isOdd) {
          // Connector line
          final stepIdx = i ~/ 2;
          return Expanded(
            child: Container(
              height: 2,
              color: stepIdx < activeIdx
                  ? _statusColor(steps[stepIdx])
                  : Colors.grey.shade200,
            ),
          );
        }
        // Step dot
        final stepIdx = i ~/ 2;
        final isActive = stepIdx <= activeIdx;
        return Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: isActive
                ? _statusColor(steps[stepIdx])
                : Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  // ── Past tickets section ──

  Widget _buildPastSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => _showPast = !_showPast),
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                Icon(
                  _showPast
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 14,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'طلبات سابقة (${_pastTickets.length})',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade400,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Divider(color: Colors.grey.shade100, height: 1),
                ),
              ],
            ),
          ),
          if (_showPast) ...[
            const SizedBox(height: AppSpacing.sm),
            ..._pastTickets.map((ticket) => _buildPastTicket(context, ticket)),
          ],
        ],
      ),
    );
  }

  Widget _buildPastTicket(BuildContext context, DropoffTicket ticket) {
    final price = Money(ticket.totalPrice);
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      child: Opacity(
        opacity: 0.7,
        child: Container(
          padding: const EdgeInsetsDirectional.all(AppSpacing.md),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade100),
            borderRadius: AppRadius.cardInner,
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 14,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.ticketNumber,
                      textDirection: TextDirection.ltr,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      '${ticket.items.length} قطع · ${price.toFormattedArabic()}',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade400,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _formatDate(ticket.pickedUpAt ?? ticket.completedAt ?? ''),
                style: context.textTheme.labelSmall?.copyWith(
                  color: Colors.grey.shade400,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Helpers ──

  String _statusMessage(DropoffStatus status) => switch (status) {
        DropoffStatus.received => 'تم استلام قطعتك وبانتظار المعالجة',
        DropoffStatus.processing => 'قطعتك قيد المعالجة',
        DropoffStatus.ready => 'جاهزة للاستلام!',
        _ => '',
      };

  Color _statusColor(DropoffStatus status) => switch (status) {
        DropoffStatus.received => const Color(0xFF1A73E8),
        DropoffStatus.processing => const Color(0xFFFF9800),
        DropoffStatus.ready => const Color(0xFF43A047),
        DropoffStatus.delivered => const Color(0xFF9CA3AF),
        DropoffStatus.cancelled => const Color(0xFFE53935),
      };

  Color _statusBgColor(DropoffStatus status) => switch (status) {
        DropoffStatus.received => const Color(0xFFEFF6FF),
        DropoffStatus.processing => const Color(0xFFFFF8E1),
        DropoffStatus.ready => const Color(0xFFF0FDF4),
        _ => Colors.grey.shade50,
      };

  Color _statusTextColor(DropoffStatus status) => switch (status) {
        DropoffStatus.received => const Color(0xFF1A73E8),
        DropoffStatus.processing => const Color(0xFFFF9800),
        DropoffStatus.ready => const Color(0xFF43A047),
        _ => Colors.grey.shade500,
      };

  Color _statusBorderColor(DropoffStatus status) => switch (status) {
        DropoffStatus.received => const Color(0xFFBFDBFE),
        DropoffStatus.processing => const Color(0xFFFFE082),
        DropoffStatus.ready => const Color(0xFFBBF7D0),
        _ => Colors.grey.shade100,
      };

  String _formatDate(String timestamp) {
    final dt = DateTime.tryParse(timestamp);
    if (dt == null) return timestamp;
    return DateFormat('d MMM', 'ar').format(dt);
  }
}

// ═══════════════════════════════════════════════════════════════
// Status Badge (customer-facing)
// ═══════════════════════════════════════════════════════════════

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final DropoffStatus status;

  @override
  Widget build(BuildContext context) {
    final (color, bgColor) = switch (status) {
      DropoffStatus.received => (
        const Color(0xFF1A73E8),
        const Color(0xFFEFF6FF),
      ),
      DropoffStatus.processing => (
        const Color(0xFFFF9800),
        const Color(0xFFFFF8E1),
      ),
      DropoffStatus.ready => (
        const Color(0xFF43A047),
        const Color(0xFFF0FDF4),
      ),
      DropoffStatus.delivered => (
        const Color(0xFF9CA3AF),
        const Color(0xFFF9FAFB),
      ),
      DropoffStatus.cancelled => (
        const Color(0xFFE53935),
        const Color(0xFFFEF2F2),
      ),
    };

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        status.labelAr,
        style: context.textTheme.labelSmall?.copyWith(
          color: color,
          fontSize: 10,
        ),
      ),
    );
  }
}
