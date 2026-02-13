import '../archetype.dart';
import '../business_type_config.dart';
import 'shared_definitions.dart';

// ═══════════════════════════════════════════════════════════════
// Service Booking — Archetype Default Config
// ═══════════════════════════════════════════════════════════════

const serviceBookingDefault = BusinessTypeConfig(
  id: '_service_booking_default',
  nameAr: 'خدمات',
  nameEn: 'Services',
  categoryAr: 'خدمات',
  categoryEn: 'Services',
  archetype: Archetype.serviceBooking,
  icon: '📋',
  features: ['service_duration', 'team_display'],
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
        color: 'bg-blue-50 text-[#1A73E8]',
      ),
      DashboardAction(
        id: 'manage_schedule',
        labelAr: 'تعديل المواعيد',
        icon: 'calendar',
        color: 'bg-green-50 text-[#43A047]',
      ),
    ],
  ),
  orderLabels: OrderLabels(
    incoming: 'حجوزات جديدة',
    accepted: 'حجوزات مؤكدة',
    completed: 'حجوزات مكتملة',
    itemUnit: 'خدمة',
  ),
  defaultEngagement: EngagementLevel.full,
  defaultOrderApproval: OrderApprovalMode.manual,
  coverageModel: CoverageModel.none,
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
  perEmployeeAvailability: true,
  dateSelection: DateSelection.required,
  suggestedRoles: [
    SuggestedRole(
      labelAr: 'موظف استقبال',
      defaultPermissions: ['manage_orders', 'respond_chat'],
    ),
    SuggestedRole(
      labelAr: 'مقدم خدمة',
      defaultPermissions: ['manage_availability', 'manage_orders'],
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
  qrTargets: [
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
      icon: 'scissors',
    ),
    QRTarget(
      id: 'info',
      labelAr: 'معلومات التواصل',
      section: 'info',
      icon: 'info',
    ),
  ],
  itemManagement: ItemManagementConfig(
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
        required: true,
        placeholderAr: '٣٠ دقيقة',
      ),
    ],
    quantityMode: QuantityMode.none,
    canDiscount: true,
    providerAssignment: true,
  ),
  manageTabs: [MTab.services],
  hasCustomersTab: true,
);
