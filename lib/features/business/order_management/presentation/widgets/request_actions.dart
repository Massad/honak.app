import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';

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
          child: SizedBox(
            height: 48,
            child: OutlinedButton.icon(
              onPressed: isLoading ? null : onDecline,
              icon: const Icon(Icons.close, size: 18),
              label: const Text('رفض'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: isLoading ? null : onAccept,
              icon: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.check, size: 18),
              label: const Text(
                'قبول الطلب',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF43A047),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAcceptedActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            onPressed: isLoading ? null : () => onUpdateStatus('in_progress'),
            icon: isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.local_shipping_outlined, size: 18),
            label: const Text(
              'بدء التنفيذ',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 48,
          child: OutlinedButton.icon(
            onPressed: isLoading ? null : () => onUpdateStatus('completed'),
            icon: const Icon(Icons.check_circle_outline, size: 18),
            label: const Text('تم التسليم'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF43A047),
              side: const BorderSide(color: Color(0xFF43A047)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInProgressActions() {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : () => onUpdateStatus('completed'),
        icon: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.check_circle_outline, size: 18),
        label: const Text(
          'تم التسليم',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF43A047),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildPreparingActions() {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : () => onUpdateStatus('ready'),
        icon: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.check_circle_outline, size: 18),
        label: const Text(
          'جاهز للتسليم',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF9800),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildReadyActions() {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : () => onUpdateStatus('delivered'),
        icon: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.local_shipping, size: 18),
        label: const Text(
          'تم التسليم',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF43A047),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
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
            // Chat button (outline)
            if (onChat != null)
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: onChat,
                    icon: const Icon(
                        Icons.chat_bubble_outline_rounded, size: 18),
                    label: const Text('محادثة'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).colorScheme.onSurface,
                      side: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .outlineVariant),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            if (onChat != null && onReceipt != null)
              const SizedBox(width: AppSpacing.sm),
            // Receipt button (primary filled)
            if (onReceipt != null)
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: onReceipt,
                    icon: const Icon(Icons.receipt_long_rounded, size: 18),
                    label: const Text(
                      'إرسال إيصال',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
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
