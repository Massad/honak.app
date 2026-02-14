import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/subscriptions/domain/entities/entities.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Opens the renewal request bottom sheet for a subscription.
void showRenewalRequestSheet(BuildContext context, Subscription subscription) {
  showAppSheet(
    context,
    builder: (context) =>
        _RenewalRequestSheet(subscription: subscription),
  );
}

class _RenewalRequestSheet extends StatefulWidget {
  final Subscription subscription;

  const _RenewalRequestSheet({required this.subscription});

  @override
  State<_RenewalRequestSheet> createState() => _RenewalRequestSheetState();
}

class _RenewalRequestSheetState extends State<_RenewalRequestSheet> {
  final _noteController = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    setState(() => _submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    final sub = widget.subscription;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'تجديد الاشتراك',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, size: 20),
                  style: IconButton.styleFrom(
                    backgroundColor: context.colorScheme.surfaceContainerLow,
                    padding: const EdgeInsets.all(6),
                    minimumSize: const Size(32, 32),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            if (_submitted)
              _SuccessState()
            else ...[
              // Package info card
              _PackageInfoCard(sub: sub),
              const SizedBox(height: AppSpacing.lg),

              // Note field
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'ملاحظة للمتجر (اختياري)',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'هل تريد تغيير موعد التوصيل أو إضافة تفاصيل...',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  filled: true,
                  fillColor: context.colorScheme.surfaceContainerLowest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: context.colorScheme.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: context.colorScheme.outlineVariant),
                  ),
                  contentPadding: const EdgeInsets.all(AppSpacing.md),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Info banner
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            color: context.colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                          children: [
                            const TextSpan(
                              text:
                                  'سيتم إنشاء طلب تجديد جديد وإرساله للمتجر. ستتمكن من متابعة حالة الطلب من صفحة ',
                            ),
                            TextSpan(
                              text: 'طلباتي',
                              style: TextStyle(color: AppColors.primary),
                            ),
                            const TextSpan(text: '.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _handleSubmit,
                  icon: const Icon(Icons.send, size: 18),
                  label: const Text(
                    'إرسال طلب التجديد',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PackageInfoCard extends StatelessWidget {
  final Subscription sub;

  const _PackageInfoCard({required this.sub});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        border: Border.all(color: const Color(0xFFBBDEFB)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                ),
              ],
            ),
            child: const Center(
              child: Text('📦', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            sub.packageName,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sub.pageName,
            style: TextStyle(
              fontSize: 13,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              border: Border.all(color: const Color(0xFFBBDEFB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh, size: 12, color: AppColors.primary),
                const SizedBox(width: 6),
                Text(
                  'طلب تجديد',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              size: 32,
              color: AppColors.success,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'تم إرسال الطلب',
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'سيظهر الطلب في قائمة طلباتك النشطة بانتظار تأكيد المتجر',
            style: TextStyle(
              fontSize: 13,
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
