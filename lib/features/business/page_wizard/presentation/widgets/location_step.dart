import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_wizard/presentation/providers/wizard_provider.dart';

class LocationStep extends ConsumerStatefulWidget {
  const LocationStep({super.key});

  @override
  ConsumerState<LocationStep> createState() => _LocationStepState();
}

class _LocationStepState extends ConsumerState<LocationStep> {
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _addressController =
        TextEditingController(text: ref.read(wizardProvider).address);
  }

  @override
  void dispose() {
    _addressController.dispose();
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
            'موقع النشاط',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Map placeholder
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: AppRadius.cardInner,
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.place, size: 36, color: AppColors.textHint),
                SizedBox(height: AppSpacing.sm),
                Text(
                  'الخريطة ستظهر هنا',
                  style: TextStyle(color: AppColors.textHint, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Use my location button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: state.isOnlineOnly
                  ? null
                  : () {
                      _addressController.text = '\u0639\u0628\u062f\u0648\u0646\u060c \u0639\u0645\u0651\u0627\u0646';
                      notifier.setAddress('\u0639\u0628\u062f\u0648\u0646\u060c \u0639\u0645\u0651\u0627\u0646');
                    },
              icon: const Icon(Icons.my_location, size: 18),
              label: const Text('استخدم موقعي الحالي'),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Address field
          TextFormField(
            controller: _addressController,
            enabled: !state.isOnlineOnly,
            decoration: InputDecoration(
              hintText: 'العنوان',
              border: OutlineInputBorder(borderRadius: AppRadius.button),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
            ),
            onChanged: notifier.setAddress,
          ),

          const Spacer(),

          // Online-only option
          Center(
            child: TextButton(
              onPressed: () {
                final newValue = !state.isOnlineOnly;
                notifier.setOnlineOnly(newValue);
                if (newValue) _addressController.clear();
              },
              child: Text(
                state.isOnlineOnly
                    ? '\u2714 نشاط عبر الإنترنت فقط'
                    : 'تخطي \u2014 نشاط عبر الإنترنت فقط',
                style: TextStyle(
                  color: state.isOnlineOnly
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
