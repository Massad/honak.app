import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/domain/entities/truck.dart';
import 'package:honak/features/business/order_management/presentation/widgets/customer_queue_position.dart';

// ═══════════════════════════════════════════════════════════════
// DeliveryEstimationConfigWidget — Business configures how
// customers see delivery tracking & ETA.
// Part of Account → Operations settings.
// ═══════════════════════════════════════════════════════════════

class DeliveryEstimationConfigWidget extends StatefulWidget {
  final DeliveryEstimationConfig config;
  final ValueChanged<DeliveryEstimationConfig> onConfigChanged;

  const DeliveryEstimationConfigWidget({
    super.key,
    required this.config,
    required this.onConfigChanged,
  });

  @override
  State<DeliveryEstimationConfigWidget> createState() =>
      _DeliveryEstimationConfigWidgetState();
}

class _DeliveryEstimationConfigWidgetState
    extends State<DeliveryEstimationConfigWidget> {
  late DeliveryEstimationConfig _form;

  @override
  void initState() {
    super.initState();
    _form = widget.config;
  }

  @override
  void didUpdateWidget(covariant DeliveryEstimationConfigWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config != widget.config) {
      _form = widget.config;
    }
  }

  void _update(DeliveryEstimationConfig updated) {
    setState(() => _form = updated);
    widget.onConfigChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Mode selection ──
          _SectionLabel('نوع التتبع'),
          const SizedBox(height: AppSpacing.sm),
          ..._modeOptions.map((opt) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _ModeCard(
                  label: opt.label,
                  desc: opt.desc,
                  selected: _form.mode == opt.mode,
                  onTap: () => _update(_form.copyWith(mode: opt.mode)),
                ),
              )),

          const SizedBox(height: AppSpacing.xl),

          // ── Visibility toggles ──
          _SectionLabel('ماذا يرى العميل؟'),
          const SizedBox(height: AppSpacing.sm),
          _ToggleRow(
            label: 'ترتيبه في الدور',
            desc: 'مثال: أنت #3 في مسار اليوم',
            value: _form.showQueuePosition,
            onChanged: (v) =>
                _update(_form.copyWith(showQueuePosition: v)),
            disabled: _form.mode != EstimationMode.routeBased,
          ),
          const SizedBox(height: AppSpacing.sm),
          _ToggleRow(
            label: 'اسم السائق وهاتفه',
            desc: 'يمكنه الاتصال بالسائق مباشرة',
            value: _form.showDriverContact,
            onChanged: (v) =>
                _update(_form.copyWith(showDriverContact: v)),
          ),
          const SizedBox(height: AppSpacing.sm),
          _ToggleRow(
            label: 'تتبع مباشر',
            desc: 'خريطة مباشرة لموقع الشاحنة (قريباً)',
            value: _form.showLiveTracking,
            onChanged: (_) {},
            disabled: true,
            comingSoon: true,
          ),

          const SizedBox(height: AppSpacing.xl),

          // ── Text fields ──
          _ConfigTextField(
            label: 'وقت التوصيل المعتاد',
            value: _form.typicalDeliveryWindow,
            placeholder: 'مثال: ١-٢ ساعة بعد بداية المسار',
            onChanged: (v) =>
                _update(_form.copyWith(typicalDeliveryWindow: v)),
          ),
          const SizedBox(height: AppSpacing.lg),
          _ConfigTextField(
            label: 'أيام التوصيل',
            value: _form.routeDaysLabel,
            placeholder: 'مثال: أحد، ثلاثاء، خميس',
            onChanged: (v) =>
                _update(_form.copyWith(routeDaysLabel: v)),
          ),
          const SizedBox(height: AppSpacing.lg),
          _ConfigTextField(
            label: 'رسالة خارج أيام التوصيل',
            value: _form.offDayMessage,
            placeholder: 'مثال: التوصيل القادم: صباح الأحد',
            onChanged: (v) =>
                _update(_form.copyWith(offDayMessage: v)),
          ),

          const SizedBox(height: AppSpacing.xl),

          // ── Preview ──
          _PreviewSection(form: _form),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Mode options data
// ═══════════════════════════════════════════════════════════════

const _modeOptions = [
  (
    mode: EstimationMode.routeBased,
    label: 'حسب المسار',
    desc: 'يرى العميل ترتيبه في دور التوصيل وعدد المتبقين قبله',
  ),
  (
    mode: EstimationMode.timeEstimate,
    label: 'تقدير زمني',
    desc: 'يظهر "خلال ٣٠-٦٠ دقيقة" بدون تفاصيل الدور',
  ),
  (
    mode: EstimationMode.nextRouteDay,
    label: 'يوم التوصيل التالي',
    desc: 'يرى العميل أقرب يوم توصيل فقط (بدون تتبع)',
  ),
];

// ═══════════════════════════════════════════════════════════════
// _SectionLabel
// ═══════════════════════════════════════════════════════════════

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: AppColors.textSecondary,
        fontSize: 12,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// _ModeCard — radio-style mode selector
// ═══════════════════════════════════════════════════════════════

class _ModeCard extends StatelessWidget {
  final String label;
  final String desc;
  final bool selected;
  final VoidCallback onTap;

  const _ModeCard({
    required this.label,
    required this.desc,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.primary.withValues(alpha: 0.06)
          : AppColors.surface,
      borderRadius: AppRadius.cardInner,
      child: InkWell(
        borderRadius: AppRadius.cardInner,
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 56),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: AppRadius.cardInner,
            border: Border.all(
              color: selected
                  ? AppColors.primary
                  : AppColors.divider,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: selected ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// _ToggleRow — switch row with label, desc, optional "coming soon"
// ═══════════════════════════════════════════════════════════════

class _ToggleRow extends StatelessWidget {
  final String label;
  final String desc;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool disabled;
  final bool comingSoon;

  const _ToggleRow({
    required this.label,
    required this.desc,
    required this.value,
    required this.onChanged,
    this.disabled = false,
    this.comingSoon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: Material(
        color: value && !disabled
            ? AppColors.primary.withValues(alpha: 0.04)
            : AppColors.surface,
        borderRadius: AppRadius.cardInner,
        child: InkWell(
          borderRadius: AppRadius.cardInner,
          onTap: disabled ? null : () => onChanged(!value),
          child: Container(
            constraints: const BoxConstraints(minHeight: 48),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: AppRadius.cardInner,
              border: Border.all(
                color: value && !disabled
                    ? AppColors.primary
                    : AppColors.divider,
              ),
            ),
            child: Row(
              children: [
                // Toggle + badge (LTR side)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (comingSoon) ...[
                      Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.15),
                          borderRadius: AppRadius.pill,
                        ),
                        child: Text(
                          'قريباً',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.warning,
                            fontSize: 8,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    SizedBox(
                      width: 40,
                      height: 24,
                      child: Switch.adaptive(
                        value: value,
                        onChanged: disabled ? null : onChanged,
                        activeTrackColor:
                            AppColors.primary.withValues(alpha: 0.5),
                        activeThumbColor: AppColors.primary,
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Label + desc (RTL side)
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        label,
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: value && !disabled
                              ? AppColors.primary
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        desc,
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// _ConfigTextField
// ═══════════════════════════════════════════════════════════════

class _ConfigTextField extends StatelessWidget {
  final String label;
  final String value;
  final String placeholder;
  final ValueChanged<String> onChanged;

  const _ConfigTextField({
    required this.label,
    required this.value,
    required this.placeholder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textHint,
            ),
            filled: true,
            fillColor: AppColors.surfaceVariant,
            contentPadding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.md,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: AppRadius.cardInner,
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.cardInner,
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.cardInner,
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// _PreviewSection — "how the customer sees it"
// ═══════════════════════════════════════════════════════════════

class _PreviewSection extends StatelessWidget {
  final DeliveryEstimationConfig form;

  const _PreviewSection({required this.form});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: AppRadius.cardInner,
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.visibility_outlined, size: 9, color: AppColors.textHint),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'كيف يراها العميل',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textHint,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          CustomerQueuePosition(
            status: DeliveryTrackingStatus.onRoute,
            estimatedMinutes: 25,
            driverName: form.showDriverContact ? 'محمود' : null,
            driverPhone: form.showDriverContact ? '0791234567' : null,
            showDriverContact: form.showDriverContact,
            variant: CustomerQueueVariant.full,
          ),
        ],
      ),
    );
  }
}
