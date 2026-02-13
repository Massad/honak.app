import 'archetype.dart';

// ═══════════════════════════════════════════════════════════════
// Enums — Dart equivalents of TypeScript string unions
// ═══════════════════════════════════════════════════════════════

/// How deeply a business uses Honak.
enum EngagementLevel {
  /// "Just show I exist" -- info page, call/WhatsApp CTAs.
  visibility,

  /// "Show my menu/catalog but I handle orders elsewhere" -- QR menus, external links.
  showcase,

  /// "I want orders/bookings through Honak" -- native order flow.
  full;
}

/// Physical vs online presence.
enum StoreType {
  /// Brick-and-mortar store customers visit in person.
  physical,

  /// Online-only, delivery/shipping only.
  online,

  /// Both physical location and online delivery.
  hybrid;
}

/// How orders are processed.
enum OrderApprovalMode {
  /// Orders are automatically accepted when placed.
  auto,

  /// Each order requires manual review and approval.
  manual;
}

/// How the business relates to customer location.
enum CoverageModel {
  /// Customer goes to the business (salon, clinic, venue).
  none,

  /// Business delivers to customer (water, gas, restaurant).
  deliveryZone,

  /// Business sends someone to customer (plumber, photographer).
  serviceArea;

  String get key => switch (this) {
    none => 'none',
    deliveryZone => 'delivery_zone',
    serviceArea => 'service_area',
  };

  static CoverageModel fromKey(String key) => switch (key) {
    'none' => none,
    'delivery_zone' => deliveryZone,
    'service_area' => serviceArea,
    _ => throw ArgumentError('Unknown coverage model: $key'),
  };
}

/// Granularity of coverage (when [CoverageModel] is not [CoverageModel.none]).
enum CoverageGranularity {
  /// Very local (water, gas).
  street,

  /// Standard (restaurants, local delivery).
  neighborhood,

  /// City-wide (plumber, photographer).
  city,

  /// All of Jordan (e-commerce).
  national;
}

/// How date selection works in the customer request flow.
enum DateSelection {
  /// Customer MUST pick a date/slot (service_booking, reservation).
  required,

  /// Customer CAN suggest a preferred date (quote_request, portfolio_inquiry).
  optional,

  /// No date selection (catalog_order, menu_order, follow_only).
  none;
}

/// How quantity is tracked for an item type.
enum QuantityMode {
  /// Unlimited until manually marked out-of-stock.
  open,

  /// Stock tracked per variant combination (size x color).
  perVariant,

  /// Single stock number for the whole item.
  perItem,

  /// No quantity tracking (services, etc.).
  none;

  String get key => switch (this) {
    open => 'open',
    perVariant => 'per_variant',
    perItem => 'per_item',
    none => 'none',
  };

  static QuantityMode fromKey(String key) => switch (key) {
    'open' => open,
    'per_variant' => perVariant,
    'per_item' => perItem,
    'none' => none,
    _ => throw ArgumentError('Unknown quantity mode: $key'),
  };
}

/// Price display mode in alternative suggestion UI.
enum PriceMode {
  /// Show price difference from original.
  difference,

  /// Show full quote price.
  quote;
}

/// Type of a dashboard section widget.
enum DashboardSectionType {
  stats,
  pendingOrders,
  recentPosts,
  quickActions,
  todaySchedule,
  activeQuotes,
  todayRevenue,
  activeQueue,
  deliveryRoute,
  lowStock,
  occupancy,
  nextAppointment,
  bestSellers,
  unavailableItems,
  upcomingReservations,
  recurringTomorrow,
  customerInsights,
  recentlyLinked,
  liveQueue,
  liveDropoff;

  String get key => switch (this) {
    stats => 'stats',
    pendingOrders => 'pending_orders',
    recentPosts => 'recent_posts',
    quickActions => 'quick_actions',
    todaySchedule => 'today_schedule',
    activeQuotes => 'active_quotes',
    todayRevenue => 'today_revenue',
    activeQueue => 'active_queue',
    deliveryRoute => 'delivery_route',
    lowStock => 'low_stock',
    occupancy => 'occupancy',
    nextAppointment => 'next_appointment',
    bestSellers => 'best_sellers',
    unavailableItems => 'unavailable_items',
    upcomingReservations => 'upcoming_reservations',
    recurringTomorrow => 'recurring_tomorrow',
    customerInsights => 'customer_insights',
    recentlyLinked => 'recently_linked',
    liveQueue => 'live_queue',
    liveDropoff => 'live_dropoff',
  };

  static DashboardSectionType fromKey(String key) => switch (key) {
    'stats' => stats,
    'pending_orders' => pendingOrders,
    'recent_posts' => recentPosts,
    'quick_actions' => quickActions,
    'today_schedule' => todaySchedule,
    'active_quotes' => activeQuotes,
    'today_revenue' => todayRevenue,
    'active_queue' => activeQueue,
    'delivery_route' => deliveryRoute,
    'low_stock' => lowStock,
    'occupancy' => occupancy,
    'next_appointment' => nextAppointment,
    'best_sellers' => bestSellers,
    'unavailable_items' => unavailableItems,
    'upcoming_reservations' => upcomingReservations,
    'recurring_tomorrow' => recurringTomorrow,
    'customer_insights' => customerInsights,
    'recently_linked' => recentlyLinked,
    'live_queue' => liveQueue,
    'live_dropoff' => liveDropoff,
    _ => throw ArgumentError('Unknown dashboard section type: $key'),
  };
}

/// Type of an item property field.
enum ItemPropertyType {
  chipList,
  text,
  number,
  duration;

  String get key => switch (this) {
    chipList => 'chip_list',
    text => 'text',
    number => 'number',
    duration => 'duration',
  };

  static ItemPropertyType fromKey(String key) => switch (key) {
    'chip_list' => chipList,
    'text' => text,
    'number' => number,
    'duration' => duration,
    _ => throw ArgumentError('Unknown item property type: $key'),
  };
}

// ═══════════════════════════════════════════════════════════════
// Nested config classes
// ═══════════════════════════════════════════════════════════════

/// Labels for orders/requests in business mode.
class OrderLabels {
  /// Label for incoming/pending requests (e.g. 'طلبات جديدة').
  final String incoming;

  /// Label for accepted/in-progress requests (e.g. 'طلبات مؤكدة').
  final String accepted;

  /// Label for completed requests (e.g. 'طلبات مكتملة').
  final String completed;

  /// Singular unit label for items (e.g. 'منتج', 'طبق', 'خدمة').
  final String itemUnit;

  const OrderLabels({
    required this.incoming,
    required this.accepted,
    required this.completed,
    required this.itemUnit,
  });

  OrderLabels copyWith({
    String? incoming,
    String? accepted,
    String? completed,
    String? itemUnit,
  }) {
    return OrderLabels(
      incoming: incoming ?? this.incoming,
      accepted: accepted ?? this.accepted,
      completed: completed ?? this.completed,
      itemUnit: itemUnit ?? this.itemUnit,
    );
  }
}

/// A stat label displayed on the business dashboard header.
class DashboardStatLabel {
  final String key;
  final String label;
  final String icon;

  const DashboardStatLabel({
    required this.key,
    required this.label,
    required this.icon,
  });
}

/// A dashboard section shown in the business home.
class DashboardSection {
  final String id;
  final String titleAr;
  final DashboardSectionType type;

  /// Only show if the page has this engagement level or higher.
  final EngagementLevel? minEngagement;

  const DashboardSection({
    required this.id,
    required this.titleAr,
    required this.type,
    this.minEngagement,
  });
}

/// A quick-action button on the business dashboard.
class DashboardAction {
  final String id;
  final String labelAr;
  final String icon;
  final String color;

  const DashboardAction({
    required this.id,
    required this.labelAr,
    required this.icon,
    required this.color,
  });
}

/// Complete dashboard configuration for a business type.
class DashboardConfig {
  final List<DashboardStatLabel> statsLabels;
  final List<DashboardSection> sections;
  final List<DashboardAction> quickActions;

  const DashboardConfig({
    required this.statsLabels,
    required this.sections,
    this.quickActions = const [],
  });

  DashboardConfig copyWith({
    List<DashboardStatLabel>? statsLabels,
    List<DashboardSection>? sections,
    List<DashboardAction>? quickActions,
  }) {
    return DashboardConfig(
      statsLabels: statsLabels ?? this.statsLabels,
      sections: sections ?? this.sections,
      quickActions: quickActions ?? this.quickActions,
    );
  }
}

/// A tab on the business Manage screen (e.g. 'المنتجات', 'القائمة').
class ManageTab {
  final String id;
  final String labelAr;

  const ManageTab({
    required this.id,
    required this.labelAr,
  });
}

/// Permission metadata displayed in the team management UI.
class PermissionMeta {
  final String id;
  final String labelAr;
  final String descAr;
  final String icon;

  const PermissionMeta({
    required this.id,
    required this.labelAr,
    required this.descAr,
    required this.icon,
  });
}

/// A suggested team role with sensible default permissions.
class SuggestedRole {
  final String labelAr;
  final List<String> defaultPermissions;

  const SuggestedRole({
    required this.labelAr,
    required this.defaultPermissions,
  });
}

/// A QR code deep-link target section.
class QRTarget {
  final String id;
  final String labelAr;
  final String section;
  final String icon;

  const QRTarget({
    required this.id,
    required this.labelAr,
    required this.section,
    required this.icon,
  });
}

/// Defines a single property field that items can have.
class ItemPropertyConfig {
  final String id;
  final String labelAr;
  final ItemPropertyType type;
  final bool required;
  final bool hasPriceVariant;
  final bool hasImages;
  final String? placeholderAr;

  const ItemPropertyConfig({
    required this.id,
    required this.labelAr,
    required this.type,
    this.required = false,
    this.hasPriceVariant = false,
    this.hasImages = false,
    this.placeholderAr,
  });
}

/// Config-driven item management for a business type.
/// Drives the add/edit overlay and list view UI.
class ItemManagementConfig {
  /// Key on the page object where items live (e.g. 'catalog', 'menu', 'services').
  final String sourceField;

  /// Singular label (e.g. 'منتج').
  final String itemLabelAr;

  /// Plural label / section title (e.g. 'المنتجات').
  final String itemsLabelAr;

  /// Add button label (e.g. 'إضافة منتج').
  final String addLabelAr;

  final bool hasImage;
  final bool hasCategory;
  final bool hasDescription;
  final bool hasPrice;

  /// Label for the price field (e.g. 'السعر', 'سعر الخدمة', 'سعر الليلة').
  final String priceLabelAr;

  /// Whether items support quantity selection in requests.
  final bool hasQuantity;

  /// Dynamic properties this item type supports.
  final List<ItemPropertyConfig> properties;

  final QuantityMode quantityMode;

  /// Can items have discount (original_price, discount_percent, discount_ends)?
  final bool canDiscount;

  /// Does this type require provider-to-service assignment? (salon, clinic).
  final bool providerAssignment;

  const ItemManagementConfig({
    required this.sourceField,
    required this.itemLabelAr,
    required this.itemsLabelAr,
    required this.addLabelAr,
    required this.hasImage,
    required this.hasCategory,
    required this.hasDescription,
    required this.hasPrice,
    this.priceLabelAr = 'السعر',
    this.hasQuantity = true,
    this.properties = const [],
    required this.quantityMode,
    this.canDiscount = false,
    this.providerAssignment = false,
  });
}

/// An insight card shown on the business insights screen.
class InsightCard {
  final String id;
  final String label;
  final String value;
  final String trend;
  final String? icon;

  const InsightCard({
    required this.id,
    required this.label,
    required this.value,
    this.trend = 'neutral',
    this.icon,
  });
}

/// A section of insight cards grouped by title.
class InsightSection {
  final String title;
  final List<InsightCard> cards;

  const InsightSection({
    required this.title,
    required this.cards,
  });
}

/// Config for what the alternative suggestion UI shows per archetype.
class AlternativeSuggestionConfig {
  final bool supportsStructured;
  final bool itemPicker;
  final bool showsTeam;
  final bool showsTimeSlot;
  final bool showsDate;
  final bool showsDateRange;
  final bool showsQuantity;
  final bool showsVariation;
  final PriceMode priceMode;

  const AlternativeSuggestionConfig({
    required this.supportsStructured,
    required this.itemPicker,
    required this.showsTeam,
    required this.showsTimeSlot,
    required this.showsDate,
    required this.showsDateRange,
    required this.showsQuantity,
    required this.showsVariation,
    required this.priceMode,
  });
}

// ═══════════════════════════════════════════════════════════════
// BusinessTypeConfig — the master config class
// ═══════════════════════════════════════════════════════════════

/// The complete configuration for a business type.
///
/// This is the single source of truth for how a business Page looks and
/// behaves -- both on the customer side and the business side.
///
/// **Identity** — [id], [nameAr], [nameEn], [categoryAr], [categoryEn],
/// [archetype], [icon].
///
/// **Features** — [features] list of enabled feature flags (e.g.
/// 'recurring_orders', 'punch_cards').
///
/// **Customer-facing** — [requestLabelAr], [customerCtaAr],
/// [customerCtaDescAr] control what buttons and labels the customer sees.
///
/// **Dashboard** — [dashboard] controls the business home screen: stat
/// cards, sections, and quick-action buttons.
///
/// **Order labels** — [orderLabels] provides Arabic labels for the
/// request inbox tabs (incoming, accepted, completed) and item unit name.
///
/// **Engagement & approval** — [defaultEngagement], [defaultOrderApproval]
/// set the initial configuration when a page of this type is created.
///
/// **Coverage** — [coverageModel], [coverageGranularity], [coverageLabelAr],
/// [showCoverageAreas] define how location/delivery works.
///
/// **Permissions & team** — [availablePermissions], [suggestedRoles],
/// [perEmployeeAvailability] configure team management.
///
/// **Item management** — [itemManagement] drives the catalog/menu/services
/// CRUD UI in business mode.
///
/// **QR codes** — [qrTargets] define which page sections QR codes can link to.
class BusinessTypeConfig {
  // ─── Identity ─────────────────────────────────────────────
  final String id;
  final String nameAr;
  final String nameEn;
  final String categoryAr;
  final String categoryEn;
  final Archetype archetype;
  final String icon;

  // ─── Features ─────────────────────────────────────────────
  final List<String> features;

  // ─── Insights ─────────────────────────────────────────────
  final List<InsightSection> insights;

  // ─── Customer-facing labels ───────────────────────────────
  final String requestLabelAr;
  final String? customerCtaAr;
  final String? customerCtaDescAr;

  // ─── Dashboard ────────────────────────────────────────────
  final DashboardConfig dashboard;

  // ─── Order labels ─────────────────────────────────────────
  final OrderLabels orderLabels;

  // ─── Engagement & approval ────────────────────────────────
  final EngagementLevel defaultEngagement;
  final OrderApprovalMode defaultOrderApproval;

  // ─── Coverage ─────────────────────────────────────────────
  final CoverageModel coverageModel;
  final CoverageGranularity? coverageGranularity;
  final String? coverageLabelAr;
  final bool showCoverageAreas;

  // ─── Permissions & team ───────────────────────────────────
  final List<PermissionMeta> availablePermissions;
  final bool perEmployeeAvailability;
  final DateSelection dateSelection;
  final List<SuggestedRole> suggestedRoles;

  // ─── QR codes ─────────────────────────────────────────────
  final List<QRTarget> qrTargets;

  // ─── Item management ──────────────────────────────────────
  final ItemManagementConfig? itemManagement;

  // ─── Manage tabs ──────────────────────────────────────────
  final List<ManageTab>? manageTabs;

  // ─── Tracking mode ──────────────────────────────────────────
  /// 'dropoff' for ticket-based tracking (laundry, tailor, etc.).
  final String? trackingMode;

  /// Config-driven info request templates for dropoff businesses.
  final List<Map<String, dynamic>>? dropoffInfoTemplates;

  // ─── Display flags ────────────────────────────────────────
  final bool hasCustomersTab;

  const BusinessTypeConfig({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.categoryAr,
    required this.categoryEn,
    required this.archetype,
    required this.icon,
    required this.features,
    this.insights = const [],
    required this.requestLabelAr,
    this.customerCtaAr,
    this.customerCtaDescAr,
    required this.dashboard,
    required this.orderLabels,
    required this.defaultEngagement,
    required this.defaultOrderApproval,
    required this.coverageModel,
    this.coverageGranularity,
    this.coverageLabelAr,
    this.showCoverageAreas = false,
    required this.availablePermissions,
    required this.perEmployeeAvailability,
    required this.dateSelection,
    required this.suggestedRoles,
    required this.qrTargets,
    this.itemManagement,
    this.manageTabs,
    this.trackingMode,
    this.dropoffInfoTemplates,
    this.hasCustomersTab = true,
  });

  /// Create a copy with selected fields overridden.
  BusinessTypeConfig copyWith({
    String? id,
    String? nameAr,
    String? nameEn,
    String? categoryAr,
    String? categoryEn,
    Archetype? archetype,
    String? icon,
    List<String>? features,
    List<InsightSection>? insights,
    String? requestLabelAr,
    String? customerCtaAr,
    String? customerCtaDescAr,
    DashboardConfig? dashboard,
    OrderLabels? orderLabels,
    EngagementLevel? defaultEngagement,
    OrderApprovalMode? defaultOrderApproval,
    CoverageModel? coverageModel,
    CoverageGranularity? coverageGranularity,
    String? coverageLabelAr,
    bool? showCoverageAreas,
    List<PermissionMeta>? availablePermissions,
    bool? perEmployeeAvailability,
    DateSelection? dateSelection,
    List<SuggestedRole>? suggestedRoles,
    List<QRTarget>? qrTargets,
    ItemManagementConfig? itemManagement,
    List<ManageTab>? manageTabs,
    String? trackingMode,
    List<Map<String, dynamic>>? dropoffInfoTemplates,
    bool? hasCustomersTab,
  }) {
    return BusinessTypeConfig(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      categoryAr: categoryAr ?? this.categoryAr,
      categoryEn: categoryEn ?? this.categoryEn,
      archetype: archetype ?? this.archetype,
      icon: icon ?? this.icon,
      features: features ?? this.features,
      insights: insights ?? this.insights,
      requestLabelAr: requestLabelAr ?? this.requestLabelAr,
      customerCtaAr: customerCtaAr ?? this.customerCtaAr,
      customerCtaDescAr: customerCtaDescAr ?? this.customerCtaDescAr,
      dashboard: dashboard ?? this.dashboard,
      orderLabels: orderLabels ?? this.orderLabels,
      defaultEngagement: defaultEngagement ?? this.defaultEngagement,
      defaultOrderApproval: defaultOrderApproval ?? this.defaultOrderApproval,
      coverageModel: coverageModel ?? this.coverageModel,
      coverageGranularity: coverageGranularity ?? this.coverageGranularity,
      coverageLabelAr: coverageLabelAr ?? this.coverageLabelAr,
      showCoverageAreas: showCoverageAreas ?? this.showCoverageAreas,
      availablePermissions: availablePermissions ?? this.availablePermissions,
      perEmployeeAvailability:
          perEmployeeAvailability ?? this.perEmployeeAvailability,
      dateSelection: dateSelection ?? this.dateSelection,
      suggestedRoles: suggestedRoles ?? this.suggestedRoles,
      qrTargets: qrTargets ?? this.qrTargets,
      itemManagement: itemManagement ?? this.itemManagement,
      manageTabs: manageTabs ?? this.manageTabs,
      trackingMode: trackingMode ?? this.trackingMode,
      dropoffInfoTemplates: dropoffInfoTemplates ?? this.dropoffInfoTemplates,
      hasCustomersTab: hasCustomersTab ?? this.hasCustomersTab,
    );
  }
}
