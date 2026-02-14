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

  Money get _totalPrice => widget.items.fold(
        const Money.zero(),
        (sum, item) => sum + Money(item.price) * item.quantity,
      );

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
                    color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.surfaceContainerLow,
                    borderRadius: AppRadius.pill,
                  ),
                  child: Text(
                    type,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurfaceVariant,
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
                      : Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: AppRadius.pill,
                ),
                child: Text(
                  'أخرى',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _showCustomItemType
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurfaceVariant,
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
        GestureDetector(
          onTap: _canAddItem ? _addCurrentItem : null,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: _canAddItem
                  ? const Color(0xFFEFF6FF)
                  : Colors.transparent,
              borderRadius: AppRadius.cardInner,
              border: Border.all(
                color: _canAddItem
                    ? const Color(0xFF1A73E8)
                    : Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 14,
                  color: _canAddItem
                      ? const Color(0xFF1A73E8)
                      : Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(width: 6),
                Text(
                  'إضافة القطعة للتذكرة',
                  style: TextStyle(
                    fontSize: 12,
                    color: _canAddItem
                        ? const Color(0xFF1A73E8)
                        : Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
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
          GestureDetector(
            onTap: widget.onNext,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1A73E8),
                borderRadius: AppRadius.cardInner,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'مراجعة الطلب (${widget.items.length} قطعة — ${_totalPrice.toFormattedArabic()})',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(
                    Icons.chevron_left_rounded,
                    size: 16,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ],
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
                color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                  color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.surfaceContainerLow,
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
                            isSelected ? Colors.white : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      Money(svc.price).toFormattedArabic(),
                      style: TextStyle(
                        fontSize: 10,
                        color:
                            isSelected ? Colors.white70 : Theme.of(context).colorScheme.onSurfaceVariant,
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
                        isSelected ? AppColors.primary : Theme.of(context).colorScheme.surfaceContainerLow,
                    borderRadius: AppRadius.pill,
                  ),
                  child: Text(
                    val,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurfaceVariant,
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
                  color: showCustom ? AppColors.primary : Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: AppRadius.pill,
                ),
                child: Text(
                  'أخرى',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: showCustom ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.onSurfaceVariant,
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
          color: enabled ? Theme.of(context).colorScheme.surfaceContainerLow : Theme.of(context).colorScheme.surfaceContainerLowest,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18,
          color: enabled ? Theme.of(context).colorScheme.onSurfaceVariant : Theme.of(context).colorScheme.outline,
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
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(
              Icons.delete_outline_rounded,
              size: 14,
              color: Color(0xFFE53935),
            ),
          ),
        ],
      ),
    );
  }
}
