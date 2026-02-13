import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/entities/user.dart';
import 'package:honak/shared/widgets/app_image.dart';

/// Profile card showing user avatar, name, and phone.
class AccountProfileCard extends StatelessWidget {
  final User user;

  const AccountProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
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
      child: Row(
        children: [
          Icon(
            Icons.chevron_left,
            size: 16,
            color: Colors.grey.shade300,
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                user.name,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                user.phone,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          AppImage.avatar(
            url: user.avatarUrl,
            name: user.name,
            radius: 22,
          ),
        ],
      ),
    );
  }
}

/// A business page card in the account settings.
class AccountPageItem extends StatelessWidget {
  final UserPage page;
  final bool isActive;
  final VoidCallback? onTap;

  const AccountPageItem({
    super.key,
    required this.page,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive
          ? AppColors.primary.withValues(alpha: 0.05)
          : Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isActive
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : Colors.grey.shade100,
            ),
          ),
          child: Row(
            children: [
              if (isActive)
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
                    'نشطة',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                )
              else
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
                      if (page.isVerified)
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.only(end: 4),
                          child: Icon(
                            Icons.verified,
                            size: 12,
                            color: AppColors.primary,
                          ),
                        ),
                      Text(
                        page.name,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (page.businessTypeName != null)
                    Text(
                      page.businessTypeName!,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade400,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: AppSpacing.sm),
              AppImage(
                url: page.avatarUrl,
                width: 32,
                height: 32,
                borderRadius: BorderRadius.circular(8),
                placeholderIcon: Icons.store,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
