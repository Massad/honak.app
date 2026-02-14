import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';
import 'package:honak/shared/widgets/app_badge.dart';

/// Mock platform data for Phase 1.
class _PlatformData {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  bool isConnected = false;
  bool autoSync = true;
  bool isExpanded = false;
  int itemsSynced = 0;
  int itemsTotal = 0;
  int syncErrors = 0;
  DateTime? lastSync;

  _PlatformData({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class CatalogSyncSettings extends StatefulWidget {
  final VoidCallback onClose;

  const CatalogSyncSettings({super.key, required this.onClose});

  @override
  State<CatalogSyncSettings> createState() => _CatalogSyncSettingsState();
}

class _CatalogSyncSettingsState extends State<CatalogSyncSettings> {
  late final List<_PlatformData> _platforms;
  final Map<String, bool> _syncingPlatforms = {};

  @override
  void initState() {
    super.initState();
    _platforms = [
      _PlatformData(
        id: 'talabat',
        name: 'طلبات',
        icon: Icons.delivery_dining_outlined,
        color: Colors.orange,
      ),
      _PlatformData(
        id: 'custom_api',
        name: 'API مخصص',
        icon: Icons.api_outlined,
        color: Colors.teal,
      ),
    ];
  }

  void _connect(_PlatformData platform) {
    setState(() {
      platform.isConnected = true;
      platform.isExpanded = true;
      platform.itemsSynced = 45;
      platform.itemsTotal = 52;
      platform.syncErrors = 2;
      platform.lastSync = DateTime.now();
      platform.autoSync = true;
    });
    context.showSnackBar('تم ربط ${platform.name} بنجاح');
  }

  void _disconnect(_PlatformData platform) {
    setState(() {
      platform.isConnected = false;
      platform.isExpanded = false;
      platform.itemsSynced = 0;
      platform.itemsTotal = 0;
      platform.syncErrors = 0;
      platform.lastSync = null;
      platform.autoSync = true;
    });
    context.showSnackBar('تم فصل ${platform.name}');
  }

  Future<void> _syncNow(_PlatformData platform) async {
    setState(() => _syncingPlatforms[platform.id] = true);
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() {
      _syncingPlatforms[platform.id] = false;
      platform.lastSync = DateTime.now();
      platform.itemsSynced = platform.itemsTotal;
      platform.syncErrors = 0;
    });
    context.showSnackBar('تمت مزامنة ${platform.name} بنجاح');
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
        SubScreenAppBar(title: 'مزامنة المنتجات', onClose: widget.onClose),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              // Description
              Text(
                'اربط منصاتك الخارجية لدفع منتجاتك وأسعارك تلقائياً.',
                style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: AppSpacing.xl),

              // Platform cards
              for (int i = 0; i < _platforms.length; i++) ...[
                _buildPlatformCard(_platforms[i]),
                if (i < _platforms.length - 1)
                  const SizedBox(height: AppSpacing.md),
              ],

              const SizedBox(height: AppSpacing.xl),

              // Info section — 3-step explanation
              _buildInfoSection(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlatformCard(_PlatformData platform) {
    final isSyncing = _syncingPlatforms[platform.id] ?? false;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: platform.isConnected
              ? AppColors.success.withValues(alpha: 0.3)
              : Theme.of(context).colorScheme.surfaceContainerLow,
        ),
      ),
      child: Column(
        children: [
          // Header — always visible
          InkWell(
            onTap: platform.isConnected
                ? () => setState(
                    () => platform.isExpanded = !platform.isExpanded)
                : null,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  // Status badge or connect button
                  if (platform.isConnected) ...[
                    if (platform.isExpanded)
                      Icon(
                        Icons.keyboard_arrow_up,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      )
                    else
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    const SizedBox(width: AppSpacing.sm),
                    const AppBadge.small(
                      label: 'مربوط',
                      color: AppColors.success,
                      icon: Icons.check_circle_outline,
                    ),
                  ] else
                    _ConnectButton(onTap: () => _connect(platform)),

                  const Spacer(),

                  // Platform name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        platform.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (!platform.isConnected)
                        Text(
                          'غير مربوط',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: AppSpacing.md),

                  // Platform icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: platform.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      platform.icon,
                      color: platform.color,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expanded stats section — only when connected + expanded
          if (platform.isConnected && platform.isExpanded) ...[
            Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  // Items synced
                  _StatRow(
                    label: 'العناصر المتزامنة',
                    value: '${platform.itemsSynced} من ${platform.itemsTotal}',
                    icon: Icons.inventory_2_outlined,
                    iconColor: AppColors.primary,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Sync errors
                  if (platform.syncErrors > 0) ...[
                    _StatRow(
                      label: 'أخطاء المزامنة',
                      value: '${platform.syncErrors}',
                      icon: Icons.error_outline,
                      iconColor: AppColors.error,
                      valueColor: AppColors.error,
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],

                  // Last sync
                  if (platform.lastSync != null) ...[
                    _StatRow(
                      label: 'آخر مزامنة',
                      value: _formatLastSync(platform.lastSync!),
                      icon: Icons.access_time,
                      iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],

                  // Auto-sync toggle
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Switch(
                          value: platform.autoSync,
                          onChanged: (val) =>
                              setState(() => platform.autoSync = val),
                          activeTrackColor: AppColors.primary,
                        ),
                        const Spacer(),
                        const Text(
                          'مزامنة تلقائية',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Sync Now button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed:
                          isSyncing ? null : () => _syncNow(platform),
                      icon: isSyncing
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.refresh, size: 18),
                      label: Text(
                        isSyncing ? 'جاري المزامنة...' : 'مزامنة الآن',
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.md,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Disconnect button
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton(
                      onPressed: () => _disconnect(platform),
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
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'كيف تعمل المزامنة؟',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Icon(
                Icons.info_outline,
                size: 18,
                color: Colors.blue.shade700,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _InfoStep(
            number: '1',
            text: 'أضف أو عدّل منتجاتك في هنك',
          ),
          const SizedBox(height: AppSpacing.sm),
          _InfoStep(
            number: '2',
            text: 'المنتجات تُدفع تلقائياً للمنصة المربوطة',
          ),
          const SizedBox(height: AppSpacing.sm),
          _InfoStep(
            number: '3',
            text: 'الأسعار والتوفر يتحدّثان بشكل متزامن',
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'المزامنة باتجاه واحد: من هنك → المنصة الخارجية.',
            style: TextStyle(
              fontSize: 11,
              color: Colors.blue.shade600,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}

// ── Private Widgets ─────────────────────────────────────────────────────────

class _ConnectButton extends StatelessWidget {
  final VoidCallback onTap;
  const _ConnectButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        child: const Text('ربط'),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color? valueColor;

  const _StatRow({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: valueColor ?? context.colorScheme.onSurface,
          ),
        ),
        const Spacer(),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Icon(icon, size: 16, color: iconColor),
      ],
    );
  }
}

class _InfoStep extends StatelessWidget {
  final String number;
  final String text;

  const _InfoStep({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.blue.shade700,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Container(
          width: 20,
          height: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.blue.shade700,
            ),
          ),
        ),
      ],
    );
  }
}
