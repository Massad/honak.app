import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/directory_floor.dart';

/// Floor plan upload placeholder — per-floor upload UI mockup.
class VenueMapsOverlay extends StatelessWidget {
  final List<DirectoryFloor> floors;
  final VoidCallback onClose;

  const VenueMapsOverlay({
    super.key,
    required this.floors,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: onClose,
        ),
        title: const Text(
          'خرائط الطوابق',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: floors.isEmpty
          ? Center(
              child: Text(
                'أضف طوابق أولاً',
                style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: floors.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (_, i) {
                final floor = floors[i];
                return Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.card,
                    border: Border.all(
                      color: context.colorScheme.outlineVariant,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        floor.label ?? floor.name,
                        style: context.textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      // Upload placeholder
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerLowest,
                          borderRadius: AppRadius.cardInner,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outlineVariant,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              size: 32,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'رفع خريطة الطابق',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'PNG, JPG — حتى 5 MB',
                              style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.08),
                            borderRadius: AppRadius.pill,
                          ),
                          child: const Text(
                            'قريباً',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
