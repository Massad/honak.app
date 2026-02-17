import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/queue/domain/entities/available_add_on.dart';
import 'package:honak/features/business/queue/domain/entities/service_package.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/widgets/app_direction.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Shows the "queue or schedule" bottom sheet.
///
/// Two choices: join queue today (بالدور) or book later (موعد لاحق).
/// If user picks queue today and add-ons are available, shows add-on step.
Future<void> showQueueOrScheduleSheet({
  required BuildContext context,
  required ServicePackage queuePackage,
  List<AvailableAddOn> availableAddOns = const [],
  required int queueSize,
  required int estimatedWaitMin,
  required bool isPaused,
  required void Function(String packageId, List<String>? addOnIds) onJoinQueue,
  required VoidCallback onBookLater,
}) {
  return showAppSheet<void>(
    context,
    builder: (_) => _QueueOrScheduleSheet(
      queuePackage: queuePackage,
      availableAddOns: availableAddOns,
      queueSize: queueSize,
      estimatedWaitMin: estimatedWaitMin,
      isPaused: isPaused,
      onJoinQueue: onJoinQueue,
      onBookLater: onBookLater,
    ),
  );
}

class _QueueOrScheduleSheet extends StatefulWidget {
  final ServicePackage queuePackage;
  final List<AvailableAddOn> availableAddOns;
  final int queueSize;
  final int estimatedWaitMin;
  final bool isPaused;
  final void Function(String packageId, List<String>? addOnIds) onJoinQueue;
  final VoidCallback onBookLater;

  const _QueueOrScheduleSheet({
    required this.queuePackage,
    required this.availableAddOns,
    required this.queueSize,
    required this.estimatedWaitMin,
    required this.isPaused,
    required this.onJoinQueue,
    required this.onBookLater,
  });

  @override
  State<_QueueOrScheduleSheet> createState() => _QueueOrScheduleSheetState();
}

class _QueueOrScheduleSheetState extends State<_QueueOrScheduleSheet> {
  // 'choice' or 'addons'
  String _step = 'choice';
  final Set<String> _selectedAddOnIds = {};

  int get _totalCents {
    var total = widget.queuePackage.price;
    for (final addOn in widget.availableAddOns) {
      if (_selectedAddOnIds.contains(addOn.id)) {
        total += addOn.priceCents;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return AppSheetScaffold(
      title: null,
      showBodyDivider: false,
      scrollable: false,
      bodyPadding: EdgeInsets.zero,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          const Divider(height: 1),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: _step == 'choice'
                  ? _buildChoiceStep(context)
                  : _buildAddOnsStep(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final price = Money(widget.queuePackage.price);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.queuePackage.nameAr,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  price.toFormattedArabic(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Choice Step ─────────────────────────────────────────────────────────

  Widget _buildChoiceStep(BuildContext context) {
    return Column(
      children: [
        // Option 1: Today — Queue
        _buildOptionCard(
          context,
          icon: Icons.people,
          iconBgColor: AppColors.primary.withValues(alpha: 0.1),
          iconColor: AppColors.primary,
          borderColor: AppColors.primary,
          bgColor: AppColors.primary.withValues(alpha: 0.03),
          title: context.l10n.queueTodayByQueue,
          subtitle: context.l10n.queueTodayByQueueSubtitle,
          enabled: !widget.isPaused,
          onTap: _handleQueueToday,
          bottomWidget: _buildQueueStatsRow(context),
        ),
        const SizedBox(height: AppSpacing.md),
        // Option 2: Book Later
        _buildOptionCard(
          context,
          icon: Icons.calendar_month,
          iconBgColor: context.colorScheme.onSurfaceVariant.withValues(
            alpha: 0.1,
          ),
          iconColor: context.colorScheme.onSurfaceVariant,
          borderColor: context.colorScheme.outlineVariant,
          bgColor: null,
          title: context.l10n.queueBookLater,
          subtitle: context.l10n.queueBookLaterSubtitle,
          enabled: true,
          onTap: () {
            Navigator.pop(context);
            widget.onBookLater();
          },
        ),
      ],
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required Color borderColor,
    required Color? bgColor,
    required String title,
    required String subtitle,
    required bool enabled,
    required VoidCallback onTap,
    Widget? bottomWidget,
  }) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: AppRadius.card,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: AppRadius.card,
            border: Border.all(color: borderColor),
            color: bgColor,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: AppRadius.cardInner,
                    ),
                    alignment: Alignment.center,
                    child: Icon(icon, size: 20, color: iconColor),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    AppDirection.chevronStartIcon(context),
                    size: 20,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              if (bottomWidget != null) ...[
                const SizedBox(height: AppSpacing.md),
                bottomWidget,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQueueStatsRow(BuildContext context) {
    if (widget.isPaused) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.warning.withValues(alpha: 0.1),
          borderRadius: AppRadius.cardInner,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.pause_circle, size: 14, color: AppColors.warning),
            const SizedBox(width: AppSpacing.xs),
            Text(
              context.l10n.queuePausedTemporarily,
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.warning,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: AppRadius.cardInner,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.people_outline, size: 14, color: AppColors.primary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            context.l10n.queueQueueSizeWaiting(widget.queueSize),
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          const Icon(Icons.access_time, size: 14, color: AppColors.primary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            context.l10n.queueApproxMinutes(widget.estimatedWaitMin),
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  void _handleQueueToday() {
    if (widget.availableAddOns.isNotEmpty) {
      setState(() => _step = 'addons');
    } else {
      Navigator.pop(context);
      widget.onJoinQueue(widget.queuePackage.id, null);
    }
  }

  // ── Add-Ons Step ────────────────────────────────────────────────────────

  Widget _buildAddOnsStep(BuildContext context) {
    final total = Money(_totalCents);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.queueOptionalAddOns,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ...widget.availableAddOns.map((addOn) {
          final isSelected = _selectedAddOnIds.contains(addOn.id);
          final price = Money(addOn.priceCents);
          return Padding(
            padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedAddOnIds.remove(addOn.id);
                  } else {
                    _selectedAddOnIds.add(addOn.id);
                  }
                });
              },
              borderRadius: AppRadius.cardInner,
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  borderRadius: AppRadius.cardInner,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : context.colorScheme.outlineVariant,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      size: 20,
                      color: isSelected
                          ? AppColors.primary
                          : context.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        addOn.nameAr,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      '+${price.toFormattedArabic()}',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: AppSpacing.md),
        // Total line
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest,
            borderRadius: AppRadius.cardInner,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.queueTotal,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                total.toFormattedArabic(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        // Action buttons
        Row(
          children: [
            Expanded(
              child: btn.Button(
                onPressed: () => setState(() => _step = 'choice'),
                label: context.l10n.back,
                variant: btn.Variant.outlined,
                size: btn.ButtonSize.large,
                expand: true,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              flex: 2,
              child: btn.Button(
                onPressed: () {
                  Navigator.pop(context);
                  widget.onJoinQueue(
                    widget.queuePackage.id,
                    _selectedAddOnIds.isEmpty
                        ? null
                        : _selectedAddOnIds.toList(),
                  );
                },
                label: context.l10n.queueReserveSpot,
                icon: const btn.ButtonIcon(Icons.navigation),
                size: btn.ButtonSize.large,
                expand: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
