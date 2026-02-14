import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_wizard/presentation/providers/wizard_provider.dart';

class HandleStep extends ConsumerStatefulWidget {
  const HandleStep({super.key});

  @override
  ConsumerState<HandleStep> createState() => _HandleStepState();
}

class _HandleStepState extends ConsumerState<HandleStep> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: ref.read(wizardProvider).handle);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(wizardProvider);
    final notifier = ref.read(wizardProvider.notifier);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'اختر اسم المستخدم',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'هذا هو الرابط الذي ستشاركه مع عملائك',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Handle input with prefix
          Directionality(
            textDirection: TextDirection.ltr,
            child: TextField(
              controller: _controller,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                prefixText: 'honak.app/@',
                prefixStyle: TextStyle(
                  color: context.colorScheme.onSurfaceVariant,
                  fontSize: 15,
                ),
                hintText: 'اسم_المستخدم',
                border: OutlineInputBorder(
                  borderRadius: AppRadius.button,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.lg,
                ),
              ),
              onChanged: (v) => notifier.setHandle(v),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Status indicator
          if (state.handle.length >= 3) ...[
            if (state.handleChecking)
              Row(
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'جارٍ التحقق...',
                    style: TextStyle(
                      color: context.colorScheme.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                ],
              )
            else if (state.handleAvailable)
              const Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.success, size: 18),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    'متاح!',
                    style: TextStyle(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              )
            else
              const Row(
                children: [
                  Icon(Icons.cancel, color: AppColors.error, size: 18),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    'هذا الاسم مستخدم بالفعل',
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
          ],
        ],
      ),
    );
  }
}
