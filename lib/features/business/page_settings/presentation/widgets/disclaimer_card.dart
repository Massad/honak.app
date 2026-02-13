import 'package:flutter/material.dart';

import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/page_settings.dart';

class DisclaimerCard extends StatelessWidget {
  final SafetyDisclaimer disclaimer;
  final ValueChanged<bool> onToggle;
  final ValueChanged<String> onTextChanged;
  final ValueChanged<String> onTitleChanged;
  final VoidCallback onRemove;

  const DisclaimerCard({
    super.key,
    required this.disclaimer,
    required this.onToggle,
    required this.onTextChanged,
    required this.onTitleChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onRemove,
                icon: Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: AppColors.error,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: AppSpacing.sm),
              Switch(
                value: disclaimer.isActive,
                onChanged: onToggle,
                activeThumbColor: AppColors.primary,
              ),
              const Spacer(),
              DisclaimerTypeBadge(type: disclaimer.type),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: TextEditingController(
                text: disclaimer.title),
            textAlign: TextAlign.end,
            onChanged: onTitleChanged,
            decoration: InputDecoration(
              hintText: 'عنوان التنبيه',
              hintStyle: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade400,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: Colors.grey.shade200),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller:
                TextEditingController(text: disclaimer.text),
            textAlign: TextAlign.end,
            onChanged: onTextChanged,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'نص التنبيه',
              hintStyle: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade400,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: Colors.grey.shade200),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shared badge for disclaimer type (safety/responsibility/policy).
class DisclaimerTypeBadge extends StatelessWidget {
  final String type;

  const DisclaimerTypeBadge({super.key, required this.type});

  Color get _color => switch (type) {
        'safety' => AppColors.warning,
        'responsibility' => AppColors.error,
        _ => AppColors.primary,
      };

  String get _label => switch (type) {
        'safety' => 'سلامة',
        'responsibility' => 'مسؤولية',
        _ => 'سياسة',
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: _color,
        ),
      ),
    );
  }
}
