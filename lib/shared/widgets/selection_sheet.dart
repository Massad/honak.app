import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// A single selectable option for [SelectionSheet].
class SelectionOption<T> {
  final T value;
  final String label;
  final IconData? icon;

  const SelectionOption({
    required this.value,
    required this.label,
    this.icon,
  });
}

/// Shows a modal bottom sheet with a list of selectable options.
///
/// If [options] has more than [searchThreshold] items a search bar appears.
/// Returns the selected value or `null` if dismissed.
Future<T?> showSelectionSheet<T>({
  required BuildContext context,
  required String title,
  required List<SelectionOption<T>> options,
  T? selectedValue,
  int searchThreshold = 8,
}) {
  return showAppSheet<T>(
    context,
    maxHeightFraction: 0.7,
    builder: (_) => _SelectionSheetBody<T>(
      title: title,
      options: options,
      selectedValue: selectedValue,
      showSearch: options.length > searchThreshold,
    ),
  );
}

class _SelectionSheetBody<T> extends StatefulWidget {
  final String title;
  final List<SelectionOption<T>> options;
  final T? selectedValue;
  final bool showSearch;

  const _SelectionSheetBody({
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.showSearch,
  });

  @override
  State<_SelectionSheetBody<T>> createState() => _SelectionSheetBodyState<T>();
}

class _SelectionSheetBodyState<T> extends State<_SelectionSheetBody<T>> {
  late List<SelectionOption<T>> _filtered;
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtered = widget.options;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filtered = widget.options;
      } else {
        _filtered = widget.options
            .where((o) => o.label.contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Handle bar
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: AppSpacing.sm),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: AppRadius.pill,
            ),
          ),
        ),

        // Title row
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            0,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close,
                  size: 22,
                  color: Colors.grey.shade500,
                ),
              ),
              const Spacer(),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),

        // Search bar
        if (widget.showSearch)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              0,
            ),
            child: TextField(
              controller: _searchCtrl,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'بحث...',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade400,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.grey.shade400,
                ),
                isDense: true,
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                border: OutlineInputBorder(
                  borderRadius: AppRadius.button,
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppRadius.button,
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppRadius.button,
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
          ),

        const SizedBox(height: AppSpacing.sm),

        // Options list
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            itemCount: _filtered.length,
            itemBuilder: (context, i) {
              final option = _filtered[i];
              final isSelected = option.value == widget.selectedValue;

              return InkWell(
                onTap: () => Navigator.pop(context, option.value),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.08)
                      : null,
                  child: Row(
                    children: [
                      if (isSelected)
                        const Icon(
                          Icons.check,
                          size: 18,
                          color: AppColors.primary,
                        )
                      else
                        const SizedBox(width: 18),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            option.label,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.grey.shade800,
                            ),
                          ),
                        ),
                      ),
                      if (option.icon != null) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Icon(
                          option.icon,
                          size: 18,
                          color: isSelected
                              ? AppColors.primary
                              : Colors.grey.shade400,
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
