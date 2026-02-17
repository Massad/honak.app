import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/directory_floor.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/sheets/tenant_invite_confirm.dart';
import 'package:honak/shared/widgets/app_direction.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Full-screen overlay for adding or editing a tenant.
///
/// Three modes:
/// 1. **Search mode** (default for add): Search existing Honak pages
/// 2. **Invite mode**: Selected page preview + floor/unit/category pickers
/// 3. **Create mode**: New unclaimed slot fields
class TenantFormOverlay extends StatefulWidget {
  final Tenant? tenant;
  final List<DirectoryFloor> floors;
  final List<String> categories;
  final List<Tenant> existingTenants;
  final VoidCallback onClose;
  final ValueChanged<Map<String, dynamic>> onSave;

  const TenantFormOverlay({
    super.key,
    this.tenant,
    required this.floors,
    required this.categories,
    required this.existingTenants,
    required this.onClose,
    required this.onSave,
  });

  @override
  State<TenantFormOverlay> createState() => _TenantFormOverlayState();
}

enum _FormMode { search, invite, create }

class _TenantFormOverlayState extends State<TenantFormOverlay> {
  late _FormMode _mode;
  String _searchQuery = '';
  String _name = '';
  String _selectedFloorId = '';
  String _unit = '';
  String _selectedCategory = '';
  String _phone = '';

  // Mock search results for Honak pages
  Map<String, dynamic>? _selectedPage;

  @override
  void initState() {
    super.initState();
    if (widget.tenant != null) {
      _mode = _FormMode.create;
      _name = widget.tenant!.name;
      _selectedFloorId = widget.tenant!.floorId;
      _unit = widget.tenant!.unit;
      _selectedCategory = widget.tenant!.category;
    } else {
      _mode = _FormMode.search;
    }
    if (widget.floors.isNotEmpty && _selectedFloorId.isEmpty) {
      _selectedFloorId = widget.floors.first.id;
    }
    if (widget.categories.isNotEmpty && _selectedCategory.isEmpty) {
      _selectedCategory = widget.categories.first;
    }
  }

  bool get _isDuplicate {
    if (_name.isEmpty) return false;
    return widget.existingTenants.any(
      (t) =>
          t.name == _name &&
          (widget.tenant == null || t.id != widget.tenant!.id),
    );
  }

  void _handleSave() {
    widget.onSave({
      'name': _name,
      'floor_id': _selectedFloorId,
      'unit': _unit,
      'category': _selectedCategory,
      if (_phone.isNotEmpty) 'phone': _phone,
      if (_selectedPage != null) 'page_id': _selectedPage!['id'],
    });
  }

  void _selectPage(Map<String, dynamic> page) {
    // Check if already in the mall
    final existingTenant = widget.existingTenants
        .where((t) => t.pageId == page['id'])
        .firstOrNull;
    if (existingTenant != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(context.l10n.dirTenantFormPageAlreadyLinked)),
      );
      return;
    }

    showAppSheet(
      context,
      builder: (_) => TenantInviteConfirm(
        page: page,
        onConfirm: () {
          Navigator.pop(context);
          setState(() {
            _selectedPage = page;
            _name = page['name'] as String;
            _mode = _FormMode.invite;
          });
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: widget.onClose,
        ),
        title: Text(
          widget.tenant != null
              ? context.l10n.dirTenantFormEditTitle
              : context.l10n.dirTenantFormAddTitle,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          if (_mode != _FormMode.search)
            btn.Button(
              onPressed: _name.isNotEmpty ? _handleSave : null,
              label: context.l10n.save,
              variant: btn.Variant.text,
              size: btn.ButtonSize.small,
            ),
        ],
      ),
      body: switch (_mode) {
        _FormMode.search => _buildSearchMode(),
        _FormMode.invite => _buildInviteMode(),
        _FormMode.create => _buildCreateMode(),
      },
    );
  }

  // ── Search mode ─────────────────────────────────────────────

  Widget _buildSearchMode() {
    final results = _mockSearchResults();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
          child: TextField(
            onChanged: (q) => setState(() => _searchQuery = q),
            autofocus: true,
            decoration: InputDecoration(
              hintText: context.l10n.dirTenantFormSearchHint,
              hintStyle: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant),
              prefixIcon:
                  Icon(Icons.search, size: 20, color: Theme.of(context).colorScheme.onSurfaceVariant),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerLowest,
              border: OutlineInputBorder(
                borderRadius: AppRadius.button,
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: results.isEmpty
              ? Center(
                  child: Text(
                    _searchQuery.isEmpty
                        ? context.l10n.dirTenantFormSearchEmpty
                        : context.l10n.dirNoResults,
                    style:
                        TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  itemCount: results.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (_, i) =>
                      _SearchResultCard(
                        page: results[i],
                        isLinked: widget.existingTenants
                            .any((t) => t.pageId == results[i]['id']),
                        onTap: () => _selectPage(results[i]),
                      ),
                ),
        ),
        // "Or create new" link
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: GestureDetector(
              onTap: () => setState(() => _mode = _FormMode.create),
              child: Text(
                context.l10n.dirTenantFormCreateNew,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _mockSearchResults() {
    if (_searchQuery.length < 2) return [];
    // Mock search results
    return [
      {
        'id': 'pg_search_1',
        'name': 'مطعم الريف',
        'handle': '@alreef',
        'category': 'مطاعم',
        'followers': 1250,
        'logo_url': null,
      },
      {
        'id': 'pg_search_2',
        'name': 'كوفي بريك',
        'handle': '@coffeebreak',
        'category': 'مقاهي',
        'followers': 870,
        'logo_url': null,
      },
      {
        'id': 'pg_search_3',
        'name': 'أزياء نور',
        'handle': '@noor_fashion',
        'category': 'ملابس',
        'followers': 2340,
        'logo_url': null,
      },
    ];
  }

  // ── Invite mode ─────────────────────────────────────────────

  Widget _buildInviteMode() {
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      children: [
        // Selected page preview
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.06),
            borderRadius: AppRadius.card,
            border:
                Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.1),
                ),
                child: const Icon(Icons.storefront, size: 20,
                    color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedPage?['name'] ?? '',
                      style: context.textTheme.titleSmall,
                    ),
                    Text(
                      _selectedPage?['handle'] ?? '',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              btn.Button(
                onPressed: () => setState(() {
                  _selectedPage = null;
                  _mode = _FormMode.search;
                }),
                label: context.l10n.dirTenantFormChange,
                variant: btn.Variant.text,
                size: btn.ButtonSize.small,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),

        // Floor picker
        _buildFloorPicker(),
        const SizedBox(height: AppSpacing.lg),

        // Unit input
        _buildField(
          label: context.l10n.dirTenantFormUnitLabel,
          value: _unit,
          onChanged: (v) => setState(() => _unit = v),
          hint: context.l10n.dirTenantFormUnitHint,
        ),
        const SizedBox(height: AppSpacing.lg),

        // Category picker
        _buildCategoryPicker(),
      ],
    );
  }

  // ── Create mode ─────────────────────────────────────────────

  Widget _buildCreateMode() {
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      children: [
        if (widget.tenant == null) ...[
          GestureDetector(
            onTap: () => setState(() => _mode = _FormMode.search),
            child: Row(
              children: [
                Icon(
                  AppDirection.backIcon(context),
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  context.l10n.dirTenantFormSearchForPage,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],

        // Name
        _buildField(
          label: context.l10n.dirTenantFormNameLabel,
          value: _name,
          onChanged: (v) => setState(() => _name = v),
          hint: context.l10n.dirTenantFormNameHint,
        ),
        if (_isDuplicate)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Text(
              context.l10n.dirTenantFormDuplicateName,
              style: TextStyle(fontSize: 11, color: AppColors.error),
            ),
          ),
        const SizedBox(height: AppSpacing.lg),

        // Floor picker
        _buildFloorPicker(),
        const SizedBox(height: AppSpacing.lg),

        // Unit
        _buildField(
          label: context.l10n.dirTenantFormUnitLabel,
          value: _unit,
          onChanged: (v) => setState(() => _unit = v),
          hint: context.l10n.dirTenantFormUnitHint,
        ),
        const SizedBox(height: AppSpacing.lg),

        // Category picker
        _buildCategoryPicker(),
        const SizedBox(height: AppSpacing.lg),

        // Phone (optional)
        _buildField(
          label: context.l10n.dirTenantFormPhoneLabel,
          value: _phone,
          onChanged: (v) => setState(() => _phone = v),
          hint: context.l10n.dirTenantFormPhoneHint,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  // ── Shared form elements ────────────────────────────────────

  Widget _buildField({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: TextEditingController(text: value)
            ..selection = TextSelection.collapsed(offset: value.length),
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            border: OutlineInputBorder(
              borderRadius: AppRadius.button,
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.button,
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFloorPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.l10n.dirTenantFormFloorLabel,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final floor in widget.floors)
              _PickerChip(
                label: floor.label ?? floor.name,
                isSelected: _selectedFloorId == floor.id,
                onTap: () => setState(() => _selectedFloorId = floor.id),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.l10n.dirTenantFormCategoryLabel,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final cat in widget.categories)
              _PickerChip(
                label: cat,
                isSelected: _selectedCategory == cat,
                onTap: () => setState(() => _selectedCategory = cat),
              ),
          ],
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Picker chip
// ═══════════════════════════════════════════════════════════════

class _PickerChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PickerChip({
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
              : Theme.of(context).colorScheme.surfaceContainerLow,
          borderRadius: AppRadius.pill,
          border: isSelected
              ? Border.all(color: AppColors.primary.withValues(alpha: 0.4))
              : null,
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

// ═══════════════════════════════════════════════════════════════
// Search result card
// ═══════════════════════════════════════════════════════════════

class _SearchResultCard extends StatelessWidget {
  final Map<String, dynamic> page;
  final bool isLinked;
  final VoidCallback onTap;

  const _SearchResultCard({
    required this.page,
    required this.isLinked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLinked ? null : onTap,
      borderRadius: AppRadius.card,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outlineVariant),
          borderRadius: AppRadius.card,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorScheme.surfaceContainerHighest,
              ),
              child: Icon(
                Icons.storefront,
                size: 20,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          page['name'] as String,
                          style: context.textTheme.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isLinked) ...[
                        const SizedBox(width: AppSpacing.xs),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF16A34A)
                                .withValues(alpha: 0.1),
                            borderRadius: AppRadius.pill,
                          ),
                          child: Text(
                            context.l10n.dirTenantFormInYourMall,
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF16A34A),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    '${page['handle']} · ${page['category']}',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    context.l10n
                        .dirTenantFormFollowers(page['followers'] as int),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (!isLinked)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: AppRadius.button,
                ),
                child: Text(
                  context.l10n.dirTenantFormInviteBtn,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
