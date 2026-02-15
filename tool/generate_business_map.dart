// =============================================================================
// Business Map Generator
// Generates docs/generated/BUSINESS_MAP.md + BUSINESS_MAP.html
//
// Run: dart run tool/generate_business_map.dart
//
// READS FROM: assets/api/pages/page_*.json (source of truth for types)
// Type list is auto-derived — no manual sync needed when adding new pages.
// Only update override maps below when a type has custom features/tracking.
// =============================================================================

import 'dart:convert';
import 'dart:io';

// ─── Data Model ──────────────────────────────────────────────────────────────

class ArchetypeInfo {
  final String id;
  final String nameAr;
  final String nameEn;
  final String customerAction;
  final String requestLabel;
  final String itemUnit;
  final List<String> customerPageSections;
  final String customerFlow;
  final List<String> dashboardSections;
  final List<String> manageTabs;
  final List<String> settingsSections;
  final String coverageModel;
  final String dateSelection;
  final String approval;
  final bool supportsRequests;
  final bool hasCatalog;
  final List<String> permissions;

  const ArchetypeInfo({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.customerAction,
    required this.requestLabel,
    required this.itemUnit,
    required this.customerPageSections,
    required this.customerFlow,
    required this.dashboardSections,
    required this.manageTabs,
    required this.settingsSections,
    required this.coverageModel,
    required this.dateSelection,
    required this.approval,
    required this.supportsRequests,
    required this.hasCatalog,
    required this.permissions,
  });
}

class TypeInfo {
  final String id;
  final String nameAr;
  final String nameEn;
  final String archetype;
  final String category;
  final List<String> features;
  final String? trackingMode; // null, 'queue', 'dropoff'
  final List<String>? overrideDashboard;
  final List<String>? overrideManageTabs;
  final List<String>? insights;
  final String? notes;

  const TypeInfo({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.archetype,
    required this.category,
    this.features = const [],
    this.trackingMode,
    this.overrideDashboard,
    this.overrideManageTabs,
    this.insights,
    this.notes,
  });
}

// ─── Archetype Definitions ───────────────────────────────────────────────────

const archetypes = <String, ArchetypeInfo>{
  'catalog_order': ArchetypeInfo(
    id: 'catalog_order',
    nameAr: 'طلب من الكتالوج',
    nameEn: 'Catalog Order',
    customerAction: '"I want these items"',
    requestLabel: 'طلب',
    itemUnit: 'منتج',
    customerPageSections: [
      'Hero (cover + logo + stats)',
      'Product grid with categories & filters',
      'Price + image + name per product',
      'Add to cart button',
      'Cart summary & checkout',
      'Delivery zone selector',
      'Posts tab (feed from page)',
      'Info tab (about, hours, location)',
    ],
    customerFlow: 'Browse catalog → Add to cart → Select delivery → Confirm order → Track',
    dashboardSections: ['stats', 'revenue', 'pending', 'actions', 'bestSellers', 'lowStock'],
    manageTabs: ['items (المنتجات)', 'packages (الباقات)'],
    settingsSections: [
      'Page status & relocation',
      'Page info (name, logo, description)',
      'Branches & locations',
      'Payment methods',
      'Operations (engagement, approval, return policy, coverage, catalog strategy)',
      'Team management',
      'Marketing & sharing',
      'Tools (catalog sync)',
    ],
    coverageModel: 'deliveryZone',
    dateSelection: 'none',
    approval: 'auto',
    supportsRequests: true,
    hasCatalog: true,
    permissions: [
      'manageCatalog', 'manageOrders', 'respondChat',
      'postUpdates', 'viewInsights', 'manageSettings', 'manageTeam',
    ],
  ),
  'menu_order': ArchetypeInfo(
    id: 'menu_order',
    nameAr: 'طلب من القائمة',
    nameEn: 'Menu Order',
    customerAction: '"I want these dishes"',
    requestLabel: 'أطلب',
    itemUnit: 'طبق',
    customerPageSections: [
      'Hero (cover + logo + stats)',
      'Menu with category tabs',
      'Items with modifiers (size, extras)',
      'Add to cart with customization',
      'Cart summary & checkout',
      'Posts tab',
      'Info tab (hours, location, menu PDF)',
    ],
    customerFlow: 'Browse menu → Customize (size/extras) → Cart → Confirm → Track',
    dashboardSections: ['stats', 'revenue', 'queue', 'pending', 'actions', 'bestSellers', 'unavailable'],
    manageTabs: ['menu (القائمة)', 'packages (الباقات)'],
    settingsSections: [
      'Page status & relocation',
      'Page info',
      'Branches & locations',
      'Payment methods',
      'Operations (engagement, approval, return policy, coverage, catalog strategy)',
      'Team management',
      'Marketing & sharing',
      'Tools (catalog sync)',
    ],
    coverageModel: 'deliveryZone',
    dateSelection: 'none',
    approval: 'auto',
    supportsRequests: true,
    hasCatalog: true,
    permissions: [
      'manageCatalog', 'manageOrders', 'respondChat',
      'postUpdates', 'viewInsights', 'manageSettings', 'manageTeam',
    ],
  ),
  'service_booking': ArchetypeInfo(
    id: 'service_booking',
    nameAr: 'حجز خدمة',
    nameEn: 'Service Booking',
    customerAction: '"I want this service at this time"',
    requestLabel: 'حجز',
    itemUnit: 'خدمة',
    customerPageSections: [
      'Hero (cover + logo + stats)',
      'Services list with durations & prices',
      'Team members (optional selection)',
      'Date & time picker',
      'Booking summary & confirm',
      'Posts tab',
      'Info tab (hours, team, location)',
    ],
    customerFlow: 'Pick service → Pick team member (optional) → Pick date/time → Confirm → Await approval',
    dashboardSections: ['stats', 'revenue', 'nextAppt', 'schedule', 'pending', 'actions'],
    manageTabs: ['services (الخدمات)', 'packages (الباقات)'],
    settingsSections: [
      'Page status & relocation',
      'Page info',
      'Branches & locations',
      'Payment methods',
      'Operations (engagement, approval, cancellation, intake questions)',
      'Team management',
      'Availability & schedule',
      'Marketing & sharing',
      'Tools (calendar sync)',
    ],
    coverageModel: 'none',
    dateSelection: 'required',
    approval: 'manual',
    supportsRequests: true,
    hasCatalog: true,
    permissions: [
      'manageAvailability', 'manageCatalog', 'manageOrders', 'respondChat',
      'postUpdates', 'viewInsights', 'manageSettings', 'manageTeam',
    ],
  ),
  'quote_request': ArchetypeInfo(
    id: 'quote_request',
    nameAr: 'طلب عرض سعر',
    nameEn: 'Quote Request',
    customerAction: '"I have this problem"',
    requestLabel: 'طلب معاينة',
    itemUnit: 'خدمة',
    customerPageSections: [
      'Hero (cover + logo + stats)',
      'Service categories',
      'Quote request form',
      'Photo upload',
      'Urgency selector',
      'Posts tab',
      'Info tab (coverage area, hours)',
    ],
    customerFlow: 'Describe problem → Attach photos → Set urgency → Submit → Business sends quote → Accept/decline',
    dashboardSections: ['stats', 'quotes', 'pending', 'actions', 'revenue'],
    manageTabs: ['services (الخدمات)', 'pastWork (أعمالنا)', 'priceRange (الأسعار)'],
    settingsSections: [
      'Page status & relocation',
      'Page info',
      'Location & service area',
      'Payment methods',
      'Operations (engagement, approval, quote form questions)',
      'Team management',
      'Marketing & sharing',
    ],
    coverageModel: 'serviceArea',
    dateSelection: 'optional',
    approval: 'manual',
    supportsRequests: true,
    hasCatalog: true,
    permissions: [
      'manageOrders', 'respondChat',
      'postUpdates', 'viewInsights', 'manageSettings', 'manageTeam',
    ],
  ),
  'portfolio_inquiry': ArchetypeInfo(
    id: 'portfolio_inquiry',
    nameAr: 'استفسار',
    nameEn: 'Portfolio Inquiry',
    customerAction: '"I want something like this"',
    requestLabel: 'استفسار',
    itemUnit: 'عمل',
    customerPageSections: [
      'Hero (cover + logo + stats)',
      'Portfolio gallery (masonry grid)',
      'Past work showcase',
      'Ready-made items (optional)',
      'Inquiry / custom order form',
      'Posts tab',
      'Info tab (about, pricing, coverage)',
    ],
    customerFlow: 'Browse portfolio → "I want something like this" → Describe request → Submit → Business responds with quote',
    dashboardSections: ['stats', 'pending', 'actions', 'revenue'],
    manageTabs: ['portfolio (المعرض)', 'pastWork (أعمالنا)', 'priceRange (الأسعار)'],
    settingsSections: [
      'Page status & relocation',
      'Page info',
      'Location & service area',
      'Payment methods',
      'Operations (engagement, approval)',
      'Team management',
      'Marketing & sharing',
    ],
    coverageModel: 'serviceArea',
    dateSelection: 'optional',
    approval: 'manual',
    supportsRequests: true,
    hasCatalog: true,
    permissions: [
      'manageOrders', 'respondChat',
      'postUpdates', 'viewInsights', 'manageSettings', 'manageTeam',
    ],
  ),
  'reservation': ArchetypeInfo(
    id: 'reservation',
    nameAr: 'حجز',
    nameEn: 'Reservation',
    customerAction: '"I want to book a space"',
    requestLabel: 'حجز',
    itemUnit: 'مساحة',
    customerPageSections: [
      'Hero (cover + logo + stats)',
      'Spaces/rooms with photos & capacity',
      'Calendar / date range picker',
      'Guest count selector',
      'Amenities checklist',
      'Safety disclaimers',
      'Reservation summary & confirm',
      'Posts tab',
      'Info tab (location, rules, policies)',
    ],
    customerFlow: 'Browse spaces → Pick dates → Set guest count → Review rules → Confirm → Await approval → Deposit',
    dashboardSections: ['stats', 'occupancy', 'upcomingRes', 'pending', 'actions', 'revenue'],
    manageTabs: ['spaces (المساحات)', 'packages (الباقات)', 'seasonalPricing (التسعير الموسمي)'],
    settingsSections: [
      'Page status & relocation',
      'Page info',
      'Branches & locations',
      'Payment methods',
      'Operations (engagement, approval, cancellation, venue settings)',
      'Safety & disclaimers',
      'Post-booking steps',
      'Team management',
      'Availability & schedule',
      'Marketing & sharing',
      'Tools (calendar sync)',
    ],
    coverageModel: 'none',
    dateSelection: 'required',
    approval: 'manual',
    supportsRequests: true,
    hasCatalog: true,
    permissions: [
      'manageAvailability', 'manageCatalog', 'manageOrders', 'respondChat',
      'postUpdates', 'viewInsights', 'manageSettings', 'manageTeam',
    ],
  ),
  'follow_only': ArchetypeInfo(
    id: 'follow_only',
    nameAr: 'متابعة فقط',
    nameEn: 'Follow-Only',
    customerAction: '"Just updates/info"',
    requestLabel: '',
    itemUnit: '',
    customerPageSections: [
      'Hero (cover + logo + stats)',
      'Posts feed (announcements, updates)',
      'Links section (website, social)',
      'Info tab (about, contact, hours)',
    ],
    customerFlow: 'Follow page → See posts in home feed → Contact via chat or phone',
    dashboardSections: ['stats', 'posts', 'actions'],
    manageTabs: [],
    settingsSections: [
      'Page status',
      'Page info',
      'Location',
      'Alert management',
      'Team management',
      'Marketing & sharing',
    ],
    coverageModel: 'none',
    dateSelection: 'none',
    approval: 'manual',
    supportsRequests: false,
    hasCatalog: false,
    permissions: ['postUpdates', 'respondChat', 'viewInsights', 'manageSettings'],
  ),
  'directory': ArchetypeInfo(
    id: 'directory',
    nameAr: 'دليل',
    nameEn: 'Directory',
    customerAction: '"What\'s inside?"',
    requestLabel: '',
    itemUnit: '',
    customerPageSections: [
      'Hero (cover + logo + stats)',
      'Tenant directory (searchable grid)',
      'Floor/category filter',
      'Tenant cards → link to tenant pages',
      'Amenities & facilities',
      'Posts tab',
      'Info tab (location, floors, hours)',
    ],
    customerFlow: 'Browse directory → Filter by floor/category → Tap tenant → View tenant page',
    dashboardSections: ['stats', 'recentlyLinked', 'actions'],
    manageTabs: [],
    settingsSections: [
      'Page status',
      'Page info',
      'Location',
      'Tenant management',
      'Team management',
      'Marketing & sharing',
    ],
    coverageModel: 'none',
    dateSelection: 'none',
    approval: 'manual',
    supportsRequests: false,
    hasCatalog: false,
    permissions: [
      'manageCatalog', 'respondChat',
      'postUpdates', 'viewInsights', 'manageSettings', 'manageTeam',
    ],
  ),
};

// ─── Business Types (auto-loaded from page fixtures) ─────────────────────────
//
// The type list is derived from assets/api/pages/page_*.json at runtime.
// Only override maps below need manual updates when a type has custom features.

late List<TypeInfo> allTypes; // populated in main()

// Override maps — only add entries for types that differ from archetype defaults.
// Types not listed here get empty features and 'standard' tracking.

const _typeFeatures = <String, List<String>>{
  'restaurant': ['menu_modifiers', 'delivery_zones', 'table_reservation', 'punch_cards'],
  'cafe': ['menu_modifiers', 'punch_cards'],
  'bakery': ['menu_modifiers', 'delivery_zones'],
  'sweet_shop': ['menu_modifiers', 'delivery_zones'],
  'fast_food': ['menu_modifiers', 'delivery_zones', 'punch_cards'],
  'water_delivery': ['recurring_orders', 'subscriptions', 'punch_cards', 'delivery_zones', 'delivery_time_slots'],
  'gas_delivery': ['recurring_orders', 'subscriptions', 'delivery_zones', 'delivery_time_slots'],
  'pharmacy': ['inventory'],
  'mini_market': ['inventory'],
  'electronics_store': ['inventory'],
  'clothes_store': ['size_variants', 'color_variants', 'inventory_tracking'],
  'bookstore': ['inventory_tracking', 'delivery_zones'],
  'online_store': ['size_variants', 'color_variants', 'inventory_tracking', 'delivery_zones'],
  'salon': ['service_duration', 'team_display', 'subscriptions', 'punch_cards', 'loyalty_points'],
  'clinic': ['service_duration', 'team_display', 'multi_location'],
  'barber': ['service_duration', 'team_display', 'punch_cards'],
  'dentist': ['service_duration', 'team_display'],
  'gym': ['service_duration', 'subscriptions'],
  'tutor': ['service_duration', 'team_display'],
  'driving_school': ['service_duration', 'team_display'],
  'car_wash': ['service_duration', 'packages'],
  'oil_change': ['service_duration', 'packages'],
  'tire_shop': ['service_duration', 'packages'],
  'laundry': ['service_duration'],
  'mobile_repair': ['service_duration'],
  'tailor': ['service_duration'],
  'shoe_repair': ['service_duration'],
  'watch_repair': ['service_duration'],
  'plumber': ['quote_form', 'service_area'],
  'photographer': ['portfolio_gallery', 'ready_made_items', 'custom_order'],
  'real_estate': ['portfolio_gallery', 'ready_made_items'],
  'event_venue': ['spaces', 'reservation_form', 'photo_gallery'],
  'villa_rental': ['per_night_pricing', 'amenities_checklist', 'photo_gallery', 'house_rules', 'checkin_checkout', 'max_guests'],
  'hotel': ['per_night_pricing', 'amenities_checklist', 'photo_gallery'],
  'camping': ['per_night_pricing', 'amenities_checklist', 'photo_gallery', 'outdoor_space'],
  'government': ['alerts'],
  'bank': ['posts_only', 'links'],
  'exchange': ['posts_only', 'links'],
  'directory': ['tenant_directory', 'floor_management', 'amenities_checklist'],
};

const _typeTrackingModes = <String, String>{
  'car_wash': 'queue', 'oil_change': 'queue', 'tire_shop': 'queue',
  'laundry': 'dropoff', 'mobile_repair': 'dropoff', 'tailor': 'dropoff',
  'shoe_repair': 'dropoff', 'watch_repair': 'dropoff',
};

const _typeNotes = <String, String>{
  'gym': 'perEmployeeAvailability=false',
  'car_wash': 'No appointments — live queue',
  'oil_change': 'No appointments — live queue',
  'tire_shop': 'No appointments — live queue',
  'laundry': 'Item dropoff + status tracking',
  'mobile_repair': 'Item dropoff + status tracking',
  'tailor': 'Item dropoff + status tracking',
  'shoe_repair': 'Item dropoff + status tracking',
  'watch_repair': 'Item dropoff + status tracking',
};

// English name overrides for types where title-casing the ID isn't enough
const _typeEnglishNames = <String, String>{
  'ac_repair': 'AC Repair',
  'mobile_repair': 'Phone Repair',
};

// Category display names (from explore_category → display)
// Fixture categories use cat_ prefix (e.g. cat_food, cat_retail)
const _categoryDisplayNames = <String, String>{
  'cat_food': 'Food & Dining',
  'cat_delivery': 'Delivery',
  'cat_grocery': 'Grocery',
  'cat_retail': 'Retail & Shopping',
  'cat_beauty': 'Beauty',
  'cat_health': 'Health',
  'cat_auto': 'Auto',
  'cat_home_services': 'Home Services',
  'cat_creative': 'Creative',
  'cat_entertainment': 'Entertainment',
  'cat_stays': 'Stays',
  'cat_government': 'Government',
  'cat_services': 'Services',
  'cat_malls': 'Shopping Centers',
  'cat_fitness': 'Fitness',
  'cat_electronics': 'Electronics',
};

/// Reads page fixture files to discover all business types automatically.
List<TypeInfo> _loadTypesFromFixtures() {
  final pagesDir = Directory('assets/api/pages');
  if (!pagesDir.existsSync()) {
    print('WARNING: assets/api/pages/ not found — using empty type list');
    return [];
  }

  final typeMap = <String, TypeInfo>{};

  for (final file in pagesDir.listSync()) {
    if (file is! File || !file.path.endsWith('.json')) continue;
    if (file.path.contains('pages_list.json')) continue; // skip generated file

    try {
      final raw = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      // Page fixtures wrap content in { "success": true, "data": { ... } }
      final json = (raw.containsKey('data') ? raw['data'] : raw) as Map<String, dynamic>;
      final typeId = json['business_type_id'] as String?;
      if (typeId == null || typeMap.containsKey(typeId)) continue;

      final archetype = json['archetype'] as String? ?? 'follow_only';
      final nameAr = json['business_type_name'] as String? ?? typeId;
      final rawCategory = json['explore_category'] as String? ?? '';
      final category = _categoryDisplayNames[rawCategory] ?? _titleCase(rawCategory);
      final nameEn = _typeEnglishNames[typeId] ?? _titleCase(typeId);

      typeMap[typeId] = TypeInfo(
        id: typeId,
        nameAr: nameAr,
        nameEn: nameEn,
        archetype: archetype,
        category: category,
        features: _typeFeatures[typeId] ?? const [],
        trackingMode: _typeTrackingModes[typeId],
        notes: _typeNotes[typeId],
      );
    } catch (e) {
      print('WARNING: Failed to parse ${file.path}: $e');
    }
  }

  // Sort: group by archetype, then alphabetically within each group
  final archetypeOrder = archetypes.keys.toList();
  final result = typeMap.values.toList()
    ..sort((a, b) {
      final ai = archetypeOrder.indexOf(a.archetype);
      final bi = archetypeOrder.indexOf(b.archetype);
      if (ai != bi) return ai.compareTo(bi);
      return a.id.compareTo(b.id);
    });

  return result;
}

String _titleCase(String snakeCase) {
  if (snakeCase.isEmpty) return snakeCase;
  return snakeCase.split('_').map((w) =>
    w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}'
  ).join(' ');
}

// ─── Detailed Feature Data (for interactive HTML) ────────────────────────────

const _customerPageTabs = <String, List<String>>{
  'catalog_order': ['المنتجات Products', 'نشاط Activity', 'معلومات Info'],
  'menu_order': ['القائمة Menu', 'نشاط Activity', 'معلومات Info'],
  'service_booking': ['الخدمات Services', 'نشاط Activity', 'معلومات Info'],
  'quote_request': ['نظرة عامة Overview', 'نشاط Activity', 'معلومات Info'],
  'portfolio_inquiry': ['الأعمال Portfolio', 'نشاط Activity', 'معلومات Info'],
  'reservation': ['الأماكن Spaces', 'نشاط Activity', 'معلومات Info'],
  'follow_only': ['نشاط Activity', 'معلومات Info'],
  'directory': ['نظرة عامة Overview', 'الدليل Directory', 'نشاط Activity', 'معلومات Info'],
};

const _customerMainSections = <String, List<String>>{
  'catalog_order': [
    'Specials banner (if active)',
    'Category filter pills',
    'Search + filter sheet (in-stock, price range, sort)',
    'Product grid: image, name, price, quantity controls',
    'Floating cart bar → OrderRequestSheet',
  ],
  'menu_order': [
    'Modifiers note banner (if set)',
    'Category filter pills',
    'Menu items: image, name, price, modifier badge',
    'Item config sheet (size, extras, add-ons)',
    'Floating cart bar → OrderRequestSheet',
  ],
  'service_booking': [
    'Packages section (if available)',
    'Category filter pills',
    'Search bar',
    'Service list: name, duration, price, book button',
    'Team members grid (if team)',
    'BookingWizardSheet: team → date/time → confirm',
  ],
  'quote_request': [
    'Services offered list',
    'Service areas chips',
    'Price range display',
    'CTA: QuoteRequestSheet (describe, photos, urgency)',
  ],
  'portfolio_inquiry': [
    'Category filter pills',
    '3-column masonry gallery grid',
    'Image viewer dialog on tap',
    'Custom work CTA card',
    'Floating action button → InquiryRequestSheet',
  ],
  'reservation': [
    'Villa detail card (if villa/chalet)',
    'Gallery strip (if event venue)',
    'Category pills',
    'Space cards: hero image, name, capacity, price/night',
    'Booked overlay when unavailable',
    'ReservationRequestSheet: dates → details → questions → confirm',
  ],
  'follow_only': [
    'Alerts cards (priority-colored, area labels)',
    'About extended text',
    'Services/links list (tappable URLs)',
    'Empty state: follow for updates',
  ],
  'directory': [
    'Directory stats grid (total stores, floors, parking)',
    'Announcements carousel',
    'Featured tenants section',
    'Floor preview (grouped by floor/category)',
    'Amenities grid (WiFi, parking, ATM, etc.)',
    'Parking banner',
  ],
};

const _customerRequestSheets = <String, String>{
  'catalog_order': 'OrderRequestSheet: cart summary → delivery/pickup toggle → address → payment → notes → submit',
  'menu_order': 'OrderRequestSheet: cart summary → delivery/pickup toggle → address → payment → notes → submit',
  'service_booking': 'BookingWizardSheet: pick team (optional) → pick date/time → confirm + notes',
  'quote_request': 'QuoteRequestSheet: describe problem → attach photos → urgency → preferred date → location → submit',
  'portfolio_inquiry': 'InquiryRequestSheet: describe request → reference photos → preferred date → submit',
  'reservation': 'ReservationRequestSheet: check-in/out dates → space → guest count → occasion → notes → review rules → confirm',
};

const _activityTabFilters = <String, List<String>>{
  'catalog_order': ['الكل', 'منتجات', 'عروض', 'تحديثات', 'صور'],
  'menu_order': ['الكل', 'منتجات', 'عروض', 'تحديثات', 'صور'],
  'service_booking': ['الكل', 'عروض', 'تحديثات', 'صور'],
  'quote_request': ['الكل', 'تحديثات', 'صور'],
  'portfolio_inquiry': ['الكل', 'تحديثات', 'صور'],
  'reservation': ['الكل', 'تحديثات', 'صور'],
  'follow_only': ['الكل', 'تحديثات', 'صور'],
  'directory': ['الكل', 'تحديثات', 'صور'],
};

const _infoTabSections = [
  'Service availability chips (delivery/pickup/booking)',
  'Delivery details (fee, minimum order, estimated time)',
  'Cancellation policy',
  'Working hours (7-day schedule)',
  'Branches / location',
  'Coverage zones',
  'Payment methods',
  'Contact (phone, WhatsApp, CliQ, links)',
  'Return policy (if applicable)',
  'Stats footer (followers, member since)',
];

const _actionBarItems = <String, List<String>>{
  'catalog_order': ['Follow', 'Message', 'Call (icon)', 'WhatsApp (icon)', 'Overflow'],
  'menu_order': ['Follow', 'Message', 'Call (icon)', 'WhatsApp (icon)', 'Overflow'],
  'service_booking': ['Follow', 'Message', 'Call (icon)', 'WhatsApp (icon)', 'Overflow'],
  'quote_request': ['Follow', 'Message', 'Call (icon)', 'WhatsApp (icon)', 'Overflow'],
  'portfolio_inquiry': ['Follow', 'Message', 'Call (icon)', 'WhatsApp (icon)', 'Overflow'],
  'reservation': ['Follow', 'Message', 'Call (icon)', 'WhatsApp (icon)', 'Overflow'],
  'follow_only': ['Follow', 'Call + label', 'WhatsApp + label', 'Share + label'],
  'directory': ['Follow', 'Call + label', 'WhatsApp + label', 'Share + label'],
};

// Insights chart visibility per archetype
const _insightsCharts = <String, List<String>>{
  'catalog_order': ['KPI cards (2x2)', 'Revenue chart', 'Ranked list (top products)', 'Distribution chart', 'Smart tips'],
  'menu_order': ['KPI cards (2x2)', 'Revenue chart', 'Ranked list (top items)', 'Distribution chart', 'Modifier analytics', 'Smart tips'],
  'service_booking': ['KPI cards (2x2)', 'Revenue chart', 'Ranked list (top services)', 'Booking calendar', 'Smart tips'],
  'quote_request': ['KPI cards (2x2)', 'Revenue chart', 'Distribution chart', 'Smart tips'],
  'portfolio_inquiry': ['KPI cards (2x2)', 'Revenue chart', 'Smart tips'],
  'reservation': ['KPI cards (2x2)', 'Revenue chart', 'Distribution chart', 'Booking calendar', 'Smart tips'],
  'follow_only': ['KPI cards (2x2)', 'Ranked list (top posts)', 'Distribution chart', 'Smart tips'],
  'directory': ['Directory dashboard', 'Directory insights cards (specialized view)'],
};

// Dashboard sections with descriptions
const _dashboardSectionDescriptions = <String, String>{
  'stats': 'Config-driven stat cards row',
  'revenue': 'Today vs yesterday with payment breakdown (cash/CliQ/bank)',
  'pending': 'Pending requests requiring action',
  'actions': 'Quick actions grid (4 columns)',
  'bestSellers': 'Top selling items',
  'lowStock': 'Items running low on stock',
  'queue': 'Active queue summary',
  'unavailable': 'Currently unavailable menu items',
  'nextAppt': 'Next upcoming appointment',
  'schedule': 'Today\'s schedule overview',
  'quotes': 'Active quotes awaiting response',
  'occupancy': 'Current occupancy / availability',
  'upcomingRes': 'Upcoming reservations',
  'posts': 'Recent posts summary',
  'recentlyLinked': 'Recently linked tenants',
};

const _manageFeatures = <String, List<String>>{
  'catalog_order': [
    'Product list grouped by category',
    'Search + filter (by category, status)',
    'Modes: normal / multi-select / reorder',
    'Mass actions: status, delete, discount, assign category/team',
    'Stock manager sheet',
    'Category manager',
    'Item wizard (add/edit with image, price, variants)',
    'Price change wizard (batch modifications)',
  ],
  'menu_order': [
    'Menu list grouped by category',
    'Search + filter',
    'Modifiers management (sizes, extras, add-ons)',
    'Mass actions: status, delete, discount',
    'Stock manager sheet',
    'Category manager',
    'Item wizard with modifiers setup',
    'Price change wizard',
  ],
  'service_booking': [
    'Services list with duration and pricing',
    'Category management',
    'Provider/team assignment per service',
    'Packages management',
    'Price change wizard',
  ],
  'quote_request': [
    'Services list',
    'Past work gallery (أعمالنا)',
    'Price range configuration (الأسعار)',
  ],
  'portfolio_inquiry': [
    'Portfolio gallery management (المعرض)',
    'Past work showcase (أعمالنا)',
    'Ready-made items pricing',
  ],
  'reservation': [
    'Spaces/rooms management (المساحات)',
    'Packages management (الباقات)',
    'Seasonal pricing configuration',
    'Gallery management',
  ],
};

const _villaManageSections = [
  'Price change banner',
  'Pricing: base weekday/weekend + seasonal',
  'Property description overlay',
  'House rules (editable list)',
  'Check-in / check-out times',
  'Gallery management',
  'Availability overlay',
];

// Settings visibility rules per archetype
const _settingsExtras = <String, List<String>>{
  'catalog_order': ['Return policy', 'Catalog strategy', 'Coverage areas', 'Packages (if subscriptions/punch_cards)', 'Catalog sync (Shopify/Woo/API)'],
  'menu_order': ['Return policy', 'Catalog strategy', 'Coverage areas', 'Packages (if subscriptions/punch_cards)', 'Catalog sync (Shopify/Woo/API)'],
  'service_booking': ['Cancellation policy', 'Intake questions', 'Availability & schedule', 'Calendar sync (Google/Outlook)'],
  'quote_request': ['Cancellation policy', 'Quote form questions', 'Coverage areas'],
  'portfolio_inquiry': ['Cancellation policy', 'Coverage areas'],
  'reservation': ['Cancellation policy', 'Venue settings', 'Safety disclaimers', 'Post-booking steps', 'Availability & schedule', 'Calendar sync (Google/Outlook)'],
  'follow_only': ['Alert management'],
  'directory': ['Tenant management'],
};

const _suggestedRoles = <String, List<String>>{
  'catalog_order': ['Cashier كاشير', 'Stock clerk أمين مستودع', 'Manager مدير'],
  'menu_order': ['Chef شيف', 'Cashier كاشير', 'Driver سائق', 'Branch mgr مدير فرع'],
  'service_booking': ['Receptionist استقبال', 'Provider مقدم خدمة', 'Manager مدير'],
  'quote_request': ['Technician فني', 'Supervisor مشرف'],
  'portfolio_inquiry': [],
  'reservation': ['Receptionist استقبال', 'Manager مدير'],
  'follow_only': [],
  'directory': ['Mall mgr مدير مول', 'Receptionist استقبال'],
};

const _alternativeSuggestionFields = <String, List<String>>{
  'catalog_order': ['Item picker', 'Quantity', 'Variation', 'Price difference'],
  'menu_order': ['Item picker', 'Quantity', 'Price difference'],
  'service_booking': ['Service picker', 'Team member', 'Time slot', 'Date', 'Price difference'],
  'quote_request': ['Service picker', 'Date', 'Quote price'],
  'portfolio_inquiry': ['Work picker', 'Date', 'Quote price'],
  'reservation': ['Space picker', 'Date range', 'Price difference'],
};

const _requestStatuses = <String, List<String>>{
  'standard': ['pending', 'accepted', 'in_progress', 'preparing', 'on_the_way', 'delivered', 'completed', 'declined', 'cancelled'],
  'queue': ['waiting', 'on_the_way', 'in_progress', 'ready', 'completed', 'no_show'],
  'dropoff': ['received', 'in_progress', 'ready', 'delivered (picked up)'],
};

// Types with special features
const _deliveryTypes = {'water_delivery', 'gas_delivery', 'pharmacy', 'mini_market', 'restaurant', 'bakery', 'fast_food', 'online_store', 'bookstore'};
const _villaTypes = {'villa_rental'};

// ─── Generator ───────────────────────────────────────────────────────────────

void main() {
  // Auto-discover types from page fixtures
  allTypes = _loadTypesFromFixtures();
  print('Discovered ${allTypes.length} types from page fixtures');

  final buf = StringBuffer();

  _writeHeader(buf);
  _writeMermaidDiagrams(buf);
  _writeOverview(buf);
  _writeCustomerExperience(buf);
  _writeBusinessExperience(buf);
  _writeTypeMatrix(buf);
  _writeTrackingModes(buf);
  _writeAddingNewType(buf);

  final outputDir = Directory('docs/generated');
  if (!outputDir.existsSync()) outputDir.createSync(recursive: true);
  File('docs/generated/BUSINESS_MAP.md').writeAsStringSync(buf.toString());
  print('Generated docs/generated/BUSINESS_MAP.md');

  // Interactive HTML mindmap
  final html = _buildInteractiveHtml();
  File('docs/generated/BUSINESS_MAP.html').writeAsStringSync(html);
  print('Generated docs/generated/BUSINESS_MAP.html');

  print('${allTypes.length} business types across ${archetypes.length} archetypes');
}

// ─── Mermaid Diagrams ─────────────────────────────────────────────────────────

void _writeMermaidDiagrams(StringBuffer buf) {
  _writeMermaidTypeHierarchy(buf);
  _writeMermaidAppModes(buf);
  _writeMermaidTrackingFlows(buf);
}

void _writeMermaidTypeHierarchy(StringBuffer buf) {
  buf.writeln('## Business Type Hierarchy');
  buf.writeln();
  buf.writeln('```mermaid');
  buf.writeln('mindmap');
  buf.writeln('  root((Honak<br/>47 Types))');

  for (final a in archetypes.values) {
    final types = allTypes.where((t) => t.archetype == a.id).toList();
    buf.writeln('    ${a.nameEn}<br/>${a.nameAr}');
    for (final t in types) {
      final marker = switch (t.trackingMode) {
        'queue' => '::icon(fa fa-users-line)',
        'dropoff' => '::icon(fa fa-ticket)',
        _ => '',
      };
      buf.writeln('      ${t.nameEn}<br/>${t.nameAr}');
      // Mermaid mindmap icons only work with certain renderers, so we
      // also add tracking mode as a child node for clarity
      if (t.trackingMode != null) {
        buf.writeln('        ${t.trackingMode} mode');
      }
    }
  }

  buf.writeln('```');
  buf.writeln();
}

void _writeMermaidAppModes(StringBuffer buf) {
  buf.writeln('## App Structure');
  buf.writeln();
  buf.writeln('```mermaid');
  buf.writeln('flowchart TD');
  buf.writeln('    App((Honak App)) --> C[Customer Mode]');
  buf.writeln('    App --> B[Business Mode]');
  buf.writeln();
  buf.writeln('    C --> Home[Home Feed]');
  buf.writeln('    C --> Explore[Explore & Search]');
  buf.writeln('    C --> PD[Page Detail]');
  buf.writeln('    C --> QA[Quick Actions]');
  buf.writeln('    C --> Chat[Chat]');
  buf.writeln('    C --> Profile[Profile & Settings]');
  buf.writeln();
  buf.writeln('    PD --> CO["Catalog Order<br/>(10 types)"]');
  buf.writeln('    PD --> MO["Menu Order<br/>(6 types)"]');
  buf.writeln('    PD --> SB["Service Booking<br/>(15 types)"]');
  buf.writeln('    PD --> QR["Quote Request<br/>(5 types)"]');
  buf.writeln('    PD --> PI["Portfolio Inquiry<br/>(2 types)"]');
  buf.writeln('    PD --> RES["Reservation<br/>(5 types)"]');
  buf.writeln('    PD --> FO["Follow-Only<br/>(3 types)"]');
  buf.writeln('    PD --> DIR["Directory<br/>(1 type)"]');
  buf.writeln();
  buf.writeln('    B --> Dash[Dashboard]');
  buf.writeln('    B --> Req[Requests]');
  buf.writeln('    B --> Post[Post]');
  buf.writeln('    B --> Manage[Manage Catalog]');
  buf.writeln('    B --> Settings[Page Settings]');
  buf.writeln();
  buf.writeln('    Profile --> AccInfo[Account Info]');
  buf.writeln('    Profile --> Addr[My Addresses]');
  buf.writeln('    Profile --> Saved[Saved Pages]');
  buf.writeln('    Profile --> Notif[Notifications]');
  buf.writeln('    Profile --> Privacy[Privacy & Security]');
  buf.writeln('    Profile --> Help[Help & Support]');
  buf.writeln('    Profile --> BizPages["My Pages → Business Mode"]');
  buf.writeln('```');
  buf.writeln();
}

void _writeMermaidTrackingFlows(StringBuffer buf) {
  final queueTypes = allTypes
      .where((t) => t.trackingMode == 'queue')
      .map((t) => t.nameEn)
      .join(', ');
  final dropoffTypes = allTypes
      .where((t) => t.trackingMode == 'dropoff')
      .map((t) => t.nameEn)
      .join(', ');

  buf.writeln('## Tracking Modes');
  buf.writeln();
  buf.writeln('```mermaid');
  buf.writeln('flowchart LR');
  buf.writeln('    subgraph Standard["Standard Flow (39 types)"]');
  buf.writeln('    direction LR');
  buf.writeln('    S1([Customer Request]) --> S2[Business Review]');
  buf.writeln('    S2 --> S3{Accept?}');
  buf.writeln('    S3 -->|Yes| S4[Fulfill]');
  buf.writeln('    S3 -->|No| S5[Decline / Alternative]');
  buf.writeln('    S4 --> S6([Complete])');
  buf.writeln('    end');
  buf.writeln();
  buf.writeln('    subgraph Queue["Queue Flow ($queueTypes)"]');
  buf.writeln('    direction LR');
  buf.writeln('    Q1([Walk-in]) --> Q2[Added to Queue]');
  buf.writeln('    Q2 --> Q3[Position Tracking]');
  buf.writeln('    Q3 --> Q4[Serving]');
  buf.writeln('    Q4 --> Q5([Done])');
  buf.writeln('    end');
  buf.writeln();
  buf.writeln('    subgraph Dropoff["Dropoff Flow ($dropoffTypes)"]');
  buf.writeln('    direction LR');
  buf.writeln('    D1([Drop Item]) --> D2[Received]');
  buf.writeln('    D2 --> D3[Inspecting]');
  buf.writeln('    D3 --> D4[Working]');
  buf.writeln('    D4 --> D5[Ready]');
  buf.writeln('    D5 --> D6([Picked Up])');
  buf.writeln('    end');
  buf.writeln('```');
  buf.writeln();
  buf.writeln('---');
  buf.writeln();
}

// ─── Markdown Sections ───────────────────────────────────────────────────────

void _writeHeader(StringBuffer buf) {
  buf.writeln('# Honak — Complete App Feature Map');
  buf.writeln();
  buf.writeln('> Auto-generated by `dart run tool/generate_business_map.dart`');
  buf.writeln('> ${allTypes.length} business types across ${archetypes.length} archetypes');
  buf.writeln('> Last generated: ${DateTime.now().toIso8601String().substring(0, 10)}');
  buf.writeln();
  buf.writeln('---');
  buf.writeln();
}

void _writeOverview(StringBuffer buf) {
  buf.writeln('## Architecture Overview');
  buf.writeln();
  buf.writeln('```');
  buf.writeln('BusinessTypeConfig (27 fields)');
  buf.writeln('  ├── Archetype (8 fixed patterns)       ← interaction model');
  buf.writeln('  ├── Features (toggles)                  ← capabilities');
  buf.writeln('  ├── Dashboard (sections + stats)         ← business home screen');
  buf.writeln('  ├── ManageTabs (catalog structure)       ← what business edits');
  buf.writeln('  ├── OrderLabels (AR strings)             ← request flow wording');
  buf.writeln('  ├── ItemManagement (fields + properties) ← catalog item shape');
  buf.writeln('  ├── Coverage (model + granularity)       ← delivery/service area');
  buf.writeln('  ├── TeamRoles (suggested + permissions)  ← who does what');
  buf.writeln('  └── Insights (sections + cards)          ← analytics view');
  buf.writeln('```');
  buf.writeln();
  buf.writeln('**Config layers**: Archetype default → Type-specific overrides → Runtime state');
  buf.writeln();

  // Archetype summary table
  buf.writeln('### Archetypes');
  buf.writeln();
  buf.writeln('| Archetype | Arabic | Customer Action | Approval | Coverage | Date | Types |');
  buf.writeln('|-----------|--------|-----------------|----------|----------|------|-------|');
  for (final a in archetypes.values) {
    final count = allTypes.where((t) => t.archetype == a.id).length;
    buf.writeln('| ${a.nameEn} | ${a.nameAr} | ${a.customerAction} | ${a.approval} | ${a.coverageModel} | ${a.dateSelection} | $count |');
  }
  buf.writeln();
}

void _writeCustomerExperience(StringBuffer buf) {
  buf.writeln('---');
  buf.writeln();
  buf.writeln('## Part 1: Customer Experience');
  buf.writeln();

  // Guest
  buf.writeln('### 1.1 Guest (No Login)');
  buf.writeln();
  buf.writeln('Guests can browse but not interact:');
  buf.writeln();
  buf.writeln('| Screen | What They See | What They Cannot Do |');
  buf.writeln('|--------|-------------|---------------------|');
  buf.writeln('| **Home** | Feed posts from promoted pages, promo banners | Follow pages, see personalized feed |');
  buf.writeln('| **Explore** | Category grid, search, page cards, filters | — (full access) |');
  buf.writeln('| **Page Detail** | Full page with all sections (hero, items, posts, info) | Place orders, send requests, chat |');
  buf.writeln('| **Product Detail** | Item photos, price, description, variants | Add to cart |');
  buf.writeln('| **Quick Actions** | Login prompt | Any actions |');
  buf.writeln('| **Chat** | Login prompt | Any chat |');
  buf.writeln('| **Profile** | Login prompt | Any profile features |');
  buf.writeln();
  buf.writeln('**Login trigger**: Any interaction attempt (follow, order, chat, save) shows login prompt sheet.');
  buf.writeln();

  // Logged-in
  buf.writeln('### 1.2 Logged-In Customer');
  buf.writeln();
  buf.writeln('| Screen | Features |');
  buf.writeln('|--------|----------|');
  buf.writeln('| **Home (Feed)** | Chronological posts from followed pages, promo banners, "Near You" discovery |');
  buf.writeln('| **Explore** | Categories, search, filters, page cards with follow button |');
  buf.writeln('| **Quick Actions** | Shortcuts per business type (reorder, rebook) |');
  buf.writeln('| **Chat** | Active conversations with businesses, message + photo support |');
  buf.writeln('| **Profile** | 7 menu items: Saved, Addresses, Account Info, Notifications, Privacy, Language, Help |');
  buf.writeln('| **Profile Sub-Screens** | AccountInfo, MyAddresses (CRUD), SavedPages, NotificationPrefs, PrivacySecurity (+ delete account), HelpSupport (FAQ + report) |');
  buf.writeln('| **Page Detail** | Full page + CTA button + follow + save + chat + share |');
  buf.writeln('| **Order/Request Flow** | Varies by archetype (see below) |');
  buf.writeln('| **Order Tracking** | Real-time status updates, chat with business |');
  buf.writeln('| **Business Pages** | "My Pages" section in profile → tap to switch to business mode |');
  buf.writeln();

  // Per archetype customer view
  buf.writeln('### 1.3 Per Archetype — What Customer Sees on Page');
  buf.writeln();
  for (final a in archetypes.values) {
    buf.writeln('#### ${a.nameEn} (${a.nameAr})');
    buf.writeln();
    buf.writeln('**Customer action**: ${a.customerAction}');
    buf.writeln();
    buf.writeln('**Page sections**:');
    for (final s in a.customerPageSections) {
      buf.writeln('- $s');
    }
    buf.writeln();
    buf.writeln('**Flow**: ${a.customerFlow}');
    buf.writeln();

    // Types in this archetype
    final types = allTypes.where((t) => t.archetype == a.id).toList();
    if (types.isNotEmpty) {
      buf.writeln('**Types**: ${types.map((t) => '${t.nameAr} (${t.nameEn})').join(' · ')}');
      buf.writeln();
    }
  }
}

void _writeBusinessExperience(StringBuffer buf) {
  buf.writeln('---');
  buf.writeln();
  buf.writeln('## Part 2: Business Experience');
  buf.writeln();

  // Common
  buf.writeln('### 2.1 Common to All Business Types');
  buf.writeln();
  buf.writeln('| Component | Description |');
  buf.writeln('|-----------|-------------|');
  buf.writeln('| **App Bar** | Page avatar + name + verified badge + archetype subtitle, dropdown to switch pages, "← عميل" chip to switch to customer mode, notification bell with badge |');
  buf.writeln('| **Bottom Tabs** | Up to 5 tabs: Dashboard, Requests, Post, Manage, Settings — visibility driven by archetype (`supportsRequests`, `hasCatalog`) |');
  buf.writeln('| **Dashboard** | Config-driven sections (stats, revenue, pending, queue, etc.) + quick actions |');
  buf.writeln('| **Requests** | Incoming/accepted/completed tabs with archetype-specific labels |');
  buf.writeln('| **Post** | Create posts (product, offer, update, photo) visible to followers |');
  buf.writeln('| **Manage** | Config-driven tabs for catalog/menu/services/portfolio management |');
  buf.writeln('| **Settings** | Page settings — status, info, operations, team, marketing (no account tab — managed in customer mode) |');
  buf.writeln();

  // Per archetype business view
  buf.writeln('### 2.2 Per Archetype — Business Owner View');
  buf.writeln();
  for (final a in archetypes.values) {
    buf.writeln('#### ${a.nameEn} (${a.nameAr})');
    buf.writeln();

    buf.writeln('| Aspect | Details |');
    buf.writeln('|--------|---------|');
    buf.writeln('| **Tabs visible** | Dashboard${a.supportsRequests ? ", Requests" : ""}${a.hasCatalog ? ", Manage" : ""}, Post, Settings |');
    buf.writeln('| **Dashboard sections** | ${a.dashboardSections.join(', ')} |');
    buf.writeln('| **Manage tabs** | ${a.manageTabs.isEmpty ? "N/A" : a.manageTabs.join(', ')} |');
    buf.writeln('| **Request labels** | ${a.requestLabel.isEmpty ? "N/A (no requests)" : a.requestLabel} |');
    buf.writeln('| **Coverage** | ${a.coverageModel} |');
    buf.writeln('| **Date selection** | ${a.dateSelection} |');
    buf.writeln('| **Approval mode** | ${a.approval} |');
    buf.writeln('| **Permissions** | ${a.permissions.join(', ')} |');
    buf.writeln();

    buf.writeln('**Settings sections**:');
    for (final s in a.settingsSections) {
      buf.writeln('- $s');
    }
    buf.writeln();
  }
}

void _writeTypeMatrix(StringBuffer buf) {
  buf.writeln('---');
  buf.writeln();
  buf.writeln('## Part 3: Full Type Matrix');
  buf.writeln();
  buf.writeln('| Type ID | Arabic | English | Archetype | Category | Tracking | Key Features |');
  buf.writeln('|---------|--------|---------|-----------|----------|----------|-------------|');
  for (final t in allTypes) {
    final tracking = t.trackingMode ?? 'standard';
    final features = t.features.isEmpty ? '(archetype defaults)' : t.features.join(', ');
    buf.writeln('| ${t.id} | ${t.nameAr} | ${t.nameEn} | ${t.archetype} | ${t.category} | $tracking | $features |');
  }
  buf.writeln();
}

void _writeTrackingModes(StringBuffer buf) {
  buf.writeln('---');
  buf.writeln();
  buf.writeln('## Part 4: Special Tracking Modes');
  buf.writeln();
  buf.writeln('Beyond the standard request → response flow, some types have special tracking:');
  buf.writeln();

  buf.writeln('### Queue Mode');
  buf.writeln();
  buf.writeln('Customer walks in → business adds to live queue → customer tracks position → served');
  buf.writeln();
  buf.writeln('**Types**: ${allTypes.where((t) => t.trackingMode == "queue").map((t) => "${t.nameAr} (${t.id})").join(", ")}');
  buf.writeln();
  buf.writeln('**Business gets**:');
  buf.writeln('- Live queue board with drag-to-reorder');
  buf.writeln('- Quick-add customer (walk-up)');
  buf.writeln('- Queue entry cards with status transitions');
  buf.writeln('- Queue dashboard widget on home');
  buf.writeln('- Activity log per entry');
  buf.writeln();
  buf.writeln('**Customer gets**:');
  buf.writeln('- Queue position tracker');
  buf.writeln('- Estimated wait time');
  buf.writeln('- "Ready" notification');
  buf.writeln('- Cancel from queue');
  buf.writeln();

  buf.writeln('### Dropoff Mode');
  buf.writeln();
  buf.writeln('Customer drops off item → business tracks repair/cleaning status → customer picks up');
  buf.writeln();
  buf.writeln('**Types**: ${allTypes.where((t) => t.trackingMode == "dropoff").map((t) => "${t.nameAr} (${t.id})").join(", ")}');
  buf.writeln();
  buf.writeln('**Business gets**:');
  buf.writeln('- Dropoff board (ticket-based tracking)');
  buf.writeln('- Quick-add ticket with item photos');
  buf.writeln('- Status pipeline (received → inspecting → working → ready → picked_up)');
  buf.writeln('- Info capture templates (per business type)');
  buf.writeln('- Dropoff dashboard widget');
  buf.writeln('- Activity log per ticket');
  buf.writeln();
  buf.writeln('**Customer gets**:');
  buf.writeln('- Ticket status tracker ("تتبع قطعك")');
  buf.writeln('- Status update notifications');
  buf.writeln('- "Ready for pickup" notification');
  buf.writeln('- Item photos and notes');
  buf.writeln();
}

void _writeAddingNewType(StringBuffer buf) {
  buf.writeln('---');
  buf.writeln();
  buf.writeln('## Part 5: Adding a New Business Type');
  buf.writeln();
  buf.writeln('### If it fits an existing archetype (most cases):');
  buf.writeln();
  buf.writeln('| Step | File | What |');
  buf.writeln('|------|------|------|');
  buf.writeln('| 1 | `lib/config/types/{category}_types.dart` | Add `createType()` entry (~50 lines) |');
  buf.writeln('| 2 | `lib/config/types/{category}_types.dart` | Export in barrel file |');
  buf.writeln('| 3 | `lib/config/business_type_registry.dart` | Add to `_allTypes` list |');
  buf.writeln('| 4 | `assets/api/pages/page_{slug}.json` | Page fixture |');
  buf.writeln('| 5 | `assets/api/products/items_{type_id}.json` | Items fixture (if has catalog) |');
  buf.writeln('| 6 | `assets/api/business/dashboard/{type_id}.json` | Dashboard fixture |');
  buf.writeln('| 7 | Run `dart run tool/generate_fixtures.dart` | Regenerate derived files |');
  buf.writeln('| 8 | Update user fixture in `assets/api/users/` | Add page to demo account |');
  buf.writeln();
  buf.writeln('**Total: ~4-5 files, 0 new Dart widget code**');
  buf.writeln();
  buf.writeln('### If it needs custom features beyond the archetype:');
  buf.writeln();
  buf.writeln('Each genuinely new capability (not covered by existing widgets) needs:');
  buf.writeln();
  buf.writeln('| Layer | Files | Example |');
  buf.writeln('|-------|-------|---------|');
  buf.writeln('| Entity | 3 (`.dart` + `.freezed.dart` + `.g.dart`) | `visit_history.dart` |');
  buf.writeln('| Provider | 1 | `visit_history_provider.dart` |');
  buf.writeln('| Widget(s) | 2-8 | `visit_timeline.dart`, `visit_card.dart` |');
  buf.writeln('| Page | 0-1 | Only if entirely new screen needed |');
  buf.writeln();
  buf.writeln('**Per custom feature: ~5-15 files**');
  buf.writeln();
  buf.writeln('### If it needs a new archetype (rare):');
  buf.writeln();
  buf.writeln('Everything above PLUS:');
  buf.writeln('- New archetype enum value in `archetype.dart`');
  buf.writeln('- New defaults file in `archetype_defaults/`');
  buf.writeln('- New request flow widgets');
  buf.writeln('- New page detail sections');
  buf.writeln('- New manage page layout');
  buf.writeln('- **~30-50+ files**');
  buf.writeln();
  buf.writeln('> In 49 types, we have NOT needed a 9th archetype. The 8 cover all known Jordan business patterns.');
  buf.writeln();

  // Document references
  buf.writeln('### Key Documents for Adding Types');
  buf.writeln();
  buf.writeln('| Document | What It Covers |');
  buf.writeln('|----------|---------------|');
  buf.writeln('| `docs/GUIDELINES.md` | Config-driven design rules, naming, component sharing |');
  buf.writeln('| `docs/ARCHETYPES.md` | 8 archetypes in detail — flows, states, features |');
  buf.writeln('| `docs/BUSINESS_TAXONOMY.md` | All ~160 types, categories, archetype mappings |');
  buf.writeln('| `mobile/CLAUDE.md` | Build commands, architecture, fixture pipeline |');
  buf.writeln('| This file (`BUSINESS_MAP.md`) | What each type currently has in the app |');
  buf.writeln();
}

// ─── Interactive HTML (Markmap) ──────────────────────────────────────────────

String _buildInteractiveHtml() {
  final md = StringBuffer();

  md.writeln('# Honak — ${allTypes.length} Business Types');
  md.writeln();

  for (final a in archetypes.values) {
    final types = allTypes.where((t) => t.archetype == a.id).toList();

    // ── Archetype level ──
    md.writeln('## ${a.nameEn} ${a.nameAr} (${types.length})');
    md.writeln();
    md.writeln('- ${a.customerAction}');
    md.writeln('- Approval: ${a.approval} · Coverage: ${a.coverageModel} · Date: ${a.dateSelection}');
    md.writeln();

    for (final t in types) {
      _writeTypeMindmap(md, a, t);
    }
  }

  final mdContent = md.toString().replaceAll('`', '\\`').replaceAll(r'$', r'\$');
  return _wrapHtml(mdContent);
}

void _writeTypeMindmap(StringBuffer md, ArchetypeInfo a, TypeInfo t) {
  final tracking = t.trackingMode ?? 'standard';
  final badge = t.trackingMode != null ? ' [$tracking]' : '';

  md.writeln('### ${t.nameEn} ${t.nameAr}$badge');
  md.writeln();

  // ── CUSTOMER EXPERIENCE ──
  md.writeln('#### Customer Experience');
  md.writeln();

  // Discovery
  md.writeln('##### Discovery');
  md.writeln();
  md.writeln('- Explore: "${t.category}" category');
  md.writeln('- Search by name');
  md.writeln('- Nearby section (distance-based)');
  md.writeln('- Trending pages (horizontal scroll)');
  md.writeln();

  // Page view
  md.writeln('##### Page View');
  md.writeln();
  md.writeln('**Header**:');
  md.writeln('- Cover image + avatar + name + verified badge');
  md.writeln('- Trust score, response time, completion rate');
  md.writeln('- Nearest branch card (if multi-branch)');
  if (a.coverageModel != 'none') {
    md.writeln('- Coverage zone banner');
  }
  md.writeln();

  // Tabs
  final tabs = _customerPageTabs[a.id] ?? [];
  md.writeln('**Tabs**: ${tabs.join(' | ')}');
  md.writeln();

  // Main section
  final mainSections = _customerMainSections[a.id] ?? [];
  md.writeln('**Main tab**:');
  for (final s in mainSections) {
    md.writeln('- $s');
  }
  md.writeln();

  // Activity tab
  final filters = _activityTabFilters[a.id] ?? [];
  md.writeln('**Activity tab**: pinned posts first, filters: ${filters.join(', ')}');
  md.writeln();

  // Info tab
  md.writeln('**Info tab**:');
  for (final s in _infoTabSections) {
    md.writeln('- $s');
  }
  md.writeln();

  // Action bar
  final actions = _actionBarItems[a.id] ?? [];
  md.writeln('**Action bar**: ${actions.join(' · ')}');
  md.writeln();

  // Request flow
  if (a.supportsRequests) {
    md.writeln('##### Request Flow');
    md.writeln();
    final sheet = _customerRequestSheets[a.id] ?? '';
    md.writeln('- $sheet');
    md.writeln('- Auth-gated (login required to submit)');
    md.writeln();

    md.writeln('##### After Request');
    md.writeln();
    final statuses = _requestStatuses[tracking] ?? _requestStatuses['standard']!;
    md.writeln('- Status flow: ${statuses.join(' → ')}');
    md.writeln('- Chat with business');
    md.writeln('- Cancel / reschedule options');
    md.writeln();
  }

  // Guest limitations
  md.writeln('##### Guest (No Login)');
  md.writeln();
  md.writeln('- Can browse full page, all tabs, all items');
  md.writeln('- Cannot: place orders, follow, message, chat, save');
  md.writeln('- Any interaction → login prompt sheet');
  md.writeln();

  // ── BUSINESS CONTROL PANEL ──
  md.writeln('#### Business Control Panel');
  md.writeln();

  // Bottom navigation
  final bottomTabs = a.supportsRequests
      ? ['الرئيسية Home', 'إحصائيات Insights', '${a.requestLabel.isEmpty ? "Orders" : a.requestLabel} (center)', 'المحادثات Chat', 'الصفحة Settings']
      : ['الرئيسية Home', 'إحصائيات Insights', 'الصفحة Settings'];
  md.writeln('##### Bottom Tabs: ${bottomTabs.length}');
  md.writeln();
  for (final tab in bottomTabs) {
    md.writeln('- $tab');
  }
  md.writeln();

  // Home → Dashboard
  md.writeln('##### Home → Dashboard');
  md.writeln();
  md.writeln('- Setup progress card (onboarding checklist)');
  if (a.supportsRequests) {
    md.writeln('- Revenue overview (today vs yesterday, cash/CliQ/bank)');
  }
  for (final sec in a.dashboardSections) {
    final desc = _dashboardSectionDescriptions[sec] ?? sec;
    md.writeln('- $sec: $desc');
  }
  if (a.supportsRequests) {
    md.writeln('- Recurring customers section');
  }
  md.writeln();

  // Home → Manage
  if (a.id != 'follow_only') {
    md.writeln('##### Home → Manage');
    md.writeln();

    if (_villaTypes.contains(t.id)) {
      md.writeln('**Villa Manage Page** (specialized):');
      for (final s in _villaManageSections) {
        md.writeln('- $s');
      }
    } else if (a.id == 'directory') {
      md.writeln('**Directory Manage Page** (specialized):');
      md.writeln('- Tenant directory management');
      md.writeln('- Floor/category organization');
      md.writeln('- Tenant linking and unlinking');
    } else {
      md.writeln('**Tabs**: ${a.manageTabs.join(', ')}');
      md.writeln();
      final features = _manageFeatures[a.id] ?? [];
      for (final f in features) {
        md.writeln('- $f');
      }
      if (_deliveryTypes.contains(t.id) && t.features.contains('delivery_zones')) {
        md.writeln('- Truck manager (delivery fleet, inventory, driving mode)');
      }
    }
    md.writeln();
  }

  // Home → Content
  md.writeln('##### Home → Content');
  md.writeln();
  md.writeln('- **Stories**: create, preview, schedule, edit, republish, delete');
  md.writeln('- Story stats: views, shares, messages, reach');
  md.writeln('- Sort: newest, oldest, most views/shares/messages/reach');
  md.writeln('- Filters: all, live, scheduled, expired');
  md.writeln('- **Posts**: coming soon');
  md.writeln();

  // Home → Customers
  if (a.supportsRequests) {
    md.writeln('##### Home → Customers');
    md.writeln();
    md.writeln('- Coming soon (placeholder)');
    md.writeln('- Will show: customer list, order history, loyalty, notes');
    md.writeln();
  }

  // Insights
  md.writeln('##### Insights');
  md.writeln();
  md.writeln('- Period selector: Weekly / Monthly / Yearly');
  final charts = _insightsCharts[a.id] ?? [];
  for (final c in charts) {
    md.writeln('- $c');
  }
  md.writeln();

  // Orders tab
  if (a.supportsRequests) {
    md.writeln('##### Orders');
    md.writeln();
    if (t.trackingMode == 'queue') {
      md.writeln('**Queue Board** (Kanban-style):');
      md.writeln('- Columns: Waiting → In Progress → Ready → Completed');
      md.writeln('- One-tap status advance');
      md.writeln('- Quick-add entry (walk-up customer)');
      md.writeln('- Pause/resume queue toggle');
      md.writeln('- No-show marking');
      md.writeln('- Revenue summary');
      md.writeln('- Estimated wait time');
      md.writeln('- Detail view bottom sheet');
    } else if (t.trackingMode == 'dropoff') {
      md.writeln('**Dropoff Board** (ticket-based):');
      md.writeln('- Ticket tracking: received → in_progress → ready → delivered');
      md.writeln('- Quick-add ticket with photos');
      md.writeln('- Before/after photo capture');
      md.writeln('- Urgent/overdue badges');
      md.writeln('- Info request templates (per business type)');
      md.writeln('- Activity log per ticket');
      md.writeln('- Day stats');
    } else {
      md.writeln('**Standard Request List**:');
      md.writeln('- Tabs: Pending / Accepted / In Progress / Completed');
      md.writeln('- Badge counts per tab');
      md.writeln('- Request detail: summary + activity log');
      md.writeln('- Actions: accept, decline, suggest alternative');
      if (t.features.contains('delivery_zones') || _deliveryTypes.contains(t.id)) {
        md.writeln('- Truck status cards');
        md.writeln('- Driving mode (delivery route interface)');
        md.writeln('- Walk-up order sheet');
      }
    }
    md.writeln();
  }

  // Chat
  if (a.supportsRequests) {
    md.writeln('##### Chat');
    md.writeln();
    md.writeln('- Customer conversations with unread badge');
    md.writeln('- Message types: text, image, system');
    md.writeln('- Power menu: send product cards, availability, quotes');
    md.writeln('- Request banner linking to order');
    md.writeln('- Read receipts');
    md.writeln();
  }

  // Settings
  md.writeln('##### Settings');
  md.writeln();
  md.writeln('**Common**:');
  md.writeln('- Page status (active/paused/closed) + relocation');
  md.writeln('- Page info (name, logo, description)');
  md.writeln('- Branches & locations');
  md.writeln('- Payment methods');
  md.writeln('- Engagement level (visibility/showcase/full)');
  if (a.supportsRequests) {
    md.writeln('- Order approval mode (auto/manual)');
  }
  final roles = _suggestedRoles[a.id] ?? [];
  if (roles.isNotEmpty) {
    md.writeln('- Team management: ${roles.join(', ')}');
  }
  md.writeln('- Marketing & sharing, QR codes');
  md.writeln();

  final extras = _settingsExtras[a.id] ?? [];
  if (extras.isNotEmpty) {
    md.writeln('**Archetype-specific**:');
    for (final e in extras) {
      md.writeln('- $e');
    }
    md.writeln();
  }

  // ── INTERACTION ──
  if (a.supportsRequests) {
    md.writeln('#### Business ↔ Customer');
    md.writeln();

    md.writeln('##### Request Lifecycle');
    md.writeln();
    final statuses = _requestStatuses[tracking] ?? _requestStatuses['standard']!;
    md.writeln('- ${statuses.join(' → ')}');
    md.writeln('- Approval: ${a.approval}');
    md.writeln();

    if (_alternativeSuggestionFields.containsKey(a.id)) {
      md.writeln('##### Alternative Suggestions');
      md.writeln();
      md.writeln('Business can suggest alternatives using:');
      for (final f in _alternativeSuggestionFields[a.id]!) {
        md.writeln('- $f');
      }
      md.writeln();
    }

    md.writeln('##### Chat');
    md.writeln();
    md.writeln('- Text + image messages');
    md.writeln('- Rich cards: products, availability, quotes');
    md.writeln('- Edit/delete messages');
    md.writeln('- Report conversation');
    md.writeln();

    md.writeln('##### Notifications');
    md.writeln();
    md.writeln('- New request received');
    md.writeln('- Status change updates');
    md.writeln('- New message in chat');
    if (t.trackingMode == 'queue') {
      md.writeln('- Queue position updates');
      md.writeln('- Ready for service');
    } else if (t.trackingMode == 'dropoff') {
      md.writeln('- Item status updates');
      md.writeln('- Ready for pickup');
    }
    md.writeln();
  }

  // ── CONFIG ──
  md.writeln('#### Config');
  md.writeln();
  md.writeln('- **Type ID**: ${t.id}');
  md.writeln('- **Archetype**: ${a.id}');
  md.writeln('- **Category**: ${t.category}');
  md.writeln('- **Tracking**: $tracking');
  if (t.features.isNotEmpty) {
    md.writeln('- **Features**: ${t.features.join(', ')}');
  } else {
    md.writeln('- **Features**: archetype defaults only');
  }
  md.writeln('- **Permissions**: ${a.permissions.join(', ')}');
  if (t.notes != null) {
    md.writeln('- **Note**: ${t.notes}');
  }
  md.writeln();
}

String _wrapHtml(String mdContent) {
  return '''<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Honak Business Map</title>
  <style>
    * { margin: 0; padding: 0; }
    html, body { height: 100%; overflow: hidden; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; }
    #mindmap { width: 100%; height: 100%; }
    .controls {
      position: fixed; top: 12px; right: 12px; z-index: 100;
      display: flex; gap: 8px; flex-wrap: wrap; max-width: 420px; justify-content: flex-end;
    }
    .controls button {
      padding: 6px 14px; border-radius: 8px; border: 1px solid #ddd;
      background: white; cursor: pointer; font-size: 13px; font-weight: 500;
      box-shadow: 0 1px 3px rgba(0,0,0,0.1); white-space: nowrap;
    }
    .controls button:hover { background: #f5f5f5; }
    .controls button.active { background: #1A73E8; color: white; border-color: #1A73E8; }
    .info {
      position: fixed; bottom: 12px; left: 12px; z-index: 100;
      font-size: 12px; color: #888; background: rgba(255,255,255,0.9);
      padding: 8px 14px; border-radius: 8px; line-height: 1.5;
    }
  </style>
</head>
<body>
  <svg id="mindmap"></svg>
  <div class="controls">
    <button onclick="zoomBy(1.4)" style="font-size:18px;padding:4px 12px">+</button>
    <button onclick="zoomBy(0.7)" style="font-size:18px;padding:4px 12px">−</button>
    <button onclick="mm.fit()">Fit</button>
  </div>
  <div class="info">
    Click nodes to expand/collapse · Drag to pan<br/>
    Auto-generated from page fixtures
  </div>

  <script src="https://cdn.jsdelivr.net/npm/d3@7"></script>
  <script src="https://cdn.jsdelivr.net/npm/markmap-view@0.17"></script>
  <script src="https://cdn.jsdelivr.net/npm/markmap-lib@0.17"></script>
  <script>
    const md = `$mdContent`;

    const { Transformer } = markmap;
    const transformer = new Transformer();
    const { root: data } = transformer.transform(md);

    const svg = document.getElementById('mindmap');
    const mm = markmap.Markmap.create(svg, {
      colorFreezeLevel: 2,
      initialExpandLevel: 1,
      maxWidth: 360,
      paddingX: 24,
      spacingHorizontal: 80,
      spacingVertical: 6,
      autoFit: true,
    }, data);

    function zoomBy(factor) {
      try {
        // Use markmap's rescale which pins at center of viewport
        const t = d3.zoomTransform(svg);
        mm.rescale(t.k * factor);
      } catch(e) {
        // Fallback: use d3 zoom behavior directly from markmap
        const sel = d3.select(svg);
        const t = d3.zoomTransform(svg);
        sel.transition().duration(300).call(
          mm.zoom.scaleTo, t.k * factor
        );
      }
    }

    // Click any node to expand/collapse its children
  </script>
</body>
</html>
''';
}
