import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/domain/entities/customer_request.dart';
import 'package:honak/features/requests/presentation/widgets/edit_order_chrome.dart';
import 'package:honak/features/requests/presentation/widgets/edit_order_sections.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/core/extensions/context_ext.dart';

/// Bottom sheet for editing an order before business accepts.
class EditOrderSheet extends StatefulWidget {
  final CustomerRequest request;
  final void Function(List<OrderLineItem> updatedItems, String? updatedNote)
      onSave;

  const EditOrderSheet({
    super.key,
    required this.request,
    required this.onSave,
  });

  @override
  State<EditOrderSheet> createState() => _EditOrderSheetState();
}

class _EditOrderSheetState extends State<EditOrderSheet> {
  late List<EditableItem> _items;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _items = widget.request.items
        .map((item) => EditableItem(
              original: item,
              quantity: item.quantity,
              removed: false,
            ))
        .toList();
    _noteController = TextEditingController(text: widget.request.note ?? '');
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  List<EditableItem> get _activeItems =>
      _items.where((i) => !i.removed).toList();

  Money get _newTotal => _activeItems.fold(
        const Money.zero(),
        (sum, item) =>
            sum + (item.original.price ?? const Money.zero()) * item.quantity,
      );

  Money get _originalTotal => widget.request.total ?? const Money.zero();

  bool get _hasChanges {
    if (_noteController.text != (widget.request.note ?? '')) return true;
    for (final item in _items) {
      if (item.removed || item.quantity != item.original.quantity) return true;
    }
    return false;
  }

  void _updateQty(int index, int delta) {
    setState(() {
      final newQty = _items[index].quantity + delta;
      if (newQty >= 1) {
        _items[index] = _items[index].copyWith(quantity: newQty);
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items[index] = _items[index].copyWith(removed: true);
    });
  }

  void _handleSave() {
    final updatedItems = _activeItems
        .map((item) => item.original.copyWith(quantity: item.quantity))
        .toList();
    final note = _noteController.text.trim();
    widget.onSave(updatedItems, note.isEmpty ? null : note);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final activeItems = _activeItems;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLowest,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppRadius.xxl)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const EditOrderDragHandle(),
          EditOrderHeader(
            requestId: widget.request.id,
            businessName: widget.request.businessName,
            onClose: () => Navigator.pop(context),
          ),
          Divider(height: 1, color: context.colorScheme.outlineVariant),
          Flexible(
            child: ListView(
              padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
              shrinkWrap: true,
              children: [
                Text('المنتجات', style: textTheme.titleSmall),
                const SizedBox(height: AppSpacing.md),
                if (activeItems.isEmpty)
                  const EditOrderEmptyWarning()
                else ...[
                  ...activeItems.map((item) {
                    final idx = _items.indexOf(item);
                    return EditOrderItemRow(
                      item: item,
                      onRemove: () => _removeItem(idx),
                      onIncrement: () => _updateQty(idx, 1),
                      onDecrement: () => _updateQty(idx, -1),
                    );
                  }),
                  const SizedBox(height: AppSpacing.sm),
                  EditOrderTotal(
                    originalTotal: _originalTotal,
                    newTotal: _newTotal,
                  ),
                ],
                EditOrderChangesDiff(items: _items),
                _buildNoteField(textTheme),
                const EditOrderInfoNotice(),
              ],
            ),
          ),
          EditOrderActions(
            canSave: activeItems.isNotEmpty && _hasChanges,
            onCancel: () => Navigator.pop(context),
            onSave: _handleSave,
          ),
        ],
      ),
    );
  }

  Widget _buildNoteField(TextTheme textTheme) => Padding(
        padding: const EdgeInsets.only(top: AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ملاحظات', style: textTheme.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _noteController,
              maxLines: 3,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: 'أضف ملاحظة للمتجر...',
                hintStyle: textTheme.bodySmall
                    ?.copyWith(color: context.colorScheme.onSurfaceVariant),
                filled: true,
                fillColor: context.colorScheme.surface,
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
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                contentPadding:
                    const EdgeInsetsDirectional.all(AppSpacing.md),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ],
        ),
      );
}
