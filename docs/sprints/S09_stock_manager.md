# S09 — Stock Manager Sheet + Business Orders Fixture

> **Size:** Medium (~6-8 files, ~4-5 hours)
> **Priority:** P1
> **Figma reference:** `app-figma/src/app/components/business-mode/StockManager.tsx` (467 lines), `app-figma/src/api/orders/business_orders.json` (592 lines)

---

## What This Is

Two related deliverables:

1. **Stock Manager Sheet** — A modal bottom sheet for batch stock/inventory updates. Accessible from dashboard or catalog management. Lets catalog-based businesses quickly update quantities and low-stock thresholds.

2. **Business Orders Fixture** — Mock fixture data for business-side order management, covering 13 business types with 4 status buckets (pending/accepted/in_progress/completed).

## Why It Matters

**Stock Manager**: Catalog businesses (water delivery, grocery, pharmacy, bookstore) need a quick way to update inventory without navigating through the full catalog editor. This is a "quick action" sheet accessible from the dashboard's low-stock alert.

**Business Orders Fixture**: Currently, business order management widgets exist but use minimal mock data. The comprehensive fixture enables realistic testing of the order flow across all archetypes.

## Current State in Flutter (VERIFIED)

### What Already Exists

**Catalog Management** (`lib/features/business/catalog_management/`):
- Full catalog editor with 19+ widgets
- `CatalogItem` entity with `stock` (int, nullable) and `lowStockThreshold` (int, nullable) fields
- `CatalogItemsProvider` for fetching/managing items
- Item editing with price history, mass actions
- BUT: no quick bulk stock update sheet

**Dashboard** (`lib/features/business/dashboard/`):
- `business_dashboard_page.dart` — config-driven sections
- Dashboard sections include low-stock alerts (when items below threshold)
- Dashboard tap actions can show sheets
- BUT: low-stock section taps have no dedicated stock update UI

**Order Management** (`lib/features/business/order_management/`):
- 20+ widgets for request handling
- `truck_detail_overlay.dart`, `walk_up_order_sheet.dart`
- Request actions (accept, decline, suggest alternative)
- BUT: business orders fixture is minimal — most order data comes from customer-side fixtures

**Mock API** (`shared/api/mock_api_client.dart`):
- Convention-based routing: `business/dashboard/{type_id}.json`
- Sub-resource pattern: `products/items_{type_id}.json`
- Manifest-based page routing

**Business Orders Fixtures** (already exist at `assets/api/orders/`):
- `orders_business.json` — generic business order list
- `orders_customer.json` — customer order list
- `order_detail_pending.json`, `order_detail_confirmed.json`, `order_detail_delivered.json`, `order_detail_cancelled.json`
- These are basic/generic — the Figma version has per-business-type orders (13 types)

**Truck Inventory** (`lib/features/business/order_management/presentation/widgets/truck_inventory.dart`):
- Delivery-specific truck inventory (full/empty bottles, capacity)
- NOT a generic stock management system — only for truck-based delivery

### What's Missing

- No `StockManagerSheet` widget for generic catalog stock management
- No batch stock update UI anywhere
- No `stock_change` entity/model
- Existing business orders fixtures are generic — need per-type enhancement to match Figma's 13-type coverage

## Requirements

### Part A: Stock Manager Sheet

#### 1. Stock Entities

Create `lib/features/business/catalog_management/domain/entities/stock_change.dart`:

**StockChange** — itemId (String), itemName (String), originalStock (int), newStock (int), category (String, nullable)

**ThresholdChange** — itemId (String), originalThreshold (int), newThreshold (int)

Plain Dart classes (read-only, no freezed needed).

#### 2. Stock Manager Sheet Widget

Create `lib/features/business/catalog_management/presentation/widgets/stock_manager_sheet.dart`:

A full-height modal bottom sheet that shows:

**Header:**
- Title: "تحديث المخزون" (Update Stock)
- Pending changes badge (shows count of unsaved changes)
- "تراجع عن الكل" (Undo All) button — resets all changes

**Search + Filters:**
- Search field to filter items by name
- 3 filter tabs: "الكل" (All), "مخزون منخفض" (Low Stock — amber), "نفذ" (Out of Stock — red)
- Filter chips highlight with appropriate colors

**Item List:**
- Each item row shows:
  - Item name (truncated)
  - Current stock number with color indicator:
    - Green (>= threshold): normal
    - Amber (> 0 but < threshold): low stock
    - Red (== 0): out of stock
  - +/- stepper buttons for quick adjustment
  - Tap on stock number to type exact value
  - Stock threshold display (tap to edit)

**Stock Bar Indicator:**
- Small progress bar per item showing stock level relative to threshold
- Green/amber/red coloring based on status

**Footer:**
- "حفظ التغييرات" (Save Changes) button — disabled when no changes
- Shows summary: "X تغييرات" (X changes)
- On save: toast confirmation "تم تحديث المخزون" with undo option

#### 3. Stock Manager Provider

Create `lib/features/business/catalog_management/presentation/providers/stock_manager_provider.dart`:

- `stockChangesProvider` — StateNotifier tracking pending changes (Map of itemId → StockChange)
- `filteredStockItemsProvider` — combines catalog items with search query and filter mode
- `stockFilterModeProvider` — StateProvider for filter mode (all/low/out)
- `stockSearchQueryProvider` — StateProvider for search text

#### 4. Dashboard Integration

Modify the dashboard's low-stock section to add a tap action that opens `StockManagerSheet`.

In the dashboard section config, when `lowStockAlert` or similar section is tapped, call:
```dart
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  builder: (_) => const StockManagerSheet(pageId: currentPageId),
);
```

### Part B: Business Orders Fixture

#### 5. Business Orders Fixture File

Enhance the existing `assets/api/orders/` directory with per-business-type fixture files.

Flutter already has generic order fixtures at `assets/api/orders/` (orders_business.json, order_detail_*.json). The Figma prototype has a much richer `business_orders.json` keyed by business ID with 4 status buckets: pending, accepted, in_progress, completed — covering 13 business types.

**Order shape:**
```json
{
  "id": "AW-201",
  "customer": "سارة م.",
  "avatar": "picsum.photos URL",
  "type": "order|quote|booking|reservation|inquiry",
  "summary": "٦ قوارير مياه ١٩ لتر",
  "total": "٩.٠٠ د.أ",
  "time": "منذ ١٠ دقائق",
  "created_at": "١٤ فبراير ٢٠٢٦ · ١٠:٠٥ ص",
  "urgent": true,
  "items": [{ "name": "...", "qty": 6, "price": "١.٥٠" }],
  "delivery_method": "توصيل",
  "delivery_address": "عبدون — شارع ١٢",
  "timeline": [
    { "status": "pending", "label": "طلب جديد", "time": "١٠:٠٥", "done": true }
  ]
}
```

Create fixture files for at least these business types (matching the Figma data):
- `water_delivery.json` — catalog orders with delivery
- `restaurant.json` — menu orders with delivery/pickup
- `plumber.json` — quote requests with job types
- `salon.json` — service bookings
- `villa_rental.json` — reservations

Each file has the 4 status buckets with 2-3 orders per bucket using realistic Arabic names and Amman neighborhoods.

#### 6. Mock API Route

Add route handling in the mock API for business orders:
- Path pattern: `GET /api/business/orders/{page_id}?status=pending|accepted|in_progress|completed`
- Or: `GET /api/business/orders/{business_type_id}` resolving by convention

Register the new asset directory in `pubspec.yaml` under `flutter.assets`.

## Files to Create

1. `lib/features/business/catalog_management/domain/entities/stock_change.dart`
2. `lib/features/business/catalog_management/presentation/widgets/stock_manager_sheet.dart`
3. `lib/features/business/catalog_management/presentation/providers/stock_manager_provider.dart`
4. `assets/api/business/orders/water_delivery.json`
5. `assets/api/business/orders/restaurant.json`
6. `assets/api/business/orders/plumber.json`
7. `assets/api/business/orders/salon.json`
8. `assets/api/business/orders/villa_rental.json`

## Files to Modify

1. `pubspec.yaml` — add `assets/api/business/orders/` to flutter.assets
2. Dashboard section (tap handler) — open StockManagerSheet on low-stock tap

## Testing

**Stock Manager testing:**
- **Sara** (0790000001/111111) → switch to business → select "pharmacy" or "bakery" page → Dashboard → tap low-stock section → Stock Manager should open
- **Ahmad** (0790000002/222222) → select "water_delivery" page → verify stock items with +/- steppers
- Test search, filter modes (all/low/out), threshold editing
- Test save with pending changes badge + undo

**Business Orders fixture testing:**
- Verify fixture files load via MockApiClient
- Check JSON structure matches expected order shape
- Verify all status buckets have realistic Arabic data

## Acceptance Criteria

- [ ] StockChange and ThresholdChange entities created
- [ ] StockManagerSheet renders as full-height bottom sheet
- [ ] Search filters items by name
- [ ] 3 filter modes work (all/low/out)
- [ ] +/- steppers update stock counts
- [ ] Tap stock number opens direct input
- [ ] Stock bar colors correctly (green/amber/red)
- [ ] Pending changes badge shows count
- [ ] Undo All resets changes
- [ ] Save shows toast confirmation
- [ ] Dashboard low-stock section opens StockManagerSheet
- [ ] Business orders fixtures created for 5 types
- [ ] Asset directory registered in pubspec.yaml
- [ ] `flutter analyze` passes
- [ ] App runs without errors

## Patterns to Follow

- Entities: plain Dart classes (read-only view models)
- Sheet pattern: same as existing `walk_up_order_sheet.dart` (DraggableScrollableSheet in showModalBottomSheet)
- Provider: StateNotifier for managing changes, FutureProvider for filtered list
- RTL: `EdgeInsetsDirectional`, Arabic labels
- Colors: `AppColors.success` (green), `AppColors.warning` (amber), `AppColors.error` (red)
- Mock fixtures: realistic Arabic, Amman neighborhoods, JOD prices as strings
- Asset registration: add directory to `pubspec.yaml` `flutter.assets` list
