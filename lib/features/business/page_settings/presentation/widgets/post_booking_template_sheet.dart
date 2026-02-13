import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/page_settings.dart';
import 'package:honak/features/business/page_settings/presentation/providers/settings_provider.dart';
import 'package:honak/features/business/page_settings/presentation/providers/templates_provider.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Shows a bottom sheet with pre-made post-booking step templates.
void showPostBookingTemplateSheet(
    BuildContext context, WidgetRef ref) {
  final templatesAsync = ref.read(templatesProvider);
  final templates = templatesAsync.valueOrNull;
  if (templates == null) {
    context.showSnackBar('جاري تحميل القوالب...');
    return;
  }

  final list =
      templates['post_booking_templates'] as List? ?? [];

  showAppSheet(
    context,
    maxHeightFraction: 0.8,
    builder: (ctx) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              'قوالب جاهزة',
              style:
                  ctx.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg),
              itemBuilder: (ctx, i) {
                final t =
                    list[i] as Map<String, dynamic>;
                return ListTile(
                  title: Text(
                    t['text'] as String? ?? '',
                    textAlign: TextAlign.end,
                  ),
                  leading: Icon(
                    Icons.add_circle_outline,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  onTap: () {
                    final id =
                        'pbs_${DateTime.now().millisecondsSinceEpoch}';
                    final steps = ref
                            .read(pageSettingsProvider)
                            .valueOrNull
                            ?.postBookingSteps ??
                        [];
                    ref
                        .read(pageSettingsProvider
                            .notifier)
                        .addPostBookingStep(
                          PostBookingStep(
                            id: id,
                            text: t['text']
                                    as String? ??
                                '',
                            sortOrder: steps.length,
                          ),
                        );
                    Navigator.pop(ctx);
                    context.showSnackBar(
                        'تم إضافة الخطوة');
                  },
                );
              },
            ),
          ),
        ],
      );
    },
  );
}
