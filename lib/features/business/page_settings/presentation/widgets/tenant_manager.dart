import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/tenant.dart';
import 'package:honak/features/business/page_settings/presentation/providers/tenant_provider.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';
import 'package:honak/shared/widgets/app_badge.dart';
import 'package:honak/shared/widgets/app_dialog.dart';
import 'package:honak/shared/widgets/button.dart';

class TenantManager extends ConsumerWidget {
  final VoidCallback onClose;
  const TenantManager({super.key, required this.onClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tenantsAsync = ref.watch(tenantProvider);
    return Column(
      children: [
        SubScreenAppBar(title: 'دليل المستأجرين', onClose: onClose),
        Expanded(
          child: tenantsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('حدث خطأ: $e')),
            data: (tenants) => _TenantBody(tenants: tenants),
          ),
        ),
      ],
    );
  }
}

class _TenantBody extends ConsumerWidget {
  final List<Tenant> tenants;
  const _TenantBody({required this.tenants});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grouped = <String, List<Tenant>>{};
    for (final t in tenants) {
      grouped.putIfAbsent(t.floor.isEmpty ? 'غير محدد' : t.floor, () => []).add(t);
    }
    final active = tenants.where((t) => t.status == 'active').length;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        _summaryCard(active, tenants.length),
        for (final entry in grouped.entries) ...[
          _floorHeader(entry.key),
          for (final t in entry.value) _tenantCard(t),
        ],
        const SizedBox(height: AppSpacing.md),
        _addButton(() => _showAddDialog(context, ref)),
      ],
    );
  }

  Widget _summaryCard(int active, int total) {
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _stat('نشط', '$active', Colors.green),
        _stat('الإجمالي', '$total', AppColors.primary),
      ]),
    );
  }

  Widget _stat(String label, String value, Color color) {
    return Column(children: [
      Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: color)),
      Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
    ]);
  }

  Widget _floorHeader(String name) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm, top: AppSpacing.lg, bottom: AppSpacing.sm),
      child: Align(alignment: AlignmentDirectional.centerEnd, child: Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
    );
  }

  Widget _tenantCard(Tenant t) {
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 8),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
      child: Row(children: [
        AppBadge.small(
          label: _statusLabel(t.status),
          color: _statusColor(t.status),
        ),
        if (t.linkedPageId != null) ...[const SizedBox(width: 6), const Icon(Icons.link, size: 14, color: AppColors.primary)],
        const Spacer(),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(t.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          Text([if (t.unit.isNotEmpty) t.unit, if (t.businessType.isNotEmpty) t.businessType].join(' • '),
              style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
        ]),
      ]),
    );
  }

  Widget _addButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('إضافة مستأجر', style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
          const SizedBox(width: 6),
          Icon(Icons.add, size: 18, color: Colors.grey.shade500),
        ]),
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final floorCtrl = TextEditingController();
    final unitCtrl = TextEditingController();
    final typeCtrl = TextEditingController();
    var status = 'active';

    showAppDialog<void>(
      context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          title: const Text('إضافة مستأجر', textAlign: TextAlign.right, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              _field(nameCtrl, 'اسم المحل'),
              const SizedBox(height: 8),
              _field(floorCtrl, 'الطابق'),
              const SizedBox(height: 8),
              _field(unitCtrl, 'رقم الوحدة'),
              const SizedBox(height: 8),
              _field(typeCtrl, 'نوع النشاط'),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                for (final s in ['active', 'coming_soon', 'closed'])
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 6),
                    child: GestureDetector(
                      onTap: () => setS(() => status = s),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: status == s ? _statusColor(s).withValues(alpha: 0.1) : Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: status == s ? _statusColor(s) : Theme.of(context).colorScheme.outlineVariant),
                        ),
                        child: Text(_statusLabel(s), style: TextStyle(fontSize: 11, color: status == s ? _statusColor(s) : Theme.of(context).colorScheme.onSurfaceVariant)),
                      ),
                    ),
                  ),
                const Spacer(),
                Text('الحالة', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
              ]),
            ]),
          ),
          actions: [
            Row(
              textDirection: Directionality.of(context),
              children: [
                Button(
                  onPressed: () => Navigator.pop(ctx),
                  label: 'إلغاء',
                  variant: Variant.text,
                ),
                const SizedBox(width: AppSpacing.sm),
                Button(
                  onPressed: () {
                    final name = nameCtrl.text.trim();
                    if (name.isEmpty) return;
                    ref.read(tenantProvider.notifier).addTenant(Tenant(
                      id: 'tnt_${DateTime.now().millisecondsSinceEpoch}',
                      name: name, floor: floorCtrl.text.trim(),
                      unit: unitCtrl.text.trim(), businessType: typeCtrl.text.trim(), status: status,
                    ));
                    Navigator.pop(ctx);
                  },
                  label: 'إضافة',
                  variant: Variant.text,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController ctrl, String hint) {
    return TextField(
      controller: ctrl, textAlign: TextAlign.right,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: hint, isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

Color _statusColor(String s) => switch (s) { 'active' => Colors.green, 'coming_soon' => Colors.orange, 'closed' => Colors.red, _ => Colors.grey.shade500 };
String _statusLabel(String s) => switch (s) { 'active' => 'نشط', 'coming_soon' => 'قريباً', 'closed' => 'مغلق', _ => s };
