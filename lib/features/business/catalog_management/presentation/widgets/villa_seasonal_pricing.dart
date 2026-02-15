import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/villa_seasonal_deals.dart';
import 'package:honak/features/pages/domain/entities/seasonal_pricing.dart';
import 'package:honak/features/pages/domain/seasonal_pricing_utils.dart';
import 'package:honak/shared/entities/money.dart';

/// Editable seasonal pricing tab — seasons, holidays, early bird, last minute.
/// Matches Figma SeasonalPricing.tsx pixel-for-pixel.
class VillaSeasonalPricing extends StatefulWidget {
  final SeasonalPricing? initialData;
  const VillaSeasonalPricing({super.key, this.initialData});

  @override
  State<VillaSeasonalPricing> createState() => _VillaSeasonalPricingState();
}

class _VillaSeasonalPricingState extends State<VillaSeasonalPricing> {
  late List<SeasonRule> _seasons;
  late List<HolidaySurcharge> _holidays;
  late EarlyBirdDiscount _earlyBird;
  late LastMinuteDeal _lastMinute;
  String? _editingSeasonId;
  String _expandedSub = 'seasons';
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    final sp = widget.initialData;
    _seasons = List.of(sp?.seasons ?? defaultSeasons);
    _holidays = List.of(sp?.holidays ?? defaultHolidays);
    _earlyBird = sp?.earlyBird ?? const EarlyBirdDiscount();
    _lastMinute = sp?.lastMinute ?? const LastMinuteDeal();
  }

  SeasonRule? get _currentSeason => getCurrentSeason(_seasons);

  void _toggleSub(String id) =>
      setState(() => _expandedSub = _expandedSub == id ? '' : id);

  void _markChanged() => setState(() => _hasChanges = true);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCurrentBanner(context),
        const SizedBox(height: AppSpacing.lg),
        _buildSubSection(
          context, 'seasons', Icons.calendar_month_outlined, AppColors.primary,
          'المواسم', '${_seasons.where((s) => s.active).length} نشط',
          _buildSeasonsContent,
        ),
        const SizedBox(height: AppSpacing.md),
        _buildSubSection(
          context, 'holidays', Icons.star_outline, AppColors.secondary,
          'رسوم الأعياد والمناسبات',
          '${_holidays.where((h) => h.active).length} نشط',
          () => VillaHolidaysContent(
            holidays: _holidays,
            onToggle: (i) {
              _holidays[i] =
                  _holidays[i].copyWith(active: !_holidays[i].active);
              _markChanged();
            },
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildSubSection(
          context, 'earlybird', Icons.auto_awesome, Colors.purple,
          'خصم الحجز المبكر',
          _earlyBird.active ? '-${_earlyBird.discountPercent}٪' : null,
          () => VillaDiscountContent(
            active: _earlyBird.active,
            daysAhead: _earlyBird.daysAhead,
            discountPercent: _earlyBird.discountPercent,
            color: Colors.purple,
            toggleLabel: 'تفعيل الخصم',
            dayOptions: const [7, 14, 21, 30],
            infoText: 'العميل يحصل على خصم ${_earlyBird.discountPercent}٪ '
                'عند الحجز قبل ${_earlyBird.daysAhead} يوم أو أكثر '
                'من تاريخ الوصول',
            onToggleActive: () => setState(() {
              _earlyBird = _earlyBird.copyWith(active: !_earlyBird.active);
              _hasChanges = true;
            }),
            onDaysChanged: (v) => setState(() {
              _earlyBird = _earlyBird.copyWith(daysAhead: v);
              _hasChanges = true;
            }),
            onPercentChanged: (v) => setState(() {
              _earlyBird = _earlyBird.copyWith(discountPercent: v);
              _hasChanges = true;
            }),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildSubSection(
          context, 'lastminute', Icons.timer_outlined, AppColors.error,
          'عروض اللحظة الأخيرة',
          _lastMinute.active ? '-${_lastMinute.discountPercent}٪' : null,
          () => VillaDiscountContent(
            active: _lastMinute.active,
            daysAhead: _lastMinute.daysAhead,
            discountPercent: _lastMinute.discountPercent,
            color: AppColors.error,
            toggleLabel: 'تفعيل العرض',
            dayOptions: const [1, 2, 3, 4],
            infoText: 'العميل يحصل على خصم ${_lastMinute.discountPercent}٪ '
                'عند الحجز قبل ${_lastMinute.daysAhead} يوم أو أقل '
                'من تاريخ الوصول',
            onToggleActive: () => setState(() {
              _lastMinute = _lastMinute.copyWith(active: !_lastMinute.active);
              _hasChanges = true;
            }),
            onDaysChanged: (v) => setState(() {
              _lastMinute = _lastMinute.copyWith(daysAhead: v);
              _hasChanges = true;
            }),
            onPercentChanged: (v) => setState(() {
              _lastMinute = _lastMinute.copyWith(discountPercent: v);
              _hasChanges = true;
            }),
          ),
        ),
        if (_hasChanges) ...[
          const SizedBox(height: AppSpacing.lg),
          _buildSaveButton(context),
        ],
      ],
    );
  }

  // ── Current Season Banner ─────────────────────────────────────
  Widget _buildCurrentBanner(BuildContext context) {
    final cs = _currentSeason;
    if (cs == null) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: context.colorScheme.outlineVariant),
        ),
        child: Column(
          children: [
            Icon(Icons.calendar_month, size: 20, color: AppColors.textHint),
            const SizedBox(height: AppSpacing.xs),
            const Text('لا يوجد موسم نشط حالياً',
                style: TextStyle(
                    fontSize: 12, color: AppColors.textSecondary)),
            const Text('أسعارك الأساسية مطبّقة',
                style: TextStyle(fontSize: 9, color: AppColors.textHint)),
          ],
        ),
      );
    }
    final color = parseSeasonColor(cs.color);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.8)],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(seasonIcon(cs.icon), size: 18, color: Colors.white),
                const SizedBox(width: AppSpacing.sm),
                Text(cs.name, style: const TextStyle(
                    fontSize: 14, color: Colors.white)),
              ]),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: AppRadius.pill,
                ),
                child: const Row(
                    mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.bolt, size: 9, color: Colors.white),
                  SizedBox(width: 2),
                  Text('نشط الآن', style: TextStyle(
                      fontSize: 10, color: Colors.white)),
                ]),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(children: [
            _bannerPrice('أيام الأسبوع', cs.weekdayCents),
            Container(width: 1, height: 32, color: Colors.white24,
                margin: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg)),
            _bannerPrice('نهاية الأسبوع', cs.weekendCents),
          ]),
          const SizedBox(height: AppSpacing.sm),
          Text(formatSeasonRange(cs), style: TextStyle(
              fontSize: 9, color: Colors.white.withValues(alpha: 0.4))),
        ],
      ),
    );
  }

  Widget _bannerPrice(String label, int cents) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(
            fontSize: 10, color: Colors.white.withValues(alpha: 0.6))),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(Money(cents).toJodString(), style: const TextStyle(
                fontSize: 18, color: Colors.white)),
            const SizedBox(width: 4),
            Text('د.أ/ليلة', style: TextStyle(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.6))),
          ],
        ),
      ],
    );
  }

  // ── Sub-Section Accordion ─────────────────────────────────────
  Widget _buildSubSection(BuildContext context, String id, IconData icon,
      Color iconColor, String title, String? badge,
      Widget Function() content) {
    final expanded = _expandedSub == id;
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
          GestureDetector(
            onTap: () => _toggleSub(id),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg, vertical: AppSpacing.md),
              child: Row(
                children: [
                  Icon(expanded ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                      size: 14, color: AppColors.textHint),
                  const Spacer(),
                  if (badge != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: iconColor.withValues(alpha: 0.08),
                        borderRadius: AppRadius.pill,
                      ),
                      child: Text(badge, style: TextStyle(
                          fontSize: 10, color: iconColor)),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                  Text(title, style: TextStyle(fontSize: 14,
                      color: context.colorScheme.onSurface)),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(icon, size: 16, color: iconColor),
                ],
              ),
            ),
          ),
          if (expanded)
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
              child: content(),
            ),
        ],
      ),
    );
  }

  // ── Seasons Content ───────────────────────────────────────────
  Widget _buildSeasonsContent() {
    return Column(
      children: [
        for (final season in _seasons) ...[
          _buildSeasonCard(season),
          const SizedBox(height: AppSpacing.sm),
        ],
        _buildTimeline(),
      ],
    );
  }

  Widget _buildSeasonCard(SeasonRule season) {
    final color = parseSeasonColor(season.color);
    final isCurrent = _currentSeason?.id == season.id;
    final isEditing = _editingSeasonId == season.id;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: season.active
            ? (isCurrent ? color.withValues(alpha: 0.04) : null)
            : AppColors.surfaceVariant.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: season.active
            ? (isCurrent
                ? AppColors.primary
                : context.colorScheme.outlineVariant)
            : context.colorScheme.outlineVariant),
      ),
      child: Opacity(
        opacity: season.active ? 1.0 : 0.6,
        child: Column(
          children: [
            Row(
              children: [
                seasonalToggle(season.active, () {
                  final i = _seasons.indexOf(season);
                  _seasons[i] = season.copyWith(active: !season.active);
                  _markChanged();
                }),
                const SizedBox(width: AppSpacing.sm),
                if (isCurrent)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: AppRadius.pill,
                    ),
                    child: const Text('الآن', style: TextStyle(
                        fontSize: 8, color: Colors.white)),
                  ),
                if (isCurrent) const SizedBox(width: AppSpacing.xs),
                GestureDetector(
                  onTap: () => setState(() => _editingSeasonId =
                      isEditing ? null : season.id),
                  child: Icon(Icons.edit_outlined, size: 12,
                      color: AppColors.textHint),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(season.name, style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600,
                        color: season.active
                            ? color : AppColors.textSecondary)),
                    Text(formatSeasonRange(season),
                        style: const TextStyle(
                            fontSize: 9, color: AppColors.textHint)),
                  ],
                ),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(seasonIcon(season.icon),
                      size: 14, color: color),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            if (!isEditing)
              Row(children: [
                Expanded(child: seasonalPriceBox(
                    context, 'أيام الأسبوع', season.weekdayCents)),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: seasonalPriceBox(
                    context, 'نهاية الأسبوع', season.weekendCents)),
              ])
            else
              _buildSeasonEdit(season),
          ],
        ),
      ),
    );
  }

  Widget _buildSeasonEdit(SeasonRule season) {
    final wdCtrl = TextEditingController(
        text: (season.weekdayCents / 100).toStringAsFixed(0));
    final weCtrl = TextEditingController(
        text: (season.weekendCents / 100).toStringAsFixed(0));
    return Column(
      children: [
        Row(children: [
          Expanded(child: seasonalEditInput(
              context, 'سعر أيام الأسبوع (د.أ/ليلة)', wdCtrl, (v) {
            final i = _seasons.indexOf(season);
            _seasons[i] = season.copyWith(
                weekdayCents: ((double.tryParse(v) ?? 0) * 100).toInt());
            _markChanged();
          })),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: seasonalEditInput(
              context, 'سعر نهاية الأسبوع (د.أ/ليلة)', weCtrl, (v) {
            final i = _seasons.indexOf(season);
            _seasons[i] = season.copyWith(
                weekendCents: ((double.tryParse(v) ?? 0) * 100).toInt());
            _markChanged();
          })),
        ]),
        const SizedBox(height: AppSpacing.sm),
        GestureDetector(
          onTap: () => setState(() => _editingSeasonId = null),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check, size: 10, color: AppColors.primary),
              SizedBox(width: 4),
              Text('تم', style: TextStyle(
                  fontSize: 10, color: AppColors.primary)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline() {
    const months = [
      'ي', 'ف', 'م', 'أ', 'م', 'ي', 'ي', 'أ', 'س', 'أ', 'ن', 'د',
    ];
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('خط زمني للأسعار — ١٢ شهر',
              style: TextStyle(fontSize: 9, color: AppColors.textHint)),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: Row(
              children: List.generate(12, (m) {
                final season = getSeasonForMonth(m + 1, _seasons);
                final color = season != null
                    ? parseSeasonColor(season.color) : AppColors.divider;
                return Expanded(
                  child: Container(
                    height: 24, color: color,
                    alignment: Alignment.center,
                    child: Text(months[m], style: TextStyle(fontSize: 7,
                        color: season != null ? Colors.white
                            : AppColors.textHint)),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            alignment: WrapAlignment.end,
            children: _seasons.where((s) => s.active).map((s) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(s.name, style: const TextStyle(
                    fontSize: 8, color: AppColors.textSecondary)),
                const SizedBox(width: 4),
                Container(width: 8, height: 8,
                    decoration: BoxDecoration(
                      color: parseSeasonColor(s.color),
                      borderRadius: BorderRadius.circular(4),
                    )),
              ],
            )).toList(),
          ),
        ],
      ),
    );
  }

  // ── Save Button ───────────────────────────────────────────────
  Widget _buildSaveButton(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _hasChanges = false),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppRadius.md),
          boxShadow: [BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.2),
              blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('حفظ التسعير الموسمي', style: TextStyle(
                fontSize: 14, color: Colors.white)),
            SizedBox(width: AppSpacing.sm),
            Icon(Icons.check, size: 16, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
