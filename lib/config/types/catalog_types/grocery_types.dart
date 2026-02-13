// ============================================================
// Grocery & Specialty Store Types — catalogOrder archetype
// pharmacy, supermarket, butcher, fruit_veg, electronics_store
// ============================================================

import '../../archetype.dart';
import '../../archetype_defaults.dart';
import '../../business_type_config.dart';

// ─── Pharmacy (compact — createType) ───────────────────────

final pharmacy = createType(
  id: 'pharmacy',
  nameAr: 'صيدلية',
  nameEn: 'Pharmacy',
  categoryAr: 'صيدلية ومنتجات صحية',
  categoryEn: 'Pharmacy',
  archetype: Archetype.catalogOrder,
  icon: '💊',
  features: ['product_catalog', 'cart', 'order_tracking', 'inventory'],
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات قيد التجهيز',
    completed: 'طلبات مكتملة',
    itemUnit: 'دواء',
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'صيدلي',
        defaultPermissions: [
          'manage_catalog',
          'manage_orders',
          'respond_chat',
        ]),
    SuggestedRole(
        labelAr: 'مساعد صيدلي',
        defaultPermissions: ['manage_orders']),
    SuggestedRole(
      labelAr: 'مدير',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
        'post_updates',
      ],
    ),
  ],
  itemManagement: ItemManagementConfig(
    sourceField: 'catalog',
    itemLabelAr: 'دواء',
    itemsLabelAr: 'الأدوية',
    addLabelAr: 'إضافة دواء',
    hasImage: true,
    hasCategory: true,
    hasDescription: true,
    hasPrice: true,
    properties: [],
    quantityMode: QuantityMode.perItem,
    canDiscount: true,
  ),
);

// ─── Supermarket (compact — createType) ────────────────────

final supermarket = createType(
  id: 'supermarket',
  nameAr: 'سوبرماركت',
  nameEn: 'Supermarket',
  categoryAr: 'بقالة واحتياجات يومية',
  categoryEn: 'Supermarket',
  archetype: Archetype.catalogOrder,
  icon: '🛒',
  features: ['product_catalog', 'cart', 'order_tracking', 'inventory'],
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات قيد التجهيز',
    completed: 'طلبات مكتملة',
    itemUnit: 'منتج',
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'كاشير',
        defaultPermissions: ['manage_orders', 'respond_chat']),
    SuggestedRole(
        labelAr: 'موظف رفوف', defaultPermissions: ['manage_catalog']),
    SuggestedRole(
        labelAr: 'موصّل', defaultPermissions: ['manage_orders']),
    SuggestedRole(
      labelAr: 'مدير',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
        'post_updates',
      ],
    ),
  ],
);

// ─── Butcher (compact — createType) ────────────────────────

final butcher = createType(
  id: 'butcher',
  nameAr: 'ملحمة',
  nameEn: 'Butcher',
  categoryAr: 'بقالة واحتياجات يومية',
  categoryEn: 'Butcher',
  archetype: Archetype.catalogOrder,
  icon: '🥩',
  features: ['product_catalog', 'cart', 'order_tracking'],
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات قيد التحضير',
    completed: 'طلبات مكتملة',
    itemUnit: 'منتج',
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'جزار',
        defaultPermissions: ['manage_catalog', 'manage_orders']),
    SuggestedRole(
        labelAr: 'موصّل', defaultPermissions: ['manage_orders']),
  ],
  itemManagement: ItemManagementConfig(
    sourceField: 'catalog',
    itemLabelAr: 'منتج',
    itemsLabelAr: 'المنتجات',
    addLabelAr: 'إضافة منتج',
    hasImage: true,
    hasCategory: true,
    hasDescription: false,
    hasPrice: true,
    properties: [],
    quantityMode: QuantityMode.open,
    canDiscount: true,
  ),
);

// ─── Fruit & Vegetables (compact — createType) ─────────────

final fruitVeg = createType(
  id: 'fruit_veg',
  nameAr: 'خضار وفواكه',
  nameEn: 'Fruit & Vegetables',
  categoryAr: 'بقالة واحتياجات يومية',
  categoryEn: 'Fruit & Vegetables',
  archetype: Archetype.catalogOrder,
  icon: '🥬',
  features: ['product_catalog', 'cart', 'order_tracking'],
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات قيد التجهيز',
    completed: 'طلبات مكتملة',
    itemUnit: 'صنف',
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'بائع',
        defaultPermissions: ['manage_catalog', 'manage_orders']),
    SuggestedRole(
        labelAr: 'موصّل', defaultPermissions: ['manage_orders']),
  ],
  itemManagement: ItemManagementConfig(
    sourceField: 'catalog',
    itemLabelAr: 'صنف',
    itemsLabelAr: 'المنتجات',
    addLabelAr: 'إضافة صنف',
    hasImage: true,
    hasCategory: true,
    hasDescription: false,
    hasPrice: true,
    properties: [],
    quantityMode: QuantityMode.open,
    canDiscount: true,
  ),
);

// ─── Mini Market (compact — createType) ──────────────────────

final miniMarket = createType(
  id: 'mini_market',
  nameAr: 'ميني ماركت',
  nameEn: 'Mini Market',
  categoryAr: 'بقالة واحتياجات يومية',
  categoryEn: 'Mini Market',
  archetype: Archetype.catalogOrder,
  icon: '🏪',
  features: ['product_catalog', 'cart', 'order_tracking'],
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات قيد التجهيز',
    completed: 'طلبات مكتملة',
    itemUnit: 'منتج',
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'بائع',
        defaultPermissions: ['manage_catalog', 'manage_orders']),
    SuggestedRole(
        labelAr: 'موصّل', defaultPermissions: ['manage_orders']),
  ],
  itemManagement: ItemManagementConfig(
    sourceField: 'catalog',
    itemLabelAr: 'منتج',
    itemsLabelAr: 'المنتجات',
    addLabelAr: 'إضافة منتج',
    hasImage: true,
    hasCategory: true,
    hasDescription: false,
    hasPrice: true,
    properties: [],
    quantityMode: QuantityMode.perItem,
    canDiscount: true,
  ),
);

// ─── Produce (compact — createType) ──────────────────────────

final produce = createType(
  id: 'produce',
  nameAr: 'خضار وفواكه',
  nameEn: 'Produce',
  categoryAr: 'بقالة واحتياجات يومية',
  categoryEn: 'Produce',
  archetype: Archetype.catalogOrder,
  icon: '🥦',
  features: ['product_catalog', 'cart', 'order_tracking'],
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات قيد التجهيز',
    completed: 'طلبات مكتملة',
    itemUnit: 'صنف',
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'بائع',
        defaultPermissions: ['manage_catalog', 'manage_orders']),
    SuggestedRole(
        labelAr: 'موصّل', defaultPermissions: ['manage_orders']),
  ],
  itemManagement: ItemManagementConfig(
    sourceField: 'catalog',
    itemLabelAr: 'صنف',
    itemsLabelAr: 'المنتجات',
    addLabelAr: 'إضافة صنف',
    hasImage: true,
    hasCategory: true,
    hasDescription: false,
    hasPrice: true,
    properties: [],
    quantityMode: QuantityMode.open,
    canDiscount: true,
  ),
);

// ─── Electronics Store (compact — createType) ──────────────

final electronicsStore = createType(
  id: 'electronics_store',
  nameAr: 'إلكترونيات',
  nameEn: 'Electronics Store',
  categoryAr: 'إلكترونيات وتقنية',
  categoryEn: 'Electronics',
  archetype: Archetype.catalogOrder,
  icon: '📱',
  features: ['product_catalog', 'cart', 'order_tracking', 'inventory'],
  coverageModel: CoverageModel.none,
  orderLabels: OrderLabels(
    incoming: 'طلبات جديدة',
    accepted: 'طلبات مؤكدة',
    completed: 'طلبات مكتملة',
    itemUnit: 'جهاز',
  ),
  suggestedRoles: [
    SuggestedRole(
        labelAr: 'بائع',
        defaultPermissions: [
          'manage_catalog',
          'manage_orders',
          'respond_chat',
        ]),
    SuggestedRole(
        labelAr: 'فني', defaultPermissions: ['manage_orders']),
    SuggestedRole(
      labelAr: 'مدير',
      defaultPermissions: [
        'manage_orders',
        'manage_catalog',
        'respond_chat',
        'view_insights',
        'post_updates',
      ],
    ),
  ],
);
