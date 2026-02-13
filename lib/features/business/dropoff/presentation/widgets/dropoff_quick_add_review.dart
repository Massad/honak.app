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
            color: Colors.grey.shade50,
            borderRadius: AppRadius.cardInner,
          ),
          child: Row(
            children: [
              Icon(
                Icons.person_outline_rounded,
                size: 18,
                color: Colors.grey.shade500,
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
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (customerPhone != null)
                      Text(
                        customerPhone!,
                        textDirection: TextDirection.ltr,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: Colors.grey.shade400,
                          fontSize: 10,
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
                    color: AppColors.primary,
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
          return Container(
            margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
            padding: const EdgeInsetsDirectional.all(AppSpacing.md),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade100),
              borderRadius: AppRadius.cardInner,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.name} × ${item.quantity}',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurface,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        item.service,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.primary,
                          fontSize: 10,
                        ),
                      ),
                      if (item.attributes.isNotEmpty)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: AppSpacing.xxs,
                          ),
                          child: Wrap(
                            spacing: AppSpacing.xs,
                            children: item.attributes.entries
                                .where((e) =>
                                    e.value.isNotEmpty &&
                                    e.value != '__custom__')
                                .map((e) => Text(
                                      e.value,
                                      style: context.textTheme.labelSmall
                                          ?.copyWith(
                                        color: Colors.grey.shade400,
                                        fontSize: 9,
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  price.toFormattedArabic(),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                GestureDetector(
                  onTap: () => onRemoveItem(i),
                  child: Icon(
                    Icons.close_rounded,
                    size: 14,
                    color: Colors.grey.shade400,
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
            color: Colors.grey.shade50,
            borderRadius: AppRadius.cardInner,
          ),
          child: Row(
            children: [
              Icon(
                Icons.event_rounded,
                size: 16,
                color: Colors.grey.shade500,
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
                        color: Colors.grey.shade400,
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
        Container(
          padding: const EdgeInsetsDirectional.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: urgent
                ? const Color(0xFFFFF8E1)
                : Colors.grey.shade50,
            borderRadius: AppRadius.cardInner,
            border: urgent
                ? Border.all(color: const Color(0xFFFFE082))
                : null,
          ),
          child: Row(
            children: [
              Icon(
                Icons.bolt_rounded,
                size: 18,
                color: urgent
                    ? AppColors.secondary
                    : Colors.grey.shade400,
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
                        color: Colors.grey.shade400,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Switch.adaptive(
                value: urgent,
                onChanged: onUrgentChanged,
                activeTrackColor: AppColors.secondary,
              ),
            ],
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
                color: Colors.grey.shade500,
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
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: items.isNotEmpty ? onSubmit : null,
            icon: const Icon(Icons.receipt_long_rounded, size: 18),
            label: Text(
              'إنشاء تذكرة $ticketNumber',
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.shade300,
              disabledForegroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.cardInner,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}
