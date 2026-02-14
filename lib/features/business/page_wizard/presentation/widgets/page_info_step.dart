import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_wizard/presentation/providers/wizard_provider.dart';

class PageInfoStep extends ConsumerStatefulWidget {
  const PageInfoStep({super.key});

  @override
  ConsumerState<PageInfoStep> createState() => _PageInfoStepState();
}

class _PageInfoStepState extends ConsumerState<PageInfoStep> {
  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(wizardProvider);
    _nameController = TextEditingController(text: state.pageName);
    _descController = TextEditingController(text: state.description);
    _phoneController = TextEditingController(text: state.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(wizardProvider.notifier);
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      children: [
        // Logo placeholder
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: context.colorScheme.outlineVariant,
                width: 1.5,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt_outlined, color: context.colorScheme.onSurfaceVariant, size: 24),
                SizedBox(height: 2),
                Text(
                  'الشعار',
                  style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Cover photo placeholder
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: AppRadius.cardInner,
            border: Border.all(
              color: context.colorScheme.outlineVariant,
              width: 1.5,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt_outlined, color: context.colorScheme.onSurfaceVariant, size: 28),
              SizedBox(height: AppSpacing.xs),
              Text(
                'صورة الغلاف',
                style: TextStyle(fontSize: 12, color: context.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),

        // Business name
        Text(
          'اسم النشاط *',
          style: theme.textTheme.labelLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'مثال: مياه أبو أحمد',
            border: OutlineInputBorder(borderRadius: AppRadius.button),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
          ),
          onChanged: notifier.setPageName,
        ),
        const SizedBox(height: AppSpacing.lg),

        // Description
        Text(
          'وصف النشاط',
          style: theme.textTheme.labelLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: _descController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'وصف مختصر عن نشاطك...',
            border: OutlineInputBorder(borderRadius: AppRadius.button),
            contentPadding: const EdgeInsets.all(AppSpacing.md),
          ),
          onChanged: notifier.setDescription,
        ),
        const SizedBox(height: AppSpacing.lg),

        // Phone
        Text(
          'رقم الهاتف',
          style: theme.textTheme.labelLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        Directionality(
          textDirection: TextDirection.ltr,
          child: TextFormField(
            controller: _phoneController,
            textDirection: TextDirection.ltr,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: '+962 7X XXX XXXX',
              border: OutlineInputBorder(borderRadius: AppRadius.button),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
            ),
            onChanged: notifier.setPhone,
          ),
        ),
      ],
    );
  }
}
