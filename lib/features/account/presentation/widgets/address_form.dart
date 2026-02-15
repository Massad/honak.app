import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/account/domain/entities/address.dart';
import 'package:honak/features/account/presentation/widgets/sub_screen_header.dart';

class AddressFormPage extends StatefulWidget {
  final Address? address;
  final void Function(Address) onSave;

  const AddressFormPage({
    super.key,
    this.address,
    required this.onSave,
  });

  @override
  State<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  late String _label;
  late String _labelIcon;
  late final TextEditingController _labelController;
  late final TextEditingController _areaController;
  late final TextEditingController _streetController;
  late final TextEditingController _buildingController;
  late final TextEditingController _floorController;
  late final TextEditingController _apartmentController;
  late final TextEditingController _notesController;
  late bool _isDefault;

  bool get _isEdit => widget.address != null;

  static const _presets = [
    ('البيت', 'home', Icons.home_outlined),
    ('الشغل', 'briefcase', Icons.work_outline),
    ('بيت أهلي', 'users', Icons.people_outline),
  ];

  bool get _canSave =>
      (_labelController.text.trim().isNotEmpty || _label.isNotEmpty) &&
      _areaController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    final addr = widget.address;
    _label = addr?.label ?? '';
    _labelIcon = addr?.labelIcon ?? 'home';
    _labelController = TextEditingController(text: _label);
    _areaController = TextEditingController(text: addr?.area ?? '');
    _streetController = TextEditingController(text: addr?.street ?? '');
    _buildingController = TextEditingController(text: addr?.building ?? '');
    _floorController = TextEditingController(text: addr?.floor ?? '');
    _apartmentController = TextEditingController(text: addr?.apartment ?? '');
    _notesController = TextEditingController(text: addr?.notes ?? '');
    _isDefault = addr?.isDefault ?? false;
  }

  @override
  void dispose() {
    _labelController.dispose();
    _areaController.dispose();
    _streetController.dispose();
    _buildingController.dispose();
    _floorController.dispose();
    _apartmentController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _selectPreset(String label, String icon) {
    setState(() {
      _label = label;
      _labelIcon = icon;
      _labelController.text = label;
    });
  }

  void _handleSave() {
    if (!_canSave) return;
    final addr = Address(
      id: widget.address?.id ?? '',
      label: _labelController.text.trim(),
      labelIcon: _labelIcon,
      area: _areaController.text.trim(),
      city: 'عمّان',
      street: _streetController.text.trim(),
      building: _buildingController.text.trim(),
      floor: _floorController.text.trim(),
      apartment: _apartmentController.text.trim(),
      notes: _notesController.text.trim(),
      isDefault: _isDefault,
    );
    widget.onSave(addr);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerLowest,
      appBar: SubScreenHeader(
        title: _isEdit ? 'تعديل العنوان' : 'عنوان جديد',
        trailing: TextButton.icon(
          onPressed: _canSave ? _handleSave : null,
          icon: Icon(
            Icons.check,
            size: 14,
            color: _canSave ? Colors.white : AppColors.textHint,
          ),
          label: Text(
            'حفظ',
            style: TextStyle(
              color: _canSave ? Colors.white : AppColors.textHint,
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor:
                _canSave ? AppColors.primary : AppColors.border,
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.md,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        children: [
          // Label presets
          _Card(
            label: 'اسم العنوان',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: AppSpacing.sm,
                  children: _presets.map((p) {
                    final selected = _label == p.$1;
                    return ChoiceChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(p.$3, size: 12,
                            color: selected ? Colors.white : AppColors.textSecondary,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(p.$1),
                        ],
                      ),
                      selected: selected,
                      onSelected: (_) => _selectPreset(p.$1, p.$2),
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : AppColors.textSecondary,
                        fontSize: 12,
                      ),
                      backgroundColor: AppColors.border,
                      shape: const StadiumBorder(),
                      showCheckmark: false,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xxs,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.md),
                _field(
                  controller: _labelController,
                  hint: 'أو أدخل اسم مخصص...',
                  onChanged: (_) => setState(() {
                    _label = _labelController.text;
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Location details
          _Card(
            label: 'تفاصيل الموقع',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _fieldLabel('المنطقة *'),
                _field(
                  controller: _areaController,
                  hint: 'مثال: عبدون، الشميساني',
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: AppSpacing.md),
                _fieldLabel('الشارع'),
                _field(
                  controller: _streetController,
                  hint: 'اسم الشارع',
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fieldLabel('البناية'),
                          _field(
                            controller: _buildingController,
                            hint: 'عمارة/فيلا',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fieldLabel('الطابق'),
                          _field(
                            controller: _floorController,
                            hint: 'رقم',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fieldLabel('الشقة'),
                          _field(
                            controller: _apartmentController,
                            hint: 'رقم',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                _fieldLabel('ملاحظات للتوصيل'),
                _field(
                  controller: _notesController,
                  hint: 'بجانب المسجد، الباب الأزرق...',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // GPS pin (placeholder)
          Material(
            color: context.colorScheme.surface,
            borderRadius: AppRadius.card,
            child: InkWell(
              borderRadius: AppRadius.card,
              onTap: () => context.showSnackBar('قريباً'),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  borderRadius: AppRadius.card,
                  border: Border.all(color: AppColors.border),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 4,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.05),
                        borderRadius:
                            BorderRadius.circular(AppRadius.sm),
                      ),
                      child: const Icon(
                        Icons.navigation_outlined,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'تحديد الموقع على الخريطة',
                            style: context.textTheme.bodyMedium,
                          ),
                          Text(
                            'لتوصيل أدق وأسرع',
                            style:
                                context.textTheme.labelSmall?.copyWith(
                              color: AppColors.textHint,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Default toggle
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: AppRadius.card,
              border: Border.all(color: AppColors.border),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'عنوان افتراضي',
                        style: context.textTheme.bodyMedium,
                      ),
                      Text(
                        'يظهر تلقائياً عند الطلب',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _isDefault,
                  onChanged: (v) => setState(() => _isDefault = v),
                  activeTrackColor: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Text(
        text,
        style: context.textTheme.labelSmall?.copyWith(
          color: AppColors.textHint,
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    ValueChanged<String>? onChanged,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.textHint),
        filled: true,
        fillColor: context.colorScheme.surfaceContainerLowest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        isDense: true,
      ),
      style: context.textTheme.bodyMedium,
    );
  }
}

class _Card extends StatelessWidget {
  final String label;
  final Widget child;

  const _Card({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppColors.textHint,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          child,
        ],
      ),
    );
  }
}
