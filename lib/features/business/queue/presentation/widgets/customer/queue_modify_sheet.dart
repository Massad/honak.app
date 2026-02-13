import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/queue/domain/entities/available_add_on.dart';
import 'package:honak/features/business/queue/domain/entities/customer_queue_entry.dart';
import 'package:honak/features/business/queue/domain/entities/service_package.dart';
import 'package:honak/shared/entities/money.dart';

/// Modification request sent from the customer.
class QueueModificationRequest {
  final String type; // 'change_package' | 'change_addons' | 'add_note'
  final String? newPackageId;
  final List<String>? newAddOnIds;
  final String? note;

  QueueModificationRequest({
    required this.type,
    this.newPackageId,
    this.newAddOnIds,
    this.note,
  });
}

/// Shows the queue modification bottom sheet.
Future<void> showQueueModifySheet({
  required BuildContext context,
  required CustomerQueueEntry entry,
  required List<ServicePackage> packages,
  List<AvailableAddOn>? availableAddOns,
  required bool isInProgress,
  required void Function(QueueModificationRequest) onSubmit,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _QueueModifySheet(
      entry: entry,
      packages: packages,
      availableAddOns: availableAddOns ?? [],
      isInProgress: isInProgress,
      onSubmit: onSubmit,
    ),
  );
}

class _QueueModifySheet extends StatefulWidget {
  final CustomerQueueEntry entry;
  final List<ServicePackage> packages;
  final List<AvailableAddOn> availableAddOns;
  final bool isInProgress;
  final void Function(QueueModificationRequest) onSubmit;

  const _QueueModifySheet({
    required this.entry,
    required this.packages,
    required this.availableAddOns,
    required this.isInProgress,
    required this.onSubmit,
  });

  @override
  State<_QueueModifySheet> createState() => _QueueModifySheetState();
}

class _QueueModifySheetState extends State<_QueueModifySheet> {
  String? _selectedType;
  String? _selectedPackageId;
  final Set<String> _selectedAddOnIds = {};
  final _noteController = TextEditingController();
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _selectedPackageId = widget.entry.packageId;
    // Pre-select current add-ons by matching names
    for (final addOn in widget.availableAddOns) {
      for (final current in widget.entry.addOns) {
        if (addOn.nameAr == current.name) {
          _selectedAddOnIds.add(addOn.id);
        }
      }
    }
    // If in progress, only notes are allowed
    if (widget.isInProgress) {
      _selectedType = 'add_note';
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: context.screenHeight * 0.85,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
      ),
      child: _submitted ? _buildSuccessState(context) : _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
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
              color: AppColors.divider,
              borderRadius: AppRadius.pill,
            ),
          ),
        ),
        // Header
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'طلب تعديل',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // Current selection summary
        _buildCurrentSummary(context),
        const Divider(height: 1),
        // Modification options
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.isInProgress) ...[
                  _buildModTypeSelection(context),
                  const SizedBox(height: AppSpacing.lg),
                ],
                if (_selectedType == 'change_package')
                  _buildPackageList(context),
                if (_selectedType == 'change_addons')
                  _buildAddOnList(context),
                if (_selectedType == 'add_note' || widget.isInProgress)
                  _buildNoteInput(context),
              ],
            ),
          ),
        ),
        // Submit button
        if (_selectedType != null)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _canSubmit ? _handleSubmit : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.button,
                    ),
                  ),
                  child: const Text('إرسال طلب التعديل'),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCurrentSummary(BuildContext context) {
    final price = Money(widget.entry.totalPriceCents);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: AppRadius.cardInner,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.local_car_wash,
              size: 20,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.entry.packageName,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (widget.entry.addOns.isNotEmpty)
                  Text(
                    widget.entry.addOns.map((a) => a.name).join('، '),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            price.toFormattedArabic(),
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModTypeSelection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ما الذي تريد تعديله؟',
          style: context.textTheme.labelSmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _ModTypeOption(
          icon: Icons.swap_horiz,
          label: 'تغيير الخدمة',
          selected: _selectedType == 'change_package',
          onTap: () => setState(() => _selectedType = 'change_package'),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (widget.availableAddOns.isNotEmpty) ...[
          _ModTypeOption(
            icon: Icons.add_circle_outline,
            label: 'تعديل الإضافات',
            selected: _selectedType == 'change_addons',
            onTap: () => setState(() => _selectedType = 'change_addons'),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        _ModTypeOption(
          icon: Icons.note_add_outlined,
          label: 'إضافة ملاحظة',
          selected: _selectedType == 'add_note',
          onTap: () => setState(() => _selectedType = 'add_note'),
        ),
      ],
    );
  }

  Widget _buildPackageList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اختر الخدمة الجديدة',
          style: context.textTheme.labelSmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ...widget.packages.map((pkg) {
          final isSelected = _selectedPackageId == pkg.id;
          final price = Money(pkg.price);
          return Padding(
            padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
            child: InkWell(
              onTap: () => setState(() => _selectedPackageId = pkg.id),
              borderRadius: AppRadius.cardInner,
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  borderRadius: AppRadius.cardInner,
                  border: Border.all(
                    color:
                        isSelected ? AppColors.primary : AppColors.divider,
                  ),
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.05)
                      : null,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pkg.nameAr,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '~${pkg.durationMin} دقيقة',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      price.toFormattedArabic(),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: AppSpacing.sm),
                      const Icon(
                        Icons.check_circle,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildAddOnList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الإضافات',
          style: context.textTheme.labelSmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ...widget.availableAddOns.map((addOn) {
          final isSelected = _selectedAddOnIds.contains(addOn.id);
          final price = Money(addOn.priceCents);
          return Padding(
            padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedAddOnIds.remove(addOn.id);
                  } else {
                    _selectedAddOnIds.add(addOn.id);
                  }
                });
              },
              borderRadius: AppRadius.cardInner,
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  borderRadius: AppRadius.cardInner,
                  border: Border.all(
                    color:
                        isSelected ? AppColors.primary : AppColors.divider,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      size: 20,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textHint,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        addOn.nameAr,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      '+${price.toFormattedArabic()}',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildNoteInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ملاحظة',
          style: context.textTheme.labelSmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _noteController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'اكتب ملاحظتك هنا...',
            hintStyle: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.textHint,
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
            contentPadding: const EdgeInsets.all(AppSpacing.md),
          ),
          onChanged: (_) => setState(() {}),
        ),
      ],
    );
  }

  bool get _canSubmit {
    if (_selectedType == null) return false;
    if (_selectedType == 'change_package') {
      return _selectedPackageId != null &&
          _selectedPackageId != widget.entry.packageId;
    }
    if (_selectedType == 'add_note') {
      return _noteController.text.trim().isNotEmpty;
    }
    return true; // change_addons is always submittable
  }

  void _handleSubmit() {
    final request = QueueModificationRequest(
      type: _selectedType!,
      newPackageId:
          _selectedType == 'change_package' ? _selectedPackageId : null,
      newAddOnIds: _selectedType == 'change_addons'
          ? _selectedAddOnIds.toList()
          : null,
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
    );
    widget.onSubmit(request);
    setState(() => _submitted = true);
  }

  Widget _buildSuccessState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.lg),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.check_circle,
              size: 32,
              color: AppColors.success,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'تم إرسال طلب التعديل',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'سيتم إشعارك عند مراجعة التعديل',
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.button,
                ),
              ),
              child: const Text('تم'),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Mod Type Option ───────────────────────────────────────────────────────

class _ModTypeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ModTypeOption({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.cardInner,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          borderRadius: AppRadius.cardInner,
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.divider,
          ),
          color: selected ? AppColors.primary.withValues(alpha: 0.05) : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: selected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: selected ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: selected ? FontWeight.w500 : null,
                ),
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle,
                size: 18,
                color: AppColors.primary,
              ),
          ],
        ),
      ),
    );
  }
}
