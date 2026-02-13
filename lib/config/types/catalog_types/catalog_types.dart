// ============================================================
// Catalog Order Types — barrel file
// Re-exports all catalogOrder archetype type definitions
// ============================================================

import '../../business_type_config.dart';

export 'delivery_types.dart';
export 'grocery_types.dart';
export 'retail_types.dart';

// We need to import the individual files to access the variables
// for the combined list below.
import 'delivery_types.dart';
import 'grocery_types.dart';
import 'retail_types.dart';

// ─── Exported list ─────────────────────────────────────────

final catalogTypes = <BusinessTypeConfig>[
  waterDelivery,
  gasDelivery,
  clothesStore,
  bookstore,
  onlineStore,
  pharmacy,
  supermarket,
  butcher,
  fruitVeg,
  miniMarket,
  produce,
  electronicsStore,
];
