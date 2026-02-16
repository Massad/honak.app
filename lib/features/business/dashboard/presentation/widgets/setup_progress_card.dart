import 'package:flutter/material.dart';

import 'package:honak/config/archetype.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// A setup step for page onboarding.
class SetupStep {
  final String id;
  final String label;
  final IconData icon;
  final bool done;
  final String actionLabel;

  const SetupStep({
    required this.id,
    required this.label,
    required this.icon,
    required this.done,
    required this.actionLabel,
  });
}

/// Returns the setup steps for a given archetype.
/// In demo mode, first 3 steps are marked as done.
List<SetupStep> getSetupSteps(Archetype archetype) {
  final productsLabel = switch (archetype) {
    Archetype.menuOrder => 'أضف أصناف القائمة',
    Archetype.serviceBooking => 'أضف خدماتك',
    Archetype.catalogOrder => 'أضف منتجاتك',
    _ => 'أضف محتوى صفحتك',
  };

  final steps = <SetupStep>[
    const SetupStep(
      id: 'logo',
      label: 'أضف شعار / صورة الصفحة',
      icon: Icons.camera_alt_outlined,
      done: true, // demo: done
      actionLabel: 'إضافة',
    ),
    const SetupStep(
      id: 'location',
      label: 'حدد موقعك على الخريطة',
      icon: Icons.location_on_outlined,
      done: true, // demo: done
      actionLabel: 'تحديد',
    ),
    const SetupStep(
      id: 'hours',
      label: 'أضف ساعات العمل',
      icon: Icons.access_time_outlined,
      done: true, // demo: done
      actionLabel: 'إضافة',
    ),
    SetupStep(
      id: 'products',
      label: productsLabel,
      icon: Icons.inventory_2_outlined,
      done: false, // demo: pending
      actionLabel: 'إضافة',
    ),
    const SetupStep(
      id: 'payment',
      label: 'حدد طرق الدفع المقبولة',
      icon: Icons.credit_card_outlined,
      done: false, // demo: pending
      actionLabel: 'تحديد',
    ),
  ];

  // Optional team step for service businesses
  if (archetype == Archetype.serviceBooking) {
    steps.add(const SetupStep(
      id: 'team',
      label: 'أضف فريق العمل',
      icon: Icons.people_outlined,
      done: false, // demo: pending
      actionLabel: 'إضافة',
    ));
  }

  return steps;
}

/// Expandable setup checklist card for new/incomplete business pages.
/// Matches Figma SetupProgress.tsx.
class SetupProgressCard extends StatefulWidget {
  final Archetype archetype;
  final ValueChanged<String>? onAction;

  const SetupProgressCard({
    super.key,
    required this.archetype,
    this.onAction,
  });

  @override
  State<SetupProgressCard> createState() => _SetupProgressCardState();
}

class _SetupProgressCardState extends State<SetupProgressCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final steps = getSetupSteps(widget.archetype);
    final doneCount = steps.where((s) => s.done).length;
    final totalCount = steps.length;
    final progress = (doneCount / totalCount * 100).round();

    // Hide when 100% complete
    if (doneCount == totalCount) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            // Header
            _buildHeader(context, doneCount, totalCount, progress),

            // Progress bar
            _buildProgressBar(context, progress),

            // Expandable steps list
            AnimatedCrossFade(
              firstChild: _buildStepsList(context, steps, progress),
              secondChild: const SizedBox.shrink(),
              crossFadeState: _expanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 250),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    int doneCount,
    int totalCount,
    int progress,
  ) {
    return InkWell(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.md,
        ),
        child: Row(
          children: [
            // Gradient rocket icon
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary, Color(0xFF4DA3FF)],
                ),
              ),
              child: const Icon(
                Icons.rocket_launch,
                size: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),

            // Title + subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'أكمل إعداد صفحتك',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    '$doneCount من $totalCount خطوات مكتملة',
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            // Percentage + chevron
            Text(
              '$progress%',
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(
              _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 14,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, int progress) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
          height: 8,
          child: Stack(
            children: [
              // Background
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              // Fill
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress / 100),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return FractionallySizedBox(
                    widthFactor: value,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: const LinearGradient(
                          begin: AlignmentDirectional.centerEnd,
                          end: AlignmentDirectional.centerStart,
                          colors: [AppColors.primary, Color(0xFF4DA3FF)],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepsList(
    BuildContext context,
    List<SetupStep> steps,
    int progress,
  ) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Column(
        children: [
          // Step items
          ...steps.map((step) => _StepItem(
                step: step,
                onAction: () => widget.onAction?.call(step.id),
              )),
          const SizedBox(height: AppSpacing.sm),

          // Motivational message
          _MotivationalMessage(progress: progress),
        ],
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final SetupStep step;
  final VoidCallback onAction;

  const _StepItem({required this.step, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: step.done
              ? const Color(0xFF43A047).withValues(alpha: 0.06)
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Check/circle icon
            Icon(
              step.done ? Icons.check_circle : Icons.circle_outlined,
              size: 16,
              color: step.done
                  ? AppColors.success
                  : Theme.of(context).colorScheme.outlineVariant,
            ),
            const SizedBox(width: AppSpacing.md),

            // Step icon
            Icon(
              step.icon,
              size: 14,
              color: step.done
                  ? AppColors.success
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: AppSpacing.sm),

            // Label
            Expanded(
              child: Text(
                step.label,
                style: TextStyle(
                  fontSize: 12,
                  color: step.done
                      ? Theme.of(context).colorScheme.onSurfaceVariant
                      : Theme.of(context).colorScheme.onSurface,
                  decoration:
                      step.done ? TextDecoration.lineThrough : null,
                ),
              ),
            ),

            // Action button (only for pending steps)
            if (!step.done)
              btn.Button(
                onPressed: onAction,
                label: step.actionLabel,
                variant: btn.Variant.tonal,
                size: btn.ButtonSize.small,
              ),
          ],
        ),
      ),
    );
  }
}

class _MotivationalMessage extends StatelessWidget {
  final int progress;

  const _MotivationalMessage({required this.progress});

  @override
  Widget build(BuildContext context) {
    final message = progress < 50
        ? 'أكمل الإعداد خلال ٣ دقائق وابدأ باستقبال الطلبات!'
        : progress < 100
            ? 'أوشكت! خطوتين فقط وتصير صفحتك جاهزة'
            : 'ممتاز! صفحتك جاهزة لاستقبال العملاء';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: AlignmentDirectional.centerEnd,
          end: AlignmentDirectional.centerStart,
          colors: [Color(0xFFEFF6FF), Color(0xFFEEF2FF)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.auto_awesome,
            size: 14,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
