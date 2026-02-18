import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/features/chat/presentation/widgets/chat_action_card_shell.dart';
import 'package:honak/shared/widgets/app_image.dart';
import 'package:honak/shared/widgets/button.dart';

class PortfolioCardMessage extends StatelessWidget {
  final Message message;

  const PortfolioCardMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final data = PortfolioCardData.fromMetadata(message.metadata);
    final previewImage = data.primaryImage;
    return ChatActionCardShell(
      message: message,
      icon: Icons.photo_library_outlined,
      color: AppColors.primary,
      title: 'أرسل أعمالي',
      body: Padding(
        padding: const EdgeInsetsDirectional.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (previewImage != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AppImage(
                  url: previewImage,
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                  placeholderIcon: Icons.image_outlined,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            Text(
              data.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurface,
              ),
            ),
            if (data.subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                data.subtitle!,
                style: TextStyle(
                  fontSize: 12,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (data.images.length > 1) ...[
              const SizedBox(height: 6),
              Text(
                '${data.images.length} صور',
                style: TextStyle(
                  fontSize: 11,
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
      footer: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: AppSpacing.md,
          end: AppSpacing.md,
          bottom: AppSpacing.sm,
        ),
        child: Button(
          onPressed: () {},
          label: data.ctaLabel ?? 'عرض التفاصيل',
          size: ButtonSize.small,
          variant: Variant.tonal,
          expand: true,
        ),
      ),
    );
  }
}
