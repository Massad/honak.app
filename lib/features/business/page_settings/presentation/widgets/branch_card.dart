import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/branch.dart';
import 'package:honak/features/business/page_settings/presentation/providers/branch_provider.dart';

class BranchCard extends ConsumerStatefulWidget {
  final Branch branch;
  final bool initiallyExpanded;
  final List<Map<String, dynamic>> cities;

  const BranchCard({
    super.key,
    required this.branch,
    this.initiallyExpanded = false,
    this.cities = const [],
  });

  @override
  ConsumerState<BranchCard> createState() => _BranchCardState();
}

class _BranchCardState extends ConsumerState<BranchCard> {
  late bool _expanded;
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  String? _selectedCity;
  String? _selectedNeighborhood;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
    _nameController = TextEditingController(text: widget.branch.name);
    _addressController =
        TextEditingController(text: widget.branch.address ?? '');
    _phoneController =
        TextEditingController(text: widget.branch.phone ?? '');
    _selectedCity = widget.branch.city;
    _selectedNeighborhood = widget.branch.neighborhood;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  List<String> get _neighborhoodsForCity {
    if (_selectedCity == null) return [];
    final city = widget.cities.firstWhere(
      (c) => c['name'] == _selectedCity,
      orElse: () => <String, dynamic>{},
    );
    final neighborhoods = city['neighborhoods'];
    if (neighborhoods is List) {
      return neighborhoods.cast<String>();
    }
    return [];
  }

  void _saveChanges() {
    final updated = widget.branch.copyWith(
      name: _nameController.text.trim(),
      address: _addressController.text.trim().isNotEmpty
          ? _addressController.text.trim()
          : null,
      phone: _phoneController.text.trim().isNotEmpty
          ? _phoneController.text.trim()
          : null,
      city: _selectedCity,
      neighborhood: _selectedNeighborhood,
    );
    ref.read(branchProvider.notifier).updateBranch(updated);
  }

  void _toggleStatus(String status) {
    ref
        .read(branchProvider.notifier)
        .toggleBranchStatus(widget.branch.id, status);
  }

  void _deleteBranch() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف الفرع', textAlign: TextAlign.end),
        content: Text(
          'هل تريد حذف فرع "${widget.branch.name}"؟',
          textAlign: TextAlign.end,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(branchProvider.notifier).removeBranch(widget.branch.id);
              context.showSnackBar('تم حذف الفرع');
            },
            child: Text('حذف', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final branch = widget.branch;
    final statusColor = branch.active ? AppColors.success : AppColors.warning;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Collapsed header — always visible
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 20,
                      color: Colors.grey.shade400,
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          branch.name,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (branch.city != null ||
                            branch.neighborhood != null)
                          Text(
                            [branch.neighborhood, branch.city]
                                .where((s) => s != null)
                                .join('، '),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    // Status-colored pin
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.place,
                        size: 16,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Expanded editing section
          if (_expanded) ...[
            Divider(height: 1, color: Colors.grey.shade100),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Name
                  _buildField(
                    controller: _nameController,
                    label: 'اسم الفرع',
                    onChanged: (_) => _saveChanges(),
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // City dropdown
                  _buildDropdown(
                    label: 'المدينة',
                    value: _selectedCity,
                    items: widget.cities
                        .map((c) => c['name'] as String)
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedCity = val;
                        _selectedNeighborhood = null;
                      });
                      _saveChanges();
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Neighborhood dropdown (cascading)
                  _buildDropdown(
                    label: 'الحي',
                    value: _selectedNeighborhood,
                    items: _neighborhoodsForCity,
                    onChanged: (val) {
                      setState(() => _selectedNeighborhood = val);
                      _saveChanges();
                    },
                    enabled: _selectedCity != null,
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Address
                  _buildField(
                    controller: _addressController,
                    label: 'العنوان التفصيلي',
                    onChanged: (_) => _saveChanges(),
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Phone (LTR)
                  _buildField(
                    controller: _phoneController,
                    label: 'رقم الهاتف',
                    keyboardType: TextInputType.phone,
                    textDirection: TextDirection.ltr,
                    onChanged: (_) => _saveChanges(),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Status toggle
                  Text(
                    'حالة الفرع',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Expanded(
                        child: _StatusToggle(
                          label: 'مغلق مؤقتاً',
                          isSelected: !branch.active,
                          color: AppColors.warning,
                          onTap: () => _toggleStatus('temp_closed'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _StatusToggle(
                          label: 'متاح',
                          isSelected: branch.active,
                          color: AppColors.success,
                          onTap: () => _toggleStatus('active'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Delete button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _deleteBranch,
                      icon: Icon(Icons.delete_outline,
                          size: 16, color: AppColors.error),
                      label: Text(
                        'حذف الفرع',
                        style: TextStyle(color: AppColors.error),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: AppColors.error.withValues(alpha: 0.3)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.sm),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    TextDirection? textDirection,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          textAlign: textDirection == TextDirection.ltr
              ? TextAlign.left
              : TextAlign.end,
          textDirection: textDirection,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
            color: enabled ? Colors.white : Colors.grey.shade50,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(value) ? value : null,
              isExpanded: true,
              alignment: AlignmentDirectional.centerEnd,
              hint: Text(
                'اختر',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade400,
                ),
              ),
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(item, style: const TextStyle(fontSize: 13)),
                );
              }).toList(),
              onChanged: enabled ? onChanged : null,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusToggle extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _StatusToggle({
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? color.withValues(alpha: 0.1) : Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color:
                  isSelected ? color.withValues(alpha: 0.3) : Colors.grey.shade200,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? color : Colors.grey.shade500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
