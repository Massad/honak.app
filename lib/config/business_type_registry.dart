import 'archetype.dart';
import 'business_type_config.dart';
import 'types/food_types.dart';
import 'types/catalog_types.dart';
import 'types/service_types.dart';
import 'types/quote_types.dart';
import 'types/portfolio_types.dart';
import 'types/reservation_types.dart';
import 'types/misc_types.dart';

// ═══════════════════════════════════════════════════════════════
// Business Type Registry
// ═══════════════════════════════════════════════════════════════
// Central registry of all business type configs.
// Collects types from all type files and provides lookup methods.
// ═══════════════════════════════════════════════════════════════

class BusinessTypeRegistry {
  BusinessTypeRegistry._();

  /// All registered business type configs, keyed by type ID.
  static final Map<String, BusinessTypeConfig> _byId = {
    for (final config in _allTypes) config.id: config,
  };

  /// Flat list of every registered type config.
  static final List<BusinessTypeConfig> _allTypes = [
    ...foodTypes,
    ...catalogTypes,
    ...serviceTypes,
    ...quoteTypes,
    ...portfolioTypes,
    ...reservationTypes,
    ...miscTypes,
  ];

  /// Get config by exact type ID. Throws if not found.
  static BusinessTypeConfig getConfig(String typeId) {
    final config = _byId[typeId];
    if (config == null) {
      throw ArgumentError('Unknown business type ID: $typeId');
    }
    return config;
  }

  /// Try to get config by type ID. Returns null if not found.
  static BusinessTypeConfig? tryGetConfig(String typeId) => _byId[typeId];

  /// All registered type configs (unmodifiable).
  static List<BusinessTypeConfig> getAllTypes() =>
      List.unmodifiable(_allTypes);

  /// All types that belong to [archetype].
  static List<BusinessTypeConfig> getTypesByArchetype(Archetype archetype) =>
      _allTypes.where((t) => t.archetype == archetype).toList();

  /// All types that match [categoryEn] (case-insensitive).
  static List<BusinessTypeConfig> getTypesByCategory(String categoryEn) {
    final lower = categoryEn.toLowerCase();
    return _allTypes
        .where((t) => t.categoryEn.toLowerCase() == lower)
        .toList();
  }

  /// All registered type IDs.
  static List<String> getAllTypeIds() =>
      _allTypes.map((t) => t.id).toList();
}
