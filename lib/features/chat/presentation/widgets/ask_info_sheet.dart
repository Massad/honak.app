import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/data/chat_info_template_store.dart';
import 'package:honak/features/chat/domain/entities/chat_info_template_item.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/features/chat/presentation/widgets/ask_info_edit_widgets.dart';
import 'package:honak/shared/widgets/app_dialog_templates.dart';
import 'package:honak/shared/widgets/button.dart';
import 'package:honak/shared/widgets/selectable_tile.dart';

/// Bottom sheet for composing a structured info request.
///
/// Has two modes:
/// - **Send mode** (default): checklist + notes + send button
/// - **Edit mode**: inline editing, reorder arrows, add/delete, type picker
class AskInfoSheet extends ConsumerStatefulWidget {
  final String pageId;
  final String? businessTypeId;
  final void Function(AskInfoResult result) onSend;

  const AskInfoSheet({
    super.key,
    required this.pageId,
    this.businessTypeId,
    required this.onSend,
  });

  @override
  ConsumerState<AskInfoSheet> createState() => _AskInfoSheetState();
}

class _AskInfoSheetState extends ConsumerState<AskInfoSheet> {
  final _notesController = TextEditingController();
  final _searchController = TextEditingController();
  String? _selectedId;
  bool _isEditMode = false;
  bool _showAll = false;
  String _searchQuery = '';

  /// How many items to show before "عرض المزيد".
  static const _initialVisibleCount = 10;

  String get _familyKey => '${widget.pageId}:${widget.businessTypeId ?? ''}';

  @override
  void dispose() {
    _notesController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(pageInfoTemplatesProvider(_familyKey));

    return itemsAsync.when(
      loading: () => const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SizedBox(height: 200, child: Center(child: Text('$e'))),
      data: (items) => _isEditMode
          ? _buildEditMode(context, items)
          : _buildSendMode(context, items),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Send Mode
  // ═══════════════════════════════════════════════════════════════

  Widget _buildSendMode(
    BuildContext context,
    List<ChatInfoTemplateItem> items,
  ) {
    final validItems = items.where((item) => item.isValid).toList();
    final invalidCount = items.length - validItems.length;
    final filtered = _applySearch(validItems);
    final visible = _applyLoadMore(filtered);
    final hasMore = filtered.length > visible.length;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHandle(),
        _buildHeader(context),
        if (validItems.length > _initialVisibleCount) _buildSearchBar(),
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (invalidCount > 0)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: AppSpacing.sm,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 14,
                          color: AppColors.error,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          '$invalidCount عنصر يحتاج تعديل',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ...visible.map((item) => _buildRadioRow(item)),
                if (hasMore) _buildLoadMoreButton(),
                const SizedBox(height: AppSpacing.lg),
                _buildNotesField(),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
        _buildSendButton(context),
      ],
    );
  }

  /// Shared header for both modes — matching Figma layout:
  /// RTL: `>` chevron | `?` icon | title ... | "تعديل"/"تم" chip | `×` close
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.sm,
        end: AppSpacing.sm,
        top: AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.help_outline_rounded,
              size: 18,
              color: AppColors.warning,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'طلب معلومات',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
          // Edit/Done chip
          GestureDetector(
            onTap: () => setState(() => _isEditMode = !_isEditMode),
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: _isEditMode
                    ? AppColors.warning
                    : context.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.tune_rounded,
                    size: 14,
                    color: _isEditMode
                        ? Colors.white
                        : context.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _isEditMode ? 'تم' : 'تعديل',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _isEditMode
                          ? Colors.white
                          : context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Button(
            onPressed: () => Navigator.pop(context),
            icon: ButtonIcon(
              Icons.close,
              size: 20,
              color: context.colorScheme.onSurfaceVariant,
            ),
            variant: Variant.text,
            size: ButtonSize.small,
          ),
        ],
      ),
    );
  }

  Widget _buildRadioRow(ChatInfoTemplateItem item) {
    final isSelected = _selectedId == item.id;
    final icon = infoItemTypeIcon(item.type);

    // Show description, or comma-separated options as fallback for choice items.
    final descText =
        item.descriptionAr ??
        (item.type == 'choice' && item.optionsAr != null
            ? item.optionsAr!.join('، ')
            : null);

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      child: SelectableTile(
        leading: Icon(icon, size: 20, color: AppColors.warning),
        title: item.labelAr,
        titleSuffix: item.required
            ? const Text(
                '*',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.error,
                ),
              )
            : null,
        subtitle: descText,
        isSelected: isSelected,
        selectionStyle: TileSelectionStyle.radio,
        onTap: () => setState(() {
          _selectedId = isSelected ? null : item.id;
        }),
      ),
    );
  }

  Widget _buildNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ملاحظات (اختياري)',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _notesController,
          maxLines: 3,
          minLines: 2,
          maxLength: InfoRequestLimits.maxNoteLength,
          decoration: InputDecoration(
            hintText: 'أضف ملاحظة للعميل...',
            counterText: '',
            hintStyle: TextStyle(
              color: context.colorScheme.onSurfaceVariant,
              fontSize: 14,
            ),
            filled: true,
            fillColor: context.colorScheme.surfaceContainerLowest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsetsDirectional.all(AppSpacing.md),
            isDense: true,
          ),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildSendButton(BuildContext context) {
    final canSend = _selectedId != null;
    return Padding(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      child: Button(
        onPressed: canSend ? () => _send(context) : null,
        label: 'إرسال',
        icon: ButtonIcon.backArrow(),
        style: Style.warning,
        size: ButtonSize.large,
        expand: true,
      ),
    );
  }

  void _send(BuildContext context) {
    final items = ref.read(pageInfoTemplatesProvider(_familyKey)).valueOrNull;
    if (items == null || _selectedId == null) return;

    final selectedItem = items
        .where((item) => item.id == _selectedId)
        .firstOrNull;
    if (selectedItem == null) return;

    // Validate selected item.
    if (!selectedItem.isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(selectedItem.validationError ?? 'عنصر غير صالح'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final note = _notesController.text.trim().isNotEmpty
        ? _notesController.text.trim()
        : null;

    widget.onSend(AskInfoResult(selectedItem: selectedItem, note: note));
    Navigator.pop(context);
  }

  // ═══════════════════════════════════════════════════════════════
  // Edit Mode
  // ═══════════════════════════════════════════════════════════════

  Widget _buildEditMode(
    BuildContext context,
    List<ChatInfoTemplateItem> items,
  ) {
    final filtered = _applySearch(items);
    final visible = _applyLoadMore(filtered);
    final hasMore = filtered.length > visible.length;
    final notifier = ref.read(pageInfoTemplatesProvider(_familyKey).notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHandle(),
        _buildHeader(context),
        if (items.length > _initialVisibleCount) _buildSearchBar(),
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < visible.length; i++)
                  EditItemCard(
                    item: visible[i],
                    index: i,
                    totalCount: visible.length,
                    onUpdate: (updated) => notifier.updateItem(updated),
                    onRemove: () => notifier.removeItem(visible[i].id),
                    onMoveUp: i > 0
                        ? () => _reorder(items, visible[i], -1, notifier)
                        : null,
                    onMoveDown: i < visible.length - 1
                        ? () => _reorder(items, visible[i], 1, notifier)
                        : null,
                  ),
                if (hasMore) _buildLoadMoreButton(),
                const SizedBox(height: AppSpacing.sm),
                if (items.length < InfoRequestLimits.maxItemsPerTemplate)
                  _buildAddButton(notifier),
                const SizedBox(height: AppSpacing.md),
                _buildResetButton(notifier),
                const SizedBox(height: AppSpacing.sm),
              ],
            ),
          ),
        ),
        // Item count footer
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Text(
            '${items.length} عنصر',
            style: TextStyle(
              fontSize: 13,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  void _reorder(
    List<ChatInfoTemplateItem> allItems,
    ChatInfoTemplateItem item,
    int direction,
    PageInfoTemplatesNotifier notifier,
  ) {
    final list = List<ChatInfoTemplateItem>.from(allItems);
    final currentIndex = list.indexWhere((e) => e.id == item.id);
    if (currentIndex < 0) return;

    final targetIndex = currentIndex + direction;
    if (targetIndex < 0 || targetIndex >= list.length) return;

    final removed = list.removeAt(currentIndex);
    list.insert(targetIndex, removed);
    notifier.reorder(list);
  }

  Widget _buildAddButton(PageInfoTemplatesNotifier notifier) {
    return GestureDetector(
      onTap: () {
        final id = 'tpl_${DateTime.now().millisecondsSinceEpoch}';
        notifier.addItem(
          ChatInfoTemplateItem(id: id, labelAr: '', type: 'text'),
        );
        // If user had collapsed extra items, expand them to see the new one.
        setState(() => _showAll = true);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'إضافة عنصر جديد',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(Icons.add_circle_outline, size: 20, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildResetButton(PageInfoTemplatesNotifier notifier) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          final confirmed = await showAppDangerConfirmDialog(
            context,
            title: 'استعادة الافتراضي؟',
            message: 'سيتم إرجاع القائمة للعناصر الافتراضية وحذف أي تعديلات.',
            confirmLabel: 'استعادة',
            cancelLabel: 'إلغاء',
          );
          if (confirmed) {
            await notifier.resetToDefaults();
          }
        },
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: AppSpacing.sm,
          ),
          child: Text(
            'استعادة الافتراضي',
            style: TextStyle(
              fontSize: 12,
              color: context.colorScheme.onSurfaceVariant,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Shared
  // ═══════════════════════════════════════════════════════════════

  Widget _buildHandle() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: AppSpacing.sm),
      child: Container(
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          color: context.colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(2),
        ),
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
        controller: _searchController,
        onChanged: (v) => setState(() => _searchQuery = v.trim()),
        decoration: InputDecoration(
          hintText: 'بحث...',
          hintStyle: TextStyle(
            color: context.colorScheme.onSurfaceVariant,
            fontSize: 13,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 18,
            color: context.colorScheme.onSurfaceVariant,
          ),
          filled: true,
          fillColor: context.colorScheme.surfaceContainerLowest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          isDense: true,
        ),
        style: const TextStyle(fontSize: 13),
      ),
    );
  }

  Widget _buildLoadMoreButton() {
    return GestureDetector(
      onTap: () => setState(() => _showAll = true),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpacing.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.expand_more, size: 18, color: AppColors.primary),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'عرض المزيد',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ChatInfoTemplateItem> _applySearch(List<ChatInfoTemplateItem> items) {
    if (_searchQuery.isEmpty) return items;
    return items.where((item) {
      return item.labelAr.contains(_searchQuery) ||
          (item.descriptionAr?.contains(_searchQuery) ?? false);
    }).toList();
  }

  List<ChatInfoTemplateItem> _applyLoadMore(List<ChatInfoTemplateItem> items) {
    if (_showAll || items.length <= _initialVisibleCount) return items;
    return items.sublist(0, _initialVisibleCount);
  }
}
