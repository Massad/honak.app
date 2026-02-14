import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/core/extensions/context_ext.dart';

export 'quote_urgency_date_sections.dart';

/// Description textarea for quote request.
class QuoteDescriptionSection extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;

  const QuoteDescriptionSection({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'وصف المشكلة',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: controller,
          maxLines: 5,
          textDirection: TextDirection.rtl,
          onChanged: (_) => onChanged(),
          decoration: InputDecoration(
            hintText:
                'اشرح المشكلة بالتفصيل... مثال: تسريب مياه من أنبوب المطبخ تحت المغسلة',
            hintStyle: theme.textTheme.bodySmall
                ?.copyWith(color: context.colorScheme.onSurfaceVariant),
            filled: true,
            fillColor: context.colorScheme.surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: AppRadius.cardInner,
              borderSide: BorderSide(color: context.colorScheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.cardInner,
              borderSide: BorderSide(color: context.colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.cardInner,
              borderSide: BorderSide(color: AppColors.primary),
            ),
            contentPadding: const EdgeInsets.all(AppSpacing.md),
          ),
        ),
      ],
    );
  }
}

/// Photo attachment mock for quote request.
class QuotePhotosMock extends StatelessWidget {
  const QuotePhotosMock({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'إرفاق صور (اختياري)',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('قريباً: إضافة صور')),
            );
          },
          borderRadius: AppRadius.cardInner,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLow,
              borderRadius: AppRadius.cardInner,
              border: Border.all(
                color: context.colorScheme.outlineVariant,
                width: 2,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt, size: 20, color: context.colorScheme.onSurfaceVariant),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  'إضافة',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Location display for quote request.
class QuoteLocationSection extends StatelessWidget {
  const QuoteLocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الموقع',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerLow,
            borderRadius: AppRadius.cardInner,
            border: Border.all(color: context.colorScheme.outlineVariant),
          ),
          child: Row(
            children: [
              const Icon(Icons.location_on,
                  size: 16, color: AppColors.primary),
              const SizedBox(width: AppSpacing.sm),
              Text('عبدون، شارع فيصل',
                  style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}
