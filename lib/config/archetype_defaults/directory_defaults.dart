import '../archetype.dart';
import '../business_type_config.dart';
import 'shared_definitions.dart';

// ═══════════════════════════════════════════════════════════════
// Directory — Archetype Default Config
// ═══════════════════════════════════════════════════════════════

const directoryDefault = BusinessTypeConfig(
  id: '_directory_default',
  nameAr: 'مجمع تجاري',
  nameEn: 'Shopping Center',
  categoryAr: 'مجمعات تجارية',
  categoryEn: 'Shopping Centers',
  archetype: Archetype.directory,
  icon: '🏬',
  features: ['tenant_directory', 'floor_management', 'venue_maps'],
  insights: defaultInsights,
  requestLabelAr: '',
  dashboard: DashboardConfig(
    statsLabels: [
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
      DashboardStatLabel(
        key: 'tenants',
        label: 'مستأجرين',
        icon: 'store',
      ),
    ],
    sections: [
      Section.stats,
      Section.recentlyLinked,
      Section.actions,
    ],
    quickActions: [
      DashboardAction(
        id: 'add_tenant',
        labelAr: 'إضافة مستأجر',
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
    incoming: '',
    accepted: '',
    completed: '',
    itemUnit: '',
  ),
  defaultEngagement: EngagementLevel.visibility,
  defaultOrderApproval: OrderApprovalMode.manual,
  coverageModel: CoverageModel.none,
  availablePermissions: [
    Perm.manageCatalog,
    Perm.postUpdates,
    Perm.respondChat,
    Perm.viewInsights,
    Perm.manageSettings,
    Perm.manageTeam,
  ],
  perEmployeeAvailability: false,
  dateSelection: DateSelection.none,
  suggestedRoles: [
    SuggestedRole(
      labelAr: 'مدير المول',
      defaultPermissions: [
        'manage_catalog',
        'post_updates',
        'respond_chat',
        'view_insights',
        'manage_settings',
      ],
    ),
    SuggestedRole(
      labelAr: 'موظف استقبال',
      defaultPermissions: ['respond_chat'],
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
      id: 'directory',
      labelAr: 'الدليل',
      section: 'directory',
      icon: 'layout',
    ),
    QRTarget(
      id: 'info',
      labelAr: 'معلومات التواصل',
      section: 'info',
      icon: 'info',
    ),
  ],
  hasCustomersTab: false,
);
