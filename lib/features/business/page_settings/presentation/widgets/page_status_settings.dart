import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/presentation/providers/settings_provider.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';
import 'package:honak/shared/widgets/button.dart';

class PageStatusSettings extends ConsumerStatefulWidget {
  final VoidCallback? onClose;

  const PageStatusSettings({super.key, this.onClose});

  @override
  ConsumerState<PageStatusSettings> createState() =>
      _PageStatusSettingsState();
}

class _PageStatusSettingsState extends ConsumerState<PageStatusSettings> {
  String _selectedStatus = 'active';
  String? _closureReason;
  final _reasonController = TextEditingController();
  bool _synced = false;

  static const _tempClosureReasons = [
    'إجازة',
    'تجديد',
    'موسمي',
    'آخر',
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  String _statusFromSettings(String status) {
    if (status == 'temp_closed') return 'temp_closed';
    if (status == 'permanent_closed') return 'permanent_closed';
    return 'active';
  }

  void _save() {
    if (_selectedStatus == 'permanent_closed') {
      _showPermanentCloseConfirmation();
      return;
    }

    ref.read(pageSettingsProvider.notifier).updatePageStatus(
          _selectedStatus,
          reason: _selectedStatus == 'temp_closed'
              ? (_closureReason ?? '')
              : null,
          message: _selectedStatus == 'temp_closed'
              ? _reasonController.text
              : null,
        );
    context.showSnackBar('تم حفظ حالة الصفحة');
    widget.onClose?.call();
  }

  void _showPermanentCloseConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تأكيد الإغلاق النهائي', textAlign: TextAlign.end),
        content: const Text(
          'سيتم إخفاء صفحتك من نتائج البحث. يمكنك إعادة تفعيلها لاحقاً.',
          textAlign: TextAlign.end,
        ),
        actions: [
          Row(
            textDirection: TextDirection.ltr,
            children: [
              Button(
                onPressed: () => Navigator.pop(ctx),
                label: 'إلغاء',
                variant: Variant.text,
              ),
              const SizedBox(width: AppSpacing.sm),
              Button(
                onPressed: () {
                  Navigator.pop(ctx);
                  ref
                      .read(pageSettingsProvider.notifier)
                      .updatePageStatus('permanent_closed');
                  context.showSnackBar('تم إغلاق الصفحة');
                  widget.onClose?.call();
                },
                label: 'تأكيد',
                variant: Variant.text,
                style: Style.danger,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(pageSettingsProvider);
    final currentStatus = settingsAsync.valueOrNull?.status ?? 'active';

    if (!_synced && settingsAsync.hasValue) {
      _synced = true;
      _selectedStatus = _statusFromSettings(currentStatus);
      _reasonController.text =
          settingsAsync.valueOrNull?.tempClosedMessage ?? '';
    }

    return Column(
      children: [
        SubScreenAppBar(title: 'حالة الصفحة', onClose: widget.onClose ?? () {}),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              // Active
              _StatusOption(
                label: 'نشطة',
                desc: 'الصفحة مفعّلة وتستقبل الطلبات',
                color: AppColors.success,
                icon: Icons.check_circle_outline,
                selected: _selectedStatus == 'active',
                onTap: () => setState(() => _selectedStatus = 'active'),
              ),
              const SizedBox(height: AppSpacing.sm),

              // Temp closed
              _StatusOption(
                label: 'مغلقة مؤقتاً',
                desc: 'الصفحة لا تستقبل طلبات حالياً',
                color: AppColors.warning,
                icon: Icons.pause_circle_outline,
                selected: _selectedStatus == 'temp_closed',
                onTap: () =>
                    setState(() => _selectedStatus = 'temp_closed'),
              ),

              // Temp closed details
              if (_selectedStatus == 'temp_closed') ...[
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.warning.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'سبب الإغلاق',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      // Reason dropdown
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _closureReason,
                            isExpanded: true,
                            alignment: AlignmentDirectional.centerEnd,
                            hint: Text(
                              'اختر السبب',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                            items: _tempClosureReasons.map((reason) {
                              return DropdownMenuItem(
                                value: reason,
                                alignment:
                                    AlignmentDirectional.centerEnd,
                                child: Text(
                                  reason,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) =>
                                setState(() => _closureReason = val),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'رسالة للعملاء (اختياري)',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      TextField(
                        controller: _reasonController,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                          hintText: 'مثال: إجازة حتى ١٥ شباط',
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.sm),

              // Permanent closed
              _StatusOption(
                label: 'مغلقة نهائياً',
                desc: 'إخفاء الصفحة من البحث والاستكشاف',
                color: AppColors.error,
                icon: Icons.cancel_outlined,
                selected: _selectedStatus == 'permanent_closed',
                onTap: () =>
                    setState(() => _selectedStatus = 'permanent_closed'),
              ),

              // Permanent closed warning
              if (_selectedStatus == 'permanent_closed') ...[
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.error.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 5,
                        child: Text(
                          'سيتم إخفاء صفحتك من نتائج البحث. يمكنك إعادة تفعيلها لاحقاً.',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.error,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 18,
                        color: AppColors.error,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),

        // Save button
        Container(
          padding: EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            bottom: MediaQuery.of(context).padding.bottom + AppSpacing.md,
            top: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
            ),
          ),
          child: Button(
            onPressed: _save,
            label: 'حفظ',
            expand: true,
            size: ButtonSize.large,
          ),
        ),
      ],
    );
  }
}

class _StatusOption extends StatelessWidget {
  final String label;
  final String desc;
  final Color color;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _StatusOption({
    required this.label,
    required this.desc,
    required this.color,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? color.withValues(alpha: 0.05) : Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? color.withValues(alpha: 0.3)
                  : Theme.of(context).colorScheme.surfaceContainerLow,
            ),
          ),
          child: Row(
            children: [
              // Custom radio circle
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? color : Theme.of(context).colorScheme.outline,
                    width: 2,
                  ),
                ),
                child: selected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                          ),
                        ),
                      )
                    : null,
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    label,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: selected ? color : null,
                    ),
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              Icon(icon, size: 20, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
