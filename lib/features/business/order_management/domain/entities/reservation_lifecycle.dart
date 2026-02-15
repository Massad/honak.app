import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';

/// A single stage in the reservation guest journey.
class JourneyStage {
  final String id;
  final String label;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final String statusTrigger;
  final JourneyNotificationTemplate notification;

  const JourneyStage({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.statusTrigger,
    required this.notification,
  });
}

/// Notification template for a journey stage.
class JourneyNotificationTemplate {
  final String title;
  final String message;
  final bool includeMap;
  final bool includeNearby;

  const JourneyNotificationTemplate({
    required this.title,
    required this.message,
    this.includeMap = false,
    this.includeNearby = false,
  });
}

/// The 6 predefined reservation journey stages.
const List<JourneyStage> kReservationJourneyStages = [
  JourneyStage(
    id: 'confirmed',
    label: 'تأكيد الحجز',
    icon: Icons.check_circle_outline,
    color: AppColors.success,
    bgColor: Color(0xFFE8F5E9),
    statusTrigger: 'accepted',
    notification: JourneyNotificationTemplate(
      title: 'تم تأكيد حجزك',
      message: 'مرحباً {customer}، تم تأكيد حجزك في {space}. '
          'موعد الوصول: {checkin}، المغادرة: {checkout}.',
    ),
  ),
  JourneyStage(
    id: 'deposit',
    label: 'استلام العربون',
    icon: Icons.account_balance_wallet_outlined,
    color: AppColors.warning,
    bgColor: Color(0xFFFFF8E1),
    statusTrigger: 'deposit_received',
    notification: JourneyNotificationTemplate(
      title: 'تم استلام العربون',
      message: 'مرحباً {customer}، تم تسجيل استلام العربون لحجزك في {space}. '
          'موعد الوصول: {checkin}.',
    ),
  ),
  JourneyStage(
    id: 'pre_arrival',
    label: 'تذكير قبل الوصول',
    icon: Icons.notifications_active_outlined,
    color: AppColors.primary,
    bgColor: Color(0xFFE3F2FD),
    statusTrigger: 'deposit_received',
    notification: JourneyNotificationTemplate(
      title: 'اقترب موعد وصولك!',
      message: 'مرحباً {customer}، حجزك في {space} بعد غد. '
          'تسجيل الوصول: {checkin}. إليك موقعنا على الخريطة.',
      includeMap: true,
      includeNearby: true,
    ),
  ),
  JourneyStage(
    id: 'checked_in',
    label: 'تسجيل الوصول',
    icon: Icons.door_front_door_outlined,
    color: AppColors.primary,
    bgColor: Color(0xFFE3F2FD),
    statusTrigger: 'checked_in',
    notification: JourneyNotificationTemplate(
      title: 'تم تسجيل الوصول',
      message: 'أهلاً وسهلاً {customer}! تم تسجيل وصولك إلى {space}. '
          'نتمنى لك إقامة ممتعة. المغادرة: {checkout}.',
    ),
  ),
  JourneyStage(
    id: 'checkout_reminder',
    label: 'تذكير بالمغادرة',
    icon: Icons.access_time,
    color: AppColors.warning,
    bgColor: Color(0xFFFFF8E1),
    statusTrigger: 'checked_in',
    notification: JourneyNotificationTemplate(
      title: 'تذكير بموعد المغادرة',
      message: 'مرحباً {customer}، نود تذكيرك بأن موعد المغادرة من {space} '
          'هو {checkout}. نرجو تسليم المفاتيح عند المغادرة.',
    ),
  ),
  JourneyStage(
    id: 'checked_out',
    label: 'تسجيل المغادرة',
    icon: Icons.logout,
    color: AppColors.textHint,
    bgColor: Color(0xFFF3F4F6),
    statusTrigger: 'completed',
    notification: JourneyNotificationTemplate(
      title: 'شكراً لزيارتك',
      message: 'شكراً لك {customer} على اختيارك {space}. '
          'نتمنى أن تكون إقامتك كانت ممتعة. نسعد بزيارتك مرة أخرى!',
    ),
  ),
];

/// Maps a request status to the current journey stage index.
/// Returns -1 if before the first stage (pending).
int journeyStageIndexForStatus(String status) {
  switch (status) {
    case 'pending':
    case 'pending_review':
      return -1;
    case 'accepted':
      return 0; // confirmed
    case 'deposit_received':
      return 1; // deposit
    case 'checked_in':
      return 3; // checked_in
    case 'completed':
      return 5; // checked_out
    default:
      return -1;
  }
}

/// Fills a notification template with actual values.
String fillNotificationTemplate(
  String template, {
  required String customer,
  required String space,
  String? checkin,
  String? checkout,
}) {
  var result = template.replaceAll('{customer}', customer);
  result = result.replaceAll('{space}', space);
  if (checkin != null) result = result.replaceAll('{checkin}', checkin);
  if (checkout != null) result = result.replaceAll('{checkout}', checkout);
  return result;
}
