import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/branch.dart';
import 'package:honak/features/business/page_settings/presentation/providers/branch_provider.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/shared/widgets/app_direction.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/button.dart';

final locationPickerBranchesProvider = Provider<AsyncValue<List<Branch>>>(
  (ref) => ref.watch(branchProvider),
);

class LocationPickerSheet extends ConsumerStatefulWidget {
  final void Function(LocationCardData data) onSend;

  const LocationPickerSheet({super.key, required this.onSend});

  @override
  ConsumerState<LocationPickerSheet> createState() =>
      _LocationPickerSheetState();
}

enum _LocationMode { branches, onTheWay, manual }

class _LocationPickerSheetState extends ConsumerState<LocationPickerSheet> {
  _LocationMode _mode = _LocationMode.branches;
  String? _selectedBranchId;

  final _manualAddressController = TextEditingController();
  final _manualMapUrlController = TextEditingController();

  @override
  void dispose() {
    _manualAddressController.dispose();
    _manualMapUrlController.dispose();
    super.dispose();
  }

  bool _isValid(List<Branch> activeBranches) {
    return switch (_mode) {
      _LocationMode.branches =>
        activeBranches.isNotEmpty && _selectedBranchId != null,
      _LocationMode.onTheWay => true,
      _LocationMode.manual =>
        _manualAddressController.text.trim().isNotEmpty ||
            _manualMapUrlController.text.trim().isNotEmpty,
    };
  }

  Branch? _selectedBranch(List<Branch> branches) {
    if (branches.isEmpty) return null;
    final selected = branches
        .where((b) => b.id == _selectedBranchId)
        .firstOrNull;
    return selected ?? branches.first;
  }

  void _send(List<Branch> activeBranches) {
    final selectedBranch = _selectedBranch(activeBranches);
    final data = switch (_mode) {
      _LocationMode.branches when selectedBranch != null => _buildBranchData(
        selectedBranch,
      ),
      _LocationMode.onTheWay => const LocationCardData(
        title: 'أنا في الطريق — هذا موقعي',
        address: 'الموقع الحالي',
        mode: 'live',
      ),
      _ => LocationCardData(
        title: _manualAddressController.text.trim().isNotEmpty
            ? _manualAddressController.text.trim()
            : 'موقع عبر الرابط',
        address: _manualAddressController.text.trim().isNotEmpty
            ? _manualAddressController.text.trim()
            : 'موقع عبر الرابط',
        mapUrl: _manualMapUrlController.text.trim().isEmpty
            ? null
            : _manualMapUrlController.text.trim(),
        mode: 'manual',
      ),
    };

    widget.onSend(data);
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  LocationCardData _buildBranchData(Branch branch) {
    final title = branch.neighborhood == null || branch.neighborhood!.isEmpty
        ? branch.name
        : '${branch.name} - ${branch.neighborhood}';
    final mapUrl = branch.latitude != null && branch.longitude != null
        ? 'https://maps.google.com/?q=${branch.latitude},${branch.longitude}'
        : null;
    return LocationCardData(
      title: title,
      address: branch.address ?? '',
      phone: branch.phone,
      mapUrl: mapUrl,
      mode: 'branch',
      branchId: branch.id,
      latitude: branch.latitude,
      longitude: branch.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    final branchesAsync = ref.watch(locationPickerBranchesProvider);
    final activeBranches =
        branchesAsync.valueOrNull?.where((b) => b.active).toList() ??
        const <Branch>[];

    if (_selectedBranchId == null && activeBranches.isNotEmpty) {
      _selectedBranchId = activeBranches
          .firstWhere((b) => b.isMain, orElse: () => activeBranches.first)
          .id;
    }

    return AppSheetScaffold(
      title: 'أرسل الموقع',
      variant: AppSheetVariant.compact,
      headerCompact: true,
      showBodyDivider: false,
      showFooterDivider: false,
      bodyPadding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      footerPadding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ModeTabs(
            mode: _mode,
            onChanged: (mode) {
              setState(() => _mode = mode);
            },
          ),
          const SizedBox(height: AppSpacing.md),
          switch (_mode) {
            _LocationMode.branches => _BranchesPane(
              asyncBranches: branchesAsync,
              selectedBranchId: _selectedBranchId,
              onSelect: (id) {
                setState(() => _selectedBranchId = id);
              },
            ),
            _LocationMode.onTheWay => const _OnTheWayPane(),
            _LocationMode.manual => _ManualPane(
              addressController: _manualAddressController,
              mapUrlController: _manualMapUrlController,
              onChanged: () => setState(() {}),
            ),
          },
        ],
      ),
      footer: Button(
        onPressed: _isValid(activeBranches)
            ? () => _send(activeBranches)
            : null,
        label: 'إرسال الموقع',
        icon: const ButtonIcon(Icons.location_on_outlined, size: 16),
        expand: true,
      ),
    );
  }
}

class _ModeTabs extends StatelessWidget {
  final _LocationMode mode;
  final ValueChanged<_LocationMode> onChanged;

  const _ModeTabs({required this.mode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isRtl = AppDirection.isRtl(context);
    final tabs = <Widget>[
      Expanded(
        child: _ModeTab(
          label: 'الفروع',
          selected: mode == _LocationMode.branches,
          onTap: () => onChanged(_LocationMode.branches),
        ),
      ),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        child: _ModeTab(
          label: 'أنا بالطريق',
          selected: mode == _LocationMode.onTheWay,
          onTap: () => onChanged(_LocationMode.onTheWay),
        ),
      ),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        child: _ModeTab(
          label: 'عنوان يدوي',
          selected: mode == _LocationMode.manual,
          onTap: () => onChanged(_LocationMode.manual),
        ),
      ),
    ];
    final orderedTabs = isRtl ? tabs : tabs.reversed.toList();

    return Row(children: orderedTabs);
  }
}

class _ModeTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ModeTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.primary
          : context.colorScheme.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected
                  ? AppColors.primary
                  : context.colorScheme.outlineVariant,
            ),
          ),
          child: Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: selected ? Colors.white : context.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _BranchesPane extends StatelessWidget {
  final AsyncValue<List<Branch>> asyncBranches;
  final String? selectedBranchId;
  final ValueChanged<String> onSelect;

  const _BranchesPane({
    required this.asyncBranches,
    required this.selectedBranchId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return asyncBranches.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => Text(
        'تعذر تحميل الفروع',
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.error,
        ),
      ),
      data: (branches) {
        final active = branches.where((b) => b.active).toList();
        if (active.isEmpty) {
          return Text(
            'لا توجد فروع نشطة',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          );
        }
        return Column(
          children: active
              .map(
                (branch) => Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: AppSpacing.sm,
                  ),
                  child: _BranchTile(
                    branch: branch,
                    selected: branch.id == selectedBranchId,
                    onTap: () => onSelect(branch.id),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _BranchTile extends StatelessWidget {
  final Branch branch;
  final bool selected;
  final VoidCallback onTap;

  const _BranchTile({
    required this.branch,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final subtitle = [
      branch.neighborhood,
      branch.city,
    ].whereType<String>().where((v) => v.isNotEmpty).join(' - ');

    return Material(
      color: selected
          ? AppColors.primary.withValues(alpha: 0.08)
          : context.colorScheme.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsetsDirectional.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : context.colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 22,
                height: 22,
                margin: const EdgeInsetsDirectional.only(
                  end: AppSpacing.sm,
                  top: 2,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected
                        ? AppColors.primary
                        : context.colorScheme.outline,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      branch.name,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (branch.address != null &&
                        branch.address!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        branch.address!,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (branch.phone != null && branch.phone!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        branch.phone!,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnTheWayPane extends StatelessWidget {
  const _OnTheWayPane();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.near_me_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'أنا في الطريق',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'سيتم إرسال تحديث أنك في الطريق',
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ManualPane extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController mapUrlController;
  final VoidCallback onChanged;

  const _ManualPane({
    required this.addressController,
    required this.mapUrlController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Input(
          controller: addressController,
          hint: 'مثال: عمان، شارع ...',
          maxLines: 2,
          onChanged: (_) => onChanged(),
        ),
        const SizedBox(height: AppSpacing.sm),
        _Input(
          controller: mapUrlController,
          hint: 'رابط خرائط جوجل (اختياري)',
          onChanged: (_) => onChanged(),
        ),
      ],
    );
  }
}

class _Input extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  const _Input({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: context.colorScheme.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: context.colorScheme.outlineVariant),
        ),
      ),
    );
  }
}
