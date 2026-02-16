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
import 'package:honak/shared/widgets/button.dart' as btn;

class BusinessAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const BusinessAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bizContext = ref.watch(businessContextProvider);
    final page = bizContext?.page;

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      // "← عميل" chip button
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: AppSpacing.sm),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                ref.read(appModeProvider.notifier).switchToCustomerMode();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_forward,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'عميل',
                      style: context.textTheme.labelSmall?.copyWith(
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
      ),
      leadingWidth: 120,
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
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
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
      // Notifications with badge
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: AppSpacing.xs),
          child: Badge(
            label: const Text(
              '5',
              style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
            ),
            backgroundColor: AppColors.error,
            child: btn.Button(
              onPressed: () => context.showSnackBar('قريباً: الإشعارات'),
              icon: btn.ButtonIcon(
                Icons.notifications_outlined,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              variant: btn.Variant.text,
              size: btn.ButtonSize.small,
            ),
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
