import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/customers/domain/entities/business_customer.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Shows the manage subscription bottom sheet for a subscriber.
Future<void> showManageSubscriptionSheet(
  BuildContext context, {
  required BusinessCustomer customer,
}) {
  return showAppSheet(
    context,
    builder: (_) => _ManageSubscriptionContent(customer: customer),
  );
}

// ═══════════════════════════════════════════════════════════════
// Manage Subscription Content
// ═══════════════════════════════════════════════════════════════

class _ManageSubscriptionContent extends StatelessWidget {
  final BusinessCustomer customer;

  const _ManageSubscriptionContent({required this.customer});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final sub = customer.subscription;
    final isActive = sub?.status == 'active';
    final isPaused = sub?.status == 'paused';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Padding(
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
                margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                decoration: BoxDecoration(
                  color: context.colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Title row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          l10n.bizManageSubTitle(customer.name),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (customer.phone != null)
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              '${customer.phone}'
                              '${customer.area != null ? ' · ${customer.area}' : ''}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.textHint,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerLow,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 14,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Actions
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          child: Column(
            children: [
              // Adjust credits
              _ActionRow(
                icon: Icons.credit_card_outlined,
                iconColor: AppColors.primary,
                iconBgColor: const Color(0xFFEFF6FF), // blue-50
                title: l10n.bizManageAdjustCredits,
                subtitle: l10n.bizManageAdjustCreditsDesc,
                onTap: () {
                  Navigator.of(context).pop();
                  context.showSnackBar(context.l10n.comingSoon);
                },
              ),
              const SizedBox(height: AppSpacing.sm),

              // Pause (if active)
              if (isActive) ...[
                _ActionRow(
                  icon: Icons.pause,
                  iconColor: const Color(0xFFFF9800),
                  iconBgColor: const Color(0xFFFFFBEB), // amber-50
                  title: l10n.bizManagePause,
                  subtitle: l10n.bizManagePauseDesc,
                  onTap: () {
                    Navigator.of(context).pop();
                    _showConfirmAction(
                      context,
                      customer: customer,
                      type: _ConfirmType.pause,
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
              ],

              // Resume (if paused)
              if (isPaused) ...[
                _ActionRow(
                  icon: Icons.check,
                  iconColor: AppColors.success,
                  iconBgColor: const Color(0xFFF0FDF4), // green-50
                  title: l10n.bizManageResume,
                  subtitle: l10n.bizManageResumeDesc,
                  onTap: () {
                    Navigator.of(context).pop();
                    context.showSnackBar(
                      l10n.bizManageResumed(customer.name),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
              ],

              // Cancel subscription
              _ActionRow(
                icon: Icons.block,
                iconColor: const Color(0xFFE53935),
                iconBgColor: const Color(0xFFFEF2F2), // red-50
                title: l10n.bizManageCancel,
                subtitle: l10n.bizManageCancelDesc,
                onTap: () {
                  Navigator.of(context).pop();
                  _showConfirmAction(
                    context,
                    customer: customer,
                    type: _ConfirmType.cancel,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Action Row
// ═══════════════════════════════════════════════════════════════

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionRow({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // Chevron trailing (visually leading in RTL)
            Icon(
              Icons.chevron_left,
              size: 16,
              color: AppColors.textHint.withValues(alpha: 0.5),
            ),
            const Spacer(),

            // Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.md),

            // Icon circle
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 14, color: iconColor),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Confirm Action Sheet (pause / cancel)
// ═══════════════════════════════════════════════════════════════

enum _ConfirmType { pause, cancel }

void _showConfirmAction(
  BuildContext context, {
  required BusinessCustomer customer,
  required _ConfirmType type,
}) {
  showAppSheet(
    context,
    builder: (_) => _ActionConfirmContent(
      customer: customer,
      type: type,
    ),
  );
}

class _ActionConfirmContent extends StatelessWidget {
  final BusinessCustomer customer;
  final _ConfirmType type;

  const _ActionConfirmContent({
    required this.customer,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final sub = customer.subscription;
    final pkgName = sub?.packageName ?? '—';
    final remaining = sub?.remainingCredits ?? 0;
    final total = sub?.totalCredits ?? 0;
    final isPause = type == _ConfirmType.pause;

    final iconColor =
        isPause ? const Color(0xFFFF9800) : const Color(0xFFE53935);
    final iconBgColor =
        isPause ? const Color(0xFFFFFBEB) : const Color(0xFFFEF2F2);
    final buttonColor = iconColor;

    final title = isPause
        ? l10n.bizConfirmPauseTitle
        : l10n.bizConfirmCancelTitle;
    final description = isPause
        ? l10n.bizConfirmPauseDesc(pkgName)
        : l10n.bizConfirmCancelDesc(pkgName);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.sm + AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerLow,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 14,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isPause ? Icons.pause : Icons.block,
                  size: 18,
                  color: iconColor,
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // ── Customer identity card ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          customer.name,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (customer.phone != null)
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              customer.phone!,
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.textHint,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: AppSpacing.md),
                    AppImage.avatar(
                      url: customer.avatar,
                      name: customer.name,
                      radius: 18,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // ── Description ──
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF4B5563), // gray-600
                  height: 1.5,
                ),
                textAlign: TextAlign.end,
              ),
              const SizedBox(height: AppSpacing.lg),

              // ── Warning box (cancel only, if credits remain) ──
              if (!isPause && remaining > 0) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2), // red-50
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFFEE2E2), // red-100
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          l10n.bizConfirmCancelWarning(remaining),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF991B1B), // red-800
                            height: 1.5,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.warning_amber_rounded,
                          size: 16,
                          color: Color(0xFFE53935),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],

              // ── Detail rows ──
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _DetailRow(
                      label: l10n.bizConfirmPackageLabel,
                      value: pkgName,
                    ),
                    const Divider(height: 1, color: Color(0xFFF9FAFB)),
                    _DetailRow(
                      label: l10n.bizConfirmRemainingLabel,
                      value: '$remaining / $total',
                      valueColor: !isPause && remaining > 0
                          ? const Color(0xFFE53935)
                          : null,
                    ),
                    if (isPause) ...[
                      const Divider(height: 1, color: Color(0xFFF9FAFB)),
                      _DetailRow(
                        label: l10n.bizConfirmDeliveryMode,
                        value: sub?.recurringMode == 'auto_send'
                            ? l10n.bizSubAutoMode
                            : l10n.bizSubRemindMode,
                      ),
                    ],
                    if (!isPause) ...[
                      const Divider(height: 1, color: Color(0xFFF9FAFB)),
                      _DetailRow(
                        label: l10n.bizConfirmTotalOrders,
                        value: l10n.bizConfirmTotalOrdersValue(
                          customer.totalOrders,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // ── Action buttons ──
              Row(
                textDirection: TextDirection.ltr,
                children: [
                  // Cancel / back
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          l10n.bizConfirmBack,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF4B5563),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),

                  // Confirm
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        if (isPause) {
                          context.showSnackBar(
                            l10n.bizConfirmPaused(customer.name),
                          );
                        } else {
                          context.showSnackBar(
                            l10n.bizConfirmCancelled(customer.name),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          isPause
                              ? l10n.bizConfirmPauseBtn
                              : l10n.bizConfirmCancelBtn,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Detail Row
// ═══════════════════════════════════════════════════════════════

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: valueColor ?? const Color(0xFF374151), // gray-700
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
