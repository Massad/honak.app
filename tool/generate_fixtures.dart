// Reads all page_*.json fixture files and generates:
//   1. assets/api/pages/pages_list.json    — all pages with PageSummary fields
//   2. assets/api/generated/manifest.json  — page ID → fixture/type/archetype
//   3. assets/api/common/categories.json   — categories derived from actual pages
//
// Run:  dart run tool/generate_fixtures.dart
import 'dart:convert';
import 'dart:io';

// ---------------------------------------------------------------------------
// Category metadata — matches Figma categories.ts source of truth.
// Only categories with >=1 page in the data will appear in output.
// ---------------------------------------------------------------------------
const _categoryMeta = <String, Map<String, dynamic>>{
  'cat_food': {
    'name_ar': 'طعام ومشروبات',
    'name_en': 'Food & Drink',
    'icon_name': 'restaurant',
    'sort_order': 1,
  },
  'cat_delivery': {
    'name_ar': 'توصيل',
    'name_en': 'Delivery',
    'icon_name': 'delivery_dining',
    'sort_order': 2,
  },
  'cat_beauty': {
    'name_ar': 'تجميل وعناية',
    'name_en': 'Beauty & Care',
    'icon_name': 'spa',
    'sort_order': 3,
  },
  'cat_health': {
    'name_ar': 'صحة وطب',
    'name_en': 'Health & Medical',
    'icon_name': 'local_hospital',
    'sort_order': 4,
  },
  'cat_fitness': {
    'name_ar': 'رياضة ولياقة',
    'name_en': 'Fitness & Wellness',
    'icon_name': 'fitness_center',
    'sort_order': 5,
  },
  'cat_retail': {
    'name_ar': 'تسوق وأزياء',
    'name_en': 'Shopping & Fashion',
    'icon_name': 'checkroom',
    'sort_order': 6,
  },
  'cat_home_services': {
    'name_ar': 'خدمات منزلية',
    'name_en': 'Home Services',
    'icon_name': 'home_repair_service',
    'sort_order': 7,
  },
  'cat_auto': {
    'name_ar': 'سيارات',
    'name_en': 'Automotive',
    'icon_name': 'directions_car',
    'sort_order': 8,
  },
  'cat_stays': {
    'name_ar': 'إقامة وسياحة',
    'name_en': 'Stays & Tourism',
    'icon_name': 'hotel',
    'sort_order': 9,
  },
  'cat_entertainment': {
    'name_ar': 'فعاليات وترفيه',
    'name_en': 'Events & Entertainment',
    'icon_name': 'celebration',
    'sort_order': 10,
  },
  'cat_creative': {
    'name_ar': 'إبداع وعمل حر',
    'name_en': 'Creative & Freelance',
    'icon_name': 'palette',
    'sort_order': 11,
  },
  'cat_government': {
    'name_ar': 'جهات حكومية',
    'name_en': 'Government',
    'icon_name': 'account_balance',
    'sort_order': 12,
  },
  'cat_services': {
    'name_ar': 'خدمات عامة',
    'name_en': 'General Services',
    'icon_name': 'build',
    'sort_order': 13,
  },
  'cat_electronics': {
    'name_ar': 'إلكترونيات وصيانة',
    'name_en': 'Electronics & Repair',
    'icon_name': 'phonelink',
    'sort_order': 14,
  },
  'cat_grocery': {
    'name_ar': 'بقالة وسوبرماركت',
    'name_en': 'Grocery',
    'icon_name': 'shopping_cart',
    'sort_order': 15,
  },
};

// ---------------------------------------------------------------------------
// Business-type emoji icons for category types array.
// ---------------------------------------------------------------------------
const _typeIcons = <String, String>{
  'restaurant': '🍽️',
  'cafe': '☕',
  'bakery': '🥖',
  'sweet_shop': '🍮',
  'juice_bar': '🧃',
  'butcher': '🥩',
  'produce': '🥬',
  'catering': '🍱',
  'water_delivery': '🚰',
  'gas_delivery': '🔥',
  'salon': '💇',
  'barber': '💈',
  'spa': '🧖',
  'cosmetics_store': '💄',
  'clinic': '🏥',
  'pharmacy': '💊',
  'physiotherapy': '🦴',
  'vet_clinic': '🐾',
  'gym': '🏋️',
  'clothes_store': '👗',
  'online_store': '🛒',
  'bookstore': '📚',
  'bridal_shop': '👰',
  'kids_store': '👶',
  'perfume_shop': '🧴',
  'electronics_store': '📱',
  'mini_market': '🏪',
  'directory': '🏬',
  'plumber': '🔧',
  'electrician': '⚡',
  'ac_repair': '❄️',
  'pest_control': '🐛',
  'laundry': '👔',
  'car_mechanic': '🔧',
  'car_wash': '🚿',
  'oil_change': '🛢️',
  'tire_shop': '🛞',
  'villa_rental': '🏡',
  'hotel': '🏨',
  'camping': '⛺',
  'event_venue': '🏛️',
  'photographer': '📷',
  'government': '🏛️',
  'municipality': '🏛️',
  'tailor': '🧵',
  'shoe_repair': '👞',
  'watch_repair': '⌚',
  'mobile_repair': '📱',
  'grocery': '🏪',
};

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------
void main() {
  final pagesDir = Directory('assets/api/pages');
  final generatedDir = Directory('assets/api/generated');

  if (!generatedDir.existsSync()) {
    generatedDir.createSync(recursive: true);
  }

  // Collect all page_*.json files (excluding page_team_members.json)
  final pageFiles = pagesDir
      .listSync()
      .whereType<File>()
      .where((f) {
        final name = f.uri.pathSegments.last;
        return name.startsWith('page_') &&
            name != 'page_team_members.json' &&
            name.endsWith('.json');
      })
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  final pagesList = <Map<String, dynamic>>[];
  final manifest = <String, Map<String, dynamic>>{};
  // cat_id → {type_id: type_name}
  final categoryTypes = <String, Map<String, String>>{};

  for (final file in pageFiles) {
    final content = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    final data = content['data'] as Map<String, dynamic>?;
    if (data == null) {
      stderr.writeln('WARN: no "data" key in ${file.path}, skipping');
      continue;
    }

    final id = data['id'] as String?;
    if (id == null) {
      stderr.writeln('WARN: no "data.id" in ${file.path}, skipping');
      continue;
    }

    final summary = content['_summary'] as Map<String, dynamic>? ?? {};
    final fileName = file.uri.pathSegments.last.replaceAll('.json', '');
    final fixturePath = 'pages/$fileName';

    final isVerified = data['is_verified'] as bool? ?? false;
    final hasStories = (data['stories'] as List?)?.isNotEmpty ?? false;

    // -- Manifest entry --
    manifest[id] = {
      'fixture': fixturePath,
      'business_type_id': data['business_type_id'] ?? '',
      'archetype': data['archetype'] ?? '',
    };

    // -- Pages-list entry --
    final entry = <String, dynamic>{
      'id': id,
      'name': data['name'],
      'slug': data['slug'] ?? id,
      'avatar_url': data['avatar_url'],
      'cover_url': data['cover_url'],
      'business_type_name': data['business_type_name'],
      'business_type_id': data['business_type_id'],
      'explore_category': data['explore_category'],
      'archetype': data['archetype'],
      'engagement_level': summary['engagement_level'] ??
          data['engagement_level'] ??
          (isVerified ? 'full' : 'visibility'),
      'is_open': summary['is_open'] ?? data['is_open'] ?? isVerified,
      'store_type': data['store_type'],
      'is_verified': isVerified,
      'is_following': summary['is_following'] ??
          data['is_following'] ??
          false,
      'followers_count': data['followers_count'] ?? 0,
      'trust_metrics': data['trust_metrics'] ?? [],
      'location': _locationSummary(data['location']),
      'distance': summary['distance'],
      'has_active_stories':
          summary['has_active_stories'] ?? hasStories,
      'monthly_metric': summary['monthly_metric'],
      'sub_category': summary['sub_category'],
    };

    if (data.containsKey('claim_status')) {
      entry['claim_status'] = data['claim_status'];
    }

    pagesList.add(entry);

    // -- Collect for categories --
    final cat = data['explore_category'] as String?;
    final typeId = data['business_type_id'] as String?;
    final typeName = data['business_type_name'] as String?;
    if (cat != null && typeId != null && typeName != null) {
      categoryTypes.putIfAbsent(cat, () => {});
      categoryTypes[cat]![typeId] = typeName;
    }
  }

  // Sort pages by category sort_order, then by Arabic name.
  pagesList.sort((a, b) {
    final catA = a['explore_category'] as String? ?? '';
    final catB = b['explore_category'] as String? ?? '';
    final sortA = _categoryMeta[catA]?['sort_order'] as int? ?? 99;
    final sortB = _categoryMeta[catB]?['sort_order'] as int? ?? 99;
    final cmp = sortA.compareTo(sortB);
    if (cmp != 0) return cmp;
    return (a['name'] as String? ?? '').compareTo(b['name'] as String? ?? '');
  });

  // ===== Output 1: pages_list.json =====
  _writeJson(
    'assets/api/pages/pages_list.json',
    {'success': true, 'data': pagesList},
  );
  stdout.writeln('  pages_list.json      ${pagesList.length} pages');

  // ===== Output 2: manifest.json =====
  final sortedManifest = Map.fromEntries(
    manifest.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
  );
  _writeJson(
    'assets/api/generated/manifest.json',
    {
      '_generated': DateTime.now().toUtc().toIso8601String(),
      'pages': sortedManifest,
    },
  );
  stdout.writeln('  manifest.json        ${manifest.length} entries');

  // ===== Output 3: categories.json =====
  final categories = <Map<String, dynamic>>[];
  for (final catId in _categoryMeta.keys) {
    final types = categoryTypes[catId];
    if (types == null || types.isEmpty) continue;

    final meta = _categoryMeta[catId]!;
    final typesList = types.entries
        .map((e) => {
              'id': e.key,
              'name': e.value,
              'icon': _typeIcons[e.key] ?? '',
            })
        .toList()
      ..sort((a, b) => a['name']!.compareTo(b['name']!));

    categories.add({
      'id': catId,
      'name_ar': meta['name_ar'],
      'name_en': meta['name_en'],
      'icon_name': meta['icon_name'],
      'sort_order': meta['sort_order'],
      'types': typesList,
    });
  }

  _writeJson(
    'assets/api/common/categories.json',
    {
      'success': true,
      'data': categories,
      'meta': {'total': categories.length, 'has_more': false},
    },
  );
  stdout.writeln('  categories.json      ${categories.length} categories');

  stdout.writeln('\nDone.');
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Map<String, dynamic>? _locationSummary(dynamic loc) {
  if (loc == null) return null;
  if (loc is! Map) return null;
  return {
    'area': loc['area'],
    'city': loc['city'],
  };
}

void _writeJson(String path, Object data) {
  File(path).writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert(data)}\n',
  );
}
