import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_wizard/presentation/providers/wizard_provider.dart';
import 'package:honak/features/business/page_wizard/presentation/widgets/handle_step.dart';
import 'package:honak/features/business/page_wizard/presentation/widgets/hours_step.dart';
import 'package:honak/features/business/page_wizard/presentation/widgets/location_step.dart';
import 'package:honak/features/business/page_wizard/presentation/widgets/page_info_step.dart';
import 'package:honak/features/business/page_wizard/presentation/widgets/payment_step.dart';
import 'package:honak/features/business/page_wizard/presentation/widgets/type_picker_step.dart';
import 'package:honak/features/business/page_wizard/presentation/widgets/wizard_done.dart';
import 'package:honak/shared/widgets/app_direction.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

class WizardPage extends ConsumerWidget {
  const WizardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(wizardProvider);
    final notifier = ref.read(wizardProvider.notifier);
    final theme = Theme.of(context);

    // Done screen — no header/footer
    if (state.step == 7) {
      return const WizardDone();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '${state.step} / ٦',
          style: theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(AppDirection.backIcon(context), size: 20),
            onPressed: () {
              if (state.step > 1) {
                notifier.prevStep();
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress bar
          _ProgressBar(currentStep: state.step, totalSteps: 6),
          // Step content
          Expanded(
            child: _buildStep(state.step),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: btn.Button(
              onPressed: notifier.canProceed
                  ? () {
                      if (state.step == 6) {
                        notifier.submit();
                      } else {
                        notifier.nextStep();
                      }
                    }
                  : null,
              label: state.step == 6 ? 'نشر الصفحة' : 'التالي',
              icon: state.step == 6
                  ? const btn.ButtonIcon(Icons.auto_awesome)
                  : null,
              size: btn.ButtonSize.large,
              expand: true,
            ),
        ),
      ),
    );
  }

  Widget _buildStep(int step) {
    return switch (step) {
      1 => const TypePickerStep(),
      2 => const HandleStep(),
      3 => const PageInfoStep(),
      4 => const LocationStep(),
      5 => const HoursStep(),
      6 => const PaymentStep(),
      _ => const SizedBox.shrink(),
    };
  }
}

class _ProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const _ProgressBar({required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: List.generate(totalSteps, (index) {
          final stepNum = index + 1;
          final isCompleted = stepNum < currentStep;
          final isCurrent = stepNum == currentStep;
          return Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsetsDirectional.only(
                end: index < totalSteps - 1 ? AppSpacing.xs : 0,
              ),
              decoration: BoxDecoration(
                color: isCompleted || isCurrent
                    ? AppColors.primary
                    : context.colorScheme.outlineVariant,
                borderRadius: AppRadius.pill,
              ),
            ),
          );
        }),
      ),
    );
  }
}
