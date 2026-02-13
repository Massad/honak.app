import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/page_settings.dart';
import 'package:honak/features/business/page_settings/presentation/providers/settings_provider.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/post_booking_template_sheet.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';

class PostBookingSteps extends ConsumerWidget {
  final VoidCallback onClose;

  const PostBookingSteps({super.key, required this.onClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(pageSettingsProvider);
    final steps =
        settingsAsync.valueOrNull?.postBookingSteps ?? [];

    return Column(
      children: [
        SubScreenAppBar(
          title: 'خطوات ما بعد الحجز',
          onClose: onClose,
        ),
        Expanded(
          child: ReorderableListView.builder(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: steps.length + 2,
            onReorder: (oldIndex, newIndex) {
              if (oldIndex >= steps.length ||
                  newIndex > steps.length) {
                return;
              }
              if (newIndex > oldIndex) newIndex--;
              final reordered =
                  List<PostBookingStep>.from(steps);
              final item = reordered.removeAt(oldIndex);
              reordered.insert(newIndex, item);
              ref
                  .read(pageSettingsProvider.notifier)
                  .reorderPostBookingSteps(reordered);
            },
            itemBuilder: (context, index) {
              // Add button
              if (index == steps.length) {
                return _AddStepButton(
                  key: const ValueKey('add_button'),
                  stepsCount: steps.length,
                );
              }

              // Templates button
              if (index == steps.length + 1) {
                return _TemplatesButton(
                  key: const ValueKey('template_button'),
                );
              }

              final step = steps[index];
              return _StepItem(
                key: ValueKey('step_${step.id}'),
                step: step,
                index: index,
                isLast: index == steps.length - 1,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AddStepButton extends ConsumerWidget {
  final int stepsCount;

  const _AddStepButton({super.key, required this.stepsCount});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            final id =
                'pbs_${DateTime.now().millisecondsSinceEpoch}';
            ref
                .read(pageSettingsProvider.notifier)
                .addPostBookingStep(
                  PostBookingStep(
                    id: id,
                    text: '',
                    sortOrder: stepsCount,
                  ),
                );
          },
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color:
                    AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'إضافة خطوة',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Icon(
                  Icons.add_circle_outline,
                  size: 18,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TemplatesButton extends ConsumerWidget {
  const _TemplatesButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () =>
              showPostBookingTemplateSheet(context, ref),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.grey.shade200,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'من القوالب الجاهزة',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Icon(
                  Icons.library_books_outlined,
                  size: 18,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StepItem extends ConsumerWidget {
  final PostBookingStep step;
  final int index;
  final bool isLast;

  const _StepItem({
    super.key,
    required this.step,
    required this.index,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: isLast ? 0 : AppSpacing.sm,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          children: [
            Icon(
              Icons.drag_handle,
              size: 18,
              color: Colors.grey.shade300,
            ),
            const SizedBox(width: AppSpacing.sm),
            Switch(
              value: step.isActive,
              onChanged: (v) {
                ref
                    .read(pageSettingsProvider.notifier)
                    .togglePostBookingStep(step.id, v);
              },
              activeThumbColor: AppColors.primary,
            ),
            IconButton(
              onPressed: () {
                ref
                    .read(pageSettingsProvider.notifier)
                    .removePostBookingStep(step.id);
              },
              icon: Icon(
                Icons.delete_outline,
                size: 16,
                color: AppColors.error,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const Spacer(),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: step.isActive
                    ? AppColors.primary
                        .withValues(alpha: 0.1)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: step.isActive
                        ? AppColors.primary
                        : Colors.grey.shade400,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                step.text.isEmpty
                    ? 'خطوة جديدة'
                    : step.text,
                style: context.textTheme.bodySmall?.copyWith(
                  color: step.text.isEmpty
                      ? Colors.grey.shade400
                      : null,
                ),
                textAlign: TextAlign.end,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
