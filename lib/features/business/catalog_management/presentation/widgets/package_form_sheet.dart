import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

void showPackageFormSheet(
  BuildContext context, {
  Map<String, dynamic>? package,
}) {
  showAppSheet(
    context,
    builder: (_) => _PackageFormContent(
      package: package,
    ),
  );
}

class _PackageFormContent extends StatefulWidget {
  final Map<String, dynamic>? package;

  const _PackageFormContent({
    this.package,
  });

  @override
  State<_PackageFormContent> createState() => _PackageFormContentState();
}

class _PackageFormContentState extends State<_PackageFormContent> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _priceCtrl;
  late final TextEditingController _creditsCtrl;

  bool _hasCredits = true;
  bool _hasEndDate = true;
  String _creditLabel = '\u062a\u0648\u0635\u064a\u0644\u0629';
  int _validityMonths = 3;

  bool get _isEditing => widget.package != null;

  String get _model {
    if (_hasCredits && _hasEndDate) return 'visits_and_date';
    if (_hasCredits) return 'visits_only';
    if (_hasEndDate) return 'date_only';
    return 'visits_only';
  }

  static const _creditLabels = [
    '\u062a\u0648\u0635\u064a\u0644\u0629',
    '\u0637\u0644\u0628',
    '\u0632\u064a\u0627\u0631\u0629',
    '\u062c\u0644\u0633\u0629',
    '\u0643\u0648\u0628',
    '\u0648\u062c\u0628\u0629',
  ];

  static const _monthOptions = [1, 2, 3, 6, 12];

  @override
  void initState() {
    super.initState();
    final p = widget.package;
    _nameCtrl = TextEditingController(text: p?['name'] as String? ?? '');
    _descCtrl = TextEditingController(text: p?['description'] as String? ?? '');
    _priceCtrl = TextEditingController(
      text: p != null
          ? ((p['price'] as int) / 100).toStringAsFixed(2)
          : '',
    );
    _creditsCtrl = TextEditingController(
      text: p?['credits']?.toString() ?? '',
    );
    if (p != null) {
      final model = p['model'] as String? ?? 'visits_and_date';
      _hasCredits = model != 'date_only';
      _hasEndDate = model != 'visits_only';
      _creditLabel =
          p['label'] as String? ?? '\u062a\u0648\u0635\u064a\u0644\u0629';
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    _creditsCtrl.dispose();
    super.dispose();
  }

  void _onCreditsToggled(bool value) {
    setState(() {
      _hasCredits = value;
      if (!_hasCredits && !_hasEndDate) {
        _hasCredits = true;
      }
    });
  }

  void _onEndDateToggled(bool value) {
    setState(() {
      _hasEndDate = value;
      if (!_hasCredits && !_hasEndDate) {
        _hasCredits = true;
      }
    });
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drag handle
        Center(
          child: Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(
              top: AppSpacing.sm,
              bottom: AppSpacing.lg,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),

        // Title
        Text(
          _isEditing
              ? context.l10n.pkgEditTitle
              : context.l10n.pkgAddTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xl),
        Flexible(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            children: [
              // Name
              TextField(
            controller: _nameCtrl,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              labelText: context.l10n.pkgName,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Description
          TextField(
            controller: _descCtrl,
            textDirection: TextDirection.rtl,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: context.l10n.pkgDescription,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Price
          TextField(
            controller: _priceCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
              labelText: context.l10n.pkgPriceJod,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Subscription model section title
          Text(
            context.l10n.pkgSubscriptionModel,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Credits toggle
          SwitchListTile(
            value: _hasCredits,
            onChanged: _onCreditsToggled,
            title: Text(
              context.l10n.pkgLimitedCredits,
              style: const TextStyle(fontSize: 14),
            ),
            activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
            thumbColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.selected)
                  ? AppColors.primary
                  : null,
            ),
            contentPadding: EdgeInsets.zero,
          ),

          // End date toggle
          SwitchListTile(
            value: _hasEndDate,
            onChanged: _onEndDateToggled,
            title: Text(
              context.l10n.pkgEndDate,
              style: const TextStyle(fontSize: 14),
            ),
            activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
            thumbColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.selected)
                  ? AppColors.primary
                  : null,
            ),
            contentPadding: EdgeInsets.zero,
          ),

          const SizedBox(height: AppSpacing.md),

          // Credits count + label chips (when credits is on)
          if (_hasCredits) ...[
            TextField(
              controller: _creditsCtrl,
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                labelText: context.l10n.pkgCreditsCount,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: _creditLabels.map((label) {
                final isSelected = _creditLabel == label;
                return GestureDetector(
                  onTap: () => setState(() => _creditLabel = label),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : Theme.of(context).colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // Validity months
          if (_hasEndDate) ...[
            Text(
              context.l10n.pkgDurationMonths,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: _monthOptions.map((m) {
                final isSelected = _validityMonths == m;
                return GestureDetector(
                  onTap: () => setState(() => _validityMonths = m),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : Theme.of(context).colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$m',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // Model info banner
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.15),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    _modelDescription,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Icon(
                  Icons.info_outline,
                  size: 16,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Save button
          btn.Button(
            onPressed: () {
              _showToast(context.l10n.pkgSaveSoon);
            },
            label: _isEditing
                ? context.l10n.pkgSaveChanges
                : context.l10n.pkgAddPackage,
            size: btn.ButtonSize.large,
            expand: true,
          ),

          // Delete button (edit mode only)
          if (_isEditing) ...[
            const SizedBox(height: AppSpacing.md),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showToast(context.l10n.pkgDeleteSoon);
                },
                child: Text(
                  context.l10n.pkgDeletePackage,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.error,
                  ),
                ),
              ),
            ),
          ],

              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ],
    );
  }

  String get _modelDescription => switch (_model) {
        'visits_and_date' => context.l10n.pkgModelVisitsAndDate,
        'visits_only' => context.l10n.pkgModelVisitsOnly,
        'date_only' => context.l10n.pkgModelDateOnly,
        _ => '',
      };
}
