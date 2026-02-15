import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/catalog_management/presentation/providers/provider.dart';
import 'package:honak/features/business/catalog_management/presentation/providers/stock_manager_provider.dart';
import 'package:honak/features/business/shared/domain/entities/biz_item.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

// ═══════════════════════════════════════════════════════════════
// Stock Manager Sheet
// Quick batch stock update for catalog-based businesses.
// ═══════════════════════════════════════════════════════════════

/// Default low-stock threshold when item doesn't specify one.
const _kDefaultThreshold = 10;

/// Opens the stock manager as a full-height bottom sheet.
Future<void> showStockManagerSheet(
  BuildContext context, {
  required String pageId,
  StockFilterMode initialFilter = StockFilterMode.all,
}) {
  return showAppSheet(
    context,
    builder: (_) => _StockManagerContent(
      pageId: pageId,
      initialFilter: initialFilter,
    ),
  );
}

class _StockManagerContent extends ConsumerStatefulWidget {
  const _StockManagerContent({
    required this.pageId,
    this.initialFilter = StockFilterMode.all,
  });

  final String pageId;
  final StockFilterMode initialFilter;

  @override
  ConsumerState<_StockManagerContent> createState() =>
      _StockManagerContentState();
}

class _StockManagerContentState extends ConsumerState<_StockManagerContent> {
  String? _editingThresholdId;

  @override
  void initState() {
    super.initState();
    // Set initial filter if coming from low-stock alert
    if (widget.initialFilter != StockFilterMode.all) {
      Future.microtask(() {
        ref.read(stockFilterModeProvider.notifier).state =
            widget.initialFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(bizItemsProvider(widget.pageId));
    final searchQuery = ref.watch(stockSearchQueryProvider);
    final filterMode = ref.watch(stockFilterModeProvider);
    final stockChanges = ref.watch(stockChangesProvider);
    final thresholdChanges = ref.watch(thresholdChangesProvider);
    final totalChanges = ref.watch(totalPendingChangesProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        _Header(totalChanges: totalChanges),
        Divider(height: 1, color: context.colorScheme.outlineVariant),

        // Search + Filters
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            0,
          ),
          child: Column(
            children: [
              _SearchField(
                value: searchQuery,
                onChanged: (v) =>
                    ref.read(stockSearchQueryProvider.notifier).state = v,
              ),
              const SizedBox(height: AppSpacing.sm),
              itemsAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (items) => _FilterPills(
                  items: items,
                  active: filterMode,
                  onChanged: (mode) =>
                      ref.read(stockFilterModeProvider.notifier).state = mode,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),

        // Items list
        Flexible(
          child: itemsAsync.when(
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.xxl),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (e, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Text('خطأ: $e'),
              ),
            ),
            data: (items) {
              final filtered = _applyFilters(
                items,
                searchQuery,
                filterMode,
                stockChanges,
                thresholdChanges,
              );

              if (filtered.isEmpty) {
                return _EmptyState(filterMode: filterMode);
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                itemCount: filtered.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final item = filtered[index];
                  return _StockItemCard(
                    item: item,
                    stockChange: stockChanges[item.id],
                    thresholdChange: thresholdChanges[item.id],
                    isEditingThreshold: _editingThresholdId == item.id,
                    onToggleThresholdEdit: () {
                      setState(() {
                        _editingThresholdId =
                            _editingThresholdId == item.id ? null : item.id;
                      });
                    },
                  );
                },
              );
            },
          ),
        ),

        // Footer action bar
        _FooterBar(totalChanges: totalChanges),
      ],
    );
  }

  List<BizItem> _applyFilters(
    List<BizItem> items,
    String query,
    StockFilterMode mode,
    Map<String, dynamic> stockChanges,
    Map<String, dynamic> thresholdChanges,
  ) {
    var result = items.where((i) => i.stock != null).toList();

    // Filter by mode
    switch (mode) {
      case StockFilterMode.low:
        result = result.where((i) {
          final stock = i.stock ?? 0;
          final threshold = _kDefaultThreshold;
          return stock > 0 && stock <= threshold;
        }).toList();
      case StockFilterMode.out:
        result = result.where((i) => (i.stock ?? 0) <= 0).toList();
      case StockFilterMode.all:
        break;
    }

    // Search
    if (query.trim().isNotEmpty) {
      final q = query.trim().toLowerCase();
      result = result
          .where((i) =>
              i.name.toLowerCase().contains(q) ||
              (i.categoryName?.toLowerCase().contains(q) ?? false))
          .toList();
    }

    return result;
  }
}

// ─────────────────────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────────────────────

class _Header extends ConsumerWidget {
  const _Header({required this.totalChanges});
  final int totalChanges;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 16,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'تحديث المخزون',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSurface,
            ),
          ),
          if (totalChanges > 0) ...[
            const SizedBox(width: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$totalChanges تعديل',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.amber.shade800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 14,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Search Field
// ─────────────────────────────────────────────────────────────

class _SearchField extends StatelessWidget {
  const _SearchField({required this.value, required this.onChanged});
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'ابحث عن منتج...',
        hintStyle: TextStyle(
          fontSize: 12,
          color: context.colorScheme.onSurfaceVariant,
        ),
        prefixIcon: Icon(
          Icons.search,
          size: 18,
          color: context.colorScheme.onSurfaceVariant,
        ),
        filled: true,
        fillColor: context.colorScheme.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        isDense: true,
      ),
      style: const TextStyle(fontSize: 12),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Filter Pills
// ─────────────────────────────────────────────────────────────

class _FilterPills extends StatelessWidget {
  const _FilterPills({
    required this.items,
    required this.active,
    required this.onChanged,
  });

  final List<BizItem> items;
  final StockFilterMode active;
  final ValueChanged<StockFilterMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final stockItems = items.where((i) => i.stock != null).toList();
    final lowCount = stockItems
        .where((i) => i.stock! > 0 && i.stock! <= _kDefaultThreshold)
        .length;
    final outCount = stockItems.where((i) => i.stock! <= 0).length;

    final filters = [
      (mode: StockFilterMode.all, label: 'الكل', count: stockItems.length),
      (mode: StockFilterMode.low, label: 'مخزون منخفض', count: lowCount),
      (mode: StockFilterMode.out, label: 'نفذ', count: outCount),
    ];

    return Row(
      children: filters.map((f) {
        final isActive = active == f.mode;
        final Color bgColor;
        final Color fgColor;

        if (!isActive) {
          bgColor = context.colorScheme.surfaceContainerLow;
          fgColor = context.colorScheme.onSurfaceVariant;
        } else {
          switch (f.mode) {
            case StockFilterMode.all:
              bgColor = AppColors.primary;
              fgColor = Colors.white;
            case StockFilterMode.low:
              bgColor = Colors.amber.shade600;
              fgColor = Colors.white;
            case StockFilterMode.out:
              bgColor = AppColors.error;
              fgColor = Colors.white;
          }
        }

        return Padding(
          padding: const EdgeInsetsDirectional.only(end: 6),
          child: GestureDetector(
            onTap: () => onChanged(f.mode),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (f.mode == StockFilterMode.low) ...[
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 10,
                      color: fgColor,
                    ),
                    const SizedBox(width: 3),
                  ],
                  Text(
                    f.label,
                    style: TextStyle(
                      fontSize: 10,
                      color: fgColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${f.count}',
                    style: TextStyle(
                      fontSize: 9,
                      color: fgColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Stock Item Card
// ─────────────────────────────────────────────────────────────

class _StockItemCard extends ConsumerWidget {
  const _StockItemCard({
    required this.item,
    this.stockChange,
    this.thresholdChange,
    required this.isEditingThreshold,
    required this.onToggleThresholdEdit,
  });

  final BizItem item;
  final dynamic stockChange;
  final dynamic thresholdChange;
  final bool isEditingThreshold;
  final VoidCallback onToggleThresholdEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final originalStock = item.stock ?? 0;
    final currentStock = stockChange != null
        ? (stockChange as dynamic).newStock as int
        : originalStock;
    final originalThreshold = _kDefaultThreshold;
    final currentThreshold = thresholdChange != null
        ? (thresholdChange as dynamic).newThreshold as int
        : originalThreshold;
    final hasChange = stockChange != null || thresholdChange != null;

    final stockRatio =
        currentThreshold > 0 ? currentStock / currentThreshold : 1.0;
    final stockColor = _stockColor(currentStock, stockRatio);
    final barColor = _barColor(currentStock, stockRatio);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: hasChange
            ? AppColors.warning.withValues(alpha: 0.05)
            : context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasChange
              ? AppColors.warning.withValues(alpha: 0.3)
              : context.colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Item image
              if (item.images.isNotEmpty)
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: context.colorScheme.outlineVariant,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(item.images.first),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        if (item.categoryName != null)
                          Text(
                            item.categoryName!,
                            style: TextStyle(
                              fontSize: 10,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        if (currentStock <= 0 && !hasChange) ...[
                          const SizedBox(width: 4),
                          _StatusPill(
                            label: 'نفذ',
                            color: AppColors.error,
                          ),
                        ] else if (stockRatio <= 1.0 &&
                            currentStock > 0 &&
                            !hasChange) ...[
                          const SizedBox(width: 4),
                          _StatusPill(
                            label: 'منخفض',
                            color: Colors.amber.shade700,
                            icon: Icons.warning_amber_rounded,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Stock bar
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: stockRatio.clamp(0.0, 1.0),
                              backgroundColor:
                                  context.colorScheme.surfaceContainerHighest,
                              color: barColor,
                              minHeight: 3,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        GestureDetector(
                          onTap: onToggleThresholdEdit,
                          child: Text(
                            '$currentStock/$currentThreshold',
                            style: TextStyle(
                              fontSize: 9,
                              color: stockColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Threshold editor
                    if (isEditingThreshold)
                      _ThresholdEditor(
                        itemId: item.id,
                        currentThreshold: currentThreshold,
                        originalThreshold: originalThreshold,
                        hasChange: thresholdChange != null,
                        onDone: onToggleThresholdEdit,
                      ),
                  ],
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              // Stock controls
              _StockStepper(
                item: item,
                currentStock: currentStock,
                hasChange: hasChange,
              ),
            ],
          ),

          // Change indicator
          if (hasChange)
            _ChangeIndicator(
              item: item,
              stockChange: stockChange,
              thresholdChange: thresholdChange,
              currentStock: currentStock,
              currentThreshold: currentThreshold,
            ),
        ],
      ),
    );
  }

  Color _stockColor(int stock, double ratio) {
    if (stock <= 0) return AppColors.error;
    if (ratio <= 0.5) return Colors.amber.shade700;
    return AppColors.success;
  }

  Color _barColor(int stock, double ratio) {
    if (stock <= 0) return AppColors.error;
    if (ratio <= 0.5) return Colors.amber.shade600;
    return AppColors.success;
  }
}

// ─────────────────────────────────────────────────────────────
// Stock Stepper (+/- buttons + editable number)
// ─────────────────────────────────────────────────────────────

class _StockStepper extends ConsumerWidget {
  const _StockStepper({
    required this.item,
    required this.currentStock,
    required this.hasChange,
  });

  final BizItem item;
  final int currentStock;
  final bool hasChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Minus
        _StepperButton(
          icon: Icons.remove,
          enabled: currentStock > 0,
          onTap: () => ref.read(stockChangesProvider.notifier).updateStock(
                itemId: item.id,
                itemName: item.name,
                originalStock: item.stock ?? 0,
                delta: -1,
                category: item.categoryName,
              ),
        ),

        // Stock input
        GestureDetector(
          onTap: () => _showDirectInput(context, ref),
          child: Container(
            width: 44,
            height: 28,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: hasChange
                  ? AppColors.warning.withValues(alpha: 0.1)
                  : context.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: hasChange
                    ? AppColors.warning.withValues(alpha: 0.4)
                    : context.colorScheme.outlineVariant,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '$currentStock',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: hasChange
                    ? Colors.amber.shade900
                    : context.colorScheme.onSurface,
              ),
            ),
          ),
        ),

        // Plus
        _StepperButton(
          icon: Icons.add,
          isPrimary: true,
          onTap: () => ref.read(stockChangesProvider.notifier).updateStock(
                itemId: item.id,
                itemName: item.name,
                originalStock: item.stock ?? 0,
                delta: 1,
                category: item.categoryName,
              ),
        ),

        // Reset button
        if (hasChange)
          GestureDetector(
            onTap: () {
              ref.read(stockChangesProvider.notifier).resetItem(item.id);
              ref
                  .read(thresholdChangesProvider.notifier)
                  .resetItem(item.id);
            },
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 4),
              child: Icon(
                Icons.refresh_rounded,
                size: 14,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }

  void _showDirectInput(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: '$currentStock');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          item.name,
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            labelText: 'الكمية الجديدة',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (v) {
            final parsed = int.tryParse(v);
            if (parsed != null) {
              ref.read(stockChangesProvider.notifier).setStockDirect(
                    itemId: item.id,
                    itemName: item.name,
                    originalStock: item.stock ?? 0,
                    value: parsed,
                    category: item.categoryName,
                  );
            }
            Navigator.pop(ctx);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              final parsed = int.tryParse(controller.text);
              if (parsed != null) {
                ref.read(stockChangesProvider.notifier).setStockDirect(
                      itemId: item.id,
                      itemName: item.name,
                      originalStock: item.stock ?? 0,
                      value: parsed,
                      category: item.categoryName,
                    );
              }
              Navigator.pop(ctx);
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({
    required this.icon,
    this.enabled = true,
    this.isPrimary = false,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: isPrimary
              ? AppColors.primary.withValues(alpha: 0.1)
              : context.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 14,
          color: !enabled
              ? context.colorScheme.outlineVariant
              : isPrimary
                  ? AppColors.primary
                  : context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Threshold Editor (inline)
// ─────────────────────────────────────────────────────────────

class _ThresholdEditor extends ConsumerStatefulWidget {
  const _ThresholdEditor({
    required this.itemId,
    required this.currentThreshold,
    required this.originalThreshold,
    required this.hasChange,
    required this.onDone,
  });

  final String itemId;
  final int currentThreshold;
  final int originalThreshold;
  final bool hasChange;
  final VoidCallback onDone;

  @override
  ConsumerState<_ThresholdEditor> createState() => _ThresholdEditorState();
}

class _ThresholdEditorState extends ConsumerState<_ThresholdEditor> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController(text: '${widget.currentThreshold}');
  }

  @override
  void didUpdateWidget(_ThresholdEditor old) {
    super.didUpdateWidget(old);
    if (old.currentThreshold != widget.currentThreshold) {
      _controller.text = '${widget.currentThreshold}';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.settings, size: 12, color: AppColors.primary),
            const SizedBox(width: 6),
            Text(
              'الحد الأدنى:',
              style: TextStyle(
                fontSize: 10,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 6),
            SizedBox(
              width: 50,
              height: 24,
              child: TextField(
                controller: _controller,
                autofocus: true,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: widget.hasChange
                      ? AppColors.primary
                      : context.colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(
                      color: widget.hasChange
                          ? AppColors.primary
                          : context.colorScheme.outlineVariant,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(
                      color: widget.hasChange
                          ? AppColors.primary
                          : context.colorScheme.outlineVariant,
                    ),
                  ),
                ),
                onChanged: (v) {
                  final parsed = int.tryParse(v);
                  if (parsed != null && parsed >= 0) {
                    ref.read(thresholdChangesProvider.notifier).setThreshold(
                          itemId: widget.itemId,
                          originalThreshold: widget.originalThreshold,
                          newThreshold: parsed,
                        );
                  }
                },
                onSubmitted: (_) => widget.onDone(),
              ),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: widget.onDone,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  size: 10,
                  color: AppColors.primary,
                ),
              ),
            ),
            if (widget.hasChange) ...[
              const SizedBox(width: 6),
              Text(
                '(كان ${widget.originalThreshold})',
                style: TextStyle(
                  fontSize: 9,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Change Indicator
// ─────────────────────────────────────────────────────────────

class _ChangeIndicator extends StatelessWidget {
  const _ChangeIndicator({
    required this.item,
    required this.stockChange,
    required this.thresholdChange,
    required this.currentStock,
    required this.currentThreshold,
  });

  final BizItem item;
  final dynamic stockChange;
  final dynamic thresholdChange;
  final int currentStock;
  final int currentThreshold;

  @override
  Widget build(BuildContext context) {
    final originalStock = item.stock ?? 0;

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Wrap(
        spacing: AppSpacing.md,
        runSpacing: 2,
        children: [
          if (stockChange != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.inventory_2_outlined,
                    size: 10, color: Colors.amber.shade600),
                const SizedBox(width: 4),
                Text('كمية: ',
                    style: TextStyle(
                        fontSize: 10,
                        color: context.colorScheme.onSurfaceVariant)),
                Text('$originalStock',
                    style: TextStyle(
                      fontSize: 10,
                      color: context.colorScheme.onSurfaceVariant,
                      decoration: TextDecoration.lineThrough,
                    )),
                const Text(' → ', style: TextStyle(fontSize: 10)),
                Text(
                  '$currentStock',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: currentStock > originalStock
                        ? AppColors.success
                        : AppColors.error,
                  ),
                ),
                Text(
                  ' (${currentStock > originalStock ? '+' : ''}${currentStock - originalStock})',
                  style: TextStyle(
                    fontSize: 9,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          if (thresholdChange != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.settings, size: 10, color: AppColors.primary),
                const SizedBox(width: 4),
                Text('حد أدنى: ',
                    style: TextStyle(
                        fontSize: 10,
                        color: context.colorScheme.onSurfaceVariant)),
                Text('$_kDefaultThreshold',
                    style: TextStyle(
                      fontSize: 10,
                      color: context.colorScheme.onSurfaceVariant,
                      decoration: TextDecoration.lineThrough,
                    )),
                const Text(' → ', style: TextStyle(fontSize: 10)),
                Text(
                  '$currentThreshold',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Status Pill
// ─────────────────────────────────────────────────────────────

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.label,
    required this.color,
    this.icon,
  });

  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 8, color: color),
            const SizedBox(width: 2),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Empty State
// ─────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.filterMode});
  final StockFilterMode filterMode;

  @override
  Widget build(BuildContext context) {
    final message = switch (filterMode) {
      StockFilterMode.low => 'لا توجد منتجات بمخزون منخفض',
      StockFilterMode.out => 'لا توجد منتجات نافذة',
      StockFilterMode.all => 'لا توجد منتجات',
    };

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 32,
              color: context.colorScheme.outlineVariant,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: TextStyle(
                fontSize: 12,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Footer Bar
// ─────────────────────────────────────────────────────────────

class _FooterBar extends ConsumerWidget {
  const _FooterBar({required this.totalChanges});
  final int totalChanges;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        MediaQuery.of(context).padding.bottom + AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.colorScheme.outlineVariant),
        ),
      ),
      child: Row(
        children: [
          if (totalChanges > 0)
            GestureDetector(
              onTap: () {
                ref.read(stockChangesProvider.notifier).resetAll();
                ref.read(thresholdChangesProvider.notifier).resetAll();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.refresh_rounded,
                      size: 14,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'تراجع',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (totalChanges > 0) const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: FilledButton.icon(
              onPressed: totalChanges > 0
                  ? () {
                      // In real app: API call to save
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم تحديث المخزون ($totalChanges تعديل)'),
                          action: SnackBarAction(
                            label: 'تراجع',
                            onPressed: () {
                              // Undo would restore here
                            },
                          ),
                        ),
                      );
                      ref.read(stockChangesProvider.notifier).resetAll();
                      ref.read(thresholdChangesProvider.notifier).resetAll();
                      Navigator.pop(context);
                    }
                  : null,
              icon: const Icon(Icons.save_outlined, size: 16),
              label: Text('حفظ التعديلات ($totalChanges)'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
