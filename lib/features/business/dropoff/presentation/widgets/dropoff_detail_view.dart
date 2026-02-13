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
import 'package:honak/features/business/dropoff/presentation/widgets/dropoff_status_config.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/ticket_activity_log.dart';
import 'package:honak/shared/entities/money.dart';

/// Full-screen draggable bottom sheet showing complete ticket details.
///
/// Matches the Figma DropoffDetailView component with:
/// - Header: back arrow, ticket #, urgent/overdue badges, activity log button
/// - Progress bar: 4 connected circles with status lines
/// - Customer card: avatar, name, phone, chat button
/// - Items cards: photo status bars, attribute chips, notes
/// - Payment card, timing card, activity log preview
/// - Bottom action bar: chat + advance button
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
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.xxl),
            ),
          ),
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  children: [
                    _buildProgressBar(context, ticket),
                    _buildCustomerCard(context, ticket),
                    _buildItemsCard(context, ticket),
                    _buildPaymentCard(context, ticket),
                    _buildTimingCard(context, ticket),
                    _buildActivitySection(context),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
              _buildBottomBar(context, ticket),
            ],
          ),
        );
      },
    );
  }

  // ── Header ──

  Widget _buildHeader(BuildContext context) {
    final ticket = widget.ticket;
    final isOverdue = _isOverdue(ticket);

    return Container(
      color: AppColors.surface,
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.md,
            ),
            child: Row(
              children: [
                // Back button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 22,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),

                // Title + badges
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'تذكرة #${ticket.ticketNumber}',
                        textDirection: TextDirection.rtl,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      if (ticket.urgent) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF2F2),
                            borderRadius: AppRadius.pill,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.bolt_rounded,
                                size: 10,
                                color: Color(0xFFE53935),
                              ),
                              SizedBox(width: 2),
                              Text(
                                'مستعجل',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFFE53935),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (isOverdue) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8E1),
                            borderRadius: AppRadius.pill,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                size: 10,
                                color: Color(0xFFFF9800),
                              ),
                              SizedBox(width: 2),
                              Text(
                                'متأخر',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFFFF9800),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Activity log button
                GestureDetector(
                  onTap: () => setState(() => _showFullLog = !_showFullLog),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: AppRadius.cardInner,
                    ),
                    child: const Icon(
                      Icons.history_rounded,
                      size: 16,
                      color: Color(0xFF1A73E8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade100),
        ],
      ),
    );
  }

  // ── Progress Bar ──

  Widget _buildProgressBar(BuildContext context, DropoffTicket ticket) {
    final currentIdx =
        DropoffStatusConfig.statusFlow.indexOf(ticket.status);

    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Step circles + connecting lines
          Row(
            children: [
              for (var i = 0;
                  i < DropoffStatusConfig.statusFlow.length;
                  i++) ...[
                _buildProgressStep(
                  context,
                  DropoffStatusConfig.statusFlow[i],
                  i,
                  currentIdx,
                ),
                if (i < DropoffStatusConfig.statusFlow.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsetsDirectional.symmetric(
                        horizontal: 4,
                      ),
                      decoration: BoxDecoration(
                        color: i < currentIdx
                            ? const Color(0xFF43A047)
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Current status badge
          _buildCurrentStatusBadge(context, ticket),
        ],
      ),
    );
  }

  Widget _buildProgressStep(
    BuildContext context,
    DropoffStatus status,
    int index,
    int currentIdx,
  ) {
    final conf = DropoffStatusConfig.of(status);
    final isCurrent = index == currentIdx;
    final isComplete = index < currentIdx;
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isCurrent
                ? conf.bgColor
                : isComplete
                    ? const Color(0xFF43A047).withValues(alpha: 0.1)
                    : Colors.grey.shade50,
            shape: BoxShape.circle,
            border: Border.all(
              color: isCurrent
                  ? conf.borderColor
                  : isComplete
                      ? const Color(0xFF43A047)
                      : Colors.grey.shade200,
              width: 2,
            ),
          ),
          child: Icon(
            isComplete ? Icons.check_circle_rounded : conf.icon,
            size: 14,
            color: isCurrent
                ? conf.color
                : isComplete
                    ? const Color(0xFF43A047)
                    : Colors.grey.shade300,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          conf.label,
          style: TextStyle(
            fontSize: 9,
            color: isCurrent
                ? conf.color
                : isComplete
                    ? const Color(0xFF43A047)
                    : Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentStatusBadge(
    BuildContext context,
    DropoffTicket ticket,
  ) {
    final conf = DropoffStatusConfig.of(ticket.status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: conf.bgColor,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: conf.borderColor),
      ),
      child: Row(
        children: [
          Icon(conf.icon, size: 14, color: conf.color),
          const SizedBox(width: AppSpacing.sm),
          Text(
            conf.label,
            style: TextStyle(fontSize: 12, color: conf.color),
          ),
          if (ticket.status != DropoffStatus.delivered &&
              ticket.status != DropoffStatus.cancelled) ...[
            const Spacer(),
            Text(
              'الموعد المتوقع: ${_formatShortDate(ticket.estimatedReadyAt)}',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Customer Card ──

  Widget _buildCustomerCard(BuildContext context, DropoffTicket ticket) {
    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'العميل',
            style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline_rounded,
                  size: 20,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.customerName,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    if (ticket.customerPhone != null) ...[
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: 10,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            ticket.customerPhone!,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 12,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A73E8),
                  borderRadius: AppRadius.cardInner,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 13,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'محادثة',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Items Card ──

  Widget _buildItemsCard(BuildContext context, DropoffTicket ticket) {
    final total = Money(ticket.totalPrice);
    final totalItems =
        ticket.items.fold(0, (sum, item) => sum + item.quantity);

    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'القطع ($totalItems قطعة)',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade400,
                ),
              ),
              const Spacer(),
              Text(
                '${total.toFormattedArabic()} د.أ',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ...ticket.items.map((item) {
            final price = Money(item.price * item.quantity);
            return Container(
              margin: const EdgeInsetsDirectional.only(
                bottom: AppSpacing.md,
              ),
              padding: const EdgeInsetsDirectional.all(AppSpacing.md),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade100),
                borderRadius: AppRadius.cardInner,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + qty + price
                  Row(
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 14,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF111827),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '×${item.quantity}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${price.toFormattedArabic()} د.أ',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),

                  // Service + attribute chips
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      _buildChip(item.service, Colors.grey.shade500),
                      ...item.attributes.entries.map(
                        (e) => _buildChip(e.value, Colors.grey.shade500),
                      ),
                    ],
                  ),

                  // Photo status bars
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: item.photoBefore != null
                                ? const Color(0xFFEFF6FF)
                                : Colors.grey.shade50,
                            borderRadius:
                                BorderRadius.circular(AppRadius.md),
                            border: Border.all(
                              color: item.photoBefore != null
                                  ? const Color(0xFFBFDBFE)
                                  : Colors.grey.shade100,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 11,
                                color: item.photoBefore != null
                                    ? const Color(0xFF1A73E8)
                                    : Colors.grey.shade300,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item.photoBefore != null
                                    ? 'صورة قبل ✓'
                                    : 'لا توجد صورة قبل',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: item.photoBefore != null
                                      ? const Color(0xFF1A73E8)
                                      : Colors.grey.shade300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: item.photoAfter != null
                                ? const Color(0xFFF0FDF4)
                                : Colors.grey.shade50,
                            borderRadius:
                                BorderRadius.circular(AppRadius.md),
                            border: Border.all(
                              color: item.photoAfter != null
                                  ? const Color(0xFFBBF7D0)
                                  : Colors.grey.shade100,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.image_outlined,
                                size: 11,
                                color: item.photoAfter != null
                                    ? const Color(0xFF43A047)
                                    : Colors.grey.shade300,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item.photoAfter != null
                                    ? 'صورة بعد ✓'
                                    : 'لا توجد صورة بعد',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: item.photoAfter != null
                                      ? const Color(0xFF43A047)
                                      : Colors.grey.shade300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Item notes
                  if (item.notes != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E1),
                        borderRadius:
                            BorderRadius.circular(AppRadius.md),
                      ),
                      child: Text(
                        item.notes!,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFFFF9800),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildChip(String text, Color color) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 10, color: color),
      ),
    );
  }

  // ── Payment Card ──

  Widget _buildPaymentCard(BuildContext context, DropoffTicket ticket) {
    final total = Money(ticket.totalPrice);

    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'الدفع',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade400,
                ),
              ),
              const Spacer(),
              if (ticket.paid)
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: AppRadius.pill,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.credit_card_rounded,
                        size: 10,
                        color: AppColors.success,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'مدفوع${ticket.paymentMethod != null ? ' (${ticket.paymentMethod})' : ''}',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: AppRadius.pill,
                  ),
                  child: Text(
                    'لم يتم الدفع بعد',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Text(
                'الإجمالي',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
              const Spacer(),
              Text(
                '${total.toFormattedArabic()} د.أ',
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          if (ticket.notes != null) ...[
            const SizedBox(height: AppSpacing.md),
            Divider(height: 1, color: Colors.grey.shade100),
            const SizedBox(height: AppSpacing.md),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'ملاحظات',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                ticket.notes!,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Timing Card ──

  Widget _buildTimingCard(BuildContext context, DropoffTicket ticket) {
    final isOverdue = _isOverdue(ticket);

    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'المواعيد',
            style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildTimingRow(
            icon: Icons.schedule_rounded,
            iconColor: Colors.grey.shade400,
            label: 'استلام القطع',
            value: _formatDateTime(ticket.droppedOffAt),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildTimingRow(
            icon: Icons.schedule_rounded,
            iconColor: Colors.grey.shade400,
            label: 'الموعد المتوقع',
            value: _formatShortDate(ticket.estimatedReadyAt),
            valueColor: isOverdue ? const Color(0xFFE53935) : null,
            suffix: isOverdue ? ' (متأخر)' : null,
          ),
          if (ticket.startedAt != null) ...[
            const SizedBox(height: AppSpacing.sm),
            _buildTimingRow(
              icon: Icons.autorenew_rounded,
              iconColor: const Color(0xFFFF9800),
              label: 'بدء المعالجة',
              value: _formatDateTime(ticket.startedAt!),
            ),
          ],
          if (ticket.completedAt != null) ...[
            const SizedBox(height: AppSpacing.sm),
            _buildTimingRow(
              icon: Icons.check_circle_rounded,
              iconColor: const Color(0xFF43A047),
              label: 'اكتمل العمل',
              value: _formatDateTime(ticket.completedAt!),
            ),
          ],
          if (ticket.pickedUpAt != null) ...[
            const SizedBox(height: AppSpacing.sm),
            _buildTimingRow(
              icon: Icons.local_shipping_rounded,
              iconColor: Colors.grey.shade400,
              label: 'تسليم العميل',
              value: _formatDateTime(ticket.pickedUpAt!),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimingRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    Color? valueColor,
    String? suffix,
  }) {
    return Row(
      children: [
        Icon(icon, size: 11, color: iconColor),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
        ),
        const Spacer(),
        Text(
          '$value${suffix ?? ''}',
          style: TextStyle(
            fontSize: 11,
            color: valueColor ?? Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  // ── Activity Section ──

  Widget _buildActivitySection(BuildContext context) {
    final entries = _activityEntries;
    if (entries.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.history_rounded,
                size: 10,
                color: Colors.grey.shade400,
              ),
              const SizedBox(width: 4),
              Text(
                'سجل النشاط (${entries.length} إجراء)',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade400,
                ),
              ),
              const Spacer(),
              if (!_showFullLog)
                GestureDetector(
                  onTap: () => setState(() => _showFullLog = true),
                  child: const Text(
                    'عرض الكل',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF1A73E8),
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
      ),
    );
  }

  // ── Bottom Action Bar ──

  Widget _buildBottomBar(BuildContext context, DropoffTicket ticket) {
    if (ticket.status == DropoffStatus.delivered ||
        ticket.status == DropoffStatus.cancelled) {
      return const SizedBox.shrink();
    }

    final action = DropoffStatusConfig.nextAction[ticket.status];
    if (action == null) return const SizedBox.shrink();

    final isReady = ticket.status == DropoffStatus.ready;
    final buttonColor =
        isReady ? const Color(0xFF43A047) : const Color(0xFF1A73E8);
    final buttonIcon = switch (ticket.status) {
      DropoffStatus.received => Icons.autorenew_rounded,
      DropoffStatus.processing => Icons.check_circle_rounded,
      DropoffStatus.ready => Icons.local_shipping_rounded,
      _ => Icons.arrow_forward_rounded,
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
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: AppRadius.cardInner,
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 14,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'محادثة',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),

            // Advance button
            Expanded(
              child: GestureDetector(
                onTap: widget.onAdvance != null
                    ? () => widget.onAdvance!(ticket.id)
                    : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: AppRadius.cardInner,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(buttonIcon, size: 14, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        action.label,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
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

  bool _isOverdue(DropoffTicket ticket) {
    if (ticket.status == DropoffStatus.delivered ||
        ticket.status == DropoffStatus.cancelled) {
      return false;
    }
    final ready = DateTime.tryParse(ticket.estimatedReadyAt);
    if (ready == null) return false;
    return DateTime.now().isAfter(ready);
  }

  String _formatDateTime(String timestamp) {
    final dt = DateTime.tryParse(timestamp);
    if (dt == null) return timestamp;
    return DateFormat('yyyy/MM/dd h:mm a', 'ar').format(dt);
  }

  String _formatShortDate(String timestamp) {
    final dt = DateTime.tryParse(timestamp);
    if (dt == null) return timestamp;
    return DateFormat('yyyy-MM-dd').format(dt);
  }
}
