import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/dropoff/domain/entities/dropoff_info_template.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Shows a bottom sheet for requesting info/photos from a customer.
///
/// Config-driven from [DropoffInfoTemplate] list. Each template group
/// is shown as an expandable section with checkable items.
/// Returns a list of selected item IDs via [onSend].
Future<List<String>?> showDropoffInfoRequestSheet(
  BuildContext context, {
  required List<DropoffInfoTemplate> templates,
}) {
  return showAppSheet<List<String>>(
    context,
    builder: (_) => _InfoRequestSheet(templates: templates),
  );
}

class _InfoRequestSheet extends StatefulWidget {
  final List<DropoffInfoTemplate> templates;

  const _InfoRequestSheet({required this.templates});

  @override
  State<_InfoRequestSheet> createState() => _InfoRequestSheetState();
}

class _InfoRequestSheetState extends State<_InfoRequestSheet> {
  final Set<String> _selectedIds = {};
  final Set<String> _expandedGroups = {};
  final _notesCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Expand all groups by default
    for (final t in widget.templates) {
      _expandedGroups.add(t.id);
    }
  }

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        _buildHeader(context),

        // Template groups
        Flexible(
          child: ListView(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.lg,
            ),
            children: [
              ...widget.templates.map(_buildGroup),
              const SizedBox(height: AppSpacing.lg),

              // Notes field
              Text(
                'ملاحظات إضافية (اختياري)',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
              const SizedBox(height: AppSpacing.xs),
              TextField(
                controller: _notesCtrl,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'أي توضيح إضافي...',
                  hintStyle:
                      TextStyle(fontSize: 13, color: Colors.grey.shade300),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  contentPadding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.md,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: AppRadius.cardInner,
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: AppRadius.cardInner,
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: AppRadius.cardInner,
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Send button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _selectedIds.isNotEmpty
                      ? () => Navigator.pop(context, _selectedIds.toList())
                      : null,
                  icon: const Icon(Icons.send_rounded, size: 16),
                  label: Text(
                    _selectedIds.isEmpty
                        ? 'إرسال'
                        : 'إرسال (${_selectedIds.length})',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    disabledForegroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.cardInner,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return AppSheetHeader(
      title: 'طلب معلومات',
      onClose: () => Navigator.pop(context),
    );
  }

  Widget _buildGroup(DropoffInfoTemplate template) {
    final isExpanded = _expandedGroups.contains(template.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group header (expandable)
        GestureDetector(
          onTap: () => setState(() {
            if (isExpanded) {
              _expandedGroups.remove(template.id);
            } else {
              _expandedGroups.add(template.id);
            }
          }),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  template.labelAr,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Items
        if (isExpanded)
          ...template.items.map((item) {
            final selected = _selectedIds.contains(item.id);
            final typeIcon = switch (item.type) {
              'photo' => Icons.camera_alt_outlined,
              'video' => Icons.videocam_outlined,
              _ => Icons.text_fields_rounded,
            };

            return Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: AppSpacing.sm,
                start: AppSpacing.xxl,
              ),
              child: GestureDetector(
                onTap: () => setState(() {
                  selected
                      ? _selectedIds.remove(item.id)
                      : _selectedIds.add(item.id);
                }),
                child: Container(
                  padding: const EdgeInsetsDirectional.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : Colors.grey.shade200,
                    ),
                    color: selected ? const Color(0xFFEFF6FF) : null,
                    borderRadius: AppRadius.cardInner,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.primary
                              : Colors.transparent,
                          border: Border.all(
                            color: selected
                                ? AppColors.primary
                                : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: selected
                            ? const Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Icon(
                        typeIcon,
                        size: 14,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          item.labelAr,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

        if (isExpanded) const SizedBox(height: AppSpacing.sm),
      ],
    );
  }
}
