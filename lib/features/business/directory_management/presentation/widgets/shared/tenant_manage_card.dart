import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant_status.dart';

/// Business-facing tenant card with status-aware display and action menu.
///
/// Four states:
/// 1. **Claimed** (green): linked with page, actions: View Page, Edit, Unlink
/// 2. **New** (<7 days, blue): same as claimed + "جديد" badge
/// 3. **Invited** (orange): pending invite, actions: Resend, Edit, Cancel
/// 4. **Unclaimed** (gray): no link, actions: Send Invite, Edit, Delete
class TenantManageCard extends StatelessWidget {
  final Tenant tenant;
  final VoidCallback? onTap;
  final VoidCallback? onMenuAction;

  const TenantManageCard({
    super.key,
    required this.tenant,
    this.onTap,
    this.onMenuAction,
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
          border: Border.all(color: context.colorScheme.outlineVariant),
          borderRadius: AppRadius.card,
        ),
        child: Row(
          children: [
            // Status dot
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: status.color,
              ),
            ),
            SizedBox(width: AppSpacing.md),

            // Logo
            _TenantLogo(logoUrl: tenant.logoUrl),
            const SizedBox(width: AppSpacing.md),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          tenant.name,
                          style: context.textTheme.titleSmall,
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
                  SizedBox(height: AppSpacing.xxs),
                  Text(
                    '${tenant.unit} · ${tenant.category}',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  _StatusSubtitle(tenant: tenant, status: status),
                ],
              ),
            ),

            // Menu button
            IconButton(
              icon: const Icon(Icons.more_vert, size: 20),
              onPressed: onMenuAction,
              visualDensity: VisualDensity.compact,
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
      width: 40,
      height: 40,
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
                size: 20,
                color: context.colorScheme.onSurfaceVariant,
              ),
            )
          : Icon(
              Icons.storefront,
              size: 20,
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
        vertical: AppSpacing.xxs,
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
      color: context.colorScheme.onSurfaceVariant,
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
