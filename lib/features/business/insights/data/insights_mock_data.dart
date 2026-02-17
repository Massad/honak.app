import 'dart:ui';

import 'package:honak/features/business/insights/domain/entities/insight_entities.dart';
import 'package:honak/features/business/insights/domain/insight_chart_config.dart';

/// Arabic period labels for mock data (simulates server responses).
String _periodLabelAr(InsightPeriod period) => switch (period) {
      InsightPeriod.week => 'هذا الأسبوع',
      InsightPeriod.month => 'هذا الشهر',
      InsightPeriod.year => 'هذه السنة',
    };

String _comparisonLabelAr(InsightPeriod period) => switch (period) {
      InsightPeriod.week => 'مقارنة بالأسبوع الماضي',
      InsightPeriod.month => 'مقارنة بالشهر الماضي',
      InsightPeriod.year => 'مقارنة بالسنة الماضية',
    };

/// Generates mock insights data for a business type + period.
InsightsData generateMockInsights({
  required String pageId,
  required String businessType,
  required String archetype,
  required InsightPeriod period,
}) {
  final labels = getChartLabels(businessType, period);
  final generator = _typeGenerators[businessType] ?? _fallbackGenerator;
  return generator(pageId, businessType, archetype, period, labels);
}

// ═══════════════════════════════════════════════════════════════
// Type-specific generators
// ═══════════════════════════════════════════════════════════════

typedef _Generator = InsightsData Function(
  String pageId,
  String businessType,
  String archetype,
  InsightPeriod period,
  ChartLabels labels,
);

final Map<String, _Generator> _typeGenerators = {
  // Existing (6)
  'water_delivery': _waterDelivery,
  'restaurant': _restaurant,
  'salon': _salon,
  'plumber': _plumber,
  'villa_rental': _villaRental,
  'government': _government,
  // menu_order (3)
  'cafe': _cafe,
  'bakery': _bakery,
  'juice_bar': _juiceBar,
  // service_booking (10)
  'clinic': _clinic,
  'gym': _gym,
  'car_wash': _carWash,
  'laundry': _laundry,
  'oil_change': _oilChange,
  'tailor': _tailor,
  'shoe_repair': _shoeRepair,
  'mobile_repair': _mobileRepair,
  'watch_repair': _watchRepair,
  'tire_shop': _tireShop,
  // catalog_order (8)
  'gas_delivery': _gasDelivery,
  'clothes_store': _clothesStore,
  'online_store': _onlineStore,
  'mini_market': _miniMarket,
  'butcher': _butcher,
  'produce': _produce,
  'pharmacy': _pharmacy,
  'electronics_store': _electronicsStore,
  // portfolio_inquiry (1)
  'photographer': _photographer,
  // reservation (1)
  'event_venue': _eventVenue,
  // follow_only (1)
  'bank': _bank,
  // directory (1)
  'directory': _directory,
};

// ── Revenue data helper ───────────────────────────────────────

const _weekDays = ['سبت', 'أحد', 'اثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة'];
const _monthWeeks = ['الأسبوع ١', 'الأسبوع ٢', 'الأسبوع ٣', 'الأسبوع ٤'];
const _yearMonths = [
  'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
  'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
];

List<String> _labelsForPeriod(InsightPeriod period) => switch (period) {
      InsightPeriod.week => _weekDays,
      InsightPeriod.month => _monthWeeks,
      InsightPeriod.year => _yearMonths,
    };

// ── Period multiplier for KPI values ──────────────────────────

double _periodMultiplier(InsightPeriod period) => switch (period) {
      InsightPeriod.week => 1.0,
      InsightPeriod.month => 4.2,
      InsightPeriod.year => 52.0,
    };

// ── Color constants ───────────────────────────────────────────

const _primary = Color(0xFF1A73E8);
const _primaryLight = Color(0xFF4DA3FF);
const _primaryLighter = Color(0xFF93C5FD);
const _primaryLightest = Color(0xFFBFDBFE);
const _error = Color(0xFFE53935);
const _warning = Color(0xFFFF9800);

// ═══════════════════════════════════════════════════════════════
// Water Delivery
// ═══════════════════════════════════════════════════════════════

InsightsData _waterDelivery(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId,
    businessType: type,
    archetype: archetype,
    period: period.name,
    periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات ${_periodLabelAr(period)}', value: '${(450 * m).toInt()} د.أ', change: '+٠٨٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'orders', label: 'الطلبات ${_periodLabelAr(period)}', value: '${(85 * m).toInt()}', change: '+١٢٪', trend: TrendDirection.up, icon: 'package'),
        InsightCardData(id: 'avg_order', label: 'متوسط الطلب', value: '٥.٣ د.أ', change: '+٠٣٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'active_customers', label: 'العملاء النشطين', value: '${(120 * m ~/ 4).toInt()}', change: '+٥', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'الاحتفاظ بالعملاء', cards: [
        InsightCardData(id: 'reorder_rate', label: 'نسبة إعادة الطلب', value: '٧٨٪', change: '+٥٪', trend: TrendDirection.up, icon: 'repeat'),
        InsightCardData(id: 'churned', label: 'عملاء فقدتهم هذا الشهر', value: '٣', change: '−١', trend: TrendDirection.down, icon: 'user-minus'),
        InsightCardData(id: 'new_customers', label: 'عملاء جدد هذا الشهر', value: '١٢', change: '+٤', trend: TrendDirection.up, icon: 'user-plus'),
      ]),
      InsightSectionData(title: 'التوصيل', cards: [
        InsightCardData(id: 'delivery_time', label: 'معدل وقت التوصيل', value: '٣٥ دقيقة', change: '−٥ د', trend: TrendDirection.up, icon: 'clock'),
        InsightCardData(id: 'top_zone', label: 'المنطقة الأكثر طلباً', value: 'عبدون', icon: 'map-pin'),
        InsightCardData(id: 'on_time', label: 'نسبة التوصيل في الوقت', value: '٩٢٪', change: '+٣٪', trend: TrendDirection.up, icon: 'truck'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel,
      summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+٢٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 45, 80, 9, 15, subscriptions: true),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'قارورة ١٩ لتر', count: 320, unit: 'طلب'),
      TopItemDataPoint(name: 'موزع ٥ جالون', count: 180, unit: 'طلب'),
      TopItemDataPoint(name: 'برادة (إيجار)', count: 45, unit: 'طلب'),
    ]),
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'عبدون', value: 35, color: _primary),
      DistributionDataPoint(name: 'خلدا', value: 28, color: _primaryLight),
      DistributionDataPoint(name: 'الصويفية', value: 22, color: _primaryLighter),
      DistributionDataPoint(name: 'دابوق', value: 15, color: _primaryLightest),
    ]),
    tips: const [
      'نصيحة: العملاء الذين يطلبون ٤+ قوارير لديهم نسبة احتفاظ أعلى بـ ٣٥٪',
      'فكرة: أنشئ عرض "بطاقة الولاء" — اشترِ ١٠ واحصل على ٢ مجاناً',
      'تنبيه: ٣ عملاء لم يطلبوا منذ أسبوعين — أرسل لهم رسالة تذكير',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Restaurant
// ═══════════════════════════════════════════════════════════════

InsightsData _restaurant(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId,
    businessType: type,
    archetype: archetype,
    period: period.name,
    periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات ${_periodLabelAr(period)}', value: '${(2350 * m).toInt()} د.أ', change: '+٠٨٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'orders', label: 'الطلبات', value: '${(530 * m).toInt()}', change: '+١٢٪', trend: TrendDirection.up, icon: 'utensils'),
        InsightCardData(id: 'avg_order', label: 'متوسط الطلب', value: '٨.٥ د.أ', change: '+٥٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'active_customers', label: 'العملاء النشطين', value: '${(890 * m ~/ 4).toInt()}', change: '+٤٥', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'الأصناف الأكثر طلباً', cards: [
        InsightCardData(id: 'top1', label: '#1 منسف أردني', value: '١٢٠ طلب', icon: 'crown'),
        InsightCardData(id: 'top2', label: '#2 شاورما', value: '٩٨ طلب', icon: 'flame'),
        InsightCardData(id: 'top3', label: '#3 مشاوي', value: '٧٥ طلب', icon: 'package'),
      ]),
      InsightSectionData(title: 'الكفاءة', cards: [
        InsightCardData(id: 'prep_time', label: 'معدل وقت التحضير', value: '١٨ دقيقة', change: '+٢ د', trend: TrendDirection.down, icon: 'clock'),
        InsightCardData(id: 'peak_hour', label: 'ساعة الذروة', value: '١-٢ م', icon: 'activity'),
        InsightCardData(id: 'delivery_vs_pickup', label: 'توصيل مقابل استلام', value: '٦٥٪ / ٣٥٪', icon: 'truck'),
      ]),
      InsightSectionData(title: 'الاحتفاظ بالعملاء', cards: [
        InsightCardData(id: 'return_rate', label: 'نسبة العودة', value: '٦٥٪', change: '+٣٪', trend: TrendDirection.up, icon: 'repeat'),
        InsightCardData(id: 'churned', label: 'عملاء فقدتهم', value: '١٥', change: '+٢', trend: TrendDirection.down, icon: 'user-minus'),
        InsightCardData(id: 'new_customers', label: 'عملاء جدد', value: '٨٩', change: '+١٢', trend: TrendDirection.up, icon: 'user-plus'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel,
      summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+٨٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 250, 500, 58, 99),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'منسف أردني', count: 120, unit: 'طلب'),
      TopItemDataPoint(name: 'شاورما سوبر', count: 98, unit: 'طلب'),
      TopItemDataPoint(name: 'مشاوي مشكلة', count: 75, unit: 'طلب'),
      TopItemDataPoint(name: 'حمص باللحمة', count: 60, unit: 'طلب'),
      TopItemDataPoint(name: 'فتوش', count: 45, unit: 'طلب'),
    ]),
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'توصيل', value: 65, color: _primary),
      DistributionDataPoint(name: 'استلام', value: 25, color: _primaryLight),
      DistributionDataPoint(name: 'داخل المطعم', value: 10, color: _primaryLighter),
    ]),
    tips: const [
      'نصيحة: الطلبات ترتفع ٤٠٪ أيام الجمعة — جهّز مخزون إضافي',
      'فكرة: أضف "عرض اليوم" — المطاعم التي تستخدمه تحقق +٢٥٪ طلبات',
      'تنبيه: معدل التحضير ارتفع ٢ دقيقة — راجع عمليات المطبخ',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Salon
// ═══════════════════════════════════════════════════════════════

InsightsData _salon(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId,
    businessType: type,
    archetype: archetype,
    period: period.name,
    periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات', value: '${(780 * m).toInt()} د.أ', change: '+١٠٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'bookings', label: 'الحجوزات', value: '${(45 * m).toInt()}', change: '+٨٪', trend: TrendDirection.up, icon: 'calendar'),
        InsightCardData(id: 'avg_bill', label: 'متوسط الفاتورة', value: '١٧.٣ د.أ', change: '+٢٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'customers', label: 'العملاء', value: '${(185 * m ~/ 4).toInt()}', change: '+١٥', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'الخدمات الأكثر طلباً', cards: [
        InsightCardData(id: 'top1', label: 'صبغة شعر', value: '١٨ حجز', icon: 'crown'),
        InsightCardData(id: 'top2', label: 'قص شعر', value: '١٥ حجز', icon: 'scissors'),
        InsightCardData(id: 'top3', label: 'عناية بالبشرة', value: '١٢ حجز', icon: 'sparkles'),
      ]),
      InsightSectionData(title: 'الجدولة', cards: [
        InsightCardData(id: 'busiest_day', label: 'أكثر يوم حجوزات', value: 'السبت', icon: 'calendar'),
        InsightCardData(id: 'peak_hour', label: 'ساعة الذروة', value: '١٠-١١ ص', icon: 'activity'),
        InsightCardData(id: 'no_show', label: 'نسبة عدم الحضور', value: '٨٪', change: '−٢٪', trend: TrendDirection.up, icon: 'user-minus'),
        InsightCardData(id: 'wait_time', label: 'معدل الانتظار', value: '١٢ دقيقة', change: '−٣ د', trend: TrendDirection.up, icon: 'clock'),
      ]),
      InsightSectionData(title: 'الاحتفاظ بالعملاء', cards: [
        InsightCardData(id: 'return_rate', label: 'نسبة العودة', value: '٨٥٪', change: '+٤٪', trend: TrendDirection.up, icon: 'repeat'),
        InsightCardData(id: 'churned', label: 'عملاء فقدتهم', value: '٥', change: '−١', trend: TrendDirection.up, icon: 'user-minus'),
        InsightCardData(id: 'new_customers', label: 'عملاء جدد', value: '٢٨', change: '+٨', trend: TrendDirection.up, icon: 'user-plus'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel,
      summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+١٠٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 80, 140, 4, 8),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'صبغة شعر', count: 18, unit: 'حجز'),
      TopItemDataPoint(name: 'قص شعر', count: 15, unit: 'حجز'),
      TopItemDataPoint(name: 'عناية بالبشرة', count: 12, unit: 'حجز'),
      TopItemDataPoint(name: 'تسريحة شعر', count: 8, unit: 'حجز'),
    ]),
    distribution: null, // service_booking skips distribution
    tips: const [
      'نصيحة: ٨٥٪ من عملائك يعودون — قدّم باقة ولاء لتعزيز الاحتفاظ',
      'فكرة: أضف خدمة "الباقة الشهرية" — الصالونات التي تقدمها تحقق +٣٠٪ إيرادات',
      'تنبيه: يوم السبت هو الأكثر ازدحاماً — فكّر بإضافة موظف إضافي',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Plumber
// ═══════════════════════════════════════════════════════════════

InsightsData _plumber(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId,
    businessType: type,
    archetype: archetype,
    period: period.name,
    periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات هذا الشهر', value: '${(2500 * m ~/ 4).toInt()} د.أ', change: '+١٥٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'jobs', label: 'أعمال', value: '${(30 * m ~/ 4).toInt()}', change: '+٥', trend: TrendDirection.up, icon: 'wrench'),
        InsightCardData(id: 'avg_job', label: 'متوسط قيمة العمل', value: '٨٣.٣ د.أ', change: '+١٠٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'contacts', label: 'عملاء تواصلوا', value: '${(50 * m ~/ 4).toInt()}', change: '+٨', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'سرعة الاستجابة', cards: [
        InsightCardData(id: 'response_time', label: 'معدل وقت الرد', value: '٤٥ دقيقة', change: '−١٠ د', trend: TrendDirection.up, icon: 'clock'),
        InsightCardData(id: 'conversion', label: 'نسبة تحويل العروض', value: '٧٢٪', change: '+٥٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'emergency', label: 'أعمال طوارئ', value: '٨', icon: 'alert-circle'),
      ]),
      InsightSectionData(title: 'أنواع الأعمال', cards: [
        InsightCardData(id: 'leaks', label: 'إصلاح تسريبات', value: '١٢ عمل', icon: 'droplets'),
        InsightCardData(id: 'heaters', label: 'تركيب سخانات', value: '٨ أعمال', icon: 'flame'),
        InsightCardData(id: 'drains', label: 'تسليك مجاري', value: '١٠ أعمال', icon: 'wrench'),
      ]),
      InsightSectionData(title: 'منطقة الخدمة', cards: [
        InsightCardData(id: 'top_area', label: 'المنطقة الأكثر طلباً', value: 'خلدا', icon: 'map-pin'),
        InsightCardData(id: 'areas_covered', label: 'مناطق مغطاة', value: '٨ مناطق', icon: 'map-pin'),
        InsightCardData(id: 'repeat_customers', label: 'عملاء متكررون', value: '٤٥٪', change: '+٨٪', trend: TrendDirection.up, icon: 'repeat'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel,
      summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+١٥٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 45, 200, 1, 4),
    ),
    topItems: null, // quote_request skips ranked list
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'إصلاحات', value: 55, color: _primary),
      DistributionDataPoint(name: 'تركيبات', value: 30, color: _primaryLight),
      DistributionDataPoint(name: 'طوارئ', value: 15, color: _error),
    ]),
    tips: const [
      'نصيحة: سرعة الرد هي العامل الأول — ردّك خلال ٤٥ دقيقة يزيد التحويل بـ ٤٠٪',
      'فكرة: أضف صور أعمال سابقة — الصفحات التي تعرض أعمالها تحصل على +٥٠٪ طلبات',
      'تنبيه: ٨ أعمال طوارئ هذا الشهر — فكّر بإضافة رسوم خدمة طوارئ',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Villa Rental
// ═══════════════════════════════════════════════════════════════

InsightsData _villaRental(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId,
    businessType: type,
    archetype: archetype,
    period: period.name,
    periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'occupancy', label: 'نسبة الإشغال', value: '٧٢٪', change: '+٥٪', trend: TrendDirection.up, icon: 'home'),
        InsightCardData(id: 'bookings', label: 'حجوزات', value: '${(18 * m).toInt()}', change: '+٣', trend: TrendDirection.up, icon: 'calendar'),
        InsightCardData(id: 'avg_stay', label: 'معدل مدة الإقامة', value: '٢.٥ ليلة', icon: 'moon'),
        InsightCardData(id: 'revenue', label: 'الإيرادات', value: '${(4500 * m).toInt()} د.أ', change: '+١٢٪', trend: TrendDirection.up, icon: 'banknote'),
      ]),
      InsightSectionData(title: 'أداء الحجوزات', cards: [
        InsightCardData(id: 'weekend', label: 'نهاية الأسبوع', value: '٩٥٪', change: '+٣٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'weekday', label: 'أيام الأسبوع', value: '٤٥٪', change: '+٨٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'repeat_guests', label: 'ضيوف متكررون', value: '٣٢٪', change: '+٥٪', trend: TrendDirection.up, icon: 'repeat'),
      ]),
      InsightSectionData(title: 'الضيوف', cards: [
        InsightCardData(id: 'guests_month', label: 'ضيوف هذا الشهر', value: '${(85 * m ~/ 4).toInt()}', change: '+١٢', trend: TrendDirection.up, icon: 'users'),
        InsightCardData(id: 'avg_guests', label: 'معدل عدد الضيوف', value: '٦', icon: 'users'),
        InsightCardData(id: 'new_guests', label: 'ضيوف جدد', value: '${(40 * m ~/ 4).toInt()}', change: '+٨', trend: TrendDirection.up, icon: 'user-plus'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel,
      summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+١٢٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 0, 600, 0, 3),
    ),
    topItems: null, // reservation skips ranked list
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'نهاية الأسبوع', value: 65, color: _primary),
      DistributionDataPoint(name: 'أيام الأسبوع', value: 25, color: _primaryLight),
      DistributionDataPoint(name: 'أعياد ومناسبات', value: 10, color: _warning),
    ]),
    tips: const [
      'نصيحة: نهاية الأسبوع تشكل ٦٥٪ من حجوزاتك — فكّر بأسعار تنافسية لأيام الأسبوع',
      'فكرة: أضف صور ٣٦٠ للفيلا — العقارات بصور شاملة تحقق +٤٠٪ حجوزات',
      'تنبيه: ٣ استفسارات لم يُرد عليها — سرعة الرد تزيد التحويل بـ ٥٥٪',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Government
// ═══════════════════════════════════════════════════════════════

InsightsData _government(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId,
    businessType: type,
    archetype: archetype,
    period: period.name,
    periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'التفاعل', cards: [
        InsightCardData(id: 'reach', label: 'الوصول', value: '${(2400 * m).toInt()}', change: '+١٨٪', trend: TrendDirection.up, icon: 'eye'),
        InsightCardData(id: 'new_followers', label: 'متابعون جدد', value: '${(245 * m ~/ 4).toInt()}', change: '+٣٢', trend: TrendDirection.up, icon: 'users'),
        InsightCardData(id: 'alerts_sent', label: 'تنبيهات مرسلة', value: '${(8 * m ~/ 4).toInt()}', icon: 'bell'),
        InsightCardData(id: 'read_rate', label: 'نسبة القراءة', value: '٧٨٪', change: '+٥٪', trend: TrendDirection.up, icon: 'check-circle'),
      ]),
      InsightSectionData(title: 'المنشورات', cards: [
        InsightCardData(id: 'posts', label: 'منشورات هذا الشهر', value: '٠٤', icon: 'file-text'),
        InsightCardData(id: 'avg_views', label: 'متوسط المشاهدات', value: '٣,٢٠٠', change: '+١٥٪', trend: TrendDirection.up, icon: 'trending-up'),
      ]),
    ],
    revenueChart: null, // follow_only has no revenue
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'تنبيه قطع مياه', count: 3200, unit: 'مشاهدة'),
      TopItemDataPoint(name: 'إغلاق طريق', count: 2800, unit: 'مشاهدة'),
      TopItemDataPoint(name: 'حملة نظافة', count: 1500, unit: 'مشاهدة'),
      TopItemDataPoint(name: 'مواعيد دفع', count: 1200, unit: 'مشاهدة'),
      TopItemDataPoint(name: 'صيانة إنارة', count: 900, unit: 'مشاهدة'),
    ]),
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'تنبيهات عاجلة', value: 25, color: _error),
      DistributionDataPoint(name: 'تنبيهات مهمة', value: 40, color: _warning),
      DistributionDataPoint(name: 'إعلامية', value: 35, color: _primary),
    ]),
    tips: const [
      'نصيحة: التنبيهات العاجلة تحقق نسبة قراءة أعلى بـ ٣x — استخدمها للأمور الطارئة فقط',
      'فكرة: أضف رابط الخدمة الإلكترونية مع كل تنبيه — يزيد التفاعل بـ ٤٥٪',
      'ملاحظة: أفضل وقت للنشر هو ٨-٩ صباحاً — نسبة الوصول أعلى بـ ٦٠٪',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Cafe (menu_order)
// ═══════════════════════════════════════════════════════════════

InsightsData _cafe(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات ${_periodLabelAr(period)}', value: '${(1200 * m).toInt()} د.أ', change: '+١٠٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'orders', label: 'الطلبات', value: '${(380 * m).toInt()}', change: '+١٥٪', trend: TrendDirection.up, icon: 'coffee'),
        InsightCardData(id: 'avg_order', label: 'متوسط الطلب', value: '٣.٢ د.أ', change: '+٤٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'active_customers', label: 'العملاء النشطين', value: '${(450 * m ~/ 4).toInt()}', change: '+٢٨', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'الأصناف الأكثر طلباً', cards: [
        InsightCardData(id: 'top1', label: '#1 قهوة عربية', value: '٩٥ طلب', icon: 'crown'),
        InsightCardData(id: 'top2', label: '#2 كابتشينو', value: '٨٢ طلب', icon: 'flame'),
        InsightCardData(id: 'top3', label: '#3 كيكة الجزر', value: '٤٥ طلب', icon: 'package'),
      ]),
      InsightSectionData(title: 'الكفاءة', cards: [
        InsightCardData(id: 'prep_time', label: 'معدل وقت التحضير', value: '٨ دقائق', change: '−١ د', trend: TrendDirection.up, icon: 'clock'),
        InsightCardData(id: 'peak_hour', label: 'ساعة الذروة', value: '٩-١٠ ص', icon: 'activity'),
        InsightCardData(id: 'dine_vs_take', label: 'جلوس مقابل سفري', value: '٤٥٪ / ٥٥٪', icon: 'truck'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+١٠٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 120, 250, 35, 70),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'قهوة عربية', count: 95, unit: 'طلب'),
      TopItemDataPoint(name: 'كابتشينو', count: 82, unit: 'طلب'),
      TopItemDataPoint(name: 'كيكة الجزر', count: 45, unit: 'طلب'),
      TopItemDataPoint(name: 'لاتيه', count: 38, unit: 'طلب'),
      TopItemDataPoint(name: 'سندويشة كلوب', count: 30, unit: 'طلب'),
    ]),
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'سفري', value: 55, color: _primary),
      DistributionDataPoint(name: 'جلوس', value: 35, color: _primaryLight),
      DistributionDataPoint(name: 'توصيل', value: 10, color: _primaryLighter),
    ]),
    tips: const [
      'نصيحة: ٥٥٪ من طلباتك سفري — وفّر أكواب وتغليف عالي الجودة',
      'فكرة: أضف "عرض الصباح" قبل ١٠ ص — المقاهي التي تقدمه تحقق +٢٠٪ مبيعات',
      'تنبيه: ساعة الذروة ٩-١٠ ص — تأكد من جاهزية فريق العمل',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Bakery (menu_order)
// ═══════════════════════════════════════════════════════════════

InsightsData _bakery(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات ${_periodLabelAr(period)}', value: '${(1800 * m).toInt()} د.أ', change: '+١٢٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'orders', label: 'الطلبات', value: '${(420 * m).toInt()}', change: '+١٠٪', trend: TrendDirection.up, icon: 'package'),
        InsightCardData(id: 'avg_order', label: 'متوسط الطلب', value: '٤.٣ د.أ', change: '+٣٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'active_customers', label: 'العملاء النشطين', value: '${(600 * m ~/ 4).toInt()}', change: '+٣٥', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'الأصناف الأكثر طلباً', cards: [
        InsightCardData(id: 'top1', label: '#1 كنافة نابلسية', value: '٨٥ طلب', icon: 'crown'),
        InsightCardData(id: 'top2', label: '#2 بقلاوة', value: '٧٠ طلب', icon: 'flame'),
        InsightCardData(id: 'top3', label: '#3 خبز عربي', value: '٦٠ طلب', icon: 'package'),
      ]),
      InsightSectionData(title: 'الكفاءة', cards: [
        InsightCardData(id: 'peak_hour', label: 'ساعة الذروة', value: '٧-٨ م', icon: 'activity'),
        InsightCardData(id: 'busiest_day', label: 'أكثر يوم مبيعات', value: 'الجمعة', icon: 'calendar'),
        InsightCardData(id: 'special_orders', label: 'طلبات خاصة', value: '١٨', icon: 'star'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+١٢٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 180, 350, 40, 80),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'كنافة نابلسية', count: 85, unit: 'طلب'),
      TopItemDataPoint(name: 'بقلاوة مشكلة', count: 70, unit: 'طلب'),
      TopItemDataPoint(name: 'خبز عربي', count: 60, unit: 'طلب'),
      TopItemDataPoint(name: 'كعكة شوكولا', count: 35, unit: 'طلب'),
      TopItemDataPoint(name: 'معمول تمر', count: 28, unit: 'طلب'),
    ]),
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'حلويات', value: 45, color: _primary),
      DistributionDataPoint(name: 'خبز ومعجنات', value: 35, color: _primaryLight),
      DistributionDataPoint(name: 'كيك وتورت', value: 20, color: _primaryLighter),
    ]),
    tips: const [
      'نصيحة: الكنافة أكثر صنف طلباً — وفّر كميات إضافية أيام الجمعة والسبت',
      'فكرة: أضف خدمة "طلب مسبق" للمناسبات — تزيد المبيعات بـ +٣٠٪',
      'تنبيه: ١٨ طلب خاص هذا الشهر — فكّر بإضافة قسم مخصص للطلبات الخاصة',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Juice Bar (menu_order)
// ═══════════════════════════════════════════════════════════════

InsightsData _juiceBar(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات ${_periodLabelAr(period)}', value: '${(650 * m).toInt()} د.أ', change: '+١٤٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'orders', label: 'الطلبات', value: '${(290 * m).toInt()}', change: '+١٨٪', trend: TrendDirection.up, icon: 'package'),
        InsightCardData(id: 'avg_order', label: 'متوسط الطلب', value: '٢.٢ د.أ', change: '+٥٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'active_customers', label: 'العملاء النشطين', value: '${(320 * m ~/ 4).toInt()}', change: '+٢٢', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'الأصناف الأكثر طلباً', cards: [
        InsightCardData(id: 'top1', label: '#1 عصير برتقال طازج', value: '٧٥ طلب', icon: 'crown'),
        InsightCardData(id: 'top2', label: '#2 كوكتيل فواكه', value: '٥٨ طلب', icon: 'flame'),
        InsightCardData(id: 'top3', label: '#3 سموذي مانجو', value: '٤٢ طلب', icon: 'package'),
      ]),
      InsightSectionData(title: 'الكفاءة', cards: [
        InsightCardData(id: 'prep_time', label: 'معدل وقت التحضير', value: '٥ دقائق', change: '−١ د', trend: TrendDirection.up, icon: 'clock'),
        InsightCardData(id: 'peak_hour', label: 'ساعة الذروة', value: '٣-٤ م', icon: 'activity'),
        InsightCardData(id: 'takeaway', label: 'نسبة السفري', value: '٨٥٪', icon: 'truck'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+١٤٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 60, 140, 25, 55),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'عصير برتقال طازج', count: 75, unit: 'طلب'),
      TopItemDataPoint(name: 'كوكتيل فواكه', count: 58, unit: 'طلب'),
      TopItemDataPoint(name: 'سموذي مانجو', count: 42, unit: 'طلب'),
      TopItemDataPoint(name: 'عصير جزر', count: 30, unit: 'طلب'),
      TopItemDataPoint(name: 'ميلك شيك فراولة', count: 22, unit: 'طلب'),
    ]),
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'عصائر طازجة', value: 50, color: _primary),
      DistributionDataPoint(name: 'كوكتيلات', value: 30, color: _primaryLight),
      DistributionDataPoint(name: 'سموذي', value: 20, color: _primaryLighter),
    ]),
    tips: const [
      'نصيحة: الطلب يرتفع ٣٥٪ بعد الظهر — جهّز الفواكه الطازجة مسبقاً',
      'فكرة: أضف "عرض الثنائي" (عصيرين بسعر مخفض) — يزيد متوسط الطلب بـ +٢٥٪',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Clinic (service_booking)
// ═══════════════════════════════════════════════════════════════

InsightsData _clinic(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات', value: '${(3200 * m).toInt()} د.أ', change: '+٧٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'patients', label: 'المرضى', value: '${(65 * m).toInt()}', change: '+١٠', trend: TrendDirection.up, icon: 'calendar'),
        InsightCardData(id: 'avg_visit', label: 'متوسط الزيارة', value: '٤٩.٢ د.أ', change: '+٣٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'new_patients', label: 'مرضى جدد', value: '${(22 * m ~/ 4).toInt()}', change: '+٨', trend: TrendDirection.up, icon: 'user-plus'),
      ]),
      InsightSectionData(title: 'الخدمات الأكثر طلباً', cards: [
        InsightCardData(id: 'top1', label: 'كشفية عامة', value: '٢٥ زيارة', icon: 'crown'),
        InsightCardData(id: 'top2', label: 'متابعة', value: '٢٠ زيارة', icon: 'repeat'),
        InsightCardData(id: 'top3', label: 'فحص شامل', value: '١٢ زيارة', icon: 'sparkles'),
      ]),
      InsightSectionData(title: 'الجدولة', cards: [
        InsightCardData(id: 'busiest_day', label: 'أكثر يوم حجوزات', value: 'الأحد', icon: 'calendar'),
        InsightCardData(id: 'no_show', label: 'نسبة عدم الحضور', value: '٦٪', change: '−٢٪', trend: TrendDirection.up, icon: 'user-minus'),
        InsightCardData(id: 'wait_time', label: 'معدل الانتظار', value: '١٥ دقيقة', change: '−٤ د', trend: TrendDirection.up, icon: 'clock'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+٧٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 350, 600, 6, 12),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'كشفية عامة', count: 25, unit: 'زيارة'),
      TopItemDataPoint(name: 'متابعة', count: 20, unit: 'زيارة'),
      TopItemDataPoint(name: 'فحص شامل', count: 12, unit: 'زيارة'),
      TopItemDataPoint(name: 'استشارة', count: 8, unit: 'زيارة'),
    ]),
    distribution: null,
    tips: const [
      'نصيحة: ٦٪ من المرضى لا يحضرون — أرسل تذكيراً قبل ٢٤ ساعة لتقليل النسبة',
      'فكرة: أضف خدمة "الاستشارة عن بُعد" — العيادات التي تقدمها تحقق +١٥٪ زيارات',
      'تنبيه: يوم الأحد الأكثر ازدحاماً — فكّر بتمديد ساعات العمل',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Gym (service_booking)
// ═══════════════════════════════════════════════════════════════

InsightsData _gym(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات', value: '${(2800 * m).toInt()} د.أ', change: '+٩٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'members', label: 'الأعضاء النشطين', value: '${(180 * m ~/ 4).toInt()}', change: '+١٢', trend: TrendDirection.up, icon: 'users'),
        InsightCardData(id: 'avg_sub', label: 'متوسط الاشتراك', value: '٣٥ د.أ', icon: 'trending-up'),
        InsightCardData(id: 'new_members', label: 'أعضاء جدد', value: '${(15 * m ~/ 4).toInt()}', change: '+٥', trend: TrendDirection.up, icon: 'user-plus'),
      ]),
      InsightSectionData(title: 'الخدمات الأكثر طلباً', cards: [
        InsightCardData(id: 'top1', label: 'اشتراك شهري', value: '٨٥ عضو', icon: 'crown'),
        InsightCardData(id: 'top2', label: 'تدريب شخصي', value: '٢٢ جلسة', icon: 'flame'),
        InsightCardData(id: 'top3', label: 'حصة جماعية', value: '١٨ جلسة', icon: 'sparkles'),
      ]),
      InsightSectionData(title: 'الحضور', cards: [
        InsightCardData(id: 'busiest_day', label: 'أكثر يوم حضوراً', value: 'الاثنين', icon: 'calendar'),
        InsightCardData(id: 'peak_hour', label: 'ساعة الذروة', value: '٥-٧ م', icon: 'activity'),
        InsightCardData(id: 'retention', label: 'نسبة تجديد الاشتراك', value: '٧٥٪', change: '+٣٪', trend: TrendDirection.up, icon: 'repeat'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+٩٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 300, 500, 20, 35),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'اشتراك شهري', count: 85, unit: 'عضو'),
      TopItemDataPoint(name: 'تدريب شخصي', count: 22, unit: 'جلسة'),
      TopItemDataPoint(name: 'حصة جماعية', count: 18, unit: 'جلسة'),
      TopItemDataPoint(name: 'اشتراك ٣ أشهر', count: 12, unit: 'عضو'),
    ]),
    distribution: null,
    tips: const [
      'نصيحة: ٧٥٪ يجددون اشتراكهم — قدّم خصم تجديد مبكر لرفع النسبة',
      'فكرة: أضف حصص جماعية صباحية — تجذب شريحة جديدة من العملاء',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Car Wash (service_booking)
// ═══════════════════════════════════════════════════════════════

InsightsData _carWash(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات', value: '${(950 * m).toInt()} د.أ', change: '+١١٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'vehicles', label: 'السيارات', value: '${(120 * m).toInt()}', change: '+١٥', trend: TrendDirection.up, icon: 'calendar'),
        InsightCardData(id: 'avg_service', label: 'متوسط الخدمة', value: '٧.٩ د.أ', change: '+٢٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'repeat', label: 'عملاء متكررون', value: '٦٨٪', change: '+٤٪', trend: TrendDirection.up, icon: 'repeat'),
      ]),
      InsightSectionData(title: 'الخدمات الأكثر طلباً', cards: [
        InsightCardData(id: 'top1', label: 'غسيل خارجي', value: '٦٥ سيارة', icon: 'crown'),
        InsightCardData(id: 'top2', label: 'غسيل كامل', value: '٣٥ سيارة', icon: 'flame'),
        InsightCardData(id: 'top3', label: 'تلميع', value: '٢٠ سيارة', icon: 'sparkles'),
      ]),
      InsightSectionData(title: 'الجدولة', cards: [
        InsightCardData(id: 'busiest_day', label: 'أكثر يوم', value: 'السبت', icon: 'calendar'),
        InsightCardData(id: 'peak_hour', label: 'ساعة الذروة', value: '١٠-١٢ ص', icon: 'activity'),
        InsightCardData(id: 'avg_time', label: 'معدل وقت الخدمة', value: '٢٥ دقيقة', change: '−٣ د', trend: TrendDirection.up, icon: 'clock'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+١١٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 100, 180, 12, 22),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'غسيل خارجي', count: 65, unit: 'سيارة'),
      TopItemDataPoint(name: 'غسيل كامل', count: 35, unit: 'سيارة'),
      TopItemDataPoint(name: 'تلميع', count: 20, unit: 'سيارة'),
    ]),
    distribution: null,
    tips: const [
      'نصيحة: ٦٨٪ من عملائك متكررون — قدّم بطاقة "الغسلة السادسة مجاناً"',
      'فكرة: أضف خدمة "غسيل متنقل" — تزيد الإيرادات بـ +٢٠٪',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Laundry (service_booking)
// ═══════════════════════════════════════════════════════════════

InsightsData _laundry(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات', value: '${(600 * m).toInt()} د.أ', change: '+٨٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'orders', label: 'الطلبات', value: '${(95 * m).toInt()}', change: '+١٠', trend: TrendDirection.up, icon: 'calendar'),
        InsightCardData(id: 'avg_order', label: 'متوسط الطلب', value: '٦.٣ د.أ', change: '+١٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'pieces', label: 'قطع مغسولة', value: '${(480 * m).toInt()}', change: '+٥٥', trend: TrendDirection.up, icon: 'package'),
      ]),
      InsightSectionData(title: 'الخدمات الأكثر طلباً', cards: [
        InsightCardData(id: 'top1', label: 'غسيل وكوي', value: '٥٠ طلب', icon: 'crown'),
        InsightCardData(id: 'top2', label: 'دراي كلين', value: '٢٨ طلب', icon: 'flame'),
        InsightCardData(id: 'top3', label: 'كوي فقط', value: '١٧ طلب', icon: 'package'),
      ]),
      InsightSectionData(title: 'الأداء', cards: [
        InsightCardData(id: 'turnaround', label: 'معدل وقت التسليم', value: '٢٤ ساعة', change: '−٢ س', trend: TrendDirection.up, icon: 'clock'),
        InsightCardData(id: 'repeat', label: 'عملاء متكررون', value: '٧٢٪', change: '+٣٪', trend: TrendDirection.up, icon: 'repeat'),
        InsightCardData(id: 'complaints', label: 'شكاوى', value: '١', change: '−٢', trend: TrendDirection.up, icon: 'alert-circle'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+٨٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 60, 120, 10, 18),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'غسيل وكوي', count: 50, unit: 'طلب'),
      TopItemDataPoint(name: 'دراي كلين', count: 28, unit: 'طلب'),
      TopItemDataPoint(name: 'كوي فقط', count: 17, unit: 'طلب'),
    ]),
    distribution: null,
    tips: const [
      'نصيحة: ٧٢٪ من عملائك متكررون — قدّم اشتراك شهري بسعر مخفض',
      'فكرة: أضف خدمة "استلام وتوصيل" — تزيد الطلبات بـ +٣٠٪',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Oil Change (service_booking)
// ═══════════════════════════════════════════════════════════════

InsightsData _oilChange(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات', value: '${(1100 * m).toInt()} د.أ', change: '+٦٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'services', label: 'الخدمات', value: '${(75 * m).toInt()}', change: '+٨', trend: TrendDirection.up, icon: 'calendar'),
        InsightCardData(id: 'avg_service', label: 'متوسط الخدمة', value: '١٤.٧ د.أ', change: '+٢٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'repeat', label: 'عملاء متكررون', value: '٥٥٪', change: '+٦٪', trend: TrendDirection.up, icon: 'repeat'),
      ]),
      InsightSectionData(title: 'الخدمات الأكثر طلباً', cards: [
        InsightCardData(id: 'top1', label: 'تغيير زيت', value: '٤٥ سيارة', icon: 'crown'),
        InsightCardData(id: 'top2', label: 'فلتر زيت + هواء', value: '٣٠ سيارة', icon: 'flame'),
        InsightCardData(id: 'top3', label: 'فحص شامل', value: '١٥ سيارة', icon: 'sparkles'),
      ]),
      InsightSectionData(title: 'الأداء', cards: [
        InsightCardData(id: 'avg_time', label: 'معدل وقت الخدمة', value: '٢٠ دقيقة', change: '−٣ د', trend: TrendDirection.up, icon: 'clock'),
        InsightCardData(id: 'busiest_day', label: 'أكثر يوم', value: 'السبت', icon: 'calendar'),
        InsightCardData(id: 'reminders', label: 'تذكيرات مرسلة', value: '٢٥', icon: 'bell'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+٦٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 120, 200, 8, 14),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'تغيير زيت', count: 45, unit: 'سيارة'),
      TopItemDataPoint(name: 'فلتر زيت + هواء', count: 30, unit: 'سيارة'),
      TopItemDataPoint(name: 'فحص شامل', count: 15, unit: 'سيارة'),
    ]),
    distribution: null,
    tips: const [
      'نصيحة: أرسل تذكير بعد ٥,٠٠٠ كم — يزيد نسبة العودة بـ ٤٠٪',
      'فكرة: أضف باقة "صيانة دورية" — تشمل زيت وفلتر وفحص بسعر مخفض',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Tailor (service_booking)
// ═══════════════════════════════════════════════════════════════

InsightsData _tailor(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات', value: '${(900 * m).toInt()} د.أ', change: '+٨٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'orders', label: 'الطلبات', value: '${(40 * m).toInt()}', change: '+٦', trend: TrendDirection.up, icon: 'calendar'),
        InsightCardData(id: 'avg_order', label: 'متوسط الطلب', value: '٢٢.٥ د.أ', change: '+٤٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'customers', label: 'العملاء', value: '${(55 * m ~/ 4).toInt()}', change: '+٨', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'الخدمات الأكثر طلباً', cards: [
        InsightCardData(id: 'top1', label: 'تقصير بنطلون', value: '١٥ طلب', icon: 'crown'),
        InsightCardData(id: 'top2', label: 'تعديل فستان', value: '١٠ طلبات', icon: 'flame'),
        InsightCardData(id: 'top3', label: 'خياطة ثوب', value: '٨ طلبات', icon: 'sparkles'),
      ]),
      InsightSectionData(title: 'الأداء', cards: [
        InsightCardData(id: 'turnaround', label: 'معدل وقت التسليم', value: '٣ أيام', change: '−١ يوم', trend: TrendDirection.up, icon: 'clock'),
        InsightCardData(id: 'repeat', label: 'عملاء متكررون', value: '٦٠٪', change: '+٥٪', trend: TrendDirection.up, icon: 'repeat'),
        InsightCardData(id: 'satisfaction', label: 'رضا العملاء', value: '٩٥٪', icon: 'star'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+٨٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 80, 170, 4, 8),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'تقصير بنطلون', count: 15, unit: 'طلب'),
      TopItemDataPoint(name: 'تعديل فستان', count: 10, unit: 'طلب'),
      TopItemDataPoint(name: 'خياطة ثوب', count: 8, unit: 'طلب'),
    ]),
    distribution: null,
    tips: const [
      'نصيحة: موسم الأعراس يرفع الطلب ٦٠٪ — استعد بمواد إضافية',
      'فكرة: أضف صور "قبل وبعد" للأعمال — تزيد الاستفسارات بـ +٣٥٪',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Shoe Repair (service_booking)
// ═══════════════════════════════════════════════════════════════

InsightsData _shoeRepair(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات', value: '${(350 * m).toInt()} د.أ', change: '+٥٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'orders', label: 'الطلبات', value: '${(55 * m).toInt()}', change: '+٧', trend: TrendDirection.up, icon: 'calendar'),
        InsightCardData(id: 'avg_order', label: 'متوسط الطلب', value: '٦.٤ د.أ', change: '+١٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'repeat', label: 'عملاء متكررون', value: '٥٠٪', change: '+٣٪', trend: TrendDirection.up, icon: 'repeat'),
      ]),
      InsightSectionData(title: 'الخدمات الأكثر طلباً', cards: [
        InsightCardData(id: 'top1', label: 'تغيير نعل', value: '٢٢ طلب', icon: 'crown'),
        InsightCardData(id: 'top2', label: 'خياطة حذاء', value: '١٥ طلب', icon: 'flame'),
        InsightCardData(id: 'top3', label: 'تلميع وتنظيف', value: '١٨ طلب', icon: 'sparkles'),
      ]),
      InsightSectionData(title: 'الأداء', cards: [
        InsightCardData(id: 'turnaround', label: 'معدل وقت التسليم', value: '٢ يوم', change: '−٤ س', trend: TrendDirection.up, icon: 'clock'),
        InsightCardData(id: 'busiest_day', label: 'أكثر يوم', value: 'الأحد', icon: 'calendar'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+٥٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 30, 70, 5, 10),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'تغيير نعل', count: 22, unit: 'طلب'),
      TopItemDataPoint(name: 'تلميع وتنظيف', count: 18, unit: 'طلب'),
      TopItemDataPoint(name: 'خياطة حذاء', count: 15, unit: 'طلب'),
    ]),
    distribution: null,
    tips: const [
      'نصيحة: أضف صور أعمال سابقة لبناء الثقة مع عملاء جدد',
      'فكرة: قدّم خدمة "تنظيف الحقائب" كخدمة إضافية',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Mobile Repair (service_booking)
// ═══════════════════════════════════════════════════════════════

InsightsData _mobileRepair(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات', value: '${(1500 * m).toInt()} د.أ', change: '+١٢٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'repairs', label: 'الإصلاحات', value: '${(60 * m).toInt()}', change: '+١٠', trend: TrendDirection.up, icon: 'calendar'),
        InsightCardData(id: 'avg_repair', label: 'متوسط الإصلاح', value: '٢٥ د.أ', change: '+٣٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'new_customers', label: 'عملاء جدد', value: '${(35 * m ~/ 4).toInt()}', change: '+١٢', trend: TrendDirection.up, icon: 'user-plus'),
      ]),
      InsightSectionData(title: 'الخدمات الأكثر طلباً', cards: [
        InsightCardData(id: 'top1', label: 'تبديل شاشة', value: '٢٨ جهاز', icon: 'crown'),
        InsightCardData(id: 'top2', label: 'تبديل بطارية', value: '١٨ جهاز', icon: 'flame'),
        InsightCardData(id: 'top3', label: 'إصلاح سوفتوير', value: '١٤ جهاز', icon: 'sparkles'),
      ]),
      InsightSectionData(title: 'الأداء', cards: [
        InsightCardData(id: 'turnaround', label: 'معدل وقت الإصلاح', value: '٤٥ دقيقة', change: '−١٠ د', trend: TrendDirection.up, icon: 'clock'),
        InsightCardData(id: 'warranty_returns', label: 'مرتجعات الضمان', value: '٢٪', change: '−١٪', trend: TrendDirection.up, icon: 'alert-circle'),
        InsightCardData(id: 'busiest_day', label: 'أكثر يوم', value: 'السبت', icon: 'calendar'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+١٢٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 150, 280, 6, 12),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'تبديل شاشة', count: 28, unit: 'جهاز'),
      TopItemDataPoint(name: 'تبديل بطارية', count: 18, unit: 'جهاز'),
      TopItemDataPoint(name: 'إصلاح سوفتوير', count: 14, unit: 'جهاز'),
    ]),
    distribution: null,
    tips: const [
      'نصيحة: تبديل الشاشات أكثر خدمة — وفّر مخزون شاشات للموديلات الشائعة',
      'فكرة: أضف خدمة "فحص مجاني" — تجذب عملاء جدد وتبني الثقة',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Watch Repair (service_booking)
// ═══════════════════════════════════════════════════════════════

InsightsData _watchRepair(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات', value: '${(420 * m).toInt()} د.أ', change: '+٤٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'repairs', label: 'الإصلاحات', value: '${(30 * m).toInt()}', change: '+٥', trend: TrendDirection.up, icon: 'calendar'),
        InsightCardData(id: 'avg_repair', label: 'متوسط الإصلاح', value: '١٤ د.أ', change: '+٢٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'repeat', label: 'عملاء متكررون', value: '٤٥٪', change: '+٣٪', trend: TrendDirection.up, icon: 'repeat'),
      ]),
      InsightSectionData(title: 'الخدمات الأكثر طلباً', cards: [
        InsightCardData(id: 'top1', label: 'تبديل بطارية', value: '١٥ ساعة', icon: 'crown'),
        InsightCardData(id: 'top2', label: 'تبديل سير', value: '٨ ساعات', icon: 'flame'),
        InsightCardData(id: 'top3', label: 'صيانة كاملة', value: '٧ ساعات', icon: 'sparkles'),
      ]),
      InsightSectionData(title: 'الأداء', cards: [
        InsightCardData(id: 'turnaround', label: 'معدل وقت الإصلاح', value: '١ يوم', icon: 'clock'),
        InsightCardData(id: 'busiest_day', label: 'أكثر يوم', value: 'الثلاثاء', icon: 'calendar'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+٤٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 40, 80, 3, 6),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'تبديل بطارية', count: 15, unit: 'ساعة'),
      TopItemDataPoint(name: 'تبديل سير', count: 8, unit: 'ساعة'),
      TopItemDataPoint(name: 'صيانة كاملة', count: 7, unit: 'ساعة'),
    ]),
    distribution: null,
    tips: const [
      'نصيحة: وفّر بطاريات للماركات الشائعة — أكثر خدمة طلباً',
      'فكرة: أضف خدمة "تقييم مجاني" لساعات قديمة — تجذب هواة الساعات',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Tire Shop (service_booking)
// ═══════════════════════════════════════════════════════════════

InsightsData _tireShop(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات', value: '${(1400 * m).toInt()} د.أ', change: '+٧٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'services', label: 'الخدمات', value: '${(80 * m).toInt()}', change: '+١٠', trend: TrendDirection.up, icon: 'calendar'),
        InsightCardData(id: 'avg_service', label: 'متوسط الخدمة', value: '١٧.٥ د.أ', change: '+٣٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'repeat', label: 'عملاء متكررون', value: '٥٨٪', change: '+٤٪', trend: TrendDirection.up, icon: 'repeat'),
      ]),
      InsightSectionData(title: 'الخدمات الأكثر طلباً', cards: [
        InsightCardData(id: 'top1', label: 'تبديل إطارات', value: '٣٥ سيارة', icon: 'crown'),
        InsightCardData(id: 'top2', label: 'ترصيص وموازنة', value: '٢٥ سيارة', icon: 'flame'),
        InsightCardData(id: 'top3', label: 'إصلاح بنشر', value: '٢٠ سيارة', icon: 'sparkles'),
      ]),
      InsightSectionData(title: 'الأداء', cards: [
        InsightCardData(id: 'avg_time', label: 'معدل وقت الخدمة', value: '٣٠ دقيقة', change: '−٥ د', trend: TrendDirection.up, icon: 'clock'),
        InsightCardData(id: 'busiest_day', label: 'أكثر يوم', value: 'الخميس', icon: 'calendar'),
        InsightCardData(id: 'emergency', label: 'خدمات طوارئ', value: '٨', icon: 'alert-circle'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+٧٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 140, 260, 8, 15),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'تبديل إطارات', count: 35, unit: 'سيارة'),
      TopItemDataPoint(name: 'ترصيص وموازنة', count: 25, unit: 'سيارة'),
      TopItemDataPoint(name: 'إصلاح بنشر', count: 20, unit: 'سيارة'),
    ]),
    distribution: null,
    tips: const [
      'نصيحة: الطلب يرتفع قبل الشتاء — وفّر مخزون إطارات شتوية مبكراً',
      'فكرة: أضف خدمة "فحص إطارات مجاني" — تجذب عملاء جدد',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Gas Delivery (catalog_order)
// ═══════════════════════════════════════════════════════════════

InsightsData _gasDelivery(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات ${_periodLabelAr(period)}', value: '${(380 * m).toInt()} د.أ', change: '+٦٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'orders', label: 'الطلبات', value: '${(95 * m).toInt()}', change: '+١٠٪', trend: TrendDirection.up, icon: 'package'),
        InsightCardData(id: 'avg_order', label: 'متوسط الطلب', value: '٤ د.أ', icon: 'trending-up'),
        InsightCardData(id: 'active_customers', label: 'العملاء النشطين', value: '${(110 * m ~/ 4).toInt()}', change: '+٨', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'الاحتفاظ بالعملاء', cards: [
        InsightCardData(id: 'reorder_rate', label: 'نسبة إعادة الطلب', value: '٨٢٪', change: '+٣٪', trend: TrendDirection.up, icon: 'repeat'),
        InsightCardData(id: 'new_customers', label: 'عملاء جدد', value: '٩', change: '+٣', trend: TrendDirection.up, icon: 'user-plus'),
      ]),
      InsightSectionData(title: 'التوصيل', cards: [
        InsightCardData(id: 'delivery_time', label: 'معدل وقت التوصيل', value: '٤٠ دقيقة', change: '−٥ د', trend: TrendDirection.up, icon: 'clock'),
        InsightCardData(id: 'top_zone', label: 'المنطقة الأكثر طلباً', value: 'الجبيهة', icon: 'map-pin'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+٦٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 35, 70, 10, 18),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'أسطوانة غاز كبيرة', count: 60, unit: 'طلب'),
      TopItemDataPoint(name: 'أسطوانة غاز صغيرة', count: 25, unit: 'طلب'),
      TopItemDataPoint(name: 'تعبئة غاز', count: 10, unit: 'طلب'),
    ]),
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'الجبيهة', value: 35, color: _primary),
      DistributionDataPoint(name: 'طبربور', value: 30, color: _primaryLight),
      DistributionDataPoint(name: 'ماركا', value: 20, color: _primaryLighter),
      DistributionDataPoint(name: 'أخرى', value: 15, color: _primaryLightest),
    ]),
    tips: const [
      'نصيحة: ٨٢٪ من عملائك يعيدون الطلب — أرسل تذكيراً بعد ٣ أسابيع',
      'فكرة: أضف خدمة "جدولة تلقائية" — يزيد الاحتفاظ بالعملاء',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Clothes Store (catalog_order)
// ═══════════════════════════════════════════════════════════════

InsightsData _clothesStore(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات ${_periodLabelAr(period)}', value: '${(2200 * m).toInt()} د.أ', change: '+١٥٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'orders', label: 'الطلبات', value: '${(85 * m).toInt()}', change: '+١٢٪', trend: TrendDirection.up, icon: 'package'),
        InsightCardData(id: 'avg_order', label: 'متوسط الطلب', value: '٢٥.٩ د.أ', change: '+٥٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'active_customers', label: 'العملاء النشطين', value: '${(200 * m ~/ 4).toInt()}', change: '+٢٥', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'الاحتفاظ بالعملاء', cards: [
        InsightCardData(id: 'return_rate', label: 'نسبة العودة', value: '٤٥٪', change: '+٥٪', trend: TrendDirection.up, icon: 'repeat'),
        InsightCardData(id: 'new_customers', label: 'عملاء جدد', value: '٤٥', change: '+١٢', trend: TrendDirection.up, icon: 'user-plus'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+١٥٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 200, 400, 8, 16),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'فساتين', count: 30, unit: 'طلب'),
      TopItemDataPoint(name: 'بلوزات', count: 25, unit: 'طلب'),
      TopItemDataPoint(name: 'بناطيل', count: 18, unit: 'طلب'),
      TopItemDataPoint(name: 'حقائب', count: 12, unit: 'طلب'),
    ]),
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'نسائي', value: 55, color: _primary),
      DistributionDataPoint(name: 'رجالي', value: 30, color: _primaryLight),
      DistributionDataPoint(name: 'أطفال', value: 15, color: _primaryLighter),
    ]),
    tips: const [
      'نصيحة: الفساتين أكثر المنتجات مبيعاً — وفّر تشكيلة متنوعة',
      'فكرة: أضف "تنبيه وصول بضاعة جديدة" — يزيد التفاعل بـ +٤٠٪',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Online Store (catalog_order)
// ═══════════════════════════════════════════════════════════════

InsightsData _onlineStore(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات ${_periodLabelAr(period)}', value: '${(1800 * m).toInt()} د.أ', change: '+٢٠٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'orders', label: 'الطلبات', value: '${(110 * m).toInt()}', change: '+١٨٪', trend: TrendDirection.up, icon: 'package'),
        InsightCardData(id: 'avg_order', label: 'متوسط الطلب', value: '١٦.٤ د.أ', change: '+٧٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'active_customers', label: 'العملاء النشطين', value: '${(350 * m ~/ 4).toInt()}', change: '+٤٥', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'الاحتفاظ بالعملاء', cards: [
        InsightCardData(id: 'return_rate', label: 'نسبة العودة', value: '٣٨٪', change: '+٤٪', trend: TrendDirection.up, icon: 'repeat'),
        InsightCardData(id: 'cart_abandon', label: 'نسبة ترك السلة', value: '٢٥٪', change: '−٣٪', trend: TrendDirection.up, icon: 'alert-circle'),
        InsightCardData(id: 'new_customers', label: 'عملاء جدد', value: '٦٨', change: '+٢٠', trend: TrendDirection.up, icon: 'user-plus'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+٢٠٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 180, 350, 12, 22),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'إلكترونيات', count: 35, unit: 'طلب'),
      TopItemDataPoint(name: 'ملابس', count: 30, unit: 'طلب'),
      TopItemDataPoint(name: 'إكسسوارات', count: 25, unit: 'طلب'),
      TopItemDataPoint(name: 'أدوات منزلية', count: 20, unit: 'طلب'),
    ]),
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'عمّان', value: 60, color: _primary),
      DistributionDataPoint(name: 'إربد', value: 20, color: _primaryLight),
      DistributionDataPoint(name: 'الزرقاء', value: 12, color: _primaryLighter),
      DistributionDataPoint(name: 'أخرى', value: 8, color: _primaryLightest),
    ]),
    tips: const [
      'نصيحة: ٢٥٪ يتركون السلة — أرسل تذكيراً بعد ساعة لاسترجاعهم',
      'فكرة: أضف "شحن مجاني فوق ١٥ د.أ" — يرفع متوسط الطلب بـ +٣٠٪',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Mini Market (catalog_order)
// ═══════════════════════════════════════════════════════════════

InsightsData _miniMarket(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات ${_periodLabelAr(period)}', value: '${(850 * m).toInt()} د.أ', change: '+٧٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'orders', label: 'الطلبات', value: '${(200 * m).toInt()}', change: '+١٠٪', trend: TrendDirection.up, icon: 'package'),
        InsightCardData(id: 'avg_order', label: 'متوسط الطلب', value: '٤.٣ د.أ', change: '+٢٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'active_customers', label: 'العملاء النشطين', value: '${(280 * m ~/ 4).toInt()}', change: '+١٥', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'الاحتفاظ بالعملاء', cards: [
        InsightCardData(id: 'reorder_rate', label: 'نسبة إعادة الطلب', value: '٧٠٪', change: '+٤٪', trend: TrendDirection.up, icon: 'repeat'),
        InsightCardData(id: 'new_customers', label: 'عملاء جدد', value: '٢٠', change: '+٥', trend: TrendDirection.up, icon: 'user-plus'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+٧٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 80, 160, 22, 38),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'حليب ومشتقات', count: 55, unit: 'طلب'),
      TopItemDataPoint(name: 'خبز ومعجنات', count: 45, unit: 'طلب'),
      TopItemDataPoint(name: 'مشروبات', count: 40, unit: 'طلب'),
      TopItemDataPoint(name: 'سناكات', count: 35, unit: 'طلب'),
      TopItemDataPoint(name: 'منظفات', count: 25, unit: 'طلب'),
    ]),
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'الحي', value: 65, color: _primary),
      DistributionDataPoint(name: 'الأحياء المجاورة', value: 25, color: _primaryLight),
      DistributionDataPoint(name: 'أخرى', value: 10, color: _primaryLighter),
    ]),
    tips: const [
      'نصيحة: الحليب والخبز أكثر المنتجات طلباً — تأكد من التوفر الدائم',
      'فكرة: أضف خدمة "توصيل سريع ٣٠ دقيقة" — تزيد الطلبات بـ +٢٥٪',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Butcher (catalog_order)
// ═══════════════════════════════════════════════════════════════

InsightsData _butcher(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات ${_periodLabelAr(period)}', value: '${(1600 * m).toInt()} د.أ', change: '+٩٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'orders', label: 'الطلبات', value: '${(130 * m).toInt()}', change: '+١١٪', trend: TrendDirection.up, icon: 'package'),
        InsightCardData(id: 'avg_order', label: 'متوسط الطلب', value: '١٢.٣ د.أ', change: '+٤٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'active_customers', label: 'العملاء النشطين', value: '${(180 * m ~/ 4).toInt()}', change: '+١٨', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'الاحتفاظ بالعملاء', cards: [
        InsightCardData(id: 'reorder_rate', label: 'نسبة إعادة الطلب', value: '٧٥٪', change: '+٣٪', trend: TrendDirection.up, icon: 'repeat'),
        InsightCardData(id: 'new_customers', label: 'عملاء جدد', value: '١٥', change: '+٥', trend: TrendDirection.up, icon: 'user-plus'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+٩٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 160, 300, 14, 24),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'لحم غنم', count: 45, unit: 'طلب'),
      TopItemDataPoint(name: 'دجاج', count: 40, unit: 'طلب'),
      TopItemDataPoint(name: 'لحم بقر', count: 25, unit: 'طلب'),
      TopItemDataPoint(name: 'كفتة', count: 20, unit: 'طلب'),
    ]),
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'لحوم حمراء', value: 50, color: _primary),
      DistributionDataPoint(name: 'دواجن', value: 35, color: _primaryLight),
      DistributionDataPoint(name: 'مجمدات', value: 15, color: _primaryLighter),
    ]),
    tips: const [
      'نصيحة: الطلب يرتفع ٥٠٪ أيام الخميس والجمعة — جهّز كميات إضافية',
      'فكرة: أضف "باقة الشواء" المجهزة — تزيد متوسط الطلب بـ +٣٥٪',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Produce (catalog_order)
// ═══════════════════════════════════════════════════════════════

InsightsData _produce(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات ${_periodLabelAr(period)}', value: '${(700 * m).toInt()} د.أ', change: '+٦٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'orders', label: 'الطلبات', value: '${(160 * m).toInt()}', change: '+٨٪', trend: TrendDirection.up, icon: 'package'),
        InsightCardData(id: 'avg_order', label: 'متوسط الطلب', value: '٤.٤ د.أ', change: '+٢٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'active_customers', label: 'العملاء النشطين', value: '${(220 * m ~/ 4).toInt()}', change: '+١٢', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'الاحتفاظ بالعملاء', cards: [
        InsightCardData(id: 'reorder_rate', label: 'نسبة إعادة الطلب', value: '٨٠٪', change: '+٥٪', trend: TrendDirection.up, icon: 'repeat'),
        InsightCardData(id: 'new_customers', label: 'عملاء جدد', value: '١٤', change: '+٤', trend: TrendDirection.up, icon: 'user-plus'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+٦٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 70, 130, 18, 28),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'بندورة', count: 40, unit: 'طلب'),
      TopItemDataPoint(name: 'خيار', count: 35, unit: 'طلب'),
      TopItemDataPoint(name: 'بطاطا', count: 30, unit: 'طلب'),
      TopItemDataPoint(name: 'ليمون', count: 25, unit: 'طلب'),
      TopItemDataPoint(name: 'موز', count: 20, unit: 'طلب'),
    ]),
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'خضار', value: 55, color: _primary),
      DistributionDataPoint(name: 'فواكه', value: 35, color: _primaryLight),
      DistributionDataPoint(name: 'أعشاب وورقيات', value: 10, color: _primaryLighter),
    ]),
    tips: const [
      'نصيحة: ٨٠٪ من العملاء يعيدون الطلب أسبوعياً — قدّم "سلة الأسبوع" المجهزة',
      'فكرة: أضف صور المنتجات الطازجة يومياً — تزيد الطلبات بـ +٢٠٪',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Pharmacy (catalog_order)
// ═══════════════════════════════════════════════════════════════

InsightsData _pharmacy(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات ${_periodLabelAr(period)}', value: '${(1300 * m).toInt()} د.أ', change: '+٨٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'orders', label: 'الطلبات', value: '${(170 * m).toInt()}', change: '+١٢٪', trend: TrendDirection.up, icon: 'package'),
        InsightCardData(id: 'avg_order', label: 'متوسط الطلب', value: '٧.٦ د.أ', change: '+٣٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'active_customers', label: 'العملاء النشطين', value: '${(250 * m ~/ 4).toInt()}', change: '+٢٠', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'الاحتفاظ بالعملاء', cards: [
        InsightCardData(id: 'reorder_rate', label: 'نسبة إعادة الطلب', value: '٦٥٪', change: '+٤٪', trend: TrendDirection.up, icon: 'repeat'),
        InsightCardData(id: 'new_customers', label: 'عملاء جدد', value: '٣٠', change: '+٨', trend: TrendDirection.up, icon: 'user-plus'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+٨٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 130, 240, 18, 30),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'أدوية وصفية', count: 60, unit: 'طلب'),
      TopItemDataPoint(name: 'مكملات غذائية', count: 40, unit: 'طلب'),
      TopItemDataPoint(name: 'عناية شخصية', count: 35, unit: 'طلب'),
      TopItemDataPoint(name: 'مستلزمات طبية', count: 20, unit: 'طلب'),
    ]),
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'أدوية', value: 50, color: _primary),
      DistributionDataPoint(name: 'مكملات', value: 25, color: _primaryLight),
      DistributionDataPoint(name: 'عناية شخصية', value: 15, color: _primaryLighter),
      DistributionDataPoint(name: 'مستلزمات', value: 10, color: _primaryLightest),
    ]),
    tips: const [
      'نصيحة: أدوية الوصفات أكثر الطلبات — وفّر خدمة "تجديد الوصفة" التلقائية',
      'فكرة: أضف قسم "عروض الشهر" — يزيد مبيعات المكملات بـ +٢٥٪',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Electronics Store (catalog_order)
// ═══════════════════════════════════════════════════════════════

InsightsData _electronicsStore(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات ${_periodLabelAr(period)}', value: '${(5500 * m).toInt()} د.أ', change: '+١٨٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'orders', label: 'الطلبات', value: '${(65 * m).toInt()}', change: '+١٥٪', trend: TrendDirection.up, icon: 'package'),
        InsightCardData(id: 'avg_order', label: 'متوسط الطلب', value: '٨٤.٦ د.أ', change: '+٨٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'active_customers', label: 'العملاء النشطين', value: '${(150 * m ~/ 4).toInt()}', change: '+٢٠', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'الاحتفاظ بالعملاء', cards: [
        InsightCardData(id: 'return_rate', label: 'نسبة العودة', value: '٣٢٪', change: '+٥٪', trend: TrendDirection.up, icon: 'repeat'),
        InsightCardData(id: 'new_customers', label: 'عملاء جدد', value: '٤٢', change: '+١٥', trend: TrendDirection.up, icon: 'user-plus'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+١٨٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 500, 1000, 5, 12),
    ),
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'هواتف ذكية', count: 20, unit: 'طلب'),
      TopItemDataPoint(name: 'سماعات', count: 15, unit: 'طلب'),
      TopItemDataPoint(name: 'شواحن وكوابل', count: 12, unit: 'طلب'),
      TopItemDataPoint(name: 'أغطية حماية', count: 10, unit: 'طلب'),
    ]),
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'هواتف', value: 40, color: _primary),
      DistributionDataPoint(name: 'إكسسوارات', value: 35, color: _primaryLight),
      DistributionDataPoint(name: 'أجهزة منزلية', value: 15, color: _primaryLighter),
      DistributionDataPoint(name: 'أخرى', value: 10, color: _primaryLightest),
    ]),
    tips: const [
      'نصيحة: الهواتف الذكية أعلى إيراداً — تابع عروض الوكلاء الرسميين',
      'فكرة: أضف خدمة "تقسيط بدون فوائد" — تزيد المبيعات بـ +٤٠٪',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Photographer (portfolio_inquiry)
// ═══════════════════════════════════════════════════════════════

InsightsData _photographer(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'revenue', label: 'الإيرادات', value: '${(1800 * m ~/ 4).toInt()} د.أ', change: '+١٢٪', trend: TrendDirection.up, icon: 'banknote'),
        InsightCardData(id: 'sessions', label: 'جلسات تصوير', value: '${(12 * m ~/ 4).toInt()}', change: '+٣', trend: TrendDirection.up, icon: 'camera'),
        InsightCardData(id: 'avg_session', label: 'متوسط قيمة الجلسة', value: '١٥٠ د.أ', change: '+٨٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'inquiries', label: 'استفسارات', value: '${(25 * m ~/ 4).toInt()}', change: '+٨', trend: TrendDirection.up, icon: 'users'),
      ]),
      InsightSectionData(title: 'سرعة الاستجابة', cards: [
        InsightCardData(id: 'response_time', label: 'معدل وقت الرد', value: '٣٠ دقيقة', change: '−١٥ د', trend: TrendDirection.up, icon: 'clock'),
        InsightCardData(id: 'conversion', label: 'نسبة تحويل الاستفسارات', value: '٤٨٪', change: '+٥٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'portfolio_views', label: 'مشاهدات الأعمال', value: '${(350 * m).toInt()}', change: '+٢٥٪', trend: TrendDirection.up, icon: 'eye'),
      ]),
      InsightSectionData(title: 'أنواع الجلسات', cards: [
        InsightCardData(id: 'weddings', label: 'حفلات زفاف', value: '٤ جلسات', icon: 'crown'),
        InsightCardData(id: 'events', label: 'مناسبات', value: '٣ جلسات', icon: 'star'),
        InsightCardData(id: 'portraits', label: 'بورتريه', value: '٥ جلسات', icon: 'camera'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+١٢٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 0, 350, 0, 3),
    ),
    topItems: null,
    distribution: null,
    tips: const [
      'نصيحة: سرعة الرد تزيد التحويل — ردّك خلال ٣٠ دقيقة يحول ٤٨٪ من الاستفسارات',
      'فكرة: أضف فيديو "خلف الكواليس" — يزيد مشاهدات الأعمال بـ +٤٠٪',
      'تنبيه: موسم الأعراس قادم — جهّز باقات الزفاف مبكراً',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Event Venue (reservation)
// ═══════════════════════════════════════════════════════════════

InsightsData _eventVenue(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'occupancy', label: 'نسبة الإشغال', value: '٦٥٪', change: '+٨٪', trend: TrendDirection.up, icon: 'home'),
        InsightCardData(id: 'events', label: 'فعاليات', value: '${(10 * m).toInt()}', change: '+٣', trend: TrendDirection.up, icon: 'calendar'),
        InsightCardData(id: 'avg_event', label: 'متوسط قيمة الحجز', value: '٨٥٠ د.أ', icon: 'trending-up'),
        InsightCardData(id: 'revenue', label: 'الإيرادات', value: '${(8500 * m).toInt()} د.أ', change: '+١٥٪', trend: TrendDirection.up, icon: 'banknote'),
      ]),
      InsightSectionData(title: 'أداء الحجوزات', cards: [
        InsightCardData(id: 'weekend', label: 'نهاية الأسبوع', value: '٩٠٪', change: '+٥٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'weekday', label: 'أيام الأسبوع', value: '٣٥٪', change: '+١٠٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'repeat', label: 'عملاء متكررون', value: '٢٨٪', change: '+٤٪', trend: TrendDirection.up, icon: 'repeat'),
      ]),
      InsightSectionData(title: 'الضيوف', cards: [
        InsightCardData(id: 'guests_month', label: 'ضيوف هذا الشهر', value: '${(500 * m ~/ 4).toInt()}', change: '+٥٠', trend: TrendDirection.up, icon: 'users'),
        InsightCardData(id: 'avg_guests', label: 'معدل عدد الضيوف', value: '١٢٠', icon: 'users'),
      ]),
    ],
    revenueChart: RevenueChartData(
      label: labels.revenueLabel, summaryLabel: labels.summaryLabel,
      ordersTooltip: labels.ordersTooltip,
      comparison: '+١٥٪ ${_comparisonLabelAr(period)}',
      comparisonTrend: TrendDirection.up,
      data: _generateRevenueData(period, 0, 1200, 0, 2),
    ),
    topItems: null,
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'حفلات زفاف', value: 45, color: _primary),
      DistributionDataPoint(name: 'مؤتمرات', value: 25, color: _primaryLight),
      DistributionDataPoint(name: 'أعياد ميلاد', value: 20, color: _primaryLighter),
      DistributionDataPoint(name: 'أخرى', value: 10, color: _primaryLightest),
    ]),
    tips: const [
      'نصيحة: أيام الأسبوع إشغال ٣٥٪ فقط — قدّم أسعار خاصة للاثنين-الأربعاء',
      'فكرة: أضف باقة "كل شيء مشمول" — تسهّل القرار وتزيد الحجوزات بـ +٣٠٪',
      'تنبيه: ٤ استفسارات لم يُرد عليها — سرعة الرد تحسّن التحويل بـ ٥٠٪',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Bank (follow_only)
// ═══════════════════════════════════════════════════════════════

InsightsData _bank(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'التفاعل', cards: [
        InsightCardData(id: 'reach', label: 'الوصول', value: '${(3500 * m).toInt()}', change: '+٢٢٪', trend: TrendDirection.up, icon: 'eye'),
        InsightCardData(id: 'new_followers', label: 'متابعون جدد', value: '${(180 * m ~/ 4).toInt()}', change: '+٢٥', trend: TrendDirection.up, icon: 'users'),
        InsightCardData(id: 'posts', label: 'منشورات', value: '${(6 * m ~/ 4).toInt()}', icon: 'file-text'),
        InsightCardData(id: 'read_rate', label: 'نسبة القراءة', value: '٧٢٪', change: '+٤٪', trend: TrendDirection.up, icon: 'check-circle'),
      ]),
      InsightSectionData(title: 'المنشورات', cards: [
        InsightCardData(id: 'avg_views', label: 'متوسط المشاهدات', value: '٤,٥٠٠', change: '+٢٠٪', trend: TrendDirection.up, icon: 'trending-up'),
        InsightCardData(id: 'top_post', label: 'أعلى منشور وصولاً', value: '٨,٢٠٠', icon: 'crown'),
      ]),
    ],
    revenueChart: null,
    topItems: TopItemsData(label: labels.topItemsLabel, items: const [
      TopItemDataPoint(name: 'عرض قرض سكني', count: 8200, unit: 'مشاهدة'),
      TopItemDataPoint(name: 'فتح حساب رقمي', count: 5400, unit: 'مشاهدة'),
      TopItemDataPoint(name: 'بطاقة ائتمان جديدة', count: 3800, unit: 'مشاهدة'),
      TopItemDataPoint(name: 'تحديث أوقات العمل', count: 2100, unit: 'مشاهدة'),
    ]),
    distribution: DistributionData(label: labels.distributionLabel, segments: const [
      DistributionDataPoint(name: 'عروض وخدمات', value: 45, color: _primary),
      DistributionDataPoint(name: 'تحديثات', value: 35, color: _primaryLight),
      DistributionDataPoint(name: 'إعلامية', value: 20, color: _primaryLighter),
    ]),
    tips: const [
      'نصيحة: عروض القروض تحقق أعلى وصول — انشر عروضاً جديدة أسبوعياً',
      'فكرة: أضف رابط "فتح حساب" مباشر مع كل منشور — يزيد التحويل بـ ٣٥٪',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Directory
// ═══════════════════════════════════════════════════════════════

InsightsData _directory(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  final m = _periodMultiplier(period);
  return InsightsData(
    pageId: pageId, businessType: type, archetype: archetype,
    period: period.name, periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'tenants', label: 'المستأجرون', value: '٤٥', icon: 'home'),
        InsightCardData(id: 'page_views', label: 'مشاهدات الصفحة', value: '${(1800 * m).toInt()}', change: '+١٥٪', trend: TrendDirection.up, icon: 'eye'),
        InsightCardData(id: 'followers', label: 'المتابعون', value: '${(320 * m ~/ 4).toInt()}', change: '+٢٠', trend: TrendDirection.up, icon: 'users'),
        InsightCardData(id: 'growth', label: 'نمو المتابعين', value: '+٨٪', change: '+٢٪', trend: TrendDirection.up, icon: 'trending-up'),
      ]),
      InsightSectionData(title: 'المنشورات', cards: [
        InsightCardData(id: 'posts', label: 'منشورات هذا الشهر', value: '${(3 * m ~/ 4).toInt()}', icon: 'file-text'),
        InsightCardData(id: 'avg_views', label: 'متوسط المشاهدات', value: '١,٢٠٠', change: '+١٠٪', trend: TrendDirection.up, icon: 'trending-up'),
      ]),
    ],
    revenueChart: null,
    topItems: null,
    distribution: null,
    tips: const [
      'نصيحة: انشر عروض المستأجرين الجديدة — يزيد تفاعل المتابعين بـ +٣٠٪',
      'فكرة: أضف "دليل المتاجر" المحدّث شهرياً — يحسّن تجربة الزوار',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Fallback
// ═══════════════════════════════════════════════════════════════

InsightsData _fallbackGenerator(String pageId, String type, String archetype,
    InsightPeriod period, ChartLabels labels) {
  return InsightsData(
    pageId: pageId,
    businessType: type,
    archetype: archetype,
    period: period.name,
    periodLabel: _periodLabelAr(period),
    kpiSections: [
      InsightSectionData(title: 'نظرة عامة', cards: [
        InsightCardData(id: 'views', label: 'مشاهدات الصفحة', value: '—', icon: 'eye'),
        InsightCardData(id: 'followers', label: 'المتابعون', value: '—', icon: 'users'),
      ]),
    ],
    revenueChart: null,
    topItems: null,
    distribution: null,
    tips: const [
      'نصيحة: العملاء الذين يطلبون ٤+ قوارير لديهم نسبة احتفاظ أعلى بـ ٣٥٪',
      'فكرة: أنشئ عرض "بطاقة الولاء" — اشترِ ١٠ واحصل على ٢ مجاناً',
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
// Revenue data generator
// ═══════════════════════════════════════════════════════════════

List<RevenueDataPoint> _generateRevenueData(
  InsightPeriod period,
  double minRevenue,
  double maxRevenue,
  int minOrders,
  int maxOrders, {
  bool subscriptions = false,
}) {
  final labels = _labelsForPeriod(period);
  final count = labels.length;
  final revenueRange = maxRevenue - minRevenue;
  final ordersRange = maxOrders - minOrders;

  return List.generate(count, (i) {
    // Deterministic "random" pattern
    final factor = (i * 37 + 13) % 100 / 100.0;
    final revenue = minRevenue + revenueRange * factor;
    final orders = minOrders + (ordersRange * factor).toInt();
    return RevenueDataPoint(
      label: labels[i],
      revenue: double.parse(revenue.toStringAsFixed(1)),
      subscriptionRevenue: subscriptions
          ? double.parse((revenue * 0.3 * ((i + 1) / count)).toStringAsFixed(1))
          : null,
      orders: orders,
    );
  });
}
