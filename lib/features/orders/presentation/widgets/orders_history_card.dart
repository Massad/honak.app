import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/domain/entities/entities.dart';
import 'package:honak/shared/widgets/app_image.dart';

/// Card for a completed/cancelled order.
class HistoryCard extends StatelessWidget {
  final CustomerRequest request;

  const HistoryCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final isCompleted =
        request.status == 'completed' || request.status == 'delivered';

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              context.showSnackBar(
                  context.l10n.ordersDetailSnackbar(request.id));
            },
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  _HistoryAvatar(
                    request: request,
                    isCompleted: isCompleted,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.businessName,
                          style: context.textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _buildSummary(context),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                            fontSize: 11,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (request.total != null)
                    Text(
                      request.total!.toFormattedArabic(),
                      style: context.textTheme.titleSmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (isCompleted) _HistoryActions(request: request),
        ],
      ),
    );
  }

  String _buildSummary(BuildContext context) {
    switch (request.type) {
      case 'order':
        final count = request.itemsCount > 0
            ? request.itemsCount
            : request.items.length;
        return context.l10n.ordersItemsCount(count);
      case 'booking':
        if (request.timeSlot != null) return request.timeSlot!;
        return context.l10n.booking;
      case 'quote':
      case 'inquiry':
        return request.description ?? '';
      case 'reservation':
        return request.dateRange ?? context.l10n.ordersPlaceReservation;
      default:
        return '';
    }
  }
}

class _HistoryAvatar extends StatelessWidget {
  final CustomerRequest request;
  final bool isCompleted;

  const _HistoryAvatar({required this.request, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppImage.avatar(
          url: request.businessAvatarUrl,
          name: request.businessName,
          radius: 22,
        ),
        if (isCompleted)
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: context.colorScheme.surface, width: 2),
              ),
              child: const Icon(Icons.check, size: 9, color: Colors.white),
            ),
          ),
      ],
    );
  }
}

class _HistoryActions extends StatelessWidget {
  final CustomerRequest request;

  const _HistoryActions({required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: context.colorScheme.surfaceContainerLowest)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => context.showSnackBar(context.l10n.reorderButton),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.replay, size: 12, color: AppColors.success),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      context.l10n.reorderButton,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.success,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(width: 1, height: 20, color: context.colorScheme.surfaceContainerLowest),
          Expanded(
            child: GestureDetector(
              onTap: () => context.showSnackBar(
                  context.l10n.ordersDetailSnackbar(request.id)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.description_outlined,
                        size: 12, color: context.colorScheme.onSurfaceVariant),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      context.l10n.ordersViewDetails,
                      style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
