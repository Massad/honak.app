import '../archetype.dart';
import '../archetype_defaults.dart';
import '../business_type_config.dart';

// ============================================================
// Portfolio Inquiry Types -- portfolio_inquiry archetype
// photographer, real_estate
// ============================================================

final photographer = createType(
  id: 'photographer',
  nameAr: 'تصوير',
  nameEn: 'Photographer',
  categoryAr: 'خدمات إبداعية',
  categoryEn: 'Photographer',
  archetype: Archetype.portfolioInquiry,
  icon: '📷',
  features: ['portfolio', 'inquiry_form'],
  insights: const [
    InsightSection(
      title: 'نظرة عامة',
      cards: [
        InsightCard(
          id: 'revenue',
          label: 'الإيرادات هذا الشهر',
          value: '٢,٠٠٠ د.أ',
          trend: 'up',
          icon: 'banknote',
        ),
        InsightCard(
          id: 'bookings',
          label: 'حجوزات هذا الشهر',
          value: '١٥',
          trend: 'up',
          icon: 'calendar',
        ),
        InsightCard(
          id: 'inquiries',
          label: 'استفسارات جديدة',
          value: '٢٠',
          trend: 'up',
          icon: 'message-circle',
        ),
        InsightCard(
          id: 'followers',
          label: 'متابعون جدد',
          value: '٥٠',
          trend: 'up',
          icon: 'users',
        ),
      ],
    ),
    InsightSection(
      title: 'التفاعل',
      cards: [
        InsightCard(
          id: 'response_time',
          label: 'معدل وقت الرد',
          value: '٣٠ دقيقة',
          trend: 'up',
          icon: 'clock',
        ),
        InsightCard(
          id: 'conversion',
          label: 'نسبة تحويل الاستفسارات',
          value: '٦٥٪',
          trend: 'up',
          icon: 'trending-up',
        ),
        InsightCard(
          id: 'portfolio_views',
          label: 'مشاهدات الأعمال',
          value: '٣٢٠',
          trend: 'up',
          icon: 'eye',
        ),
      ],
    ),
    InsightSection(
      title: 'أنواع التصوير',
      cards: [
        InsightCard(
          id: 'top_1',
          label: 'أعراس',
          value: '٥ حجوزات',
          trend: 'up',
          icon: 'heart',
        ),
        InsightCard(
          id: 'top_2',
          label: 'بورتريه',
          value: '٤ جلسات',
          trend: 'up',
          icon: 'user',
        ),
        InsightCard(
          id: 'top_3',
          label: 'مناسبات',
          value: '٣ حجوزات',
          trend: 'neutral',
          icon: 'calendar',
        ),
      ],
    ),
  ],
  requestLabelAr: 'استفسار / حجز',
  dashboard: DashboardConfig(
    statsLabels: const [
      DashboardStatLabel(
        key: 'inquiries_today',
        label: 'استفسار جديد',
        icon: 'message-circle',
      ),
      DashboardStatLabel(
        key: 'new_followers',
        label: 'متابع جديد',
        icon: 'users',
      ),
      DashboardStatLabel(
        key: 'page_views',
        label: 'مشاهدة',
        icon: 'eye',
      ),
    ],
    sections: [Section.stats, Section.quotes, Section.actions],
    quickActions: const [
      DashboardAction(
        id: 'add_work',
        labelAr: 'أضف عمل جديد',
        icon: 'image',
        color: 'bg-purple-50 text-purple-600',
      ),
      DashboardAction(
        id: 'new_post',
        labelAr: 'منشور جديد',
        icon: 'edit-3',
        color: 'bg-orange-50 text-[#FF9800]',
      ),
      DashboardAction(
        id: 'update_pricing',
        labelAr: 'تحديث الأسعار',
        icon: 'tag',
        color: 'bg-blue-50 text-[#1A73E8]',
      ),
    ],
  ),
  orderLabels: const OrderLabels(
    incoming: 'استفسارات جديدة',
    accepted: 'حجوزات مؤكدة',
    completed: 'أعمال مكتملة',
    itemUnit: 'استفسار',
  ),
  showCoverageAreas: false,
  coverageLabelAr: 'نطاق الخدمة',
  availablePermissions: [
    Perm.manageOrders,
    Perm.respondChat,
    Perm.postUpdates,
    Perm.viewInsights,
    Perm.manageSettings,
    Perm.manageTeam,
  ],
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'مصور',
      defaultPermissions: ['manage_orders', 'respond_chat', 'post_updates'],
    ),
    SuggestedRole(
      labelAr: 'مصور مساعد',
      defaultPermissions: ['respond_chat'],
    ),
    SuggestedRole(
      labelAr: 'مدير حسابات',
      defaultPermissions: [
        'manage_orders',
        'respond_chat',
        'view_insights',
        'post_updates',
      ],
    ),
  ],
  qrTargets: const [
    QRTarget(
      id: 'page',
      labelAr: 'الصفحة الرئيسية',
      section: 'page',
      icon: 'store',
    ),
    QRTarget(
      id: 'portfolio',
      labelAr: 'الأعمال',
      section: 'portfolio',
      icon: 'image',
    ),
    QRTarget(
      id: 'info',
      labelAr: 'معلومات التواصل',
      section: 'info',
      icon: 'info',
    ),
  ],
  itemManagement: const ItemManagementConfig(
    sourceField: 'portfolio',
    itemLabelAr: 'عمل',
    itemsLabelAr: 'معرض الأعمال',
    addLabelAr: 'إضافة عمل',
    hasImage: true,
    hasCategory: true,
    hasDescription: true,
    hasPrice: false,
    properties: [],
    quantityMode: QuantityMode.none,
    canDiscount: false,
  ),
  manageTabs: const [
    ManageTab(id: 'items', labelAr: 'المعرض'),
    ManageTab(id: 'past_work', labelAr: 'أعمالنا'),
    ManageTab(id: 'price_range', labelAr: 'الأسعار'),
  ],
);

final realEstate = createType(
  id: 'real_estate',
  nameAr: 'عقارات',
  nameEn: 'Real Estate Agent',
  categoryAr: 'خدمات مهنية',
  categoryEn: 'Real Estate',
  archetype: Archetype.portfolioInquiry,
  icon: '🏘️',
  features: ['portfolio_gallery', 'ready_made_items'],
  requestLabelAr: 'استفسار عقاري',
  orderLabels: const OrderLabels(
    incoming: 'استفسارات جديدة',
    accepted: 'عقارات قيد التفاوض',
    completed: 'صفقات مكتملة',
    itemUnit: 'عقار',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'وكيل عقاري',
      defaultPermissions: ['manage_catalog', 'manage_orders', 'respond_chat'],
    ),
    SuggestedRole(
      labelAr: 'مدير مكتب',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
        'post_updates',
      ],
    ),
  ],
  itemManagement: const ItemManagementConfig(
    sourceField: 'catalog',
    itemLabelAr: 'عقار',
    itemsLabelAr: 'العقارات',
    addLabelAr: 'إضافة عقار',
    hasImage: true,
    hasCategory: true,
    hasDescription: true,
    hasPrice: true,
    properties: [
      ItemPropertyConfig(
        id: 'area',
        labelAr: 'المساحة',
        type: ItemPropertyType.text,
        required: false,
        placeholderAr: '١٥٠ م²',
      ),
      ItemPropertyConfig(
        id: 'bedrooms',
        labelAr: 'غرف النوم',
        type: ItemPropertyType.text,
        required: false,
        placeholderAr: '٣',
      ),
    ],
    quantityMode: QuantityMode.none,
    canDiscount: false,
  ),
);

/// All portfolio inquiry type configs.
final List<BusinessTypeConfig> portfolioTypes = [
  photographer,
  realEstate,
];
