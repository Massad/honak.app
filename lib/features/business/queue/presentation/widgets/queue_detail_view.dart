import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/queue/domain/entities/queue_entry.dart';
import 'package:honak/features/business/queue/domain/entities/queue_source.dart';
import 'package:honak/features/business/queue/domain/entities/queue_status.dart';
import 'package:honak/features/business/queue/presentation/widgets/queue_activity_log.dart';
import 'package:honak/features/business/queue/presentation/widgets/queue_activity_utils.dart';
import 'package:honak/shared/entities/money.dart';

// ═══════════════════════════════════════════════════════════════
// Queue Detail View — full-screen overlay for a queue entry
// ═══════════════════════════════════════════════════════════════

class QueueDetailView extends StatefulWidget {
  final QueueEntry entry;
  final ValueChanged<QueueStatus>? onChangeStatus;

  const QueueDetailView({
    super.key,
    required this.entry,
    this.onChangeStatus,
  });

  @override
  State<QueueDetailView> createState() => _QueueDetailViewState();
}

class _QueueDetailViewState extends State<QueueDetailView> {
  late final List<QueueActivityEntry> _activityLog;

  @override
  void initState() {
    super.initState();
    _activityLog = generateQueueActivity(widget.entry);
  }

  QueueEntry get entry => widget.entry;

  bool get _isTerminal =>
      entry.status == QueueStatus.completed ||
      entry.status == QueueStatus.noShow;

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 100,
                  ),
                  children: [
                    _buildStatusProgress(context),
                    _buildCustomerCard(context),
                    if (_hasVehicleInfo) _buildVehicleCard(context),
                    _buildServiceCard(context),
                    _buildPhotosCard(context),
                    if (entry.notes != null) _buildNotesCard(context),
                    _buildTimingCard(context),
                    _buildActivityPreview(context),
                  ],
                ),
              ),
              _buildBottomBar(context),
            ],
          ),
        );
      },
    );
  }

  bool get _hasVehicleInfo =>
      entry.vehicleType != null || entry.plateNumber != null;

  // ═══════════════════════════════════════════════════════════
  // Header
  // ═══════════════════════════════════════════════════════════

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
        border: Border(
          bottom: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
        ),
      ),
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Row(
            children: [
              // Back button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 22,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // Customer name + badges
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            entry.customerName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF111827),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _SourceBadge(source: entry.source),
                        if (entry.isSubscriber) ...[
                          const SizedBox(width: 4),
                          _Badge(
                            icon: Icons.workspace_premium_rounded,
                            label: 'مشترك',
                            color: const Color(0xFFFF9800),
                            bgColor: const Color(0xFFFFF8E1),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'وصول: ${_formatTime(entry.checkedInAt)} · ${entry.packageName}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              // Activity log button
              GestureDetector(
                onTap: () => showQueueActivityLogSheet(
                  context,
                  entry: entry,
                  activityLog: _activityLog,
                ),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: const Icon(
                    Icons.receipt_long_rounded,
                    size: 16,
                    color: Color(0xFF1A73E8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // Status Progress Bar
  // ═══════════════════════════════════════════════════════════

  Widget _buildStatusProgress(BuildContext context) {
    const statusFlow = [
      QueueStatus.waiting,
      QueueStatus.inProgress,
      QueueStatus.ready,
      QueueStatus.completed,
    ];
    final currentIdx = statusFlow.indexOf(entry.status);
    final statusConf = _StatusConfig.of(entry.status);

    return _SectionCard(
      child: Column(
        children: [
          // Progress circles + connecting lines
          Row(
            children: [
              for (var i = 0; i < statusFlow.length; i++) ...[
                _ProgressCircle(
                  status: statusFlow[i],
                  isActive: i <= currentIdx && currentIdx >= 0,
                  isCurrent: statusFlow[i] == entry.status,
                ),
                if (i < statusFlow.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsetsDirectional.symmetric(
                        horizontal: 4,
                      ),
                      decoration: BoxDecoration(
                        color: i < currentIdx
                            ? const Color(0xFF43A047)
                            : Theme.of(context).colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Current status badge
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: statusConf.bgColor,
              borderRadius: AppRadius.cardInner,
              border: Border.all(color: statusConf.borderColor),
            ),
            child: Row(
              children: [
                Icon(statusConf.icon, size: 14, color: statusConf.color),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  statusConf.label,
                  style: TextStyle(
                    fontSize: 12,
                    color: statusConf.color,
                  ),
                ),
                if (entry.status == QueueStatus.inProgress &&
                    entry.startedAt != null) ...[
                  const Spacer(),
                  Text(
                    '${_elapsedMinutes(entry.startedAt!)} د مضت · من أصل ~${entry.estimatedDurationMin} د',
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // No-show badge
          if (entry.status == QueueStatus.noShow)
            Container(
              width: double.infinity,
              margin: const EdgeInsetsDirectional.only(top: AppSpacing.sm),
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: AppRadius.cardInner,
                border: Border.all(color: const Color(0xFFE53935)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.block_rounded, size: 14, color: Color(0xFFE53935)),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    'لم يحضر',
                    style: TextStyle(fontSize: 12, color: Color(0xFFE53935)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // Customer Info Card
  // ═══════════════════════════════════════════════════════════

  Widget _buildCustomerCard(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'العميل',
            style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_rounded,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // Name + phone + subscription
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.customerName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF111827),
                      ),
                    ),
                    if (entry.customerPhone != null) ...[
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_rounded,
                            size: 10,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              entry.customerPhone!,
                              style: TextStyle(
                                fontSize: 11,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            'اتصال',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF1A73E8),
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (entry.subscriptionPlan != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.workspace_premium_rounded,
                            size: 10,
                            color: Color(0xFFFF9800),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            entry.subscriptionPlan!,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFFFF9800),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              // Chat button
              GestureDetector(
                onTap: () {}, // TODO: open chat
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A73E8),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.chat_rounded, size: 13, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        'محادثة',
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // Vehicle Card
  // ═══════════════════════════════════════════════════════════

  Widget _buildVehicleCard(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'السيارة',
            style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Icon(
                  Icons.directions_car_rounded,
                  size: 22,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (entry.vehicleType != null)
                        Text(
                          entry.vehicleType!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF111827),
                          ),
                        ),
                      if (entry.vehicleColor != null) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          '· ${entry.vehicleColor!}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (entry.plateNumber != null) ...[
                    const SizedBox(height: 2),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        entry.plateNumber!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // Service Details Card
  // ═══════════════════════════════════════════════════════════

  Widget _buildServiceCard(BuildContext context) {
    final hasDiscount =
        entry.discount != null && entry.priceBeforeDiscount != null;

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الخدمة',
            style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Package name + price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                entry.packageName,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF111827),
                ),
              ),
              Text(
                Money(entry.packagePrice).toFormattedArabic(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1A73E8),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Duration
          Row(
            children: [
              Icon(Icons.access_time_rounded, size: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(
                'مدة متوقعة: ~${entry.estimatedDurationMin} دقيقة',
                style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),

          // Add-ons
          if (entry.addOns.isNotEmpty) ...[
            Divider(height: AppSpacing.lg, color: Theme.of(context).colorScheme.surfaceContainerLowest),
            Text(
              'إضافات',
              style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.xs),
            ...entry.addOns.map(
              (addon) => Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      addon.name,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      '+${Money(addon.price).toFormattedArabic()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Total + discount
          Divider(height: AppSpacing.lg, color: Theme.of(context).colorScheme.outlineVariant),
          if (hasDiscount) ...[
            // Before discount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'المجموع قبل الخصم',
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                Text(
                  Money(entry.priceBeforeDiscount!).toFormattedArabic(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Discount row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'خصم ${entry.discount!.type == "percentage" ? "${(entry.discount!.value / 100).round()}%" : ""}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFFF9800),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        entry.discount!.reason,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color(0xFFFF9800),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  '-${Money(entry.discount!.amount).toFormattedArabic()}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFFF9800),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الإجمالي',
                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              Text(
                Money(entry.totalPrice).toFormattedArabic(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: hasDiscount
                      ? const Color(0xFF43A047)
                      : const Color(0xFF111827),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // Photos Card
  // ═══════════════════════════════════════════════════════════

  Widget _buildPhotosCard(BuildContext context) {
    final hasBefore = entry.photosBefore.isNotEmpty;
    final hasAfter = entry.photosAfter.isNotEmpty;

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'صور التوثيق',
            style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _PhotoButton(
                  icon: Icons.camera_alt_rounded,
                  label: 'صورة قبل',
                  captured: hasBefore,
                  activeColor: const Color(0xFF1A73E8),
                  activeBg: const Color(0xFFEFF6FF),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _PhotoButton(
                  icon: Icons.image_rounded,
                  label: 'صورة بعد',
                  captured: hasAfter,
                  activeColor: const Color(0xFF43A047),
                  activeBg: const Color(0xFFF0FDF4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // Notes Card
  // ═══════════════════════════════════════════════════════════

  Widget _buildNotesCard(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.sticky_note_2_outlined,
                size: 12,
                color: Color(0xFFFF9800),
              ),
              const SizedBox(width: 6),
              const Text(
                'ملاحظات',
                style: TextStyle(fontSize: 10, color: Color(0xFFFF9800)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Text(
              entry.notes!,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // Timing Card
  // ═══════════════════════════════════════════════════════════

  Widget _buildTimingCard(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'التوقيتات',
            style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.sm),
          _TimingRow(label: 'الوصول', epoch: entry.checkedInAt),
          if (entry.startedAt != null)
            _TimingRow(label: 'بدء الخدمة', epoch: entry.startedAt!),
          if (entry.completedAt != null &&
              entry.status == QueueStatus.completed)
            _TimingRow(label: 'اكتمال', epoch: entry.completedAt!),
          if (entry.completedAt != null && entry.status == QueueStatus.ready)
            _TimingRow(label: 'جاهز', epoch: entry.completedAt!),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // Activity Log Preview
  // ═══════════════════════════════════════════════════════════

  Widget _buildActivityPreview(BuildContext context) {
    return _SectionCard(
      child: QueueActivityPreview(
        entries: _activityLog,
        maxEntries: 4,
        onViewFull: () => showQueueActivityLogSheet(
          context,
          entry: entry,
          activityLog: _activityLog,
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // Bottom Action Bar
  // ═══════════════════════════════════════════════════════════

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Chat button
            Expanded(
              child: GestureDetector(
                onTap: () {}, // TODO: open chat
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_rounded,
                        size: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'محادثة',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (!_isTerminal) ...[
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _AdvanceButton(
                  status: entry.status,
                  onTap: () => _advanceStatus(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _advanceStatus() {
    final next = switch (entry.status) {
      QueueStatus.waiting || QueueStatus.onTheWay => QueueStatus.inProgress,
      QueueStatus.inProgress => QueueStatus.ready,
      QueueStatus.ready => QueueStatus.completed,
      _ => null,
    };
    if (next != null) {
      widget.onChangeStatus?.call(next);
    }
  }

  // ═══════════════════════════════════════════════════════════
  // Helpers
  // ═══════════════════════════════════════════════════════════

  String _formatTime(int epochSeconds) {
    final dt = DateTime.fromMillisecondsSinceEpoch(epochSeconds * 1000);
    return DateFormat.jm('ar').format(dt);
  }

  int _elapsedMinutes(int epochSeconds) {
    final started = DateTime.fromMillisecondsSinceEpoch(epochSeconds * 1000);
    return DateTime.now().difference(started).inMinutes;
  }
}

// ═══════════════════════════════════════════════════════════════
// Section Card wrapper
// ═══════════════════════════════════════════════════════════════

class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Source Badge
// ═══════════════════════════════════════════════════════════════

class _SourceBadge extends StatelessWidget {
  final QueueSource source;
  const _SourceBadge({required this.source});

  @override
  Widget build(BuildContext context) {
    final (icon, label, color, bgColor) = switch (source) {
      QueueSource.appReserve => (
          Icons.smartphone_rounded,
          'حجز',
          const Color(0xFF1A73E8),
          const Color(0xFFEFF6FF),
        ),
      QueueSource.phone => (
          Icons.phone_in_talk_rounded,
          'هاتف',
          const Color(0xFF7B1FA2),
          const Color(0xFFF3E5F5),
        ),
      QueueSource.walkIn => (
          Icons.directions_walk_rounded,
          'حضوري',
          Theme.of(context).colorScheme.onSurfaceVariant,
          Theme.of(context).colorScheme.surfaceContainerLow,
        ),
    };

    return _Badge(icon: icon, label: label, color: color, bgColor: bgColor);
  }
}

// ═══════════════════════════════════════════════════════════════
// Generic Badge
// ═══════════════════════════════════════════════════════════════

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;

  const _Badge({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
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
            style: TextStyle(fontSize: 10, color: color),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Progress Circle
// ═══════════════════════════════════════════════════════════════

class _ProgressCircle extends StatelessWidget {
  final QueueStatus status;
  final bool isActive;
  final bool isCurrent;

  const _ProgressCircle({
    required this.status,
    required this.isActive,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    final conf = _StatusConfig.of(status);

    final Color bgColor;
    final Color borderColor;
    final Widget iconWidget;
    final Color labelColor;

    if (isCurrent) {
      bgColor = conf.bgColor;
      borderColor = conf.borderColor;
      iconWidget = Icon(conf.icon, size: 14, color: conf.color);
      labelColor = conf.color;
    } else if (isActive) {
      bgColor = const Color(0xFF43A047).withValues(alpha: 0.1);
      borderColor = const Color(0xFF43A047);
      iconWidget = const Icon(
        Icons.check_circle_rounded,
        size: 14,
        color: Color(0xFF43A047),
      );
      labelColor = const Color(0xFF43A047);
    } else {
      bgColor = Theme.of(context).colorScheme.surfaceContainerLowest;
      borderColor = Theme.of(context).colorScheme.outlineVariant;
      iconWidget = Icon(conf.icon, size: 14, color: Theme.of(context).colorScheme.outline);
      labelColor = Theme.of(context).colorScheme.outline;
    }

    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Center(child: iconWidget),
        ),
        const SizedBox(height: 4),
        Text(
          conf.label,
          style: TextStyle(fontSize: 9, color: labelColor),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Photo Button
// ═══════════════════════════════════════════════════════════════

class _PhotoButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool captured;
  final Color activeColor;
  final Color activeBg;

  const _PhotoButton({
    required this.icon,
    required this.label,
    required this.captured,
    required this.activeColor,
    required this.activeBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: captured ? activeBg : Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: captured ? activeColor : Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
            color: captured ? activeColor : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: captured ? activeColor : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          if (captured)
            const Padding(
              padding: EdgeInsetsDirectional.only(top: 2),
              child: Text(
                '✓ تم التقاط',
                style: TextStyle(fontSize: 9, color: Color(0xFF43A047)),
              ),
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Timing Row
// ═══════════════════════════════════════════════════════════════

class _TimingRow extends StatelessWidget {
  final String label;
  final int epoch;

  const _TimingRow({required this.label, required this.epoch});

  @override
  Widget build(BuildContext context) {
    final dt = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    final time = DateFormat.jm('ar').format(dt);
    final date = DateFormat.yMMMd('ar').format(dt);

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          Row(
            children: [
              Text(
                time,
                style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(width: 6),
              Text(
                date,
                style: TextStyle(fontSize: 9, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Advance Button
// ═══════════════════════════════════════════════════════════════

class _AdvanceButton extends StatelessWidget {
  final QueueStatus status;
  final VoidCallback onTap;

  const _AdvanceButton({required this.status, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final (label, icon, color) = switch (status) {
      QueueStatus.waiting || QueueStatus.onTheWay => (
          'ابدأ الخدمة',
          Icons.play_arrow_rounded,
          const Color(0xFF1A73E8),
        ),
      QueueStatus.inProgress => (
          'جاهز ✓',
          Icons.check_circle_rounded,
          const Color(0xFF43A047),
        ),
      QueueStatus.ready => (
          'تم الاستلام',
          Icons.check_circle_rounded,
          Theme.of(context).colorScheme.onSurface,
        ),
      _ => ('', Icons.check, Theme.of(context).colorScheme.onSurfaceVariant),
    };

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: Theme.of(context).colorScheme.surface),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Status Config
// ═══════════════════════════════════════════════════════════════

class _StatusConfig {
  final String label;
  final Color color;
  final Color bgColor;
  final Color borderColor;
  final IconData icon;

  const _StatusConfig({
    required this.label,
    required this.color,
    required this.bgColor,
    required this.borderColor,
    required this.icon,
  });

  static _StatusConfig of(QueueStatus status) => switch (status) {
        QueueStatus.waiting => const _StatusConfig(
            label: 'في الانتظار',
            color: Color(0xFFFF9800),
            bgColor: Color(0xFFFFF8E1),
            borderColor: Color(0xFFFF9800),
            icon: Icons.access_time_rounded,
          ),
        QueueStatus.onTheWay => const _StatusConfig(
            label: 'في الطريق',
            color: Color(0xFF43A047),
            bgColor: Color(0xFFF0FDF4),
            borderColor: Color(0xFF43A047),
            icon: Icons.navigation_rounded,
          ),
        QueueStatus.inProgress => const _StatusConfig(
            label: 'قيد الخدمة',
            color: Color(0xFF1A73E8),
            bgColor: Color(0xFFEFF6FF),
            borderColor: Color(0xFF1A73E8),
            icon: Icons.play_arrow_rounded,
          ),
        QueueStatus.ready => const _StatusConfig(
            label: 'جاهز للاستلام',
            color: Color(0xFF43A047),
            bgColor: Color(0xFFF0FDF4),
            borderColor: Color(0xFF43A047),
            icon: Icons.check_circle_rounded,
          ),
        QueueStatus.completed => const _StatusConfig(
            label: 'مكتمل',
            color: Color(0xFF6B7280),
            bgColor: Color(0xFFF9FAFB),
            borderColor: Color(0xFF6B7280),
            icon: Icons.local_shipping_rounded,
          ),
        QueueStatus.noShow => const _StatusConfig(
            label: 'لم يحضر',
            color: Color(0xFFE53935),
            bgColor: Color(0xFFFEF2F2),
            borderColor: Color(0xFFE53935),
            icon: Icons.block_rounded,
          ),
      };
}
