import 'package:flutter/material.dart';

import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';

void showPackageFormSheet(
  BuildContext context, {
  Map<String, dynamic>? package,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, controller) => _PackageFormContent(
        scrollController: controller,
        package: package,
      ),
    ),
  );
}

class _PackageFormContent extends StatefulWidget {
  final ScrollController scrollController;
  final Map<String, dynamic>? package;

  const _PackageFormContent({
    required this.scrollController,
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
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ListView(
        controller: widget.scrollController,
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppSpacing.lg),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Title
          Text(
            _isEditing
                ? '\u062a\u0639\u062f\u064a\u0644 \u0627\u0644\u0628\u0627\u0642\u0629'
                : '\u0625\u0636\u0627\u0641\u0629 \u0628\u0627\u0642\u0629',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),

          // Name
          TextField(
            controller: _nameCtrl,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              labelText:
                  '\u0627\u0633\u0645 \u0627\u0644\u0628\u0627\u0642\u0629',
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
              labelText: '\u0627\u0644\u0648\u0635\u0641',
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
              labelText:
                  '\u0627\u0644\u0633\u0639\u0631 (\u062f.\u0623)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Subscription model section title
          Text(
            '\u0646\u0645\u0648\u0630\u062c \u0627\u0644\u0627\u0634\u062a\u0631\u0627\u0643',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Credits toggle
          SwitchListTile(
            value: _hasCredits,
            onChanged: _onCreditsToggled,
            title: const Text(
              '\u0631\u0635\u064a\u062f \u0645\u062d\u062f\u062f',
              style: TextStyle(fontSize: 14),
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
            title: const Text(
              '\u062a\u0627\u0631\u064a\u062e \u0627\u0646\u062a\u0647\u0627\u0621',
              style: TextStyle(fontSize: 14),
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
                labelText:
                    '\u0639\u062f\u062f \u0627\u0644\u0631\u0635\u064a\u062f',
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
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.grey.shade600,
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
              '\u0645\u062f\u0629 \u0627\u0644\u0627\u0634\u062a\u0631\u0627\u0643 (\u0623\u0634\u0647\u0631)',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
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
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$m',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.grey.shade600,
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
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showToast(
                  '\u0642\u0631\u064a\u0628\u0627\u064b \u2014 \u062d\u0641\u0638 \u0627\u0644\u0628\u0627\u0642\u0629',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _isEditing
                    ? '\u062d\u0641\u0638 \u0627\u0644\u062a\u0639\u062f\u064a\u0644\u0627\u062a'
                    : '\u0625\u0636\u0627\u0641\u0629 \u0627\u0644\u0628\u0627\u0642\u0629',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Delete button (edit mode only)
          if (_isEditing) ...[
            const SizedBox(height: AppSpacing.md),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showToast(
                    '\u0642\u0631\u064a\u0628\u0627\u064b \u2014 \u062d\u0630\u0641 \u0627\u0644\u0628\u0627\u0642\u0629',
                  );
                },
                child: const Text(
                  '\u062d\u0630\u0641 \u0627\u0644\u0628\u0627\u0642\u0629',
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
    );
  }

  String get _modelDescription => switch (_model) {
        'visits_and_date' =>
          '\u064a\u0646\u062a\u0647\u064a \u0627\u0644\u0627\u0634\u062a\u0631\u0627\u0643 \u0639\u0646\u062f \u0646\u0641\u0627\u062f \u0627\u0644\u0631\u0635\u064a\u062f \u0623\u0648 \u0639\u0646\u062f \u0627\u0646\u062a\u0647\u0627\u0621 \u0627\u0644\u0645\u062f\u0629 \u2014 \u0623\u064a\u0647\u0645\u0627 \u0623\u0642\u0631\u0628',
        'visits_only' =>
          '\u064a\u0646\u062a\u0647\u064a \u0627\u0644\u0627\u0634\u062a\u0631\u0627\u0643 \u0641\u0642\u0637 \u0639\u0646\u062f \u0646\u0641\u0627\u062f \u0627\u0644\u0631\u0635\u064a\u062f \u2014 \u0628\u062f\u0648\u0646 \u062a\u0627\u0631\u064a\u062e \u0627\u0646\u062a\u0647\u0627\u0621',
        'date_only' =>
          '\u0627\u0634\u062a\u0631\u0627\u0643 \u0632\u0645\u0646\u064a \u2014 \u0627\u0644\u0639\u0645\u064a\u0644 \u064a\u0633\u062a\u062e\u062f\u0645 \u0628\u0644\u0627 \u062d\u062f\u0648\u062f \u062e\u0644\u0627\u0644 \u0627\u0644\u0645\u062f\u0629',
        _ => '',
      };
}
