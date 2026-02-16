import 'package:flutter/material.dart';
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
    return switch (status) {
      'pending' => _buildPendingActions(),
      'accepted' => _buildAcceptedActions(),
      'in_progress' => _buildInProgressActions(),
      'preparing' => _buildPreparingActions(),
      'ready' => _buildReadyActions(),
      'completed' || 'delivered' => _buildTerminalActions(context),
      'declined' => _buildDeclinedBadge(),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildPendingActions() {
    return Row(
      children: [
        Expanded(
          child: Button(
            onPressed: isLoading ? null : onDecline,
            label: 'رفض',
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
            label: 'قبول الطلب',
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

  Widget _buildAcceptedActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Button(
          onPressed: isLoading ? null : () => onUpdateStatus('in_progress'),
          label: 'بدء التنفيذ',
          icon: const ButtonIcon(Icons.local_shipping_outlined),
          size: ButtonSize.large,
          expand: true,
          isLoading: isLoading,
        ),
        const SizedBox(height: AppSpacing.sm),
        Button(
          onPressed: isLoading ? null : () => onUpdateStatus('completed'),
          label: 'تم التسليم',
          icon: const ButtonIcon(Icons.check_circle_outline),
          style: Style.success,
          variant: Variant.outlined,
          size: ButtonSize.large,
          expand: true,
        ),
      ],
    );
  }

  Widget _buildInProgressActions() {
    return Button(
      onPressed: isLoading ? null : () => onUpdateStatus('completed'),
      label: 'تم التسليم',
      icon: const ButtonIcon(Icons.check_circle_outline),
      style: Style.success,
      size: ButtonSize.large,
      expand: true,
      isLoading: isLoading,
    );
  }

  Widget _buildPreparingActions() {
    return Button(
      onPressed: isLoading ? null : () => onUpdateStatus('ready'),
      label: 'جاهز للتسليم',
      icon: const ButtonIcon(Icons.check_circle_outline),
      style: Style.warning,
      size: ButtonSize.large,
      expand: true,
      isLoading: isLoading,
    );
  }

  Widget _buildReadyActions() {
    return Button(
      onPressed: isLoading ? null : () => onUpdateStatus('delivered'),
      label: 'تم التسليم',
      icon: const ButtonIcon(Icons.local_shipping),
      style: Style.success,
      size: ButtonSize.large,
      expand: true,
      isLoading: isLoading,
    );
  }

  Widget _buildTerminalActions(BuildContext context) {
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
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'مكتمل',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF43A047),
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Icon(
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
                  label: 'محادثة',
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
                  label: 'إرسال إيصال',
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

  Widget _buildDeclinedBadge() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'مرفوض',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Icon(
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
