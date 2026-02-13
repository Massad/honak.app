import 'package:flutter/material.dart';

import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/team_member.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Shows a bottom sheet for bulk team assignment to multiple items.
Future<void> showTeamAssignSheet(
  BuildContext context, {
  required int selectedCount,
  required String itemLabelAr,
  required List<TeamMember> members,
  required ValueChanged<List<String>> onApply,
}) {
  return showAppSheet(
    context,
    maxHeightFraction: 0.65,
    builder: (_) => _TeamAssignContent(
      selectedCount: selectedCount,
      itemLabelAr: itemLabelAr,
      members: members,
      onApply: onApply,
    ),
  );
}

class _TeamAssignContent extends StatefulWidget {
  final int selectedCount;
  final String itemLabelAr;
  final List<TeamMember> members;
  final ValueChanged<List<String>> onApply;

  const _TeamAssignContent({
    required this.selectedCount,
    required this.itemLabelAr,
    required this.members,
    required this.onApply,
  });

  @override
  State<_TeamAssignContent> createState() => _TeamAssignContentState();
}

class _TeamAssignContentState extends State<_TeamAssignContent> {
  final Set<String> _selected = {};

  List<TeamMember> get _pickable =>
      widget.members.where((m) => !m.isOwner).toList();

  void _toggle(String id) {
    setState(() {
      if (_selected.contains(id)) {
        _selected.remove(id);
      } else {
        _selected.add(id);
      }
    });
  }

  Color _avatarColor(String name) {
    final colors = [
      AppColors.primary,
      Colors.teal,
      Colors.orange,
      Colors.purple,
      Colors.pink,
    ];
    return colors[name.hashCode.abs() % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drag handle
        Center(
          child: Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(
                top: AppSpacing.sm, bottom: AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),

        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              'تعيين فريق لـ ${widget.selectedCount} ${widget.itemLabelAr}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Members list
        Flexible(
          child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                children: _pickable.map((member) {
                  final isSelected = _selected.contains(member.id);
                  final color = _avatarColor(member.name);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: GestureDetector(
                      onTap: () => _toggle(member.id),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withValues(alpha: 0.04)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.3)
                                : Colors.grey.shade200,
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
                                  : Colors.grey.shade300,
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  member.name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (member.role != null)
                                  Text(
                                    member.role!,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  member.name.isNotEmpty
                                      ? member.name[0]
                                      : '?',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: color,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Apply button
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApply(_selected.toList());
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'تطبيق',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
      ],
    );
  }
}
