import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/data/settings_repository.dart';

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
    'bank': false,
  };

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
      if (_paymentMethods.containsKey(m)) {
        _paymentMethods[m as String] = true;
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
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade100),
            ),
          ),
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  context.showSnackBar('تم الحفظ');
                  widget.onClose();
                },
                child: Text(
                  'حفظ',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
                icon: const Icon(Icons.arrow_forward, size: 20),
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
                style: TextStyle(color: Colors.grey.shade400),
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
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.store,
                  size: 32,
                  color: Colors.grey.shade400,
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
                  child: const Icon(
                    Icons.camera_alt,
                    size: 12,
                    color: Colors.white,
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
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 24,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 4),
                Text(
                  'صورة الغلاف',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade400,
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
        _FieldLabel('CliQ Alias'),
        const SizedBox(height: AppSpacing.sm),
        _buildTextField(_cliqController, hintText: 'username'),
        const SizedBox(height: AppSpacing.xxl),
        _FieldLabel('طرق الدفع'),
        const SizedBox(height: AppSpacing.sm),
        ..._paymentMethods.entries.map((e) {
          final label = switch (e.key) {
            'cash' => 'نقدي',
            'cliq' => 'CliQ',
            'bank' => 'تحويل بنكي',
            _ => e.key,
          };
          return CheckboxListTile(
            value: e.value,
            onChanged: (v) {
              setState(
                  () => _paymentMethods[e.key] = v ?? false);
            },
            title: Text(
              label,
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.end,
            ),
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            contentPadding: EdgeInsets.zero,
            activeColor: AppColors.primary,
          );
        }),
      ],
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
          color: Colors.grey.shade400,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade200),
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
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
