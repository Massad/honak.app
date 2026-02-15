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
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              for (var index = 0; index < steps.length; index++)
                _StepItem(
                  key: ValueKey('step_${steps[index].id}'),
                  step: steps[index],
                  index: index,
                  isLast: index == steps.length - 1,
                  onMoveUp: index > 0
                      ? () {
                          final reordered =
                              List<PostBookingStep>.from(steps);
                          final item = reordered.removeAt(index);
                          reordered.insert(index - 1, item);
                          ref
                              .read(pageSettingsProvider.notifier)
                              .reorderPostBookingSteps(reordered);
                        }
                      : null,
                  onMoveDown: index < steps.length - 1
                      ? () {
                          final reordered =
                              List<PostBookingStep>.from(steps);
                          final item = reordered.removeAt(index);
                          reordered.insert(index + 1, item);
                          ref
                              .read(pageSettingsProvider.notifier)
                              .reorderPostBookingSteps(reordered);
                        }
                      : null,
                ),
              _AddStepButton(stepsCount: steps.length),
              const _TemplatesButton(),
            ],
          ),
        ),
      ],
    );
  }
}

class _AddStepButton extends ConsumerWidget {
  final int stepsCount;

  const _AddStepButton({required this.stepsCount});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
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
  const _TemplatesButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
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
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'من القوالب الجاهزة',
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Icon(
                  Icons.library_books_outlined,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
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
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;

  const _StepItem({
    super.key,
    required this.step,
    required this.index,
    required this.isLast,
    this.onMoveUp,
    this.onMoveDown,
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
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            // Up/down arrows
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ReorderArrow(
                  icon: Icons.arrow_upward,
                  enabled: onMoveUp != null,
                  onTap: onMoveUp ?? () {},
                ),
                const SizedBox(height: 2),
                _ReorderArrow(
                  icon: Icons.arrow_downward,
                  enabled: onMoveDown != null,
                  onTap: onMoveDown ?? () {},
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.sm),
            // Index badge
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(Icons.drag_handle, size: 16, color: Theme.of(context).colorScheme.outline),
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
            Expanded(
              child: Text(
                step.text.isEmpty
                    ? 'خطوة جديدة'
                    : step.text,
                style: context.textTheme.bodySmall?.copyWith(
                  color: step.text.isEmpty
                      ? Theme.of(context).colorScheme.onSurfaceVariant
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

// ── Reorder Arrow ────────────────────────────────────────────────────────────

class _ReorderArrow extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _ReorderArrow({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: enabled
              ? AppColors.primary.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 14,
          color: enabled ? AppColors.primary : Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
    );
  }
}
