part of 'dropoff_quick_add.dart';

// ═════════════════════════════════════════════════════════════════
// Step 3 — Review & Submit
// ═════════════════════════════════════════════════════════════════

class _ReviewStep extends StatelessWidget {
  final String customerName;
  final String? customerPhone;
  final List<DropoffItem> items;
  final int estimatedDays;
  final bool urgent;
  final String notes;
  final Money totalPrice;
  final String ticketNumber;
  final VoidCallback onEditCustomer;
  final ValueChanged<int> onRemoveItem;
  final ValueChanged<int> onEstimatedDaysChanged;
  final ValueChanged<bool> onUrgentChanged;
  final TextEditingController notesController;
  final VoidCallback onSubmit;

  const _ReviewStep({
    required this.customerName,
    this.customerPhone,
    required this.items,
    required this.estimatedDays,
    required this.urgent,
    required this.notes,
    required this.totalPrice,
    required this.ticketNumber,
    required this.onEditCustomer,
    required this.onRemoveItem,
    required this.onEstimatedDaysChanged,
    required this.onUrgentChanged,
    required this.notesController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final readyDate = DateTime.now().add(Duration(days: estimatedDays));
    final readyFormatted = DateFormat('EEEE، d MMMM', 'ar').format(readyDate);

    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      children: [
        // ── Customer card ──
        Container(
          padding: const EdgeInsetsDirectional.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            borderRadius: AppRadius.cardInner,
          ),
          child: Row(
            children: [
              // Avatar circle
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                ),
                child: Icon(
                  Icons.person_outline_rounded,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerName,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface,
                        fontSize: 14,
                      ),
                    ),
                    if (customerPhone != null)
                      Text(
                        customerPhone!,
                        textDirection: Directionality.of(context),
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onEditCustomer,
                child: const Text(
                  'تعديل',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF1A73E8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Items list ──
        _FieldLabel('القطع (${items.length})'),
        const SizedBox(height: AppSpacing.sm),
        ...List.generate(items.length, (i) {
          final item = items[i];
          final price = Money(item.price);
          final validAttrs = item.attributes.entries
              .where((e) => e.value.isNotEmpty && e.value != '__custom__')
              .toList();
          return Container(
            margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
            padding: const EdgeInsetsDirectional.all(AppSpacing.md),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
              borderRadius: AppRadius.cardInner,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Package icon
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 2,
                    end: AppSpacing.sm,
                  ),
                  child: Icon(
                    Icons.inventory_2_outlined,
                    size: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${item.name} × ${item.quantity}',
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.colorScheme.onSurface,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text(
                            price.toFormattedArabic(),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.service,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.primary,
                          fontSize: 10,
                        ),
                      ),
                      if (validAttrs.isNotEmpty)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: AppSpacing.xxs,
                          ),
                          child: Wrap(
                            spacing: AppSpacing.xs,
                            runSpacing: AppSpacing.xxs,
                            children: validAttrs
                                .map((e) => Container(
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surfaceContainerLowest,
                                        borderRadius: AppRadius.pill,
                                        border: Border.all(
                                          color: Theme.of(context).colorScheme.surfaceContainerLow,
                                        ),
                                      ),
                                      child: Text(
                                        e.value,
                                        style: context.textTheme.labelSmall
                                            ?.copyWith(
                                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                                          fontSize: 9,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      if (item.notes != null && item.notes!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: AppSpacing.xxs,
                          ),
                          child: Text(
                            item.notes!,
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xFFFF9800),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                GestureDetector(
                  onTap: () => onRemoveItem(i),
                  child: const Padding(
                    padding: EdgeInsetsDirectional.only(top: 2),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      size: 14,
                      color: Color(0xFFE53935),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: AppSpacing.lg),

        // ── Estimated ready date ──
        _FieldLabel('الموعد المتوقع للتجهيز'),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsetsDirectional.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            borderRadius: AppRadius.cardInner,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.calendar_today_rounded,
                size: 16,
                color: Color(0xFF1A73E8),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      readyFormatted,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'بعد $estimatedDays ${estimatedDays == 1 ? 'يوم' : 'أيام'}',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              _QuantityButton(
                icon: Icons.remove,
                onTap: estimatedDays > 1
                    ? () => onEstimatedDaysChanged(estimatedDays - 1)
                    : null,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.sm,
                ),
                child: Text(
                  '$estimatedDays',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _QuantityButton(
                icon: Icons.add,
                onTap: () => onEstimatedDaysChanged(estimatedDays + 1),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Urgent toggle ──
        GestureDetector(
          onTap: () => onUrgentChanged(!urgent),
          child: Container(
            padding: const EdgeInsetsDirectional.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: urgent
                  ? const Color(0xFFFEF2F2)
                  : Theme.of(context).colorScheme.surfaceContainerLowest,
              borderRadius: AppRadius.cardInner,
              border: urgent
                  ? Border.all(color: const Color(0xFFE53935))
                  : Border.all(color: Theme.of(context).colorScheme.outlineVariant),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.bolt_rounded,
                  size: 18,
                  color: urgent
                      ? const Color(0xFFE53935)
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'خدمة مستعجلة',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurface,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'أولوية معالجة أعلى',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                // Checkbox indicator
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: urgent
                        ? const Color(0xFFE53935)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: urgent
                          ? const Color(0xFFE53935)
                          : Theme.of(context).colorScheme.outline,
                      width: 2,
                    ),
                  ),
                  child: urgent
                      ? Icon(
                          Icons.check_rounded,
                          size: 14,
                          color: Theme.of(context).colorScheme.surface,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Notes ──
        _FieldLabel('ملاحظات عامة (اختياري)'),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: notesController,
          maxLines: 3,
          decoration: _inputDecoration(hint: 'أي ملاحظات على الطلب...'),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Total + Submit ──
        const Divider(),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Text(
              'الإجمالي',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            Text(
              totalPrice.toFormattedArabic(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        GestureDetector(
          onTap: items.isNotEmpty ? onSubmit : null,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: items.isNotEmpty
                  ? const Color(0xFF1A73E8)
                  : Theme.of(context).colorScheme.outline,
              borderRadius: AppRadius.cardInner,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_rounded, size: 16, color: Colors.white),
                const SizedBox(width: 6),
                Text(
                  'إنشاء تذكرة $ticketNumber',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}
