// ============================================================
// Food & Drink Types — menuOrder archetype
// restaurant, cafe, bakery, sweet_shop, juice_bar, fast_food
// ============================================================

import '../archetype.dart';
import '../archetype_defaults.dart';
import '../business_type_config.dart';

// ─── Restaurant (full config — legacy) ─────────────────────

final restaurant = createType(
  id: 'restaurant',
  nameAr: 'مطعم',
  nameEn: 'Restaurant',
  categoryAr: 'طعام ومشروبات',
  categoryEn: 'Food & Beverage',
  archetype: Archetype.menuOrder,
  icon: '🍽️',
  features: [
    'menu_modifiers',
    'delivery_zones',
    'table_reservation',
    'punch_cards',
  ],
  insights: [
    InsightSection(
      title: 'نظرة عامة',
      cards: [
        InsightCard(
            id: 'revenue',
            label: 'الإيرادات هذا الأسبوع',
            value: '٢,٣٥٠ د.أ',
            trend: 'up',
            icon: 'banknote'),
        InsightCard(
            id: 'orders',
            label: 'الطلبات هذا الأسبوع',
            value: '٥٣٠',
            trend: 'up',
            icon: 'utensils'),
        InsightCard(
            id: 'avg_order',
            label: 'متوسط الطلب',
            value: '٨.٥ د.أ',
            trend: 'up',
            icon: 'trending-up'),
        InsightCard(
            id: 'customers',
            label: 'العملاء النشطين',
            value: '٨٩٠',
            trend: 'up',
            icon: 'users'),
      ],
    ),
    InsightSection(
      title: 'الأصناف الأكثر طلباً',
      cards: [
        InsightCard(
            id: 'top_1',
            label: 'منسف أردني',
            value: '١٢٠ طلب',
            trend: 'up',
            icon: 'crown'),
        InsightCard(
            id: 'top_2',
            label: 'شاورما دجاج سوبر',
            value: '٩٨ طلب',
            trend: 'up',
            icon: 'flame'),
        InsightCard(
            id: 'top_3',
            label: 'مشاوي مشكلة',
            value: '٦٧ طلب',
            trend: 'neutral',
            icon: 'beef'),
      ],
    ),
    InsightSection(
      title: 'الكفاءة',
      cards: [
        InsightCard(
            id: 'prep_time',
            label: 'معدل وقت التحضير',
            value: '٢٠ دقيقة',
            trend: 'up',
            icon: 'clock'),
        InsightCard(
            id: 'peak_hour',
            label: 'ساعة الذروة',
            value: '٢:٠٠ — ٤:٠٠ م',
            trend: 'neutral',
            icon: 'activity'),
        InsightCard(
            id: 'dine_vs_delivery',
            label: 'توصيل مقابل استلام',
            value: '٦٥٪ توصيل',
            trend: 'neutral',
            icon: 'truck'),
      ],
    ),
    InsightSection(
      title: 'الاحتفاظ بالعملاء',
      cards: [
        InsightCard(
            id: 'return_rate',
            label: 'نسبة العودة',
            value: '٧٨٪',
            trend: 'up',
            icon: 'repeat'),
        InsightCard(
            id: 'churn',
            label: 'عملاء فقدتهم هذا الشهر',
            value: '٢',
            trend: 'down',
            icon: 'user-minus'),
        InsightCard(
            id: 'new_customers',
            label: 'عملاء جدد هذا الشهر',
            value: '٦٨',
            trend: 'up',
            icon: 'user-plus'),
      ],
    ),
  ],
  requestLabelAr: 'طلب قائمة',
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
          key: 'requests_today', label: 'طلبات اليوم', icon: 'utensils'),
      DashboardStatLabel(
          key: 'new_followers', label: 'متابع جديد', icon: 'users'),
      DashboardStatLabel(key: 'page_views', label: 'مشاهدة', icon: 'eye'),
    ],
    sections: [
      Section.stats,
      Section.revenue,
      Section.queue,
      Section.unavailable,
      Section.pending,
      Section.actions,
      Section.bestSellers,
    ],
    quickActions: [
      DashboardAction(
          id: 'add_item',
          labelAr: 'إضافة صنف',
          icon: 'plus',
          color: 'bg-blue-50 text-[#1A73E8]'),
      DashboardAction(
          id: 'daily_special',
          labelAr: 'عرض اليوم',
          icon: 'sparkles',
          color: 'bg-orange-50 text-[#FF9800]'),
      DashboardAction(
          id: 'toggle_item',
          labelAr: 'إيقاف صنف',
          icon: 'eye-off',
          color: 'bg-red-50 text-[#E53935]'),
    ],
  ),
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات مقبولة',
    completed: 'طلبات مكتملة',
    itemUnit: 'صنف',
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'شيف', defaultPermissions: ['manage_catalog']),
    SuggestedRole(
        labelAr: 'طباخ', defaultPermissions: ['manage_orders']),
    SuggestedRole(
        labelAr: 'كاشير',
        defaultPermissions: ['manage_orders', 'respond_chat']),
    SuggestedRole(
        labelAr: 'نادل', defaultPermissions: ['manage_orders']),
    SuggestedRole(
        labelAr: 'موصّل', defaultPermissions: ['manage_orders']),
    SuggestedRole(
      labelAr: 'مدير فرع',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
        'post_updates',
      ],
    ),
  ],
  qrTargets: [
    QRTarget(
        id: 'page',
        labelAr: 'الصفحة الرئيسية',
        section: 'page',
        icon: 'store'),
    QRTarget(
        id: 'menu',
        labelAr: 'القائمة',
        section: 'menu',
        icon: 'utensils-crossed'),
    QRTarget(
        id: 'specials',
        labelAr: 'عروض اليوم',
        section: 'specials',
        icon: 'tag'),
    QRTarget(
        id: 'info',
        labelAr: 'معلومات التواصل',
        section: 'info',
        icon: 'info'),
  ],
  manageTabs: [MTab.menu, MTab.packages],
);

// ─── Cafe ──────────────────────────────────────────────────

final cafe = createType(
  id: 'cafe',
  nameAr: 'مقهى / كوفي شوب',
  nameEn: 'Cafe & Coffee Shop',
  categoryAr: 'طعام ومشروبات',
  categoryEn: 'Coffee Shop',
  archetype: Archetype.menuOrder,
  icon: '☕',
  features: ['menu_modifiers', 'punch_cards'],
  coverageModel: CoverageModel.deliveryZone,
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات قيد التحضير',
    completed: 'طلبات مكتملة',
    itemUnit: 'مشروب',
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'باريستا',
        defaultPermissions: ['manage_catalog', 'manage_orders']),
    SuggestedRole(
        labelAr: 'كاشير',
        defaultPermissions: ['manage_orders', 'respond_chat']),
    SuggestedRole(
      labelAr: 'مدير',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
        'post_updates',
      ],
    ),
  ],
);

// ─── Bakery ────────────────────────────────────────────────

final bakery = createType(
  id: 'bakery',
  nameAr: 'مخبز',
  nameEn: 'Bakery',
  categoryAr: 'طعام ومشروبات',
  categoryEn: 'Bakery',
  archetype: Archetype.menuOrder,
  icon: '🥖',
  features: ['menu_modifiers', 'delivery_zones'],
  coverageModel: CoverageModel.deliveryZone,
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات قيد التحضير',
    completed: 'طلبات مكتملة',
    itemUnit: 'صنف',
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'خباز', defaultPermissions: ['manage_catalog']),
    SuggestedRole(
        labelAr: 'كاشير',
        defaultPermissions: ['manage_orders', 'respond_chat']),
    SuggestedRole(
        labelAr: 'موصّل', defaultPermissions: ['manage_orders']),
    SuggestedRole(
      labelAr: 'مدير',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
        'post_updates',
      ],
    ),
  ],
);

// ─── Sweet Shop ────────────────────────────────────────────

final sweetShop = createType(
  id: 'sweet_shop',
  nameAr: 'حلويات',
  nameEn: 'Sweet Shop',
  categoryAr: 'طعام ومشروبات',
  categoryEn: 'Sweet Shop',
  archetype: Archetype.menuOrder,
  icon: '🍮',
  features: ['menu_modifiers', 'delivery_zones'],
  coverageModel: CoverageModel.deliveryZone,
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات قيد التحضير',
    completed: 'طلبات مكتملة',
    itemUnit: 'صنف',
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'حلواني', defaultPermissions: ['manage_catalog']),
    SuggestedRole(
        labelAr: 'كاشير',
        defaultPermissions: ['manage_orders', 'respond_chat']),
    SuggestedRole(
        labelAr: 'موصّل', defaultPermissions: ['manage_orders']),
  ],
);

// ─── Juice Bar ─────────────────────────────────────────────

final juiceBar = createType(
  id: 'juice_bar',
  nameAr: 'عصائر / كوكتيل',
  nameEn: 'Juice Bar',
  categoryAr: 'طعام ومشروبات',
  categoryEn: 'Juice Bar',
  archetype: Archetype.menuOrder,
  icon: '🧃',
  coverageModel: CoverageModel.none,
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات قيد التحضير',
    completed: 'طلبات مكتملة',
    itemUnit: 'مشروب',
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'عصّار',
        defaultPermissions: ['manage_catalog', 'manage_orders']),
    SuggestedRole(
        labelAr: 'كاشير',
        defaultPermissions: ['manage_orders', 'respond_chat']),
  ],
);

// ─── Fast Food ─────────────────────────────────────────────

final fastFood = createType(
  id: 'fast_food',
  nameAr: 'وجبات سريعة',
  nameEn: 'Fast Food',
  categoryAr: 'طعام ومشروبات',
  categoryEn: 'Fast Food',
  archetype: Archetype.menuOrder,
  icon: '🍔',
  features: ['menu_modifiers', 'delivery_zones', 'punch_cards'],
  coverageModel: CoverageModel.deliveryZone,
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'طباخ', defaultPermissions: ['manage_orders']),
    SuggestedRole(
        labelAr: 'كاشير',
        defaultPermissions: ['manage_orders', 'respond_chat']),
    SuggestedRole(
        labelAr: 'موصّل', defaultPermissions: ['manage_orders']),
    SuggestedRole(
      labelAr: 'مدير فرع',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
        'post_updates',
      ],
    ),
  ],
);

// ─── Exported list ─────────────────────────────────────────

final foodTypes = <BusinessTypeConfig>[
  restaurant,
  cafe,
  bakery,
  sweetShop,
  juiceBar,
  fastFood,
];
