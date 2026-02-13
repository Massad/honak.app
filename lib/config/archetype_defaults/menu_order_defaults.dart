import '../archetype.dart';
import '../business_type_config.dart';
import 'shared_definitions.dart';

// ═══════════════════════════════════════════════════════════════
// Menu Order — Archetype Default Config
// ═══════════════════════════════════════════════════════════════

const menuOrderDefault = BusinessTypeConfig(
  id: '_menu_order_default',
  nameAr: 'مطعم',
  nameEn: 'Restaurant',
  categoryAr: 'طعام ومشروبات',
  categoryEn: 'Food & Drink',
  archetype: Archetype.menuOrder,
  icon: '🍽️',
  features: ['menu_modifiers', 'delivery_zones', 'punch_cards'],
  insights: defaultInsights,
  requestLabelAr: 'طلب',
  dashboard: DashboardConfig(
    statsLabels: [
      DashboardStatLabel(
        key: 'requests_today',
        label: 'طلبات اليوم',
        icon: 'utensils',
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
      Section.queue,
      Section.pending,
      Section.actions,
      Section.bestSellers,
      Section.unavailable,
    ],
    quickActions: [
      DashboardAction(
        id: 'add_item',
        labelAr: 'إضافة صنف',
        icon: 'plus',
        color: 'bg-blue-50 text-[#1A73E8]',
      ),
      DashboardAction(
        id: 'daily_special',
        labelAr: 'عرض اليوم',
        icon: 'sparkles',
        color: 'bg-orange-50 text-[#FF9800]',
      ),
      DashboardAction(
        id: 'toggle_item',
        labelAr: 'إيقاف صنف',
        icon: 'eye-off',
        color: 'bg-red-50 text-[#E53935]',
      ),
    ],
  ),
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات قيد التحضير',
    completed: 'طلبات مكتملة',
    itemUnit: 'طبق',
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
      labelAr: 'شيف',
      defaultPermissions: ['manage_catalog'],
    ),
    SuggestedRole(
      labelAr: 'كاشير',
      defaultPermissions: ['manage_orders', 'respond_chat'],
    ),
    SuggestedRole(
      labelAr: 'موصّل',
      defaultPermissions: ['manage_orders'],
    ),
    SuggestedRole(
      labelAr: 'مدير فرع',
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
      id: 'menu',
      labelAr: 'القائمة',
      section: 'menu',
      icon: 'utensils-crossed',
    ),
    QRTarget(
      id: 'info',
      labelAr: 'معلومات التواصل',
      section: 'info',
      icon: 'info',
    ),
  ],
  itemManagement: ItemManagementConfig(
    sourceField: 'menu',
    itemLabelAr: 'صنف',
    itemsLabelAr: 'القائمة',
    addLabelAr: 'إضافة صنف',
    hasImage: true,
    hasCategory: true,
    hasDescription: true,
    hasPrice: true,
    properties: [
      ItemPropertyConfig(
        id: 'sizes',
        labelAr: 'الأحجام / الحصص',
        type: ItemPropertyType.chipList,
        hasPriceVariant: true,
        hasImages: true,
        placeholderAr: 'حجم جديد...',
      ),
    ],
    quantityMode: QuantityMode.open,
    canDiscount: true,
  ),
  manageTabs: [MTab.menu],
  hasCustomersTab: true,
);
