import 'dart:async';

import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/queue/domain/entities/queue_entry.dart';
import 'package:honak/features/business/queue/domain/entities/queue_source.dart';
import 'package:honak/features/business/queue/domain/entities/queue_status.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:intl/intl.dart' hide TextDirection;

part 'queue_entry_card_widgets.dart';

/// Individual card for each queue entry.
///
/// Shows customer info, vehicle details, package, timer, and action buttons.
/// Supports compact mode for completed entries.
class QueueEntryCard extends StatefulWidget {
  const QueueEntryCard({
    super.key,
    required this.entry,
    this.onAdvance,
    this.onNoShow,
    this.onRemove,
    this.advanceLabel,
    this.advanceColor,
    this.showTimer = false,
    this.compact = false,
  });

  final QueueEntry entry;
  final VoidCallback? onAdvance;
  final VoidCallback? onNoShow;
  final VoidCallback? onRemove;
  final String? advanceLabel;
  final Color? advanceColor;
  final bool showTimer;
  final bool compact;

  @override
  State<QueueEntryCard> createState() => _QueueEntryCardState();
}

class _QueueEntryCardState extends State<QueueEntryCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.compact) return _buildCompactCard(context);
    return _buildFullCard(context);
  }

  // ── Compact card for completed entries ──

  Widget _buildCompactCard(BuildContext context) {
    final entry = widget.entry;
    final price = Money(entry.totalPrice);

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
              // Vehicle icon
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Icon(
                  Icons.directions_car_rounded,
                  size: 14,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          entry.customerName,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _SourceBadge(source: entry.source),
                        if (entry.status == QueueStatus.noShow) ...[
                          const SizedBox(width: AppSpacing.xs),
                          Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF2F2), // red-50
                              borderRadius: AppRadius.pill,
                            ),
                            child: Text(
                              'لم يحضر',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: AppColors.error,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      '${entry.packageName} · ${price.toFormattedArabic()}',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade400,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),

              // Completed icon
              if (entry.status == QueueStatus.completed)
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: AppColors.success,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Full card ──

  Widget _buildFullCard(BuildContext context) {
    final entry = widget.entry;

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
      child: ClipRRect(
        borderRadius: AppRadius.cardInner,
        child: Column(
          children: [
            // Main content
            _buildMainRow(context, entry),

            // Notes preview (only when not expanded)
            if (entry.notes != null && !_expanded)
              _buildNotesPreview(context, entry.notes!),

            // Expanded details
            if (_expanded) _buildExpandedDetails(context, entry),

            // Action buttons
            if (widget.onAdvance != null) _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMainRow(BuildContext context, QueueEntry entry) {
    final price = Money(entry.totalPrice);

    return Padding(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vehicle icon + subscriber badge
          _buildVehicleIcon(entry),
          const SizedBox(width: AppSpacing.md),

          // Info column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + source + on_the_way badge
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        entry.customerName,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _SourceBadge(source: entry.source),
                    if (entry.status == QueueStatus.onTheWay) ...[
                      const SizedBox(width: AppSpacing.xs),
                      _OnTheWayBadge(),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.xxs),

                // Vehicle details
                if (_hasVehicleInfo(entry))
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: AppSpacing.xs,
                    ),
                    child: _buildVehicleDetails(context, entry),
                  ),

                // Package + price + add-ons
                Row(
                  children: [
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
                        entry.packageName,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      price.toFormattedArabic(),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade500,
                        fontSize: 10,
                      ),
                    ),
                    if (entry.addOns.isNotEmpty) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        '+${entry.addOns.length} إضافة',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.primary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ],
                ),

                // Subscription badge
                if (entry.subscriptionPlan != null)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: AppSpacing.xs,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.workspace_premium_rounded,
                          size: 10,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          entry.subscriptionPlan!,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: AppColors.secondary,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Timer / expand toggle
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (widget.showTimer && entry.startedAt != null)
                _LiveTimer(
                  startedAt: entry.startedAt!,
                  durationMin: entry.estimatedDurationMin,
                )
              else
                Text(
                  '~${entry.estimatedDurationMin} د',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: Colors.grey.shade400,
                    fontSize: 10,
                  ),
                ),
              const SizedBox(height: AppSpacing.xs),
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 14,
                  color: Colors.grey.shade300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleIcon(QueueEntry entry) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Icon(
            Icons.directions_car_rounded,
            size: 18,
            color: Colors.grey.shade600,
          ),
        ),
        if (entry.isSubscriber)
          PositionedDirectional(
            top: -4,
            end: -4,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.workspace_premium_rounded,
                size: 9,
                color: AppColors.white,
              ),
            ),
          ),
      ],
    );
  }

  bool _hasVehicleInfo(QueueEntry entry) {
    return entry.vehicleType != null ||
        entry.vehicleColor != null ||
        entry.plateNumber != null;
  }

  Widget _buildVehicleDetails(BuildContext context, QueueEntry entry) {
    final parts = <String>[
      if (entry.vehicleType != null) entry.vehicleType!,
      if (entry.vehicleColor != null) entry.vehicleColor!,
    ];
    return Row(
      children: [
        if (parts.isNotEmpty)
          Text(
            parts.join(' · '),
            style: context.textTheme.labelSmall?.copyWith(
              color: Colors.grey.shade500,
              fontSize: 10,
            ),
          ),
        if (entry.plateNumber != null) ...[
          if (parts.isNotEmpty)
            Text(
              ' · ',
              style: context.textTheme.labelSmall?.copyWith(
                color: Colors.grey.shade500,
                fontSize: 10,
              ),
            ),
          Text(
            entry.plateNumber!,
            textDirection: TextDirection.ltr,
            style: context.textTheme.labelSmall?.copyWith(
              color: Colors.grey.shade600,
              fontSize: 10,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNotesPreview(BuildContext context, String notes) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(
          children: [
            Icon(Icons.sticky_note_2_outlined, size: 10, color: Colors.grey.shade400),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                notes,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelSmall?.copyWith(
                  color: Colors.grey.shade400,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedDetails(BuildContext context, QueueEntry entry) {
    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      padding: const EdgeInsetsDirectional.only(top: AppSpacing.sm),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phone
          if (entry.customerPhone != null) ...[
            Row(
              children: [
                Icon(Icons.phone_outlined, size: 12, color: Colors.grey.shade400),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  entry.customerPhone!,
                  textDirection: TextDirection.ltr,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                const Spacer(),
                Text(
                  'اتصال',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.primary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
          ],

          // Full notes
          if (entry.notes != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsetsDirectional.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1), // amber-50
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.sticky_note_2_outlined,
                        size: 10,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        'ملاحظات',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.secondary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    entry.notes!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],

          // Add-ons
          if (entry.addOns.isNotEmpty) ...[
            Text(
              'إضافات:',
              style: context.textTheme.labelSmall?.copyWith(
                color: Colors.grey.shade400,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            for (final addon in entry.addOns)
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: AppSpacing.xxs,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      addon.name,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '+${Money(addon.price).toFormattedArabic()}',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade500,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: AppSpacing.sm),
          ],

          // Check-in time
          Text(
            'وقت الوصول: ${_formatCheckinTime(entry.checkedInAt)}',
            style: context.textTheme.labelSmall?.copyWith(
              color: Colors.grey.shade400,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade50)),
      ),
      child: Row(
        children: [
          // Primary action
          Expanded(
            child: Material(
              color: widget.advanceColor ?? AppColors.primary,
              child: InkWell(
                onTap: widget.onAdvance,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.advanceLabel ?? '',
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
          ),

          // No-show button (for waiting entries)
          if (widget.onNoShow != null)
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: BorderDirectional(
                  start: BorderSide(color: Colors.grey.shade100),
                ),
              ),
              child: InkWell(
                onTap: widget.onNoShow,
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.block_rounded, size: 12, color: Colors.grey.shade400),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        'لم يحضر',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: Colors.grey.shade400,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Remove button (for non-waiting entries without no-show)
          if (widget.onRemove != null && widget.onNoShow == null)
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: BorderDirectional(
                  start: BorderSide(color: Colors.grey.shade100),
                ),
              ),
              child: InkWell(
                onTap: widget.onRemove,
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: 10,
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 12,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatCheckinTime(int epochSeconds) {
    final dt = DateTime.fromMillisecondsSinceEpoch(epochSeconds * 1000);
    return DateFormat.jm('ar').format(dt);
  }
}

