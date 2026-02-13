import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_status.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_ticket.dart';
import 'package:honak/features/business/dropoff/domain/entities/ticket_activity.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/activity_log_utils.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/ticket_activity_log.dart';
import 'package:honak/shared/entities/money.dart';

/// Full-screen draggable bottom sheet showing complete ticket details.
///
/// Includes a 4-step progress bar, customer info, items list,
/// payment section, timing details, activity log preview, and action bar.
class DropoffDetailView extends StatefulWidget {
  final DropoffTicket ticket;
  final ValueChanged<String>? onAdvance;

  const DropoffDetailView({
    super.key,
    required this.ticket,
    this.onAdvance,
  });

  @override
  State<DropoffDetailView> createState() => _DropoffDetailViewState();
}

class _DropoffDetailViewState extends State<DropoffDetailView> {
  bool _showFullLog = false;

  List<TicketActivityEntry> get _activityEntries =>
      generateMockActivity(widget.ticket);

  @override
  Widget build(BuildContext context) {
    final ticket = widget.ticket;

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.xxl),
            ),
          ),
          child: Column(
            children: [
              // Drag handle + close
              _buildHeader(context),

              // Scrollable content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  children: [
                    // Progress bar
                    _buildProgressBar(context, ticket.status),
                    const SizedBox(height: AppSpacing.lg),

                    // Customer info
                    _buildCustomerSection(context, ticket),
                    const SizedBox(height: AppSpacing.lg),

                    // Items list
                    _buildItemsSection(context, ticket),
                    const SizedBox(height: AppSpacing.lg),

                    // Payment section
                    _buildPaymentSection(context, ticket),
                    const SizedBox(height: AppSpacing.lg),

                    // Timing details
                    _buildTimingSection(context, ticket),
                    const SizedBox(height: AppSpacing.lg),

                    // Activity log
                    _buildActivitySection(context),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),

              // Bottom action bar
              _buildBottomBar(context, ticket),
            ],
          ),
        );
      },
    );
  }

  // ── Header ──

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        0,
      ),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Row(
            children: [
              Text(
                'تفاصيل التذكرة ${widget.ticket.ticketNumber}',
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }

  // ── 4-Step Progress Bar ──

  Widget _buildProgressBar(BuildContext context, DropoffStatus status) {
    final steps = [
      (DropoffStatus.received, 'مستلمة', Icons.inbox_rounded),
      (DropoffStatus.processing, 'قيد المعالجة', Icons.settings_rounded),
      (DropoffStatus.ready, 'جاهزة', Icons.check_circle_outline_rounded),
      (DropoffStatus.delivered, 'تم التسليم', Icons.done_all_rounded),
    ];
    final activeIdx = steps.indexWhere((s) => s.$1 == status);

    return Row(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Expanded(
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: i <= activeIdx
                        ? _statusColor(steps[i].$1)
                        : Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    steps[i].$3,
                    size: 16,
                    color: i <= activeIdx ? Colors.white : Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  steps[i].$2,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: i <= activeIdx
                        ? _statusColor(steps[i].$1)
                        : Colors.grey.shade400,
                    fontSize: 9,
                    fontWeight:
                        i == activeIdx ? FontWeight.w600 : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          if (i < steps.length - 1)
            Expanded(
              flex: 0,
              child: Container(
                width: 24,
                height: 2,
                color: i < activeIdx
                    ? _statusColor(steps[i].$1)
                    : Colors.grey.shade200,
              ),
            ),
        ],
      ],
    );
  }

  // ── Customer Section ──

  Widget _buildCustomerSection(BuildContext context, DropoffTicket ticket) {
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: AppRadius.cardInner,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline_rounded,
              size: 20,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.customerName,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                if (ticket.customerPhone != null) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    ticket.customerPhone!,
                    textDirection: TextDirection.ltr,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Colors.grey.shade500,
                      fontSize: 10,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (ticket.customerPhone != null) ...[
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 14,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.phone_outlined,
                  size: 14,
                  color: AppColors.success,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Items Section ──

  Widget _buildItemsSection(BuildContext context, DropoffTicket ticket) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'القطع (${ticket.items.length})',
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...ticket.items.map((item) {
          final price = Money(item.price);
          return Container(
            margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
            padding: const EdgeInsetsDirectional.all(AppSpacing.md),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade100),
              borderRadius: AppRadius.cardInner,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${item.name} × ${item.quantity}',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurface,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      price.toFormattedArabic(),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  item.service,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.primary,
                    fontSize: 10,
                  ),
                ),
                if (item.attributes.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: item.attributes.entries.map((attr) {
                      return Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${attr.key}: ${attr.value}',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.grey.shade500,
                            fontSize: 9,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                // Photo status icons
                if (item.photoBefore != null || item.photoAfter != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      if (item.photoBefore != null) ...[
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 10,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'قبل',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: AppColors.secondary,
                            fontSize: 9,
                          ),
                        ),
                      ],
                      if (item.photoBefore != null && item.photoAfter != null)
                        const SizedBox(width: AppSpacing.sm),
                      if (item.photoAfter != null) ...[
                        Icon(
                          Icons.camera_rounded,
                          size: 10,
                          color: AppColors.success,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'بعد',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: AppColors.success,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          );
        }),
      ],
    );
  }

  // ── Payment Section ──

  Widget _buildPaymentSection(BuildContext context, DropoffTicket ticket) {
    final total = Money(ticket.totalPrice);

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: ticket.paid
            ? const Color(0xFFF0FDF4)
            : Colors.grey.shade50,
        borderRadius: AppRadius.cardInner,
        border: Border.all(
          color: ticket.paid
              ? const Color(0xFFBBF7D0)
              : Colors.grey.shade100,
        ),
      ),
      child: Row(
        children: [
          Icon(
            ticket.paid
                ? Icons.check_circle
                : Icons.payments_outlined,
            size: 18,
            color: ticket.paid ? AppColors.success : Colors.grey.shade400,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.paid ? 'مدفوع' : 'غير مدفوع',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: ticket.paid
                        ? AppColors.success
                        : Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                if (ticket.paid && ticket.paymentMethod != null) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    ticket.paymentMethod!,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Colors.grey.shade500,
                      fontSize: 10,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Text(
            total.toFormattedArabic(),
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  // ── Timing Section ──

  Widget _buildTimingSection(BuildContext context, DropoffTicket ticket) {
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: AppRadius.cardInner,
      ),
      child: Column(
        children: [
          _TimingRow(
            label: 'وقت الاستلام',
            value: _formatDateTime(ticket.droppedOffAt),
            icon: Icons.inbox_rounded,
          ),
          const SizedBox(height: AppSpacing.sm),
          _TimingRow(
            label: 'الموعد المتوقع',
            value: _formatDateTime(ticket.estimatedReadyAt),
            icon: Icons.event_rounded,
          ),
          if (ticket.startedAt != null) ...[
            const SizedBox(height: AppSpacing.sm),
            _TimingRow(
              label: 'بدء المعالجة',
              value: _formatDateTime(ticket.startedAt!),
              icon: Icons.play_arrow_rounded,
            ),
          ],
          if (ticket.completedAt != null) ...[
            const SizedBox(height: AppSpacing.sm),
            _TimingRow(
              label: 'اكتمال المعالجة',
              value: _formatDateTime(ticket.completedAt!),
              icon: Icons.check_circle_outline_rounded,
            ),
          ],
          if (ticket.pickedUpAt != null) ...[
            const SizedBox(height: AppSpacing.sm),
            _TimingRow(
              label: 'وقت التسليم',
              value: _formatDateTime(ticket.pickedUpAt!),
              icon: Icons.done_all_rounded,
            ),
          ],
        ],
      ),
    );
  }

  // ── Activity Section ──

  Widget _buildActivitySection(BuildContext context) {
    final entries = _activityEntries;
    if (entries.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'سجل النشاط',
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade500,
                fontSize: 12,
              ),
            ),
            const Spacer(),
            if (!_showFullLog)
              GestureDetector(
                onTap: () => setState(() => _showFullLog = true),
                child: Text(
                  'عرض الكل',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.primary,
                    fontSize: 10,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        TicketActivityLog(
          entries: entries,
          isPreview: !_showFullLog,
        ),
      ],
    );
  }

  // ── Bottom Action Bar ──

  Widget _buildBottomBar(BuildContext context, DropoffTicket ticket) {
    if (ticket.status == DropoffStatus.delivered ||
        ticket.status == DropoffStatus.cancelled) {
      return const SizedBox.shrink();
    }

    final (label, color) = switch (ticket.status) {
      DropoffStatus.received => ('بدء المعالجة', AppColors.primary),
      DropoffStatus.processing => ('جاهز للاستلام', AppColors.success),
      DropoffStatus.ready => ('تم التسليم', const Color(0xFF616161)),
      _ => ('', AppColors.primary),
    };

    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Chat button
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: AppRadius.cardInner,
              ),
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                size: 18,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(width: AppSpacing.md),

            // Advance button
            Expanded(
              child: SizedBox(
                height: 44,
                child: ElevatedButton(
                  onPressed: widget.onAdvance != null
                      ? () => widget.onAdvance!(ticket.id)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.cardInner,
                    ),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ──

  Color _statusColor(DropoffStatus status) => switch (status) {
        DropoffStatus.received => AppColors.secondary,
        DropoffStatus.processing => AppColors.primary,
        DropoffStatus.ready => AppColors.success,
        DropoffStatus.delivered => const Color(0xFF616161),
        DropoffStatus.cancelled => AppColors.error,
      };

  String _formatDateTime(String timestamp) {
    final dt = DateTime.tryParse(timestamp);
    if (dt == null) return timestamp;
    return DateFormat('yyyy/MM/dd h:mm a', 'ar').format(dt);
  }
}

// ═══════════════════════════════════════════════════════════════
// Timing Row
// ═══════════════════════════════════════════════════════════════

class _TimingRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _TimingRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade400),
        const SizedBox(width: AppSpacing.sm),
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: Colors.grey.shade500,
            fontSize: 10,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurface,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
