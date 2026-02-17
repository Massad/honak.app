part of 'queue_quick_add.dart';

// ═════════════════════════════════════════════════════════════════
// Add-on option (not an entity — local UI data for the sheet)
// ═════════════════════════════════════════════════════════════════

class _AddOnOption {
  final String Function(BuildContext) nameBuilder;
  final int priceCents;

  const _AddOnOption(this.nameBuilder, this.priceCents);

  String name(BuildContext context) => nameBuilder(context);
}

List<String> _vehicleTypes(BuildContext context) => [
  context.l10n.queueVehicleSedan,
  context.l10n.queueVehicleSuv,
  context.l10n.queueVehicleHatchback,
  context.l10n.queueVehiclePickup,
  context.l10n.queueVehicleMiniTruck,
  context.l10n.queueVehicleVan,
];

List<String> _vehicleColors(BuildContext context) => [
  context.l10n.queueColorWhite,
  context.l10n.queueColorBlack,
  context.l10n.queueColorSilver,
  context.l10n.queueColorGray,
  context.l10n.queueColorRed,
  context.l10n.queueColorBlue,
  context.l10n.queueColorNavy,
  context.l10n.queueColorBeige,
  context.l10n.queueColorGreen,
];

List<_AddOnOption> _addOns() => [
  _AddOnOption((c) => c.l10n.queueAddOnLeatherCleaning, 300),
  _AddOnOption((c) => c.l10n.queueAddOnTirePolish, 150),
  _AddOnOption((c) => c.l10n.queueAddOnPetHairRemoval, 200),
  _AddOnOption((c) => c.l10n.queueAddOnPremiumFragrance, 100),
  _AddOnOption((c) => c.l10n.queueAddOnTrunkCleaning, 200),
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

const _kDiscountReasonOther = '__other__';

class _DiscountReasonOption {
  final String key;
  final String Function(BuildContext) label;

  const _DiscountReasonOption(this.key, this.label);
}

List<_DiscountReasonOption> _discountReasons() => [
  _DiscountReasonOption('vip', (c) => c.l10n.queueDiscountReasonVip),
  _DiscountReasonOption('compensation', (c) => c.l10n.queueDiscountReasonCompensation),
  _DiscountReasonOption('special_offer', (c) => c.l10n.queueDiscountReasonSpecialOffer),
  _DiscountReasonOption('subscription', (c) => c.l10n.queueDiscountReasonSubscription),
  _DiscountReasonOption('first_visit', (c) => c.l10n.queueDiscountReasonFirstVisit),
  _DiscountReasonOption(_kDiscountReasonOther, (c) => c.l10n.queueDiscountReasonOther),
];

class _DetailsStepState extends State<_DetailsStep> {
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _plateCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _discountValueCtrl = TextEditingController();
  final _discountNoteCtrl = TextEditingController();
  final _vehicleTypeOtherCtrl = TextEditingController();
  final _vehicleColorOtherCtrl = TextEditingController();

  String? _vehicleType;
  String? _vehicleColor;
  final Set<int> _selectedAddOns = {};

  // Discount state
  bool _discountOpen = false;
  String _discountType = 'percentage'; // 'percentage' or 'fixed'
  String? _discountReason;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _plateCtrl.dispose();
    _notesCtrl.dispose();
    _discountValueCtrl.dispose();
    _discountNoteCtrl.dispose();
    _vehicleTypeOtherCtrl.dispose();
    _vehicleColorOtherCtrl.dispose();
    super.dispose();
  }

  bool get _canSubmit => _nameCtrl.text.trim().isNotEmpty;

  /// Subtotal before discount (package + add-ons).
  Money get _subtotal {
    var total = Money(widget.package.price);
    final addOnList = _addOns();
    for (final i in _selectedAddOns) {
      total = total + Money(addOnList[i].priceCents);
    }
    return total;
  }

  /// Calculated discount amount in piasters.
  int get _discountAmountCents {
    if (!_discountOpen) return 0;
    final raw = double.tryParse(_discountValueCtrl.text) ?? 0;
    if (raw <= 0) return 0;
    if (_discountType == 'percentage') {
      return (_subtotal.cents * raw / 100).round().clamp(0, _subtotal.cents);
    } else {
      // Fixed amount in JOD → piasters
      return (raw * 100).round().clamp(0, _subtotal.cents);
    }
  }

  Money get _totalPrice {
    return Money(_subtotal.cents - _discountAmountCents);
  }

  bool get _hasDiscount => _discountOpen && _discountAmountCents > 0;

  void _clearDiscount() {
    setState(() {
      _discountOpen = false;
      _discountValueCtrl.clear();
      _discountReason = null;
      _discountNoteCtrl.clear();
    });
  }

  List<QueueAddOn> get _addOnEntities {
    final addOnList = _addOns();
    return _selectedAddOns
        .map((i) => QueueAddOn(
              name: addOnList[i].name(context),
              price: addOnList[i].priceCents,
            ))
        .toList();
  }

  void _submit() {
    if (!_canSubmit) return;
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    QueueDiscount? discount;
    int? priceBeforeDiscount;
    if (_hasDiscount) {
      final rawValue = double.tryParse(_discountValueCtrl.text) ?? 0;
      discount = QueueDiscount(
        type: _discountType,
        value: _discountType == 'percentage'
            ? rawValue.round()
            : (rawValue * 100).round(),
        amount: _discountAmountCents,
        reason: _discountReason != null
            ? _discountReasons().firstWhere((r) => r.key == _discountReason).label(context)
            : context.l10n.queueDiscountReasonOther,
        reasonNote: _discountReason == _kDiscountReasonOther
            ? _discountNoteCtrl.text.trim()
            : null,
      );
      priceBeforeDiscount = _subtotal.cents;
    }

    final entry = QueueEntry(
      id: 'q-${DateTime.now().millisecondsSinceEpoch}',
      position: 0, // caller assigns actual position
      status: QueueStatus.waiting,
      source: QueueSource.walkIn,
      customerName: _nameCtrl.text.trim(),
      customerPhone:
          _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
      vehicleType: _vehicleType == _kOtherValue
          ? _vehicleTypeOtherCtrl.text.trim().isEmpty
              ? null
              : _vehicleTypeOtherCtrl.text.trim()
          : _vehicleType,
      vehicleColor: _vehicleColor == _kOtherValue
          ? _vehicleColorOtherCtrl.text.trim().isEmpty
              ? null
              : _vehicleColorOtherCtrl.text.trim()
          : _vehicleColor,
      plateNumber:
          _plateCtrl.text.trim().isEmpty ? null : _plateCtrl.text.trim(),
      packageId: widget.package.id,
      packageName: widget.package.nameAr,
      packagePrice: widget.package.price,
      addOns: _addOnEntities,
      totalPrice: _totalPrice.cents,
      estimatedDurationMin: widget.package.durationMin,
      discount: discount,
      priceBeforeDiscount: priceBeforeDiscount,
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
        _FieldLabel(context.l10n.queueCustomerName),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _nameCtrl,
          onChanged: (_) => setState(() {}),
          decoration: _inputDecoration(context,
            hint: context.l10n.queueCustomerNameHint,
            prefixIcon: Icons.person_outline,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Phone (optional, LTR) ──
        _FieldLabel(context.l10n.queuePhoneOptional),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _phoneCtrl,
          keyboardType: TextInputType.phone,
          textDirection: Directionality.of(context),
          decoration: _inputDecoration(context,
            hint: '07XXXXXXXX',
            prefixIcon: Icons.phone_outlined,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Vehicle type chips ──
        _FieldLabel(context.l10n.queueVehicleType),
        const SizedBox(height: AppSpacing.sm),
        _ChipGroup(
          items: _vehicleTypes(context),
          selected: _vehicleType,
          showOther: true,
          onSelected: (v) => setState(() {
            _vehicleType = _vehicleType == v ? null : v;
            if (v != _kOtherValue) _vehicleTypeOtherCtrl.clear();
          }),
        ),
        if (_vehicleType == _kOtherValue) ...[
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _vehicleTypeOtherCtrl,
            decoration: _inputDecoration(context, hint: context.l10n.queueVehicleTypeHint),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),

        // ── Vehicle color chips ──
        _FieldLabel(context.l10n.queueVehicleColor),
        const SizedBox(height: AppSpacing.sm),
        _ChipGroup(
          items: _vehicleColors(context),
          selected: _vehicleColor,
          showOther: true,
          onSelected: (v) => setState(() {
            _vehicleColor = _vehicleColor == v ? null : v;
            if (v != _kOtherValue) _vehicleColorOtherCtrl.clear();
          }),
        ),
        if (_vehicleColor == _kOtherValue) ...[
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _vehicleColorOtherCtrl,
            decoration: _inputDecoration(context, hint: context.l10n.queueVehicleColorHint),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),

        // ── Plate number (optional, LTR) ──
        _FieldLabel(context.l10n.queuePlateOptional),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _plateCtrl,
          textDirection: Directionality.of(context),
          decoration: _inputDecoration(context, hint: '42-12345'),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Add-ons ──
        _FieldLabel(context.l10n.queueAddOns),
        const SizedBox(height: AppSpacing.sm),
        ...List.generate(_addOns().length, (i) {
          final addon = _addOns()[i];
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
                        selected ? AppColors.primary : Theme.of(context).colorScheme.outlineVariant,
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
                              : Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: selected
                          ? Icon(Icons.check, size: 14,
                              color: Theme.of(context).colorScheme.surface)
                          : null,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        addon.name(context),
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Text(
                      '+${Money(addon.priceCents).toFormattedArabic()}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: AppSpacing.sm),

        // ── Discount section (collapsible) ──
        _buildDiscountSection(),
        const SizedBox(height: AppSpacing.sm),

        // ── Notes ──
        _FieldLabel(context.l10n.queueNotesOptional),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _notesCtrl,
          maxLines: 2,
          decoration: _inputDecoration(context, hint: context.l10n.queueNotesHint),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Total + Submit ──
        const Divider(),
        const SizedBox(height: AppSpacing.md),
        _buildTotalSection(),
        const SizedBox(height: AppSpacing.md),
        btn.Button(
          onPressed: _canSubmit ? _submit : null,
          label: context.l10n.queueAddToQueue,
          icon: const btn.ButtonIcon(Icons.add),
          size: btn.ButtonSize.large,
          expand: true,
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }

  Widget _buildDiscountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header (tap to expand/collapse)
        GestureDetector(
          onTap: () => setState(() => _discountOpen = !_discountOpen),
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.local_offer_rounded,
                  size: 16,
                  color: _hasDiscount
                      ? const Color(0xFFFF9800)
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    context.l10n.queueAddDiscount,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _hasDiscount
                          ? const Color(0xFFFF9800)
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                if (_hasDiscount)
                  Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E1),
                      borderRadius: AppRadius.pill,
                    ),
                    child: Text(
                      _discountType == 'percentage'
                          ? '-${_discountValueCtrl.text}%'
                          : '-${Money(_discountAmountCents).toFormattedArabic()}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFFFF9800),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                const SizedBox(width: AppSpacing.sm),
                Icon(
                  _discountOpen
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),

        if (_discountOpen) ...[
          const SizedBox(height: AppSpacing.sm),

          // Type toggle: fixed vs percentage
          Row(
            children: [
              _DiscountTypeChip(
                label: context.l10n.queueDiscountFixed,
                selected: _discountType == 'fixed',
                onTap: () => setState(() => _discountType = 'fixed'),
              ),
              const SizedBox(width: AppSpacing.sm),
              _DiscountTypeChip(
                label: context.l10n.queueDiscountPercentage,
                selected: _discountType == 'percentage',
                onTap: () => setState(() => _discountType = 'percentage'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Value input
          TextField(
            controller: _discountValueCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
            textDirection: Directionality.of(context),
            decoration: _inputDecoration(context,
              hint: _discountType == 'percentage' ? '10' : '1.5',
              prefixIcon: _discountType == 'percentage'
                  ? Icons.percent
                  : Icons.payments_outlined,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Reason chips
          _FieldLabel(context.l10n.queueDiscountReason),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _discountReasons().map((reason) {
              final selected = _discountReason == reason.key;
              return GestureDetector(
                onTap: () => setState(() {
                  _discountReason = selected ? null : reason.key;
                }),
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFFFFF8E1)
                        : Theme.of(context).colorScheme.surfaceContainerLowest,
                    border: Border.all(
                      color: selected
                          ? const Color(0xFFFF9800)
                          : Theme.of(context).colorScheme.outlineVariant,
                    ),
                    borderRadius: AppRadius.pill,
                  ),
                  child: Text(
                    reason.label(context),
                    style: TextStyle(
                      fontSize: 11,
                      color: selected
                          ? const Color(0xFFFF9800)
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          // Free-text note if "other" selected
          if (_discountReason == _kDiscountReasonOther) ...[
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _discountNoteCtrl,
              decoration: _inputDecoration(context, hint: context.l10n.queueDiscountReasonHint),
            ),
          ],
          const SizedBox(height: AppSpacing.md),

          // Live calculation preview
          if (_discountAmountCents > 0)
            Container(
              padding: const EdgeInsetsDirectional.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                borderRadius: AppRadius.cardInner,
                border: Border.all(color: const Color(0xFFFFE0B2)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        context.l10n.queueSubtotalBeforeDiscount,
                        style: TextStyle(
                          fontSize: 11,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _subtotal.toFormattedArabic(),
                        style: TextStyle(
                          fontSize: 11,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        context.l10n.queueDiscountLabel,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFFFF9800),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '-${Money(_discountAmountCents).toFormattedArabic()}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFFFF9800),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 12),
                  Row(
                    children: [
                      Text(
                        context.l10n.queueAfterDiscount,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _totalPrice.toFormattedArabic(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF43A047),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          const SizedBox(height: AppSpacing.sm),

          // Remove discount button
          if (_hasDiscount)
            GestureDetector(
              onTap: _clearDiscount,
              child: Center(
                child: Text(
                  context.l10n.queueRemoveDiscount,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.error,
                  ),
                ),
              ),
            ),
        ],
      ],
    );
  }

  Widget _buildTotalSection() {
    return Column(
      children: [
        // Subtotal (if discount active)
        if (_hasDiscount) ...[
          Row(
            children: [
              Text(
                context.l10n.queueSubtotalBeforeDiscount,
                style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              const Spacer(),
              Text(
                _subtotal.toFormattedArabic(),
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${context.l10n.queueDiscountLabel} ',
                    style: const TextStyle(fontSize: 11, color: Color(0xFFFF9800)),
                  ),
                  if (_discountReason != null)
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 6,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: AppRadius.pill,
                      ),
                      child: Text(
                        _discountReasons().firstWhere((r) => r.key == _discountReason).label(context),
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color(0xFFFF9800),
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                '-${Money(_discountAmountCents).toFormattedArabic()}',
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFFFF9800),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
        ],

        // Final total
        Row(
          children: [
            Text(
              context.l10n.queueGrandTotal,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            Text(
              _totalPrice.toFormattedArabic(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _hasDiscount ? const Color(0xFF43A047) : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════
// Discount type toggle chip
// ═════════════════════════════════════════════════════════════════

class _DiscountTypeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _DiscountTypeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFFFF8E1) : Theme.of(context).colorScheme.surfaceContainerLowest,
            border: Border.all(
              color: selected
                  ? const Color(0xFFFF9800)
                  : Theme.of(context).colorScheme.outlineVariant,
            ),
            borderRadius: AppRadius.cardInner,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              color: selected
                  ? const Color(0xFFFF9800)
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

// Shared widgets (_PackageCard, _PackageSummary, _FieldLabel, _ChipGroup,
// _inputDecoration) are in queue_quick_add_widgets.dart
