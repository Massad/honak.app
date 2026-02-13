import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/features/chat/presentation/providers/chat_provider.dart';
import 'package:honak/shared/entities/selected_item.dart';
import 'package:honak/shared/widgets/item_selection/category_filter_pills.dart';
import 'package:honak/shared/widgets/item_selection/item_configuration_step.dart';
import 'package:honak/shared/widgets/item_selection/item_tile.dart';

enum ItemPickerMode { singlePick, multiPick }

/// Unified item browse + select sheet.
///
/// Two-step flow:
/// - Step 1 (browse): search + category pills + item list tiles
/// - Step 2 (configure): shown only when item has option groups
///
/// Items without options → single tap selects immediately (step 2 skipped).
///
/// Replaces ProductPickerSheet with full option group support.
class ItemPickerSheet extends ConsumerStatefulWidget {
  final String pageSlug;
  final void Function(SelectedItem)? onItemSelected;
  final void Function(List<SelectedItem>)? onItemsSelected;
  final ItemPickerMode mode;
  final String title;
  final bool showQuantity;
  final List<SelectedItem> initialSelections;

  const ItemPickerSheet({
    super.key,
    required this.pageSlug,
    this.onItemSelected,
    this.onItemsSelected,
    this.mode = ItemPickerMode.singlePick,
    this.title = 'اختر منتج',
    this.showQuantity = true,
    this.initialSelections = const [],
  });

  @override
  ConsumerState<ItemPickerSheet> createState() => _ItemPickerSheetState();
}

class _ItemPickerSheetState extends ConsumerState<ItemPickerSheet> {
  String _searchQuery = '';
  String? _selectedCategory;

  // Step 2: item being configured (null = step 1)
  Item? _configuringItem;

  // Multi-pick selections
  late List<SelectedItem> _selections;

  @override
  void initState() {
    super.initState();
    _selections = List.of(widget.initialSelections);
  }

  bool _isItemSelected(String itemId) =>
      _selections.any((s) => s.itemId == itemId);

  void _selectItemDirect(Item item) {
    final selected = SelectedItem(
      itemId: item.id,
      name: item.nameAr,
      image: item.images.isNotEmpty ? item.images.first : null,
      basePriceCents: item.price.cents,
      categoryName: item.categoryName,
      description: item.descriptionAr,
    );

    if (widget.mode == ItemPickerMode.singlePick) {
      widget.onItemSelected?.call(selected);
      Navigator.pop(context);
    } else {
      setState(() {
        if (_isItemSelected(item.id)) {
          _selections.removeWhere((s) => s.itemId == item.id);
        } else {
          _selections.add(selected);
        }
      });
    }
  }

  void _handleItemTap(Item item) {
    if (item.optionGroups.isNotEmpty) {
      // Has options — go to step 2
      setState(() => _configuringItem = item);
    } else {
      _selectItemDirect(item);
    }
  }

  void _handleConfigured(SelectedItem selected) {
    if (widget.mode == ItemPickerMode.singlePick) {
      widget.onItemSelected?.call(selected);
      Navigator.pop(context);
    } else {
      setState(() {
        // Replace if already selected, otherwise add
        _selections.removeWhere((s) => s.itemId == selected.itemId);
        _selections.add(selected);
        _configuringItem = null;
      });
    }
  }

  void _handleMultiPickDone() {
    widget.onItemsSelected?.call(_selections);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: _configuringItem != null
              ? _buildConfigStep()
              : _buildBrowseStep(scrollController),
        );
      },
    );
  }

  Widget _buildBrowseStep(ScrollController scrollController) {
    final itemsAsync = ref.watch(businessItemsProvider(widget.pageSlug));

    return Column(
      children: [
        _buildHandle(),
        _buildBrowseHeader(),
        _buildSearchBar(),
        Expanded(
          child: itemsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Text(
                'حدث خطأ في تحميل المنتجات',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            data: (items) => _buildItemList(items, scrollController),
          ),
        ),
        if (widget.mode == ItemPickerMode.multiPick) _buildMultiPickFooter(),
      ],
    );
  }

  Widget _buildConfigStep() {
    return ItemConfigurationStep(
      item: _configuringItem!,
      showQuantity: widget.showQuantity,
      confirmLabel:
          widget.mode == ItemPickerMode.singlePick ? 'إرسال' : 'إضافة',
      onConfirm: _handleConfigured,
      onBack: () => setState(() => _configuringItem = null),
    );
  }

  Widget _buildHandle() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: AppSpacing.sm),
      child: Container(
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.divider,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildBrowseHeader() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.lg,
        end: AppSpacing.sm,
        top: AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, size: 20),
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      child: TextField(
        onChanged: (v) => setState(() => _searchQuery = v),
        decoration: InputDecoration(
          hintText: 'بحث...',
          hintStyle: const TextStyle(
            color: AppColors.textHint,
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 20,
            color: AppColors.textHint,
          ),
          filled: true,
          fillColor: AppColors.background,
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

  Widget _buildItemList(List<Item> items, ScrollController controller) {
    final categories = items
        .where((i) => i.categoryName != null)
        .map((i) => i.categoryName!)
        .toSet()
        .toList();

    var filtered = items.where((item) {
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final nameMatch = item.nameAr.toLowerCase().contains(q) ||
            (item.nameEn?.toLowerCase().contains(q) ?? false);
        final descMatch =
            item.descriptionAr?.toLowerCase().contains(q) ?? false;
        if (!nameMatch && !descMatch) return false;
      }
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
              ? const Center(
                  child: Text(
                    'لا توجد نتائج',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                )
              : ListView.separated(
                  controller: controller,
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const Divider(
                    height: 1,
                    color: AppColors.divider,
                  ),
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    final isSelected = _isItemSelected(item.id);

                    return Stack(
                      children: [
                        ItemTile(
                          item: item,
                          onTap: () => _handleItemTap(item),
                        ),
                        if (widget.mode == ItemPickerMode.multiPick &&
                            isSelected)
                          Positioned.directional(
                            textDirection: Directionality.of(context),
                            end: 0,
                            top: 0,
                            bottom: 0,
                            child: const Center(
                              child: Icon(
                                Icons.check_circle,
                                size: 20,
                                color: AppColors.success,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildMultiPickFooter() {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md + MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.divider, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Text(
            '${_selections.length} عنصر محدد',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          FilledButton(
            onPressed: _selections.isNotEmpty ? _handleMultiPickDone : null,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'تم',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
