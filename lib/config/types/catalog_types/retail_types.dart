// ============================================================
// Retail Types — catalogOrder archetype
// clothes_store, bookstore, online_store
// ============================================================

import '../../archetype.dart';
import '../../archetype_defaults.dart';
import '../../business_type_config.dart';

// ─── Clothes Store (full config — legacy) ──────────────────

final clothesStore = createType(
  id: 'clothes_store',
  nameAr: 'متجر ملابس',
  nameEn: 'Clothes Store',
  categoryAr: 'تسوق وأزياء',
  categoryEn: 'Clothes Store',
  archetype: Archetype.catalogOrder,
  icon: '👗',
  features: [
    'size_variants',
    'color_variants',
    'inventory_tracking',
    'multi_location',
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
            value: '١٢٥',
            trend: 'up',
            icon: 'shopping-bag'),
        InsightCard(
            id: 'avg_order',
            label: 'متوسط الطلب',
            value: '١٤.٨ د.أ',
            trend: 'up',
            icon: 'trending-up'),
        InsightCard(
            id: 'visitors',
            label: 'زوار الصفحة',
            value: '٢,٣٠٠',
            trend: 'up',
            icon: 'users'),
      ],
    ),
    InsightSection(
      title: 'الأصناف الأكثر مبيعاً',
      cards: [
        InsightCard(
            id: 'top_1',
            label: 'تيشيرت قطن أساسي',
            value: '٤٥ قطعة',
            trend: 'up',
            icon: 'crown'),
        InsightCard(
            id: 'top_2',
            label: 'جينز كلاسيك',
            value: '٣٨ قطعة',
            trend: 'up',
            icon: 'trending-up'),
        InsightCard(
            id: 'top_3',
            label: 'فستان صيفي',
            value: '٢٥ قطعة',
            trend: 'neutral',
            icon: 'shirt'),
      ],
    ),
    InsightSection(
      title: 'المخزون',
      cards: [
        InsightCard(
            id: 'total_items',
            label: 'إجمالي المنتجات',
            value: '٣٤٠',
            trend: 'neutral',
            icon: 'package'),
        InsightCard(
            id: 'low_stock',
            label: 'منتجات مخزون منخفض',
            value: '٢٠',
            trend: 'down',
            icon: 'alert-circle'),
        InsightCard(
            id: 'out_of_stock',
            label: 'نفد المخزون',
            value: '٣',
            trend: 'up',
            icon: 'x-circle'),
        InsightCard(
            id: 'new_arrivals',
            label: 'وصول جديد هذا الشهر',
            value: '٤٥ منتج',
            trend: 'neutral',
            icon: 'package-plus'),
      ],
    ),
    InsightSection(
      title: 'الفروع',
      cards: [
        InsightCard(
            id: 'branch_1',
            label: 'فرع عبدون',
            value: '٧٥ طلب/أسبوع',
            trend: 'up',
            icon: 'map-pin'),
        InsightCard(
            id: 'branch_2',
            label: 'فرع المقابلين',
            value: '٥٠ طلب/أسبوع',
            trend: 'up',
            icon: 'map-pin'),
      ],
    ),
  ],
  requestLabelAr: 'طلب شراء',
  defaultEngagement: EngagementLevel.showcase,
  showCoverageAreas: false,
  coverageGranularity: CoverageGranularity.city,
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
          key: 'requests_today', label: 'طلبات اليوم', icon: 'shopping-bag'),
      DashboardStatLabel(
          key: 'new_followers', label: 'متابع جديد', icon: 'users'),
      DashboardStatLabel(key: 'page_views', label: 'مشاهدة', icon: 'eye'),
    ],
    sections: [
      Section.stats,
      Section.revenue,
      Section.lowStock,
      Section.pending,
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
          id: 'daily_special',
          labelAr: 'عرض اليوم',
          icon: 'sparkles',
          color: 'bg-orange-50 text-[#FF9800]'),
      DashboardAction(
          id: 'new_arrival',
          labelAr: 'وصول جديد',
          icon: 'package-plus',
          color: 'bg-green-50 text-[#43A047]'),
      DashboardAction(
          id: 'new_post',
          labelAr: 'منشور جديد',
          icon: 'edit-3',
          color: 'bg-purple-50 text-purple-600'),
    ],
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'بائع',
        defaultPermissions: ['manage_orders', 'respond_chat']),
    SuggestedRole(
        labelAr: 'أمين مخزن', defaultPermissions: ['manage_catalog']),
    SuggestedRole(
        labelAr: 'كاشير', defaultPermissions: ['manage_orders']),
    SuggestedRole(
        labelAr: 'مسؤول السوشال ميديا',
        defaultPermissions: ['post_updates', 'respond_chat']),
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
        id: 'catalog',
        labelAr: 'الكتالوج',
        section: 'catalog',
        icon: 'shopping-bag'),
    QRTarget(
        id: 'new_arrivals',
        labelAr: 'وصول جديد',
        section: 'new_arrivals',
        icon: 'sparkles'),
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
    properties: [
      ItemPropertyConfig(
          id: 'sizes',
          labelAr: 'المقاسات',
          type: ItemPropertyType.chipList,
          placeholderAr: 'مقاس جديد...'),
      ItemPropertyConfig(
          id: 'colors',
          labelAr: 'الألوان',
          type: ItemPropertyType.chipList,
          hasImages: true,
          placeholderAr: 'لون جديد...'),
    ],
    quantityMode: QuantityMode.perVariant,
    canDiscount: true,
  ),
);

// ─── Bookstore (full config — legacy) ──────────────────────

final bookstore = createType(
  id: 'bookstore',
  nameAr: 'مكتبة / قرطاسية',
  nameEn: 'Bookstore',
  categoryAr: 'تسوق وتعليم',
  categoryEn: 'Bookstore',
  archetype: Archetype.catalogOrder,
  icon: '📚',
  features: ['inventory_tracking', 'delivery_zones', 'delivery_time_slots'],
  insights: [
    InsightSection(
      title: 'نظرة عامة',
      cards: [
        InsightCard(
            id: 'revenue',
            label: 'الإيرادات هذا الأسبوع',
            value: '٦٨٠ د.أ',
            trend: 'up',
            icon: 'banknote'),
        InsightCard(
            id: 'orders',
            label: 'الطلبات هذا الأسبوع',
            value: '٧٥',
            trend: 'up',
            icon: 'shopping-bag'),
        InsightCard(
            id: 'avg_order',
            label: 'متوسط الطلب',
            value: '٩.١ د.أ',
            trend: 'up',
            icon: 'trending-up'),
        InsightCard(
            id: 'customers',
            label: 'العملاء النشطين',
            value: '٤٥٠',
            trend: 'up',
            icon: 'users'),
      ],
    ),
    InsightSection(
      title: 'الأكثر مبيعاً',
      cards: [
        InsightCard(
            id: 'top_1',
            label: 'رواية "ذاكرة الجسد"',
            value: '٢٢ نسخة',
            trend: 'up',
            icon: 'crown'),
        InsightCard(
            id: 'top_2',
            label: 'قرطاسية مدرسية',
            value: '١٨ طقم',
            trend: 'up',
            icon: 'trending-up'),
        InsightCard(
            id: 'top_3',
            label: 'كتب أطفال',
            value: '١٥ كتاب',
            trend: 'neutral',
            icon: 'book-open'),
      ],
    ),
    InsightSection(
      title: 'المخزون',
      cards: [
        InsightCard(
            id: 'total_items',
            label: 'إجمالي العناوين',
            value: '٢,٠٠٠',
            trend: 'neutral',
            icon: 'library'),
        InsightCard(
            id: 'low_stock',
            label: 'مخزون منخفض',
            value: '١٥ عنوان',
            trend: 'down',
            icon: 'alert-circle'),
        InsightCard(
            id: 'new_arrivals',
            label: 'وصول جديد هذا الشهر',
            value: '٤٥ عنوان',
            trend: 'neutral',
            icon: 'package-plus'),
      ],
    ),
    InsightSection(
      title: 'الاحتفاظ بالعملاء',
      cards: [
        InsightCard(
            id: 'return_rate',
            label: 'نسبة العودة',
            value: '٦٨٪',
            trend: 'up',
            icon: 'repeat'),
        InsightCard(
            id: 'new_customers',
            label: 'عملاء جدد هذا الشهر',
            value: '٤٢',
            trend: 'up',
            icon: 'user-plus'),
      ],
    ),
  ],
  requestLabelAr: 'طلب شراء',
  coverageGranularity: CoverageGranularity.city,
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
          key: 'requests_today', label: 'طلبات اليوم', icon: 'shopping-bag'),
      DashboardStatLabel(
          key: 'new_followers', label: 'متابع جديد', icon: 'users'),
      DashboardStatLabel(key: 'page_views', label: 'مشاهدة', icon: 'eye'),
    ],
    sections: [
      Section.stats,
      Section.revenue,
      Section.lowStock,
      Section.pending,
      Section.actions,
      Section.bestSellers,
    ],
    quickActions: [
      DashboardAction(
          id: 'add_product',
          labelAr: 'إضافة كتاب',
          icon: 'plus',
          color: 'bg-blue-50 text-[#1A73E8]'),
      DashboardAction(
          id: 'daily_special',
          labelAr: 'عرض اليوم',
          icon: 'sparkles',
          color: 'bg-orange-50 text-[#FF9800]'),
      DashboardAction(
          id: 'new_arrival',
          labelAr: 'وصول جديد',
          icon: 'package-plus',
          color: 'bg-green-50 text-[#43A047]'),
      DashboardAction(
          id: 'new_post',
          labelAr: 'منشور جديد',
          icon: 'edit-3',
          color: 'bg-purple-50 text-purple-600'),
    ],
  ),
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات مؤكدة',
    completed: 'طلبات مكتملة',
    itemUnit: 'منتج',
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'بائع',
        defaultPermissions: ['manage_orders', 'respond_chat']),
    SuggestedRole(
        labelAr: 'أمين مخزن', defaultPermissions: ['manage_catalog']),
    SuggestedRole(
        labelAr: 'كاشير', defaultPermissions: ['manage_orders']),
    SuggestedRole(
      labelAr: 'مدير المكتبة',
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
        id: 'catalog',
        labelAr: 'الكتب والمنتجات',
        section: 'catalog',
        icon: 'book-open'),
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
    quantityMode: QuantityMode.perItem,
    canDiscount: true,
  ),
);

// ─── Online Store (full config — legacy) ───────────────────

final onlineStore = createType(
  id: 'online_store',
  nameAr: 'متجر أونلاين',
  nameEn: 'Online Store',
  categoryAr: 'تجارة إلكترونية',
  categoryEn: 'Online Store',
  archetype: Archetype.catalogOrder,
  icon: '🛒',
  features: [
    'size_variants',
    'color_variants',
    'inventory_tracking',
    'delivery_zones',
    'delivery_time_slots',
  ],
  insights: [
    InsightSection(
      title: 'نظرة عامة',
      cards: [
        InsightCard(
            id: 'revenue',
            label: 'الإيرادات هذا الأسبوع',
            value: '٤,٠٠٠ د.أ',
            trend: 'up',
            icon: 'banknote'),
        InsightCard(
            id: 'orders',
            label: 'الطلبات هذا الأسبوع',
            value: '٢٠٠',
            trend: 'up',
            icon: 'shopping-bag'),
        InsightCard(
            id: 'avg_order',
            label: 'متوسط الطلب',
            value: '٢٠.٠ د.أ',
            trend: 'up',
            icon: 'trending-up'),
        InsightCard(
            id: 'visitors',
            label: 'زوار الصفحة',
            value: '٥,٨٠٠',
            trend: 'up',
            icon: 'users'),
      ],
    ),
    InsightSection(
      title: 'المنتجات الأكثر مبيعاً',
      cards: [
        InsightCard(
            id: 'top_1',
            label: 'سماعات لاسلكية',
            value: '٨٢ قطعة',
            trend: 'up',
            icon: 'crown'),
        InsightCard(
            id: 'top_2',
            label: 'شاحن سريع',
            value: '٦٥ قطعة',
            trend: 'up',
            icon: 'trending-up'),
        InsightCard(
            id: 'top_3',
            label: 'كفر جوال',
            value: '٥٠ قطعة',
            trend: 'neutral',
            icon: 'package'),
      ],
    ),
    InsightSection(
      title: 'الشحن والتوصيل',
      cards: [
        InsightCard(
            id: 'shipped',
            label: 'شحنات هذا الأسبوع',
            value: '١٩٠',
            trend: 'up',
            icon: 'truck'),
        InsightCard(
            id: 'avg_delivery',
            label: 'متوسط التوصيل',
            value: '٢.٥ يوم',
            trend: 'up',
            icon: 'clock'),
        InsightCard(
            id: 'returns',
            label: 'مرتجعات',
            value: '٨',
            trend: 'up',
            icon: 'rotate-ccw'),
      ],
    ),
  ],
  requestLabelAr: 'طلب شراء',
  coverageGranularity: CoverageGranularity.national,
  coverageLabelAr: 'مناطق الشحن',
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
          key: 'requests_today', label: 'طلبات اليوم', icon: 'shopping-bag'),
      DashboardStatLabel(
          key: 'new_followers', label: 'متابع جديد', icon: 'users'),
      DashboardStatLabel(key: 'page_views', label: 'مشاهدة', icon: 'eye'),
    ],
    sections: [
      Section.stats,
      Section.revenue,
      Section.lowStock,
      Section.pending,
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
          id: 'daily_special',
          labelAr: 'عرض اليوم',
          icon: 'sparkles',
          color: 'bg-orange-50 text-[#FF9800]'),
      DashboardAction(
          id: 'new_arrival',
          labelAr: 'وصول جديد',
          icon: 'package-plus',
          color: 'bg-green-50 text-[#43A047]'),
      DashboardAction(
          id: 'new_post',
          labelAr: 'منشور جديد',
          icon: 'edit-3',
          color: 'bg-purple-50 text-purple-600'),
    ],
  ),
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات مؤكدة',
    completed: 'طلبات مكتملة',
    itemUnit: 'منتج',
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'مسؤول طلبات',
        defaultPermissions: ['manage_orders', 'respond_chat']),
    SuggestedRole(
        labelAr: 'أمين مخزن', defaultPermissions: ['manage_catalog']),
    SuggestedRole(
        labelAr: 'خدمة عملاء',
        defaultPermissions: ['respond_chat', 'manage_orders']),
    SuggestedRole(
        labelAr: 'مسؤول محتوى',
        defaultPermissions: ['post_updates', 'manage_catalog']),
    SuggestedRole(
      labelAr: 'مدير المتجر',
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
        id: 'catalog',
        labelAr: 'الكتالوج',
        section: 'catalog',
        icon: 'shopping-bag'),
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
    properties: [
      ItemPropertyConfig(
          id: 'colors',
          labelAr: 'الألوان',
          type: ItemPropertyType.chipList,
          hasImages: true,
          placeholderAr: 'لون جديد...'),
    ],
    quantityMode: QuantityMode.perItem,
    canDiscount: true,
  ),
);
