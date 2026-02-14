import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant_status.dart';

/// Business-facing tenant card with status-aware display and inline actions.
///
/// Matches Figma: avatar, name+subtitle, status line, two action buttons.
/// Four states:
/// 1. **Claimed** (green): "عرض الصفحة" + "تعديل"
/// 2. **New** (<7 days, blue): same as claimed + "جديد" badge
/// 3. **Invited** (orange): "إعادة الدعوة" + "تعديل"
/// 4. **Unclaimed** (gray): "إرسال دعوة" + "تعديل"
class TenantManageCard extends StatelessWidget {
  final Tenant tenant;
  final VoidCallback? onTap;
  final VoidCallback? onMenuAction;
  final VoidCallback? onViewPage;
  final VoidCallback? onEdit;
  final VoidCallback? onInvite;

  const TenantManageCard({
    super.key,
    required this.tenant,
    this.onTap,
    this.onMenuAction,
    this.onViewPage,
    this.onEdit,
    this.onInvite,
  });

  @override
  Widget build(BuildContext context) {
    final status = tenant.status;

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.card,
      child: Container(
        padding: const EdgeInsetsDirectional.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: Border.all(color: context.colorScheme.outlineVariant),
          borderRadius: AppRadius.card,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top row: menu + info + avatar
            Row(
              children: [
                // Unlink/link indicator icon
                Icon(
                  status == TenantStatus.claimed ||
                          status == TenantStatus.newTenant
                      ? Icons.link
                      : status == TenantStatus.invited
                          ? Icons.schedule_send
                          : Icons.link_off,
                  size: 16,
                  color: status.color.withValues(alpha: 0.6),
                ),
                const SizedBox(width: AppSpacing.sm),

                // Info column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Name + badge
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              tenant.name,
                              style: context.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (status == TenantStatus.newTenant ||
                              status == TenantStatus.invited) ...[
                            const SizedBox(width: AppSpacing.xs),
                            _Badge(status: status),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),

                      // Category · unit · floor
                      Text(
                        '${tenant.category} · ${tenant.unit}',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),

                      // Status line with dot
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: status.color,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          _StatusSubtitle(tenant: tenant, status: status),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: AppSpacing.sm),

                // Avatar
                _TenantLogo(logoUrl: tenant.logoUrl),
              ],
            ),

            const SizedBox(height: AppSpacing.sm),

            // Action buttons row
            Row(
              textDirection: TextDirection.ltr,
              children: [
                // Menu icon (far left in LTR = far right in RTL)
                SizedBox(
                  width: 32,
                  height: 32,
                  child: IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 18,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    onPressed: onMenuAction,
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                const Spacer(),

                // Edit button
                _ActionButton(
                  icon: Icons.edit_outlined,
                  label: 'تعديل',
                  onTap: onEdit,
                ),
                const SizedBox(width: AppSpacing.sm),

                // Primary action (View Page / Invite)
                if (status == TenantStatus.claimed ||
                    status == TenantStatus.newTenant)
                  _ActionButton(
                    icon: Icons.open_in_new,
                    label: 'عرض الصفحة',
                    onTap: onViewPage,
                    isPrimary: true,
                  )
                else if (status == TenantStatus.invited)
                  _ActionButton(
                    icon: Icons.send,
                    label: 'إعادة الدعوة',
                    onTap: onInvite,
                    isPrimary: true,
                  )
                else
                  _ActionButton(
                    icon: Icons.mail_outline,
                    label: 'إرسال دعوة',
                    onTap: onInvite,
                    isPrimary: true,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isPrimary;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isPrimary ? AppColors.primary : context.colorScheme.onSurface;
    final bgColor = isPrimary
        ? AppColors.primary.withValues(alpha: 0.08)
        : context.colorScheme.surfaceContainerHighest;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: AppRadius.cardInner,
          border: isPrimary
              ? Border.all(color: AppColors.primary.withValues(alpha: 0.2))
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TenantLogo extends StatelessWidget {
  final String? logoUrl;

  const _TenantLogo({required this.logoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colorScheme.surfaceContainerHighest,
      ),
      clipBehavior: Clip.antiAlias,
      child: logoUrl != null
          ? Image.network(
              logoUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(
                Icons.storefront,
                size: 22,
                color: context.colorScheme.onSurfaceVariant,
              ),
            )
          : Icon(
              Icons.storefront,
              size: 22,
              color: context.colorScheme.onSurfaceVariant,
            ),
    );
  }
}

class _Badge extends StatelessWidget {
  final TenantStatus status;

  const _Badge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 1,
      ),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.15),
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        status.label,
        style: context.textTheme.labelSmall?.copyWith(
          color: status.color,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }
}

class _StatusSubtitle extends StatelessWidget {
  final Tenant tenant;
  final TenantStatus status;

  const _StatusSubtitle({required this.tenant, required this.status});

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme.labelSmall?.copyWith(
      color: status.color,
      fontWeight: FontWeight.w500,
    );

    return switch (status) {
      TenantStatus.claimed => Text(
          'مربوط · ${_timeAgo(tenant.linkedAt)}',
          style: style,
        ),
      TenantStatus.newTenant => Text(
          'مربوط · ${_timeAgo(tenant.linkedAt)}',
          style: style,
        ),
      TenantStatus.invited => Text(
          'دعوة معلّقة · ${_timeAgo(tenant.invitedAt)}',
          style: style,
        ),
      TenantStatus.unclaimed => Text(
          'غير مربوط',
          style: style,
        ),
    };
  }

  String _timeAgo(String? dateStr) {
    if (dateStr == null) return '';
    final date = DateTime.tryParse(dateStr);
    if (date == null) return '';
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 30) return 'منذ ${diff.inDays ~/ 30} شهر';
    if (diff.inDays > 0) return 'منذ ${diff.inDays} يوم';
    if (diff.inHours > 0) return 'منذ ${diff.inHours} ساعة';
    return 'الآن';
  }
}
