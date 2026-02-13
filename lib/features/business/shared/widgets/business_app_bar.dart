import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/shared/widgets/page_selector_sheet.dart';
import 'package:honak/shared/providers/app_mode_provider.dart';
import 'package:honak/shared/providers/business_page_provider.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/app_image.dart';

class BusinessAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const BusinessAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bizContext = ref.watch(businessContextProvider);
    final page = bizContext?.page;

    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      // "← عميل" back button
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: AppSpacing.xs),
        child: Center(
          child: GestureDetector(
            onTap: () {
              ref.read(appModeProvider.notifier).switchToCustomerMode();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'عميل',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      leadingWidth: 90,
      // Page name + avatar
      title: page != null
          ? GestureDetector(
              onTap: () => _showPageSelector(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (page.isVerified) ...[
                              Icon(
                                Icons.verified,
                                size: 14,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                            ],
                            Flexible(
                              child: Text(
                                page.name,
                                style: context.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        if (bizContext?.config != null)
                          Text(
                            bizContext!.config!.requestLabelAr,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: Colors.grey.shade400,
                              fontSize: 10,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  // Avatar
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade100,
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    child: AppImage.avatar(
                      url: page.avatarUrl,
                      name: page.name,
                      radius: 18,
                    ),
                  ),
                ],
              ),
            )
          : null,
      centerTitle: false,
      // Notifications
      actions: [
        IconButton(
          onPressed: () => context.showSnackBar('قريباً: الإشعارات'),
          icon: Icon(
            Icons.notifications_outlined,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  void _showPageSelector(BuildContext context) {
    showAppSheet(
      context,
      builder: (_) => const PageSelectorSheet(),
    );
  }
}
