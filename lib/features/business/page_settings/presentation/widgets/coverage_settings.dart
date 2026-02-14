import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/coverage_zone.dart';
import 'package:honak/features/business/page_settings/presentation/providers/coverage_provider.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';

class CoverageSettings extends ConsumerWidget {
  final VoidCallback onClose;
  const CoverageSettings({super.key, required this.onClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coverageAsync = ref.watch(coverageProvider);

    return Column(
      children: [
        SubScreenAppBar(title: 'مناطق التغطية', onClose: onClose),
        Expanded(
          child: coverageAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('حدث خطأ: $e')),
            data: (data) => _CoverageBody(
              defaultFee: data.defaultFee,
              zones: data.zones,
            ),
          ),
        ),
      ],
    );
  }
}

class _CoverageBody extends ConsumerWidget {
  final int defaultFee;
  final List<CoverageZone> zones;

  const _CoverageBody({required this.defaultFee, required this.zones});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grouped = <String, List<CoverageZone>>{};
    for (final z in zones) {
      grouped.putIfAbsent(z.zone, () => []).add(z);
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        _DefaultFeeCard(fee: defaultFee),
        for (final entry in grouped.entries) ...[
          _ZoneHeader(
            zoneName: entry.key,
            zones: entry.value,
          ),
          for (final zone in entry.value)
            _NeighborhoodItem(zone: zone, defaultFee: defaultFee),
        ],
        _buildInfoBanner(),
      ],
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'حدد المناطق التي توصل لها. المناطق غير المحددة لن تظهر للعملاء عند الطلب.',
              style: TextStyle(fontSize: 11, color: Colors.blue.shade700),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.info_outline, size: 18, color: Colors.blue.shade700),
        ],
      ),
    );
  }
}

class _DefaultFeeCard extends ConsumerWidget {
  final int fee;
  const _DefaultFeeCard({required this.fee});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  final newFee = fee + 50;
                  ref.read(coverageProvider.notifier).updateDefaultFee(newFee);
                },
                icon: const Icon(Icons.add, size: 18),
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                padding: EdgeInsets.zero,
              ),
              Text(
                '$fee فلس',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: fee > 0
                    ? () {
                        final newFee = (fee - 50).clamp(0, 99999);
                        ref
                            .read(coverageProvider.notifier)
                            .updateDefaultFee(newFee);
                      }
                    : null,
                icon: const Icon(Icons.remove, size: 18),
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'رسوم التوصيل الافتراضية',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              Text(
                'تُطبق على المناطق بدون رسوم خاصة',
                style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ZoneHeader extends ConsumerWidget {
  final String zoneName;
  final List<CoverageZone> zones;

  const _ZoneHeader({required this.zoneName, required this.zones});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allActive = zones.every((z) => z.active);

    return Padding(
      padding: const EdgeInsetsDirectional.only(
        end: AppSpacing.sm,
        top: AppSpacing.lg,
        bottom: AppSpacing.sm,
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              for (final z in zones) {
                if (allActive && z.active || !allActive && !z.active) {
                  ref.read(coverageProvider.notifier).toggleZone(z.id);
                }
              }
            },
            child: Text(
              allActive ? 'إلغاء الكل' : 'تحديد الكل',
              style: const TextStyle(fontSize: 11, color: AppColors.primary),
            ),
          ),
          const Spacer(),
          Text(
            zoneName,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _NeighborhoodItem extends ConsumerWidget {
  final CoverageZone zone;
  final int defaultFee;

  const _NeighborhoodItem({required this.zone, required this.defaultFee});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = zone.active;

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 6),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary.withValues(alpha: 0.04)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.2)
              : Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          if (isActive)
            GestureDetector(
              onTap: () => _showFeeDialog(context, ref),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: zone.deliveryFee != null
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  zone.deliveryFee != null
                      ? '${zone.deliveryFee} فلس'
                      : 'افتراضي',
                  style: TextStyle(
                    fontSize: 10,
                    color: zone.deliveryFee != null
                        ? AppColors.primary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          Checkbox(
            value: isActive,
            onChanged: (_) =>
                ref.read(coverageProvider.notifier).toggleZone(zone.id),
            activeColor: AppColors.primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          const Spacer(),
          Text(zone.name, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  void _showFeeDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(
      text: zone.deliveryFee?.toString() ?? '',
    );
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'رسوم توصيل — ${zone.name}',
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 14),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'رسوم بالفلس',
                suffixText: 'فلس',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref
                  .read(coverageProvider.notifier)
                  .updateZoneFee(zone.id, null);
              Navigator.pop(ctx);
            },
            child: const Text('افتراضي'),
          ),
          TextButton(
            onPressed: () {
              final fee = int.tryParse(controller.text);
              if (fee != null) {
                ref
                    .read(coverageProvider.notifier)
                    .updateZoneFee(zone.id, fee);
              }
              Navigator.pop(ctx);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}
