part of 'dropoff_quick_add.dart';

// ═════════════════════════════════════════════════════════════════
// Step 2 — Add Items
// ═════════════════════════════════════════════════════════════════

class _ItemsStep extends StatefulWidget {
  final List<DropoffServiceCategory> serviceCategories;
  final List<DropoffAttribute> attributes;
  final List<String> itemTypes;
  final List<DropoffItem> items;
  final ValueChanged<DropoffItem> onAddItem;
  final ValueChanged<int> onRemoveItem;
  final VoidCallback onNext;

  const _ItemsStep({
    required this.serviceCategories,
    required this.attributes,
    required this.itemTypes,
    required this.items,
    required this.onAddItem,
    required this.onRemoveItem,
    required this.onNext,
  });

  @override
  State<_ItemsStep> createState() => _ItemsStepState();
}

class _ItemsStepState extends State<_ItemsStep> {
  DropoffService? _selectedService;
  String? _selectedItemType;
  bool _showCustomItemType = false;
  final _customItemTypeCtrl = TextEditingController();
  int _quantity = 1;
  final Map<String, String> _selectedAttributes = {};
  final Map<String, TextEditingController> _customAttrCtrls = {};
  final _itemNotesCtrl = TextEditingController();

  @override
  void dispose() {
    _customItemTypeCtrl.dispose();
    _itemNotesCtrl.dispose();
    for (final ctrl in _customAttrCtrls.values) {
      ctrl.dispose();
    }
    super.dispose();
  }

  void _resetCurrentItem() {
    setState(() {
      _selectedService = null;
      _selectedItemType = null;
      _showCustomItemType = false;
      _customItemTypeCtrl.clear();
      _quantity = 1;
      _selectedAttributes.clear();
      _itemNotesCtrl.clear();
    });
  }

  String get _currentItemName {
    if (_showCustomItemType) return _customItemTypeCtrl.text.trim();
    return _selectedItemType ?? '';
  }

  bool get _canAddItem =>
      _selectedService != null && _currentItemName.isNotEmpty;

  void _addCurrentItem() {
    if (!_canAddItem) return;
    final item = DropoffItem(
      id: 'item-${DateTime.now().millisecondsSinceEpoch}',
      name: _currentItemName,
      quantity: _quantity,
      service: _selectedService!.nameAr,
      price: _selectedService!.price,
      attributes: Map.of(_selectedAttributes),
      notes: _itemNotesCtrl.text.trim().isEmpty
          ? null
          : _itemNotesCtrl.text.trim(),
    );
    widget.onAddItem(item);
    _resetCurrentItem();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      children: [
        // ── Service category selection ──
        _FieldLabel('اختر الخدمة'),
        const SizedBox(height: AppSpacing.sm),
        ...widget.serviceCategories.map((cat) => _buildCategoryGroup(cat)),
        const SizedBox(height: AppSpacing.lg),

        // ── Item type selection ──
        _FieldLabel('نوع القطعة'),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            ...widget.itemTypes.map((type) {
              final isSelected = _selectedItemType == type && !_showCustomItemType;
              return GestureDetector(
                onTap: () => setState(() {
                  _selectedItemType = type;
                  _showCustomItemType = false;
                }),
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.grey.shade100,
                    borderRadius: AppRadius.pill,
                  ),
                  child: Text(
                    type,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.grey.shade500,
                    ),
                  ),
                ),
              );
            }),
            // "Other" chip
            GestureDetector(
              onTap: () => setState(() {
                _showCustomItemType = true;
                _selectedItemType = null;
              }),
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: _showCustomItemType
                      ? AppColors.primary
                      : Colors.grey.shade100,
                  borderRadius: AppRadius.pill,
                ),
                child: Text(
                  'أخرى',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _showCustomItemType
                        ? Colors.white
                        : Colors.grey.shade500,
                  ),
                ),
              ),
            ),
          ],
        ),

        // Custom item type input
        if (_showCustomItemType) ...[
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _customItemTypeCtrl,
            onChanged: (_) => setState(() {}),
            decoration: _inputDecoration(hint: 'أدخل نوع القطعة'),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),

        // ── Quantity ──
        _FieldLabel('الكمية'),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            _QuantityButton(
              icon: Icons.remove,
              onTap: _quantity > 1
                  ? () => setState(() => _quantity--)
                  : null,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.lg,
              ),
              child: Text(
                '$_quantity',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _QuantityButton(
              icon: Icons.add,
              onTap: () => setState(() => _quantity++),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Attributes ──
        ...widget.attributes.map((attr) => _buildAttribute(attr)),

        // ── Item notes ──
        _FieldLabel('ملاحظات على القطعة (اختياري)'),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _itemNotesCtrl,
          maxLines: 2,
          decoration: _inputDecoration(hint: 'بقعة على الأمام، مثلاً...'),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Add item button ──
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _canAddItem ? _addCurrentItem : null,
            icon: const Icon(Icons.add, size: 16),
            label: const Text(
              'إضافة القطعة للتذكرة',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(
                color: _canAddItem
                    ? AppColors.primary
                    : Colors.grey.shade300,
              ),
              disabledForegroundColor: Colors.grey.shade400,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.cardInner,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Added items list ──
        if (widget.items.isNotEmpty) ...[
          _FieldLabel('القطع المضافة (${widget.items.length})'),
          const SizedBox(height: AppSpacing.sm),
          ...List.generate(widget.items.length, (i) {
            final item = widget.items[i];
            return _AddedItemCard(
              item: item,
              onRemove: () => widget.onRemoveItem(i),
            );
          }),
          const SizedBox(height: AppSpacing.lg),

          // ── Proceed to review ──
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.cardInner,
                ),
              ),
              child: const Text(
                'مراجعة الطلب',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ],
    );
  }

  Widget _buildCategoryGroup(DropoffServiceCategory cat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(cat.icon, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: AppSpacing.xs),
            Text(
              cat.nameAr,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: cat.services.map((svc) {
            final isSelected = _selectedService?.id == svc.id;
            return GestureDetector(
              onTap: () => setState(() => _selectedService = svc),
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.grey.shade100,
                  borderRadius: AppRadius.pill,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      svc.nameAr,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color:
                            isSelected ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      Money(svc.price).toFormattedArabic(),
                      style: TextStyle(
                        fontSize: 10,
                        color:
                            isSelected ? Colors.white70 : Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }

  Widget _buildAttribute(DropoffAttribute attr) {
    final selected = _selectedAttributes[attr.id];
    final showCustom = selected == '__custom__';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(attr.labelAr),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            ...attr.values.map((val) {
              final isSelected = selected == val;
              return GestureDetector(
                onTap: () => setState(() {
                  _selectedAttributes[attr.id] =
                      _selectedAttributes[attr.id] == val ? '' : val;
                }),
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isSelected ? AppColors.primary : Colors.grey.shade100,
                    borderRadius: AppRadius.pill,
                  ),
                  child: Text(
                    val,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.grey.shade500,
                    ),
                  ),
                ),
              );
            }),
            GestureDetector(
              onTap: () => setState(() {
                _selectedAttributes[attr.id] = '__custom__';
              }),
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: showCustom ? AppColors.primary : Colors.grey.shade100,
                  borderRadius: AppRadius.pill,
                ),
                child: Text(
                  'أخرى',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: showCustom ? Colors.white : Colors.grey.shade500,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (showCustom) ...[
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _customAttrCtrls.putIfAbsent(
              attr.id,
              () => TextEditingController(),
            ),
            onChanged: (val) => setState(() {
              if (val.trim().isNotEmpty) {
                _selectedAttributes[attr.id] = val.trim();
              }
            }),
            decoration: _inputDecoration(hint: 'أدخل ${attr.labelAr}'),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════
// Quantity Button
// ═════════════════════════════════════════════════════════════════

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _QuantityButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: enabled ? Colors.grey.shade100 : Colors.grey.shade50,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18,
          color: enabled ? Colors.grey.shade600 : Colors.grey.shade300,
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════
// Added Item Card
// ═════════════════════════════════════════════════════════════════

class _AddedItemCard extends StatelessWidget {
  final DropoffItem item;
  final VoidCallback onRemove;

  const _AddedItemCard({required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final price = Money(item.price);

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4), // green-50
        border: Border.all(color: const Color(0xFFBBF7D0)),
        borderRadius: AppRadius.cardInner,
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            size: 14,
            color: AppColors.success,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.name} × ${item.quantity}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '${item.service} · ${price.toFormattedArabic()}',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: Colors.grey.shade500,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close_rounded,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
