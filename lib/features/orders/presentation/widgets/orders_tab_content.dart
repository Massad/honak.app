import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/orders/presentation/widgets/orders_history_card.dart';
import 'package:honak/features/requests/domain/entities/entities.dart';
import 'package:honak/features/requests/presentation/widgets/request_list_card.dart';
import 'package:honak/shared/widgets/app_image.dart';

/// Active orders tab — shows live order cards with tracking.
class OrdersActiveTab extends StatelessWidget {
  final List<CustomerRequest> requests;

  const OrdersActiveTab({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return const OrdersEmptyTabState(
        icon: Icons.shopping_bag_outlined,
        message: 'لا توجد طلبات نشطة',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: requests.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        return RequestListCard(
          request: requests[index],
          onTap: () => context.push(
            Routes.orderDetailPath(requests[index].id),
            extra: requests[index],
          ),
        );
      },
    );
  }
}

/// Upcoming bookings/reservations tab — calendar-style date cards.
class OrdersUpcomingTab extends StatelessWidget {
  final List<CustomerRequest> requests;

  const OrdersUpcomingTab({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return const OrdersEmptyTabState(
        icon: Icons.calendar_today_outlined,
        message: 'لا توجد مواعيد قادمة',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: requests.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        return UpcomingBookingCard(request: requests[index]);
      },
    );
  }
}

/// Card for an upcoming booking/reservation with calendar panel.
class UpcomingBookingCard extends StatelessWidget {
  final CustomerRequest request;

  const UpcomingBookingCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final isReservation = request.isReservation;
    final dateText = request.preferredDate ?? request.timeSlot ?? '';
    final accentColor =
        isReservation ? AppColors.success : const Color(0xFF7B1FA2);
    final lightBg =
        isReservation ? const Color(0xFFC6F6D5) : const Color(0xFFE9D8FD);

    return GestureDetector(
      onTap: () => context.push(
        Routes.orderDetailPath(request.id),
        extra: request,
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: AppRadius.card,
          border: Border.all(
            color: isReservation
                ? AppColors.success.withValues(alpha: 0.2)
                : const Color(0xFF7B1FA2).withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            // Calendar panel
            Container(
              width: 72,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [lightBg.withValues(alpha: 0.5), lightBg],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isReservation
                        ? Icons.place_outlined
                        : Icons.calendar_today_outlined,
                    size: 16,
                    color: accentColor,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    dateText,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: accentColor,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _BusinessRow(request: request),
                    const SizedBox(height: AppSpacing.xs),
                    if (request.summary != null)
                      Text(
                        request.summary!,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    else if (request.description != null)
                      Text(
                        request.description!,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (isReservation) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          if (request.guestCount != null) ...[
                            Text(
                              '${request.guestCount} ضيوف',
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                          ],
                          if (request.total != null)
                            Text(
                              request.total!.toFormattedArabic(),
                              style: context.textTheme.bodySmall?.copyWith(
                                color: AppColors.primary,
                                fontSize: 10,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BusinessRow extends StatelessWidget {
  final CustomerRequest request;

  const _BusinessRow({required this.request});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImage.avatar(
          url: request.businessAvatarUrl,
          name: request.businessName,
          radius: 16,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            request.businessName,
            style: context.textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// History tab — completed / cancelled orders with reorder hint.
class OrdersHistoryTab extends StatelessWidget {
  final List<CustomerRequest> requests;

  const OrdersHistoryTab({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return const OrdersEmptyTabState(
        icon: Icons.check_circle_outline,
        message: 'لا توجد طلبات سابقة',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: requests.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        return HistoryCard(request: requests[index]);
      },
    );
  }
}

/// Placeholder shown when a tab has no content.
class OrdersEmptyTabState extends StatelessWidget {
  final IconData icon;
  final String message;

  const OrdersEmptyTabState({
    super.key,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: context.screenHeight * 0.15),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: context.colorScheme.outline),
              const SizedBox(height: AppSpacing.lg),
              Text(
                message,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
