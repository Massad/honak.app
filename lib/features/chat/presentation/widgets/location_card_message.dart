import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/shared/widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationCardMessage extends StatelessWidget {
  final Message message;
  static const _mapPreviewUrl =
      'https://images.unsplash.com/photo-1524661135-423995f22d0b?auto=format&fit=crop&w=400&h=180&q=80';

  const LocationCardMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final data = LocationCardData.fromMetadata(message.metadata);
    final titleText = data.title.trim();
    final addressText = data.address.trim();
    final hasCoords = data.latitude != null && data.longitude != null;
    final hasMapUrl = data.mapUrl?.trim().isNotEmpty ?? false;
    final showMapPreview = data.branchId != null || hasCoords;
    final isOnWay = data.mode == 'live' || addressText == 'الموقع الحالي';
    final hasDistinctAddress =
        addressText.isNotEmpty && addressText != titleText;
    final showCustomAddressHeader = !showMapPreview && !isOnWay;
    final showOpenMap = !isOnWay && (showMapPreview || hasMapUrl);
    final phoneText = data.phone?.trim();
    final hoursText = data.hours?.trim();
    final hasPhone = phoneText != null && phoneText.isNotEmpty;
    final hasHours = hoursText != null && hoursText.isNotEmpty;

    void openMaps() {
      if (hasMapUrl) {
        launchUrl(Uri.parse(data.mapUrl!.trim()));
        return;
      }
      if (hasCoords) {
        launchUrl(
          Uri.parse(
            'https://www.google.com/maps?q=${data.latitude},${data.longitude}',
          ),
        );
        return;
      }
      launchUrl(
        Uri.parse(
          'https://www.google.com/maps/search/${Uri.encodeComponent(data.address)}',
        ),
      );
    }

    return Container(
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      constraints: const BoxConstraints(maxWidth: 320),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.colorScheme.outlineVariant.withValues(
                  alpha: 0.45,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showMapPreview)
                  SizedBox(
                    width: double.infinity,
                    height: 140,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          _mapPreviewUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            color: context.colorScheme.surfaceContainerHigh,
                          ),
                        ),
                        Container(color: Colors.black.withValues(alpha: 0.08)),
                        PositionedDirectional(
                          top: AppSpacing.sm,
                          end: AppSpacing.sm,
                          child: Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorScheme.surface.withValues(
                                alpha: 0.9,
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.near_me_outlined,
                                  size: 10,
                                  color: context.colorScheme.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'موقع مشارك',
                                  style: context.textTheme.labelSmall?.copyWith(
                                    color: context.colorScheme.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (!showMapPreview && isOnWay)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsetsDirectional.all(AppSpacing.md),
                    color: AppColors.primary.withValues(alpha: 0.08),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                          child: const Icon(
                            Icons.near_me_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                titleText,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'تم مشاركة الموقع الحالي',
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                if (showCustomAddressHeader)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsetsDirectional.all(AppSpacing.md),
                    color: AppColors.primary.withValues(alpha: 0.08),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withValues(alpha: 0.12),
                          ),
                          child: const Icon(
                            Icons.location_on_outlined,
                            size: 18,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.near_me_outlined,
                                    size: 11,
                                    color: context.colorScheme.primary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'موقع مشارك',
                                    style: context.textTheme.labelSmall
                                        ?.copyWith(
                                          color: context.colorScheme.primary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                titleText,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.md,
                    AppSpacing.sm,
                    AppSpacing.md,
                    AppSpacing.md,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showMapPreview && titleText.isNotEmpty) ...[
                        Text(
                          titleText,
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                      ],
                      if (!isOnWay && (showMapPreview || hasDistinctAddress))
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 13,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                addressText,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (hasPhone || hasHours) ...[
                        const SizedBox(height: AppSpacing.sm),
                        Divider(
                          height: 1,
                          color: context.colorScheme.outlineVariant.withValues(
                            alpha: 0.3,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        if (hasPhone) ...[
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                size: 12,
                                color: AppColors.success,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                phoneText,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          if (hasHours) const SizedBox(height: 4),
                        ],
                        if (hasHours)
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 12,
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                hoursText,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                      ],
                      if (showOpenMap) ...[
                        const SizedBox(height: AppSpacing.md),
                        Button(
                          onPressed: openMaps,
                          label: 'فتح في الخريطة',
                          icon: const ButtonIcon(
                            Icons.open_in_new_rounded,
                            size: 15,
                          ),
                          size: ButtonSize.small,
                          variant: Variant.tonal,
                          expand: true,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: AppSpacing.sm,
              top: AppSpacing.xs,
            ),
            child: Text(
              _formatTime(message.createdAt),
              style: TextStyle(
                fontSize: 10,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int timestampSec) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestampSec * 1000);
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final period = date.hour < 12 ? 'ص' : 'م';
    return '$hour:${date.minute.toString().padLeft(2, '0')} $period';
  }
}
