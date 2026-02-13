import '../archetype.dart';
import '../business_type_config.dart';
import 'shared_definitions.dart';

// ═══════════════════════════════════════════════════════════════
// Follow Only — Archetype Default Config
// ═══════════════════════════════════════════════════════════════

const followOnlyDefault = BusinessTypeConfig(
  id: '_follow_only_default',
  nameAr: 'صفحة رسمية',
  nameEn: 'Official Page',
  categoryAr: 'جهات رسمية',
  categoryEn: 'Government',
  archetype: Archetype.followOnly,
  icon: '🏛️',
  features: ['posts_only', 'links'],
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
        key: 'posts_count',
        label: 'منشورات',
        icon: 'file-text',
      ),
    ],
    sections: [
      Section.stats,
      Section.posts,
      Section.actions,
    ],
    quickActions: [
      DashboardAction(
        id: 'create_post',
        labelAr: 'نشر تحديث',
        icon: 'edit-3',
        color: 'bg-blue-50 text-[#1A73E8]',
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
    Perm.postUpdates,
    Perm.respondChat,
    Perm.viewInsights,
    Perm.manageSettings,
  ],
  perEmployeeAvailability: false,
  dateSelection: DateSelection.none,
  suggestedRoles: [],
  qrTargets: [
    QRTarget(
      id: 'page',
      labelAr: 'الصفحة الرئيسية',
      section: 'page',
      icon: 'store',
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
