import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';

/// Card shown when the business requests additional information from the customer.
///
/// - **Customer view**: shows the question, item list with per-item "ارسال" buttons.
/// - **Business view**: shows a sent-confirmation header and the item list
///   without action buttons (read-only summary of what was requested).
class InfoRequestCard extends StatelessWidget {
  final Message message;
  final bool isBusinessMode;

  const InfoRequestCard({
    super.key,
    required this.message,
    this.isBusinessMode = false,
  });

  List<Map<String, dynamic>> get _infoItems =>
      (message.metadata['info_items'] as List?)
          ?.cast<Map<String, dynamic>>() ??
      [];

  String? get _note => message.metadata['note'] as String?;

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
          _buildHeader(cs, question),
          if (_infoItems.isNotEmpty) ...[
            Divider(height: 1, color: cs.outlineVariant),
            _buildItemList(cs),
          ],
          if (isBusinessMode) _buildSentStatus(cs),
        ],
      ),
    );
  }

  Widget _buildHeader(ColorScheme cs, String question) {
    final headerText = isBusinessMode
        ? 'تم إرسال طلب معلومات'
        : message.senderName != null
            ? '${message.senderName} يحتاج معلومات إضافية'
            : 'مطلوب معلومات إضافية';

    return Padding(
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
                  headerText,
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
                if (_note != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _note!,
                    style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemList(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.md,
        end: AppSpacing.md,
        bottom: AppSpacing.md,
        top: AppSpacing.sm,
      ),
      child: Column(
        children: _infoItems.map((item) {
          return _buildItemRow(item, cs);
        }).toList(),
      ),
    );
  }

  Widget _buildItemRow(Map<String, dynamic> item, ColorScheme cs) {
    final label = item['label'] as String? ?? '';
    final description = item['description'] as String?;
    final itemType = item['type'] as String? ?? 'text';

    final icon = switch (itemType) {
      'photo' => Icons.camera_alt_outlined,
      'video' => Icons.videocam_outlined,
      'location' => Icons.location_on_outlined,
      'document' => Icons.description_outlined,
      'choice' => Icons.list_outlined,
      _ => Icons.text_fields,
    };

    final options = (item['options'] as List?)?.cast<String>();
    final hasOptions =
        itemType == 'choice' && options != null && options.isNotEmpty;

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
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
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 2),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 11,
                        color: cs.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                if (hasOptions)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: options
                          .map((opt) => Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    bottom: 2),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '· ',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: cs.onSurfaceVariant,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        opt,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: cs.onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Icon(icon, size: 18, color: AppColors.warning),
          const SizedBox(width: AppSpacing.sm),
          SizedBox(
            height: 30,
            child: FilledButton(
              onPressed: isBusinessMode ? null : () {},
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.warning,
                disabledBackgroundColor:
                    AppColors.warning.withValues(alpha: 0.38),
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
  }

  Widget _buildSentStatus(ColorScheme cs) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.08),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.schedule, size: 14, color: AppColors.warning),
          SizedBox(width: AppSpacing.xs),
          Text(
            'في انتظار الرد',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.warning,
            ),
          ),
        ],
      ),
    );
  }
}
