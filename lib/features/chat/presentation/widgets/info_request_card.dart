import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';

/// Card shown when the business requests additional information from the customer.
/// The customer sees the question and can respond via the chat input.
class InfoRequestCard extends StatelessWidget {
  final Message message;

  const InfoRequestCard({super.key, required this.message});

  List<Map<String, dynamic>> get _infoItems =>
      (message.metadata['info_items'] as List?)
          ?.cast<Map<String, dynamic>>() ??
      [];

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final question = message.metadata['question'] as String? ?? message.content;

    return Container(
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.06),
        border: Border.all(color: AppColors.warning, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.help_outline_rounded,
                    size: 18,
                    color: AppColors.warning,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.senderName != null
                            ? '${message.senderName} يحتاج معلومات إضافية'
                            : 'مطلوب معلومات إضافية',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.warning,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        question,
                        style: TextStyle(
                          fontSize: 13,
                          color: cs.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_infoItems.isNotEmpty) ...[
            Divider(height: 1, color: cs.outlineVariant),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: AppSpacing.md,
                end: AppSpacing.md,
                bottom: AppSpacing.md,
                top: AppSpacing.sm,
              ),
              child: Column(
                children: _infoItems.map((item) {
                  final label = item['label'] as String? ?? '';
                  final description = item['description'] as String?;
                  final itemType = item['type'] as String? ?? 'text';

                  final icon = switch (itemType) {
                    'photo' => Icons.camera_alt_outlined,
                    'video' => Icons.videocam_outlined,
                    _ => Icons.text_fields,
                  };

                  return Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: AppSpacing.sm,
                    ),
                    child: Row(
                      children: [
                        Icon(icon, size: 18, color: AppColors.warning),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                label,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: cs.onSurface,
                                ),
                              ),
                              if (description != null)
                                Text(
                                  description,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: cs.onSurfaceVariant,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: FilledButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('قريباً: إرسال الملفات'),
                                ),
                              );
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.warning,
                              padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: AppSpacing.md,
                              ),
                              textStyle: const TextStyle(fontSize: 12),
                            ),
                            child: const Text('ارسال'),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
