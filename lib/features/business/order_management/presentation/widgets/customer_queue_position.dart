import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:url_launcher/url_launcher.dart';

// ═══════════════════════════════════════════════════════════════
// CustomerQueuePosition — Customer delivery tracking widget.
// Aramex-style: "getting closer" → ETA → "you're next!".
// Two variants: compact (for order cards) and full (for detail).
// ═══════════════════════════════════════════════════════════════

enum DeliveryTrackingStatus { queued, onRoute, next, delivered, skipped }

enum CustomerQueueVariant { compact, full }

class CustomerQueuePosition extends StatelessWidget {
  final DeliveryTrackingStatus status;
  final int? estimatedMinutes;
  final String? driverName;
  final String? driverPhone;
  final String? truckName;
  final List<String> preparationHints;
  final String? deliveredAt;
  final int? deliveredQty;
  final int? emptiesCollected;
  final ({int before, int after})? creditsDeducted;
  final String? skipReason;
  final String? rescheduledTo;
  final CustomerQueueVariant variant;
  final bool showDriverContact;

  const CustomerQueuePosition({
    super.key,
    required this.status,
    this.estimatedMinutes,
    this.driverName,
    this.driverPhone,
    this.truckName,
    this.preparationHints = const [],
    this.deliveredAt,
    this.deliveredQty,
    this.emptiesCollected,
    this.creditsDeducted,
    this.skipReason,
    this.rescheduledTo,
    this.variant = CustomerQueueVariant.full,
    this.showDriverContact = true,
  });

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      DeliveryTrackingStatus.delivered => _buildDelivered(context),
      DeliveryTrackingStatus.skipped => _buildSkipped(context),
      _ => variant == CustomerQueueVariant.compact
          ? _buildCompact(context)
          : _buildFull(context),
    };
  }

  // ── Delivered ──────────────────────────────────────────────

  Widget _buildDelivered(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.08),
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: AppColors.success.withValues(alpha: 0.2)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Status header
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'تم التوصيل',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 16,
                  color: AppColors.white,
                ),
              ),
            ],
          ),

          // Delivery time + driver
          if (deliveredAt != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              'تم التسليم الساعة $deliveredAt'
              '${driverName != null ? ' بواسطة $driverName' : ''}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
              textAlign: TextAlign.end,
            ),
          ],

          // Quantity info
          if (deliveredQty != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(
              '$deliveredQty قارورة تم تسليمها'
              '${emptiesCollected != null ? ' · $emptiesCollected فارغة تم جمعها' : ''}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontSize: 10,
              ),
              textAlign: TextAlign.end,
            ),
          ],

          // Credits
          if (creditsDeducted != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              'الرصيد: ${creditsDeducted!.before} ← ${creditsDeducted!.after} (تم الخصم تلقائياً)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.primary,
                fontSize: 10,
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ],
      ),
    );
  }

  // ── Skipped ────────────────────────────────────────────────

  Widget _buildSkipped(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.08),
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.2)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'تم تخطي التوصيل',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.warning,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Icon(Icons.skip_next, size: 18, color: AppColors.warning),
            ],
          ),
          if (skipReason != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              skipReason!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
              textAlign: TextAlign.end,
            ),
          ],
          if (rescheduledTo != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              'تمت إعادة الجدولة: $rescheduledTo',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.primary,
                fontSize: 10,
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ],
      ),
    );
  }

  // ── Active status config ───────────────────────────────────

  _StatusConfig _configForStatus() {
    return switch (status) {
      DeliveryTrackingStatus.queued => _StatusConfig(
          bg: const Color(0xFFF5F5F5),
          border: const Color(0xFFE0E0E0),
          iconBg: const Color(0xFF9E9E9E),
          label: 'طلبك في مسار اليوم',
          desc: estimatedMinutes != null
              ? 'المتوقع: $estimatedMinutes — ${estimatedMinutes! + 20} دقيقة'
              : 'سيتم التوصيل اليوم',
          labelColor: const Color(0xFF616161),
          descColor: AppColors.textSecondary,
          icon: Icons.local_shipping_outlined,
        ),
      DeliveryTrackingStatus.onRoute => _StatusConfig(
          bg: AppColors.primary.withValues(alpha: 0.08),
          border: AppColors.primary.withValues(alpha: 0.25),
          iconBg: AppColors.primary,
          label: 'السائق في المنطقة',
          desc: estimatedMinutes != null
              ? 'المتوقع: $estimatedMinutes — ${estimatedMinutes! + 15} دقيقة'
              : 'السائق يقترب',
          labelColor: AppColors.primary,
          descColor: AppColors.textSecondary,
          icon: Icons.local_shipping_outlined,
        ),
      DeliveryTrackingStatus.next => _StatusConfig(
          bg: AppColors.success.withValues(alpha: 0.08),
          border: AppColors.success.withValues(alpha: 0.35),
          iconBg: AppColors.success,
          label: 'السائق في طريقه إليك!',
          desc: 'المتوقع: ٥ — ١٠ دقائق',
          labelColor: AppColors.success,
          descColor: AppColors.success,
          icon: Icons.navigation_outlined,
        ),
      _ => throw StateError('Unexpected status: $status'),
    };
  }

  // ── Compact variant (for LiveOrderCard) ────────────────────

  Widget _buildCompact(BuildContext context) {
    final c = _configForStatus();

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: c.bg,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: c.border),
      ),
      child: Row(
        children: [
          // Call button for "next" status
          if (status == DeliveryTrackingStatus.next &&
              showDriverContact &&
              driverPhone != null)
            _CallButton(
              phone: driverPhone!,
              compact: true,
            ),

          // Text
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  c.label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: c.labelColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  c.desc,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: c.descColor,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Status icon
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: c.iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(c.icon, size: 14, color: AppColors.white),
          ),
        ],
      ),
    );
  }

  // ── Full variant (for RequestDetail) ───────────────────────

  Widget _buildFull(BuildContext context) {
    final c = _configForStatus();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: c.bg,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: c.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Header row ──
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      c.label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: c.labelColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          c.desc,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: c.descColor,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Icon(Icons.access_time, size: 10, color: c.descColor),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: c.iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(c.icon, size: 18, color: AppColors.white),
              ),
            ],
          ),

          // ── Preparation hints (next status only) ──
          if (status == DeliveryTrackingStatus.next &&
              preparationHints.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.7),
                borderRadius: AppRadius.button,
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'جهّز للاستلام:',
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.success,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Icon(
                        Icons.info_outline,
                        size: 10,
                        color: AppColors.success,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    alignment: WrapAlignment.end,
                    spacing: 6,
                    runSpacing: 6,
                    children: preparationHints
                        .map((hint) => Container(
                              padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.success
                                    .withValues(alpha: 0.12),
                                borderRadius: AppRadius.pill,
                              ),
                              child: Text(
                                hint,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                  color: const Color(0xFF2E7D32),
                                  fontSize: 10,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],

          // ── Driver info ──
          if (showDriverContact && driverName != null) ...[
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.6),
                borderRadius: AppRadius.button,
              ),
              child: Row(
                children: [
                  if (driverPhone != null)
                    _CallButton(phone: driverPhone!, compact: false),
                  const Spacer(),
                  Text(
                    'السائق: $driverName',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.local_shipping_outlined,
                    size: 11,
                    color: AppColors.textHint,
                  ),
                ],
              ),
            ),
          ],

          // ── Truck name ──
          if (truckName != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              truckName!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textHint,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// _CallButton
// ═══════════════════════════════════════════════════════════════

class _CallButton extends StatelessWidget {
  final String phone;
  final bool compact;

  const _CallButton({required this.phone, required this.compact});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: compact ? AppColors.success : AppColors.primary,
      borderRadius: AppRadius.button,
      child: InkWell(
        borderRadius: AppRadius.button,
        onTap: () => launchUrl(Uri.parse('tel:$phone')),
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: compact ? 10 : AppSpacing.md,
            vertical: compact ? 6 : AppSpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.phone, size: 10, color: AppColors.white),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'اتصال',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.white,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// _StatusConfig
// ═══════════════════════════════════════════════════════════════

class _StatusConfig {
  final Color bg;
  final Color border;
  final Color iconBg;
  final String label;
  final String desc;
  final Color labelColor;
  final Color descColor;
  final IconData icon;

  const _StatusConfig({
    required this.bg,
    required this.border,
    required this.iconBg,
    required this.label,
    required this.desc,
    required this.labelColor,
    required this.descColor,
    required this.icon,
  });
}
