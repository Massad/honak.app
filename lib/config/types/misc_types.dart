import '../archetype.dart';
import '../archetype_defaults.dart';
import '../business_type_config.dart';

// ============================================================
// Misc Types -- follow_only, directory, portfolio_inquiry
// government, directory_mall, bank, exchange, real_estate
//
// NOTE: real_estate is in portfolio_types.dart
// NOTE: cinema and kids_play are in reservation_types.dart
// ============================================================

// ─── follow_only ────────────────────────────────────────────

final government = createType(
  id: 'government',
  nameAr: 'جهة حكومية',
  nameEn: 'Government',
  categoryAr: 'جهة حكومية',
  categoryEn: 'Government',
  archetype: Archetype.followOnly,
  icon: '\u{1F3DB}\uFE0F',
  features: ['alerts'],
  insights: const [
    InsightSection(
      title: 'التفاعل',
      cards: [
        InsightCard(
          id: 'reach',
          label: 'الوصول هذا الأسبوع',
          value: '٢,٤٠٠',
          trend: 'up',
          icon: 'eye',
        ),
        InsightCard(
          id: 'followers',
          label: 'متابعون جدد',
          value: '٢٤٥',
          trend: 'up',
          icon: 'users',
        ),
        InsightCard(
          id: 'alerts_sent',
          label: 'تنبيهات مرسلة',
          value: '٨',
          icon: 'bell',
        ),
        InsightCard(
          id: 'alert_reads',
          label: 'نسبة القراءة',
          value: '٧٨٪',
          trend: 'up',
          icon: 'check-circle',
        ),
      ],
    ),
    InsightSection(
      title: 'المنشورات',
      cards: [
        InsightCard(
          id: 'posts_count',
          label: 'منشورات هذا الشهر',
          value: '١٤',
          icon: 'file-text',
        ),
        InsightCard(
          id: 'avg_views',
          label: 'متوسط المشاهدات',
          value: '٣,٢٠٠',
          trend: 'up',
          icon: 'trending-up',
        ),
      ],
    ),
  ],
  requestLabelAr: 'متابعة',
  dashboard: DashboardConfig(
    statsLabels: const [
      DashboardStatLabel(
        key: 'page_views',
        label: 'مشاهدات',
        icon: 'eye',
      ),
      DashboardStatLabel(
        key: 'new_followers',
        label: 'متابعون جدد',
        icon: 'users',
      ),
      DashboardStatLabel(
        key: 'alerts_active',
        label: 'تنبيهات نشطة',
        icon: 'bell',
      ),
    ],
    sections: [Section.stats, Section.actions],
    quickActions: const [
      DashboardAction(
        id: 'new_alert',
        labelAr: 'تنبيه جديد',
        icon: 'alert-triangle',
        color: 'bg-amber-50 text-amber-700',
      ),
      DashboardAction(
        id: 'new_post',
        labelAr: 'منشور جديد',
        icon: 'edit-3',
        color: 'bg-blue-50 text-[#1A73E8]',
      ),
    ],
  ),
  orderLabels: const OrderLabels(
    incoming: 'واردة',
    accepted: 'نشطة',
    completed: 'منتهية',
    itemUnit: 'تنبيه',
  ),
  defaultOrderApproval: OrderApprovalMode.auto,
  availablePermissions: [
    Perm.postUpdates,
    Perm.viewInsights,
    Perm.manageSettings,
    Perm.manageTeam,
  ],
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'مدير محتوى',
      defaultPermissions: ['post_updates', 'view_insights'],
    ),
    SuggestedRole(
      labelAr: 'مسؤول إعلامي',
      defaultPermissions: ['post_updates', 'view_insights'],
    ),
    SuggestedRole(
      labelAr: 'مدير الصفحة',
      defaultPermissions: [
        'post_updates',
        'view_insights',
        'manage_settings',
        'manage_team',
      ],
    ),
  ],
  qrTargets: const [
    QRTarget(
      id: 'info',
      labelAr: 'معلومات',
      section: 'info',
      icon: 'info',
    ),
  ],
);

final bank = createType(
  id: 'bank',
  nameAr: 'بنك',
  nameEn: 'Bank',
  categoryAr: 'بنوك وصرافة',
  categoryEn: 'Banking',
  archetype: Archetype.followOnly,
  icon: '🏦',
  features: ['posts_only', 'links'],
);

final exchange = createType(
  id: 'exchange',
  nameAr: 'صرافة',
  nameEn: 'Currency Exchange',
  categoryAr: 'بنوك وصرافة',
  categoryEn: 'Exchange',
  archetype: Archetype.followOnly,
  icon: '💱',
  features: ['posts_only', 'links'],
);

// ─── directory ──────────────────────────────────────────────

final directoryMall = createType(
  id: 'directory',
  nameAr: 'مركز تجاري / مجمع',
  nameEn: 'Shopping Mall',
  categoryAr: 'مراكز تجارية',
  categoryEn: 'Shopping Mall',
  archetype: Archetype.directory,
  icon: '🏬',
  features: ['amenities_checklist'],
  insights: const [
    InsightSection(
      title: 'نظرة عامة',
      cards: [
        InsightCard(
          id: 'views',
          label: 'مشاهدات الصفحة',
          value: '٤٥,٢٠٠',
          trend: 'up',
          icon: 'eye',
        ),
        InsightCard(
          id: 'followers',
          label: 'المتابعون',
          value: '٢,٣٠٠',
          trend: 'up',
          icon: 'users',
        ),
        InsightCard(
          id: 'tenants',
          label: 'إجمالي المستأجرين',
          value: '٢٥',
          trend: 'up',
          icon: 'store',
        ),
        InsightCard(
          id: 'active',
          label: 'مفتوح حالياً',
          value: '٢٣',
          trend: 'up',
          icon: 'check-circle',
        ),
      ],
    ),
    InsightSection(
      title: 'التفاعل',
      cards: [
        InsightCard(
          id: 'directory_views',
          label: 'زيارات الدليل',
          value: '٢٠,٥٠٠',
          trend: 'up',
          icon: 'layout-grid',
        ),
        InsightCard(
          id: 'tenant_clicks',
          label: 'نقرات على المستأجرين',
          value: '٣,٨٠٠',
          trend: 'up',
          icon: 'mouse-pointer',
        ),
        InsightCard(
          id: 'search_queries',
          label: 'عمليات بحث',
          value: '٩٥٠',
          trend: 'up',
          icon: 'search',
        ),
      ],
    ),
    InsightSection(
      title: 'الطوابق الأكثر زيارة',
      cards: [
        InsightCard(
          id: 'floor_1',
          label: 'الطابق ٢ — أزياء',
          value: '٥,٢٠٠ زيار',
          trend: 'up',
          icon: 'crown',
        ),
        InsightCard(
          id: 'floor_2',
          label: 'الطابق ٢ — ساحة الطعام',
          value: '٤,١٠٠ زيارة',
          trend: 'up',
          icon: 'trending-up',
        ),
        InsightCard(
          id: 'floor_3',
          label: 'الطابق ٣ — ترفيه',
          value: '٢,٨٠٠ زيارة',
          trend: 'neutral',
          icon: 'map-pin',
        ),
      ],
    ),
  ],
  requestLabelAr: 'دليل',
  dashboard: DashboardConfig(
    statsLabels: const [
      DashboardStatLabel(
        key: 'page_views',
        label: 'مشاهدة',
        icon: 'eye',
      ),
      DashboardStatLabel(
        key: 'new_followers',
        label: 'متابع جديد',
        icon: 'users',
      ),
      DashboardStatLabel(
        key: 'claimed_tenants',
        label: 'مربوط',
        icon: 'store',
      ),
      DashboardStatLabel(
        key: 'new_this_week',
        label: 'جديد هذا الأسبوع',
        icon: 'user-plus',
      ),
    ],
    sections: [Section.stats, Section.recentlyLinked, Section.actions],
    quickActions: const [
      DashboardAction(
        id: 'add_tenant',
        labelAr: 'إضافة مستأجر',
        icon: 'plus',
        color: 'bg-blue-50 text-[#1A73E8]',
      ),
      DashboardAction(
        id: 'edit_featured',
        labelAr: 'المميزون',
        icon: 'sparkles',
        color: 'bg-orange-50 text-[#FF9800]',
      ),
      DashboardAction(
        id: 'new_post',
        labelAr: 'منشور جديد',
        icon: 'edit-3',
        color: 'bg-green-50 text-[#43A047]',
      ),
    ],
  ),
  orderLabels: const OrderLabels(
    incoming: 'طلبات ربط جديدة',
    accepted: 'مستأجرون مربوطون',
    completed: 'مستأجرون',
    itemUnit: 'مستأجر',
  ),
  defaultOrderApproval: OrderApprovalMode.auto,
  availablePermissions: [
    Perm.manageCatalog,
    Perm.respondChat,
    Perm.postUpdates,
    Perm.viewInsights,
    Perm.manageSettings,
    Perm.manageTeam,
  ],
  suggestedRoles: const [
    SuggestedRole(
      labelAr: 'مدير تسويق',
      defaultPermissions: ['post_updates', 'respond_chat', 'view_insights'],
    ),
    SuggestedRole(
      labelAr: 'مدير عمليات',
      defaultPermissions: ['manage_catalog', 'manage_settings'],
    ),
    SuggestedRole(
      labelAr: 'خدمة عملاء',
      defaultPermissions: ['respond_chat'],
    ),
    SuggestedRole(
      labelAr: 'مدير المول',
      defaultPermissions: [
        'manage_catalog',
        'respond_chat',
        'post_updates',
        'view_insights',
        'manage_settings',
        'manage_team',
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
      id: 'directory',
      labelAr: 'دليل المتاجر',
      section: 'directory',
      icon: 'layout-grid',
    ),
    QRTarget(
      id: 'info',
      labelAr: 'معلومات التواصل',
      section: 'info',
      icon: 'info',
    ),
  ],
);

/// All misc type configs (follow_only + directory).
final List<BusinessTypeConfig> miscTypes = [
  government,
  bank,
  exchange,
  directoryMall,
];
