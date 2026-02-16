import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/button.dart' as btn;
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/features/pages/presentation/widgets/sections/booking_step_confirm.dart';
import 'package:honak/features/pages/presentation/widgets/sections/booking_step_datetime.dart';
import 'package:honak/features/pages/presentation/widgets/sections/booking_step_team.dart';
import 'package:honak/shared/entities/selected_item.dart';
import 'package:honak/shared/widgets/item_selection/item_browse_step.dart';
import 'package:honak/shared/widgets/item_selection/item_configuration_step.dart';
import 'package:honak/shared/widgets/wizard_step_indicator.dart';

enum ItemPickerMode { singlePick, multiPick }

enum PickerWizardMode { pick, book }

class BookingResult {
  final String serviceId;
  final String serviceName;
  final int priceCents;
  final int durationMinutes;
  final String? memberId;
  final String? memberName;
  final DateTime? date;
  final String? time;
  final String? notes;

  const BookingResult({
    required this.serviceId,
    required this.serviceName,
    required this.priceCents,
    required this.durationMinutes,
    this.memberId,
    this.memberName,
    this.date,
    this.time,
    this.notes,
  });
}

class ItemPickerSheet extends ConsumerStatefulWidget {
  final String pageSlug;
  final void Function(SelectedItem)? onItemSelected;
  final void Function(List<SelectedItem>)? onItemsSelected;
  final ItemPickerMode mode;
  final String title;
  final bool showQuantity;
  final List<SelectedItem> initialSelections;

  // Wizard params
  final PickerWizardMode wizardMode;
  final List<Map<String, dynamic>> teamMembers;
  final Item? preSelectedItem;
  final String? pageName;
  final int? durationMinutes;
  final void Function(BookingResult)? onBookingConfirmed;

  const ItemPickerSheet({
    super.key,
    required this.pageSlug,
    this.onItemSelected,
    this.onItemsSelected,
    this.mode = ItemPickerMode.singlePick,
    this.title = 'اختر منتج',
    this.showQuantity = true,
    this.initialSelections = const [],
    this.wizardMode = PickerWizardMode.pick,
    this.teamMembers = const [],
    this.preSelectedItem,
    this.pageName,
    this.durationMinutes,
    this.onBookingConfirmed,
  });

  @override
  ConsumerState<ItemPickerSheet> createState() => _ItemPickerSheetState();
}

enum _WizardStep { browse, team, dateTime, confirm }

class _ItemPickerSheetState extends ConsumerState<ItemPickerSheet> {
  // Wizard navigation
  late List<_WizardStep> _steps;
  int _currentStep = 0;

  // Browse state
  Item? _selectedItem;
  late List<SelectedItem> _selections;

  // Configure state (pick mode only)
  Item? _configuringItem;

  // Team state
  String? _selectedMemberId;
  String? _selectedMemberName;

  // DateTime state
  DateTime? _selectedDate;
  String? _selectedTime;

  // Confirm state
  final _notesController = TextEditingController();

  int get _durationMinutes =>
      widget.durationMinutes ??
      ((_selectedItem?.sortOrder ?? 0) > 0
          ? _selectedItem!.sortOrder
          : 30);

  @override
  void initState() {
    super.initState();
    if (widget.wizardMode == PickerWizardMode.book) {
      _steps = [
        if (widget.preSelectedItem == null) _WizardStep.browse,
        if (widget.teamMembers
            .where((m) => m['active'] != false)
            .isNotEmpty)
          _WizardStep.team,
        _WizardStep.dateTime,
        _WizardStep.confirm,
      ];
      if (widget.preSelectedItem != null) {
        _selectedItem = widget.preSelectedItem;
      }
    } else {
      _steps = [_WizardStep.browse];
    }
    _selections = List.of(widget.initialSelections);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  // ── Pick mode handlers (unchanged from original) ───────────

  bool _isItemSelected(String itemId) {
    if (widget.mode == ItemPickerMode.singlePick) {
      return _selectedItem?.id == itemId;
    }
    return _selections.any((s) => s.itemId == itemId);
  }

  void _handleItemTap(Item item) {
    if (widget.mode == ItemPickerMode.singlePick) {
      setState(() {
        _selectedItem = _selectedItem?.id == item.id ? null : item;
      });
    } else {
      if (item.optionGroups.isNotEmpty) {
        setState(() => _configuringItem = item);
      } else {
        _toggleMultiPickItem(item);
      }
    }
  }

  void _toggleMultiPickItem(Item item) {
    final selected = SelectedItem(
      itemId: item.id,
      name: item.nameAr,
      image: item.images.isNotEmpty ? item.images.first : null,
      basePriceCents: item.price.cents,
      categoryName: item.categoryName,
      description: item.descriptionAr,
    );
    setState(() {
      if (_isItemSelected(item.id)) {
        _selections.removeWhere((s) => s.itemId == item.id);
      } else {
        _selections.add(selected);
      }
    });
  }

  void _handleSinglePickSend() {
    final item = _selectedItem;
    if (item == null) return;

    if (item.optionGroups.isNotEmpty) {
      setState(() => _configuringItem = item);
    } else {
      final selected = SelectedItem(
        itemId: item.id,
        name: item.nameAr,
        image: item.images.isNotEmpty ? item.images.first : null,
        basePriceCents: item.price.cents,
        categoryName: item.categoryName,
        description: item.descriptionAr,
      );
      widget.onItemSelected?.call(selected);
      Navigator.pop(context);
    }
  }

  void _handleConfigured(SelectedItem selected) {
    if (widget.mode == ItemPickerMode.singlePick) {
      widget.onItemSelected?.call(selected);
      Navigator.pop(context);
    } else {
      setState(() {
        _selections.removeWhere((s) => s.itemId == selected.itemId);
        _selections.add(selected);
        _configuringItem = null;
      });
    }
  }

  void _handleMultiPickDone() {
    widget.onItemsSelected?.call(_selections);
    Navigator.pop(context);
  }

  // ── Book mode handlers ─────────────────────────────────────

  void _handleBrowseItemTap(Item item) {
    setState(() {
      _selectedItem = _selectedItem?.id == item.id ? null : item;
    });
    if (_selectedItem != null) {
      _next();
    }
  }

  bool get _canProceed {
    switch (_steps[_currentStep]) {
      case _WizardStep.browse:
        return _selectedItem != null;
      case _WizardStep.team:
        return true;
      case _WizardStep.dateTime:
        return _selectedDate != null && _selectedTime != null;
      case _WizardStep.confirm:
        return true;
    }
  }

  void _next() {
    if (_currentStep < _steps.length - 1 && _canProceed) {
      setState(() => _currentStep++);
    }
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _confirm() {
    final result = BookingResult(
      serviceId: _selectedItem?.id ?? '',
      serviceName: _selectedItem?.nameAr ?? '',
      priceCents: _selectedItem?.price.cents ?? 0,
      durationMinutes: _durationMinutes,
      memberId: _selectedMemberId,
      memberName: _selectedMemberName,
      date: _selectedDate,
      time: _selectedTime,
      notes: _notesController.text.isNotEmpty
          ? _notesController.text
          : null,
    );
    widget.onBookingConfirmed?.call(result);
    Navigator.of(context).pop();
    context.showSnackBar('تم تأكيد الحجز بنجاح');
  }

  // ── Build ──────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (widget.wizardMode == PickerWizardMode.book) {
      return _buildBookMode();
    }
    return _buildPickMode();
  }

  // ── Pick mode layout (identical to original) ───────────────

  Widget _buildPickMode() {
    if (_configuringItem != null) {
      return ItemConfigurationStep(
        item: _configuringItem!,
        showQuantity: widget.showQuantity,
        confirmLabel:
            widget.mode == ItemPickerMode.singlePick ? 'إرسال' : 'إضافة',
        onConfirm: _handleConfigured,
        onBack: () => setState(() => _configuringItem = null),
      );
    }

    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHandle(cs),
        _buildBrowseHeader(cs),
        Flexible(
          child: ItemBrowseStep(
            pageSlug: widget.pageSlug,
            showRadio: true,
            teamMembers: widget.teamMembers,
            selectedItem: widget.mode == ItemPickerMode.singlePick
                ? _selectedItem
                : null,
            selectedIds: widget.mode == ItemPickerMode.multiPick
                ? _selections.map((s) => s.itemId).toSet()
                : const {},
            onItemTap: _handleItemTap,
          ),
        ),
        if (widget.mode == ItemPickerMode.singlePick)
          _buildSinglePickFooter()
        else
          _buildMultiPickFooter(),
      ],
    );
  }

  // ── Book mode layout ───────────────────────────────────────

  Widget _buildBookMode() {
    final cs = context.colorScheme;
    final isLastStep = _steps[_currentStep] == _WizardStep.confirm;

    final stepLabels = _steps.map((s) {
      switch (s) {
        case _WizardStep.browse:
          return 'الخدمة';
        case _WizardStep.team:
          return 'الموظف';
        case _WizardStep.dateTime:
          return 'الموعد';
        case _WizardStep.confirm:
          return 'تأكيد';
      }
    }).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Handle bar
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: AppSpacing.sm),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: cs.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        // Header
        _buildBookHeader(cs),
        // Step indicator
        WizardStepIndicator(
          labels: stepLabels,
          currentStep: _currentStep,
        ),
        const SizedBox(height: AppSpacing.md),
        // Step content
        Flexible(child: _buildStepContent()),
        // Bottom bar
        _WizardBottomBar(
          isFirstStep: _currentStep == 0,
          isLastStep: isLastStep,
          canProceed: _canProceed,
          onBack: _back,
          onNext: isLastStep ? _confirm : _next,
        ),
      ],
    );
  }

  Widget _buildBookHeader(ColorScheme cs) {
    final serviceName = _selectedItem?.nameAr ?? '';
    final pageName = widget.pageName ?? '';
    final subtitle = serviceName.isNotEmpty && pageName.isNotEmpty
        ? '$serviceName \u2014 $pageName'
        : serviceName.isNotEmpty
            ? serviceName
            : pageName;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg, AppSpacing.md, AppSpacing.sm, 0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'حجز موعد',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    subtitle,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_steps[_currentStep]) {
      case _WizardStep.browse:
        return ItemBrowseStep(
          pageSlug: widget.pageSlug,
          teamMembers: widget.teamMembers,
          selectedItem: _selectedItem,
          onItemTap: _handleBrowseItemTap,
        );
      case _WizardStep.team:
        return TeamStepContent(
          members: widget.teamMembers,
          selectedMemberId: _selectedMemberId,
          onSelected: (id, name) => setState(() {
            _selectedMemberId = id;
            _selectedMemberName = name;
          }),
        );
      case _WizardStep.dateTime:
        return DateTimeStepContent(
          durationMinutes: _durationMinutes,
          selectedDate: _selectedDate,
          selectedTime: _selectedTime,
          onDateSelected: (d) => setState(() => _selectedDate = d),
          onTimeSelected: (t) => setState(() => _selectedTime = t),
        );
      case _WizardStep.confirm:
        return ConfirmStepContent(
          serviceName: _selectedItem?.nameAr ?? '',
          priceCents: _selectedItem?.price.cents ?? 0,
          durationMinutes: _durationMinutes,
          memberName: _selectedMemberName,
          selectedDate: _selectedDate,
          selectedTime: _selectedTime,
          notesController: _notesController,
        );
    }
  }

  // ── Shared pick mode sub-widgets ───────────────────────────

  Widget _buildHandle(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: AppSpacing.sm),
      child: Container(
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          color: cs.outlineVariant,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildBrowseHeader(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.lg,
        end: AppSpacing.sm,
        top: AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, size: 20),
            color: cs.onSurfaceVariant,
          ),
        ],
      ),
    );
  }

  Widget _buildSinglePickFooter() {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(
              color: context.colorScheme.outlineVariant, width: 0.5),
        ),
      ),
      child: btn.Button(
        onPressed: _selectedItem != null ? _handleSinglePickSend : null,
        label: 'إرسال',
        icon: const btn.ButtonIcon(Icons.send_rounded),
        size: btn.ButtonSize.large,
        expand: true,
      ),
    );
  }

  Widget _buildMultiPickFooter() {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(
              color: context.colorScheme.outlineVariant, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Text(
            '${_selections.length} عنصر محدد',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          btn.Button(
            onPressed: _selections.isNotEmpty ? _handleMultiPickDone : null,
            label: 'تم',
          ),
        ],
      ),
    );
  }
}

// ── Wizard bottom bar (book mode) ───────────────────────────

class _WizardBottomBar extends StatelessWidget {
  final bool isFirstStep;
  final bool isLastStep;
  final bool canProceed;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const _WizardBottomBar({
    required this.isFirstStep,
    required this.isLastStep,
    required this.canProceed,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.colorScheme.outlineVariant),
        ),
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          if (!isFirstStep)
            Expanded(
              child: btn.Button(
                onPressed: onBack,
                label: 'رجوع',
                variant: btn.Variant.outlined,
                expand: true,
              ),
            )
          else
            const Spacer(),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: btn.Button(
              onPressed: canProceed ? onNext : null,
              label: isLastStep ? 'تأكيد الحجز' : 'التالي',
              expand: true,
            ),
          ),
        ],
      ),
    );
  }
}
