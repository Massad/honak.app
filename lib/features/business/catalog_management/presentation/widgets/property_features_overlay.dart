import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/property_feature_items.dart';

/// Full-screen overlay for managing property features (categories + items).
/// Matches Figma PropertyFeatures.tsx pixel-for-pixel.
class PropertyFeaturesOverlay extends StatefulWidget {
  final VoidCallback onClose;
  final int maxGuests;
  final int bedrooms;
  final int bathrooms;
  final List<String> amenities;

  const PropertyFeaturesOverlay({
    super.key,
    required this.onClose,
    this.maxGuests = 10,
    this.bedrooms = 4,
    this.bathrooms = 3,
    this.amenities = const [],
  });

  @override
  State<PropertyFeaturesOverlay> createState() =>
      _PropertyFeaturesOverlayState();
}

class _PropertyFeaturesOverlayState extends State<PropertyFeaturesOverlay> {
  late List<FeatureCategory> _categories;
  String? _expandedCat;
  bool _reorderMode = false;
  bool _saved = false;

  // Category CRUD
  bool _addingCat = false;
  final _newCatCtrl = TextEditingController();
  String? _editingCatId;
  final _editCatCtrl = TextEditingController();

  // Item CRUD
  String? _addingItemToCat;
  String? _editingItemId;
  final _editItemCtrl = TextEditingController();
  String? _showSuggestions;

  @override
  void initState() {
    super.initState();
    _categories = buildDefaultCategories(
      maxGuests: widget.maxGuests,
      bedrooms: widget.bedrooms,
      bathrooms: widget.bathrooms,
      amenities: widget.amenities,
    );
    _expandedCat = _categories.firstOrNull?.id;
  }

  @override
  void dispose() {
    _newCatCtrl.dispose();
    _editCatCtrl.dispose();
    _editItemCtrl.dispose();
    super.dispose();
  }

  int get _totalItems =>
      _categories.fold(0, (s, c) => s + c.items.length);
  int get _totalEnabled =>
      _categories.fold(0, (s, c) => s + c.enabledCount);

  List<String> get _allItemNames =>
      _categories.expand((c) => c.items.map((i) => i.name)).toList();

  String _genId() =>
      'f_${DateTime.now().millisecondsSinceEpoch}_'
      '${(_categories.length + 1).toString()}';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xxxl),
            children: [
              for (int ci = 0; ci < _categories.length; ci++) ...[
                _buildCategoryCard(context, _categories[ci], ci),
                const SizedBox(height: AppSpacing.md),
              ],
              _buildAddCategory(context),
              const SizedBox(height: AppSpacing.md),
              _buildTip(context),
            ],
          ),
        ),
      ],
    );
  }

  // ── Header ──────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
            bottom: BorderSide(color: context.colorScheme.outlineVariant)),
      ),
      child: Column(
        children: [
          Row(children: [
            GestureDetector(
              onTap: widget.onClose,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Icon(Icons.arrow_forward_ios, size: 14,
                    color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('وصف العقار', style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurface)),
                Text('${_categories.length} تصنيف · '
                    '$_totalEnabled مفعّل من $_totalItems',
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.textHint)),
              ],
            )),
            const SizedBox(width: AppSpacing.md),
            GestureDetector(
              onTap: () {
                setState(() => _saved = true);
                Future.delayed(const Duration(seconds: 2),
                    () { if (mounted) setState(() => _saved = false); });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg, vertical: 6),
                decoration: BoxDecoration(
                  color: _saved ? AppColors.success : AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: _saved
                    ? const Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.check, size: 12, color: Colors.white),
                        SizedBox(width: 4),
                        Text('تم الحفظ', style: TextStyle(
                            fontSize: 12, color: Colors.white)),
                      ])
                    : const Text('حفظ', style: TextStyle(
                        fontSize: 12, color: Colors.white)),
              ),
            ),
          ]),
          const SizedBox(height: AppSpacing.md),
          Row(children: [
            GestureDetector(
              onTap: () => setState(() => _reorderMode = !_reorderMode),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: _reorderMode
                      ? AppColors.primary : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.drag_indicator, size: 10,
                      color: _reorderMode
                          ? Colors.white : AppColors.textHint),
                  const SizedBox(width: 4),
                  Text(_reorderMode ? 'تم' : 'ترتيب',
                      style: TextStyle(fontSize: 10,
                          color: _reorderMode
                              ? Colors.white : AppColors.textHint)),
                ]),
              ),
            ),
            const Spacer(),
            const Text('أضف تصنيفات وعناصر لوصف العقار بالكامل',
                style: TextStyle(fontSize: 10, color: AppColors.textHint)),
          ]),
        ],
      ),
    );
  }

  // ── Category Card ───────────────────────────────────────────
  Widget _buildCategoryCard(
      BuildContext context, FeatureCategory cat, int idx) {
    final expanded = _expandedCat == cat.id;
    final isEditingCat = _editingCatId == cat.id;

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: context.colorScheme.outlineVariant),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4, offset: const Offset(0, 1))],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Category header
          GestureDetector(
            onTap: () => setState(() =>
                _expandedCat = expanded ? null : cat.id),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  if (_reorderMode) ...[
                    Column(mainAxisSize: MainAxisSize.min, children: [
                      GestureDetector(
                        onTap: idx > 0
                            ? () => _moveCat(idx, idx - 1) : null,
                        child: Icon(Icons.arrow_upward, size: 12,
                            color: idx > 0
                                ? AppColors.primary : AppColors.divider),
                      ),
                      const SizedBox(height: 2),
                      GestureDetector(
                        onTap: idx < _categories.length - 1
                            ? () => _moveCat(idx, idx + 1) : null,
                        child: Icon(Icons.arrow_downward, size: 12,
                            color: idx < _categories.length - 1
                                ? AppColors.primary : AppColors.divider),
                      ),
                    ]),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                  Icon(expanded ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                      size: 14, color: AppColors.textHint),
                  if (!isEditingCat) ...[
                    const SizedBox(width: AppSpacing.xs),
                    if (_categories.length > 1)
                      GestureDetector(
                        onTap: () => _deleteCat(cat.id),
                        child: const Icon(Icons.delete_outline, size: 12,
                            color: AppColors.textHint),
                      ),
                    const SizedBox(width: AppSpacing.xs),
                    GestureDetector(
                      onTap: () => setState(() {
                        _editingCatId = cat.id;
                        _editCatCtrl.text = cat.name;
                      }),
                      child: const Icon(Icons.edit_outlined, size: 12,
                          color: AppColors.textHint),
                    ),
                  ],
                  const Spacer(),
                  if (isEditingCat)
                    Expanded(child: Row(children: [
                      GestureDetector(
                        onTap: () => setState(() => _editingCatId = null),
                        child: Icon(Icons.close, size: 14,
                            color: AppColors.textHint),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => _renameCat(cat.id),
                        child: const Icon(Icons.check, size: 14,
                            color: AppColors.success),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(child: TextField(
                        controller: _editCatCtrl,
                        autofocus: true,
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.surfaceVariant,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(AppRadius.sm),
                            borderSide: BorderSide(
                                color: context.colorScheme.outlineVariant)),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xs),
                        ),
                        onSubmitted: (_) => _renameCat(cat.id),
                      )),
                    ]))
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(cat.name, style: TextStyle(fontSize: 14,
                            color: context.colorScheme.onSurface)),
                        Text('${cat.enabledCount} / ${cat.items.length} عنصر',
                            style: const TextStyle(
                                fontSize: 9, color: AppColors.textHint)),
                      ],
                    ),
                  const SizedBox(width: AppSpacing.sm),
                  const Icon(Icons.label_outlined, size: 14,
                      color: AppColors.primary),
                ],
              ),
            ),
          ),
          // Items
          if (expanded) _buildCategoryItems(context, cat),
        ],
      ),
    );
  }

  Widget _buildCategoryItems(BuildContext context, FeatureCategory cat) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: AppColors.surfaceVariant)),
      ),
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.md),
      child: Column(
        children: [
          if (cat.items.isEmpty && _addingItemToCat != cat.id)
            _buildEmptyItems(),
          for (int i = 0; i < cat.items.length; i++) ...[
            FeatureItemRow(
              item: cat.items[i],
              reorderMode: _reorderMode,
              isFirst: i == 0,
              isLast: i == cat.items.length - 1,
              isEditing: _editingItemId == cat.items[i].id,
              editCtrl: _editingItemId == cat.items[i].id
                  ? _editItemCtrl : null,
              onToggle: () => _toggleItem(cat.id, i),
              onCountChange: (c) => _updateCount(cat.id, i, c),
              onEditStart: () => setState(() {
                _editingItemId = cat.items[i].id;
                _editItemCtrl.text = cat.items[i].name;
              }),
              onEditSave: () => _renameItem(cat.id, i),
              onEditCancel: () =>
                  setState(() => _editingItemId = null),
              onDelete: () => _deleteItem(cat.id, i),
              onMoveUp: () => _moveItem(cat.id, i, i - 1),
              onMoveDown: () => _moveItem(cat.id, i, i + 1),
            ),
            const SizedBox(height: 6),
          ],
          const SizedBox(height: AppSpacing.sm),
          if (_addingItemToCat == cat.id)
            AddItemForm(
              onAdd: (item) {
                setState(() {
                  cat.items.add(item);
                  _addingItemToCat = null;
                });
              },
              onCancel: () =>
                  setState(() => _addingItemToCat = null),
            )
          else
            Row(children: [
              if (suggestedItems.any(
                  (s) => !_allItemNames.contains(s.name)))
                GestureDetector(
                  onTap: () => setState(() => _showSuggestions =
                      _showSuggestions == cat.id ? null : cat.id),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(
                          color: context.colorScheme.outlineVariant,
                          style: BorderStyle.solid),
                    ),
                    child: const Row(
                        mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.auto_awesome, size: 10,
                          color: AppColors.textHint),
                      SizedBox(width: 4),
                      Text('اقتراحات', style: TextStyle(
                          fontSize: 10, color: AppColors.textHint)),
                    ]),
                  ),
                ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: GestureDetector(
                onTap: () => setState(() {
                  _addingItemToCat = cat.id;
                  _showSuggestions = null;
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(
                        color: context.colorScheme.outlineVariant,
                        style: BorderStyle.solid),
                  ),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Icon(Icons.add, size: 10, color: AppColors.textHint),
                    SizedBox(width: 4),
                    Text('إضافة عنصر', style: TextStyle(
                        fontSize: 10, color: AppColors.textHint)),
                  ]),
                ),
              )),
            ]),
          if (_showSuggestions == cat.id) ...[
            const SizedBox(height: AppSpacing.sm),
            SuggestionsPanel(
              existingNames: _allItemNames,
              onAdd: (item) => setState(() => cat.items.add(item)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyItems() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: Column(children: [
        Icon(Icons.label_outlined, size: 24,
            color: AppColors.divider),
        const SizedBox(height: AppSpacing.sm),
        const Text('لا توجد عناصر بعد',
            style: TextStyle(fontSize: 12, color: AppColors.textHint)),
        const Text('أضف عناصر لوصف هذا التصنيف',
            style: TextStyle(fontSize: 10, color: AppColors.divider)),
      ]),
    );
  }

  // ── Add Category ────────────────────────────────────────────
  Widget _buildAddCategory(BuildContext context) {
    if (_addingCat) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: const Color(0xFFBBDEFB)),
        ),
        child: Column(children: [
          TextField(
            controller: _newCatCtrl,
            autofocus: true,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 12),
            decoration: InputDecoration(
              hintText: 'اسم التصنيف الجديد...',
              filled: true,
              fillColor: AppColors.surfaceVariant,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                borderSide: BorderSide(
                    color: context.colorScheme.outlineVariant)),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
            ),
            onSubmitted: (_) => _addCat(),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(children: [
            Expanded(child: GestureDetector(
              onTap: _addCat,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 12, color: Colors.white),
                    SizedBox(width: 4),
                    Text('إضافة تصنيف', style: TextStyle(
                        fontSize: 12, color: Colors.white)),
                  ],
                ),
              ),
            )),
            const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: () => setState(() {
                _addingCat = false;
                _newCatCtrl.clear();
              }),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Text('إلغاء', style: TextStyle(
                    fontSize: 12, color: AppColors.textSecondary)),
              ),
            ),
          ]),
        ]),
      );
    }

    return GestureDetector(
      onTap: () => setState(() => _addingCat = true),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
              color: context.colorScheme.outlineVariant,
              style: BorderStyle.solid),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('إضافة تصنيف جديد', style: TextStyle(
                fontSize: 12, color: AppColors.textHint)),
            SizedBox(width: AppSpacing.sm),
            Icon(Icons.create_new_folder_outlined, size: 14,
                color: AppColors.textHint),
          ],
        ),
      ),
    );
  }

  Widget _buildTip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: const Color(0xFFBBDEFB)),
      ),
      child: const Text(
        'أضف تصنيفات مثل "المرافق الترفيهية" أو "خدمات إضافية" '
        'ثم أضف العناصر داخلها. يمكنك ترتيب التصنيفات والعناصر حسب الأهمية.',
        style: TextStyle(fontSize: 10, color: AppColors.primary),
        textAlign: TextAlign.center,
      ),
    );
  }

  // ── CRUD Operations ─────────────────────────────────────────

  void _addCat() {
    final name = _newCatCtrl.text.trim();
    if (name.isEmpty) return;
    final cat = FeatureCategory(id: _genId(), name: name);
    setState(() {
      _categories.add(cat);
      _newCatCtrl.clear();
      _addingCat = false;
      _expandedCat = cat.id;
    });
  }

  void _renameCat(String catId) {
    final name = _editCatCtrl.text.trim();
    if (name.isEmpty) return;
    setState(() {
      _categories.firstWhere((c) => c.id == catId).name = name;
      _editingCatId = null;
    });
  }

  void _deleteCat(String catId) {
    setState(() {
      _categories.removeWhere((c) => c.id == catId);
      if (_expandedCat == catId) _expandedCat = null;
    });
  }

  void _moveCat(int from, int to) {
    setState(() {
      final cat = _categories.removeAt(from);
      _categories.insert(to, cat);
    });
  }

  void _toggleItem(String catId, int idx) {
    setState(() {
      final item = _findCat(catId).items[idx];
      item.enabled = !item.enabled;
    });
  }

  void _updateCount(String catId, int idx, int count) {
    setState(() {
      _findCat(catId).items[idx].count = count.clamp(0, 999);
    });
  }

  void _renameItem(String catId, int idx) {
    final name = _editItemCtrl.text.trim();
    if (name.isEmpty) return;
    setState(() {
      _findCat(catId).items[idx].name = name;
      _editingItemId = null;
    });
  }

  void _deleteItem(String catId, int idx) {
    setState(() => _findCat(catId).items.removeAt(idx));
  }

  void _moveItem(String catId, int from, int to) {
    setState(() {
      final items = _findCat(catId).items;
      if (to < 0 || to >= items.length) return;
      final item = items.removeAt(from);
      items.insert(to, item);
    });
  }

  FeatureCategory _findCat(String catId) =>
      _categories.firstWhere((c) => c.id == catId);
}
