import 'package:flutter/material.dart';

/// Resolves icon string IDs from config/API to Flutter IconData.
IconData resolveInsightIcon(String? iconId) {
  if (iconId == null) return Icons.bar_chart_rounded;
  return _iconMap[iconId] ?? Icons.bar_chart_rounded;
}

const Map<String, IconData> _iconMap = {
  'banknote': Icons.payments_outlined,
  'package': Icons.inventory_2_outlined,
  'utensils': Icons.restaurant_outlined,
  'trending-up': Icons.trending_up,
  'users': Icons.people_outlined,
  'repeat': Icons.replay,
  'user-minus': Icons.person_remove_outlined,
  'user-plus': Icons.person_add_outlined,
  'clock': Icons.schedule_outlined,
  'droplets': Icons.water_drop_outlined,
  'map-pin': Icons.location_on_outlined,
  'calendar': Icons.calendar_today_outlined,
  'star': Icons.star_outlined,
  'activity': Icons.show_chart,
  'truck': Icons.local_shipping_outlined,
  'flame': Icons.local_fire_department_outlined,
  'crown': Icons.emoji_events_outlined,
  'eye': Icons.visibility_outlined,
  'wrench': Icons.build_outlined,
  'scissors': Icons.content_cut_outlined,
  'sparkles': Icons.auto_awesome_outlined,
  'alert-circle': Icons.error_outline,
  'bell': Icons.notifications_outlined,
  'check-circle': Icons.check_circle_outline,
  'file-text': Icons.article_outlined,
  'home': Icons.home_outlined,
  'moon': Icons.dark_mode_outlined,
  'heart': Icons.favorite_outline,
  'briefcase': Icons.work_outline,
};
