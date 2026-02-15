import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';
import 'package:honak/shared/widgets/app_badge.dart';

class CalendarSyncSettings extends StatefulWidget {
  final VoidCallback onClose;

  const CalendarSyncSettings({super.key, required this.onClose});

  @override
  State<CalendarSyncSettings> createState() => _CalendarSyncSettingsState();
}

class _CalendarSyncSettingsState extends State<CalendarSyncSettings> {
  bool _isConnected = false;
  bool _isSyncing = false;
  DateTime? _lastSync;

  void _connect() {
    setState(() {
      _isConnected = true;
      _lastSync = DateTime.now();
    });
    context.showSnackBar('تم ربط Google Calendar بنجاح');
  }

  void _disconnect() {
    setState(() {
      _isConnected = false;
      _lastSync = null;
    });
    context.showSnackBar('تم فصل Google Calendar');
  }

  Future<void> _syncNow() async {
    setState(() => _isSyncing = true);
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() {
      _isSyncing = false;
      _lastSync = DateTime.now();
    });
    context.showSnackBar('تمت المزامنة بنجاح');
  }

  String _formatLastSync(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60) return 'الآن';
    if (diff.inMinutes < 60) return 'قبل ${diff.inMinutes} دقائق';
    if (diff.inHours < 24) return 'قبل ${diff.inHours} ساعات';
    return 'قبل ${diff.inDays} أيام';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubScreenAppBar(title: 'مزامنة التقويم', onClose: widget.onClose),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              // Description
              Text(
                'اربط تقويمك الشخصي لمزامنة مواعيدك تلقائياً مع حجوزات العملاء.',
                style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: AppSpacing.xl),

              // Google Calendar card
              _isConnected
                  ? _buildConnectedCard()
                  : _buildDisconnectedCard(),

              const SizedBox(height: AppSpacing.xl),

              // Info box
              _buildInfoBox(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDisconnectedCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Google Calendar',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    'مزامنة الحجوزات مع تقويم جوجل',
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.blue,
                  size: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _connect,
              icon: const Icon(Icons.link, size: 18),
              label: const Text('ربط'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Theme.of(context).colorScheme.surface,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectedCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          // Header row: icon + name + badge
          Row(
            children: [
              const AppBadge(
                label: 'مربوط',
                color: AppColors.success,
                icon: Icons.check_circle_outline,
                pill: true,
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Google Calendar',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    'مزامنة الحجوزات مع تقويم جوجل',
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.success,
                  size: 28,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.lg),

          // Last sync timestamp
          if (_lastSync != null)
            Row(
              children: [
                const Spacer(),
                Text(
                  'آخر مزامنة: ${_formatLastSync(_lastSync!)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),

          const SizedBox(height: AppSpacing.lg),

          // Sync Now button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _isSyncing ? null : _syncNow,
              icon: _isSyncing
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.refresh, size: 18),
              label: Text(_isSyncing ? 'جاري المزامنة...' : 'مزامنة الآن'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // Disconnect link
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton(
              onPressed: _disconnect,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.error,
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'فصل',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              'المزامنة باتجاه واحد: الحجوزات من هناك.app تُضاف تلقائياً لتقويمك. التعديلات على التقويم لا تؤثر على الحجوزات.',
              style: TextStyle(fontSize: 11, color: Colors.blue.shade700),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Icon(Icons.info_outline, size: 18, color: Colors.blue.shade700),
        ],
      ),
    );
  }
}
