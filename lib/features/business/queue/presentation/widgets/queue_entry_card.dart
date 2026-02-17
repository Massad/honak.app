import 'dart:async';

import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/queue/domain/entities/queue_entry.dart';
import 'package:honak/features/business/queue/domain/entities/queue_source.dart';
import 'package:honak/features/business/queue/domain/entities/queue_status.dart';
import 'package:honak/features/business/queue/presentation/widgets/queue_activity_log.dart';
import 'package:honak/features/business/queue/presentation/widgets/queue_activity_utils.dart';
import 'package:honak/features/business/queue/presentation/widgets/queue_status_config.dart';
import 'package:honak/features/business/shared/widgets/generic_status_picker_sheet.dart';
import 'package:honak/features/business/shared/widgets/photo_toggle_button.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:intl/intl.dart' hide TextDirection;

part 'queue_entry_card_widgets.dart';

// ═══════════════════════════════════════════════════════════════════════════
// QueueEntryCard — matches Figma QueueEntryCard.tsx
// ═══════════════════════════════════════════════════════════════════════════

class QueueEntryCard extends StatefulWidget {
  const QueueEntryCard({
    super.key,
    required this.entry,
    this.onAdvance,
    this.onNoShow,
    this.onRemove,
    this.onOpenDetail,
    this.onOpenChat,
    this.onChangeStatus,
    this.activityLog,
    this.advanceLabel,
    this.advanceIcon,
    this.advanceColor,
    this.showTimer = false,
    this.compact = false,
  });

  final QueueEntry entry;
  final VoidCallback? onAdvance;
  final VoidCallback? onNoShow;
  final VoidCallback? onRemove;
  final VoidCallback? onOpenDetail;
  final VoidCallback? onOpenChat;
  final ValueChanged<QueueStatus>? onChangeStatus;
  final List<QueueActivityEntry>? activityLog;
  final String? advanceLabel;
  final IconData? advanceIcon;
  final Color? advanceColor;
  final bool showTimer;
  final bool compact;

  @override
  State<QueueEntryCard> createState() => _QueueEntryCardState();
}

class _QueueEntryCardState extends State<QueueEntryCard> {
  bool _expanded = false;

  static const _blue = Color(0xFF1A73E8);
  static const _blue50 = Color(0xFFEFF6FF);
  static const _amber = Color(0xFFFF9800);
  static const _green = Color(0xFF43A047);

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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: context.colorScheme.outlineVariant),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 1)),
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
                  color: context.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Icon(Icons.directions_car_rounded,
                    size: 14, color: context.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(entry.customerName,
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: context.colorScheme.onSurface)),
                        const SizedBox(width: AppSpacing.sm),
                        _SourceBadge(source: entry.source),
                        if (entry.status == QueueStatus.noShow) ...[
                          const SizedBox(width: AppSpacing.xs),
                          Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF2F2),
                              borderRadius: AppRadius.pill,
                            ),
                            child: Text(context.l10n.queueNoShowLabel,
                                style: context.textTheme.labelSmall?.copyWith(
                                    color: const Color(0xFFE53935),
                                    fontSize: 10)),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                        '${entry.packageName} · ${price.toFormattedArabic()}',
                        style: context.textTheme.labelSmall
                            ?.copyWith(color: context.colorScheme.onSurfaceVariant, fontSize: 10)),
                  ],
                ),
              ),
              if (entry.status == QueueStatus.completed)
                const Icon(Icons.check_circle, size: 16, color: _green),
              if (widget.onChangeStatus != null) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _showStatusPickerSheet(context),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Icon(Icons.swap_horiz_rounded,
                        size: 11, color: context.colorScheme.onSurfaceVariant),
                  ),
                ),
              ],
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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: context.colorScheme.outlineVariant),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: ClipRRect(
        borderRadius: AppRadius.cardInner,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Header zone — activity log + chat + spacer + timer
            _buildHeaderZone(context, entry),

            // 2. Info zone (tappable → detail view)
            GestureDetector(
              onTap: widget.onOpenDetail,
              behavior: HitTestBehavior.opaque,
              child: _buildInfoZone(context, entry),
            ),

            // 3. Photo buttons (waiting / in_progress / ready)
            if (_shouldShowPhotos(entry.status))
              _buildPhotoButtons(context, entry),

            // 4. Expanded details
            if (_expanded) _buildExpandedDetails(context, entry),

            // 5. Action buttons
            if (widget.onAdvance != null) _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  bool _shouldShowPhotos(QueueStatus status) =>
      status == QueueStatus.waiting ||
      status == QueueStatus.inProgress ||
      status == QueueStatus.ready;

  // ── Header zone: activity log + chat + spacer + timer ──

  Widget _buildHeaderZone(BuildContext context, QueueEntry entry) {
    final hasActivity =
        widget.activityLog != null && widget.activityLog!.isNotEmpty;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 12, 0),
      child: Row(
        children: [
          if (hasActivity)
            GestureDetector(
              onTap: () => showQueueActivityLogSheet(
                context,
                entry: entry,
                activityLog: widget.activityLog!,
              ),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _blue50,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Icon(Icons.receipt_long_rounded,
                    size: 13, color: _blue),
              ),
            ),
          if (widget.onOpenChat != null) ...[
            if (hasActivity) const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: widget.onOpenChat,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(Icons.chat_bubble_outline_rounded,
                    size: 13, color: context.colorScheme.onSurfaceVariant),
              ),
            ),
          ],
          const Spacer(),
          if (widget.showTimer && entry.startedAt != null)
            _LiveTimer(
                startedAt: entry.startedAt!,
                durationMin: entry.estimatedDurationMin)
          else
            Text(context.l10n.queueEstimatedWaitMin(entry.estimatedDurationMin),
                style: context.textTheme.labelSmall
                    ?.copyWith(color: context.colorScheme.onSurfaceVariant, fontSize: 10)),
        ],
      ),
    );
  }

  // ── Info zone (tappable → detail view) ──

  Widget _buildInfoZone(BuildContext context, QueueEntry entry) {
    final price = Money(entry.totalPrice);

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vehicle icon + subscriber crown
              _buildVehicleIcon(entry),
              const SizedBox(width: AppSpacing.md),

              // Info column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + badges
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: AppSpacing.sm,
                      runSpacing: 2,
                      children: [
                        Text(entry.customerName,
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: context.colorScheme.onSurface, fontSize: 14)),
                        _SourceBadge(source: entry.source),
                        if (entry.status == QueueStatus.onTheWay)
                          _OnTheWayBadge(),
                      ],
                    ),
                    const SizedBox(height: 2),

                    // Vehicle details
                    if (_hasVehicleInfo(entry))
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.only(bottom: 4),
                        child: _buildVehicleDetails(context, entry),
                      ),

                    // Package + price + discount + add-ons
                    _buildPackageRow(context, entry, price),

                    // Subscription
                    if (entry.subscriptionPlan != null)
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.only(top: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.workspace_premium_rounded,
                                size: 10, color: _amber),
                            const SizedBox(width: AppSpacing.xs),
                            Text(entry.subscriptionPlan!,
                                style: context.textTheme.labelSmall
                                    ?.copyWith(
                                        color: _amber, fontSize: 10)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Status badge + expand chevron
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (widget.onChangeStatus != null)
                    _StatusBadge(
                      status: entry.status,
                      onTap: () => _showStatusPickerSheet(context),
                    ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () => setState(() => _expanded = !_expanded),
                    child: Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 14,
                      color: context.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Notes preview (not expanded)
          if (entry.notes != null && !_expanded)
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 8),
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Row(
                  children: [
                    Icon(Icons.sticky_note_2_outlined,
                        size: 10, color: context.colorScheme.onSurfaceVariant),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(entry.notes!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.labelSmall
                              ?.copyWith(color: context.colorScheme.onSurfaceVariant, fontSize: 10)),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPackageRow(
      BuildContext context, QueueEntry entry, Money price) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: AppSpacing.sm,
      runSpacing: 2,
      children: [
        Container(
          padding:
              const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLow, borderRadius: AppRadius.pill),
          child: Text(entry.packageName,
              style: context.textTheme.labelSmall
                  ?.copyWith(color: context.colorScheme.onSurfaceVariant, fontSize: 10)),
        ),
        if (entry.discount != null && entry.priceBeforeDiscount != null) ...[
          Text(Money(entry.priceBeforeDiscount!).toFormattedArabic(),
              style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.outline,
                  fontSize: 10,
                  decoration: TextDecoration.lineThrough)),
          Text(price.toFormattedArabic(),
              style: context.textTheme.labelSmall
                  ?.copyWith(color: _green, fontSize: 10)),
          Container(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7ED),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              entry.discount!.type == 'percentage'
                  ? context.l10n.queueDiscountPercent((entry.discount!.value / 100).round())
                  : '${context.l10n.queueDiscountLabel} ${Money(entry.discount!.amount).toFormattedArabic()}',
              style: context.textTheme.labelSmall
                  ?.copyWith(color: _amber, fontSize: 9),
            ),
          ),
        ] else
          Text(price.toFormattedArabic(),
              style: context.textTheme.labelSmall
                  ?.copyWith(color: context.colorScheme.onSurfaceVariant, fontSize: 10)),
        if (entry.addOns.isNotEmpty)
          Text(context.l10n.queueAddOnCount(entry.addOns.length),
              style: context.textTheme.labelSmall
                  ?.copyWith(color: _blue, fontSize: 10)),
      ],
    );
  }

  // ── Photo buttons ──

  Widget _buildPhotoButtons(BuildContext context, QueueEntry entry) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 8),
      child: Row(
        children: [
          Expanded(
            child: PhotoToggleButton(
              label: context.l10n.queuePhotoBefore,
              icon: Icons.camera_alt_outlined,
              hasPhoto: entry.photosBefore.isNotEmpty,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: PhotoToggleButton(
              label: context.l10n.queuePhotoAfter,
              icon: Icons.image_outlined,
              hasPhoto: entry.photosAfter.isNotEmpty,
            ),
          ),
        ],
      ),
    );
  }

  // ── Expanded details ──

  Widget _buildExpandedDetails(BuildContext context, QueueEntry entry) {
    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 12),
      padding: const EdgeInsetsDirectional.only(top: 8),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: context.colorScheme.surfaceContainerLowest)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (entry.customerPhone != null) ...[
            Row(
              children: [
                Icon(Icons.phone_outlined, size: 12, color: context.colorScheme.onSurfaceVariant),
                const SizedBox(width: AppSpacing.sm),
                Text(entry.customerPhone!,
                    textDirection: TextDirection.ltr,
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: context.colorScheme.onSurfaceVariant)),
                const Spacer(),
                Text(context.l10n.queueCall,
                    style: context.textTheme.labelSmall
                        ?.copyWith(color: _blue, fontSize: 10)),
              ],
            ),
            const SizedBox(height: 8),
          ],
          if (entry.notes != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsetsDirectional.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.sticky_note_2_outlined,
                          size: 10, color: _amber),
                      const SizedBox(width: AppSpacing.xs),
                      Text(context.l10n.queueExpandedNotes,
                          style: context.textTheme.labelSmall
                              ?.copyWith(color: _amber, fontSize: 10)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(entry.notes!,
                      style: context.textTheme.bodySmall
                          ?.copyWith(color: context.colorScheme.onSurface)),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
          if (entry.addOns.isNotEmpty) ...[
            Text(context.l10n.queueExpandedAddOns,
                style: context.textTheme.labelSmall
                    ?.copyWith(color: context.colorScheme.onSurfaceVariant, fontSize: 10)),
            const SizedBox(height: AppSpacing.xs),
            for (final addon in entry.addOns)
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(addon.name,
                        style: context.textTheme.labelSmall
                            ?.copyWith(fontSize: 10)),
                    Text('+${Money(addon.price).toFormattedArabic()}',
                        style: context.textTheme.labelSmall
                            ?.copyWith(color: context.colorScheme.onSurfaceVariant, fontSize: 10)),
                  ],
                ),
              ),
            const SizedBox(height: 8),
          ],
          Text(
              context.l10n.queueCheckinTime(_formatCheckinTime(entry.checkedInAt)),
              style: context.textTheme.labelSmall
                  ?.copyWith(color: context.colorScheme.onSurfaceVariant, fontSize: 10)),
        ],
      ),
    );
  }

  // ── Action buttons ──

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: context.colorScheme.surfaceContainerLowest)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: widget.advanceColor ?? _blue,
              child: InkWell(
                onTap: widget.onAdvance,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.advanceIcon != null) ...[
                        Icon(widget.advanceIcon,
                            size: 14, color: Theme.of(context).colorScheme.surface),
                        const SizedBox(width: 6),
                      ],
                      Text(widget.advanceLabel ?? '',
                          style: context.textTheme.bodySmall
                              ?.copyWith(color: Theme.of(context).colorScheme.surface, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (widget.onNoShow != null)
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerLowest,
                border:
                    BorderDirectional(start: BorderSide(color: context.colorScheme.surfaceContainerLow)),
              ),
              child: InkWell(
                onTap: widget.onNoShow,
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Icon(Icons.block_rounded,
                          size: 12, color: context.colorScheme.onSurfaceVariant),
                      const SizedBox(width: AppSpacing.xs),
                      Text(context.l10n.queueNoShowLabel,
                          style: context.textTheme.labelSmall
                              ?.copyWith(color: context.colorScheme.onSurfaceVariant, fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ),
          if (widget.onRemove != null && widget.onNoShow == null)
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerLowest,
                border:
                    BorderDirectional(start: BorderSide(color: context.colorScheme.surfaceContainerLow)),
              ),
              child: InkWell(
                onTap: widget.onRemove,
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 16, vertical: 10),
                  child: Icon(Icons.close_rounded,
                      size: 12, color: context.colorScheme.onSurfaceVariant),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── Helpers ──

  Widget _buildVehicleIcon(QueueEntry entry) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Icon(Icons.directions_car_rounded,
              size: 18, color: context.colorScheme.onSurfaceVariant),
        ),
        if (entry.isSubscriber)
          PositionedDirectional(
            top: -4,
            end: -4,
            child: DecoratedBox(
              decoration:
                  BoxDecoration(color: _amber, shape: BoxShape.circle),
              child: SizedBox(
                width: 16,
                height: 16,
                child: Icon(Icons.workspace_premium_rounded,
                    size: 9, color: Theme.of(context).colorScheme.surface),
              ),
            ),
          ),
      ],
    );
  }

  bool _hasVehicleInfo(QueueEntry entry) =>
      entry.vehicleType != null ||
      entry.vehicleColor != null ||
      entry.plateNumber != null;

  Widget _buildVehicleDetails(BuildContext context, QueueEntry entry) {
    final parts = <String>[
      if (entry.vehicleType != null) entry.vehicleType!,
      if (entry.vehicleColor != null) entry.vehicleColor!,
    ];
    return Row(
      children: [
        if (parts.isNotEmpty)
          Text(parts.join(' · '),
              style: context.textTheme.labelSmall
                  ?.copyWith(color: context.colorScheme.onSurfaceVariant, fontSize: 10)),
        if (entry.plateNumber != null) ...[
          if (parts.isNotEmpty)
            Text(' · ',
                style: context.textTheme.labelSmall
                    ?.copyWith(color: context.colorScheme.onSurfaceVariant, fontSize: 10)),
          Text(entry.plateNumber!,
              textDirection: TextDirection.ltr,
              style: context.textTheme.labelSmall
                  ?.copyWith(color: context.colorScheme.onSurfaceVariant, fontSize: 10)),
        ],
      ],
    );
  }

  String _formatCheckinTime(int epochSeconds) {
    final dt = DateTime.fromMillisecondsSinceEpoch(epochSeconds * 1000);
    return DateFormat.jm('ar').format(dt);
  }

  void _showStatusPickerSheet(BuildContext context) async {
    final newStatus = await _showQueueStatusPicker(
      context,
      currentStatus: widget.entry.status,
      customerName: widget.entry.customerName,
      packageName: widget.entry.packageName,
    );
    if (newStatus != null) {
      widget.onChangeStatus?.call(newStatus);
    }
  }
}
