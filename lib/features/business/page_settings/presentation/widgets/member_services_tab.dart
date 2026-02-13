import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/catalog_management/presentation/providers/provider.dart';
import 'package:honak/features/business/page_settings/presentation/providers/team_provider.dart';
import 'package:honak/features/business/shared/domain/entities/entities.dart';
import 'package:honak/shared/providers/business_page_provider.dart';

/// Service assignment tab inside [MemberDetailScreen].
/// Shows items grouped by category with search and checkboxes.
class MemberServicesTab extends ConsumerStatefulWidget {
  final String memberId;

  const MemberServicesTab({super.key, required this.memberId});

  @override
  ConsumerState<MemberServicesTab> createState() => _MemberServicesTabState();
}

class _MemberServicesTabState extends ConsumerState<MemberServicesTab> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final bizContext = ref.watch(businessContextProvider);
    if (bizContext == null) return const SizedBox.shrink();

    final itemsAsync = ref.watch(bizItemsProvider(bizContext.page.id));
    final members = ref.watch(teamProvider).valueOrNull ?? [];
    final member =
        members.where((m) => m.id == widget.memberId).firstOrNull;
    if (member == null) return const SizedBox.shrink();

    return itemsAsync.when(
      loading: () => const _ServicesSkeleton(),
      error: (_, __) => Center(
        child: Text(
          'تعذر تحميل الخدمات',
          style: TextStyle(color: Colors.grey.shade400),
        ),
      ),
      data: (items) {
        if (items.isEmpty) {
          return Center(
            child: Text(
              'لا توجد خدمات',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
            ),
          );
        }

        final filtered = _search.isEmpty
            ? items
            : items
                .where(
                    (i) => i.name.toLowerCase().contains(_search.toLowerCase()))
                .toList();

        // Group by category
        final grouped = <String, List<BizItem>>{};
        for (final item in filtered) {
          final cat = item.categoryName ?? 'أخرى';
          grouped.putIfAbsent(cat, () => []).add(item);
        }

        final assignedCount =
            items.where((i) => member.serviceIds.contains(i.id)).length;

        return Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: TextField(
                onChanged: (v) => setState(() => _search = v),
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintText: 'بحث...',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade400,
                  ),
                  prefixIcon:
                      Icon(Icons.search, size: 20, color: Colors.grey.shade400),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
            ),

            // Summary
            Padding(
              padding: const EdgeInsetsDirectional.only(
                end: AppSpacing.lg,
                bottom: AppSpacing.sm,
              ),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  '$assignedCount من ${items.length} خدمات معيّنة',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
                ),
              ),
            ),

            // Grouped list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                children: [
                  for (final entry in grouped.entries) ...[
                    _CategoryGroup(
                      categoryName: entry.key,
                      items: entry.value,
                      assignedIds: member.serviceIds,
                      onToggle: (serviceId) =>
                          _toggleService(serviceId, member.serviceIds),
                      onToggleAll: (ids, selected) =>
                          _toggleAllInCategory(ids, selected, member.serviceIds),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _toggleService(String serviceId, List<String> current) {
    final updated = List<String>.from(current);
    if (updated.contains(serviceId)) {
      updated.remove(serviceId);
    } else {
      updated.add(serviceId);
    }
    ref
        .read(teamProvider.notifier)
        .updateServiceIds(widget.memberId, updated);
  }

  void _toggleAllInCategory(
    List<String> categoryItemIds,
    bool selected,
    List<String> current,
  ) {
    final updated = List<String>.from(current);
    if (selected) {
      // Add all that aren't already assigned
      for (final id in categoryItemIds) {
        if (!updated.contains(id)) updated.add(id);
      }
    } else {
      updated.removeWhere(categoryItemIds.contains);
    }
    ref
        .read(teamProvider.notifier)
        .updateServiceIds(widget.memberId, updated);
  }
}

class _CategoryGroup extends StatelessWidget {
  final String categoryName;
  final List<BizItem> items;
  final List<String> assignedIds;
  final ValueChanged<String> onToggle;
  final void Function(List<String> ids, bool selected) onToggleAll;

  const _CategoryGroup({
    required this.categoryName,
    required this.items,
    required this.assignedIds,
    required this.onToggle,
    required this.onToggleAll,
  });

  @override
  Widget build(BuildContext context) {
    final itemIds = items.map((i) => i.id).toList();
    final allSelected = items.every((i) => assignedIds.contains(i.id));
    final assignedInCat = items.where((i) => assignedIds.contains(i.id)).length;

    return ExpansionTile(
      initiallyExpanded: true,
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsetsDirectional.only(start: AppSpacing.sm),
      shape: const Border(),
      title: Row(
        children: [
          // Select-all checkbox
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: allSelected,
              onChanged: (_) => onToggleAll(itemIds, !allSelected),
              activeColor: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            '$assignedInCat/${items.length}',
            style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
          ),
          const Spacer(),
          Text(
            categoryName,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
      children: [
        for (final item in items)
          _ServiceRow(
            item: item,
            assigned: assignedIds.contains(item.id),
            onToggle: () => onToggle(item.id),
          ),
      ],
    );
  }
}

class _ServiceRow extends StatelessWidget {
  final BizItem item;
  final bool assigned;
  final VoidCallback onToggle;

  const _ServiceRow({
    required this.item,
    required this.assigned,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: assigned,
                onChanged: (_) => onToggle(),
                activeColor: AppColors.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            if (item.price != null)
              Text(
                item.price!.toFormattedArabic(),
                style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
              ),
            const Spacer(),
            Text(
              item.name,
              style: TextStyle(
                fontSize: 12,
                color: assigned ? Colors.grey.shade800 : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServicesSkeleton extends StatelessWidget {
  const _ServicesSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // Search bar placeholder
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.shimmerBase,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        // Category group placeholders
        for (var i = 0; i < 2; i++) ...[
          Container(
            height: 20,
            width: 100,
            decoration: BoxDecoration(
              color: AppColors.shimmerBase,
              borderRadius: BorderRadius.circular(AppRadius.xxs),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          for (var j = 0; j < 4; j++) ...[
            Container(
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.shimmerBase,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
            const SizedBox(height: 4),
          ],
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}
