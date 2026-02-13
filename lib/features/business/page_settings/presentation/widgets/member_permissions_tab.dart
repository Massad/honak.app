import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/config/business_type_config.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/presentation/providers/team_provider.dart';

/// Permission toggles tab inside [MemberDetailScreen].
class MemberPermissionsTab extends ConsumerWidget {
  final String memberId;
  final BusinessTypeConfig? config;

  const MemberPermissionsTab({
    super.key,
    required this.memberId,
    this.config,
  });

  static const _permIcon = <String, IconData>{
    'manage_availability': Icons.calendar_today_outlined,
    'manage_catalog': Icons.inventory_2_outlined,
    'manage_orders': Icons.shopping_bag_outlined,
    'respond_chat': Icons.chat_bubble_outline,
    'post_updates': Icons.edit_outlined,
    'view_insights': Icons.bar_chart_outlined,
    'manage_settings': Icons.settings_outlined,
    'manage_team': Icons.people_outline,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(teamProvider).valueOrNull ?? [];
    final member = members.where((m) => m.id == memberId).firstOrNull;
    if (member == null) return const SizedBox.shrink();

    final perms = config?.availablePermissions ?? [];
    final isOwner = member.isOwner;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        if (isOwner)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Text(
              'المشرف الرئيسي يملك جميع الصلاحيات',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
              textAlign: TextAlign.end,
            ),
          ),
        for (final perm in perms)
          _PermissionRow(
            perm: perm,
            enabled: isOwner || member.permissions.contains(perm.id),
            disabled: isOwner,
            onToggle: () {
              final current = List<String>.from(member.permissions);
              if (current.contains(perm.id)) {
                current.remove(perm.id);
              } else {
                current.add(perm.id);
              }
              ref
                  .read(teamProvider.notifier)
                  .updatePermissions(memberId, current);
            },
          ),
      ],
    );
  }
}

class _PermissionRow extends StatelessWidget {
  final PermissionMeta perm;
  final bool enabled;
  final bool disabled;
  final VoidCallback onToggle;

  const _PermissionRow({
    required this.perm,
    required this.enabled,
    this.disabled = false,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            height: 28,
            child: FittedBox(
              child: Switch(
                value: enabled,
                onChanged: disabled ? null : (_) => onToggle(),
                activeTrackColor: AppColors.primary.withValues(alpha: 0.4),
                activeThumbColor: AppColors.primary,
              ),
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  perm.labelAr,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color:
                        enabled ? Colors.grey.shade800 : Colors.grey.shade400,
                  ),
                ),
                Text(
                  perm.descAr,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Icon(
            MemberPermissionsTab._permIcon[perm.id] ??
                Icons.check_circle_outline,
            size: 20,
            color: enabled
                ? AppColors.primary.withValues(alpha: 0.6)
                : Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
