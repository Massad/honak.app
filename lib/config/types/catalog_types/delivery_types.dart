// ============================================================
// Delivery Types — catalogOrder archetype
// water_delivery, gas_delivery
// ============================================================

import '../../archetype.dart';
import '../../archetype_defaults.dart';
import '../../business_type_config.dart';

// ─── Water Delivery (full config — legacy) ─────────────────

final waterDelivery = createType(
  id: 'water_delivery',
  nameAr: 'توصيل مياه',
  nameEn: 'Water Delivery',
  categoryAr: 'خدمات التوصيل',
  categoryEn: 'Delivery Services',
  archetype: Archetype.catalogOrder,
  icon: '🚰',
  features: [
    'recurring_orders',
    'subscriptions',
    'punch_cards',
    'delivery_zones',
    'delivery_time_slots',
    'coverage_area',
  ],
  insights: [
    InsightSection(
      title: 'نظرة عامة',
      cards: [
        InsightCard(
            id: 'revenue',
            label: 'الإيرادات هذا الأسبوع',
            value: '٤٥٠ د.أ',
            trend: 'up',
            icon: 'banknote'),
        InsightCard(
            id: 'orders',
            label: 'الطلبات هذا الأسبوع',
            value: '٨٥',
            trend: 'up',
            icon: 'package'),
        InsightCard(
            id: 'avg_order',
            label: 'متوسط الطلب',
            value: '٥.٣ د.أ',
            trend: 'up',
            icon: 'trending-up'),
        InsightCard(
            id: 'customers',
            label: 'العملاء النشطين',
            value: '٣٤٠',
            trend: 'up',
            icon: 'users'),
      ],
    ),
    InsightSection(
      title: 'الاحتفاظ بالعملاء',
      cards: [
        InsightCard(
            id: 'reorder_rate',
            label: 'نسبة إعادة الطلب',
            value: '٩٢٪',
            trend: 'up',
            icon: 'repeat'),
        InsightCard(
            id: 'churn',
            label: 'عملاء فقدتهم هذا الشهر',
            value: '٨',
            trend: 'down',
            icon: 'user-minus'),
        InsightCard(
            id: 'new_customers',
            label: 'عملاء جدد هذا الشهر',
            value: '٢٣',
            trend: 'up',
            icon: 'user-plus'),
      ],
    ),
    InsightSection(
      title: 'التوصيل',
      cards: [
        InsightCard(
            id: 'delivery_time',
            label: 'معدل وقت التوصيل',
            value: '٣٥ دقيقة',
            trend: 'up',
            icon: 'clock'),
        InsightCard(
            id: 'bottles_month',
            label: 'قوارير هذا الشهر',
            value: '٢,٠٠٠',
            trend: 'up',
            icon: 'droplets'),
        InsightCard(
            id: 'top_zone',
            label: 'المنطقة الأكثر طلباً',
            value: 'خلدا',
            trend: 'neutral',
            icon: 'map-pin'),
      ],
    ),
    InsightSection(
      title: 'الإيرادات المتوقعة',
      cards: [
        InsightCard(
            id: 'recurring_revenue',
            label: 'إيرادات متكررة متوقعة',
            value: '٢,٠٠٠ د.أ/شهر',
            trend: 'neutral',
            icon: 'calendar'),
        InsightCard(
            id: 'top_product',
            label: 'المنتج الأكثر ربحاً',
            value: 'قارورة ١٩ لتر',
            trend: 'neutral',
            icon: 'star'),
      ],
    ),
  ],
  requestLabelAr: 'طلب كتالوج',
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
          key: 'requests_today', label: 'طلبات اليوم', icon: 'package'),
      DashboardStatLabel(
          key: 'new_followers', label: 'متابع جديد', icon: 'users'),
      DashboardStatLabel(key: 'page_views', label: 'مشاهدة', icon: 'eye'),
    ],
    sections: [
      Section.stats,
      Section.revenue,
      Section.route,
      Section.lowStock,
      Section.pending,
      Section.recurringTomorrow,
      Section.customerInsights,
      Section.actions,
      Section.bestSellers,
    ],
    quickActions: [
      DashboardAction(
          id: 'add_product',
          labelAr: 'إضافة منتج',
          icon: 'plus',
          color: 'bg-blue-50 text-[#1A73E8]'),
      DashboardAction(
          id: 'update_zones',
          labelAr: 'مناطق التوصيل',
          icon: 'map-pin',
          color: 'bg-green-50 text-[#43A047]'),
      DashboardAction(
          id: 'new_post',
          labelAr: 'منشور جديد',
          icon: 'edit-3',
          color: 'bg-orange-50 text-[#FF9800]'),
    ],
  ),
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات مقبولة',
    completed: 'طلبات مكتملة',
    itemUnit: 'منتج',
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'سائق', defaultPermissions: ['manage_orders']),
    SuggestedRole(
        labelAr: 'موزع', defaultPermissions: ['manage_orders']),
    SuggestedRole(
        labelAr: 'كاشير',
        defaultPermissions: ['manage_orders', 'respond_chat']),
    SuggestedRole(
      labelAr: 'مشرف',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
      ],
    ),
    SuggestedRole(
        labelAr: 'محاسب', defaultPermissions: ['view_insights']),
  ],
  qrTargets: [
    QRTarget(
        id: 'page',
        labelAr: 'الصفحة الرئيسية',
        section: 'page',
        icon: 'store'),
    QRTarget(
        id: 'catalog',
        labelAr: 'الكتالوج',
        section: 'catalog',
        icon: 'package'),
    QRTarget(
        id: 'info',
        labelAr: 'معلومات التواصل',
        section: 'info',
        icon: 'info'),
  ],
  itemManagement: ItemManagementConfig(
    sourceField: 'catalog',
    itemLabelAr: 'منتج',
    itemsLabelAr: 'المنتجات',
    addLabelAr: 'إضافة منتج',
    hasImage: true,
    hasCategory: true,
    hasDescription: true,
    hasPrice: true,
    properties: [],
    quantityMode: QuantityMode.open,
    canDiscount: true,
  ),
  manageTabs: [MTab.items, MTab.packages],
);

// ─── Gas Delivery (full config — legacy) ───────────────────

final gasDelivery = createType(
  id: 'gas_delivery',
  nameAr: 'توصيل غاز',
  nameEn: 'Gas Delivery',
  categoryAr: 'خدمات التوصيل',
  categoryEn: 'Delivery Services',
  archetype: Archetype.catalogOrder,
  icon: '🔥',
  features: [
    'recurring_orders',
    'subscriptions',
    'delivery_zones',
    'delivery_time_slots',
    'coverage_area',
  ],
  insights: [
    InsightSection(
      title: 'نظرة عامة',
      cards: [
        InsightCard(
            id: 'revenue',
            label: 'الإيرادات هذا الأسبوع',
            value: '٣٢٠ د.أ',
            trend: 'up',
            icon: 'banknote'),
        InsightCard(
            id: 'orders',
            label: 'الطلبات هذا الأسبوع',
            value: '٤٦',
            trend: 'up',
            icon: 'package'),
        InsightCard(
            id: 'avg_order',
            label: 'متوسط الطلب',
            value: '٧.٠٠ د.أ',
            trend: 'neutral',
            icon: 'trending-up'),
        InsightCard(
            id: 'customers',
            label: 'العملاء النشطين',
            value: '٢٨٠',
            trend: 'up',
            icon: 'users'),
      ],
    ),
    InsightSection(
      title: 'التوصيل',
      cards: [
        InsightCard(
            id: 'cylinders_month',
            label: 'اسطوانات هذا الشهر',
            value: '٢,٠٠٠',
            trend: 'up',
            icon: 'flame'),
        InsightCard(
            id: 'delivery_time',
            label: 'معدل وقت التوصيل',
            value: '٤٥ دقيقة',
            trend: 'up',
            icon: 'clock'),
        InsightCard(
            id: 'top_zone',
            label: 'المنطقة الأكثر طلباً',
            value: 'عبدون',
            trend: 'neutral',
            icon: 'map-pin'),
        InsightCard(
            id: 'peak_hours',
            label: 'ساعات الذروة',
            value: '٦–٨ مساءً',
            trend: 'neutral',
            icon: 'bar-chart-3'),
      ],
    ),
    InsightSection(
      title: 'الاحتفاظ بالعملاء',
      cards: [
        InsightCard(
            id: 'repeat_rate',
            label: 'نسبة إعادة الطلب',
            value: '٨٨٪',
            trend: 'up',
            icon: 'repeat'),
        InsightCard(
            id: 'churn',
            label: 'عملاء فقدتهم',
            value: '٥',
            trend: 'down',
            icon: 'user-minus'),
        InsightCard(
            id: 'new_customers',
            label: 'عملاء جدد هذا الشهر',
            value: '١٨',
            trend: 'up',
            icon: 'user-plus'),
      ],
    ),
  ],
  requestLabelAr: 'طلب كتالوج',
  coverageGranularity: CoverageGranularity.street,
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
          key: 'requests_today', label: 'طلبات اليوم', icon: 'package'),
      DashboardStatLabel(
          key: 'new_followers', label: 'متابع جديد', icon: 'users'),
      DashboardStatLabel(key: 'page_views', label: 'مشاهدة', icon: 'eye'),
    ],
    sections: [
      Section.stats,
      Section.revenue,
      Section.route,
      Section.lowStock,
      Section.pending,
      Section.recurringTomorrow,
      Section.customerInsights,
      Section.actions,
    ],
    quickActions: [
      DashboardAction(
          id: 'add_product',
          labelAr: 'إضافة منتج',
          icon: 'plus',
          color: 'bg-blue-50 text-[#1A73E8]'),
      DashboardAction(
          id: 'update_zones',
          labelAr: 'مناطق التغطية',
          icon: 'map-pin',
          color: 'bg-green-50 text-[#43A047]'),
      DashboardAction(
          id: 'new_post',
          labelAr: 'منشور جديد',
          icon: 'edit-3',
          color: 'bg-orange-50 text-[#FF9800]'),
    ],
  ),
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات مقبولة',
    completed: 'طلبات مكتملة',
    itemUnit: 'منتج',
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'سائق', defaultPermissions: ['manage_orders']),
    SuggestedRole(
        labelAr: 'موزع', defaultPermissions: ['manage_orders']),
    SuggestedRole(
        labelAr: 'كاشير',
        defaultPermissions: ['manage_orders', 'respond_chat']),
    SuggestedRole(
      labelAr: 'مشرف',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
      ],
    ),
    SuggestedRole(
        labelAr: 'محاسب', defaultPermissions: ['view_insights']),
  ],
  qrTargets: [
    QRTarget(
        id: 'page',
        labelAr: 'الصفحة الرئيسية',
        section: 'page',
        icon: 'store'),
    QRTarget(
        id: 'catalog',
        labelAr: 'الكتالوج',
        section: 'catalog',
        icon: 'package'),
    QRTarget(
        id: 'info',
        labelAr: 'معلومات التواصل',
        section: 'info',
        icon: 'info'),
  ],
  itemManagement: ItemManagementConfig(
    sourceField: 'catalog',
    itemLabelAr: 'منتج',
    itemsLabelAr: 'المنتجات',
    addLabelAr: 'إضافة منتج',
    hasImage: true,
    hasCategory: true,
    hasDescription: true,
    hasPrice: true,
    properties: [],
    quantityMode: QuantityMode.open,
    canDiscount: true,
  ),
);
