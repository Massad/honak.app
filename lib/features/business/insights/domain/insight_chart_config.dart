import 'package:honak/features/business/insights/domain/entities/insight_entities.dart';

/// Which charts to show per archetype.
class ArchetypeChartVisibility {
  final bool showRevenueChart;
  final bool showRankedList;
  final bool showDistribution;

  const ArchetypeChartVisibility({
    required this.showRevenueChart,
    required this.showRankedList,
    required this.showDistribution,
  });
}

/// Chart visibility matrix per archetype key.
ArchetypeChartVisibility getChartVisibility(String archetypeKey) {
  return _visibilityMap[archetypeKey] ??
      const ArchetypeChartVisibility(
        showRevenueChart: true,
        showRankedList: true,
        showDistribution: true,
      );
}

const Map<String, ArchetypeChartVisibility> _visibilityMap = {
  'catalog_order': ArchetypeChartVisibility(
    showRevenueChart: true,
    showRankedList: true,
    showDistribution: true,
  ),
  'menu_order': ArchetypeChartVisibility(
    showRevenueChart: true,
    showRankedList: true,
    showDistribution: true,
  ),
  'service_booking': ArchetypeChartVisibility(
    showRevenueChart: true,
    showRankedList: true,
    showDistribution: false,
  ),
  'quote_request': ArchetypeChartVisibility(
    showRevenueChart: true,
    showRankedList: false,
    showDistribution: true,
  ),
  'portfolio_inquiry': ArchetypeChartVisibility(
    showRevenueChart: true,
    showRankedList: false,
    showDistribution: false,
  ),
  'reservation': ArchetypeChartVisibility(
    showRevenueChart: true,
    showRankedList: false,
    showDistribution: true,
  ),
  'follow_only': ArchetypeChartVisibility(
    showRevenueChart: false,
    showRankedList: true,
    showDistribution: true,
  ),
  'directory': ArchetypeChartVisibility(
    showRevenueChart: false,
    showRankedList: false,
    showDistribution: false,
  ),
};

/// Chart labels resolved per business type.
ChartLabels getChartLabels(String typeId, InsightPeriod period) {
  final base = _labelsMap[typeId] ?? _labelsMap['water_delivery']!;
  // Replace period placeholder in revenue label
  final periodStr = period.periodLabelAr;
  return ChartLabels(
    revenueLabel: base.revenueLabel.replaceAll('هذا الأسبوع', periodStr),
    topItemsLabel: base.topItemsLabel,
    distributionLabel: base.distributionLabel,
    revenueTooltip: base.revenueTooltip,
    summaryLabel: base.summaryLabel,
    ordersTooltip: base.ordersTooltip,
  );
}

const Map<String, ChartLabels> _labelsMap = {
  'water_delivery': ChartLabels(
    revenueLabel: 'الإيرادات والطلبات — هذا الأسبوع',
    topItemsLabel: 'المنتجات الأكثر طلباً',
    distributionLabel: 'توزيع الطلبات حسب المنطقة',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الطلبات',
  ),
  'restaurant': ChartLabels(
    revenueLabel: 'الإيرادات والطلبات — هذا الأسبوع',
    topItemsLabel: 'الأصناف الأكثر طلباً',
    distributionLabel: 'نوع الطلب',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الطلبات',
  ),
  'salon': ChartLabels(
    revenueLabel: 'الإيرادات والحجوزات — هذا الأسبوع',
    topItemsLabel: 'الخدمات الأكثر حجزاً',
    distributionLabel: 'نوع العملاء',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الحجوزات',
  ),
  'plumber': ChartLabels(
    revenueLabel: 'الإيرادات والأعمال — هذا الأسبوع',
    topItemsLabel: 'أنواع الأعمال الأكثر طلباً',
    distributionLabel: 'توزيع أنواع الأعمال',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الأعمال',
  ),
  'government': ChartLabels(
    revenueLabel: 'الوصول والتنبيهات — هذا الأسبوع',
    topItemsLabel: 'التنبيهات الأعلى وصولاً',
    distributionLabel: 'توزيع أنواع التنبيهات',
    revenueTooltip: 'المشاهدات',
    summaryLabel: 'المشاهدات',
    ordersTooltip: 'التنبيهات',
  ),
  'villa_rental': ChartLabels(
    revenueLabel: 'الإيرادات والحجوزات — هذا الأسبوع',
    topItemsLabel: 'نوع الضيوف الأكثر حجزاً',
    distributionLabel: 'توزيع الحجوزات',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الحجوزات',
  ),
  // ── menu_order ──
  'cafe': ChartLabels(
    revenueLabel: 'الإيرادات والطلبات — هذا الأسبوع',
    topItemsLabel: 'المشروبات الأكثر طلباً',
    distributionLabel: 'نوع الطلب',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الطلبات',
  ),
  'bakery': ChartLabels(
    revenueLabel: 'الإيرادات والطلبات — هذا الأسبوع',
    topItemsLabel: 'المعجنات الأكثر طلباً',
    distributionLabel: 'نوع المنتج',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الطلبات',
  ),
  'juice_bar': ChartLabels(
    revenueLabel: 'الإيرادات والطلبات — هذا الأسبوع',
    topItemsLabel: 'العصائر الأكثر طلباً',
    distributionLabel: 'نوع المشروب',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الطلبات',
  ),
  // ── service_booking ──
  'clinic': ChartLabels(
    revenueLabel: 'الإيرادات والزيارات — هذا الأسبوع',
    topItemsLabel: 'الخدمات الأكثر طلباً',
    distributionLabel: 'نوع العملاء',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الزيارات',
  ),
  'gym': ChartLabels(
    revenueLabel: 'الإيرادات والاشتراكات — هذا الأسبوع',
    topItemsLabel: 'الخدمات الأكثر طلباً',
    distributionLabel: 'نوع الأعضاء',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الاشتراكات',
  ),
  'car_wash': ChartLabels(
    revenueLabel: 'الإيرادات والخدمات — هذا الأسبوع',
    topItemsLabel: 'الخدمات الأكثر طلباً',
    distributionLabel: 'نوع الخدمة',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الخدمات',
  ),
  'laundry': ChartLabels(
    revenueLabel: 'الإيرادات والطلبات — هذا الأسبوع',
    topItemsLabel: 'الخدمات الأكثر طلباً',
    distributionLabel: 'نوع الخدمة',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الطلبات',
  ),
  'oil_change': ChartLabels(
    revenueLabel: 'الإيرادات والخدمات — هذا الأسبوع',
    topItemsLabel: 'الخدمات الأكثر طلباً',
    distributionLabel: 'نوع الخدمة',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الخدمات',
  ),
  'tailor': ChartLabels(
    revenueLabel: 'الإيرادات والطلبات — هذا الأسبوع',
    topItemsLabel: 'الخدمات الأكثر طلباً',
    distributionLabel: 'نوع الخدمة',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الطلبات',
  ),
  'shoe_repair': ChartLabels(
    revenueLabel: 'الإيرادات والطلبات — هذا الأسبوع',
    topItemsLabel: 'الخدمات الأكثر طلباً',
    distributionLabel: 'نوع الخدمة',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الطلبات',
  ),
  'mobile_repair': ChartLabels(
    revenueLabel: 'الإيرادات والإصلاحات — هذا الأسبوع',
    topItemsLabel: 'الخدمات الأكثر طلباً',
    distributionLabel: 'نوع الإصلاح',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الإصلاحات',
  ),
  'watch_repair': ChartLabels(
    revenueLabel: 'الإيرادات والإصلاحات — هذا الأسبوع',
    topItemsLabel: 'الخدمات الأكثر طلباً',
    distributionLabel: 'نوع الإصلاح',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الإصلاحات',
  ),
  'tire_shop': ChartLabels(
    revenueLabel: 'الإيرادات والخدمات — هذا الأسبوع',
    topItemsLabel: 'الخدمات الأكثر طلباً',
    distributionLabel: 'نوع الخدمة',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الخدمات',
  ),
  // ── catalog_order ──
  'gas_delivery': ChartLabels(
    revenueLabel: 'الإيرادات والطلبات — هذا الأسبوع',
    topItemsLabel: 'المنتجات الأكثر طلباً',
    distributionLabel: 'توزيع الطلبات حسب المنطقة',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الطلبات',
  ),
  'clothes_store': ChartLabels(
    revenueLabel: 'الإيرادات والطلبات — هذا الأسبوع',
    topItemsLabel: 'المنتجات الأكثر مبيعاً',
    distributionLabel: 'توزيع المبيعات',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الطلبات',
  ),
  'online_store': ChartLabels(
    revenueLabel: 'الإيرادات والطلبات — هذا الأسبوع',
    topItemsLabel: 'المنتجات الأكثر مبيعاً',
    distributionLabel: 'توزيع الطلبات حسب المنطقة',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الطلبات',
  ),
  'mini_market': ChartLabels(
    revenueLabel: 'الإيرادات والطلبات — هذا الأسبوع',
    topItemsLabel: 'المنتجات الأكثر طلباً',
    distributionLabel: 'توزيع الطلبات حسب المنطقة',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الطلبات',
  ),
  'butcher': ChartLabels(
    revenueLabel: 'الإيرادات والطلبات — هذا الأسبوع',
    topItemsLabel: 'المنتجات الأكثر طلباً',
    distributionLabel: 'توزيع المبيعات',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الطلبات',
  ),
  'produce': ChartLabels(
    revenueLabel: 'الإيرادات والطلبات — هذا الأسبوع',
    topItemsLabel: 'المنتجات الأكثر طلباً',
    distributionLabel: 'توزيع المبيعات',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الطلبات',
  ),
  'pharmacy': ChartLabels(
    revenueLabel: 'الإيرادات والطلبات — هذا الأسبوع',
    topItemsLabel: 'المنتجات الأكثر طلباً',
    distributionLabel: 'توزيع المبيعات',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الطلبات',
  ),
  'electronics_store': ChartLabels(
    revenueLabel: 'الإيرادات والطلبات — هذا الأسبوع',
    topItemsLabel: 'المنتجات الأكثر مبيعاً',
    distributionLabel: 'توزيع المبيعات',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الطلبات',
  ),
  // ── portfolio_inquiry ──
  'photographer': ChartLabels(
    revenueLabel: 'الإيرادات والاستفسارات — هذا الأسبوع',
    topItemsLabel: 'أنواع الجلسات الأكثر طلباً',
    distributionLabel: 'توزيع أنواع الجلسات',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الاستفسارات',
  ),
  // ── reservation ──
  'event_venue': ChartLabels(
    revenueLabel: 'الإيرادات والحجوزات — هذا الأسبوع',
    topItemsLabel: 'نوع الفعاليات الأكثر حجزاً',
    distributionLabel: 'توزيع الفعاليات',
    revenueTooltip: 'الإيرادات (د.أ)',
    summaryLabel: 'الإيرادات',
    ordersTooltip: 'الحجوزات',
  ),
  // ── follow_only ──
  'bank': ChartLabels(
    revenueLabel: 'الوصول والتفاعل — هذا الأسبوع',
    topItemsLabel: 'المنشورات الأعلى وصولاً',
    distributionLabel: 'توزيع أنواع المنشورات',
    revenueTooltip: 'المشاهدات',
    summaryLabel: 'المشاهدات',
    ordersTooltip: 'المنشورات',
  ),
  // ── directory ──
  'directory': ChartLabels(
    revenueLabel: 'المشاهدات والتفاعل — هذا الأسبوع',
    topItemsLabel: 'المتاجر الأكثر زيارة',
    distributionLabel: 'توزيع الزيارات',
    revenueTooltip: 'المشاهدات',
    summaryLabel: 'المشاهدات',
    ordersTooltip: 'الزيارات',
  ),
};
