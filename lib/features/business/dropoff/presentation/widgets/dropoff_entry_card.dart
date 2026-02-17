import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_status.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_ticket.dart';
import 'package:honak/features/business/dropoff/domain/entities/ticket_activity.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/dropoff_status_config.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/dropoff_status_picker.dart';
import 'package:honak/features/business/shared/widgets/photo_toggle_button.dart';
import 'package:honak/shared/entities/money.dart';

/// Card displaying a single dropoff ticket in the board list.
///
/// Matches the Figma DropoffEntryCard component with:
/// - Header row: ticket #, activity log, urgent/overdue badges, status dropdown
/// - Customer section: avatar, name, phone, price, paid badge
/// - Items chips: first 3 items as rounded pills + overflow + total count
/// - Timing row: drop-off time + estimated ready date
/// - Notes section (orange background)
/// - Photo action buttons (before/after with dashed/solid borders)
/// - Full-width advance button (status-colored)
class DropoffEntryCard extends StatelessWidget {
  const DropoffEntryCard({
    super.key,
    required this.ticket,
    this.onAdvance,
    this.onTap,
    this.onStatusChange,
    this.onPhotoBefore,
    this.onPhotoAfter,
    this.onRequestInfo,
    this.onActivityLog,
    this.activityLog = const [],
    this.compact = false,
  });

  final DropoffTicket ticket;
  final VoidCallback? onAdvance;
  final VoidCallback? onTap;
  final ValueChanged<DropoffStatus>? onStatusChange;
  final VoidCallback? onPhotoBefore;
  final VoidCallback? onPhotoAfter;
  final VoidCallback? onRequestInfo;
  final VoidCallback? onActivityLog;
  final List<TicketActivityEntry> activityLog;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) return _buildCompactCard(context);
    return _buildFullCard(context);
  }

  // ── Compact card for delivered entries ──

  Widget _buildCompactCard(BuildContext context) {
    final price = Money(ticket.totalPrice);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Opacity(
        opacity: 0.7,
        child: Padding(
          padding: const EdgeInsetsDirectional.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Icon(
                  Icons.local_laundry_service_outlined,
                  size: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          ticket.ticketNumber,
                          textDirection: Directionality.of(context),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          ticket.customerName,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      '${ticket.items.length} قطع · ${price.toFormattedArabic()}',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.check_circle, size: 16, color: AppColors.success),
            ],
          ),
        ),
      ),
    );
  }

  // ── Full card ──

  Widget _buildFullCard(BuildContext context) {
    final statusConf = DropoffStatusConfig.of(ticket.status);
    final isOverdue = _isOverdue;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: AppRadius.cardInner,
        border: Border.all(
          color: isOverdue
              ? const Color(0xFFFEE2E2)
              : ticket.urgent
                  ? const Color(0xFFFEF2F2)
                  : Theme.of(context).colorScheme.surfaceContainerLow,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: AppRadius.cardInner,
        child: Column(
          children: [
            // ── Header row: ticket # + badges + status dropdown ──
            _buildHeaderRow(context, statusConf),

            // ── Tappable info area ──
            GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: Column(
                children: [
                  _buildCustomerSection(context),
                  _buildItemsChips(context),
                  _buildTimingRow(context),
                  if (ticket.notes != null) _buildNotesSection(context),
                ],
              ),
            ),

            // ── Photo action buttons ──
            if (_showPhotoButtons) _buildPhotoButtons(context),

            // ── Advance button ──
            if (onAdvance != null &&
                DropoffStatusConfig.nextAction
                    .containsKey(ticket.status))
              _buildAdvanceButton(context, statusConf),
          ],
        ),
      ),
    );
  }

  // ── Header Row ──

  Widget _buildHeaderRow(
    BuildContext context,
    DropoffStatusConfig statusConf,
  ) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 6),
      child: Row(
        children: [
          // Ticket number badge
          Container(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '#${ticket.ticketNumber}',
              textDirection: Directionality.of(context),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),

          // Activity log button
          if (activityLog.isNotEmpty) ...[
            const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: onActivityLog,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.history_rounded,
                  size: 11,
                  color: Color(0xFF1A73E8),
                ),
              ),
            ),
          ],

          // Urgent badge
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.bolt_rounded,
                    size: 10,
                    color: Color(0xFFE53935),
                  ),
                  const SizedBox(width: 2),
                  const Text(
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

          // Overdue badge
          if (_isOverdue) ...[
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 10,
                    color: Color(0xFFFF9800),
                  ),
                  const SizedBox(width: 2),
                  const Text(
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

          const Spacer(),

          // Interactive status badge (dropdown)
          GestureDetector(
            onTap: onStatusChange != null
                ? () => _openStatusPicker(context)
                : null,
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: statusConf.bgColor,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: statusConf.borderColor,
                  width: 1.5,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    statusConf.icon,
                    size: 11,
                    color: statusConf.color,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    statusConf.label,
                    style: TextStyle(
                      fontSize: 10,
                      color: statusConf.color,
                    ),
                  ),
                  if (onStatusChange != null) ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 10,
                      color: statusConf.color.withValues(alpha: 0.6),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Customer Section ──

  Widget _buildCustomerSection(BuildContext context) {
    final price = Money(ticket.totalPrice);

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Row(
        children: [
          // Avatar circle
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline_rounded,
              size: 13,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          // Name + phone
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.customerName,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (ticket.customerPhone != null)
                  Text(
                    ticket.customerPhone!,
                    textDirection: Directionality.of(context),
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),

          // Price + paid badge
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    price.toFormattedArabic(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    'د.أ',
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              if (ticket.paid)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.credit_card_rounded,
                      size: 9,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'مدفوع',
                      style: TextStyle(
                        fontSize: 9,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Items Chips ──

  Widget _buildItemsChips(BuildContext context) {
    final totalItems =
        ticket.items.fold(0, (sum, item) => sum + item.quantity);

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Row(
        children: [
          Expanded(
            child: Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                // First 3 items as chips
                ...ticket.items.take(3).map((item) => Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerLowest,
                        borderRadius: AppRadius.pill,
                        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                      ),
                      child: Text(
                        '${item.name} ×${item.quantity}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )),
                // Overflow indicator
                if (ticket.items.length > 3)
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    child: Text(
                      '+${ticket.items.length - 3} أخرى',
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Total count
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 10,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 2),
              Text(
                '$totalItems قطعة',
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Timing Row ──

  Widget _buildTimingRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Row(
        children: [
          Icon(
            Icons.schedule_rounded,
            size: 10,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 4),
          Text(
            'استلام: ${_timeAgo(ticket.droppedOffAt)}',
            style: TextStyle(
              fontSize: 10,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            'الموعد: ${_formatShortDate(ticket.estimatedReadyAt)}',
            style: TextStyle(
              fontSize: 10,
              color: _isOverdue
                  ? const Color(0xFFE53935)
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // ── Notes Section ──

  Widget _buildNotesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 6),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E1),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Text(
          ticket.notes!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFFFF9800),
          ),
        ),
      ),
    );
  }

  // ── Photo Action Buttons ──

  Widget _buildPhotoButtons(BuildContext context) {
    final hasPhotoBefore = ticket.items.any((i) => i.photoBefore != null);
    final hasPhotoAfter = ticket.items.any((i) => i.photoAfter != null);

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 6),
      child: Row(
        children: [
          Expanded(
            child: PhotoToggleButton(
              label: 'صورة قبل',
              icon: Icons.camera_alt_outlined,
              hasPhoto: hasPhotoBefore,
              onTap: onPhotoBefore,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: PhotoToggleButton(
              label: 'صورة بعد',
              icon: Icons.image_outlined,
              hasPhoto: hasPhotoAfter,
              activeColor: const Color(0xFF43A047),
              onTap: onPhotoAfter,
            ),
          ),

          // Info request button (optional, dropoff-specific)
          if (onRequestInfo != null) ...[
            const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: onRequestInfo,
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1).withValues(alpha: 0.5),
                  borderRadius: AppRadius.cardInner,
                  border: Border.all(
                    color: const Color(0xFFFFE082),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.question_answer_outlined,
                      size: 13,
                      color: Color(0xFFFF8F00),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'طلب معلومات',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFFFF8F00),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Advance Button ──

  Widget _buildAdvanceButton(
    BuildContext context,
    DropoffStatusConfig statusConf,
  ) {
    final action = DropoffStatusConfig.nextAction[ticket.status]!;
    final isReady = ticket.status == DropoffStatus.ready;
    final buttonColor =
        isReady ? const Color(0xFF43A047) : const Color(0xFF1A73E8);
    final buttonIcon = isReady
        ? Icons.check_circle_rounded
        : Icons.chevron_left_rounded;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 12),
      child: GestureDetector(
        onTap: onAdvance,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: AppRadius.cardInner,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                buttonIcon,
                size: 14,
                color: Theme.of(context).colorScheme.surface,
              ),
              const SizedBox(width: 6),
              Text(
                action.label,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Status Picker ──

  Future<void> _openStatusPicker(BuildContext context) async {
    final newStatus = await showDropoffStatusPicker(
      context,
      ticket: ticket,
      activityLog: activityLog,
      onViewFullLog: activityLog.isNotEmpty
          ? () => showDropoffActivityLogSheet(
                context,
                ticket: ticket,
                activityLog: activityLog,
              )
          : null,
    );
    if (newStatus != null && onStatusChange != null) {
      onStatusChange!(newStatus);
    }
  }

  // ── Helpers ──

  bool get _isOverdue {
    if (ticket.status == DropoffStatus.delivered ||
        ticket.status == DropoffStatus.cancelled) {
      return false;
    }
    final ready = DateTime.tryParse(ticket.estimatedReadyAt);
    if (ready == null) return false;
    return DateTime.now().isAfter(ready);
  }

  bool get _showPhotoButtons =>
      ticket.status == DropoffStatus.received ||
      ticket.status == DropoffStatus.processing ||
      ticket.status == DropoffStatus.ready;

  String _timeAgo(String timestamp) {
    final dt = DateTime.tryParse(timestamp);
    if (dt == null) return timestamp;
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes} د';
    if (diff.inHours < 24) return '${diff.inHours} س';
    return '${diff.inDays} يوم';
  }

  String _formatShortDate(String timestamp) {
    final dt = DateTime.tryParse(timestamp);
    if (dt == null) return timestamp;
    return DateFormat('yyyy-MM-dd', 'ar').format(dt);
  }
}
