import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_wizard/presentation/providers/wizard_provider.dart';

class WizardDone extends ConsumerWidget {
  const WizardDone({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(wizardProvider);
    final theme = Theme.of(context);
    final link = 'honak.app/@${state.handle}';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(AppSpacing.xxl),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Success icon
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 44,
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Heading
              Text(
                '\u0635\u0641\u062d\u062a\u0643 \u062c\u0627\u0647\u0632\u0629!',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '\u0634\u0627\u0631\u0643 \u0631\u0627\u0628\u0637\u0643 \u0645\u0639 \u0639\u0645\u0644\u0627\u0626\u0643 \u0648\u0627\u0628\u062f\u0623 \u0627\u0633\u062a\u0642\u0628\u0627\u0644 \u0627\u0644\u0637\u0644\u0628\u0627\u062a',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Link card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceVariant,
                  borderRadius: AppRadius.card,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          link,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: link));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('\u062a\u0645 \u0646\u0633\u062e \u0627\u0644\u0631\u0627\u0628\u0637'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy, size: 20),
                      tooltip: '\u0646\u0633\u062e',
                    ),
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('\u0645\u0634\u0627\u0631\u0643\u0629 \u0639\u0628\u0631 \u0648\u0627\u062a\u0633\u0627\u0628 \u2014 \u0642\u0631\u064a\u0628\u0627\u064b'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.share, size: 20),
                      tooltip: '\u0645\u0634\u0627\u0631\u0643\u0629',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Quick action row
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('\u0642\u0631\u064a\u0628\u0627\u064b'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.qr_code, size: 18),
                      label: const Text('QR Code'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('\u0642\u0631\u064a\u0628\u0627\u064b'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.inventory_2_outlined, size: 18),
                      label: const Text('\u0625\u0639\u062f\u0627\u062f \u0627\u0644\u0645\u0646\u062a\u062c\u0627\u062a'),
                    ),
                  ),
                ],
              ),

              const Spacer(flex: 3),

              // CTA: Go to manage page
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: () {
                    // For Phase 1, just pop back — business mode switch
                    // would happen when the page is created on backend
                    Navigator.of(context).pop();
                  },
                  child: const Text('\u0627\u0644\u0630\u0647\u0627\u0628 \u0644\u0625\u062f\u0627\u0631\u0629 \u0627\u0644\u0635\u0641\u062d\u0629'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
