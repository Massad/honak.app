import '../archetype.dart';
import '../business_type_config.dart';

// ═══════════════════════════════════════════════════════════════
// Shared Permission Definitions
// ═══════════════════════════════════════════════════════════════

class Perm {
  Perm._();

  static const manageAvailability = PermissionMeta(
    id: 'manage_availability',
    labelAr: 'تعديل المواعيد',
    descAr: 'تعديل مواعيد العمل والحجوزات',
    icon: 'calendar',
  );

  static const manageCatalog = PermissionMeta(
    id: 'manage_catalog',
    labelAr: 'تعديل المنتجات',
    descAr: 'إضافة وتعديل المنتجات والأسعار',
    icon: 'package',
  );

  static const manageOrders = PermissionMeta(
    id: 'manage_orders',
    labelAr: 'إدارة الطلبات',
    descAr: 'قبول ورفض ومتابعة الطلبات',
    icon: 'shopping-bag',
  );

  static const respondChat = PermissionMeta(
    id: 'respond_chat',
    labelAr: 'الرد على المادثات',
    descAr: 'الرد على رسائل العملاء',
    icon: 'message-circle',
  );

  static const postUpdates = PermissionMeta(
    id: 'post_updates',
    labelAr: 'نشر تحديثات',
    descAr: 'إنشاء ونشر منشورات',
    icon: 'edit-3',
  );

  static const viewInsights = PermissionMeta(
    id: 'view_insights',
    labelAr: 'عرض الإحصائيات',
    descAr: 'الاطلاع على التحليلات والأرقام',
    icon: 'bar-chart-3',
  );

  static const manageSettings = PermissionMeta(
    id: 'manage_settings',
    labelAr: 'إعدادات الصفحة',
    descAr: 'تعديل معلومات الصفحة والإعدادات',
    icon: 'settings',
  );

  static const manageTeam = PermissionMeta(
    id: 'manage_team',
    labelAr: 'إدارة الفريق',
    descAr: 'إضافة وحذف أعضاء الفريق وصلاحياتهم',
    icon: 'users',
  );
}

// ═══════════════════════════════════════════════════════════════
// Shared Dashboard Sections
// ═══════════════════════════════════════════════════════════════

class Section {
  Section._();

  static const stats = DashboardSection(
    id: 'stats',
    titleAr: 'ملخص اليوم',
    type: DashboardSectionType.stats,
  );

  static const pending = DashboardSection(
    id: 'pending',
    titleAr: 'طلبات معلقة',
    type: DashboardSectionType.pendingOrders,
    minEngagement: EngagementLevel.full,
  );

  static const posts = DashboardSection(
    id: 'posts',
    titleAr: 'أحدث المنشورات',
    type: DashboardSectionType.recentPosts,
  );

  static const schedule = DashboardSection(
    id: 'schedule',
    titleAr: 'جدول اليوم',
    type: DashboardSectionType.todaySchedule,
    minEngagement: EngagementLevel.full,
  );

  static const quotes = DashboardSection(
    id: 'quotes',
    titleAr: 'عروض أسعار نشطة',
    type: DashboardSectionType.activeQuotes,
    minEngagement: EngagementLevel.full,
  );

  static const actions = DashboardSection(
    id: 'actions',
    titleAr: 'إجراءات سريعة',
    type: DashboardSectionType.quickActions,
  );

  static const revenue = DashboardSection(
    id: 'revenue',
    titleAr: 'إيرادات اليوم',
    type: DashboardSectionType.todayRevenue,
    minEngagement: EngagementLevel.full,
  );

  static const queue = DashboardSection(
    id: 'queue',
    titleAr: 'الطلبات النشطة',
    type: DashboardSectionType.activeQueue,
    minEngagement: EngagementLevel.full,
  );

  static const route = DashboardSection(
    id: 'route',
    titleAr: 'توصيلات اليوم',
    type: DashboardSectionType.deliveryRoute,
    minEngagement: EngagementLevel.full,
  );

  static const lowStock = DashboardSection(
    id: 'low_stock',
    titleAr: 'تنبيه المخزون',
    type: DashboardSectionType.lowStock,
    minEngagement: EngagementLevel.full,
  );

  static const occupancy = DashboardSection(
    id: 'occupancy',
    titleAr: 'الإشغال',
    type: DashboardSectionType.occupancy,
    minEngagement: EngagementLevel.full,
  );

  static const nextAppt = DashboardSection(
    id: 'next_appt',
    titleAr: 'الموعد القادم',
    type: DashboardSectionType.nextAppointment,
    minEngagement: EngagementLevel.full,
  );

  static const bestSellers = DashboardSection(
    id: 'best_sellers',
    titleAr: 'الأكثر طلباً',
    type: DashboardSectionType.bestSellers,
    minEngagement: EngagementLevel.full,
  );

  static const unavailable = DashboardSection(
    id: 'unavailable',
    titleAr: 'أصناف متوقفة',
    type: DashboardSectionType.unavailableItems,
    minEngagement: EngagementLevel.full,
  );

  static const upcomingRes = DashboardSection(
    id: 'upcoming_res',
    titleAr: 'حجوزات قادمة',
    type: DashboardSectionType.upcomingReservations,
    minEngagement: EngagementLevel.full,
  );

  static const recurringTomorrow = DashboardSection(
    id: 'recurring_tomorrow',
    titleAr: 'دور الغد',
    type: DashboardSectionType.recurringTomorrow,
    minEngagement: EngagementLevel.full,
  );

  static const customerInsights = DashboardSection(
    id: 'customer_insights',
    titleAr: 'تنبيهات العملاء',
    type: DashboardSectionType.customerInsights,
    minEngagement: EngagementLevel.full,
  );

  static const recentlyLinked = DashboardSection(
    id: 'recently_linked',
    titleAr: 'ربط حديث — مراجعة',
    type: DashboardSectionType.recentlyLinked,
  );

  static const liveQueue = DashboardSection(
    id: 'live_queue',
    titleAr: 'لوحة الدور',
    type: DashboardSectionType.liveQueue,
    minEngagement: EngagementLevel.full,
  );

  static const liveDropoff = DashboardSection(
    id: 'live_dropoff',
    titleAr: 'لوحة التتبع',
    type: DashboardSectionType.liveDropoff,
    minEngagement: EngagementLevel.full,
  );
}

// ═══════════════════════════════════════════════════════════════
// Shared Manage Tabs
// ═══════════════════════════════════════════════════════════════

class MTab {
  MTab._();

  static const items = ManageTab(id: 'items', labelAr: 'المنتجات');
  static const menu = ManageTab(id: 'items', labelAr: 'القائمة');
  static const services = ManageTab(id: 'items', labelAr: 'الخدمات');
  static const spaces = ManageTab(id: 'items', labelAr: 'المساحات');
  static const portfolio = ManageTab(id: 'items', labelAr: 'المعرض');
  static const pastWork = ManageTab(id: 'past_work', labelAr: 'أعمالنا');
  static const packages = ManageTab(id: 'packages', labelAr: 'الباقات');
  static const priceRange = ManageTab(id: 'price_range', labelAr: 'الأسعار');
}

// ═══════════════════════════════════════════════════════════════
// Alternative Suggestion Config Per Archetype
// ═══════════════════════════════════════════════════════════════

const alternativeConfig = <Archetype, AlternativeSuggestionConfig>{
  Archetype.catalogOrder: AlternativeSuggestionConfig(
    supportsStructured: true,
    itemPicker: true,
    showsTeam: false,
    showsTimeSlot: false,
    showsDate: false,
    showsDateRange: false,
    showsQuantity: true,
    showsVariation: true,
    priceMode: PriceMode.difference,
  ),
  Archetype.menuOrder: AlternativeSuggestionConfig(
    supportsStructured: true,
    itemPicker: true,
    showsTeam: false,
    showsTimeSlot: false,
    showsDate: false,
    showsDateRange: false,
    showsQuantity: true,
    showsVariation: false,
    priceMode: PriceMode.difference,
  ),
  Archetype.serviceBooking: AlternativeSuggestionConfig(
    supportsStructured: true,
    itemPicker: true,
    showsTeam: true,
    showsTimeSlot: true,
    showsDate: true,
    showsDateRange: false,
    showsQuantity: false,
    showsVariation: false,
    priceMode: PriceMode.difference,
  ),
  Archetype.quoteRequest: AlternativeSuggestionConfig(
    supportsStructured: true,
    itemPicker: true,
    showsTeam: false,
    showsTimeSlot: false,
    showsDate: true,
    showsDateRange: false,
    showsQuantity: false,
    showsVariation: false,
    priceMode: PriceMode.quote,
  ),
  Archetype.portfolioInquiry: AlternativeSuggestionConfig(
    supportsStructured: true,
    itemPicker: true,
    showsTeam: false,
    showsTimeSlot: false,
    showsDate: true,
    showsDateRange: false,
    showsQuantity: false,
    showsVariation: false,
    priceMode: PriceMode.quote,
  ),
  Archetype.reservation: AlternativeSuggestionConfig(
    supportsStructured: true,
    itemPicker: true,
    showsTeam: false,
    showsTimeSlot: false,
    showsDate: false,
    showsDateRange: true,
    showsQuantity: false,
    showsVariation: false,
    priceMode: PriceMode.difference,
  ),
  Archetype.followOnly: AlternativeSuggestionConfig(
    supportsStructured: false,
    itemPicker: false,
    showsTeam: false,
    showsTimeSlot: false,
    showsDate: false,
    showsDateRange: false,
    showsQuantity: false,
    showsVariation: false,
    priceMode: PriceMode.difference,
  ),
  Archetype.directory: AlternativeSuggestionConfig(
    supportsStructured: false,
    itemPicker: false,
    showsTeam: false,
    showsTimeSlot: false,
    showsDate: false,
    showsDateRange: false,
    showsQuantity: false,
    showsVariation: false,
    priceMode: PriceMode.difference,
  ),
};

// ═══════════════════════════════════════════════════════════════
// Default Insights (shared stub)
// ═══════════════════════════════════════════════════════════════

const defaultInsights = [
  InsightSection(
    title: 'نظرة عامة',
    cards: [
      InsightCard(
        id: 'views',
        label: 'مشاهدات الصفحة',
        value: '—',
        trend: 'neutral',
        icon: 'eye',
      ),
      InsightCard(
        id: 'followers',
        label: 'المتابعون',
        value: '—',
        trend: 'neutral',
        icon: 'users',
      ),
    ],
  ),
];
