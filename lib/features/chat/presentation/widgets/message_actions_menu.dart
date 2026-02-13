import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/features/chat/presentation/providers/message_action_provider.dart';

/// Shows a centered modal menu with contextual actions for a message.
void showMessageActionsMenu(
  BuildContext context,
  Message message,
  bool isMine,
  WidgetRef ref, {
  VoidCallback? onReport,
}) {
  final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final ageMinutes = (now - message.createdAt) / 60;
  final isText = message.type == 'text';

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'message_actions',
    barrierColor: Colors.black26,
    pageBuilder: (_, __, ___) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 260,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Message preview
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    isText ? message.content : '📎 مرفق',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                // Actions
                if (isText)
                  _ActionTile(
                    icon: Icons.copy_rounded,
                    label: 'نسخ',
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: message.content));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم النسخ')),
                      );
                    },
                  ),
                if (isMine && isText && ageMinutes < 15)
                  _ActionTile(
                    icon: Icons.edit_rounded,
                    label: 'تعديل',
                    color: AppColors.primary,
                    onTap: () {
                      ref.read(editingMessageProvider.notifier).state = message;
                      Navigator.pop(context);
                    },
                  ),
                _ActionTile(
                  icon: Icons.check_box_outlined,
                  label: 'تحديد',
                  onTap: () {
                    final selected =
                        ref.read(selectedMessagesProvider.notifier);
                    selected.state = {...selected.state, message.id};
                    Navigator.pop(context);
                  },
                ),
                if (!isMine)
                  _ActionTile(
                    icon: Icons.flag_outlined,
                    label: 'إبلاغ',
                    color: const Color(0xFFFB923C), // orange-400
                    onTap: () {
                      Navigator.pop(context);
                      if (onReport != null) {
                        onReport();
                      }
                    },
                  ),
                const Divider(height: 1),
                _ActionTile(
                  icon: Icons.person_outline_rounded,
                  label: 'حذف لي',
                  color: AppColors.error,
                  onTap: () {
                    final deleted =
                        ref.read(deletedForMeProvider.notifier);
                    deleted.state = {...deleted.state, message.id};
                    Navigator.pop(context);
                  },
                ),
                if (isMine && ageMinutes < 60)
                  _ActionTile(
                    icon: Icons.group_outlined,
                    label: 'حذف للجميع',
                    color: AppColors.error,
                    isLast: true,
                    onTap: () {
                      final deleted =
                          ref.read(deletedForEveryoneProvider.notifier);
                      deleted.state = {...deleted.state, message.id};
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;
  final bool isLast;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.textPrimary;
    return InkWell(
      onTap: onTap,
      borderRadius: isLast
          ? const BorderRadius.vertical(bottom: Radius.circular(16))
          : null,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.lg,
          vertical: 12,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: c),
            const SizedBox(width: AppSpacing.md),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: c,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
