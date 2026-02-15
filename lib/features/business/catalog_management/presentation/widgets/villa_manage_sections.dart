import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/entities/money.dart';

// ═══════════════════════════════════════════════════════════════════
// Section Toggle — matches Figma: 36x36 icon box, 14px title, chevron
// ═══════════════════════════════════════════════════════════════════

class VillaSectionToggle extends StatelessWidget {
  final String id;
  final IconData icon;
  final String title;
  final Color? iconColor;
  final int? count;
  final String? expandedSection;
  final ValueChanged<String> onTap;

  const VillaSectionToggle({
    super.key,
    required this.id,
    required this.icon,
    required this.title,
    this.iconColor,
    this.count,
    required this.expandedSection,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isExpanded = expandedSection == id;
    return GestureDetector(
      onTap: () => onTap(id),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: context.colorScheme.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4, offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(children: [
          Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 16, color: AppColors.textHint),
          const Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(title, style: TextStyle(
                fontSize: 14, color: context.colorScheme.onSurface)),
            if (count != null)
              Text('$count عنصر', style: const TextStyle(
                  fontSize: 10, color: AppColors.textHint)),
          ]),
          const SizedBox(width: AppSpacing.md),
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(icon, size: 16, color: iconColor ?? AppColors.primary),
          ),
        ]),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// Section Box — white container with border + shadow
// ═══════════════════════════════════════════════════════════════════

class VillaSectionBox extends StatelessWidget {
  final Widget child;
  const VillaSectionBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: context.colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4, offset: const Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// Price Card — blue weekday / orange weekend
// ═══════════════════════════════════════════════════════════════════

class VillaPriceCard extends StatelessWidget {
  final String label;
  final int cents;
  final Color bg;
  final Color border;
  final Color textColor;

  const VillaPriceCard({
    super.key,
    required this.label,
    required this.cents,
    required this.bg,
    required this.border,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: border),
      ),
      child: Column(children: [
        Text(label, style: const TextStyle(
            fontSize: 10, color: AppColors.textSecondary)),
        const SizedBox(height: AppSpacing.xxs),
        Text(Money(cents).toJodString(), style: TextStyle(
            fontSize: 18, color: textColor)),
        const Text('د.أ/ليلة', style: TextStyle(
            fontSize: 9, color: AppColors.textHint)),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// Time Card — green check-in / red check-out
// ═══════════════════════════════════════════════════════════════════

class VillaTimeCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String time;
  final Color bg;
  final Color border;

  const VillaTimeCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.time,
    required this.bg,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: border),
      ),
      child: Column(children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(height: AppSpacing.xs),
        Text(label, style: const TextStyle(
            fontSize: 10, color: AppColors.textSecondary)),
        const SizedBox(height: AppSpacing.xxs),
        Text(time, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
            color: context.colorScheme.onSurface)),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// House Rules Section — amber cards with add/edit/remove
// ═══════════════════════════════════════════════════════════════════

class VillaRulesSection extends StatefulWidget {
  final List<String> rules;
  final TextEditingController ruleCtrl;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final ValueChanged<MapEntry<int, String>> onEdit;

  const VillaRulesSection({
    super.key,
    required this.rules,
    required this.ruleCtrl,
    required this.onAdd,
    required this.onRemove,
    required this.onEdit,
  });

  @override
  State<VillaRulesSection> createState() => _VillaRulesSectionState();
}

class _VillaRulesSectionState extends State<VillaRulesSection> {
  int? _editingIdx;
  final TextEditingController _editCtrl = TextEditingController();

  @override
  void dispose() {
    _editCtrl.dispose();
    super.dispose();
  }

  void _saveEdit() {
    if (_editingIdx != null && _editCtrl.text.trim().isNotEmpty) {
      widget.onEdit(MapEntry(_editingIdx!, _editCtrl.text.trim()));
    }
    setState(() => _editingIdx = null);
  }

  @override
  Widget build(BuildContext context) {
    final dot = Text('•', style: TextStyle(
        fontSize: 14, color: Colors.amber.shade700));
    return VillaSectionBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        for (int i = 0; i < widget.rules.length; i++)
          Container(
            margin: const EdgeInsetsDirectional.only(bottom: 6),
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(color: const Color(0xFFFFECB3)),
            ),
            child: _editingIdx == i
                ? Row(children: [
                    GestureDetector(
                      onTap: () => setState(() => _editingIdx = null),
                      child: const Icon(Icons.close, size: 14,
                          color: AppColors.textHint),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    GestureDetector(
                      onTap: _saveEdit,
                      child: const Icon(Icons.check, size: 14,
                          color: AppColors.success),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(child: TextField(
                      controller: _editCtrl,
                      textAlign: TextAlign.right,
                      autofocus: true,
                      style: const TextStyle(fontSize: 12),
                      decoration: const InputDecoration(
                        border: InputBorder.none, isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      onSubmitted: (_) => _saveEdit(),
                    )),
                    const SizedBox(width: AppSpacing.sm),
                    dot,
                  ])
                : Row(children: [
                    GestureDetector(
                      onTap: () => widget.onRemove(i),
                      child: const Icon(Icons.delete_outline, size: 14,
                          color: AppColors.textHint),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    GestureDetector(
                      onTap: () => setState(() {
                        _editingIdx = i;
                        _editCtrl.text = widget.rules[i];
                      }),
                      child: const Icon(Icons.edit_outlined, size: 12,
                          color: AppColors.textHint),
                    ),
                    const Spacer(),
                    Flexible(child: Text(widget.rules[i], style: TextStyle(
                        fontSize: 12, color: context.colorScheme.onSurface),
                        textAlign: TextAlign.right)),
                    const SizedBox(width: AppSpacing.sm),
                    dot,
                  ]),
          ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: AppSpacing.xs),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: context.colorScheme.outlineVariant),
          ),
          child: Row(children: [
            GestureDetector(
              onTap: widget.onAdd,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.amber.shade500,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.add, size: 16, color: Colors.white),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(child: TextField(
              controller: widget.ruleCtrl,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 12),
              decoration: const InputDecoration(
                hintText: 'أضف قانوناً جديداً...',
                border: InputBorder.none, isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              onSubmitted: (_) => widget.onAdd(),
            )),
          ]),
        ),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// Gallery Section — 3-column grid with reorder mode + delete overlay
// ═══════════════════════════════════════════════════════════════════

class VillaGallerySection extends StatefulWidget {
  final List<String> images;
  final ValueChanged<List<String>> onReorder;

  const VillaGallerySection({
    super.key,
    required this.images,
    required this.onReorder,
  });

  @override
  State<VillaGallerySection> createState() => _VillaGallerySectionState();
}

class _VillaGallerySectionState extends State<VillaGallerySection> {
  bool _reorderMode = false;
  bool _showSavedBanner = false;
  late List<String> _images;

  @override
  void initState() {
    super.initState();
    _images = List<String>.from(widget.images);
  }

  @override
  void didUpdateWidget(VillaGallerySection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_reorderMode) _images = List<String>.from(widget.images);
  }

  void _swapImages(int a, int b) {
    setState(() {
      final temp = _images[a];
      _images[a] = _images[b];
      _images[b] = temp;
    });
  }

  void _saveOrder() {
    setState(() { _reorderMode = false; _showSavedBanner = true; });
    widget.onReorder(_images);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showSavedBanner = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return VillaSectionBox(
      child: Column(children: [
        // Reorder toggle row
        Row(children: [
          GestureDetector(
            onTap: _reorderMode ? _saveOrder : () => setState(() => _reorderMode = true),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: AppSpacing.xs),
              decoration: BoxDecoration(
                color: _reorderMode ? AppColors.primary : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.swap_vert, size: 10,
                    color: _reorderMode ? Colors.white : AppColors.textHint),
                const SizedBox(width: 4),
                Text(_reorderMode ? 'تم الترتيب' : 'ترتيب',
                    style: TextStyle(fontSize: 10,
                        color: _reorderMode ? Colors.white : AppColors.textHint)),
              ]),
            ),
          ),
        ]),
        const SizedBox(height: AppSpacing.sm),
        if (_showSavedBanner)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Text('تم حفظ الترتيب الجديد',
                  style: TextStyle(fontSize: 10, color: Colors.white)),
              SizedBox(width: 4),
              Icon(Icons.check_circle, size: 12, color: Colors.white),
            ]),
          ),
        if (_reorderMode) _buildReorderList() else _buildGrid(),
      ]),
    );
  }

  Widget _buildReorderList() {
    return Column(children: [
      for (int i = 0; i < _images.length; i++)
        Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: context.colorScheme.outlineVariant),
          ),
          child: Row(children: [
            Column(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                onTap: i > 0 ? () => _swapImages(i, i - 1) : null,
                child: Icon(Icons.arrow_upward, size: 14,
                    color: i > 0 ? AppColors.primary : AppColors.divider),
              ),
              const SizedBox(height: 2),
              GestureDetector(
                onTap: i < _images.length - 1 ? () => _swapImages(i, i + 1) : null,
                child: Icon(Icons.arrow_downward, size: 14,
                    color: i < _images.length - 1 ? AppColors.primary : AppColors.divider),
              ),
            ]),
            const SizedBox(width: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.xxs),
              child: Image.network(_images[i],
                  width: 48, height: 48, fit: BoxFit.cover),
            ),
            const SizedBox(width: AppSpacing.sm),
            Container(
              width: 20, height: 20,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text('${i + 1}',
                  style: const TextStyle(fontSize: 9, color: Colors.white))),
            ),
            if (i == 0) ...[
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4)),
                child: const Text('رئيسية',
                    style: TextStyle(fontSize: 7, color: Colors.white)),
              ),
            ],
            const Spacer(),
            const Icon(Icons.drag_indicator, size: 14,
                color: AppColors.textHint),
          ]),
        ),
    ]);
  }

  Widget _buildGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
      itemCount: _images.length + 1,
      itemBuilder: (ctx, i) =>
          i == _images.length ? _addPlaceholder() : _imageCell(_images[i], i),
    );
  }

  Widget _addPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: context.colorScheme.outlineVariant, width: 2),
      ),
      child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Icon(Icons.add, size: 20, color: AppColors.textHint),
        Text('إضافة', style: TextStyle(fontSize: 9, color: AppColors.textHint)),
      ]),
    );
  }

  Widget _imageCell(String url, int index) {
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Image.network(url, fit: BoxFit.cover,
            width: double.infinity, height: double.infinity),
      ),
      PositionedDirectional(
        top: 4, start: 4,
        child: GestureDetector(
          child: Container(
            width: 20, height: 20,
            decoration: const BoxDecoration(
                color: Colors.black45, shape: BoxShape.circle),
            child: const Center(
                child: Icon(Icons.close, size: 10, color: Colors.white)),
          ),
        ),
      ),
      PositionedDirectional(
        top: 4, end: 4,
        child: Container(
          width: 20, height: 20,
          decoration: BoxDecoration(
              color: Colors.black45, borderRadius: BorderRadius.circular(10)),
          child: Center(child: Text('${index + 1}',
              style: const TextStyle(fontSize: 9, color: Colors.white))),
        ),
      ),
      if (index == 0)
        PositionedDirectional(
          bottom: 4, end: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(4)),
            child: const Text('رئيسية',
                style: TextStyle(fontSize: 8, color: Colors.white)),
          ),
        ),
    ]);
  }
}

// ═══════════════════════════════════════════════════════════════════
// Shared helpers (free functions used by the page)
// ═══════════════════════════════════════════════════════════════════

Widget villaEditButton(
    BuildContext context, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(label, style: const TextStyle(
            fontSize: 12, color: AppColors.textSecondary)),
        const SizedBox(width: 6),
        const Icon(Icons.edit_outlined, size: 12,
            color: AppColors.textSecondary),
      ]),
    ),
  );
}

Widget villaSaveCancelRow({
  required BuildContext context,
  required VoidCallback onSave,
  required VoidCallback onCancel,
}) {
  return Row(textDirection: TextDirection.ltr, children: [
    GestureDetector(
      onTap: onCancel,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: const Text('إلغاء', style: TextStyle(
            fontSize: 12, color: AppColors.textSecondary)),
      ),
    ),
    const SizedBox(width: AppSpacing.sm),
    Expanded(
      child: GestureDetector(
        onTap: onSave,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text('حفظ', style: TextStyle(fontSize: 12,
                fontWeight: FontWeight.w500, color: Colors.white)),
            SizedBox(width: 4),
            Icon(Icons.check, size: 14, color: Colors.white),
          ]),
        ),
      ),
    ),
  ]);
}

Widget villaLabeledInput(String label, TextEditingController ctrl,
    BuildContext context, {bool isText = false}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label,
        style: const TextStyle(fontSize: 10, color: AppColors.textHint)),
    const SizedBox(height: AppSpacing.xs),
    TextField(
      controller: ctrl,
      textAlign: TextAlign.center,
      textDirection: isText ? null : TextDirection.ltr,
      keyboardType: isText ? TextInputType.text : TextInputType.number,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.surfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: context.colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: context.colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        isDense: true,
      ),
    ),
  ]);
}
