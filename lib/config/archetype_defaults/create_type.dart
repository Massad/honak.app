import '../archetype.dart';
import '../business_type_config.dart';
import 'catalog_order_defaults.dart';
import 'directory_defaults.dart';
import 'follow_only_defaults.dart';
import 'menu_order_defaults.dart';
import 'portfolio_inquiry_defaults.dart';
import 'quote_request_defaults.dart';
import 'reservation_defaults.dart';
import 'service_booking_defaults.dart';

// ═══════════════════════════════════════════════════════════════
// Archetype Default Registry
// ═══════════════════════════════════════════════════════════════

const _archetypeDefaults = <Archetype, BusinessTypeConfig>{
  Archetype.catalogOrder: catalogOrderDefault,
  Archetype.menuOrder: menuOrderDefault,
  Archetype.serviceBooking: serviceBookingDefault,
  Archetype.quoteRequest: quoteRequestDefault,
  Archetype.portfolioInquiry: portfolioInquiryDefault,
  Archetype.reservation: reservationDefault,
  Archetype.followOnly: followOnlyDefault,
  Archetype.directory: directoryDefault,
};

/// Returns the full default [BusinessTypeConfig] for the given [archetype].
///
/// Individual business types only need to override what differs from these
/// defaults. Use [createType] to merge overrides on top.
BusinessTypeConfig archetypeDefault(Archetype archetype) {
  return _archetypeDefaults[archetype]!;
}

// ═══════════════════════════════════════════════════════════════
// createType — merge archetype defaults with type-specific overrides
// ═══════════════════════════════════════════════════════════════

/// Create a full [BusinessTypeConfig] by merging archetype defaults with
/// type-specific overrides. Only specify what is DIFFERENT from the
/// archetype default.
///
/// Required overrides: [id], [nameAr], [nameEn], [icon], [categoryAr],
/// [categoryEn], [archetype].
///
/// Example:
/// ```dart
/// final waterDelivery = createType(
///   id: 'water_delivery',
///   nameAr: 'توصيل مياه',
///   nameEn: 'Water Delivery',
///   categoryAr: 'خدمات التوصيل',
///   categoryEn: 'Delivery Services',
///   archetype: Archetype.catalogOrder,
///   icon: '💧',
///   features: ['product_catalog', 'cart', 'order_tracking', 'inventory',
///              'recurring_orders', 'punch_cards', 'delivery_zones'],
/// );
/// ```
BusinessTypeConfig createType({
  required String id,
  required String nameAr,
  required String nameEn,
  required String icon,
  required String categoryAr,
  required String categoryEn,
  required Archetype archetype,
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
  final base = archetypeDefault(archetype);

  return BusinessTypeConfig(
    id: id,
    nameAr: nameAr,
    nameEn: nameEn,
    categoryAr: categoryAr,
    categoryEn: categoryEn,
    archetype: archetype,
    icon: icon,
    features: features ?? base.features,
    insights: insights ?? base.insights,
    requestLabelAr: requestLabelAr ?? base.requestLabelAr,
    customerCtaAr: customerCtaAr ?? base.customerCtaAr,
    customerCtaDescAr: customerCtaDescAr ?? base.customerCtaDescAr,
    dashboard: dashboard ?? base.dashboard,
    orderLabels: orderLabels ?? base.orderLabels,
    defaultEngagement: defaultEngagement ?? base.defaultEngagement,
    defaultOrderApproval: defaultOrderApproval ?? base.defaultOrderApproval,
    coverageModel: coverageModel ?? base.coverageModel,
    coverageGranularity: coverageGranularity ?? base.coverageGranularity,
    coverageLabelAr: coverageLabelAr ?? base.coverageLabelAr,
    showCoverageAreas: showCoverageAreas ?? base.showCoverageAreas,
    availablePermissions: availablePermissions ?? base.availablePermissions,
    perEmployeeAvailability:
        perEmployeeAvailability ?? base.perEmployeeAvailability,
    dateSelection: dateSelection ?? base.dateSelection,
    suggestedRoles: suggestedRoles ?? base.suggestedRoles,
    qrTargets: qrTargets ?? base.qrTargets,
    itemManagement: itemManagement ?? base.itemManagement,
    manageTabs: manageTabs ?? base.manageTabs,
    trackingMode: trackingMode ?? base.trackingMode,
    dropoffInfoTemplates: dropoffInfoTemplates ?? base.dropoffInfoTemplates,
    hasCustomersTab: hasCustomersTab ?? base.hasCustomersTab,
  );
}
