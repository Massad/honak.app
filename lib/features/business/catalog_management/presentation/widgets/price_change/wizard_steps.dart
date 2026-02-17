import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/shared/domain/entities/biz_item.dart';

// ═══════════════════════════════════════════════════════════════════════
// Step 1 — Value: Direction + Method + Amount
// ═══════════════════════════════════════════════════════════════════════

class StepValue extends StatelessWidget {
  final String direction;
  final String method;
  final double value;
  final TextEditingController? controller;
  final ValueChanged<String> onDirectionChanged;
  final ValueChanged<String> onMethodChanged;
  final ValueChanged<double> onValueChanged;

  const StepValue({
    super.key,
    required this.direction,
    required this.method,
    required this.value,
    this.controller,
    required this.onDirectionChanged,
    required this.onMethodChanged,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isPercentage = method == 'percentage';
    final percentQuickPicks = [5, 10, 15, 20, 25, 30, 50];
    final amountQuickPicks = [0.5, 1.0, 2.0, 5.0, 10.0];

    return ListView(
      padding: AppSpacing.screenPadding,
      children: [
        // Direction
        _SectionLabel(label: context.l10n.pcDirection),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _OptionCard(
                icon: Icons.arrow_circle_down_outlined,
                iconColor: AppColors.success,
                label: context.l10n.pcDecrease,
                isSelected: direction == 'decrease',
                onTap: () => onDirectionChanged('decrease'),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _OptionCard(
                icon: Icons.arrow_circle_up_outlined,
                iconColor: AppColors.warning,
                label: context.l10n.pcIncrease,
                isSelected: direction == 'increase',
                onTap: () => onDirectionChanged('increase'),
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xxl),

        // Method
        _SectionLabel(label: context.l10n.pcMethod),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _OptionCard(
                icon: null,
                label: context.l10n.pcPercentage,
                suffix: '%',
                isSelected: isPercentage,
                onTap: () => onMethodChanged('percentage'),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _OptionCard(
                icon: null,
                label: context.l10n.pcFixedAmount,
                suffix: 'د.أ',
                isSelected: !isPercentage,
                onTap: () => onMethodChanged('fixed'),
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xxl),

        // Value input
        _SectionLabel(label: context.l10n.pcValue),
        const SizedBox(height: AppSpacing.sm),
        Center(
          child: SizedBox(
            width: 180,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                ],
                onChanged: (v) {
                  final parsed = double.tryParse(v) ?? 0;
                  onValueChanged(parsed);
                },
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  hintText: '0',
                  hintStyle: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  suffixText: isPercentage ? '%' : 'د.أ',
                  suffixStyle: context.textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.md,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Quick picks
        Wrap(
          alignment: WrapAlignment.center,
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: isPercentage
              ? percentQuickPicks.map((p) {
                  final isActive = value == p.toDouble();
                  return _QuickPickChip(
                    label: '$p%',
                    isSelected: isActive,
                    onTap: () => onValueChanged(p.toDouble()),
                  );
                }).toList()
              : amountQuickPicks.map((a) {
                  final isActive = value == a;
                  final label = a == a.truncateToDouble()
                      ? '${a.toInt()} د.أ'
                      : '$a د.أ';
                  return _QuickPickChip(
                    label: label,
                    isSelected: isActive,
                    onTap: () => onValueChanged(a),
                  );
                }).toList(),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Step 2 — Scope: all / category / specific items
// ═══════════════════════════════════════════════════════════════════════

class StepScope extends StatefulWidget {
  final String scope;
  final List<String> categoryNames;
  final List<String> itemIds;
  final List<BizItem> items;
  final String itemsLabel;
  final ValueChanged<String> onScopeChanged;
  final ValueChanged<List<String>> onCategoryNamesChanged;
  final ValueChanged<List<String>> onItemIdsChanged;

  const StepScope({
    super.key,
    required this.scope,
    required this.categoryNames,
    required this.itemIds,
    required this.items,
    required this.itemsLabel,
    required this.onScopeChanged,
    required this.onCategoryNamesChanged,
    required this.onItemIdsChanged,
  });

  @override
  State<StepScope> createState() => _StepScopeState();
}

class _StepScopeState extends State<StepScope> {
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  /// Group items by categoryName and count per category.
  Map<String, int> get _categoryGroups {
    final map = <String, int>{};
    for (final item in widget.items) {
      final cat = item.categoryName ?? '_uncategorized_';
      map[cat] = (map[cat] ?? 0) + 1;
    }
    return map;
  }

  List<BizItem> get _filteredItems {
    if (_searchQuery.isEmpty) return widget.items;
    return widget.items
        .where(
            (i) => i.name.contains(_searchQuery) ||
                (i.nameEn?.toLowerCase().contains(
                        _searchQuery.toLowerCase()) ??
                    false))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppSpacing.screenPadding,
      children: [
        // Radio: All
        _RadioOption(
          label: '${context.l10n.pcScopeAll} ${widget.itemsLabel}',
          isSelected: widget.scope == 'all',
          onTap: () => widget.onScopeChanged('all'),
        ),
        if (widget.scope == 'all') ...[
          const SizedBox(height: AppSpacing.sm),
          _InfoBox(
            color: AppColors.info,
            text: context.l10n.pcScopeAllInfo(
              widget.itemsLabel,
              widget.items.length,
            ),
          ),
        ],

        const SizedBox(height: AppSpacing.md),

        // Radio: Category
        _RadioOption(
          label: context.l10n.pcScopeCategory,
          isSelected: widget.scope == 'category',
          onTap: () => widget.onScopeChanged('category'),
        ),
        if (widget.scope == 'category') ...[
          const SizedBox(height: AppSpacing.sm),
          ..._categoryGroups.entries.map((entry) {
            final isChecked =
                widget.categoryNames.contains(entry.key);
            final displayName = entry.key == '_uncategorized_'
                ? context.l10n.wizardUncategorized
                : entry.key;
            return _CheckboxRow(
              label: '$displayName (${entry.value})',
              isChecked: isChecked,
              onChanged: (checked) {
                final updated = List<String>.from(widget.categoryNames);
                if (checked) {
                  updated.add(entry.key);
                } else {
                  updated.remove(entry.key);
                }
                widget.onCategoryNamesChanged(updated);
              },
            );
          }),
        ],

        const SizedBox(height: AppSpacing.md),

        // Radio: Specific items
        _RadioOption(
          label: context.l10n.pcScopeSpecific,
          isSelected: widget.scope == 'specific',
          onTap: () => widget.onScopeChanged('specific'),
        ),
        if (widget.scope == 'specific') ...[
          const SizedBox(height: AppSpacing.sm),
          // Search field (show if items > 6)
          if (widget.items.length > 6) ...[
            TextField(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: context.l10n.pcSearchHint,
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                isDense: true,
                contentPadding: AppSpacing.inputPadding,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          ..._filteredItems.map((item) {
            final isChecked = widget.itemIds.contains(item.id);
            final priceText = item.price?.toFormattedArabic() ?? '';
            return _CheckboxRow(
              label: item.name,
              subtitle: priceText,
              isChecked: isChecked,
              onChanged: (checked) {
                final updated = List<String>.from(widget.itemIds);
                if (checked) {
                  updated.add(item.id);
                } else {
                  updated.remove(item.id);
                }
                widget.onItemIdsChanged(updated);
              },
            );
          }),
        ],
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Step 3 — Schedule: Start / End dates
// ═══════════════════════════════════════════════════════════════════════

class StepSchedule extends StatelessWidget {
  final bool startsNow;
  final DateTime? startsAt;
  final bool hasEndDate;
  final DateTime? endsAt;
  final ValueChanged<bool> onStartsNowChanged;
  final ValueChanged<DateTime> onStartsAtChanged;
  final ValueChanged<bool> onHasEndDateChanged;
  final ValueChanged<DateTime> onEndsAtChanged;

  const StepSchedule({
    super.key,
    required this.startsNow,
    required this.startsAt,
    required this.hasEndDate,
    required this.endsAt,
    required this.onStartsNowChanged,
    required this.onStartsAtChanged,
    required this.onHasEndDateChanged,
    required this.onEndsAtChanged,
  });

  bool get _isEndBeforeStart {
    if (!hasEndDate || endsAt == null) return false;
    final start = startsNow ? DateTime.now() : (startsAt ?? DateTime.now());
    return !start.isBefore(endsAt!);
  }

  String _durationNote(BuildContext context) {
    if (!hasEndDate || endsAt == null) return '';
    final start = startsNow ? DateTime.now() : (startsAt ?? DateTime.now());
    final hours = endsAt!.difference(start).inHours;
    if (hours <= 0) return '';
    final days = hours ~/ 24;
    final remHours = hours % 24;
    if (days > 0 && remHours > 0) return context.l10n.pcDurationDaysAndHours(days, remHours);
    if (days > 0) return context.l10n.pcDurationApprox(days);
    return context.l10n.pcDurationHoursOnly(remHours);
  }

  Future<void> _pickDateTime(BuildContext context, ValueChanged<DateTime> onPick,
      {DateTime? initial}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      locale: const Locale('ar'),
    );
    if (picked == null || !context.mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: initial != null
          ? TimeOfDay.fromDateTime(initial)
          : TimeOfDay.now(),
    );
    final hour = time?.hour ?? 12;
    final minute = time?.minute ?? 0;
    onPick(DateTime(picked.year, picked.month, picked.day, hour, minute));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppSpacing.screenPadding,
      children: [
        // Start time
        _SectionLabel(label: context.l10n.pcStartTime),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _OptionCard(
                icon: Icons.flash_on_outlined,
                iconColor: AppColors.primary,
                label: context.l10n.pcStartNow,
                isSelected: startsNow,
                onTap: () => onStartsNowChanged(true),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _OptionCard(
                icon: Icons.schedule_outlined,
                iconColor: AppColors.primary,
                label: context.l10n.pcScheduleLater,
                isSelected: !startsNow,
                onTap: () => onStartsNowChanged(false),
              ),
            ),
          ],
        ),
        if (!startsNow) ...[
          const SizedBox(height: AppSpacing.md),
          _DateTimePickerField(
            label: context.l10n.pcStartDateTime,
            date: startsAt,
            onTap: () => _pickDateTime(
              context,
              onStartsAtChanged,
              initial: startsAt,
            ),
          ),
        ],

        const SizedBox(height: AppSpacing.xxl),

        // End time
        _SectionLabel(label: context.l10n.pcEndTime),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _OptionCard(
                icon: Icons.event_outlined,
                iconColor: AppColors.primary,
                label: context.l10n.pcSpecificDate,
                isSelected: hasEndDate,
                onTap: () => onHasEndDateChanged(true),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _OptionCard(
                icon: Icons.all_inclusive_outlined,
                iconColor: AppColors.primary,
                label: context.l10n.pcNoEnd,
                isSelected: !hasEndDate,
                onTap: () => onHasEndDateChanged(false),
              ),
            ),
          ],
        ),
        if (hasEndDate) ...[
          const SizedBox(height: AppSpacing.md),
          _DateTimePickerField(
            label: context.l10n.pcEndDateTime,
            date: endsAt,
            onTap: () => _pickDateTime(
              context,
              onEndsAtChanged,
              initial: endsAt,
            ),
          ),
        ],

        // Duration note
        if (_durationNote(context).isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Center(
            child: Text(
              _durationNote(context),
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],

        const SizedBox(height: AppSpacing.xxl),

        // Validation: start must be before end
        if (_isEndBeforeStart) ...[
          _InfoBox(
            color: AppColors.error,
            text: context.l10n.pcEndBeforeStartError,
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // Tip box
        _InfoBox(
          color: AppColors.warning,
          text: context.l10n.pcScheduleTip,
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Step 4 — Visibility: Public toggle + reason
// ═══════════════════════════════════════════════════════════════════════

class StepVisibility extends StatelessWidget {
  final bool isPublic;
  final String reason;
  final ValueChanged<bool> onPublicChanged;
  final ValueChanged<String> onReasonChanged;

  const StepVisibility({
    super.key,
    required this.isPublic,
    required this.reason,
    required this.onPublicChanged,
    required this.onReasonChanged,
  });

  static const _reasonSuggestions = [
    'عيد الأضحى',
    'عيد الفطر',
    'رمضان',
    'الصيف',
    'الشتاء',
    'افتتاح',
    'ذكرى سنوية',
    'تصفية',
    'نهاية الموسم',
    'العودة للمدارس',
    'عرض سريع',
    'موسم الذروة',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppSpacing.screenPadding,
      children: [
        // Toggle row
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          ),
          child: Row(
            children: [
              Switch.adaptive(
                value: isPublic,
                onChanged: onPublicChanged,
                activeTrackColor: AppColors.primary,
                activeThumbColor: Theme.of(context).colorScheme.surface,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  context.l10n.pcPublicAnnouncement,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Info box based on public/private
        if (isPublic)
          _InfoBox(
            color: AppColors.success,
            text: context.l10n.pcPublicCustomerView,
          )
        else
          _InfoBox(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            text: context.l10n.pcPrivateUpdateDesc,
          ),

        // Reason field (only when public)
        if (isPublic) ...[
          const SizedBox(height: AppSpacing.xxl),
          _SectionLabel(label: context.l10n.pcReasonOptional),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            onChanged: onReasonChanged,
            controller: TextEditingController(text: reason)
              ..selection = TextSelection.collapsed(offset: reason.length),
            maxLines: 2,
            decoration: InputDecoration(
              hintText: context.l10n.pcReasonHint,
              hintStyle: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              isDense: true,
              contentPadding: AppSpacing.inputPadding,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _reasonSuggestions.map((r) {
              final isActive = reason == r;
              return _QuickPickChip(
                label: r,
                isSelected: isActive,
                onTap: () => onReasonChanged(r),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Step 5 — Confirm: Summary + item previews
// ═══════════════════════════════════════════════════════════════════════

class StepConfirm extends StatelessWidget {
  final String direction;
  final String method;
  final double value;
  final String scope;
  final List<String> categoryNames;
  final List<String> itemIds;
  final bool startsNow;
  final DateTime? startsAt;
  final bool hasEndDate;
  final DateTime? endsAt;
  final bool isPublic;
  final String reason;
  final List<BizItem> items;

  const StepConfirm({
    super.key,
    required this.direction,
    required this.method,
    required this.value,
    required this.scope,
    required this.categoryNames,
    required this.itemIds,
    required this.startsNow,
    required this.startsAt,
    required this.hasEndDate,
    required this.endsAt,
    required this.isPublic,
    required this.reason,
    required this.items,
  });

  bool get _isDecrease => direction == 'decrease';
  bool get _isPercentage => method == 'percentage';

  Color get _accentColor =>
      _isDecrease ? AppColors.success : AppColors.warning;

  String get _valueText {
    if (_isPercentage) {
      return '${value.toStringAsFixed(value == value.truncateToDouble() ? 0 : 1)}%';
    }
    return '${value.toStringAsFixed(value == value.truncateToDouble() ? 0 : 2)} د.أ';
  }

  String _directionText(BuildContext context) =>
      _isDecrease ? context.l10n.pcDecrease : context.l10n.pcIncrease;

  String _scopeText(BuildContext context) {
    if (scope == 'all') return context.l10n.pcScopeAllCount(items.length);
    if (scope == 'category') {
      return context.l10n.pcCategoriesLabel(categoryNames.join('، '));
    }
    return context.l10n.pcSpecificItemsCount(itemIds.length);
  }

  String _scheduleText(BuildContext context) {
    final start = startsNow ? context.l10n.pcImmediate : _formatDate(startsAt);
    final end = hasEndDate ? _formatDate(endsAt) : context.l10n.pcNoEnd;
    return '$start → $end';
  }

  String _publicText(BuildContext context) =>
      isPublic ? context.l10n.pcPublicAnnouncement : context.l10n.pcSilentChange;

  List<BizItem> get _affectedItems {
    if (scope == 'all') return items;
    if (scope == 'category') {
      return items
          .where((i) => categoryNames.contains(i.categoryName))
          .toList();
    }
    return items.where((i) => itemIds.contains(i.id)).toList();
  }

  double _computeNewPrice(double originalJod) {
    if (_isPercentage) {
      final factor = _isDecrease ? (1 - value / 100) : (1 + value / 100);
      return (originalJod * factor * 100).roundToDouble() / 100;
    }
    final delta = _isDecrease ? -value : value;
    final result = originalJod + delta;
    return result < 0 ? 0 : result;
  }

  static String _formatDate(DateTime? date) {
    if (date == null) return '—';
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}'
        ' ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final affected = _affectedItems;
    final previews = affected.take(3).toList();

    return ListView(
      padding: AppSpacing.screenPadding,
      children: [
        // Summary card
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: _accentColor.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _accentColor.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            children: [
              Icon(
                _isDecrease
                    ? Icons.arrow_circle_down_outlined
                    : Icons.arrow_circle_up_outlined,
                size: 36,
                color: _accentColor,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${_directionText(context)} $_valueText',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: _accentColor,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _SummaryRow(
                icon: Icons.layers_outlined,
                text: _scopeText(context),
              ),
              const SizedBox(height: AppSpacing.sm),
              _SummaryRow(
                icon: Icons.schedule_outlined,
                text: _scheduleText(context),
              ),
              const SizedBox(height: AppSpacing.sm),
              _SummaryRow(
                icon: isPublic
                    ? Icons.campaign_outlined
                    : Icons.visibility_off_outlined,
                text: _publicText(context),
              ),
              if (reason.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                _SummaryRow(
                  icon: Icons.label_outline,
                  text: reason,
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.xxl),

        // Item previews
        if (previews.isNotEmpty) ...[
          _SectionLabel(
            label: context.l10n.pcConfirmPreview(previews.length, affected.length),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...previews.map((item) {
            final originalJod = item.price?.jod ?? 0;
            final newJod = _computeNewPrice(originalJod);
            final changePercent = originalJod > 0
                ? ((newJod - originalJod) / originalJod * 100)
                    .round()
                : 0;
            final badgeText = _isDecrease
                ? '$changePercent%'
                : '+$changePercent%';

            return Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
              ),
              child: Row(
                children: [
                  // Change badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: _accentColor.withValues(alpha: 0.1),
                      borderRadius: AppRadius.pill,
                    ),
                    child: Text(
                      badgeText,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: _accentColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  // Prices
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              '${originalJod.toStringAsFixed(2)} د.أ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              '${newJod.toStringAsFixed(2)} د.أ',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: _accentColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],

        const SizedBox(height: AppSpacing.lg),

        // One-at-a-time note
        _InfoBox(
          color: AppColors.info,
          text: context.l10n.pcOneChangeNote,
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Shared helper widgets
// ═══════════════════════════════════════════════════════════════════════

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: context.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String label;
  final String? suffix;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionCard({
    this.icon,
    this.iconColor,
    required this.label,
    this.suffix,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.05)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.outlineVariant,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            if (icon != null)
              Icon(icon, size: 28, color: iconColor ?? AppColors.primary),
            if (icon != null) const SizedBox(height: AppSpacing.sm),
            if (suffix != null)
              Text(
                suffix!,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            if (suffix != null) const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color:
                    isSelected ? AppColors.primary : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickPickChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _QuickPickChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Theme.of(context).colorScheme.surfaceContainerLowest,
          borderRadius: AppRadius.pill,
          border: Border.all(
            color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _RadioOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RadioOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected ? AppColors.primary : Theme.of(context).colorScheme.outline,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              label,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckboxRow extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const _CheckboxRow({
    required this.label,
    this.subtitle,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: AppSpacing.xxxl,
          top: AppSpacing.sm,
          bottom: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isChecked
                    ? AppColors.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isChecked
                      ? AppColors.primary
                      : Theme.of(context).colorScheme.outline,
                  width: 1.5,
                ),
              ),
              child: isChecked
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight:
                          isChecked ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final Color color;
  final String text;

  const _InfoBox({
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 16,
            color: color.withValues(alpha: 0.6),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: color.withValues(alpha: 0.8),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateTimePickerField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;

  const _DateTimePickerField({
    required this.label,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasDate = date != null;
    final display = hasDate
        ? '${date!.year}/${date!.month.toString().padLeft(2, '0')}/${date!.day.toString().padLeft(2, '0')}'
            '  ${date!.hour.toString().padLeft(2, '0')}:${date!.minute.toString().padLeft(2, '0')}'
        : label;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                display,
                style: TextStyle(
                  fontSize: 13,
                  color: hasDate ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            if (!hasDate)
              Icon(
                Icons.access_time_outlined,
                size: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _SummaryRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: context.textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
