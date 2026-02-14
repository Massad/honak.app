import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/config/business_type_config.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/team_member.dart';
import 'package:honak/features/business/page_settings/presentation/providers/team_provider.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/add_member_sheet.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/member_detail_screen.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/team_member_card.dart';

export 'team_member_card.dart';

class TeamManagement extends ConsumerStatefulWidget {
  final BusinessTypeConfig? config;
  final VoidCallback onClose;

  const TeamManagement({
    super.key,
    this.config,
    required this.onClose,
  });

  @override
  ConsumerState<TeamManagement> createState() => _TeamManagementState();
}

class _TeamManagementState extends ConsumerState<TeamManagement> {
  String? _selectedMemberId;

  @override
  Widget build(BuildContext context) {
    // Detail view
    if (_selectedMemberId != null) {
      return MemberDetailScreen(
        memberId: _selectedMemberId!,
        config: widget.config,
        onClose: () => setState(() => _selectedMemberId = null),
      );
    }

    // List view
    final teamAsync = ref.watch(teamProvider);

    return Column(
      children: [
        SubScreenAppBar(title: 'فريق العمل', onClose: widget.onClose),
        Expanded(
          child: teamAsync.when(
            data: (members) => _TeamBody(
              members: members,
              config: widget.config,
              onMemberTap: (id) => setState(() => _selectedMemberId = id),
            ),
            loading: () => const TeamSkeleton(),
            error: (_, __) => Center(
              child: Text(
                'تعذر تحميل الفريق',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Team body — info banner, owner card, member cards, add button
// ═══════════════════════════════════════════════════════════════

class _TeamBody extends ConsumerWidget {
  final List<TeamMember> members;
  final BusinessTypeConfig? config;
  final ValueChanged<String> onMemberTap;

  const _TeamBody({
    required this.members,
    this.config,
    required this.onMemberTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final owner = members.where((m) => m.isOwner).firstOrNull;
    final nonOwners = members.where((m) => !m.isOwner).toList();

    // Empty state
    if (members.isEmpty) {
      return _EmptyTeamState(config: config);
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // Info banner
        _InfoBanner(),
        const SizedBox(height: AppSpacing.md),

        // Owner card
        if (owner != null) ...[
          _OwnerCard(owner: owner),
          const SizedBox(height: AppSpacing.sm),
        ],

        // Non-owner member cards (tappable)
        for (final member in nonOwners) ...[
          TeamMemberCard(
            member: member,
            config: config,
            onTap: () => onMemberTap(member.id),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],

        // Add member button
        const SizedBox(height: AppSpacing.md),
        _AddMemberButton(
          onTap: () => showAddMemberSheet(
            context,
            config: config,
            onAdd: (member) {
              ref.read(teamProvider.notifier).addMember(member);
              context.showSnackBar('تم إضافة ${member.name}');
            },
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Info banner
// ═══════════════════════════════════════════════════════════════

class _InfoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.info.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              'عند إضافة عضو برقم هاتفه، سيظهر لديه إشعار بالانضمام. يستطيع الدخول بحسابه العادي وسيرى الصلاحيات الممنوحة له فقط.',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.info.withValues(alpha: 0.8),
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Icon(
            Icons.info_outline,
            size: 18,
            color: AppColors.info.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Owner card — special non-collapsible card
// ═══════════════════════════════════════════════════════════════

class _OwnerCard extends StatelessWidget {
  final TeamMember owner;

  const _OwnerCard({required this.owner});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.04),
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          // Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
                child: const Text(
                  'مشرف رئيسي',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'جميع الصلاحيات',
                style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          const Spacer(),
          // Name + phone
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                owner.name,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (owner.phone != null)
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    owner.phone!,
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.sm),
          // Shield icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: const Icon(
              Icons.shield_outlined,
              size: 18,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Add member button (dashed border)
// ═══════════════════════════════════════════════════════════════

class _AddMemberButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddMemberButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        decoration: BoxDecoration(
          borderRadius: AppRadius.card,
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'إضافة عضو',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(Icons.person_add_outlined, size: 18, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Empty team state
// ═══════════════════════════════════════════════════════════════

class _EmptyTeamState extends StatelessWidget {
  final BusinessTypeConfig? config;

  const _EmptyTeamState({this.config});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.xxxl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.people_outline,
              size: 30,
              color: AppColors.primary.withValues(alpha: 0.4),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'لا يوجد أعضاء بعد',
            style: context.textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'أضف أعضاء فريقك وحدد صلاحيات كل واحد',
            style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
