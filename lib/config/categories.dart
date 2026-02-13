// Honak — Explore Categories
//
// 21 customer-facing categories for the Explore screen.
// Each maps to one or more archetypes.

class ExploreCategory {
  final String id;
  final String nameAr;
  final String nameEn;
  final String icon;
  final List<String> archetypes;
  final int sortOrder;

  const ExploreCategory({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.icon,
    required this.archetypes,
    required this.sortOrder,
  });
}

const exploreCategories = <ExploreCategory>[
  ExploreCategory(
    id: 'food',
    nameAr: 'طعام ومشروبات',
    nameEn: 'Food & Drink',
    icon: 'restaurant',
    archetypes: ['menu_order'],
    sortOrder: 1,
  ),
  ExploreCategory(
    id: 'grocery',
    nameAr: 'بقالة واحتياجات يومية',
    nameEn: 'Grocery & Daily Needs',
    icon: 'shopping_cart',
    archetypes: ['catalog_order'],
    sortOrder: 2,
  ),
  ExploreCategory(
    id: 'delivery',
    nameAr: 'خدمات التوصيل',
    nameEn: 'Delivery Services',
    icon: 'local_shipping',
    archetypes: ['catalog_order'],
    sortOrder: 3,
  ),
  ExploreCategory(
    id: 'beauty',
    nameAr: 'جمال وعناية',
    nameEn: 'Beauty & Personal Care',
    icon: 'content_cut',
    archetypes: ['service_booking'],
    sortOrder: 4,
  ),
  ExploreCategory(
    id: 'health',
    nameAr: 'صحة وطب',
    nameEn: 'Health & Medical',
    icon: 'medical_services',
    archetypes: ['service_booking'],
    sortOrder: 5,
  ),
  ExploreCategory(
    id: 'pharmacy',
    nameAr: 'صيدلية ومنتجات صحية',
    nameEn: 'Pharmacy & Health Products',
    icon: 'medication',
    archetypes: ['catalog_order'],
    sortOrder: 6,
  ),
  ExploreCategory(
    id: 'fitness',
    nameAr: 'لياقة وعافية',
    nameEn: 'Fitness & Wellness',
    icon: 'fitness_center',
    archetypes: ['service_booking'],
    sortOrder: 7,
  ),
  ExploreCategory(
    id: 'home_services',
    nameAr: 'خدمات منزلية',
    nameEn: 'Home Services',
    icon: 'build',
    archetypes: ['quote_request'],
    sortOrder: 8,
  ),
  ExploreCategory(
    id: 'auto',
    nameAr: 'سيارات وصيانة',
    nameEn: 'Auto Services',
    icon: 'directions_car',
    archetypes: ['quote_request', 'service_booking'],
    sortOrder: 9,
  ),
  ExploreCategory(
    id: 'cleaning',
    nameAr: 'غسيل وتنظيف',
    nameEn: 'Laundry & Cleaning',
    icon: 'auto_awesome',
    archetypes: ['service_booking'],
    sortOrder: 10,
  ),
  ExploreCategory(
    id: 'shopping',
    nameAr: 'تسوق وأزياء',
    nameEn: 'Shopping & Fashion',
    icon: 'shopping_bag',
    archetypes: ['catalog_order'],
    sortOrder: 11,
  ),
  ExploreCategory(
    id: 'electronics',
    nameAr: 'إلكترونيات وتقنية',
    nameEn: 'Electronics & Tech',
    icon: 'smartphone',
    archetypes: ['catalog_order'],
    sortOrder: 12,
  ),
  ExploreCategory(
    id: 'stays',
    nameAr: 'إقامة وعطلات',
    nameEn: 'Stays & Vacation',
    icon: 'bed',
    archetypes: ['reservation'],
    sortOrder: 13,
  ),
  ExploreCategory(
    id: 'events',
    nameAr: 'مناسبات وترفيه',
    nameEn: 'Events & Entertainment',
    icon: 'celebration',
    archetypes: ['reservation'],
    sortOrder: 14,
  ),
  ExploreCategory(
    id: 'education',
    nameAr: 'تعليم وتدريب',
    nameEn: 'Education & Training',
    icon: 'school',
    archetypes: ['service_booking'],
    sortOrder: 15,
  ),
  ExploreCategory(
    id: 'creative',
    nameAr: 'خدمات إبداعية',
    nameEn: 'Creative Services',
    icon: 'palette',
    archetypes: ['portfolio_inquiry'],
    sortOrder: 16,
  ),
  ExploreCategory(
    id: 'professional',
    nameAr: 'خدمات مهنية',
    nameEn: 'Professional Services',
    icon: 'work',
    archetypes: ['quote_request'],
    sortOrder: 17,
  ),
  ExploreCategory(
    id: 'pets',
    nameAr: 'حيوانات أليفة',
    nameEn: 'Pets & Veterinary',
    icon: 'pets',
    archetypes: ['service_booking', 'catalog_order'],
    sortOrder: 18,
  ),
  ExploreCategory(
    id: 'finance',
    nameAr: 'بنوك وصرافة',
    nameEn: 'Finance & Banking',
    icon: 'account_balance',
    archetypes: ['follow_only'],
    sortOrder: 19,
  ),
  ExploreCategory(
    id: 'government',
    nameAr: 'جهات حكومية ورسمية',
    nameEn: 'Government & Official',
    icon: 'assured_workload',
    archetypes: ['follow_only'],
    sortOrder: 20,
  ),
  ExploreCategory(
    id: 'shopping_centers',
    nameAr: 'مجمعات تجارية',
    nameEn: 'Shopping Centers',
    icon: 'domain',
    archetypes: ['directory'],
    sortOrder: 21,
  ),
];

/// Lookup category by id.
ExploreCategory? getCategoryById(String id) {
  for (final c in exploreCategories) {
    if (c.id == id) return c;
  }
  return null;
}

/// Get categories for a specific archetype.
List<ExploreCategory> getCategoriesForArchetype(String archetype) {
  return exploreCategories
      .where((c) => c.archetypes.contains(archetype))
      .toList();
}
