import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Full-screen success page shown after submitting a request.
class RequestConfirmationPage extends StatelessWidget {
  final String requestId;
  final String businessName;
  final String requestType;
  final bool isAutoApproved;
  final VoidCallback onViewRequest;
  final VoidCallback onBackToPage;

  const RequestConfirmationPage({
    super.key,
    required this.requestId,
    required this.businessName,
    required this.requestType,
    this.isAutoApproved = false,
    required this.onViewRequest,
    required this.onBackToPage,
  });

  static const _manualApprovalTypes = {'quote', 'inquiry'};

  static const _typeLabels = <String, String>{
    'order': 'طلب الشراء',
    'booking': 'طلب الحجز',
    'quote': 'طلب عرض السعر',
    'inquiry': 'الاستفسار',
    'reservation': 'طلب الحجز',
  };

  @override
  Widget build(BuildContext context) {
    final isAlwaysManual =
        _manualApprovalTypes.contains(requestType);
    final showPending = !isAutoApproved || isAlwaysManual;
    final typeLabel = _typeLabels[requestType] ?? 'الطلب';

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.xxxl,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                _StatusIcon(showPending: showPending),
                const SizedBox(height: AppSpacing.xxl),

                // Title
                Text(
                  showPending ? 'تم الإرسال!' : 'تم التأكيد!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: AppSpacing.sm),

                // Subtitle
                Text(
                  'تم إرسال $typeLabel إلى',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  businessName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                      ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Status card
                _StatusCard(showPending: showPending, requestType: requestType),
                const SizedBox(height: AppSpacing.md),

                // Notification hint
                Text(
                  showPending
                      ? 'ستصلك إشعار عندما يردون على طلبك'
                      : 'ستصلك إشعار عندما يكون طلبك جاهز',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Buttons
                btn.Button(
                  onPressed: onViewRequest,
                  label: 'عرض الطلب',
                  size: btn.ButtonSize.large,
                  expand: true,
                ),
                const SizedBox(height: AppSpacing.md),
                btn.Button(
                  onPressed: onBackToPage,
                  label: 'العودة للصفحة',
                  icon: const btn.ButtonIcon(Icons.arrow_back),
                  variant: btn.Variant.outlined,
                  size: btn.ButtonSize.large,
                  expand: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  final bool showPending;

  const _StatusIcon({required this.showPending});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: showPending
            ? const Color(0xFFFFF8E1)
            : AppColors.success.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        showPending ? Icons.access_time_rounded : Icons.check_circle_rounded,
        size: 56,
        color: showPending ? const Color(0xFFFF8F00) : AppColors.success,
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final bool showPending;
  final String requestType;

  const _StatusCard({
    required this.showPending,
    required this.requestType,
  });

  @override
  Widget build(BuildContext context) {
    final isServiceType =
        const {'quote', 'inquiry'}.contains(requestType);

    if (showPending) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E1),
          border: Border.all(color: const Color(0xFFFFE082)),
          borderRadius: AppRadius.cardInner,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.access_time,
                  size: 14,
                  color: Color(0xFFFF8F00),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'بانتظار الموافقة',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFFF8F00),
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              isServiceType
                  ? 'سيقوم صاحب الخدمة بمراجعة طلبك والرد عليك'
                  : 'سيقوم صاحب المتجر بمراجعة طلبك وتأكيده',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: const Color(0xFFFFB300),
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.05),
        border: Border.all(
          color: AppColors.success.withValues(alpha: 0.3),
        ),
        borderRadius: AppRadius.cardInner,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.bolt,
                size: 14,
                color: AppColors.success,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'تم تأكيد طلبك تلقائياً',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'طلبك مؤكد وجاري التحضير',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.success.withValues(alpha: 0.7),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
