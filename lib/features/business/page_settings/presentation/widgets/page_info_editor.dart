import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/data/settings_repository.dart';
import 'package:honak/shared/widgets/app_direction.dart';
import 'package:honak/shared/widgets/app_dialog.dart';
import 'package:honak/shared/widgets/button.dart';

final _pageInfoProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  return SettingsRepository().getPageInfo();
});

class PageInfoEditor extends ConsumerStatefulWidget {
  final VoidCallback onClose;

  const PageInfoEditor({super.key, required this.onClose});

  @override
  ConsumerState<PageInfoEditor> createState() => _PageInfoEditorState();
}

class _PageInfoEditorState extends ConsumerState<PageInfoEditor> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cliqController = TextEditingController();
  int _descMaxLength = 500;

  final _paymentMethods = <String, bool>{
    'cash': false,
    'cliq': false,
    'bank_transfer': false,
    'visa_mc': false,
    'ewallet': false,
  };
  final _customPaymentMethods = <String>[];

  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _phoneController.dispose();
    _cliqController.dispose();
    super.dispose();
  }

  void _initFromData(Map<String, dynamic> data) {
    if (_initialized) return;
    _initialized = true;
    _nameController.text = data['name'] as String? ?? '';
    _descController.text = data['description'] as String? ?? '';
    _phoneController.text = data['phone'] as String? ?? '';
    _cliqController.text = data['cliq_alias'] as String? ?? '';
    _descMaxLength = data['description_max_length'] as int? ?? 500;
    final methods = data['payment_methods'] as List? ?? [];
    for (final m in methods) {
      final key = m as String;
      if (_paymentMethods.containsKey(key)) {
        _paymentMethods[key] = true;
      } else {
        _customPaymentMethods.add(key);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final pageInfoAsync = ref.watch(_pageInfoProvider);

    return Column(
      children: [
        // App bar
        Container(
          padding: EdgeInsetsDirectional.only(
            top: MediaQuery.of(context).padding.top + AppSpacing.sm,
            start: AppSpacing.sm,
            end: AppSpacing.sm,
            bottom: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              bottom: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
            ),
          ),
          child: Row(
            children: [
              Button(
                onPressed: () {
                  context.showSnackBar('تم الحفظ');
                  widget.onClose();
                },
                label: 'حفظ',
                variant: Variant.text,
              ),
              const Spacer(),
              Text(
                'معلومات الصفحة',
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              IconButton(
                onPressed: widget.onClose,
                icon: Icon(AppDirection.backIcon(context), size: 20),
              ),
            ],
          ),
        ),
        // Content
        Expanded(
          child: pageInfoAsync.when(
            data: (data) {
              _initFromData(data);
              return _buildForm(context);
            },
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (_, __) => Center(
              child: Text(
                'تعذر تحميل البيانات',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // Logo placeholder
        Center(
          child: Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.store,
                  size: 32,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 12,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        // Cover placeholder
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 24,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 4),
                Text(
                  'صورة الغلاف',
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        _FieldLabel('اسم الصفحة'),
        const SizedBox(height: AppSpacing.sm),
        _buildTextField(_nameController),
        const SizedBox(height: AppSpacing.lg),
        _FieldLabel('الوصف'),
        const SizedBox(height: AppSpacing.sm),
        _buildTextField(_descController,
            maxLines: 3, maxLength: _descMaxLength),
        const SizedBox(height: AppSpacing.lg),
        _FieldLabel('رقم الهاتف'),
        const SizedBox(height: AppSpacing.sm),
        _buildTextField(_phoneController,
            keyboardType: TextInputType.phone),
        const SizedBox(height: AppSpacing.lg),
        _FieldLabel('طرق الدفع'),
        const SizedBox(height: AppSpacing.sm),
        _buildPaymentChips(),
        if (_paymentMethods['cliq'] == true) ...[
          const SizedBox(height: AppSpacing.md),
          _FieldLabel('CliQ Alias'),
          const SizedBox(height: AppSpacing.sm),
          _buildTextField(_cliqController, hintText: 'username'),
        ],
      ],
    );
  }

  static const _standardMethods = <String, (String, IconData)>{
    'cash': ('كاش', Icons.payments_outlined),
    'cliq': ('كليك', Icons.account_balance_outlined),
    'bank_transfer': ('تحويل بنكي', Icons.account_balance_wallet_outlined),
    'visa_mc': ('فيزا / ماستركارد', Icons.credit_card_outlined),
    'ewallet': ('محفظة إلكترونية', Icons.phone_android_outlined),
  };

  Widget _buildPaymentChips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.end,
          children: [
            ..._paymentMethods.entries.map((e) {
              final config = _standardMethods[e.key];
              if (config == null) return const SizedBox.shrink();
              return _buildChip(
                label: config.$1,
                icon: config.$2,
                isSelected: e.value,
                onTap: () => setState(
                    () => _paymentMethods[e.key] = !e.value),
              );
            }),
            ..._customPaymentMethods.map((name) {
              return _buildChip(
                label: name,
                icon: Icons.add_circle_outline,
                isSelected: true,
                onTap: () => setState(
                    () => _customPaymentMethods.remove(name)),
              );
            }),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Button(
          onPressed: () => _showAddCustomPaymentDialog(context),
          label: 'إضافة طريقة دفع',
          icon: ButtonIcon(Icons.add),
          variant: Variant.text,
          size: ButtonSize.small,
        ),
      ],
    );
  }

  Widget _buildChip({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.08)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.3)
                : Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight:
                    isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              icon,
              size: 16,
              color: isSelected
                  ? AppColors.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCustomPaymentDialog(BuildContext context) {
    final controller = TextEditingController();
    showAppDialog<void>(
      context,
      builder: (ctx) => AlertDialog(
        title: const Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            'إضافة طريقة دفع',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        content: TextField(
          controller: controller,
          textAlign: TextAlign.end,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'اسم طريقة الدفع',
            hintStyle: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            isDense: true,
            contentPadding: const EdgeInsets.all(AppSpacing.md),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
        actions: [
          Row(
            textDirection: Directionality.of(context),
            children: [
              Button(
                onPressed: () => Navigator.of(ctx).pop(),
                label: 'إلغاء',
                variant: Variant.text,
              ),
              const SizedBox(width: AppSpacing.sm),
              Button(
                onPressed: () {
                  final name = controller.text.trim();
                  if (name.isNotEmpty) {
                    setState(() => _customPaymentMethods.add(name));
                  }
                  Navigator.of(ctx).pop();
                },
                label: 'إضافة',
                variant: Variant.text,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType? keyboardType,
    int? maxLength,
    String? hintText,
  }) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.end,
      maxLines: maxLines,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Text(
        text,
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
