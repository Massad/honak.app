import 'package:flutter/material.dart';

import 'package:honak/config/business_type_config.dart';
import 'package:honak/features/business/dashboard/presentation/widgets/sections/booking_sections.dart';
import 'package:honak/features/business/dashboard/presentation/widgets/sections/core_sections.dart';
import 'package:honak/features/business/dashboard/presentation/widgets/sections/delivery_sections.dart';
import 'package:honak/features/business/dashboard/presentation/widgets/sections/order_sections.dart';
import 'package:honak/features/business/dashboard/presentation/widgets/sections/venue_sections.dart';
import 'package:honak/features/business/dropoff/presentation/widgets/dropoff_dashboard_widget.dart';
import 'package:honak/features/business/queue/presentation/widgets/queue_dashboard_widget.dart';

/// Whether this section type renders its own colored container
/// and should skip the white card wrapper.
bool hasCustomBackground(DashboardSectionType type) {
  return type == DashboardSectionType.lowStock ||
      type == DashboardSectionType.unavailableItems;
}

/// Renders the inner content for a dashboard section based on its type.
class DashboardSectionContent extends StatelessWidget {
  final DashboardSectionType type;
  final Map<String, dynamic> data;

  const DashboardSectionContent({
    super.key,
    required this.type,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      // Core
      DashboardSectionType.stats => TodaySummarySection(
          data: data['today_summary'] as Map<String, dynamic>? ?? {},
        ),
      DashboardSectionType.todayRevenue => TodayRevenueSection(
          data: data['today_revenue'] as Map<String, dynamic>? ?? {},
        ),
      DashboardSectionType.pendingOrders => PendingRequestsSection(
          items: data['pending_requests'] as List? ?? [],
        ),
      // Booking
      DashboardSectionType.nextAppointment => NextAppointmentSection(
          data: data['next_appointment'] as Map<String, dynamic>? ?? {},
        ),
      DashboardSectionType.todaySchedule => TodayScheduleSection(
          items: data['today_schedule'] as List? ?? [],
        ),
      DashboardSectionType.activeQuotes => ActiveQuotesSection(
          items: data['active_quotes'] as List? ?? [],
        ),
      // Order
      DashboardSectionType.activeQueue => ActiveQueueSection(
          items: data['active_queue'] as List? ?? [],
        ),
      DashboardSectionType.unavailableItems => UnavailableItemsSection(
          items: data['unavailable_items'] as List? ?? [],
        ),
      DashboardSectionType.bestSellers => BestSellersSection(
          items: data['best_sellers'] as List? ?? [],
        ),
      // Delivery
      DashboardSectionType.deliveryRoute => DeliveryRouteSection(
          data: data['delivery_route'] as Map<String, dynamic>? ?? {},
        ),
      DashboardSectionType.lowStock => LowStockSection(
          items: data['low_stock'] as List? ?? [],
        ),
      DashboardSectionType.recurringTomorrow => RecurringTomorrowSection(
          data: data['recurring_tomorrow'] as Map<String, dynamic>? ?? {},
        ),
      DashboardSectionType.customerInsights => CustomerInsightsSection(
          items: data['customer_insights'] as List? ?? [],
        ),
      // Venue
      DashboardSectionType.occupancy => OccupancySection(
          data: data['occupancy'] as Map<String, dynamic>? ?? {},
        ),
      DashboardSectionType.upcomingReservations =>
        UpcomingReservationsSection(
          items: data['upcoming_reservations'] as List? ?? [],
        ),
      DashboardSectionType.recentlyLinked => RecentlyLinkedSection(
          items: data['recently_linked'] as List? ?? [],
        ),
      // Queue
      DashboardSectionType.liveQueue => QueueDashboardWidget(
          waiting:
              (data['live_queue'] as Map<String, dynamic>?)?['waiting']
                  as int? ??
              0,
          inProgress:
              (data['live_queue'] as Map<String, dynamic>?)?['in_progress']
                  as int? ??
              0,
          completed:
              (data['live_queue'] as Map<String, dynamic>?)?['completed']
                  as int? ??
              0,
          avgWaitMin:
              (data['live_queue'] as Map<String, dynamic>?)?['avg_wait_min']
                  as int? ??
              0,
          revenueTodayCents: (data['live_queue']
                  as Map<String, dynamic>?)?['revenue_today_cents']
              as int? ??
              0,
        ),
      // Dropoff
      DashboardSectionType.liveDropoff => DropoffDashboardWidget(
          received:
              (data['live_dropoff'] as Map<String, dynamic>?)?['received']
                  as int? ??
              0,
          processing:
              (data['live_dropoff'] as Map<String, dynamic>?)?['processing']
                  as int? ??
              0,
          ready:
              (data['live_dropoff'] as Map<String, dynamic>?)?['ready']
                  as int? ??
              0,
          delivered:
              (data['live_dropoff'] as Map<String, dynamic>?)?['delivered']
                  as int? ??
              0,
          overdue:
              (data['live_dropoff'] as Map<String, dynamic>?)?['overdue']
                  as int? ??
              0,
          revenueTodayCents: (data['live_dropoff']
                  as Map<String, dynamic>?)?['revenue_today_cents']
              as int? ??
              0,
        ),
      // Fallback
      _ => const SizedBox.shrink(),
    };
  }
}
