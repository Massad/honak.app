import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/button.dart';

/// Action buttons shown based on request status.
class RequestActions extends StatelessWidget {
  final String status;
  final bool isLoading;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final ValueChanged<String> onUpdateStatus;
  final VoidCallback? onReceipt;
  final VoidCallback? onChat;

  const RequestActions({
    super.key,
    required this.status,
    required this.isLoading,
    required this.onAccept,
    required this.onDecline,
    required this.onUpdateStatus,
    this.onReceipt,
    this.onChat,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return switch (status) {
      'pending' => _buildPendingActions(l10n),
      'accepted' => _buildAcceptedActions(l10n),
      'in_progress' => _buildInProgressActions(l10n),
      'preparing' => _buildPreparingActions(l10n),
      'ready' => _buildReadyActions(l10n),
      'completed' || 'delivered' => _buildTerminalActions(context, l10n),
      'declined' => _buildDeclinedBadge(l10n),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildPendingActions(AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          child: Button(
            onPressed: isLoading ? null : onDecline,
            label: l10n.bizReqDecline,
            icon: const ButtonIcon(Icons.close),
            style: Style.danger,
            variant: Variant.outlined,
            size: ButtonSize.large,
            expand: true,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          flex: 2,
          child: Button(
            onPressed: isLoading ? null : onAccept,
            label: l10n.bizReqAcceptOrder,
            icon: const ButtonIcon(Icons.check),
            style: Style.success,
            size: ButtonSize.large,
            expand: true,
            isLoading: isLoading,
          ),
        ),
      ],
    );
  }

  Widget _buildAcceptedActions(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Button(
          onPressed: isLoading ? null : () => onUpdateStatus('in_progress'),
          label: l10n.bizReqStartExecution,
          icon: const ButtonIcon(Icons.local_shipping_outlined),
          size: ButtonSize.large,
          expand: true,
          isLoading: isLoading,
        ),
        const SizedBox(height: AppSpacing.sm),
        Button(
          onPressed: isLoading ? null : () => onUpdateStatus('completed'),
          label: l10n.bizReqMarkDelivered,
          icon: const ButtonIcon(Icons.check_circle_outline),
          style: Style.success,
          variant: Variant.outlined,
          size: ButtonSize.large,
          expand: true,
        ),
      ],
    );
  }

  Widget _buildInProgressActions(AppLocalizations l10n) {
    return Button(
      onPressed: isLoading ? null : () => onUpdateStatus('completed'),
      label: l10n.bizReqMarkDelivered,
      icon: const ButtonIcon(Icons.check_circle_outline),
      style: Style.success,
      size: ButtonSize.large,
      expand: true,
      isLoading: isLoading,
    );
  }

  Widget _buildPreparingActions(AppLocalizations l10n) {
    return Button(
      onPressed: isLoading ? null : () => onUpdateStatus('ready'),
      label: l10n.bizReqReadyForDelivery,
      icon: const ButtonIcon(Icons.check_circle_outline),
      style: Style.warning,
      size: ButtonSize.large,
      expand: true,
      isLoading: isLoading,
    );
  }

  Widget _buildReadyActions(AppLocalizations l10n) {
    return Button(
      onPressed: isLoading ? null : () => onUpdateStatus('delivered'),
      label: l10n.bizReqMarkDelivered,
      icon: const ButtonIcon(Icons.local_shipping),
      style: Style.success,
      size: ButtonSize.large,
      expand: true,
      isLoading: isLoading,
    );
  }

  Widget _buildTerminalActions(BuildContext context, AppLocalizations l10n) {
    return Column(
      children: [
        // Completed badge
        Center(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF43A047).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.bizReqStatusCompleted,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF43A047),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Icon(
                  Icons.check_circle,
                  size: 20,
                  color: Color(0xFF43A047),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        // Receipt + Chat buttons
        Row(
          children: [
            if (onChat != null)
              Expanded(
                child: Button(
                  onPressed: onChat,
                  label: l10n.bizReqChat,
                  icon: const ButtonIcon(Icons.chat_bubble_outline_rounded),
                  variant: Variant.outlined,
                  size: ButtonSize.large,
                  expand: true,
                ),
              ),
            if (onChat != null && onReceipt != null)
              const SizedBox(width: AppSpacing.sm),
            if (onReceipt != null)
              Expanded(
                child: Button(
                  onPressed: onReceipt,
                  label: l10n.bizReqSendReceipt,
                  icon: const ButtonIcon(Icons.receipt_long_rounded),
                  size: ButtonSize.large,
                  expand: true,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeclinedBadge(AppLocalizations l10n) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.bizReqStatusDeclined,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Icon(
              Icons.block,
              size: 20,
              color: AppColors.error,
            ),
          ],
        ),
      ),
    );
  }
}
