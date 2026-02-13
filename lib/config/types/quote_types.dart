import '../archetype.dart';
import '../archetype_defaults.dart';
import '../business_type_config.dart';

// ============================================================
// Quote Request Types -- quote_request archetype
// plumber, electrician, ac_repair, moving_company, auto_mechanic
// ============================================================

final plumber = createType(
  id: 'plumber',
  nameAr: 'سباك',
  nameEn: 'Plumber',
  categoryAr: 'خدمات منزلية',
  categoryEn: 'Plumber',
  archetype: Archetype.quoteRequest,
  icon: '🔧',
  features: ['quote_form', 'service_area'],
  insights: const [
    InsightSection(
      title: 'نظرة عامة',
      cards: [
        InsightCard(
          id: 'revenue',
          label: 'الإيرادات هذا الشهر',
          value: '٢,٥٠٠ د.أ',
          trend: 'up',
          icon: 'banknote',
        ),
        InsightCard(
          id: 'jobs',
          label: 'أعمال هذا الشهر',
          value: '٣٠',
          trend: 'up',
          icon: 'wrench',
        ),
        InsightCard(
          id: 'avg_job',
          label: 'متوسط قيمة العمل',
          value: '٨٣.٣ د.أ',
          trend: 'up',
          icon: 'trending-up',
        ),
        InsightCard(
          id: 'clients',
          label: 'عملاء تواصلوا',
          value: '٥٠',
          trend: 'up',
          icon: 'users',
        ),
      ],
    ),
    InsightSection(
      title: 'سرعة الاستجابة',
      cards: [
        InsightCard(
          id: 'response_time',
          label: 'معدل وقت الرد',
          value: '٤٥ دقيقة',
          trend: 'up',
          icon: 'clock',
        ),
        InsightCard(
          id: 'quote_rate',
          label: 'نسبة تحويل العروض',
          value: '٧٢٪',
          trend: 'up',
          icon: 'trending-up',
        ),
        InsightCard(
          id: 'emergency_jobs',
          label: 'أعمال طوارئ هذا الشهر',
          value: '٨',
          trend: 'up',
          icon: 'alert-circle',
        ),
      ],
    ),
    InsightSection(
      title: 'أنواع الأعمال',
      cards: [
        InsightCard(
          id: 'top_1',
          label: 'إصلاح تسريبات',
          value: '٢٢ عمل',
          trend: 'up',
          icon: 'droplets',
        ),
        InsightCard(
          id: 'top_2',
          label: 'تركيب سخانات',
          value: '٨ أعمال',
          trend: 'up',
          icon: 'flame',
        ),
        InsightCard(
          id: 'top_3',
          label: 'تسليك مجاري',
          value: '٥ أعمال',
          trend: 'neutral',
          icon: 'wrench',
        ),
      ],
    ),
    InsightSection(
      title: 'منطقة الخدمة',
      cards: [
        InsightCard(
          id: 'top_zone',
          label: 'المنطقة الأكثر طلباً',
          value: 'عبدون',
          trend: 'neutral',
          icon: 'map-pin',
        ),
        InsightCard(
          id: 'coverage',
          label: 'مناطق مغطاة',
          value: '٥ مناطق',
          trend: 'neutral',
          icon: 'map-pin',
        ),
        InsightCard(
          id: 'repeat_clients',
          label: 'عملاء متكررون',
          value: '٦٥٪',
          trend: 'up',
          icon: 'repeat',
        ),
      ],
    ),
  ],
  requestLabelAr: 'طلب معاينة',
  customerCtaAr: 'اطلب معاينة',
  customerCtaDescAr: 'سيتواصل معك الفنّي لتحديد موعد الزيارة والكشف',
  dashboard: DashboardConfig(
    statsLabels: const [
      DashboardStatLabel(
        key: 'requests_today',
        label: 'طلبات اليوم',
        icon: 'wrench',
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
    sections: [Section.stats, Section.quotes, Section.pending, Section.actions],
    quickActions: const [
      DashboardAction(
        id: 'update_area',
        labelAr: 'مناطق الخدمة',
        icon: 'map-pin',
        color: 'bg-blue-50 text-[#1A73E8]',
      ),
      DashboardAction(
        id: 'add_photos',
        labelAr: 'صور أعمال',
        icon: 'camera',
        color: 'bg-purple-50 text-purple-600',
      ),
      DashboardAction(
        id: 'new_post',
        labelAr: 'منشور جديد',
        icon: 'edit-3',
        color: 'bg-orange-50 text-[#FF9800]',
      ),
    ],
  ),
  orderLabels: const OrderLabels(
    incoming: 'طلبات معاينة جديدة',
    accepted: 'معاينات مقبولة',
    completed: 'أعمال مكتملة',
    itemUnit: 'عمل',
  ),
  showCoverageAreas: true,
  availablePermissions: [
    Perm.manageAvailability,
    Perm.manageOrders,
    Perm.respondChat,
    Perm.postUpdates,
    Perm.viewInsights,
    Perm.manageSettings,
    Perm.manageTeam,
  ],
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'فني',
      defaultPermissions: ['manage_orders', 'respond_chat'],
    ),
    SuggestedRole(
      labelAr: 'فني طوارئ',
      defaultPermissions: ['manage_orders', 'respond_chat'],
    ),
    SuggestedRole(
      labelAr: 'مساعد',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'مشرف',
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
      id: 'services',
      labelAr: 'الخدمات',
      section: 'services',
      icon: 'wrench',
    ),
    QRTarget(
      id: 'portfolio',
      labelAr: 'أعمال سابقة',
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
    sourceField: 'services_offered',
    itemLabelAr: 'خدمة',
    itemsLabelAr: 'الخدمات المقدمة',
    addLabelAr: 'إضافة خدمة',
    hasImage: false,
    hasCategory: false,
    hasDescription: true,
    hasPrice: false,
    properties: [],
    quantityMode: QuantityMode.none,
    canDiscount: false,
  ),
  manageTabs: const [
    ManageTab(id: 'items', labelAr: 'الخدمات'),
    ManageTab(id: 'past_work', labelAr: 'أعمالنا'),
    ManageTab(id: 'price_range', labelAr: 'الأسعار'),
  ],
);

final electrician = createType(
  id: 'electrician',
  nameAr: 'كهربائي',
  nameEn: 'Electrician',
  categoryAr: 'خدمات منزلية',
  categoryEn: 'Electrician',
  archetype: Archetype.quoteRequest,
  icon: '⚡',
  requestLabelAr: 'طلب كهربائي',
  customerCtaAr: 'اطلب كهربائي',
  customerCtaDescAr: 'صف المشكلة — سيتم التواصل معك لتحديد الموعد',
  orderLabels: const OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'زيارات مؤكدة',
    completed: 'أعمال مكتملة',
    itemUnit: 'طلب',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'فني كهرباء',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'فني طوارئ',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'مشرف',
      defaultPermissions: ['manage_orders', 'respond_chat', 'view_insights'],
    ),
  ],
);

final acRepair = createType(
  id: 'ac_repair',
  nameAr: 'تكييف وتبريد',
  nameEn: 'AC Repair & Installation',
  categoryAr: 'خدمات منزلية',
  categoryEn: 'AC Repair',
  archetype: Archetype.quoteRequest,
  icon: '❄️',
  requestLabelAr: 'طلب صيانة تكييف',
  customerCtaAr: 'اطلب صيانة',
  orderLabels: const OrderLabels(
    incoming: 'طلبات صيانة',
    accepted: 'زيارات مؤكدة',
    completed: 'أعمال مكتملة',
    itemUnit: 'طلب',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'فني تكييف',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'فني تركيب',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'مشرف',
      defaultPermissions: ['manage_orders', 'respond_chat', 'view_insights'],
    ),
  ],
);

final movingCompany = createType(
  id: 'moving_company',
  nameAr: 'نقل أثاث',
  nameEn: 'Moving Company',
  categoryAr: 'خدمات منزلية',
  categoryEn: 'Moving Company',
  archetype: Archetype.quoteRequest,
  icon: '🚛',
  requestLabelAr: 'طلب نقل',
  customerCtaAr: 'اطلب عرض سعر نقل',
  customerCtaDescAr: 'حدد عنوان المصدر والوجهة — سنتواصل معك',
  orderLabels: const OrderLabels(
    incoming: 'طلبات نقل',
    accepted: 'نقليات مؤكدة',
    completed: 'نقليات مكتملة',
    itemUnit: 'نقلة',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'سائق',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'عامل نقل',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'مدير',
      defaultPermissions: [
        'manage_orders',
        'respond_chat',
        'view_insights',
        'post_updates',
      ],
    ),
  ],
);

final autoMechanic = createType(
  id: 'auto_mechanic',
  nameAr: 'ميكانيكي سيارات',
  nameEn: 'Auto Mechanic',
  categoryAr: 'سيارات وصيانة',
  categoryEn: 'Auto Mechanic',
  archetype: Archetype.quoteRequest,
  icon: '🔧',
  requestLabelAr: 'طلب فحص / صيانة',
  customerCtaAr: 'اطلب فحص',
  customerCtaDescAr: 'صف المشكلة أو نوع الصيانة المطلوبة',
  coverageModel: CoverageModel.none,
  orderLabels: const OrderLabels(
    incoming: 'طلبات فحص',
    accepted: 'صيانات مؤكدة',
    completed: 'صيانات مكتملة',
    itemUnit: 'صيانة',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'ميكانيكي',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'كهربائي سيارات',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'مشرف ورشة',
      defaultPermissions: ['manage_orders', 'respond_chat', 'view_insights'],
    ),
  ],
);

/// All quote request type configs.
final List<BusinessTypeConfig> quoteTypes = [
  plumber,
  electrician,
  acRepair,
  movingCompany,
  autoMechanic,
];
