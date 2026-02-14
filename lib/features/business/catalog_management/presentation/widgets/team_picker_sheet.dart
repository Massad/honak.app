import 'package:flutter/material.dart';

import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/team_member.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Shows a bottom sheet to pick team members for a service item.
/// Returns the selected member IDs, or null if dismissed.
Future<List<String>?> showTeamPickerSheet(
  BuildContext context, {
  required List<TeamMember> members,
  required List<String> selectedIds,
}) {
  return showAppSheet<List<String>>(
    context,
    maxHeightFraction: 0.7,
    builder: (_) => _TeamPickerContent(
      members: members,
      initialSelected: selectedIds,
    ),
  );
}

class _TeamPickerContent extends StatefulWidget {
  final List<TeamMember> members;
  final List<String> initialSelected;

  const _TeamPickerContent({
    required this.members,
    required this.initialSelected,
  });

  @override
  State<_TeamPickerContent> createState() => _TeamPickerContentState();
}

class _TeamPickerContentState extends State<_TeamPickerContent> {
  late final Set<String> _selected;

  /// Only show non-owner active members
  List<TeamMember> get _pickable =>
      widget.members.where((m) => !m.isOwner).toList();

  @override
  void initState() {
    super.initState();
    _selected = Set.from(widget.initialSelected);
  }

  void _toggleMember(String id) {
    setState(() {
      if (_selected.contains(id)) {
        _selected.remove(id);
      } else {
        _selected.add(id);
      }
    });
  }

  void _toggleAll() {
    setState(() {
      if (_selected.length == _pickable.length) {
        _selected.clear();
      } else {
        _selected.addAll(_pickable.map((m) => m.id));
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
    final allSelected = _selected.length == _pickable.length;

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
              color: Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),

        // Header
        Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _toggleAll,
                    child: Text(
                      allSelected ? 'إلغاء الكل' : 'تحديد الكل',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'المختصين المعينين (${_selected.length}/${_pickable.length})',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Members list
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                children: [
                  for (final member in _pickable) ...[
                    _MemberPickerRow(
                      member: member,
                      isSelected: _selected.contains(member.id),
                      avatarColor: _avatarColor(member.name),
                      onTap: () => _toggleMember(member.id),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],

                  // Warning when none selected
                  if (_selected.isEmpty) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.warning.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'لم يتم تعيين أي مختص — العملاء لن يتمكنوا من اختيار مزود الخدمة',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.warning,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Icon(Icons.warning_amber_outlined,
                              size: 18, color: AppColors.warning),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Done button
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, _selected.toList()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'تم',
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

class _MemberPickerRow extends StatelessWidget {
  final TeamMember member;
  final bool isSelected;
  final Color avatarColor;
  final VoidCallback onTap;

  const _MemberPickerRow({
    required this.member,
    required this.isSelected,
    required this.avatarColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.04)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.3)
                : Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            // Checkbox
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              size: 20,
              color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.outline,
            ),
            const Spacer(),
            // Name + role
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  member.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                if (member.role != null)
                  Text(
                    member.role!,
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
            const SizedBox(width: AppSpacing.sm),
            // Avatar
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: avatarColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  member.name.isNotEmpty ? member.name[0] : '?',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: avatarColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
