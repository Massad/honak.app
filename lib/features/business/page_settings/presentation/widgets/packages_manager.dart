import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/package_model.dart';
import 'package:honak/features/business/page_settings/presentation/providers/packages_provider.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';
import 'package:honak/shared/widgets/app_badge.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/confirm_dialog.dart';

class PackagesManager extends ConsumerStatefulWidget {
  final VoidCallback onClose;
  const PackagesManager({super.key, required this.onClose});

  @override
  ConsumerState<PackagesManager> createState() => _PackagesManagerState();
}

class _PackagesManagerState extends ConsumerState<PackagesManager> {
  @override
  Widget build(BuildContext context) {
    final packagesAsync = ref.watch(packagesProvider);

    return Column(
      children: [
        SubScreenAppBar(title: 'الباقات', onClose: widget.onClose),
        Expanded(
          child: packagesAsync.when(
            data: (packages) => _buildList(packages),
            loading: () => const _PackagesSkeleton(),
            error: (_, __) => Center(
              child: Text(
                'تعذر تحميل الباقات',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildList(List<BusinessPackage> packages) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // Info banner
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.lg),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'أنشئ باقات اشتراك لعملائك. الباقات تظهر في صفحتك ويمكن للعميل شراؤها مباشرة.',
                  style: TextStyle(fontSize: 11, color: Colors.blue.shade700),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.info_outline, size: 18, color: Colors.blue.shade700),
            ],
          ),
        ),

        // Package cards
        for (final pkg in packages)
          _PackageCard(
            pkg: pkg,
            onToggle: (v) =>
                ref.read(packagesProvider.notifier).togglePackage(pkg.id, v),
            onEdit: () => _showPackageEditor(context, ref, pkg),
          ),

        // Add package button (dashed border)
        GestureDetector(
          onTap: () => _showPackageEditor(context, ref),
          child: CustomPaint(
            painter: _DashedBorderPainter(
              color: AppColors.primary.withValues(alpha: 0.3),
              borderRadius: 14,
            ),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'إضافة باقة',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Icon(Icons.add_circle_outline,
                      size: 18, color: AppColors.primary),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }

  void _showPackageEditor(BuildContext context, WidgetRef ref,
      [BusinessPackage? existing]) {
    showAppSheet(
      context,
      builder: (_) => _PackageEditorSheet(
        existing: existing,
        onSave: (pkg) {
          if (existing != null) {
            ref.read(packagesProvider.notifier).updatePackage(pkg);
          } else {
            ref.read(packagesProvider.notifier).addPackage(pkg);
          }
        },
        onDelete: existing != null
            ? () => ref
                .read(packagesProvider.notifier)
                .removePackage(existing.id)
            : null,
      ),
    );
  }
}

// ─── Package Card ──────────────────────────────────────────────────────────

class _PackageCard extends StatelessWidget {
  final BusinessPackage pkg;
  final ValueChanged<bool> onToggle;
  final VoidCallback onEdit;

  const _PackageCard({
    required this.pkg,
    required this.onToggle,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 10),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: pkg.active ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: pkg.active
              ? AppColors.primary.withValues(alpha: 0.15)
              : Theme.of(context).colorScheme.surfaceContainerLow,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Row 1: name + active toggle
          Row(
            children: [
              Switch(
                value: pkg.active,
                onChanged: onToggle,
                activeTrackColor: AppColors.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const Spacer(),
              Text(
                pkg.name,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          if (pkg.description.isNotEmpty)
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 4),
              child: Text(
                pkg.description,
                style:
                    TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant),
                textAlign: TextAlign.right,
              ),
            ),
          const SizedBox(height: AppSpacing.sm),
          // Row 2: Stats chips + edit
          Row(
            children: [
              GestureDetector(
                onTap: onEdit,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'تعديل',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              AppBadge.small(
                label: '${pkg.credits} ${pkg.creditLabel}',
                color: Colors.blue,
              ),
              const SizedBox(width: 6),
              AppBadge.small(
                label: _formatPrice(pkg.price),
                color: Colors.green,
              ),
              if (pkg.validityMonths != null) ...[
                const SizedBox(width: 6),
                AppBadge.small(
                  label: '${pkg.validityMonths} شهر',
                  color: Colors.orange,
                ),
              ],
            ],
          ),
          // Compare price (savings indicator)
          if (pkg.comparePrice != null && pkg.comparePrice! > 0) ...[
            const SizedBox(height: 6),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                'توفير ${_calcSavings(pkg)}٪ مقارنة بالسعر المفرد (${_formatPrice(pkg.comparePrice!)})',
                style: TextStyle(fontSize: 10, color: Colors.green.shade600),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Package Editor Sheet ──────────────────────────────────────────────────

class _PackageEditorSheet extends StatefulWidget {
  final BusinessPackage? existing;
  final ValueChanged<BusinessPackage> onSave;
  final VoidCallback? onDelete;

  const _PackageEditorSheet({
    this.existing,
    required this.onSave,
    this.onDelete,
  });

  @override
  State<_PackageEditorSheet> createState() => _PackageEditorSheetState();
}

class _PackageEditorSheetState extends State<_PackageEditorSheet> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _priceCtrl;
  late final TextEditingController _creditLabelCtrl;
  late final TextEditingController _comparePriceCtrl;

  late int _credits;
  late String _validityModel;
  late int _months;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _nameCtrl = TextEditingController(text: e?.name ?? '');
    _descCtrl = TextEditingController(text: e?.description ?? '');
    _priceCtrl = TextEditingController(
      text: e != null ? _piasterToJod(e.price) : '',
    );
    _creditLabelCtrl = TextEditingController(text: e?.creditLabel ?? '');
    _comparePriceCtrl = TextEditingController(
      text: e?.comparePrice != null ? _piasterToJod(e!.comparePrice!) : '',
    );
    _credits = e?.credits ?? 1;
    _validityModel = e?.validityModel ?? 'visits_date';
    _months = e?.validityMonths ?? 1;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    _creditLabelCtrl.dispose();
    _comparePriceCtrl.dispose();
    super.dispose();
  }

  String _piasterToJod(int piasters) {
    final jod = piasters / 1000;
    return jod.toStringAsFixed(jod.truncateToDouble() == jod ? 0 : 3);
  }

  void _save() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) return;

    final price = (double.tryParse(_priceCtrl.text) ?? 0) * 1000;
    final compareText = _comparePriceCtrl.text.trim();
    final comparePrice = compareText.isNotEmpty
        ? ((double.tryParse(compareText) ?? 0) * 1000).round()
        : null;

    final pkg = BusinessPackage(
      id: widget.existing?.id ??
          'pkg_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      description: _descCtrl.text.trim(),
      price: price.round(),
      credits: _credits,
      creditLabel: _creditLabelCtrl.text.trim().isEmpty
          ? 'استخدام'
          : _creditLabelCtrl.text.trim(),
      validityModel: _validityModel,
      validityMonths: _validityModel == 'visits_date' ? _months : null,
      comparePrice: comparePrice,
      active: widget.existing?.active ?? true,
    );

    widget.onSave(pkg);
    Navigator.of(context).pop();
  }

  Future<void> _confirmDelete() async {
    final confirmed = await ConfirmDialog.show(
      context,
      title: 'حذف الباقة',
      message: 'هل أنت متأكد من حذف هذه الباقة؟',
      confirmLabel: 'حذف',
      cancelLabel: 'إلغاء',
      isDestructive: true,
    );
    if (confirmed && mounted) {
      Navigator.of(context).pop();
      widget.onDelete?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Handle bar
        Center(
          child: Container(
            width: 40,
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
        Text(
          widget.existing != null ? 'تعديل الباقة' : 'باقة جديدة',
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSpacing.xl),
        Flexible(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            children: [
              // 1. Name
              _FieldLabel('اسم الباقة'),
              _StyledTextField(
                  hint: 'مثال: باقة شهرية', controller: _nameCtrl),
              const SizedBox(height: AppSpacing.md),

              // 2. Description
              _FieldLabel('الوصف (اختياري)'),
              _StyledTextField(
                hint: 'وصف قصير للباقة',
                controller: _descCtrl,
                maxLines: 2,
              ),
              const SizedBox(height: AppSpacing.md),

              // 3. Price
              _FieldLabel('السعر'),
              _StyledTextField(
                hint: '0.000',
                controller: _priceCtrl,
                keyboardType: TextInputType.number,
                suffix: 'د.أ',
              ),
              const SizedBox(height: AppSpacing.md),

              // 4. Credits
              _FieldLabel('عدد الاستخدامات'),
              _CounterField(
                value: _credits,
                onChanged: (v) => setState(() => _credits = v),
                min: 1,
                max: 999,
              ),
              const SizedBox(height: AppSpacing.md),

              // 5. Credit label
              _FieldLabel('وحدة الاستخدام'),
              _StyledTextField(
                hint: 'مثال: توصيلة، جلسة، زيارة',
                controller: _creditLabelCtrl,
              ),
              const SizedBox(height: AppSpacing.md),

              // 6. Validity model
              _FieldLabel('صلاحية الباقة'),
              _RadioOption(
                label: 'عدد + مدة',
                desc: 'تنتهي عند استخدام الرصيد أو انتهاء المدة',
                selected: _validityModel == 'visits_date',
                onTap: () => setState(() => _validityModel = 'visits_date'),
              ),
              const SizedBox(height: 6),
              _RadioOption(
                label: 'عدد فقط',
                desc: 'تنتهي فقط عند استخدام كل الرصيد',
                selected: _validityModel == 'visits_only',
                onTap: () => setState(() => _validityModel = 'visits_only'),
              ),

              // 7. Validity months (only for visits_date)
              if (_validityModel == 'visits_date') ...[
                const SizedBox(height: AppSpacing.md),
                _FieldLabel('المدة (أشهر)'),
                _CounterField(
                  value: _months,
                  onChanged: (v) => setState(() => _months = v),
                  min: 1,
                  max: 24,
                ),
              ],
              const SizedBox(height: AppSpacing.md),

              // 8. Compare price
              _FieldLabel('سعر الاستخدام المفرد (اختياري)'),
              _StyledTextField(
                hint: 'لإظهار نسبة التوفير',
                controller: _comparePriceCtrl,
                keyboardType: TextInputType.number,
                suffix: 'د.أ',
              ),
              const SizedBox(height: AppSpacing.xl),

              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    widget.existing != null ? 'حفظ التعديلات' : 'إنشاء الباقة',
                  ),
                ),
              ),

              // Delete button (existing only)
              if (widget.existing != null) ...[
                const SizedBox(height: AppSpacing.sm),
                TextButton(
                  onPressed: _confirmDelete,
                  child: const Text(
                    'حذف الباقة',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Helper Widgets ────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 6),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

class _StyledTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? suffix;

  const _StyledTextField({
    required this.hint,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textAlign: TextAlign.end,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
        prefixText: suffix,
        prefixStyle: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}

class _CounterField extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  const _CounterField({
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _counterButton(Icons.remove, value > min, () {
            if (value > min) onChanged(value - 1);
          }),
          Container(
            constraints: const BoxConstraints(minWidth: 48),
            alignment: Alignment.center,
            child: Text(
              '$value',
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          _counterButton(Icons.add, value < max, () {
            if (value < max) onChanged(value + 1);
          }),
        ],
      ),
    );
  }

  Widget _counterButton(
      IconData icon, bool enabled, VoidCallback onPressed) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Icon(
          icon,
          size: 18,
          color: enabled ? AppColors.primary : Colors.grey.shade300,
        ),
      ),
    );
  }
}

class _RadioOption extends StatelessWidget {
  final String label;
  final String desc;
  final bool selected;
  final VoidCallback onTap;

  const _RadioOption({
    required this.label,
    required this.desc,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.05)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected
                ? AppColors.primary.withValues(alpha: 0.3)
                : Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              size: 18,
              color: selected ? AppColors.primary : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selected ? AppColors.primary : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: TextStyle(
                      fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Dashed Border Painter ─────────────────────────────────────────────────

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double borderRadius;

  _DashedBorderPainter({required this.color, required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    const dashWidth = 6.0;
    const dashSpace = 4.0;

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final end = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(
              distance, end > metric.length ? metric.length : end),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter old) =>
      color != old.color || borderRadius != old.borderRadius;
}

// ─── Skeleton ──────────────────────────────────────────────────────────────

class _PackagesSkeleton extends StatelessWidget {
  const _PackagesSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: List.generate(2, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.shimmerBase,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        );
      }),
    );
  }
}

// ─── Helpers ───────────────────────────────────────────────────────────────

String _formatPrice(int piasters) {
  final jod = piasters / 1000;
  return '${jod.toStringAsFixed(jod.truncateToDouble() == jod ? 0 : 3)} د.أ';
}

int _calcSavings(BusinessPackage pkg) {
  if (pkg.comparePrice == null || pkg.comparePrice == 0) return 0;
  final fullPrice = pkg.comparePrice! * pkg.credits;
  return ((fullPrice - pkg.price) / fullPrice * 100).round();
}
