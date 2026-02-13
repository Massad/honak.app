// ============================================================
// Service Booking Types -- service_booking archetype
// salon, clinic, barber, dentist, gym, laundry, car_wash,
// mobile_repair, tutor, driving_school
// ============================================================

import '../archetype.dart';
import '../archetype_defaults.dart';
import '../business_type_config.dart';

// ─── Salon (full config — legacy) ──────────────────────────

final salon = createType(
  id: 'salon',
  nameAr: 'صالون تجميل',
  nameEn: 'Salon',
  categoryAr: 'جمال وعناية',
  categoryEn: 'Salon',
  archetype: Archetype.serviceBooking,
  icon: '💇',
  features: [
    'service_duration',
    'team_display',
    'subscriptions',
    'punch_cards',
    'loyalty_points',
  ],
  insights: [
    InsightSection(
      title: 'نظرة عامة',
      cards: [
        InsightCard(
            id: 'revenue',
            label: 'الإيرادات هذا الأسبوع',
            value: '٧٨٠ د.أ',
            trend: 'up',
            icon: 'banknote'),
        InsightCard(
            id: 'bookings',
            label: 'الحجوزات هذا الأسبوع',
            value: '٤٥',
            trend: 'up',
            icon: 'calendar'),
        InsightCard(
            id: 'avg_ticket',
            label: 'متوسط الفاتورة',
            value: '١٧.٣ د.أ',
            trend: 'up',
            icon: 'trending-up'),
        InsightCard(
            id: 'clients',
            label: 'العملاء النشطين',
            value: '١٨٥',
            trend: 'up',
            icon: 'users'),
      ],
    ),
    InsightSection(
      title: 'الخدمات الأكثر طلباً',
      cards: [
        InsightCard(
            id: 'top_1',
            label: 'صبغة شعر',
            value: '١٨ حجز',
            trend: 'up',
            icon: 'crown'),
        InsightCard(
            id: 'top_2',
            label: 'قص شعر',
            value: '١٥ حجز',
            trend: 'up',
            icon: 'scissors'),
        InsightCard(
            id: 'top_3',
            label: 'عناية بالبشرة',
            value: '٨ حجوزات',
            trend: 'neutral',
            icon: 'sparkles'),
      ],
    ),
    InsightSection(
      title: 'الجدولة',
      cards: [
        InsightCard(
            id: 'peak_day',
            label: 'أكثر يوم حجوزات',
            value: 'السبت',
            trend: 'neutral',
            icon: 'calendar'),
        InsightCard(
            id: 'peak_hour',
            label: 'ساعة الذروة',
            value: '٠٩:٠٠ — ٠٠١١:٠٠ ص',
            trend: 'neutral',
            icon: 'activity'),
        InsightCard(
            id: 'no_show',
            label: 'نسبة عدم الحضور',
            value: '٣٪',
            trend: 'up',
            icon: 'user-minus'),
        InsightCard(
            id: 'avg_wait',
            label: 'معدل الانتظار',
            value: '٥ دقائق',
            trend: 'up',
            icon: 'clock'),
      ],
    ),
    InsightSection(
      title: 'الاحتفاظ بالعملاء',
      cards: [
        InsightCard(
            id: 'return_rate',
            label: 'نسبة العودة',
            value: '٨٥٪',
            trend: 'up',
            icon: 'repeat'),
        InsightCard(
            id: 'packages_sold',
            label: 'باقات مباعة هذا الشهر',
            value: '٢٣',
            trend: 'up',
            icon: 'package'),
        InsightCard(
            id: 'new_clients',
            label: 'عملاء جدد هذا الشهر',
            value: '١٥',
            trend: 'up',
            icon: 'user-plus'),
      ],
    ),
  ],
  requestLabelAr: 'حجز خدمة',
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
          key: 'requests_today', label: 'حجوزات اليوم', icon: 'calendar'),
      DashboardStatLabel(
          key: 'new_followers', label: 'متابع جديد', icon: 'users'),
      DashboardStatLabel(key: 'page_views', label: 'مشاهدة', icon: 'eye'),
    ],
    sections: [
      Section.stats,
      Section.revenue,
      Section.nextAppt,
      Section.schedule,
      Section.pending,
      Section.actions,
    ],
    quickActions: [
      DashboardAction(
          id: 'add_service',
          labelAr: 'إضافة خدمة',
          icon: 'plus',
          color: 'bg-blue-50 text-[#1A73E8]'),
      DashboardAction(
          id: 'daily_special',
          labelAr: 'عرض اليوم',
          icon: 'sparkles',
          color: 'bg-orange-50 text-[#FF9800]'),
      DashboardAction(
          id: 'manage_schedule',
          labelAr: 'تعديل المواعيد',
          icon: 'calendar',
          color: 'bg-green-50 text-[#43A047]'),
      DashboardAction(
          id: 'add_member',
          labelAr: 'إضافة عضو فريق',
          icon: 'user-plus',
          color: 'bg-purple-50 text-purple-600'),
    ],
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'حلاق',
        defaultPermissions: ['manage_availability', 'manage_orders']),
    SuggestedRole(
        labelAr: 'مصفف شعر',
        defaultPermissions: ['manage_availability', 'manage_orders']),
    SuggestedRole(
        labelAr: 'أخصائية تجميل',
        defaultPermissions: ['manage_availability', 'manage_orders']),
    SuggestedRole(
        labelAr: 'أخصائية بشرة',
        defaultPermissions: ['manage_availability', 'manage_orders']),
    SuggestedRole(
        labelAr: 'موظف استقبال',
        defaultPermissions: ['manage_orders', 'respond_chat']),
    SuggestedRole(
      labelAr: 'مدير الصالون',
      defaultPermissions: [
        'manage_availability',
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
        id: 'services',
        labelAr: 'الخدمات',
        section: 'services',
        icon: 'scissors'),
    QRTarget(
        id: 'team',
        labelAr: 'الفريق',
        section: 'team',
        icon: 'users'),
    QRTarget(
        id: 'info',
        labelAr: 'معلومات التواصل',
        section: 'info',
        icon: 'info'),
  ],
  manageTabs: [MTab.services, MTab.packages],
);

// ─── Clinic (full config — legacy) ─────────────────────────

final clinic = createType(
  id: 'clinic',
  nameAr: 'عيادة / طبيب',
  nameEn: 'Clinic',
  categoryAr: 'صحة وطب',
  categoryEn: 'Clinic',
  archetype: Archetype.serviceBooking,
  icon: '🏥',
  features: ['service_duration', 'team_display', 'multi_location'],
  insights: [
    InsightSection(
      title: 'نظرة عامة',
      cards: [
        InsightCard(
            id: 'appointments',
            label: 'مواعيد هذا الأسبوع',
            value: '٣٨',
            trend: 'up',
            icon: 'calendar'),
        InsightCard(
            id: 'patients',
            label: 'مرضى نشطين',
            value: '١٢٥',
            trend: 'up',
            icon: 'users'),
        InsightCard(
            id: 'revenue',
            label: 'الإيرادات هذا الأسبوع',
            value: '٢,٠٠٠ د.أ',
            trend: 'up',
            icon: 'banknote'),
        InsightCard(
            id: 'avg_visit',
            label: 'معدل الزيارة',
            value: '٣٥ د.أ',
            trend: 'neutral',
            icon: 'trending-up'),
      ],
    ),
    InsightSection(
      title: 'المواعيد',
      cards: [
        InsightCard(
            id: 'show_rate',
            label: 'نسبة الحضور',
            value: '٨٨٪',
            trend: 'up',
            icon: 'check-circle-2'),
        InsightCard(
            id: 'no_show',
            label: 'لم يحضر هذا الشهر',
            value: '٥',
            trend: 'up',
            icon: 'user-x'),
        InsightCard(
            id: 'avg_wait',
            label: 'معدل وقت الانتظار',
            value: '٢ دقيقة',
            trend: 'up',
            icon: 'clock'),
      ],
    ),
    InsightSection(
      title: 'التخصصات الأكثر طلباً',
      cards: [
        InsightCard(
            id: 'top_service',
            label: 'الخدمة الأولى',
            value: 'كشف عام',
            trend: 'neutral',
            icon: 'stethoscope'),
        InsightCard(
            id: 'top_service2',
            label: 'الخدمة الثانية',
            value: 'تحاليل مخبرية',
            trend: 'neutral',
            icon: 'test-tube'),
        InsightCard(
            id: 'new_patients',
            label: 'مرضى جدد هذا الشهر',
            value: '١٨',
            trend: 'up',
            icon: 'user-plus'),
      ],
    ),
  ],
  requestLabelAr: 'حجز موعد',
  showCoverageAreas: false,
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
          key: 'requests_today', label: 'مواعيد اليوم', icon: 'calendar'),
      DashboardStatLabel(
          key: 'new_followers', label: 'مريض جديد', icon: 'user-plus'),
      DashboardStatLabel(key: 'page_views', label: 'مشاهدة', icon: 'eye'),
    ],
    sections: [
      Section.stats,
      Section.nextAppt,
      Section.schedule,
      Section.pending,
      Section.actions,
    ],
    quickActions: [
      DashboardAction(
          id: 'add_service',
          labelAr: 'إضافة خدمة',
          icon: 'plus',
          color: 'bg-blue-50 text-[#1A73E8]'),
      DashboardAction(
          id: 'block_slot',
          labelAr: 'حظر وقت',
          icon: 'x-circle',
          color: 'bg-red-50 text-red-600'),
      DashboardAction(
          id: 'new_post',
          labelAr: 'منشور جديد',
          icon: 'edit-3',
          color: 'bg-purple-50 text-purple-600'),
    ],
  ),
  orderLabels: OrderLabels(
    incoming: 'مواعيد جديدة',
    accepted: 'مواعيد مؤكدة',
    completed: 'مواعيد مكتملة',
    itemUnit: 'خدمة',
  ),
  suggestedRoles: [
    SuggestedRole(
      labelAr: 'طبيب',
      defaultPermissions: [
        'manage_availability',
        'manage_orders',
        'respond_chat',
        'view_insights',
      ],
    ),
    SuggestedRole(
        labelAr: 'طبيب أسنان',
        defaultPermissions: [
          'manage_availability',
          'manage_orders',
          'respond_chat',
        ]),
    SuggestedRole(
        labelAr: 'ممرض/ة',
        defaultPermissions: ['manage_orders', 'respond_chat']),
    SuggestedRole(
        labelAr: 'موظف استقبال',
        defaultPermissions: [
          'manage_orders',
          'respond_chat',
          'manage_availability',
        ]),
    SuggestedRole(
      labelAr: 'مدير العيادة',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
        'manage_settings',
        'manage_team',
        'manage_availability',
        'post_updates',
      ],
    ),
    SuggestedRole(
        labelAr: 'سكرتير/ة طبية',
        defaultPermissions: [
          'manage_orders',
          'respond_chat',
          'manage_availability',
        ]),
  ],
  qrTargets: [
    QRTarget(
        id: 'page',
        labelAr: 'الصفحة الرئيسية',
        section: 'page',
        icon: 'store'),
    QRTarget(
        id: 'services',
        labelAr: 'الخدمات الطبية',
        section: 'services',
        icon: 'stethoscope'),
    QRTarget(
        id: 'info',
        labelAr: 'معلومات التواصل',
        section: 'info',
        icon: 'info'),
  ],
  manageTabs: [MTab.services, MTab.packages],
);

// ─── Barber ──────────────────────────────────────────────────

final barber = createType(
  id: 'barber',
  nameAr: 'حلاق رجالي',
  nameEn: 'Barber Shop',
  categoryAr: 'جمال وعناية',
  categoryEn: 'Barber Shop',
  archetype: Archetype.serviceBooking,
  icon: '💈',
  features: ['service_duration', 'team_display', 'punch_cards'],
  requestLabelAr: 'حجز حلاقة',
  orderLabels: const OrderLabels(
    incoming: 'حجوزات جديدة',
    accepted: 'حجوزات مؤكدة',
    completed: 'حجوزات مكتملة',
    itemUnit: 'حلاقة',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'حلاق',
      defaultPermissions: ['manage_availability', 'manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'حلاق متدرب',
      defaultPermissions: ['manage_availability'],
    ),
    SuggestedRole(
      labelAr: 'موظف استقبال',
      defaultPermissions: ['manage_orders', 'respond_chat'],
    ),
    SuggestedRole(
      labelAr: 'مدير',
      defaultPermissions: [
        'manage_availability',
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
        'post_updates',
      ],
    ),
  ],
);

// ─── Dentist ─────────────────────────────────────────────────

final dentist = createType(
  id: 'dentist',
  nameAr: 'طبيب أسنان',
  nameEn: 'Dentist',
  categoryAr: 'صحة وطب',
  categoryEn: 'Dentist',
  archetype: Archetype.serviceBooking,
  icon: '🦷',
  features: ['service_duration', 'team_display'],
  requestLabelAr: 'حجز موعد أسنان',
  orderLabels: const OrderLabels(
    incoming: 'مواعيد جديدة',
    accepted: 'مواعيد مؤكدة',
    completed: 'مواعيد مكتملة',
    itemUnit: 'زيارة',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'طبيب أسنان',
      defaultPermissions: ['manage_availability', 'manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'مساعد طبيب',
      defaultPermissions: ['manage_availability', 'manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'موظف استقبال',
      defaultPermissions: ['manage_orders', 'respond_chat'],
    ),
    SuggestedRole(
      labelAr: 'مدير العيادة',
      defaultPermissions: [
        'manage_availability',
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
        'post_updates',
      ],
    ),
  ],
  itemManagement: const ItemManagementConfig(
    sourceField: 'services',
    itemLabelAr: 'خدمة',
    itemsLabelAr: 'الخدمات',
    addLabelAr: 'إضافة خدمة',
    hasImage: false,
    hasCategory: true,
    hasDescription: true,
    hasPrice: true,
    properties: [
      ItemPropertyConfig(
        id: 'duration',
        labelAr: 'المدة',
        type: ItemPropertyType.text,
        required: true,
        placeholderAr: '٣٠ دقيقة',
      ),
    ],
    quantityMode: QuantityMode.none,
    canDiscount: false,
    providerAssignment: true,
  ),
);

// ─── Gym ─────────────────────────────────────────────────────

final gym = createType(
  id: 'gym',
  nameAr: 'نادي رياضي',
  nameEn: 'Gym / Fitness Club',
  categoryAr: 'لياقة وعافية',
  categoryEn: 'Gym',
  archetype: Archetype.serviceBooking,
  icon: '🏋️',
  features: ['service_duration', 'subscriptions'],
  requestLabelAr: 'اشتراك',
  perEmployeeAvailability: false,
  orderLabels: const OrderLabels(
    incoming: 'طلبات اشتراك',
    accepted: 'اشتراكات مؤكدة',
    completed: 'اشتراكات منتهية',
    itemUnit: 'اشتراك',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'مدرب',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'موظف استقبال',
      defaultPermissions: ['manage_orders', 'respond_chat'],
    ),
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
  itemManagement: const ItemManagementConfig(
    sourceField: 'services',
    itemLabelAr: 'اشتراك',
    itemsLabelAr: 'الاشتراكات',
    addLabelAr: 'إضافة اشتراك',
    hasImage: false,
    hasCategory: true,
    hasDescription: true,
    hasPrice: true,
    properties: [
      ItemPropertyConfig(
        id: 'duration',
        labelAr: 'المدة',
        type: ItemPropertyType.text,
        required: true,
        placeholderAr: 'شهر واحد',
      ),
    ],
    quantityMode: QuantityMode.none,
    canDiscount: true,
  ),
  manageTabs: const [
    ManageTab(id: 'items', labelAr: 'الخدمات'),
    ManageTab(id: 'packages', labelAr: 'الباقات'),
  ],
);

// ─── Laundry ─────────────────────────────────────────────────

final laundry = createType(
  id: 'laundry',
  nameAr: 'مغسلة ملابس',
  nameEn: 'Laundry',
  categoryAr: 'غسيل وتنظيف',
  categoryEn: 'Laundry',
  archetype: Archetype.serviceBooking,
  icon: '👔',
  features: ['service_duration'],
  trackingMode: 'dropoff',
  requestLabelAr: 'طلب غسيل',
  customerCtaAr: 'تتبع ملابسك',
  customerCtaDescAr: 'سلّم ملابسك وتابع حالتها خطوة بخطوة',
  perEmployeeAvailability: false,
  dateSelection: DateSelection.none,
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
          key: 'received', label: 'مستلمة', icon: 'inbox'),
      DashboardStatLabel(
          key: 'processing', label: 'قيد المعالجة', icon: 'loader'),
      DashboardStatLabel(
          key: 'ready', label: 'جاهزة', icon: 'check-circle'),
      DashboardStatLabel(
          key: 'revenue_today', label: 'إيراد اليوم', icon: 'trending-up'),
    ],
    sections: [
      Section.stats,
      Section.liveDropoff,
      Section.revenue,
      Section.actions,
    ],
    quickActions: [
      DashboardAction(
          id: 'new_ticket',
          labelAr: 'استلام جديد',
          icon: 'plus',
          color: 'bg-blue-50 text-[#1A73E8]'),
      DashboardAction(
          id: 'add_service',
          labelAr: 'إضافة خدمة',
          icon: 'sparkles',
          color: 'bg-purple-50 text-purple-600'),
    ],
  ),
  orderLabels: const OrderLabels(
    incoming: 'تذاكر مستلمة',
    accepted: 'قيد المعالجة',
    completed: 'تم التسليم',
    itemUnit: 'قطعة',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'عامل غسيل',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'موظف استقبال',
      defaultPermissions: ['manage_orders', 'respond_chat'],
    ),
    SuggestedRole(
      labelAr: 'مدير',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
      ],
    ),
  ],
  itemManagement: const ItemManagementConfig(
    sourceField: 'services',
    itemLabelAr: 'خدمة',
    itemsLabelAr: 'الخدمات',
    addLabelAr: 'إضافة خدمة',
    hasImage: false,
    hasCategory: true,
    hasDescription: false,
    hasPrice: true,
    properties: [
      ItemPropertyConfig(
        id: 'duration',
        labelAr: 'المدة',
        type: ItemPropertyType.text,
        required: false,
        placeholderAr: '٢٤ ساعة',
      ),
    ],
    quantityMode: QuantityMode.open,
    canDiscount: true,
  ),
);

// ─── Car Wash ────────────────────────────────────────────────

final carWash = createType(
  id: 'car_wash',
  nameAr: 'مغسلة سيارات',
  nameEn: 'Car Wash',
  categoryAr: 'سيارات وصيانة',
  categoryEn: 'Car Wash',
  archetype: Archetype.serviceBooking,
  icon: '🚿',
  features: ['service_duration', 'packages'],
  requestLabelAr: 'حجز غسيل',
  customerCtaAr: 'احجز مكانك بالدور',
  customerCtaDescAr: 'اختر الخدمة واحجز مكانك — سنشعرك عندما يقترب دورك',
  perEmployeeAvailability: false,
  dateSelection: DateSelection.none,
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
          key: 'queue_size', label: 'بالدور الآن', icon: 'users'),
      DashboardStatLabel(
          key: 'completed_today', label: 'مكتمل اليوم', icon: 'check-circle'),
      DashboardStatLabel(
          key: 'revenue_today', label: 'إيراد اليوم', icon: 'trending-up'),
    ],
    sections: [
      Section.stats,
      Section.liveQueue,
      Section.revenue,
      Section.actions,
    ],
    quickActions: [
      DashboardAction(
          id: 'add_to_queue',
          labelAr: 'إضافة للدور',
          icon: 'plus',
          color: 'bg-blue-50 text-[#1A73E8]'),
      DashboardAction(
          id: 'add_service',
          labelAr: 'إضافة خدمة',
          icon: 'sparkles',
          color: 'bg-purple-50 text-purple-600'),
    ],
  ),
  orderLabels: const OrderLabels(
    incoming: 'بالانتظار',
    accepted: 'قيد الغسيل',
    completed: 'مكتمل',
    itemUnit: 'غسلة',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'عامل غسيل',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'عامل تفصيلي',
      defaultPermissions: ['manage_orders'],
    ),
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
  itemManagement: const ItemManagementConfig(
    sourceField: 'services',
    itemLabelAr: 'خدمة',
    itemsLabelAr: 'الخدمات',
    addLabelAr: 'إضافة خدمة',
    hasImage: false,
    hasCategory: true,
    hasDescription: true,
    hasPrice: true,
    properties: [
      ItemPropertyConfig(
        id: 'duration',
        labelAr: 'المدة التقديرية',
        type: ItemPropertyType.text,
        required: true,
        placeholderAr: '٣٠ دقيقة',
      ),
    ],
    quantityMode: QuantityMode.none,
    canDiscount: true,
  ),
  manageTabs: [MTab.services, MTab.packages],
);

// ─── Oil Change ─────────────────────────────────────────────

final oilChange = createType(
  id: 'oil_change',
  nameAr: 'تغيير زيت',
  nameEn: 'Oil Change / Quick Lube',
  categoryAr: 'سيارات وصيانة',
  categoryEn: 'Oil Change',
  archetype: Archetype.serviceBooking,
  icon: '🛢️',
  features: ['service_duration', 'packages'],
  requestLabelAr: 'حجز تغيير زيت',
  customerCtaAr: 'احجز مكانك بالدور',
  customerCtaDescAr: 'اختر نوع الزيت واحجز مكانك',
  perEmployeeAvailability: false,
  dateSelection: DateSelection.none,
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
          key: 'queue_size', label: 'بالدور الآن', icon: 'users'),
      DashboardStatLabel(
          key: 'completed_today', label: 'مكتمل اليوم', icon: 'check-circle'),
      DashboardStatLabel(
          key: 'revenue_today', label: 'إيراد اليوم', icon: 'trending-up'),
    ],
    sections: [
      Section.stats,
      Section.liveQueue,
      Section.revenue,
      Section.actions,
    ],
    quickActions: [
      DashboardAction(
          id: 'add_to_queue',
          labelAr: 'إضافة للدور',
          icon: 'plus',
          color: 'bg-blue-50 text-[#1A73E8]'),
      DashboardAction(
          id: 'add_service',
          labelAr: 'إضافة خدمة',
          icon: 'sparkles',
          color: 'bg-purple-50 text-purple-600'),
    ],
  ),
  orderLabels: const OrderLabels(
    incoming: 'بالانتظار',
    accepted: 'قيد التغيير',
    completed: 'مكتمل',
    itemUnit: 'تغيير',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'فني زيوت',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'مدير',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
      ],
    ),
  ],
  itemManagement: const ItemManagementConfig(
    sourceField: 'services',
    itemLabelAr: 'خدمة',
    itemsLabelAr: 'الخدمات',
    addLabelAr: 'إضافة خدمة',
    hasImage: false,
    hasCategory: true,
    hasDescription: true,
    hasPrice: true,
    properties: [
      ItemPropertyConfig(
        id: 'duration',
        labelAr: 'المدة التقديرية',
        type: ItemPropertyType.text,
        required: true,
        placeholderAr: '٢٠ دقيقة',
      ),
    ],
    quantityMode: QuantityMode.none,
    canDiscount: true,
  ),
  manageTabs: [MTab.services, MTab.packages],
);

// ─── Tire Shop ──────────────────────────────────────────────

final tireShop = createType(
  id: 'tire_shop',
  nameAr: 'محل كفرات',
  nameEn: 'Tire Shop',
  categoryAr: 'سيارات وصيانة',
  categoryEn: 'Tire Shop',
  archetype: Archetype.serviceBooking,
  icon: '🛞',
  features: ['service_duration', 'packages'],
  requestLabelAr: 'حجز خدمة كفرات',
  customerCtaAr: 'احجز مكانك بالدور',
  perEmployeeAvailability: false,
  dateSelection: DateSelection.none,
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
          key: 'queue_size', label: 'بالدور الآن', icon: 'users'),
      DashboardStatLabel(
          key: 'completed_today', label: 'مكتمل اليوم', icon: 'check-circle'),
      DashboardStatLabel(
          key: 'revenue_today', label: 'إيراد اليوم', icon: 'trending-up'),
    ],
    sections: [
      Section.stats,
      Section.liveQueue,
      Section.revenue,
      Section.actions,
    ],
    quickActions: [
      DashboardAction(
          id: 'add_to_queue',
          labelAr: 'إضافة للدور',
          icon: 'plus',
          color: 'bg-blue-50 text-[#1A73E8]'),
      DashboardAction(
          id: 'add_service',
          labelAr: 'إضافة خدمة',
          icon: 'sparkles',
          color: 'bg-purple-50 text-purple-600'),
    ],
  ),
  orderLabels: const OrderLabels(
    incoming: 'بالانتظار',
    accepted: 'قيد العمل',
    completed: 'مكتمل',
    itemUnit: 'خدمة',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'فني كفرات',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'مدير',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
      ],
    ),
  ],
  itemManagement: const ItemManagementConfig(
    sourceField: 'services',
    itemLabelAr: 'خدمة',
    itemsLabelAr: 'الخدمات',
    addLabelAr: 'إضافة خدمة',
    hasImage: false,
    hasCategory: true,
    hasDescription: true,
    hasPrice: true,
    properties: [
      ItemPropertyConfig(
        id: 'duration',
        labelAr: 'المدة التقديرية',
        type: ItemPropertyType.text,
        required: true,
        placeholderAr: '٤٥ دقيقة',
      ),
    ],
    quantityMode: QuantityMode.none,
    canDiscount: true,
  ),
  manageTabs: [MTab.services, MTab.packages],
);

// ─── Mobile Repair ───────────────────────────────────────────

final mobileRepair = createType(
  id: 'mobile_repair',
  nameAr: 'تصليح موبايلات',
  nameEn: 'Mobile Phone Repair',
  categoryAr: 'إلكترونيات وتقنية',
  categoryEn: 'Mobile Phone Repair',
  archetype: Archetype.serviceBooking,
  icon: '🔧',
  features: ['service_duration'],
  trackingMode: 'dropoff',
  requestLabelAr: 'طلب تصليح',
  customerCtaAr: 'تتبع جهازك',
  customerCtaDescAr: 'سلّم جهازك وتابع حالة التصليح خطوة بخطوة',
  perEmployeeAvailability: false,
  dateSelection: DateSelection.none,
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
          key: 'received', label: 'مستلمة', icon: 'inbox'),
      DashboardStatLabel(
          key: 'processing', label: 'قيد التصليح', icon: 'loader'),
      DashboardStatLabel(
          key: 'ready', label: 'جاهزة', icon: 'check-circle'),
      DashboardStatLabel(
          key: 'revenue_today', label: 'إيراد اليوم', icon: 'trending-up'),
    ],
    sections: [
      Section.stats,
      Section.liveDropoff,
      Section.revenue,
      Section.actions,
    ],
    quickActions: [
      DashboardAction(
          id: 'new_ticket',
          labelAr: 'استلام جديد',
          icon: 'plus',
          color: 'bg-blue-50 text-[#1A73E8]'),
      DashboardAction(
          id: 'add_service',
          labelAr: 'إضافة خدمة',
          icon: 'sparkles',
          color: 'bg-purple-50 text-purple-600'),
    ],
  ),
  orderLabels: const OrderLabels(
    incoming: 'أجهزة مستلمة',
    accepted: 'قيد التصليح',
    completed: 'تم التسليم',
    itemUnit: 'جهاز',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'فني تصليح',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'موظف استقبال',
      defaultPermissions: ['manage_orders', 'respond_chat'],
    ),
  ],
  itemManagement: const ItemManagementConfig(
    sourceField: 'services',
    itemLabelAr: 'خدمة',
    itemsLabelAr: 'خدمات التصليح',
    addLabelAr: 'إضافة خدمة',
    hasImage: false,
    hasCategory: true,
    hasDescription: true,
    hasPrice: true,
    properties: [
      ItemPropertyConfig(
        id: 'duration',
        labelAr: 'المدة التقديرية',
        type: ItemPropertyType.text,
        required: false,
        placeholderAr: '١ ساعة',
      ),
    ],
    quantityMode: QuantityMode.none,
    canDiscount: false,
  ),
);

// ─── Tailor ─────────────────────────────────────────────────

final tailor = createType(
  id: 'tailor',
  nameAr: 'خياط',
  nameEn: 'Tailor',
  categoryAr: 'أزياء وملابس',
  categoryEn: 'Tailor',
  archetype: Archetype.serviceBooking,
  icon: '🪡',
  features: ['service_duration'],
  trackingMode: 'dropoff',
  requestLabelAr: 'طلب خياطة',
  customerCtaAr: 'تتبع قطعتك',
  customerCtaDescAr: 'سلّم القطعة وتابع حالتها خطوة بخطوة',
  perEmployeeAvailability: false,
  dateSelection: DateSelection.none,
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
          key: 'received', label: 'مستلمة', icon: 'inbox'),
      DashboardStatLabel(
          key: 'processing', label: 'قيد الخياطة', icon: 'loader'),
      DashboardStatLabel(
          key: 'ready', label: 'جاهزة', icon: 'check-circle'),
      DashboardStatLabel(
          key: 'revenue_today', label: 'إيراد اليوم', icon: 'trending-up'),
    ],
    sections: [
      Section.stats,
      Section.liveDropoff,
      Section.revenue,
      Section.actions,
    ],
    quickActions: [
      DashboardAction(
          id: 'new_ticket',
          labelAr: 'استلام جديد',
          icon: 'plus',
          color: 'bg-blue-50 text-[#1A73E8]'),
      DashboardAction(
          id: 'add_service',
          labelAr: 'إضافة خدمة',
          icon: 'sparkles',
          color: 'bg-purple-50 text-purple-600'),
    ],
  ),
  orderLabels: const OrderLabels(
    incoming: 'قطع مستلمة',
    accepted: 'قيد الخياطة',
    completed: 'تم التسليم',
    itemUnit: 'قطعة',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'خياط',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'موظف استقبال',
      defaultPermissions: ['manage_orders', 'respond_chat'],
    ),
    SuggestedRole(
      labelAr: 'مدير',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
      ],
    ),
  ],
);

// ─── Shoe Repair ────────────────────────────────────────────

final shoeRepair = createType(
  id: 'shoe_repair',
  nameAr: 'إسكافي',
  nameEn: 'Shoe Repair',
  categoryAr: 'أزياء وملابس',
  categoryEn: 'Shoe Repair',
  archetype: Archetype.serviceBooking,
  icon: '👞',
  features: ['service_duration'],
  trackingMode: 'dropoff',
  requestLabelAr: 'طلب إصلاح',
  customerCtaAr: 'تتبع حذائك',
  customerCtaDescAr: 'سلّم الحذاء وتابع حالة الإصلاح خطوة بخطوة',
  perEmployeeAvailability: false,
  dateSelection: DateSelection.none,
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
          key: 'received', label: 'مستلمة', icon: 'inbox'),
      DashboardStatLabel(
          key: 'processing', label: 'قيد الإصلاح', icon: 'loader'),
      DashboardStatLabel(
          key: 'ready', label: 'جاهزة', icon: 'check-circle'),
      DashboardStatLabel(
          key: 'revenue_today', label: 'إيراد اليوم', icon: 'trending-up'),
    ],
    sections: [
      Section.stats,
      Section.liveDropoff,
      Section.revenue,
      Section.actions,
    ],
    quickActions: [
      DashboardAction(
          id: 'new_ticket',
          labelAr: 'استلام جديد',
          icon: 'plus',
          color: 'bg-blue-50 text-[#1A73E8]'),
      DashboardAction(
          id: 'add_service',
          labelAr: 'إضافة خدمة',
          icon: 'sparkles',
          color: 'bg-purple-50 text-purple-600'),
    ],
  ),
  orderLabels: const OrderLabels(
    incoming: 'أحذية مستلمة',
    accepted: 'قيد الإصلاح',
    completed: 'تم التسليم',
    itemUnit: 'حذاء',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'إسكافي',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'مدير',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
      ],
    ),
  ],
);

// ─── Watch Repair ───────────────────────────────────────────

final watchRepair = createType(
  id: 'watch_repair',
  nameAr: 'تصليح ساعات',
  nameEn: 'Watch Repair',
  categoryAr: 'إلكترونيات وتقنية',
  categoryEn: 'Watch Repair',
  archetype: Archetype.serviceBooking,
  icon: '⌚',
  features: ['service_duration'],
  trackingMode: 'dropoff',
  requestLabelAr: 'طلب تصليح ساعة',
  customerCtaAr: 'تتبع ساعتك',
  customerCtaDescAr: 'سلّم الساعة وتابع حالة التصليح خطوة بخطوة',
  perEmployeeAvailability: false,
  dateSelection: DateSelection.none,
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
          key: 'received', label: 'مستلمة', icon: 'inbox'),
      DashboardStatLabel(
          key: 'processing', label: 'قيد التصليح', icon: 'loader'),
      DashboardStatLabel(
          key: 'ready', label: 'جاهزة', icon: 'check-circle'),
      DashboardStatLabel(
          key: 'revenue_today', label: 'إيراد اليوم', icon: 'trending-up'),
    ],
    sections: [
      Section.stats,
      Section.liveDropoff,
      Section.revenue,
      Section.actions,
    ],
    quickActions: [
      DashboardAction(
          id: 'new_ticket',
          labelAr: 'استلام جديد',
          icon: 'plus',
          color: 'bg-blue-50 text-[#1A73E8]'),
      DashboardAction(
          id: 'add_service',
          labelAr: 'إضافة خدمة',
          icon: 'sparkles',
          color: 'bg-purple-50 text-purple-600'),
    ],
  ),
  orderLabels: const OrderLabels(
    incoming: 'ساعات مستلمة',
    accepted: 'قيد التصليح',
    completed: 'تم التسليم',
    itemUnit: 'ساعة',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'ساعاتي',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'مدير',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
      ],
    ),
  ],
);

// ─── Tutor ───────────────────────────────────────────────────

final tutor = createType(
  id: 'tutor',
  nameAr: 'مدرس خصوصي',
  nameEn: 'Private Tutor',
  categoryAr: 'تعليم وتدريب',
  categoryEn: 'Private Tutor',
  archetype: Archetype.serviceBooking,
  icon: '📖',
  features: ['service_duration', 'team_display'],
  requestLabelAr: 'حجز حصة',
  coverageModel: CoverageModel.serviceArea,
  coverageGranularity: CoverageGranularity.city,
  coverageLabelAr: 'نطاق التدريس',
  orderLabels: const OrderLabels(
    incoming: 'حجوزات جديدة',
    accepted: 'حصص مؤكدة',
    completed: 'حصص مكتملة',
    itemUnit: 'حصة',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'مدرس',
      defaultPermissions: [
        'manage_availability',
        'manage_orders',
        'respond_chat',
      ],
    ),
  ],
  itemManagement: const ItemManagementConfig(
    sourceField: 'services',
    itemLabelAr: 'مادة',
    itemsLabelAr: 'المواد',
    addLabelAr: 'إضافة مادة',
    hasImage: false,
    hasCategory: true,
    hasDescription: true,
    hasPrice: true,
    properties: [
      ItemPropertyConfig(
        id: 'duration',
        labelAr: 'مدة الحصة',
        type: ItemPropertyType.text,
        required: true,
        placeholderAr: '٦٠ دقيقة',
      ),
    ],
    quantityMode: QuantityMode.none,
    canDiscount: false,
    providerAssignment: true,
  ),
);

// ─── Driving School ──────────────────────────────────────────

final drivingSchool = createType(
  id: 'driving_school',
  nameAr: 'مدرسة سواقة',
  nameEn: 'Driving School',
  categoryAr: 'سيارات وصيانة',
  categoryEn: 'Driving School',
  archetype: Archetype.serviceBooking,
  icon: '🚗',
  features: ['service_duration', 'team_display'],
  requestLabelAr: 'حجز حصة',
  perEmployeeAvailability: true,
  orderLabels: const OrderLabels(
    incoming: 'حجوزات جديدة',
    accepted: 'حصص مؤكدة',
    completed: 'حصص مكتملة',
    itemUnit: 'حصة',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'مدرب سواقة',
      defaultPermissions: ['manage_availability', 'manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'موظف استقبال',
      defaultPermissions: ['manage_orders', 'respond_chat'],
    ),
  ],
  manageTabs: const [
    ManageTab(id: 'items', labelAr: 'الخدمات'),
    ManageTab(id: 'packages', labelAr: 'الباقات'),
  ],
);

// ─── Exported list ─────────────────────────────────────────

final serviceTypes = <BusinessTypeConfig>[
  salon,
  clinic,
  barber,
  dentist,
  gym,
  laundry,
  carWash,
  oilChange,
  tireShop,
  mobileRepair,
  tailor,
  shoeRepair,
  watchRepair,
  tutor,
  drivingSchool,
];
