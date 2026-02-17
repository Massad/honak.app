import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/customers/domain/entities/customer_invite.dart';

/// Individual invite card — used in both preview and full list.
/// Matches Figma InviteSection.tsx InviteCard (lines 279-343).
class InviteCard extends StatelessWidget {
  final CustomerInvite invite;
  final VoidCallback? onWithdraw;

  const InviteCard({
    super.key,
    required this.invite,
    this.onWithdraw,
  });

  @override
  Widget build(BuildContext context) {
    final inv = invite;
    final l10n = context.l10n;
    final isPending = inv.status == InviteStatus.pending && !inv.isExpired;
    final isExpiredOrWithdrawn =
        inv.isExpired || inv.status == InviteStatus.withdrawn;

    return Opacity(
      opacity: isExpiredOrWithdrawn ? 0.6 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md), // p-3
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Top row: name + status badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Status badges + expiry warning
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Expiry warning
                    if (isPending &&
                        inv.daysUntilExpiry != null &&
                        inv.daysUntilExpiry! <= 3)
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.only(end: 6),
                        child: Text(
                          l10n.bizInviteExpiresInDays(
                              inv.daysUntilExpiry!),
                          style: const TextStyle(
                            fontSize: 8,
                            color: Color(0xFFF59E0B), // amber-500
                          ),
                        ),
                      ),
                    _StatusBadge(status: inv.status, isExpired: inv.isExpired),
                  ],
                ),

                // Name / phone
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      inv.displayName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF374151), // gray-700
                      ),
                    ),
                    if (inv.name.isNotEmpty)
                      Directionality(
                        textDirection: Directionality.of(context),
                        child: Text(
                          inv.phone,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textHint,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 4),

            // Bottom row: withdraw link + package + sent date + method
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Withdraw link
                if (isPending && onWithdraw != null)
                  GestureDetector(
                    onTap: onWithdraw,
                    child: Text(
                      l10n.bizInviteWithdraw,
                      style: const TextStyle(
                        fontSize: 9,
                        color: AppColors.error,
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink(),

                // Package name + sent date + method
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (inv.packageName != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF), // blue-50
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          inv.packageName!,
                          style: const TextStyle(
                            fontSize: 9,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    Text(
                      _sentLabel(inv.daysSinceSent, l10n),
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textHint,
                      ),
                    ),
                    if (inv.method == 'whatsapp') ...[
                      const Text(
                        ' · واتساب',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Status Badge
// ═══════════════════════════════════════════════════════════════

class _StatusBadge extends StatelessWidget {
  final InviteStatus status;
  final bool isExpired;

  const _StatusBadge({required this.status, required this.isExpired});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final (String label, Color color, Color bgColor) = switch (status) {
      InviteStatus.pending when !isExpired => (
        l10n.bizInvitePending,
        const Color(0xFFD97706), // amber-600
        const Color(0xFFFFFBEB), // amber-50
      ),
      InviteStatus.registered => (
        l10n.bizInviteRegistered,
        AppColors.primary,
        const Color(0xFFEFF6FF), // blue-50
      ),
      InviteStatus.subscribed => (
        l10n.bizInviteSubscribed,
        AppColors.success,
        const Color(0xFFF0FDF4), // green-50
      ),
      InviteStatus.withdrawn => (
        l10n.bizInviteWithdrawn,
        const Color(0xFFF87171), // red-400
        const Color(0xFFFEF2F2), // red-50
      ),
      _ => (
        l10n.bizInviteExpired,
        AppColors.textHint,
        const Color(0xFFF3F4F6), // gray-100
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8, // px-2
        vertical: 2, // py-0.5
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9,
          color: color,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Helpers
// ═══════════════════════════════════════════════════════════════

String _sentLabel(int daysSince, dynamic l10n) {
  if (daysSince == 0) return 'أُرسلت ${l10n.bizInviteSentToday}';
  return 'أُرسلت ${l10n.bizInviteSentDaysAgo(daysSince)}';
}
