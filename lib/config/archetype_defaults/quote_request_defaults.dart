import '../archetype.dart';
import '../business_type_config.dart';
import 'shared_definitions.dart';

// ═══════════════════════════════════════════════════════════════
// Quote Request — Archetype Default Config
// ═══════════════════════════════════════════════════════════════

const quoteRequestDefault = BusinessTypeConfig(
  id: '_quote_request_default',
  nameAr: 'خدمات منزلية',
  nameEn: 'Home Services',
  categoryAr: 'خدمات منزلية',
  categoryEn: 'Home Services',
  archetype: Archetype.quoteRequest,
  icon: '🔧',
  features: ['quote_form', 'photo_upload', 'urgency_levels'],
  insights: defaultInsights,
  requestLabelAr: 'طلب معاينة',
  customerCtaAr: 'اطلب معاينة',
  customerCtaDescAr: 'سيتم التواصل معك لتحديد موعد الزيارة',
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
        key: 'requests_today',
        label: 'طلبات اليوم',
        icon: 'file-text',
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
      Section.quotes,
      Section.pending,
      Section.actions,
      Section.revenue,
    ],
    quickActions: [
      DashboardAction(
        id: 'send_quote',
        labelAr: 'إرسال عرض سعر',
        icon: 'file-text',
        color: 'bg-blue-50 text-[#1A73E8]',
      ),
      DashboardAction(
        id: 'manage_schedule',
        labelAr: 'جدول المواعيد',
        icon: 'calendar',
        color: 'bg-green-50 text-[#43A047]',
      ),
    ],
  ),
  orderLabels: OrderLabels(
    incoming: 'طلبات معاينة',
    accepted: 'معاينات مؤكدة',
    completed: 'أعمال مكتملة',
    itemUnit: 'طلب',
  ),
  defaultEngagement: EngagementLevel.full,
  defaultOrderApproval: OrderApprovalMode.manual,
  coverageModel: CoverageModel.serviceArea,
  coverageGranularity: CoverageGranularity.city,
  coverageLabelAr: 'نطاق الخدمة',
  showCoverageAreas: true,
  availablePermissions: [
    Perm.manageOrders,
    Perm.respondChat,
    Perm.postUpdates,
    Perm.viewInsights,
    Perm.manageSettings,
    Perm.manageTeam,
  ],
  perEmployeeAvailability: false,
  dateSelection: DateSelection.optional,
  suggestedRoles: [
    SuggestedRole(
      labelAr: 'فني',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'مشرف',
      defaultPermissions: [
        'manage_orders',
        'respond_chat',
        'view_insights',
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
      icon: 'wrench',
    ),
    QRTarget(
      id: 'info',
      labelAr: 'معلومات التواصل',
      section: 'info',
      icon: 'info',
    ),
  ],
  manageTabs: [MTab.services, MTab.priceRange],
  hasCustomersTab: true,
);
