import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_image.dart';

/// Step 1: Team member selection list.
class TeamStepContent extends StatelessWidget {
  final List<Map<String, dynamic>> members;
  final String? selectedMemberId;
  final void Function(String? id, String? name) onSelected;

  const TeamStepContent({
    super.key,
    required this.members,
    required this.selectedMemberId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      children: [
        // "Any available" option
        _TeamMemberOption(
          // \u0623\u064a \u0634\u062e\u0635 \u0645\u062a\u0627\u062d = "Any available person"
          name: '\u0623\u064a \u0634\u062e\u0635 \u0645\u062a\u0627\u062d',
          role: null,
          avatarUrl: null,
          isSelected: selectedMemberId == null,
          onTap: () => onSelected(null, null),
          isAnyOption: true,
        ),
        const SizedBox(height: AppSpacing.sm),
        ...members
            .where((m) => m['active'] != false)
            .map((m) {
          final id = m['id'] as String? ?? '';
          final name = m['name'] as String? ?? '';
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _TeamMemberOption(
              name: name,
              role: m['role'] as String?,
              avatarUrl: m['avatar_url'] as String?,
              isSelected: selectedMemberId == id,
              onTap: () => onSelected(id, name),
            ),
          );
        }),
      ],
    );
  }
}

class _TeamMemberOption extends StatelessWidget {
  final String name;
  final String? role;
  final String? avatarUrl;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isAnyOption;

  const _TeamMemberOption({
    required this.name,
    this.role,
    this.avatarUrl,
    required this.isSelected,
    required this.onTap,
    this.isAnyOption = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? context.colorScheme.primaryContainer
          : context.colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              isAnyOption
                  ? CircleAvatar(
                      radius: 22,
                      backgroundColor:
                          context.colorScheme.surfaceContainerHighest,
                      child: Icon(Icons.groups,
                          color: context.colorScheme.onSurfaceVariant),
                    )
                  : AppImage.avatar(
                      url: avatarUrl,
                      name: name,
                      radius: 22,
                    ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (role != null && role!.isNotEmpty)
                      Text(
                        role!,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle,
                    color: context.colorScheme.primary, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
