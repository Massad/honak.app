import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/business_hours.dart';
import 'package:honak/features/business/page_settings/presentation/providers/hours_provider.dart';

/// Tab 2: Blocked dates — connected to provider.
class BlockedDatesTab extends ConsumerStatefulWidget {
  const BlockedDatesTab({super.key});

  @override
  ConsumerState<BlockedDatesTab> createState() =>
      _BlockedDatesTabState();
}

class _BlockedDatesTabState extends ConsumerState<BlockedDatesTab> {
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _addDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null && mounted) {
      final dateStr =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      final reason = _reasonController.text.trim();
      ref.read(blockedDatesProvider.notifier).addBlockedDate(
            BlockedDate(
              date: dateStr,
              reason: reason.isNotEmpty ? reason : null,
            ),
          );
      _reasonController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final blockedAsync = ref.watch(blockedDatesProvider);

    return blockedAsync.when(
      data: (dates) => ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          for (final date in dates) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: Theme.of(context).colorScheme.outlineVariant),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      ref
                          .read(blockedDatesProvider.notifier)
                          .removeBlockedDate(date.date);
                    },
                    icon: Icon(
                      Icons.close,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        date.date,
                        style: context.textTheme.bodyMedium,
                      ),
                      if (date.reason != null)
                        Text(
                          date.reason!,
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(
                    Icons.event_busy,
                    size: 16,
                    color: AppColors.error,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _reasonController,
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              hintText: 'سبب الإغلاق (اختياري)',
              hintStyle: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              isDense: true,
              contentPadding:
                  const EdgeInsets.all(AppSpacing.md),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton.icon(
            onPressed: _addDate,
            icon: const Icon(Icons.add, size: 16),
            label: const Text('إضافة تاريخ محظور'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(
                color:
                    AppColors.primary.withValues(alpha: 0.3),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
      loading: () =>
          const Center(child: CircularProgressIndicator()),
      error: (_, __) => Center(
        child: Text(
          'تعذر تحميل التواريخ',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ),
    );
  }
}
