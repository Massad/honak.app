/// The 8 page archetypes that determine a business Page's layout,
/// interaction model, and request flow.
///
/// Every business type maps to exactly one archetype. The archetype drives:
/// - What the customer sees on the Page (Overview tab sections)
/// - What kind of request the customer can send
/// - How the business dashboard, manage tab, and request inbox look
enum Archetype {
  /// Browse catalog -> add items -> send order request.
  /// Used by: Water Delivery, Grocery, Retail, Pharmacy, Pet Store, etc.
  catalogOrder,

  /// Browse menu with modifiers -> send order request.
  /// Used by: Restaurant, Cafe, Bakery, Coffee Shop, Home Cook, etc.
  menuOrder,

  /// Pick service + optional team member + date/time -> send booking request.
  /// Used by: Salon, Barber, Doctor, Dentist, Tutor, Lawyer, etc.
  serviceBooking,

  /// Describe problem + attach photos + urgency -> business sends quote.
  /// Used by: Plumber, Electrician, AC Tech, Painter, Carpenter, etc.
  quoteRequest,

  /// View portfolio -> send inquiry or custom order request.
  /// Used by: Photographer, Graphic Designer, Artist, Cake Designer, etc.
  portfolioInquiry,

  /// Pick space/room + dates + party size -> send reservation request.
  /// Used by: Hotel, Event Venue, Coworking, Chalet, Camp Site, etc.
  reservation,

  /// Follow for updates only -- no commerce, no requests.
  /// Used by: Municipality, NGO, School, Content Creator, Bank, etc.
  followOnly,

  /// Browse tenant directory by floor/category -- container for other pages.
  /// Used by: Shopping Mall, Commercial Building, Medical Complex, etc.
  directory;

  /// Snake-case key matching the backend/config IDs (e.g. 'catalog_order').
  String get key => switch (this) {
    catalogOrder => 'catalog_order',
    menuOrder => 'menu_order',
    serviceBooking => 'service_booking',
    quoteRequest => 'quote_request',
    portfolioInquiry => 'portfolio_inquiry',
    reservation => 'reservation',
    followOnly => 'follow_only',
    directory => 'directory',
  };

  /// Arabic display name for UI.
  String get displayNameAr => switch (this) {
    catalogOrder => 'طلب من الكتالوج',
    menuOrder => 'طلب من القائمة',
    serviceBooking => 'حجز خدمة',
    quoteRequest => 'طلب عرض سعر',
    portfolioInquiry => 'استفسار',
    reservation => 'حجز',
    followOnly => 'متابعة فقط',
    directory => 'دليل',
  };

  /// English display name for UI.
  String get displayNameEn => switch (this) {
    catalogOrder => 'Catalog Order',
    menuOrder => 'Menu Order',
    serviceBooking => 'Service Booking',
    quoteRequest => 'Quote Request',
    portfolioInquiry => 'Portfolio Inquiry',
    reservation => 'Reservation',
    followOnly => 'Follow Only',
    directory => 'Directory',
  };

  /// Whether this archetype supports customer requests (orders/bookings/quotes).
  bool get supportsRequests => switch (this) {
    followOnly || directory => false,
    _ => true,
  };

  /// Whether this archetype has a managed item catalog (products, menu, services, spaces).
  bool get hasCatalog => switch (this) {
    followOnly || directory => false,
    _ => true,
  };

  /// Resolve from snake_case key string.
  static Archetype fromKey(String key) => switch (key) {
    'catalog_order' => catalogOrder,
    'menu_order' => menuOrder,
    'service_booking' => serviceBooking,
    'quote_request' => quoteRequest,
    'portfolio_inquiry' => portfolioInquiry,
    'reservation' => reservation,
    'follow_only' => followOnly,
    'directory' => directory,
    _ => throw ArgumentError('Unknown archetype key: $key'),
  };
}
