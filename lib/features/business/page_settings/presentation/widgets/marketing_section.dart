import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/entities/user.dart';

class MarketingSection extends StatelessWidget {
  final UserPage page;

  const MarketingSection({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'مشاركة صفحتك',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Link display
          GestureDetector(
            onTap: () {
              Clipboard.setData(
                ClipboardData(text: 'https://honak.app/@${page.slug}'),
              );
              context.showSnackBar('تم نسخ الرابط');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.copy, size: 14, color: Colors.grey.shade400),
                  const Spacer(),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      'honak.app/@${page.slug}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(Icons.link, size: 14, color: Colors.grey.shade400),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          // Share buttons
          Row(
            children: [
              Expanded(
                child: _ShareButton(
                  label: 'مشاركة',
                  icon: Icons.share_outlined,
                  color: Colors.grey.shade600,
                  bgColor: Colors.grey.shade100,
                  onTap: () => context.showSnackBar('قريباً: مشاركة'),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _ShareButton(
                  label: 'رمز QR',
                  icon: Icons.qr_code,
                  color: Colors.grey.shade600,
                  bgColor: Colors.grey.shade100,
                  onTap: () => context.showSnackBar('قريباً: رمز QR'),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _ShareButton(
                  label: 'واتساب',
                  icon: Icons.chat,
                  color: Colors.white,
                  bgColor: const Color(0xFF25D366),
                  onTap: () => context.showSnackBar('قريباً: واتساب'),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Verification card
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: page.isVerified
                  ? AppColors.primary.withValues(alpha: 0.05)
                  : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                if (!page.isVerified)
                  Icon(
                    Icons.chevron_left,
                    size: 16,
                    color: Colors.grey.shade300,
                  ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (page.isVerified) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'موثّقة',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          page.isVerified ? 'صفحة موثّقة' : 'وثّق صفحتك',
                          style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      page.isVerified
                          ? 'صفحتك تحمل شارة التوثيق'
                          : 'احصل على شارة التوثيق لزيادة الثقة',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: AppSpacing.sm),
                Icon(
                  Icons.verified,
                  size: 20,
                  color: page.isVerified
                      ? AppColors.primary
                      : Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShareButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  const _ShareButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              Icon(icon, size: 14, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
