import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/config/business_type_config.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/presentation/providers/team_provider.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/member_branches_tab.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/member_permissions_tab.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/member_schedule_tab.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/member_services_tab.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';

/// Detail screen for a single team member with config-driven tabs.
class MemberDetailScreen extends ConsumerStatefulWidget {
  final String memberId;
  final BusinessTypeConfig? config;
  final VoidCallback onClose;

  const MemberDetailScreen({
    super.key,
    required this.memberId,
    this.config,
    required this.onClose,
  });

  @override
  ConsumerState<MemberDetailScreen> createState() =>
      _MemberDetailScreenState();
}

class _MemberDetailScreenState extends ConsumerState<MemberDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<_TabEntry> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = _buildTabs();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<_TabEntry> _buildTabs() {
    final config = widget.config;
    final tabs = <_TabEntry>[
      _TabEntry(
        id: 'permissions',
        label: 'الصلاحيات',
        builder: () => MemberPermissionsTab(
          memberId: widget.memberId,
          config: config,
        ),
      ),
    ];

    if (config?.itemManagement?.providerAssignment == true) {
      tabs.add(_TabEntry(
        id: 'services',
        label: 'الخدمات',
        builder: () => MemberServicesTab(memberId: widget.memberId),
      ));
    }

    if (config?.features.contains('multi_location') == true) {
      tabs.add(_TabEntry(
        id: 'branches',
        label: 'الفروع',
        builder: () => MemberBranchesTab(memberId: widget.memberId),
      ));
    }

    if (config?.perEmployeeAvailability == true) {
      tabs.add(_TabEntry(
        id: 'schedule',
        label: 'الجدول',
        builder: () => MemberScheduleTab(memberId: widget.memberId),
      ));
    }

    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    final members = ref.watch(teamProvider).valueOrNull ?? [];
    final member =
        members.where((m) => m.id == widget.memberId).firstOrNull;

    if (member == null) {
      // Member was removed while viewing — go back
      WidgetsBinding.instance.addPostFrameCallback((_) => widget.onClose());
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        // App bar
        SubScreenAppBar(
          title: member.name,
          onClose: widget.onClose,
        ),

        // Persistent header
        _MemberHeader(
          name: member.name,
          role: member.role,
          phone: member.phone,
          active: member.active,
          onActiveChanged: (active) {
            ref
                .read(teamProvider.notifier)
                .toggleMember(member.id, active);
          },
        ),

        // Tab bar (skip if only 1 tab)
        if (_tabs.length > 1)
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey.shade400,
              indicatorColor: AppColors.primary,
              labelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(fontSize: 12),
              tabs: [
                for (final tab in _tabs) Tab(text: tab.label),
              ],
            ),
          ),

        // Tab body
        Expanded(
          child: _tabs.length == 1
              ? _tabs.first.builder()
              : TabBarView(
                  controller: _tabController,
                  children: [
                    for (final tab in _tabs) tab.builder(),
                  ],
                ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Member header (persistent, above tabs)
// ═══════════════════════════════════════════════════════════════

class _MemberHeader extends StatelessWidget {
  final String name;
  final String? role;
  final String? phone;
  final bool active;
  final ValueChanged<bool> onActiveChanged;

  const _MemberHeader({
    required this.name,
    this.role,
    this.phone,
    required this.active,
    required this.onActiveChanged,
  });

  Color get _avatarColor {
    const colors = [
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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      child: Row(
        children: [
          // Active toggle
          SizedBox(
            width: 40,
            height: 28,
            child: FittedBox(
              child: Switch(
                value: active,
                onChanged: onActiveChanged,
                activeTrackColor: AppColors.primary.withValues(alpha: 0.4),
                activeThumbColor: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            active ? 'نشط' : 'معطّل',
            style: TextStyle(
              fontSize: 11,
              color: active ? AppColors.success : Colors.grey.shade400,
            ),
          ),

          const Spacer(),

          // Name + role + phone
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (role != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(AppRadius.xs),
                      ),
                      child: Text(
                        role!,
                        style: TextStyle(
                          fontSize: 9,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    name,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (phone != null)
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    phone!,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.sm),

          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _avatarColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Center(
              child: Text(
                name.isNotEmpty ? name[0] : '?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _avatarColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Tab entry helper
// ═══════════════════════════════════════════════════════════════

class _TabEntry {
  final String id;
  final String label;
  final Widget Function() builder;

  const _TabEntry({
    required this.id,
    required this.label,
    required this.builder,
  });
}
