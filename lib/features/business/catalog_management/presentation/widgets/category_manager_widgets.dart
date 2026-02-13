part of 'category_manager.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Sub-widgets for CategoryManager page
// ═══════════════════════════════════════════════════════════════════════════

InputDecoration _categoryInputDecoration({String? hintText}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.sm + 2,
    ),
    filled: true,
    fillColor: Colors.grey.shade50,
    border: OutlineInputBorder(
      borderRadius: AppRadius.cardInner,
      borderSide: BorderSide(color: Colors.grey.shade200),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: AppRadius.cardInner,
      borderSide: BorderSide(color: Colors.grey.shade200),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppRadius.cardInner,
      borderSide: const BorderSide(color: AppColors.primary),
    ),
  );
}

BoxDecoration _cardDecoration({Color? borderColor}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: AppRadius.card,
    border: Border.all(color: borderColor ?? Colors.grey.shade100),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.04),
        blurRadius: 4,
        offset: const Offset(0, 1),
      ),
    ],
  );
}

// ── Flash banner ─────────────────────────────────────────────────────────

class _FlashBanner extends StatelessWidget {
  final String message;
  const _FlashBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.success,
          borderRadius: AppRadius.cardInner,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check, color: Colors.white, size: 14),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                message,
                style: context.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Summary card ─────────────────────────────────────────────────────────

class _SummaryCard extends StatelessWidget {
  final int categoryCount;
  final int totalItems;
  final String itemLabelAr;
  final VoidCallback onAdd;

  const _SummaryCard({
    required this.categoryCount,
    required this.totalItems,
    required this.itemLabelAr,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          const Icon(Icons.local_offer_outlined, color: AppColors.primary, size: 16),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$categoryCount تصنيف',
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$totalItems $itemLabelAr',
                style: context.textTheme.labelSmall?.copyWith(
                  color: AppColors.textHint,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const Spacer(),
          FilledButton.icon(
            onPressed: onAdd,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(borderRadius: AppRadius.cardInner),
              textStyle: context.textTheme.labelSmall,
            ),
            icon: const Icon(Icons.add, size: 14),
            label: const Text('تصنيف جديد'),
          ),
        ],
      ),
    );
  }
}

// ── Add card ─────────────────────────────────────────────────────────────

class _AddCard extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const _AddCard({
    required this.controller,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: _cardDecoration(
          borderColor: AppColors.primary.withValues(alpha: 0.3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اسم التصنيف الجديد',
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => onConfirm(),
                    decoration: _categoryInputDecoration(
                      hintText: 'مثال: قص شعر، أطباق رئيسية...',
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                _ActionButton(
                  icon: Icons.check,
                  color: AppColors.success,
                  onTap: onConfirm,
                ),
                const SizedBox(width: AppSpacing.sm),
                _ActionButton(
                  icon: Icons.close,
                  color: Colors.grey.shade400,
                  bgColor: Colors.grey.shade100,
                  onTap: onCancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Category card ────────────────────────────────────────────────────────

class _CategoryCard extends StatelessWidget {
  final BizCategory category;
  final String itemLabelAr;
  final bool isEditing;
  final TextEditingController? editController;
  final VoidCallback onEdit;
  final VoidCallback onConfirmEdit;
  final VoidCallback onCancelEdit;
  final VoidCallback onDelete;

  const _CategoryCard({
    required this.category,
    required this.itemLabelAr,
    required this.isEditing,
    required this.editController,
    required this.onEdit,
    required this.onConfirmEdit,
    required this.onCancelEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: _cardDecoration(
        borderColor: isEditing
            ? AppColors.primary.withValues(alpha: 0.3)
            : null,
      ),
      child: isEditing ? _buildEditing(context) : _buildNormal(context),
    );
  }

  Widget _buildNormal(BuildContext context) {
    return Row(
      children: [
        _SmallIconButton(
          icon: Icons.edit_outlined,
          hoverColor: AppColors.primary.withValues(alpha: 0.08),
          onTap: onEdit,
        ),
        const SizedBox(width: AppSpacing.xs),
        _SmallIconButton(
          icon: Icons.delete_outline,
          iconColor: AppColors.error.withValues(alpha: 0.7),
          hoverColor: AppColors.error.withValues(alpha: 0.08),
          onTap: onDelete,
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: AppRadius.pill,
          ),
          child: Text(
            '${category.itemCount} $itemLabelAr',
            style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          category.name,
          style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildEditing(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: editController,
          autofocus: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => onConfirmEdit(),
          decoration: _categoryInputDecoration(),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _ActionButton(
              icon: Icons.check,
              color: AppColors.success,
              small: true,
              onTap: onConfirmEdit,
            ),
            const SizedBox(width: AppSpacing.sm),
            _ActionButton(
              icon: Icons.close,
              color: Colors.grey.shade400,
              bgColor: Colors.grey.shade100,
              small: true,
              onTap: onCancelEdit,
            ),
          ],
        ),
      ],
    );
  }
}

// ── Empty state ──────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.huge),
      child: Column(
        children: [
          Icon(Icons.local_offer_outlined, size: 40, color: Colors.grey.shade300),
          const SizedBox(height: AppSpacing.md),
          Text(
            'لا توجد تصنيفات بعد',
            style: context.textTheme.bodySmall?.copyWith(color: AppColors.textHint),
          ),
          const SizedBox(height: AppSpacing.md),
          TextButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add, size: 12),
            label: const Text('إضافة تصنيف'),
            style: TextButton.styleFrom(textStyle: context.textTheme.labelSmall),
          ),
        ],
      ),
    );
  }
}

// ── Radio option (delete sheet) ──────────────────────────────────────────

class _RadioOption extends StatelessWidget {
  final String label;
  final String? trailing;
  final bool selected;
  final VoidCallback onTap;

  const _RadioOption({
    required this.label,
    this.trailing,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withValues(alpha: 0.06) : Colors.white,
          borderRadius: AppRadius.cardInner,
          border: Border.all(
            color: selected
                ? AppColors.primary.withValues(alpha: 0.3)
                : Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.primary : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            if (trailing != null) ...[
              const Spacer(),
              Text(
                trailing!,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Shared small buttons ─────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color? bgColor;
  final VoidCallback onTap;
  final bool small;

  const _ActionButton({
    required this.icon,
    required this.color,
    this.bgColor,
    required this.onTap,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = small ? 14.0 : 16.0;
    final pad = small ? 6.0 : 10.0;
    return Material(
      color: bgColor ?? color.withValues(alpha: 0.1),
      borderRadius: AppRadius.cardInner,
      child: InkWell(
        borderRadius: AppRadius.cardInner,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(pad),
          child: Icon(icon, size: size, color: color),
        ),
      ),
    );
  }
}

class _SmallIconButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final Color hoverColor;
  final VoidCallback onTap;

  const _SmallIconButton({
    required this.icon,
    this.iconColor,
    required this.hoverColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: AppRadius.cardInner,
      child: InkWell(
        borderRadius: AppRadius.cardInner,
        hoverColor: hoverColor,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(icon, size: 14, color: iconColor ?? Colors.grey.shade400),
        ),
      ),
    );
  }
}
