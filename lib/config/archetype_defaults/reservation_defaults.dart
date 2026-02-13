import '../archetype.dart';
import '../business_type_config.dart';
import 'shared_definitions.dart';

// ═══════════════════════════════════════════════════════════════
// Reservation — Archetype Default Config
// ═══════════════════════════════════════════════════════════════

const reservationDefault = BusinessTypeConfig(
  id: '_reservation_default',
  nameAr: 'حجوزات',
  nameEn: 'Reservations',
  categoryAr: 'مناسبات وترفيه',
  categoryEn: 'Events & Entertainment',
  archetype: Archetype.reservation,
  icon: '🎫',
  features: ['spaces_calendar', 'packages', 'deposits'],
  insights: defaultInsights,
  requestLabelAr: 'حجز',
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
        key: 'requests_today',
        label: 'حجوزات اليوم',
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
      Section.occupancy,
      Section.upcomingRes,
      Section.pending,
      Section.actions,
      Section.revenue,
    ],
    quickActions: [
      DashboardAction(
        id: 'add_space',
        labelAr: 'إضافة مساحة',
        icon: 'plus',
        color: 'bg-blue-50 text-[#1A73E8]',
      ),
      DashboardAction(
        id: 'manage_calendar',
        labelAr: 'إدارة التقويم',
        icon: 'calendar',
        color: 'bg-green-50 text-[#43A047]',
      ),
    ],
  ),
  orderLabels: OrderLabels(
    incoming: 'طلبات حجز',
    accepted: 'حجوزات مؤكدة',
    completed: 'حجوزات منتهية',
    itemUnit: 'حجز',
  ),
  defaultEngagement: EngagementLevel.full,
  defaultOrderApproval: OrderApprovalMode.manual,
  coverageModel: CoverageModel.none,
  availablePermissions: [
    Perm.manageCatalog,
    Perm.manageOrders,
    Perm.respondChat,
    Perm.postUpdates,
    Perm.viewInsights,
    Perm.manageSettings,
    Perm.manageTeam,
  ],
  perEmployeeAvailability: false,
  dateSelection: DateSelection.required,
  suggestedRoles: [
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
  qrTargets: [
    QRTarget(
      id: 'page',
      labelAr: 'الصفحة الرئيسية',
      section: 'page',
      icon: 'store',
    ),
    QRTarget(
      id: 'spaces',
      labelAr: 'المساحات',
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
  manageTabs: [MTab.spaces, MTab.packages],
  hasCustomersTab: true,
);
