import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_source.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_status.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_ticket.dart';
import 'package:honak/shared/entities/money.dart';

/// Card displaying a single dropoff ticket in the board list.
///
/// Shows ticket number, customer info, items summary, timing, photo buttons,
/// status badge, and an advance-status action button.
class DropoffEntryCard extends StatelessWidget {
  const DropoffEntryCard({
    super.key,
    required this.ticket,
    this.onAdvance,
    this.onTap,
    this.compact = false,
  });

  final DropoffTicket ticket;
  final VoidCallback? onAdvance;
  final VoidCallback? onTap;
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
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Icon(
                  Icons.local_laundry_service_outlined,
                  size: 14,
                  color: Colors.grey.shade400,
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
                          textDirection: TextDirection.ltr,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          ticket.customerName,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxs),
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
              Icon(Icons.check_circle, size: 16, color: AppColors.success),
            ],
          ),
        ),
      ),
    );
  }

  // ── Full card ──

  Widget _buildFullCard(BuildContext context) {
    final isOverdue = _isOverdue;
    final price = Money(ticket.totalPrice);

    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.cardInner,
          border: Border.all(
            color: isOverdue
                ? const Color(0xFFFEE2E2)
                : ticket.urgent
                    ? const Color(0xFFFFF3CD)
                    : Colors.grey.shade100,
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
              // Main content
              Padding(
                padding: const EdgeInsetsDirectional.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row 1: Ticket number + urgent + overdue + status badge
                    Row(
                      children: [
                        // Ticket number badge
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
                        if (ticket.urgent) ...[
                          const SizedBox(width: AppSpacing.xs),
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
                                Icon(
                                  Icons.bolt_rounded,
                                  size: 10,
                                  color: AppColors.secondary,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  'مستعجل',
                                  style:
                                      context.textTheme.labelSmall?.copyWith(
                                    color: AppColors.secondary,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        if (isOverdue) ...[
                          const SizedBox(width: AppSpacing.xs),
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
                                Icon(
                                  Icons.warning_amber_rounded,
                                  size: 10,
                                  color: AppColors.error,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  'متأخر',
                                  style:
                                      context.textTheme.labelSmall?.copyWith(
                                    color: AppColors.error,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const Spacer(),
                        _StatusBadge(status: ticket.status),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Row 2: Customer name + source badge
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            ticket.customerName,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurface,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _SourceBadge(source: ticket.source),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),

                    // Row 3: Items summary + price
                    Row(
                      children: [
                        Icon(
                          Icons.checkroom_rounded,
                          size: 12,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            '${ticket.items.length} قطع'
                            '${ticket.items.isNotEmpty ? ' · ${ticket.items.first.name}' : ''}'
                            '${ticket.items.length > 1 ? ' +${ticket.items.length - 1}' : ''}',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: Colors.grey.shade500,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          price.toFormattedArabic(),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.grey.shade500,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),

                    // Row 4: Timing info
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 10,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          'استلام: ${_formatTime(ticket.droppedOffAt)}',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.grey.shade400,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Text(
                          'جاهز: ${_formatTime(ticket.estimatedReadyAt)}',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: isOverdue
                                ? AppColors.error
                                : Colors.grey.shade400,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),

                    // Row 5: Photo buttons
                    if (_hasAnyPhotos) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          if (_hasPhotoBefore)
                            _PhotoButton(
                              icon: Icons.camera_alt_outlined,
                              label: 'قبل',
                              color: AppColors.secondary,
                            ),
                          if (_hasPhotoBefore && _hasPhotoAfter)
                            const SizedBox(width: AppSpacing.sm),
                          if (_hasPhotoAfter)
                            _PhotoButton(
                              icon: Icons.camera_rounded,
                              label: 'بعد',
                              color: AppColors.success,
                            ),
                        ],
                      ),
                    ],

                    // Paid badge
                    if (ticket.paid) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 10,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            'مدفوع',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: AppColors.success,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Action button
              if (onAdvance != null && ticket.status != DropoffStatus.delivered)
                _buildAdvanceButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdvanceButton(BuildContext context) {
    final (label, color) = switch (ticket.status) {
      DropoffStatus.received => ('بدء المعالجة', AppColors.primary),
      DropoffStatus.processing => ('جاهز للاستلام', AppColors.success),
      DropoffStatus.ready => ('تم التسليم', const Color(0xFF616161)),
      _ => ('', AppColors.primary),
    };

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade50)),
      ),
      child: Material(
        color: color,
        child: InkWell(
          onTap: onAdvance,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Helpers ──

  bool get _isOverdue {
    if (ticket.status == DropoffStatus.delivered ||
        ticket.status == DropoffStatus.cancelled) {
      return false;
    }
    final ready = DateTime.tryParse(ticket.estimatedReadyAt);
    if (ready == null) {
      return false;
    }
    return DateTime.now().isAfter(ready);
  }

  bool get _hasPhotoBefore => ticket.items.any((i) => i.photoBefore != null);
  bool get _hasPhotoAfter => ticket.items.any((i) => i.photoAfter != null);
  bool get _hasAnyPhotos => _hasPhotoBefore || _hasPhotoAfter;

  String _formatTime(String timestamp) {
    final dt = DateTime.tryParse(timestamp);
    if (dt == null) return timestamp;
    return DateFormat('MM/dd h:mm a', 'ar').format(dt);
  }
}

// ═══════════════════════════════════════════════════════════════
// Source Badge
// ═══════════════════════════════════════════════════════════════

class _SourceBadge extends StatelessWidget {
  const _SourceBadge({required this.source});

  final DropoffSource source;

  @override
  Widget build(BuildContext context) {
    final (label, color, bgColor, icon) = switch (source) {
      DropoffSource.walkIn => (
        'حضوري',
        Colors.grey.shade500,
        Colors.grey.shade100,
        Icons.directions_walk_rounded,
      ),
      DropoffSource.appRequest => (
        'تطبيق',
        AppColors.primary,
        const Color(0xFFEFF6FF),
        Icons.smartphone_rounded,
      ),
      DropoffSource.phone => (
        'هاتف',
        const Color(0xFF7B1FA2),
        const Color(0xFFFAF5FF),
        Icons.phone_in_talk_rounded,
      ),
    };

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 9, color: color),
          const SizedBox(width: 2),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: color,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Status Badge
// ═══════════════════════════════════════════════════════════════

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final DropoffStatus status;

  @override
  Widget build(BuildContext context) {
    final (color, bgColor) = switch (status) {
      DropoffStatus.received => (
        AppColors.secondary,
        const Color(0xFFFFF8E1),
      ),
      DropoffStatus.processing => (
        AppColors.primary,
        const Color(0xFFEFF6FF),
      ),
      DropoffStatus.ready => (
        AppColors.success,
        const Color(0xFFF0FDF4),
      ),
      DropoffStatus.delivered => (
        Colors.grey.shade500,
        Colors.grey.shade100,
      ),
      DropoffStatus.cancelled => (
        AppColors.error,
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

// ═══════════════════════════════════════════════════════════════
// Photo Button
// ═══════════════════════════════════════════════════════════════

class _PhotoButton extends StatelessWidget {
  const _PhotoButton({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: color,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
