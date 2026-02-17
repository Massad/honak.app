import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/domain/entities/reservation_lifecycle.dart';
import 'package:honak/features/business/shared/domain/entities/entities.dart';

/// Timeline card showing reservation lifecycle stages.
///
/// Business view: expand stages to see notification previews + action buttons.
/// Customer view: read-only timeline.
class GuestJourneyCard extends StatefulWidget {
  final BizRequest request;
  final String viewMode; // 'customer' | 'business'
  final ValueChanged<String>? onStatusChange;
  final ValueChanged<JourneyStage>? onSendNotification;
  final String? spaceName;
  final String? checkinDate;
  final String? checkoutDate;

  const GuestJourneyCard({
    super.key,
    required this.request,
    this.viewMode = 'business',
    this.onStatusChange,
    this.onSendNotification,
    this.spaceName,
    this.checkinDate,
    this.checkoutDate,
  });

  @override
  State<GuestJourneyCard> createState() => _GuestJourneyCardState();
}

class _GuestJourneyCardState extends State<GuestJourneyCard> {
  int? _expandedIndex;

  int get _currentStageIndex =>
      journeyStageIndexForStatus(widget.request.status);

  bool get _isBusiness => widget.viewMode == 'business';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: const Icon(
                    Icons.route_outlined,
                    size: 18,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.bizReqGjTitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: cs.onSurface,
                        ),
                      ),
                      if (widget.request.dateRange != null)
                        Text(
                          widget.request.dateRange!,
                          style: TextStyle(
                            fontSize: 10,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Timeline ──
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.md, 0, AppSpacing.md, AppSpacing.md,
            ),
            child: Column(
              children: List.generate(
                kReservationJourneyStages.length,
                (index) => _buildStageRow(context, index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStageRow(BuildContext context, int index) {
    final stage = kReservationJourneyStages[index];
    final isDone = index <= _currentStageIndex;
    final isCurrent = index == _currentStageIndex;
    final isLast = index == kReservationJourneyStages.length - 1;
    final isExpanded = _expandedIndex == index;
    final cs = Theme.of(context).colorScheme;

    final circleColor = isDone ? stage.color : AppColors.textHint;
    final circleBg = isDone
        ? stage.bgColor
        : cs.surfaceContainerHighest.withValues(alpha: 0.3);

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline column
              SizedBox(
                width: 28,
                child: Column(
                  children: [
                    // Circle
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: circleBg,
                        shape: BoxShape.circle,
                        border: isCurrent
                            ? Border.all(color: stage.color, width: 2)
                            : null,
                      ),
                      child: Icon(
                        isDone ? Icons.check : stage.icon,
                        size: 14,
                        color: circleColor,
                      ),
                    ),
                    // Connector line
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          margin:
                              const EdgeInsets.symmetric(vertical: 2),
                          color: isDone
                              ? stage.color.withValues(alpha: 0.3)
                              : AppColors.border,
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              // Content column
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: isLast ? 0 : AppSpacing.sm,
                  ),
                  child: GestureDetector(
                    onTap: _isBusiness
                        ? () => setState(() {
                              _expandedIndex =
                                  isExpanded ? null : index;
                            })
                        : null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                stage.label,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: isCurrent
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: isDone
                                      ? cs.onSurface
                                      : cs.onSurfaceVariant,
                                ),
                              ),
                            ),
                            if (isDone) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.success
                                      .withValues(alpha: 0.1),
                                  borderRadius: AppRadius.pill,
                                ),
                                child: Text(
                                  context.l10n.bizReqGjDone,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    color: AppColors.success,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                            if (_isBusiness) ...[
                              const SizedBox(width: 4),
                              Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 16,
                                color: AppColors.textHint,
                              ),
                            ],
                          ],
                        ),

                        // ── Expanded notification preview ──
                        if (isExpanded && _isBusiness)
                          _buildExpandedContent(context, stage, index),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedContent(
    BuildContext context,
    JourneyStage stage,
    int index,
  ) {
    final cs = Theme.of(context).colorScheme;
    final customerName = widget.request.customer.name;
    final space = widget.spaceName ?? context.l10n.bizReqGjSpaceDefault;
    final checkin = widget.checkinDate ?? '';
    final checkout = widget.checkoutDate ?? '';

    final filledMessage = fillNotificationTemplate(
      stage.notification.message,
      customer: customerName,
      space: space,
      checkin: checkin,
      checkout: checkout,
    );

    final canAdvance = index == _currentStageIndex + 1;

    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.sm),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Notification preview
          Text(
            stage.notification.title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            filledMessage,
            style: TextStyle(
              fontSize: 10,
              color: cs.onSurfaceVariant,
              height: 1.5,
            ),
          ),

          // Map link
          if (stage.notification.includeMap) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.map_outlined, size: 12, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text(
                    context.l10n.bizReqGjViewMap,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Action buttons
          const SizedBox(height: AppSpacing.sm),
          Row(
            textDirection: TextDirection.ltr,
            children: [
              const Spacer(),
              // Send notification button
              _ActionButton(
                label: context.l10n.bizReqGjSendNotification,
                icon: Icons.notifications_outlined,
                color: AppColors.primary,
                onTap: () => widget.onSendNotification?.call(stage),
              ),
              if (canAdvance) ...[
                const SizedBox(width: AppSpacing.sm),
                _ActionButton(
                  label: context.l10n.bizReqGjConfirmStage(stage.label),
                  icon: Icons.check,
                  color: AppColors.success,
                  onTap: () =>
                      widget.onStatusChange?.call(stage.statusTrigger),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
