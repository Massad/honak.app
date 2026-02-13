import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/entities/selected_item.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/item_selection/item_option_selector.dart';

/// Step 2 of the item picker: configure options + quantity + confirm.
///
/// Shows item header (image + name + base price), option groups,
/// quantity stepper, computed total price, and confirm button.
class ItemConfigurationStep extends StatefulWidget {
  final Item item;
  final bool showQuantity;
  final String confirmLabel;
  final void Function(SelectedItem) onConfirm;
  final VoidCallback onBack;

  const ItemConfigurationStep({
    super.key,
    required this.item,
    this.showQuantity = true,
    this.confirmLabel = 'تأكيد',
    required this.onConfirm,
    required this.onBack,
  });

  @override
  State<ItemConfigurationStep> createState() => _ItemConfigurationStepState();
}

class _ItemConfigurationStepState extends State<ItemConfigurationStep> {
  final Map<String, Set<String>> _selectedOptions = {};
  final Map<String, String> _textInputs = {};
  int _quantity = 1;

  int get _modifierSum {
    int sum = 0;
    for (final group in widget.item.optionGroups) {
      final selected = _selectedOptions[group.id];
      if (selected == null) continue;
      for (final option in group.options) {
        if (selected.contains(option.id)) {
          sum += option.priceModifier;
        }
      }
    }
    return sum;
  }

  int get _unitPrice => widget.item.price.cents + _modifierSum;
  int get _totalPrice => _unitPrice * _quantity;

  bool get _isComplete {
    for (final group in widget.item.optionGroups) {
      if (!group.isRequired) continue;
      if (group.type == 'text_input') {
        final text = _textInputs[group.id];
        if (text == null || text.isEmpty) return false;
      } else {
        final selected = _selectedOptions[group.id];
        if (selected == null || selected.isEmpty) return false;
      }
    }
    return true;
  }

  void _handleOptionSelected(String groupId, String optionId, String type) {
    setState(() {
      if (type == 'single_select') {
        _selectedOptions[groupId] = {optionId};
      } else {
        final current = _selectedOptions[groupId] ?? {};
        if (current.contains(optionId)) {
          current.remove(optionId);
        } else {
          current.add(optionId);
        }
        _selectedOptions[groupId] = current;
      }
    });
  }

  void _handleTextInput(String groupId, String value) {
    setState(() {
      _textInputs[groupId] = value;
    });
  }

  SelectedItem _buildSelectedItem() {
    final selectedOpts = <String, List<SelectedOption>>{};
    for (final group in widget.item.optionGroups) {
      final ids = _selectedOptions[group.id];
      if (ids == null || ids.isEmpty) continue;
      selectedOpts[group.id] = group.options
          .where((o) => ids.contains(o.id))
          .map((o) => SelectedOption.fromItemOption(o))
          .toList();
    }

    return SelectedItem(
      itemId: widget.item.id,
      name: widget.item.nameAr,
      image: widget.item.images.isNotEmpty ? widget.item.images.first : null,
      basePriceCents: widget.item.price.cents,
      selectedOptions: selectedOpts,
      textInputs: Map.from(_textInputs),
      quantity: _quantity,
      categoryName: widget.item.categoryName,
      description: widget.item.descriptionAr,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Back arrow + item header
        _buildHeader(),
        const Divider(height: 1, color: AppColors.divider),

        // Scrollable content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Item info
                _buildItemInfo(),
                if (widget.item.optionGroups.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.lg),
                  ItemOptionSelector(
                    optionGroups: widget.item.optionGroups,
                    selectedOptions: _selectedOptions,
                    textInputs: _textInputs,
                    onOptionSelected: _handleOptionSelected,
                    onTextInput: _handleTextInput,
                    compact: true,
                  ),
                ],
                if (widget.showQuantity) ...[
                  const SizedBox(height: AppSpacing.md),
                  _buildQuantityStepper(),
                ],
              ],
            ),
          ),
        ),

        // Bottom: total + confirm
        _buildBottomBar(),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.sm,
        end: AppSpacing.lg,
        top: AppSpacing.sm,
        bottom: AppSpacing.sm,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Directionality(
              textDirection: TextDirection.ltr,
              child: Icon(Icons.arrow_forward_ios, size: 18),
            ),
            onPressed: widget.onBack,
            color: AppColors.textSecondary,
            visualDensity: VisualDensity.compact,
          ),
          Expanded(
            child: Text(
              widget.item.nameAr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.item.images.isNotEmpty) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AppImage(
              url: widget.item.images.first,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              placeholderIcon: Icons.image_outlined,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.nameAr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              if (widget.item.descriptionAr != null) ...[
                const SizedBox(height: 4),
                Text(
                  widget.item.descriptionAr!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 6),
              Text(
                Money(widget.item.price.cents).toFormattedArabic(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityStepper() {
    return Row(
      children: [
        const Text(
          'الكمية',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.divider),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StepperButton(
                icon: Icons.remove,
                onTap: _quantity > 1
                    ? () => setState(() => _quantity--)
                    : null,
              ),
              SizedBox(
                width: 40,
                child: Center(
                  child: Text(
                    '$_quantity',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              _StepperButton(
                icon: Icons.add,
                onTap: () => setState(() => _quantity++),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md + MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.divider, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'المجموع',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                Money(_totalPrice).toFormattedArabic(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: FilledButton(
              onPressed: _isComplete
                  ? () => widget.onConfirm(_buildSelectedItem())
                  : null,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                widget.confirmLabel,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _StepperButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          size: 18,
          color: onTap != null ? AppColors.textPrimary : AppColors.divider,
        ),
      ),
    );
  }
}
