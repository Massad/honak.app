part of 'queue_quick_add.dart';

// ═════════════════════════════════════════════════════════════════
// Add-on option (not an entity — local UI data for the sheet)
// ═════════════════════════════════════════════════════════════════

class _AddOnOption {
  final String name;
  final int priceCents;

  const _AddOnOption(this.name, this.priceCents);
}

const _kVehicleTypes = [
  'سيدان',
  'SUV',
  'هاتشباك',
  'بيك أب',
  'شاحنة صغيرة',
  'فان',
];

const _kVehicleColors = [
  'أبيض',
  'أسود',
  'فضي',
  'رمادي',
  'أحمر',
  'أزرق',
  'كحلي',
  'بيج',
  'أخضر',
];

const _kAddOns = [
  _AddOnOption('تنظيف جلد المقاعد', 300),
  _AddOnOption('تلميع الإطارات', 150),
  _AddOnOption('إزالة الشعر (حيوانات أليفة)', 200),
  _AddOnOption('معطر فاخر', 100),
  _AddOnOption('تنظيف الصندوق', 200),
];

// ═════════════════════════════════════════════════════════════════
// Step 2 — Customer Details
// ═════════════════════════════════════════════════════════════════

class _DetailsStep extends StatefulWidget {
  final ServicePackage package;
  final VoidCallback onChangePackage;
  final ValueChanged<QueueEntry> onSubmit;

  const _DetailsStep({
    required this.package,
    required this.onChangePackage,
    required this.onSubmit,
  });

  @override
  State<_DetailsStep> createState() => _DetailsStepState();
}

class _DetailsStepState extends State<_DetailsStep> {
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _plateCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  String? _vehicleType;
  String? _vehicleColor;
  final Set<int> _selectedAddOns = {};

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _plateCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  bool get _canSubmit => _nameCtrl.text.trim().isNotEmpty;

  Money get _totalPrice {
    var total = Money(widget.package.price);
    for (final i in _selectedAddOns) {
      total = total + Money(_kAddOns[i].priceCents);
    }
    return total;
  }

  List<QueueAddOn> get _addOnEntities => _selectedAddOns
      .map((i) => QueueAddOn(
            name: _kAddOns[i].name,
            price: _kAddOns[i].priceCents,
          ))
      .toList();

  void _submit() {
    if (!_canSubmit) return;
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final entry = QueueEntry(
      id: 'q-${DateTime.now().millisecondsSinceEpoch}',
      position: 0, // caller assigns actual position
      status: QueueStatus.waiting,
      source: QueueSource.walkIn,
      customerName: _nameCtrl.text.trim(),
      customerPhone:
          _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
      vehicleType: _vehicleType,
      vehicleColor: _vehicleColor,
      plateNumber:
          _plateCtrl.text.trim().isEmpty ? null : _plateCtrl.text.trim(),
      packageId: widget.package.id,
      packageName: widget.package.nameAr,
      packagePrice: widget.package.price,
      addOns: _addOnEntities,
      totalPrice: _totalPrice.cents,
      estimatedDurationMin: widget.package.durationMin,
      checkedInAt: now,
    );
    widget.onSubmit(entry);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      children: [
        // ── Selected package summary ──
        _PackageSummary(
          package: widget.package,
          onChange: widget.onChangePackage,
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Customer name (required) ──
        _FieldLabel('اسم العميل *'),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _nameCtrl,
          onChanged: (_) => setState(() {}),
          decoration: _inputDecoration(
            hint: 'مثال: أحمد',
            prefixIcon: Icons.person_outline,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Phone (optional, LTR) ──
        _FieldLabel('رقم الهاتف (اختياري)'),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _phoneCtrl,
          keyboardType: TextInputType.phone,
          textDirection: TextDirection.ltr,
          decoration: _inputDecoration(
            hint: '07XXXXXXXX',
            prefixIcon: Icons.phone_outlined,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Vehicle type chips ──
        _FieldLabel('نوع السيارة'),
        const SizedBox(height: AppSpacing.sm),
        _ChipGroup(
          items: _kVehicleTypes,
          selected: _vehicleType,
          onSelected: (v) => setState(
            () => _vehicleType = _vehicleType == v ? null : v,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Vehicle color chips ──
        _FieldLabel('لون السيارة'),
        const SizedBox(height: AppSpacing.sm),
        _ChipGroup(
          items: _kVehicleColors,
          selected: _vehicleColor,
          onSelected: (v) => setState(
            () => _vehicleColor = _vehicleColor == v ? null : v,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Plate number (optional, LTR) ──
        _FieldLabel('رقم اللوحة (اختياري)'),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _plateCtrl,
          textDirection: TextDirection.ltr,
          decoration: _inputDecoration(hint: '42-12345'),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Add-ons ──
        _FieldLabel('إضافات'),
        const SizedBox(height: AppSpacing.sm),
        ...List.generate(_kAddOns.length, (i) {
          final addon = _kAddOns[i];
          final selected = _selectedAddOns.contains(i);
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: GestureDetector(
              onTap: () => setState(() {
                selected
                    ? _selectedAddOns.remove(i)
                    : _selectedAddOns.add(i);
              }),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        selected ? AppColors.primary : Colors.grey.shade200,
                  ),
                  color: selected
                      ? const Color(0xFFEFF6FF)
                      : null,
                  borderRadius: AppRadius.cardInner,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color:
                            selected ? AppColors.primary : Colors.transparent,
                        border: Border.all(
                          color: selected
                              ? AppColors.primary
                              : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: selected
                          ? const Icon(Icons.check, size: 14,
                              color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        addon.name,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Text(
                      '+${Money(addon.priceCents).toFormattedArabic()}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: AppSpacing.sm),

        // ── Notes ──
        _FieldLabel('ملاحظات (اختياري)'),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _notesCtrl,
          maxLines: 2,
          decoration: _inputDecoration(hint: 'أي ملاحظات خاصة...'),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Total + Submit ──
        const Divider(),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Text(
              'الإجمالي',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
            const Spacer(),
            Text(
              _totalPrice.toFormattedArabic(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _canSubmit ? _submit : null,
            icon: const Icon(Icons.add, size: 18),
            label: const Text(
              'إضافة للدور',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.shade300,
              disabledForegroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.cardInner,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

// Shared widgets (_PackageCard, _PackageSummary, _FieldLabel, _ChipGroup,
// _inputDecoration) are in queue_quick_add_widgets.dart
