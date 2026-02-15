import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/features/chat/presentation/providers/chat_provider.dart';
import 'package:honak/shared/widgets/item_selection/category_filter_pills.dart';
import 'package:honak/shared/widgets/item_selection/item_tile.dart';

/// Browse content for ItemPickerSheet: search + team filter + category filter + item list.
class ItemBrowseStep extends ConsumerStatefulWidget {
  final String pageSlug;
  final bool showRadio;
  final List<Map<String, dynamic>> teamMembers;
  final Item? selectedItem;
  final Set<String> selectedIds;
  final void Function(Item) onItemTap;

  const ItemBrowseStep({
    super.key,
    required this.pageSlug,
    this.showRadio = true,
    this.teamMembers = const [],
    this.selectedItem,
    this.selectedIds = const {},
    required this.onItemTap,
  });

  @override
  ConsumerState<ItemBrowseStep> createState() => _ItemBrowseStepState();
}

class _ItemBrowseStepState extends ConsumerState<ItemBrowseStep> {
  String _searchQuery = '';
  String? _selectedCategory;
  String? _selectedTeamMemberId;

  List<Map<String, dynamic>> get _activeMembers =>
      widget.teamMembers.where((m) => m['active'] != false).toList();

  bool _isItemSelected(String itemId) {
    if (widget.selectedItem != null) {
      return widget.selectedItem!.id == itemId;
    }
    return widget.selectedIds.contains(itemId);
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final itemsAsync = ref.watch(businessItemsProvider(widget.pageSlug));

    return Column(
      children: [
        _buildSearchBar(cs),
        if (_activeMembers.isNotEmpty) _buildTeamFilterPills(cs),
        Flexible(
          child: itemsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Text(
                'حدث خطأ في تحميل المنتجات',
                style: TextStyle(color: cs.onSurfaceVariant),
              ),
            ),
            data: (items) => _buildItemList(items, cs),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      child: TextField(
        onChanged: (v) => setState(() => _searchQuery = v),
        decoration: InputDecoration(
          hintText: 'بحث...',
          hintStyle: TextStyle(
            color: cs.onSurfaceVariant,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 20,
            color: cs.onSurfaceVariant,
          ),
          filled: true,
          fillColor: cs.surfaceContainerLowest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          isDense: true,
        ),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildTeamFilterPills(ColorScheme cs) {
    final primary = cs.primary;
    final members = _activeMembers;

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        itemCount: members.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final isAll = index == 0;
          final label = isAll ? 'الكل' : (members[index - 1]['name'] as String? ?? '');
          final memberId = isAll ? null : (members[index - 1]['id'] as String? ?? '');
          final isActive = isAll
              ? _selectedTeamMemberId == null
              : _selectedTeamMemberId == memberId;

          return GestureDetector(
            onTap: () {
              setState(() {
                if (isAll) {
                  _selectedTeamMemberId = null;
                } else if (_selectedTeamMemberId == memberId) {
                  _selectedTeamMemberId = null;
                } else {
                  _selectedTeamMemberId = memberId;
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? primary
                    : cs.surfaceContainerHighest.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(9999),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: primary.withValues(alpha: 0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.white : cs.onSurfaceVariant,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemList(List<Item> items, ColorScheme cs) {
    final categories = items
        .where((i) => i.categoryName != null)
        .map((i) => i.categoryName!)
        .toSet()
        .toList();

    var filtered = items.where((item) {
      // Team member filter
      if (_selectedTeamMemberId != null) {
        if (item.teamMemberIds.isNotEmpty &&
            !item.teamMemberIds.contains(_selectedTeamMemberId)) {
          return false;
        }
      }
      // Search filter
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final nameMatch = item.nameAr.toLowerCase().contains(q) ||
            (item.nameEn?.toLowerCase().contains(q) ?? false);
        final descMatch =
            item.descriptionAr?.toLowerCase().contains(q) ?? false;
        if (!nameMatch && !descMatch) return false;
      }
      // Category filter
      if (_selectedCategory != null) {
        return item.categoryName == _selectedCategory;
      }
      return true;
    }).toList();

    return Column(
      children: [
        if (categories.isNotEmpty)
          CategoryFilterPills(
            categories: categories,
            selected: _selectedCategory,
            onSelected: (cat) => setState(() => _selectedCategory = cat),
          ),
        const SizedBox(height: AppSpacing.xs),
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Text(
                    'لا توجد نتائج',
                    style: TextStyle(
                      color: cs.onSurfaceVariant,
                      fontSize: 14,
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    return ItemTile(
                      item: item,
                      onTap: () => widget.onItemTap(item),
                      isSelected: _isItemSelected(item.id),
                      showRadio: widget.showRadio,
                    );
                  },
                ),
        ),
      ],
    );
  }
}
