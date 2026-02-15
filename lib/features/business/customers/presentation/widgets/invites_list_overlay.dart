import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/customers/domain/entities/customer_invite.dart';
import 'package:honak/features/business/customers/presentation/widgets/invite_card.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/empty_state.dart';

/// Shows a full-screen overlay with all invites, search, and filter.
/// Matches Figma InviteSection.tsx InvitesListOverlay (lines 346-436).
Future<void> showInvitesListOverlay(
  BuildContext context, {
  required List<CustomerInvite> invites,
}) {
  return showAppSheet(
    context,
    maxHeightFraction: 0.9,
    builder: (_) => _InvitesListContent(invites: invites),
  );
}

class _InvitesListContent extends StatefulWidget {
  final List<CustomerInvite> invites;

  const _InvitesListContent({required this.invites});

  @override
  State<_InvitesListContent> createState() => _InvitesListContentState();
}

class _InvitesListContentState extends State<_InvitesListContent> {
  String _search = '';
  String _filter = 'all'; // all, pending, registered, expired

  List<CustomerInvite> get _filtered {
    var list = [...widget.invites];

    // Search
    if (_search.trim().isNotEmpty) {
      final q = _search.trim();
      list = list.where((i) {
        return i.name.contains(q) || i.phone.contains(q);
      }).toList();
    }

    // Filter
    switch (_filter) {
      case 'pending':
        list = list
            .where((i) => i.status == InviteStatus.pending)
            .toList();
      case 'registered':
        list = list
            .where((i) =>
                i.status == InviteStatus.registered ||
                i.status == InviteStatus.subscribed)
            .toList();
      case 'expired':
        list = list
            .where((i) =>
                i.status == InviteStatus.expired ||
                i.status == InviteStatus.withdrawn)
            .toList();
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final invites = widget.invites;
    final filtered = _filtered;

    final filters = [
      _FilterDef(
        id: 'all',
        label: l10n.bizInviteAllFilter,
        count: invites.length,
      ),
      _FilterDef(
        id: 'pending',
        label: l10n.bizInvitePending,
        count: invites
            .where((i) => i.status == InviteStatus.pending)
            .length,
      ),
      _FilterDef(
        id: 'registered',
        label: l10n.bizInviteRegisteredFilter,
        count: invites
            .where((i) =>
                i.status == InviteStatus.registered ||
                i.status == InviteStatus.subscribed)
            .length,
      ),
      _FilterDef(
        id: 'expired',
        label: l10n.bizInviteExpired,
        count: invites
            .where((i) =>
                i.status == InviteStatus.expired ||
                i.status == InviteStatus.withdrawn)
            .length,
      ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Sticky header ──
        AppSheetHeader(
          title: l10n.bizInviteSentInvites,
          onClose: () => Navigator.of(context).pop(),
        ),

        // Search
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: TextField(
            onChanged: (v) => setState(() => _search = v),
            textDirection: TextDirection.rtl,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: l10n.bizInviteSearchHint,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: AppColors.textHint,
              ),
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              contentPadding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.md,
                10,
                36,
                10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.divider),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.divider),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
              prefixIcon: const Padding(
                padding: EdgeInsetsDirectional.only(start: 12),
                child:
                    Icon(Icons.search, size: 14, color: AppColors.textHint),
              ),
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 32, minHeight: 0),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Filter chips
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filters.map((f) {
                final isSelected = f.id == _filter;
                return Padding(
                  padding:
                      const EdgeInsetsDirectional.only(end: AppSpacing.sm),
                  child: GestureDetector(
                    onTap: () => setState(() => _filter = f.id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            f.label,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                          if (f.count > 0) ...[
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white.withValues(alpha: 0.2)
                                    : const Color(0xFFE5E7EB)
                                        .withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              child: Text(
                                '${f.count}',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // ── Invite list ──
        Flexible(
          child: filtered.isEmpty
              ? EmptyState(
                  icon: Icons.send_outlined,
                  title: l10n.bizInviteNoInvites,
                )
              : ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ).copyWith(bottom: AppSpacing.xxl),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (_, i) => InviteCard(
                    invite: filtered[i],
                  ),
                ),
        ),
      ],
    );
  }
}

class _FilterDef {
  final String id;
  final String label;
  final int count;

  const _FilterDef({
    required this.id,
    required this.label,
    required this.count,
  });
}
