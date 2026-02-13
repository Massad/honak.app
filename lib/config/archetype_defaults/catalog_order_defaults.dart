import '../archetype.dart';
import '../business_type_config.dart';
import 'shared_definitions.dart';

// ═══════════════════════════════════════════════════════════════
// Catalog Order — Archetype Default Config
// ═══════════════════════════════════════════════════════════════

const catalogOrderDefault = BusinessTypeConfig(
  id: '_catalog_order_default',
  nameAr: 'متجر',
  nameEn: 'Store',
  categoryAr: 'تسوق',
  categoryEn: 'Shopping',
  archetype: Archetype.catalogOrder,
  icon: '🛒',
  features: ['product_catalog', 'cart', 'order_tracking', 'inventory'],
  insights: defaultInsights,
  requestLabelAr: 'طلب',
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
        key: 'requests_today',
        label: 'طلبات اليوم',
        icon: 'shopping-bag',
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
      Section.pending,
      Section.actions,
      Section.bestSellers,
      Section.lowStock,
    ],
    quickActions: [
      DashboardAction(
        id: 'add_item',
        labelAr: 'إضافة منتج',
        icon: 'plus',
        color: 'bg-blue-50 text-[#1A73E8]',
      ),
      DashboardAction(
        id: 'toggle_item',
        labelAr: 'إيقاف منتج',
        icon: 'eye-off',
        color: 'bg-red-50 text-[#E53935]',
      ),
    ],
  ),
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات مؤكدة',
    completed: 'طلبات مكتملة',
    itemUnit: 'منتج',
  ),
  defaultEngagement: EngagementLevel.full,
  defaultOrderApproval: OrderApprovalMode.auto,
  coverageModel: CoverageModel.deliveryZone,
  coverageGranularity: CoverageGranularity.neighborhood,
  coverageLabelAr: 'مناطق التوصيل',
  showCoverageAreas: true,
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
  dateSelection: DateSelection.none,
  suggestedRoles: [
    SuggestedRole(
      labelAr: 'كاشير',
      defaultPermissions: ['manage_orders', 'respond_chat'],
    ),
    SuggestedRole(
      labelAr: 'موظف مخزون',
      defaultPermissions: ['manage_catalog'],
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
      id: 'catalog',
      labelAr: 'المنتجات',
      section: 'catalog',
      icon: 'package',
    ),
    QRTarget(
      id: 'info',
      labelAr: 'معلومات التواصل',
      section: 'info',
      icon: 'info',
    ),
  ],
  itemManagement: ItemManagementConfig(
    sourceField: 'catalog',
    itemLabelAr: 'منتج',
    itemsLabelAr: 'المنتجات',
    addLabelAr: 'إضافة منتج',
    hasImage: true,
    hasCategory: true,
    hasDescription: true,
    hasPrice: true,
    properties: [],
    quantityMode: QuantityMode.perItem,
    canDiscount: true,
  ),
  manageTabs: [MTab.items],
  hasCustomersTab: true,
);
