import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/catalog_management/domain/entities/price_change.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/price_change/wizard_steps.dart';
import 'package:honak/features/business/shared/domain/entities/biz_item.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Full-screen 5-step wizard for creating / editing a price change.
class PriceChangeWizardPage extends StatefulWidget {
  final List<BizItem> items;
  final String itemsLabel;
  final Function(PriceChange) onComplete;
  final PriceChange? editChange;

  const PriceChangeWizardPage({
    super.key,
    required this.items,
    required this.itemsLabel,
    required this.onComplete,
    this.editChange,
  });

  @override
  State<PriceChangeWizardPage> createState() => _PriceChangeWizardPageState();
}

class _PriceChangeWizardPageState extends State<PriceChangeWizardPage> {
  int _step = 0;
  late final TextEditingController _valueController;

  static const _stepLabels = [
    'القيمة',
    'النطاق',
    'الجدول',
    'الإعلان',
    'التأكيد',
  ];

  // Wizard state
  String _direction = 'decrease';
  String _method = 'percentage';
  double _value = 0;
  String _scope = 'all';
  List<String> _categoryNames = [];
  List<String> _itemIds = [];
  bool _startsNow = true;
  DateTime? _startsAt;
  bool _hasEndDate = false;
  DateTime? _endsAt;
  bool _isPublic = true;
  String _reason = '';

  @override
  void initState() {
    super.initState();
    final ec = widget.editChange;
    if (ec != null) {
      _direction = ec.direction;
      _method = ec.method;
      _value = ec.value;
      _scope = ec.scope;
      _categoryNames = List.from(ec.categoryNames);
      _itemIds = List.from(ec.itemIds);

      final startDt = DateTime.parse(ec.startsAt);
      if (startDt.isAfter(DateTime.now())) {
        _startsNow = false;
        _startsAt = startDt;
      }

      if (ec.endsAt != null) {
        _hasEndDate = true;
        _endsAt = DateTime.parse(ec.endsAt!);
      }

      _isPublic = ec.isPublic;
      _reason = ec.reason;
    }
    _valueController = TextEditingController(
      text: _value > 0
          ? (_value == _value.truncateToDouble()
              ? _value.toInt().toString()
              : _value.toString())
          : '',
    );
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  bool get _canAdvance {
    switch (_step) {
      case 0:
        return _value > 0;
      case 1:
        if (_scope == 'category') return _categoryNames.isNotEmpty;
        if (_scope == 'specific') return _itemIds.isNotEmpty;
        return true;
      case 2:
        if (!_startsNow && _startsAt == null) return false;
        if (_hasEndDate && _endsAt == null) return false;
        // Validate start is before end
        if (_hasEndDate && _endsAt != null) {
          final start = _startsNow ? DateTime.now() : (_startsAt ?? DateTime.now());
          if (!start.isBefore(_endsAt!)) return false;
        }
        return true;
      case 3:
        return true;
      case 4:
        return true;
      default:
        return false;
    }
  }

  int get _affectedCount {
    if (_scope == 'all') return widget.items.length;
    if (_scope == 'category') {
      return widget.items
          .where((i) => _categoryNames.contains(i.categoryName))
          .length;
    }
    return _itemIds.length;
  }

  void _onNext() {
    if (_step < 4) {
      setState(() => _step++);
    } else {
      _onConfirm();
    }
  }

  void _onBack() {
    if (_step > 0) {
      setState(() => _step--);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _onConfirm() {
    final now = DateTime.now();
    final change = PriceChange(
      id: 'pc_${now.millisecondsSinceEpoch}',
      direction: _direction,
      method: _method,
      value: _value,
      scope: _scope,
      categoryNames: _categoryNames,
      itemIds: _itemIds,
      startsAt: (_startsNow ? now : _startsAt!).toIso8601String(),
      endsAt: _hasEndDate ? _endsAt!.toIso8601String() : null,
      reason: _reason,
      isPublic: _isPublic,
      status: _startsNow ? 'active' : 'scheduled',
      affectedCount: _affectedCount,
    );
    widget.onComplete(change);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(child: _buildStep()),
          _buildBottom(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsetsDirectional.only(
        top: topPadding + AppSpacing.sm,
        start: AppSpacing.sm,
        end: AppSpacing.sm,
        bottom: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: _step == 0
                    ? () => Navigator.of(context).pop()
                    : _onBack,
                icon: Icon(
                  _step == 0 ? Icons.close : Icons.arrow_forward,
                  size: 20,
                ),
              ),
              const Spacer(),
              Text(
                _stepLabels[_step],
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsetsDirectional.only(end: AppSpacing.md),
                child: Text(
                  '${_step + 1} من 5',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          // Progress bar — 5 segments
          Row(
            children: List.generate(5, (i) {
              final isFilled = i <= _step;
              return Expanded(
                child: Container(
                  height: 3,
                  margin: EdgeInsetsDirectional.only(
                    end: i < 4 ? 3 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: isFilled
                        ? AppColors.primary
                        : Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: AppRadius.pill,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStep() {
    return switch (_step) {
      0 => StepValue(
          direction: _direction,
          method: _method,
          value: _value,
          controller: _valueController,
          onDirectionChanged: (d) => setState(() => _direction = d),
          onMethodChanged: (m) => setState(() {
            _method = m;
            _value = 0;
            _valueController.clear();
          }),
          onValueChanged: (v) => setState(() {
            _value = v;
            final text = v > 0
                ? (v == v.truncateToDouble()
                    ? v.toInt().toString()
                    : v.toString())
                : '';
            if (_valueController.text != text) {
              _valueController.text = text;
            }
          }),
        ),
      1 => StepScope(
          scope: _scope,
          categoryNames: _categoryNames,
          itemIds: _itemIds,
          items: widget.items,
          itemsLabel: widget.itemsLabel,
          onScopeChanged: (s) => setState(() {
            _scope = s;
            _categoryNames = [];
            _itemIds = [];
          }),
          onCategoryNamesChanged: (c) =>
              setState(() => _categoryNames = c),
          onItemIdsChanged: (ids) => setState(() => _itemIds = ids),
        ),
      2 => StepSchedule(
          startsNow: _startsNow,
          startsAt: _startsAt,
          hasEndDate: _hasEndDate,
          endsAt: _endsAt,
          onStartsNowChanged: (v) => setState(() {
            _startsNow = v;
            if (v) _startsAt = null;
          }),
          onStartsAtChanged: (d) => setState(() => _startsAt = d),
          onHasEndDateChanged: (v) => setState(() {
            _hasEndDate = v;
            if (!v) _endsAt = null;
          }),
          onEndsAtChanged: (d) => setState(() => _endsAt = d),
        ),
      3 => StepVisibility(
          isPublic: _isPublic,
          reason: _reason,
          onPublicChanged: (v) => setState(() => _isPublic = v),
          onReasonChanged: (r) => setState(() => _reason = r),
        ),
      4 => StepConfirm(
          direction: _direction,
          method: _method,
          value: _value,
          scope: _scope,
          categoryNames: _categoryNames,
          itemIds: _itemIds,
          startsNow: _startsNow,
          startsAt: _startsAt,
          hasEndDate: _hasEndDate,
          endsAt: _endsAt,
          isPublic: _isPublic,
          reason: _reason,
          items: widget.items,
        ),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildBottom(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final isFinal = _step == 4;

    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md + bottomPadding,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          btn.Button(
            onPressed: _onBack,
            label: _step == 0 ? 'إلغاء' : 'السابق',
            variant: btn.Variant.text,
          ),
          const Spacer(),
          btn.Button(
            onPressed: _canAdvance ? _onNext : null,
            label: isFinal ? 'تأكيد وتطبيق' : 'التالي',
          ),
        ],
      ),
    );
  }
}
