import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/shared/widgets/app_dialog.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/button.dart';

class ImageMessage extends StatelessWidget {
  final Message message;
  final bool isMine;

  const ImageMessage({
    super.key,
    required this.message,
    required this.isMine,
  });

  @override
  Widget build(BuildContext context) {
    final time = DateTime.fromMillisecondsSinceEpoch(message.createdAt * 1000);
    final timeStr =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

    return Align(
      alignment: isMine
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: GestureDetector(
        onTap: () => _showFullScreen(context),
        child: Container(
          margin: const EdgeInsetsDirectional.only(
            start: AppSpacing.sm,
            end: AppSpacing.sm,
            top: AppSpacing.xxs,
            bottom: AppSpacing.xxs,
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.65,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                AppImage(
                  url: message.imageUrl,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(12),
                ),
                PositionedDirectional(
                  bottom: 4,
                  end: 4,
                  child: Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      timeStr,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFullScreen(BuildContext context) {
    showAppDialog<void>(
      context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(color: Colors.black87),
            ),
            Center(
              child: InteractiveViewer(
                child: AppImage(
                  url: message.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              left: 8,
              child: Button(
                onPressed: () => Navigator.pop(context),
                icon: ButtonIcon(Icons.close, size: 28, color: AppColors.white),
                variant: Variant.text,
                size: ButtonSize.small,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
