import 'package:flutter/material.dart';
import 'package:honak/config/business_type_config.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

class MassActionBar extends StatelessWidget {
  final int selectedCount;
  final ItemManagementConfig? config;
  final bool hasMultipleBranches;
  final bool hasTeam;
  final VoidCallback onExit;
  final ValueChanged<String> onStatusChange;
  final VoidCallback onDelete;
  final VoidCallback? onOpenDiscount;
  final VoidCallback? onOpenBranch;
  final VoidCallback? onOpenCategory;
  final VoidCallback? onOpenTeam;

  const MassActionBar({
    super.key,
    required this.selectedCount,
    this.config,
    this.hasMultipleBranches = false,
    this.hasTeam = false,
    required this.onExit,
    required this.onStatusChange,
    required this.onDelete,
    this.onOpenDiscount,
    this.onOpenBranch,
    this.onOpenCategory,
    this.onOpenTeam,
  });

  @override
  Widget build(BuildContext context) {
    final actions = <_ActionItem>[
      if (config?.canDiscount == true)
        _ActionItem(
          label: 'خصم',
          icon: Icons.local_offer_outlined,
          bgColor: Colors.orange.shade50,
          iconColor: Colors.orange.shade700,
          onTap: onOpenDiscount,
        ),
      _ActionItem(
        label: 'غير متوفر',
        icon: Icons.cancel_outlined,
        bgColor: Colors.red.shade50,
        iconColor: AppColors.error,
        onTap: () => onStatusChange('out_of_stock'),
      ),
      _ActionItem(
        label: 'إخفاء',
        icon: Icons.visibility_off_outlined,
        bgColor: Colors.grey.shade100,
        iconColor: Colors.grey.shade600,
        onTap: () => onStatusChange('hidden'),
      ),
      _ActionItem(
        label: 'حذف',
        icon: Icons.delete_outline,
        bgColor: Colors.red.shade50,
        iconColor: AppColors.error,
        onTap: onDelete,
      ),
      if (hasMultipleBranches)
        _ActionItem(
          label: 'تعيين الفروع',
          icon: Icons.store_outlined,
          bgColor: Colors.blue.shade50,
          iconColor: AppColors.primary,
          onTap: onOpenBranch,
        ),
      if (config?.hasCategory == true)
        _ActionItem(
          label: 'تغيير الفئة',
          icon: Icons.category_outlined,
          bgColor: Colors.blue.shade50,
          iconColor: AppColors.primary,
          onTap: onOpenCategory,
        ),
      if (hasTeam)
        _ActionItem(
          label: 'تعيين فريق',
          icon: Icons.people_outline,
          bgColor: Colors.blue.shade50,
          iconColor: AppColors.primary,
          onTap: onOpenTeam,
        ),
    ];

    return AppSheetOverlay(
      onDismiss: onExit,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppSpacing.lg),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$selectedCount',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Expanded(
                  child: Text(
                    'عنصر محدد',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onExit,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            // Action grid
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 0.9,
              children: actions.map((a) => _buildAction(a)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(_ActionItem action) {
    return GestureDetector(
      onTap: action.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: action.bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(action.icon, size: 20, color: action.iconColor),
            const SizedBox(height: AppSpacing.xs),
            Text(
              action.label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: action.iconColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionItem {
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback? onTap;

  const _ActionItem({
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    this.onTap,
  });
}

// ===============================================================
// Mass Discount Sheet
// ===============================================================

Future<void> showMassDiscountSheet(
  BuildContext context, {
  required int selectedCount,
  required String itemLabelAr,
  required ValueChanged<int> onApply,
}) {
  return showAppSheet(
    context,
    builder: (_) => _MassDiscountContent(
      selectedCount: selectedCount,
      itemLabelAr: itemLabelAr,
      onApply: onApply,
    ),
  );
}

class _MassDiscountContent extends StatefulWidget {
  final int selectedCount;
  final String itemLabelAr;
  final ValueChanged<int> onApply;

  const _MassDiscountContent({
    required this.selectedCount,
    required this.itemLabelAr,
    required this.onApply,
  });

  @override
  State<_MassDiscountContent> createState() => _MassDiscountContentState();
}

class _MassDiscountContentState extends State<_MassDiscountContent> {
  final _controller = TextEditingController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_validate);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validate() {
    final val = int.tryParse(_controller.text);
    setState(() {
      _isValid = val != null && val >= 1 && val <= 99;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                Text(
                  'تطبيق خصم على ${widget.selectedCount} ${widget.itemLabelAr}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'نسبة الخصم',
                    suffixText: '٪',
                    hintText: '10',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isValid
                        ? () {
                            widget.onApply(int.parse(_controller.text));
                            Navigator.pop(context);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade700,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade200,
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.md),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'تطبيق الخصم',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
