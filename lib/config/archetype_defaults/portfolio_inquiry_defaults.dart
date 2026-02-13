import '../archetype.dart';
import '../business_type_config.dart';
import 'shared_definitions.dart';

// ═══════════════════════════════════════════════════════════════
// Portfolio Inquiry — Archetype Default Config
// ═══════════════════════════════════════════════════════════════

const portfolioInquiryDefault = BusinessTypeConfig(
  id: '_portfolio_inquiry_default',
  nameAr: 'خدمات إبداعية',
  nameEn: 'Creative Services',
  categoryAr: 'خدمات إبداعية',
  categoryEn: 'Creative Services',
  archetype: Archetype.portfolioInquiry,
  icon: '🎨',
  features: ['portfolio_gallery', 'ready_made_items', 'custom_order'],
  insights: defaultInsights,
  requestLabelAr: 'استفسار',
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
        key: 'requests_today',
        label: 'استفسارات اليوم',
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
    sections: [
      Section.stats,
      Section.pending,
      Section.actions,
      Section.revenue,
    ],
    quickActions: [
      DashboardAction(
        id: 'add_work',
        labelAr: 'إضافة عمل',
        icon: 'plus',
        color: 'bg-blue-50 text-[#1A73E8]',
      ),
      DashboardAction(
        id: 'create_post',
        labelAr: 'نشر تحديث',
        icon: 'edit-3',
        color: 'bg-purple-50 text-purple-600',
      ),
    ],
  ),
  orderLabels: OrderLabels(
    incoming: 'استفسارات جديدة',
    accepted: 'مشاريع مؤكدة',
    completed: 'مشاريع مكتملة',
    itemUnit: 'مشروع',
  ),
  defaultEngagement: EngagementLevel.full,
  defaultOrderApproval: OrderApprovalMode.manual,
  coverageModel: CoverageModel.serviceArea,
  coverageGranularity: CoverageGranularity.city,
  coverageLabelAr: 'نطاق العمل',
  availablePermissions: [
    Perm.manageCatalog,
    Perm.manageOrders,
    Perm.respondChat,
    Perm.postUpdates,
    Perm.viewInsights,
    Perm.manageSettings,
  ],
  perEmployeeAvailability: false,
  dateSelection: DateSelection.optional,
  suggestedRoles: [],
  qrTargets: [
    QRTarget(
      id: 'page',
      labelAr: 'الصفحة الرئيسية',
      section: 'page',
      icon: 'store',
    ),
    QRTarget(
      id: 'portfolio',
      labelAr: 'المعرض',
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
  manageTabs: [MTab.portfolio, MTab.pastWork],
  hasCustomersTab: true,
);
