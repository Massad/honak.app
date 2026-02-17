import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/config/business_type_config.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/features/business/catalog_management/presentation/providers/provider.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/team_picker_sheet.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/wizard_steps.dart';
import 'package:honak/features/business/page_settings/presentation/providers/team_provider.dart';
import 'package:honak/features/business/shared/domain/entities/biz_category.dart';
import 'package:honak/features/business/shared/domain/entities/biz_item.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/widgets/app_screen.dart';

/// Full-screen wizard for creating or editing a BizItem.
///
/// Pass [item] for edit mode, leave null for create mode.
/// [config] drives which fields are visible.
/// [pageId] is required for API calls.
/// [categories] provides category options for the selector.
class ItemWizardPage extends ConsumerStatefulWidget {
  final BizItem? item;
  final ItemManagementConfig? config;
  final String pageId;
  final List<BizCategory> categories;

  const ItemWizardPage({
    super.key,
    this.item,
    required this.config,
    required this.pageId,
    this.categories = const [],
  });

  bool get isEdit => item != null;

  @override
  ConsumerState<ItemWizardPage> createState() => _ItemWizardPageState();
}

class _ItemWizardPageState extends ConsumerState<ItemWizardPage> {
  int _currentStep = 0;
  bool _saving = false;

  // Step 1 — Basics
  late final TextEditingController _nameCtrl;
  String? _selectedCategoryId;

  // Step 2 — Details & Pricing
  late final TextEditingController _descCtrl;
  late final TextEditingController _priceCtrl;
  late final TextEditingController _discountCtrl;
  final Map<String, TextEditingController> _propertyControllers = {};
  final Map<String, List<String>> _chipSelections = {};

  // Step 3 — Availability
  String _status = 'active';
  late final TextEditingController _stockCtrl;
  List<String> _assignedTeamIds = [];

  ItemManagementConfig? get _cfg => widget.config;

  @override
  void initState() {
    super.initState();
    final item = widget.item;

    // Step 1
    _nameCtrl = TextEditingController(text: item?.name ?? '');
    _selectedCategoryId = item?.categoryId;

    // Step 2
    _descCtrl = TextEditingController(text: item?.description ?? '');
    _priceCtrl = TextEditingController(
      text: item?.price != null ? item!.price!.toJodString() : '',
    );
    _discountCtrl = TextEditingController(
      text: item?.discountPercent?.toString() ?? '',
    );

    // Init property controllers
    for (final prop in _cfg?.properties ?? <ItemPropertyConfig>[]) {
      final existing = item?.properties[prop.id];
      if (prop.type == ItemPropertyType.chipList) {
        _chipSelections[prop.id] = existing is List
            ? List<String>.from(existing)
            : [];
      } else {
        _propertyControllers[prop.id] = TextEditingController(
          text: existing?.toString() ?? '',
        );
      }
    }

    // Step 3
    _status = item?.status ?? 'active';
    _stockCtrl = TextEditingController(text: item?.stock?.toString() ?? '');
    _assignedTeamIds = List.from(item?.assignedTeamIds ?? []);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    _discountCtrl.dispose();
    _stockCtrl.dispose();
    for (final ctrl in _propertyControllers.values) {
      ctrl.dispose();
    }
    super.dispose();
  }

  bool get _canGoNext {
    if (_currentStep == 0) return _nameCtrl.text.trim().isNotEmpty;
    return true;
  }

  void _next() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      _save();
    }
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);

    try {
      final repo = ref.read(catalogRepositoryProvider);
      final data = _buildPayload();

      if (widget.isEdit) {
        await repo.updateItem(widget.pageId, widget.item!.id, data);
      } else {
        await repo.createItem(widget.pageId, data);
      }

      // Invalidate items cache to refresh the list
      ref.invalidate(bizItemsProvider(widget.pageId));

      if (mounted) {
        context.showSnackBar(context.l10n.wizardSaved);
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(context.l10n.wizardSaveError, isError: true);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Map<String, dynamic> _buildPayload() {
    final properties = <String, dynamic>{};
    for (final prop in _cfg?.properties ?? <ItemPropertyConfig>[]) {
      if (prop.type == ItemPropertyType.chipList) {
        properties[prop.id] = _chipSelections[prop.id] ?? [];
      } else {
        properties[prop.id] = _propertyControllers[prop.id]?.text ?? '';
      }
    }

    final priceText = _priceCtrl.text.trim();
    final discountText = _discountCtrl.text.trim();

    return {
      'name': _nameCtrl.text.trim(),
      'category_id': _selectedCategoryId,
      'description': _descCtrl.text.trim(),
      if (priceText.isNotEmpty)
        'price_cents': Money.fromJod(double.tryParse(priceText) ?? 0).cents,
      if (discountText.isNotEmpty)
        'discount_percent': int.tryParse(discountText) ?? 0,
      'status': _status,
      if (_stockCtrl.text.trim().isNotEmpty)
        'stock': int.tryParse(_stockCtrl.text.trim()),
      'properties': properties,
      if (_assignedTeamIds.isNotEmpty) 'assigned_team_ids': _assignedTeamIds,
    };
  }

  Future<void> _openTeamPicker() async {
    final members = ref.read(teamProvider).valueOrNull ?? [];
    if (members.isEmpty) return;

    final result = await showTeamPickerSheet(
      context,
      members: members,
      selectedIds: _assignedTeamIds,
    );
    if (result != null && mounted) {
      setState(() => _assignedTeamIds = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.isEdit;
    final itemLabel = _cfg?.itemLabelAr ?? context.l10n.catalogSelectedItem;
    final title = isEdit
        ? context.l10n.wizardEditItem(itemLabel)
        : context.l10n.wizardAddItem(itemLabel);

    return AppScreen(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title),
        centerTitle: true,
        // Close button on the left — in RTL, actions = left side
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      showBack: false,
      body: Column(
        children: [
          StepIndicator(currentStep: _currentStep, totalSteps: 3),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: switch (_currentStep) {
                0 => WizardStepBasics(
                  key: const ValueKey(0),
                  nameCtrl: _nameCtrl,
                  selectedCategoryId: _selectedCategoryId,
                  categories: widget.categories,
                  config: _cfg,
                  onCategoryChanged: (id) =>
                      setState(() => _selectedCategoryId = id),
                ),
                1 => WizardStepDetails(
                  key: const ValueKey(1),
                  config: _cfg,
                  descCtrl: _descCtrl,
                  priceCtrl: _priceCtrl,
                  discountCtrl: _discountCtrl,
                  propertyControllers: _propertyControllers,
                  chipSelections: _chipSelections,
                  onChipChanged: (propId, chips) =>
                      setState(() => _chipSelections[propId] = chips),
                ),
                _ => WizardStepAvailability(
                  key: const ValueKey(2),
                  config: _cfg,
                  status: _status,
                  stockCtrl: _stockCtrl,
                  onStatusChanged: (s) => setState(() => _status = s),
                  assignedTeamIds: _assignedTeamIds,
                  onTeamAssignTap: _openTeamPicker,
                ),
              },
            ),
          ),
          WizardBottomNav(
            currentStep: _currentStep,
            canGoNext: _canGoNext,
            saving: _saving,
            onBack: _back,
            onNext: _next,
          ),
        ],
      ),
    );
  }
}
