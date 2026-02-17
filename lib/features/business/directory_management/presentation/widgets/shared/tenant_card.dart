import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant.dart';
import 'package:honak/shared/widgets/app_direction.dart';

/// Customer-facing tenant card used in directory browsing.
///
/// Shows logo, name, unit, category, and open/closed status.
/// If the tenant has a linked page, tapping navigates to that page.
class TenantCard extends StatelessWidget {
  final Tenant tenant;
  final VoidCallback? onTap;
  final bool compact;

  const TenantCard({
    super.key,
    required this.tenant,
    this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasPage = tenant.pageId != null;
    final isClosed = !tenant.isOpen || tenant.temporarilyClosed;

    return InkWell(
      onTap: hasPage ? onTap : null,
      borderRadius: AppRadius.card,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          vertical: compact ? AppSpacing.sm : AppSpacing.md,
          horizontal: AppSpacing.lg,
        ),
        child: Row(
          children: [
            _TenantLogo(
              logoUrl: tenant.logoUrl,
              size: compact ? 36.0 : 44.0,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tenant.name,
                    style: context.textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            _StatusBadge(isClosed: isClosed),
            if (hasPage) ...[
              const SizedBox(width: AppSpacing.xs),
              Icon(
                AppDirection.chevronEndIcon(context),
                size: 20,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TenantLogo extends StatelessWidget {
  final String? logoUrl;
  final double size;

  const _TenantLogo({required this.logoUrl, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
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
                size: size * 0.5,
                color: context.colorScheme.onSurfaceVariant,
              ),
            )
          : Icon(
              Icons.storefront,
              size: size * 0.5,
              color: context.colorScheme.onSurfaceVariant,
            ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isClosed;

  const _StatusBadge({required this.isClosed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: isClosed
            ? context.colorScheme.surfaceContainerHighest
            : const Color(0xFFDCFCE7),
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        isClosed ? context.l10n.dirClosedStatus : context.l10n.dirOpenStatus,
        style: context.textTheme.labelSmall?.copyWith(
          color: isClosed
              ? context.colorScheme.onSurfaceVariant
              : const Color(0xFF16A34A),
        ),
      ),
    );
  }
}
