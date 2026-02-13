import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/package_form_sheet.dart';

class PackageManagerSection extends StatelessWidget {
  const PackageManagerSection({super.key});

  static const _mockPackages = [
    {
      'name': '\u0628\u0627\u0642\u0629 10 \u0642\u0648\u0627\u0631\u064a\u0631',
      'price': 15000,
      'credits': 10,
      'label': '\u062a\u0648\u0635\u064a\u0644\u0629',
      'model': 'visits_and_date',
      'active': true,
    },
    {
      'name': '\u0628\u0627\u0642\u0629 20 \u0642\u0627\u0631\u0648\u0631\u0629',
      'price': 25000,
      'credits': 20,
      'label': '\u062a\u0648\u0635\u064a\u0644\u0629',
      'model': 'visits_only',
      'active': true,
    },
  ];

  static String _modelLabel(String model) => switch (model) {
        'visits_and_date' =>
          '\u0632\u064a\u0627\u0631\u0627\u062a + \u062a\u0627\u0631\u064a\u062e',
        'visits_only' =>
          '\u0639\u062f\u062f \u0632\u064a\u0627\u0631\u0627\u062a',
        'date_only' =>
          '\u0627\u0634\u062a\u0631\u0627\u0643 \u0632\u0645\u0646\u064a',
        _ => model,
      };

  void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg, AppSpacing.xl, AppSpacing.lg, AppSpacing.sm,
          ),
          child: Row(
            children: [
              Text(
                '\u0627\u0644\u0628\u0627\u0642\u0627\u062a \u0648\u0627\u0644\u0627\u0634\u062a\u0631\u0627\u0643\u0627\u062a',
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => showPackageFormSheet(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 14, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        '\u0625\u0636\u0627\u0641\u0629 \u0628\u0627\u0642\u0629',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Package cards
        if (_mockPackages.isEmpty)
          _buildEmptyState(context)
        else
          ...(_mockPackages.map(
            (pkg) => _buildPackageCard(context, pkg),
          )),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.md,
      ),
      child: GestureDetector(
        onTap: () => showPackageFormSheet(context),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.grey.shade300,
              style: BorderStyle.solid,
            ),
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.grey.shade300,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.card_membership_outlined,
                size: 28,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '\u0625\u0636\u0627\u0641\u0629 \u0628\u0627\u0642\u0629 \u0623\u0648 \u0627\u0634\u062a\u0631\u0627\u0643 \u0644\u0639\u0645\u0644\u0627\u0626\u0643',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageCard(
    BuildContext context,
    Map<String, dynamic> pkg,
  ) {
    final name = pkg['name'] as String;
    final price = pkg['price'] as int;
    final credits = pkg['credits'] as int;
    final label = pkg['label'] as String;
    final model = pkg['model'] as String;
    final active = pkg['active'] as bool;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg, AppSpacing.xs, AppSpacing.lg, AppSpacing.sm,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Edit + toggle buttons
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => showPackageFormSheet(context, package: pkg),
                  child: Icon(
                    Icons.edit_outlined,
                    size: 16,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                GestureDetector(
                  onTap: () => _showToast(
                    context,
                    '\u0642\u0631\u064a\u0628\u0627\u064b \u2014 \u062a\u063a\u064a\u064a\u0631 \u0627\u0644\u062d\u0627\u0644\u0629',
                  ),
                  child: Icon(
                    active
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 16,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.md),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Active badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: active
                              ? AppColors.success.withValues(alpha: 0.1)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          active
                              ? '\u0641\u0639\u0651\u0627\u0644'
                              : '\u0645\u062e\u0641\u064a',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: active
                                ? AppColors.success
                                : Colors.grey.shade500,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      // Name
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Model label
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _modelLabel(model),
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      // Credits
                      Text(
                        '$credits $label',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      // Price
                      Text(
                        '${(price / 100).toStringAsFixed(2)} \u062f.\u0623',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Icon
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.card_membership_outlined,
                size: 18,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
