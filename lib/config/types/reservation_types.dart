import '../archetype.dart';
import '../archetype_defaults.dart';
import '../business_type_config.dart';

// ============================================================
// Reservation Types -- reservation archetype
// event_venue, villa_rental, farm_stay, cinema, kids_play
// ============================================================

final eventVenue = createType(
  id: 'event_venue',
  nameAr: 'قاعة مناسبات',
  nameEn: 'Event Venue',
  categoryAr: 'مناسبات وفعاليات',
  categoryEn: 'Events',
  archetype: Archetype.reservation,
  icon: '🏛️',
  features: ['spaces', 'reservation_form', 'photo_gallery'],
  insights: const [
    InsightSection(
      title: 'نظرة عامة',
      cards: [
        InsightCard(
          id: 'bookings_total',
          label: 'إجمالي الحجوزات',
          value: '٢,٣٠٠',
          trend: 'up',
          icon: 'calendar',
        ),
        InsightCard(
          id: 'revenue_month',
          label: 'إيراد الشهر',
          value: '٢٥,٥٠٠ د.أ',
          trend: 'up',
          icon: 'trending-up',
        ),
        InsightCard(
          id: 'occupancy',
          label: 'نسبة الإشغال',
          value: '٧٢٪',
          trend: 'up',
          icon: 'home',
        ),
        InsightCard(
          id: 'avg_event_size',
          label: 'متوسط الضيوف',
          value: '١٢٠',
          icon: 'users',
        ),
      ],
    ),
    InsightSection(
      title: 'أنواع المناسبات',
      cards: [
        InsightCard(
          id: 'weddings',
          label: 'أعراس',
          value: '٤٥٪',
          icon: 'heart',
        ),
        InsightCard(
          id: 'corporate',
          label: 'شركات',
          value: '٣٠٪',
          icon: 'briefcase',
        ),
        InsightCard(
          id: 'birthdays',
          label: 'أعياد ميلاد',
          value: '١٥٪',
          icon: 'cake',
        ),
        InsightCard(
          id: 'other',
          label: 'أخرى',
          value: '١٠٪',
          icon: 'more-horizontal',
        ),
      ],
    ),
  ],
  requestLabelAr: 'طلب حجز',
  dashboard: DashboardConfig(
    statsLabels: const [
      DashboardStatLabel(
        key: 'requests_today',
        label: 'طلبات حجز اليوم',
        icon: 'calendar',
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
    sections: [
      Section.stats,
      Section.revenue,
      Section.occupancy,
      Section.upcomingRes,
      Section.pending,
      Section.actions,
    ],
    quickActions: const [
      DashboardAction(
        id: 'add_photos',
        labelAr: 'إضافة صور',
        icon: 'camera',
        color: 'bg-blue-50 text-[#1A73E8]',
      ),
      DashboardAction(
        id: 'update_availability',
        labelAr: 'تحديث التوفر',
        icon: 'calendar',
        color: 'bg-green-50 text-[#43A047]',
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
    incoming: 'طلبات حجز جديدة',
    accepted: 'حجوزات مؤكدة',
    completed: 'مناسبات مكتملة',
    itemUnit: 'حجز',
  ),
  showCoverageAreas: false,
  availablePermissions: [
    Perm.manageCatalog,
    Perm.manageOrders,
    Perm.respondChat,
    Perm.postUpdates,
    Perm.viewInsights,
    Perm.manageSettings,
    Perm.manageTeam,
  ],
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'مدير القاعة',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
        'post_updates',
        'manage_settings',
      ],
    ),
    SuggestedRole(
      labelAr: 'منسق مناسبات',
      defaultPermissions: ['manage_orders', 'respond_chat'],
    ),
    SuggestedRole(
      labelAr: 'مسؤول حجوزات',
      defaultPermissions: ['manage_orders', 'respond_chat', 'manage_catalog'],
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
      id: 'spaces',
      labelAr: 'القاعات والمساحات',
      section: 'spaces',
      icon: 'layout',
    ),
    QRTarget(
      id: 'info',
      labelAr: 'معلومات التواصل',
      section: 'info',
      icon: 'info',
    ),
  ],
  itemManagement: const ItemManagementConfig(
    sourceField: 'spaces',
    itemLabelAr: 'قاعة / مساحة',
    itemsLabelAr: 'القاعات والمساحات',
    addLabelAr: 'إضافة قاعة',
    hasImage: true,
    hasCategory: false,
    hasDescription: true,
    hasPrice: true,
    properties: [
      ItemPropertyConfig(
        id: 'capacity',
        labelAr: 'السعة (أشخاص)',
        type: ItemPropertyType.number,
        required: true,
        placeholderAr: 'عدد الأشخاص',
      ),
    ],
    quantityMode: QuantityMode.none,
    canDiscount: false,
  ),
  manageTabs: const [
    ManageTab(id: 'items', labelAr: 'المساحات'),
    ManageTab(id: 'packages', labelAr: 'الباقات'),
  ],
  hasCustomersTab: true,
);

final villaRental = createType(
  id: 'villa_rental',
  nameAr: 'تأجير فلل',
  nameEn: 'Villa Rental',
  categoryAr: 'إقامة وعطلات',
  categoryEn: 'Vacation Rentals',
  archetype: Archetype.reservation,
  icon: '🏡',
  features: [
    'per_night_pricing',
    'amenities_checklist',
    'photo_gallery',
    'house_rules',
    'checkin_checkout',
    'max_guests',
  ],
  insights: const [
    InsightSection(
      title: 'نظرة عامة',
      cards: [
        InsightCard(
          id: 'occupancy',
          label: 'نسبة الإشغال',
          value: '٧٢٪',
          trend: 'up',
          icon: 'home',
        ),
        InsightCard(
          id: 'bookings_month',
          label: 'حجوزات هذا الشهر',
          value: '١٨',
          trend: 'up',
          icon: 'calendar',
        ),
        InsightCard(
          id: 'avg_stay',
          label: 'معدل مدة الإقامة',
          value: '٢.٥ ليلة',
          trend: 'up',
          icon: 'moon',
        ),
        InsightCard(
          id: 'revenue',
          label: 'الإيرادات هذا الشهر',
          value: '٤,٥٠٠ د.أ',
          trend: 'up',
          icon: 'banknote',
        ),
      ],
    ),
    InsightSection(
      title: 'أداء الحجوزات',
      cards: [
        InsightCard(
          id: 'weekend_rate',
          label: 'حجوزات نهاية الأسبوع',
          value: '٩٥٪',
          trend: 'up',
          icon: 'trending-up',
        ),
        InsightCard(
          id: 'weekday_rate',
          label: 'حجوزات أيام الأسبوع',
          value: '٤٥٪',
          trend: 'up',
          icon: 'trending-up',
        ),
        InsightCard(
          id: 'repeat_guests',
          label: 'ضيوف متكررون',
          value: '٣٢٪',
          trend: 'up',
          icon: 'repeat',
        ),
      ],
    ),
    InsightSection(
      title: 'الضيوف',
      cards: [
        InsightCard(
          id: 'total_guests',
          label: 'ضيوف هذا الشهر',
          value: '٨٥',
          trend: 'up',
          icon: 'users',
        ),
        InsightCard(
          id: 'avg_guests',
          label: 'معدل عدد الضيوف',
          value: '٦ أشخاص',
          trend: 'neutral',
          icon: 'users',
        ),
        InsightCard(
          id: 'new_guests',
          label: 'ضيوف جدد',
          value: '٤٠',
          trend: 'up',
          icon: 'user-plus',
        ),
      ],
    ),
  ],
  requestLabelAr: 'طلب حجز',
  dashboard: DashboardConfig(
    statsLabels: const [
      DashboardStatLabel(
        key: 'requests_today',
        label: 'طلبات حجز اليوم',
        icon: 'calendar',
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
    sections: [
      Section.stats,
      Section.revenue,
      Section.occupancy,
      Section.upcomingRes,
      Section.pending,
      Section.actions,
    ],
    quickActions: const [
      DashboardAction(
        id: 'add_photos',
        labelAr: 'إضافة صور',
        icon: 'camera',
        color: 'bg-blue-50 text-[#1A73E8]',
      ),
      DashboardAction(
        id: 'update_availability',
        labelAr: 'تحديث التوفر',
        icon: 'calendar',
        color: 'bg-green-50 text-[#43A047]',
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
    incoming: 'طلبات حجز جديدة',
    accepted: 'حجوزات مؤكدة',
    completed: 'حجوزات مكتملة',
    itemUnit: 'ليلة',
  ),
  showCoverageAreas: false,
  availablePermissions: [
    Perm.manageAvailability,
    Perm.manageCatalog,
    Perm.manageOrders,
    Perm.respondChat,
    Perm.postUpdates,
    Perm.viewInsights,
    Perm.manageSettings,
    Perm.manageTeam,
  ],
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'مدير العقار',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
        'manage_availability',
        'post_updates',
      ],
    ),
    SuggestedRole(
      labelAr: 'عامل نظافة',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'مسؤول استقبال',
      defaultPermissions: [
        'manage_orders',
        'respond_chat',
        'manage_availability',
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
      id: 'gallery',
      labelAr: 'معرض الصور',
      section: 'gallery',
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
    sourceField: 'spaces',
    itemLabelAr: 'مساحة',
    itemsLabelAr: 'المساحات',
    addLabelAr: 'إضافة مساحة',
    hasImage: true,
    hasCategory: false,
    hasDescription: true,
    hasPrice: true,
    properties: [
      ItemPropertyConfig(
        id: 'capacity',
        labelAr: 'السعة (أشخاص)',
        type: ItemPropertyType.number,
        required: true,
        placeholderAr: 'عدد الأشخاص',
      ),
    ],
    quantityMode: QuantityMode.none,
    canDiscount: false,
  ),
  manageTabs: const [ManageTab(id: 'items', labelAr: 'المساحات')],
  hasCustomersTab: true,
);

final farmStay = createType(
  id: 'farm_stay',
  nameAr: 'مزرعة',
  nameEn: 'Farm Stay',
  categoryAr: 'إقامة وعطلات',
  categoryEn: 'Farm Stay',
  archetype: Archetype.reservation,
  icon: '🌿',
  features: [
    'per_night_pricing',
    'amenities_checklist',
    'photo_gallery',
    'house_rules',
    'checkin_checkout',
    'max_guests',
    'outdoor_space',
    'campfire_area',
    'playground',
  ],
  insights: const [
    InsightSection(
      title: 'نظرة عامة',
      cards: [
        InsightCard(
          id: 'occupancy',
          label: 'نسبة الإشغال',
          value: '٦٠٪',
          trend: 'up',
          icon: 'home',
        ),
        InsightCard(
          id: 'bookings_month',
          label: 'حجوزات هذا الشهر',
          value: '١٢',
          trend: 'up',
          icon: 'calendar',
        ),
        InsightCard(
          id: 'avg_stay',
          label: 'معدل مدة الإقامة',
          value: '٢ ليلة',
          trend: 'up',
          icon: 'moon',
        ),
        InsightCard(
          id: 'revenue',
          label: 'الإيرادات هذا الشهر',
          value: '٢,٠٠٠ د.أ',
          trend: 'up',
          icon: 'banknote',
        ),
      ],
    ),
    InsightSection(
      title: 'أداء الحجوزات',
      cards: [
        InsightCard(
          id: 'weekend_rate',
          label: 'حجوزات نهاية الأسبوع',
          value: '٨٨٪',
          trend: 'up',
          icon: 'trending-up',
        ),
        InsightCard(
          id: 'repeat_guests',
          label: 'ضيوف متكررون',
          value: '٢٨٪',
          trend: 'up',
          icon: 'repeat',
        ),
        InsightCard(
          id: 'new_guests',
          label: 'ضيوف جدد هذا الشهر',
          value: '٢٥',
          trend: 'up',
          icon: 'user-plus',
        ),
      ],
    ),
  ],
  requestLabelAr: 'طلب حجز',
  dashboard: DashboardConfig(
    statsLabels: const [
      DashboardStatLabel(
        key: 'requests_today',
        label: 'طلبات حجز اليوم',
        icon: 'calendar',
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
    sections: [
      Section.stats,
      Section.revenue,
      Section.occupancy,
      Section.upcomingRes,
      Section.pending,
      Section.actions,
    ],
    quickActions: const [
      DashboardAction(
        id: 'add_photos',
        labelAr: 'إضافة صور',
        icon: 'camera',
        color: 'bg-blue-50 text-[#1A73E8]',
      ),
      DashboardAction(
        id: 'update_availability',
        labelAr: 'تحديث التوفر',
        icon: 'calendar',
        color: 'bg-green-50 text-[#43A047]',
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
    incoming: 'طلبات حجز جديدة',
    accepted: 'حجوزات مؤكدة',
    completed: 'مناسبات مكتملة',
    itemUnit: 'حجز',
  ),
  showCoverageAreas: false,
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'مدير العقار',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
        'post_updates',
        'manage_settings',
      ],
    ),
    SuggestedRole(
      labelAr: 'منسق مناسبات',
      defaultPermissions: ['manage_orders', 'respond_chat'],
    ),
    SuggestedRole(
      labelAr: 'مسؤول حجوزات',
      defaultPermissions: ['manage_orders', 'respond_chat', 'manage_catalog'],
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
      id: 'spaces',
      labelAr: 'القاعات والمساحات',
      section: 'spaces',
      icon: 'layout',
    ),
    QRTarget(
      id: 'info',
      labelAr: 'معلومات التواصل',
      section: 'info',
      icon: 'info',
    ),
  ],
  itemManagement: const ItemManagementConfig(
    sourceField: 'spaces',
    itemLabelAr: 'قاعة / مساحة',
    itemsLabelAr: 'القاعات والمساحات',
    addLabelAr: 'إضافة قاعة',
    hasImage: true,
    hasCategory: false,
    hasDescription: true,
    hasPrice: true,
    properties: [
      ItemPropertyConfig(
        id: 'capacity',
        labelAr: 'السعة (أشخاص)',
        type: ItemPropertyType.number,
        required: true,
        placeholderAr: 'عدد الأشخاص',
      ),
    ],
    quantityMode: QuantityMode.none,
    canDiscount: false,
  ),
  manageTabs: const [
    ManageTab(id: 'items', labelAr: 'المساحات'),
    ManageTab(id: 'packages', labelAr: 'الباقات'),
  ],
  hasCustomersTab: true,
);

final cinema = createType(
  id: 'cinema',
  nameAr: 'سينما',
  nameEn: 'Cinema',
  categoryAr: 'مناسبات وترفيه',
  categoryEn: 'Cinema',
  archetype: Archetype.reservation,
  icon: '🎬',
  requestLabelAr: 'حجز تذكرة',
  orderLabels: const OrderLabels(
    incoming: 'حجوزات جديدة',
    accepted: 'حجوزات مؤكدة',
    completed: 'عروض منتهية',
    itemUnit: 'تذكرة',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'موظف شباك',
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
    sourceField: 'catalog',
    itemLabelAr: 'فيلم / عرض',
    itemsLabelAr: 'العروض',
    addLabelAr: 'إضافة عرض',
    hasImage: true,
    hasCategory: true,
    hasDescription: true,
    hasPrice: true,
    properties: [
      ItemPropertyConfig(
        id: 'showtime',
        labelAr: 'أوقات العرض',
        type: ItemPropertyType.text,
        required: true,
        placeholderAr: '٧:٠٠ م، ٩:٣٠ م',
      ),
    ],
    quantityMode: QuantityMode.perItem,
    canDiscount: true,
  ),
);

final kidsPlay = createType(
  id: 'kids_play',
  nameAr: 'ألعاب أطفال / ملاهي',
  nameEn: 'Kids Play Area',
  categoryAr: 'مناسبات وترفيه',
  categoryEn: 'Kids Entertainment',
  archetype: Archetype.reservation,
  icon: '🎠',
  requestLabelAr: 'حجز',
  features: ['spaces_calendar', 'packages'],
  orderLabels: const OrderLabels(
    incoming: 'حجوزات جديدة',
    accepted: 'حجوزات مؤكدة',
    completed: 'حجوزات منتهية',
    itemUnit: 'حجز',
  ),
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'مشرف ألعاب',
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

/// All reservation type configs.
final List<BusinessTypeConfig> reservationTypes = [
  eventVenue,
  villaRental,
  farmStay,
  cinema,
  kidsPlay,
];
