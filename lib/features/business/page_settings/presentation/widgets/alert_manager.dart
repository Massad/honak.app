import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/alert_model.dart';
import 'package:honak/features/business/page_settings/presentation/providers/alert_provider.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';
import 'package:honak/shared/widgets/app_badge.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/confirm_dialog.dart';

class AlertManager extends ConsumerWidget {
  final VoidCallback onClose;
  const AlertManager({super.key, required this.onClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertsAsync = ref.watch(alertProvider);
    return Column(
      children: [
        SubScreenAppBar(title: 'إدارة التنبيهات', onClose: onClose),
        Expanded(
          child: alertsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('حدث خطأ: $e')),
            data: (alerts) => _AlertBody(alerts: alerts),
          ),
        ),
      ],
    );
  }
}

class _AlertBody extends ConsumerWidget {
  final List<BusinessAlert> alerts;
  const _AlertBody({required this.alerts});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = alerts.where((a) => a.active).toList();
    final inactive = alerts.where((a) => !a.active).toList();

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        if (active.isNotEmpty) ...[
          _sectionHeader('تنبيهات نشطة', active.length),
          for (final a in active) _AlertCard(alert: a),
        ],
        if (inactive.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          _sectionHeader('منشورات سابقة', inactive.length),
          for (final a in inactive) _AlertCard(alert: a),
        ],
        if (alerts.isEmpty)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(children: [
              Icon(Icons.notifications_none,
                  size: 48, color: Theme.of(context).colorScheme.outline),
              const SizedBox(height: AppSpacing.md),
              Text('لا توجد تنبيهات',
                  style: TextStyle(
                      fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant)),
              const SizedBox(height: 4),
              Text('أضف تنبيهات لإبلاغ المتابعين بالمستجدات',
                  style: TextStyle(
                      fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant)),
            ]),
          ),
        const SizedBox(height: AppSpacing.lg),
        _addButton(() => _showAddSheet(context, ref)),
      ],
    );
  }

  Widget _sectionHeader(String title, int count) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          end: AppSpacing.sm, bottom: AppSpacing.sm),
      child: Row(children: [
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(6)),
          child: Text('$count',
              style: TextStyle(
                  fontSize: 10, color: Colors.grey.shade500)),
        ),
        const Spacer(),
        Text(title,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600)),
      ]),
    );
  }

  Widget _addButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('إضافة تنبيه',
                  style: TextStyle(
                      fontSize: 13, color: Colors.grey.shade500)),
              const SizedBox(width: 6),
              Icon(Icons.add, size: 18, color: Colors.grey.shade500),
            ]),
      ),
    );
  }

  void _showAddSheet(BuildContext context, WidgetRef ref) {
    final titleCtrl = TextEditingController();
    final bodyCtrl = TextEditingController();
    var severity = 'info';
    var hasExpiry = false;

    showAppSheet(
      context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => Padding(
          padding: EdgeInsets.only(
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.lg,
              bottom: AppSpacing.lg),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('تنبيه جديد',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: AppSpacing.lg),
                _textField(titleCtrl, 'عنوان التنبيه'),
                const SizedBox(height: AppSpacing.sm),
                _textField(bodyCtrl, 'تفاصيل التنبيه', maxLines: 3),
                const SizedBox(height: AppSpacing.md),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      for (final s in ['info', 'warning', 'urgent'])
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 8),
                          child: GestureDetector(
                            onTap: () => setS(() => severity = s),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: severity == s
                                    ? _severityColor(s)
                                        .withValues(alpha: 0.1)
                                    : Theme.of(context).colorScheme.surfaceContainerLowest,
                                borderRadius:
                                    BorderRadius.circular(6),
                                border: Border.all(
                                    color: severity == s
                                        ? _severityColor(s)
                                        : Theme.of(context).colorScheme.outlineVariant),
                              ),
                              child: Text(_severityLabel(s),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: severity == s
                                          ? _severityColor(s)
                                          : Theme.of(context).colorScheme.onSurfaceVariant,
                                      fontWeight: severity == s
                                          ? FontWeight.w500
                                          : FontWeight.normal)),
                            ),
                          ),
                        ),
                      const Spacer(),
                      Text('الأهمية',
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurfaceVariant)),
                    ]),
                const SizedBox(height: AppSpacing.md),
                GestureDetector(
                  onTap: () => setS(() => hasExpiry = !hasExpiry),
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              hasExpiry
                                  ? 'تاريخ انتهاء'
                                  : 'بدون انتهاء',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.onSurfaceVariant)),
                          const SizedBox(width: 4),
                          Icon(
                              hasExpiry
                                  ? Icons.event
                                  : Icons.all_inclusive,
                              size: 16,
                              color: Theme.of(context).colorScheme.onSurfaceVariant),
                        ]),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final title = titleCtrl.text.trim();
                      final body = bodyCtrl.text.trim();
                      if (title.isEmpty || body.isEmpty) return;
                      final now = DateTime.now()
                              .millisecondsSinceEpoch ~/
                          1000;
                      ref
                          .read(alertProvider.notifier)
                          .addAlert(BusinessAlert(
                            id: 'alrt_${DateTime.now().millisecondsSinceEpoch}',
                            title: title,
                            body: body,
                            severity: severity,
                            active: true,
                            createdAt: now,
                          ));
                      Navigator.pop(ctx);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Theme.of(context).colorScheme.surface,
                      padding:
                          const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('حفظ التنبيه',
                        style: TextStyle(fontSize: 14)),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget _textField(TextEditingController ctrl, String hint,
      {int maxLines = 1}) {
    return TextField(
      controller: ctrl,
      textAlign: TextAlign.right,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// ── Alert Card ────────────────────────────────────────────────────────────────

class _AlertCard extends ConsumerWidget {
  final BusinessAlert alert;
  const _AlertCard({required this.alert});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 10),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: alert.active ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: _severityColor(alert.severity)
                .withValues(alpha: alert.active ? 0.2 : 0.1)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        // Title row with severity badge and toggle
        Row(children: [
          Switch(
            value: alert.active,
            onChanged: (v) =>
                ref.read(alertProvider.notifier).toggleAlert(alert.id, v),
            activeTrackColor: AppColors.primary,
          ),
          const Spacer(),
          AppBadge.small(
            label: _severityLabel(alert.severity),
            color: _severityColor(alert.severity),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(alert.title,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600),
                textAlign: TextAlign.right),
          ),
        ]),
        const SizedBox(height: 6),

        // Body text
        Text(alert.body,
            style:
                TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
            textAlign: TextAlign.right),
        const SizedBox(height: 8),

        // Target areas
        if (alert.targetAreas.isNotEmpty) ...[
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            alignment: WrapAlignment.end,
            children: [
              for (final area in alert.targetAreas)
                AppBadge.small(
                  label: area,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  icon: Icons.location_on_outlined,
                ),
            ],
          ),
          const SizedBox(height: 8),
        ],

        // Info row: views, countdown, creation date
        Row(children: [
          // Creation date
          Text('أُنشئ: ${_fmtDate(alert.createdAt)}',
              style: TextStyle(
                  fontSize: 9, color: Theme.of(context).colorScheme.onSurfaceVariant)),
          const Spacer(),

          // View count
          Row(mainAxisSize: MainAxisSize.min, children: [
            Text('${alert.views}',
                style: TextStyle(
                    fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant)),
            const SizedBox(width: 3),
            Icon(Icons.visibility_outlined,
                size: 13, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ]),

          // Countdown timer for active alerts with expiry
          if (alert.active && alert.expiresAt != null) ...[
            const SizedBox(width: AppSpacing.md),
            _CountdownBadge(expiresAt: alert.expiresAt!),
          ],

          // Expiry date for inactive alerts
          if (!alert.active && alert.expiresAt != null) ...[
            const SizedBox(width: AppSpacing.md),
            Text('انتهى: ${_fmtDate(alert.expiresAt!)}',
                style: TextStyle(
                    fontSize: 9, color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ],
        ]),

        // End alert button for active alerts
        if (alert.active) ...[
          const SizedBox(height: AppSpacing.sm),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton.icon(
              onPressed: () => _confirmEndAlert(context, ref),
              icon: const Icon(Icons.stop_circle_outlined, size: 16),
              label: const Text('إنهاء التنبيه',
                  style: TextStyle(fontSize: 12)),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.error,
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      ]),
    );
  }

  Future<void> _confirmEndAlert(
      BuildContext context, WidgetRef ref) async {
    final confirmed = await ConfirmDialog.show(
      context,
      title: 'إنهاء التنبيه',
      message: 'هل أنت متأكد من إنهاء التنبيه "${alert.title}"؟ '
          'لن يظهر بعد الآن للمتابعين.',
      confirmLabel: 'إنهاء',
      isDestructive: true,
    );
    if (confirmed) {
      ref.read(alertProvider.notifier).endAlert(alert.id);
    }
  }
}

// ── Countdown Badge ───────────────────────────────────────────────────────────

class _CountdownBadge extends StatelessWidget {
  final int expiresAt;
  const _CountdownBadge({required this.expiresAt});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final remaining = expiresAt - now;

    if (remaining <= 0) {
      return AppBadge.small(
        label: 'منتهي',
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        icon: Icons.timer_off_outlined,
      );
    }

    final days = remaining ~/ 86400;
    final hours = (remaining % 86400) ~/ 3600;

    final String text;
    if (days > 0) {
      text = 'متبقي $days يوم';
    } else {
      text = 'متبقي $hours ساعة';
    }

    return AppBadge.small(
      label: text,
      color: days <= 1 ? Colors.orange : AppColors.primary,
      icon: Icons.timer_outlined,
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

Color _severityColor(String s) => switch (s) {
      'info' => Colors.blue,
      'warning' => Colors.orange,
      'urgent' => Colors.red,
      _ => Colors.grey.shade500,
    };

String _severityLabel(String s) => switch (s) {
      'info' => 'معلومة',
      'warning' => 'تنبيه',
      'urgent' => 'عاجل',
      _ => s,
    };

String _fmtDate(int ts) {
  final d = DateTime.fromMillisecondsSinceEpoch(ts * 1000);
  return '${d.day}/${d.month}/${d.year}';
}
