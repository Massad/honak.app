# Session Coordination Plan — 4 Sessions

## How It Works

**4 sessions, each runs multiple rounds:**
1. Paste **Preamble** (`docs/SESSION_PREAMBLE.md`) + **Round 1 prompt** (from this doc)
2. Session does the work, reports what it did
3. Paste **Verify** prompt (short — session has context)
4. Paste **Round 2 prompt** → verify → **Round 3** → verify → etc.

**ALL 4 sessions can run simultaneously — zero file conflicts between sessions at any round.**

---

## Session Assignment Overview

| Session | Round 1 | Round 2 | Round 3 | Round 4 |
|---------|---------|---------|---------|---------|
| **1** | S10 Sprint | Insights Batch (25 generators) | — | — |
| **2** | S11 Sprint | Reservation (event_venue + villa_rental) | Portfolio (photographer) | Delivery (gas + water) |
| **3** | Villa Manage | Misc (bank, directory, government) | Grocery (mini_market, butcher, produce) | Catalog (pharmacy, electronics_store) |
| **4** | Food Group | Service Group (11 types) | Retail (clothes_store, online_store) | — |

**Why this assignment:**
- Session 1 did order code → Insights is code-heavy (same muscle)
- Session 2 did reservation entities → Reservation config is same domain, then Portfolio + Delivery are light
- Session 3 did villa/settings → Misc is similar "odd types", then Grocery + Catalog are config alignment
- Session 4 did food config+fixtures → Service Group is the exact same pattern, then Retail is too

---

## File Ownership Map (Why Zero Conflicts)

| Session | Round | Dart files | JSON files |
|---------|-------|-----------|-----------|
| 1 | R1 | `order_management/pages/detail_page.dart`, `order_management/widgets/request_activity_utils.dart` (NEW) | — |
| 1 | R2 | `insights/data/insights_mock_data.dart`, `insights/domain/insight_chart_config.dart` | — |
| 2 | R1 | 9 NEW files under `order_management/` (no overlap with S1-R1) | — |
| 2 | R2 | `config/types/reservation_types.dart` | `dashboard/event_venue.json`, `dashboard/villa_rental.json` |
| 2 | R3 | `config/types/portfolio_types.dart` | `dashboard/photographer.json` |
| 2 | R4 | `config/types/catalog_types/delivery_types.dart` | `dashboard/gas_delivery.json`, `dashboard/water_delivery.json` |
| 3 | R1 | `catalog_management/pages/villa_manage_page.dart` (NEW), `business_home_page.dart`, `settings_page.dart` | `page_villa.json` |
| 3 | R2 | `config/types/misc_types.dart` | `dashboard/bank.json` (NEW), `dashboard/directory.json`, `dashboard/government.json` |
| 3 | R3 | `config/types/catalog_types/grocery_types.dart` | `dashboard/mini_market.json`, `dashboard/butcher.json`, `dashboard/produce.json` |
| 3 | R4 | `config/types/catalog_types/catalog_types.dart` | `dashboard/pharmacy.json`, `dashboard/electronics_store.json` (NEW) |
| 4 | R1 | `config/types/food_types.dart` | `dashboard/cafe.json`, `dashboard/bakery.json`, `dashboard/juice_bar.json`, `dashboard/restaurant.json` |
| 4 | R2 | `config/types/service_types.dart` | `dashboard/clinic.json`, `dashboard/gym.json` (NEW), `dashboard/car_wash.json`, `dashboard/laundry.json`, `dashboard/oil_change.json`, `dashboard/tailor.json`, `dashboard/shoe_repair.json`, `dashboard/mobile_repair.json`, `dashboard/watch_repair.json`, `dashboard/tire_shop.json`, `dashboard/salon.json` |
| 4 | R3 | `config/types/catalog_types/retail_types.dart` | `dashboard/clothes_store.json`, `dashboard/online_store.json` |

**No file appears in two sessions. No round within a session conflicts with another session's concurrent round.**

---

## Verify Prompt (use after every round)

```
Run `flutter analyze` and report any new issues. Then tell me:
1. Which demo account and business page to test
2. What to check on each screen (dashboard sections, stats, fixture data)
3. What the expected values should be
```

## Fix Prompt (use if verify reports issues)

```
Fix these issues from flutter analyze:
[paste the issues here]
```

---

## Session 1: S10 → Insights Batch

### Round 1 — S10 Request Detail Tabs
```
## Your Task: S10 — Request Detail Enhancement

Read the full sprint doc at `docs/sprints/S10_request_detail_tabs.md` — it has complete requirements, file paths, and acceptance criteria.

**Summary:** Add a 2-tab layout (Summary + Activity Log) to the business-side request detail page, plus status context banners for pending/accepted states.

**Files:**
- CREATE: `lib/features/business/order_management/presentation/widgets/request_activity_utils.dart`
- MODIFY: `lib/features/business/order_management/presentation/pages/detail_page.dart`

**Figma reference (read for PIXEL-PERFECT layout):**
- `../app-figma/src/app/components/orders/OrderDetailPage.tsx`
- `../app-figma/src/app/components/orders/OrderDetailParts.tsx`

**Follow these existing patterns:**
- Activity generation: `lib/features/business/dropoff/presentation/widgets/activity_log_utils.dart` → `generateTicketActivity()`
- Shared activity UI: `lib/shared/widgets/activity_log.dart` → reuse `ActivityLogEntry` model, `_TimelineEntry` pattern
- Tab pattern: `DefaultTabController(length: 2)` + `TabBar` + `TabBarView`

**DO NOT modify:** `request_detail_sections.dart`, `request_actions.dart`, `activity_log.dart`, any dropoff/queue files, any config files, any insight files.
```

### Round 2 — Insights Batch (ALL 25 generators)
```
## Next Task: Add custom insights generators for 25 business types

You now own TWO files only:
- `lib/features/business/insights/data/insights_mock_data.dart` — add generator functions + register in `_typeGenerators` map
- `lib/features/business/insights/domain/insight_chart_config.dart` — add chart labels in `_labelsMap`

**Currently registered (6):** water_delivery, restaurant, salon, plumber, villa_rental, government
**You need to add (25):** cafe, bakery, juice_bar, clinic, gym, car_wash, laundry, oil_change, tailor, shoe_repair, mobile_repair, watch_repair, tire_shop, gas_delivery, clothes_store, online_store, mini_market, butcher, produce, pharmacy, electronics_store, photographer, event_venue, bank, directory

**How to create each generator:**
1. Study existing generators in the file — especially `_restaurant` (menu_order), `_salon` (service_booking), `_waterDelivery` (catalog_order), `_villaRental` (reservation), `_government` (follow_only)
2. Each new generator follows the EXACT same pattern as its archetype lead
3. Customize: KPI labels, revenue scale, top items, distribution segments, tips — all type-specific
4. Use `_periodMultiplier(period)` to scale values
5. Register in `_typeGenerators` map
6. Add chart labels in `_labelsMap` with type-appropriate Arabic labels

**Generator grouping by archetype pattern:**

**menu_order (cafe, bakery, juice_bar):** Copy `_restaurant`. Customize: items (drinks for cafe, baked goods for bakery, juices for juice_bar), distribution (dine-in/takeaway/delivery), revenue scale.

**service_booking (clinic, gym, car_wash, laundry, oil_change, tailor, shoe_repair, mobile_repair, watch_repair, tire_shop):** Copy `_salon`. Customize: service names, KPI labels (patients for clinic, members for gym, vehicles for car_wash), revenue scale.

**catalog_order (gas_delivery, clothes_store, online_store, mini_market, butcher, produce, pharmacy, electronics_store):** Copy `_waterDelivery`. Customize: product names, distribution (by area for delivery, by category for retail), revenue scale.

**portfolio_inquiry (photographer):** Copy `_plumber` but adjust: inquiries instead of jobs, portfolio views, session prices.

**reservation (event_venue):** Copy `_villaRental`. Customize: event types instead of guest types, occupancy focus.

**follow_only (bank):** Copy `_government`. No revenue chart. Focus: page views, followers, post reach.

**directory:** Simple — stats only: tenant_count, page_views, follower_growth. showRevenueChart=false, showRankedList=false, showDistribution=false (see _visibilityMap).

**Tips:** Each type gets 2-3 Arabic tips relevant to that business. Make them actionable and specific.

**Work in batches:** Do 5-6 at a time, verify the file compiles between batches.

**DO NOT modify:** Any config files, any dashboard fixtures, any widget files, any other insight files besides the 2 listed above.
```

#### Round 2 Verify
```
Run `flutter analyze`. Confirm all 25 generators are registered. List the total `_typeGenerators` map (should have 31 entries: 6 existing + 25 new).
```

---

## Session 2: S11 → Reservation → Portfolio → Delivery

### Round 1 — S11 Reservation Lifecycle
```
## Your Task: S11 — Reservation Lifecycle Widgets

Read the full sprint doc at `docs/sprints/S11_reservation_lifecycle.md` — it has complete requirements for all 9 files.

**Summary:** Create reservation lifecycle for villa rentals and event venues: Guest Journey Card, Deposit Tracker, Property Condition Recorder, Order Snapshot Display, entities, and mock data. ALL NEW FILES — zero modifications to existing code.

**9 files to CREATE** — all under `lib/features/business/order_management/`:
- `domain/entities/reservation_lifecycle.dart`
- `domain/entities/deposit_ledger.dart`
- `domain/entities/property_inspection.dart`
- `presentation/widgets/guest_journey_card.dart`
- `presentation/widgets/deposit_tracker.dart`
- `presentation/widgets/property_condition_recorder.dart`
- `presentation/widgets/reservation_management_section.dart`
- `presentation/widgets/order_snapshot_display.dart`
- `data/reservation_mock_data.dart`

**Figma reference (PIXEL-PERFECT):**
- `../app-figma/src/app/components/orders/GuestJourneyCard.tsx`
- `../app-figma/src/app/components/business-mode/DepositTracker.tsx`
- `../app-figma/src/app/components/business-mode/PropertyConditionRecorder.tsx`
- `../app-figma/src/app/components/orders/ReservationManagementSection.tsx`

**Entities:** Plain Dart classes (no freezed — read-only view models for mock).

**DO NOT modify:** Any existing files. This is all new code. No config files, no insight files.
```

### Round 2 — Reservation Config (event_venue + villa_rental)
```
## Next Task: Align reservation business types with Figma

You just built reservation lifecycle widgets — now align the configs and fixtures for the same domain.

You own `lib/config/types/reservation_types.dart` and fixtures for event_venue + villa_rental.

- Figma: `../app-figma/src/app/config/types/event-venue.ts` + `../app-figma/src/app/config/types/villa-rental.ts`
- Figma defaults: `../app-figma/src/app/config/archetype-defaults.ts` → reservation
- Flutter config: `lib/config/types/reservation_types.dart`
- Flutter defaults: `lib/config/archetype_defaults/reservation_defaults.dart`

**event_venue:** Events: حفل زفاف 50000, مؤتمر 30000, حفل تخرج 20000, اجتماع 5000. Occupancy-focused dashboard: upcoming_reservations, occupancy rates.

**villa_rental:** Verify config matches Figma. Verify `assets/api/business/dashboard/villa_rental.json` has complete section data.

**For each:** Compare Figma config fields (dashboard.statsLabels, sections, quickActions, orderLabels, features) to Flutter. Update if different. Ensure dashboard fixture has data for all configured sections including `yesterday`, `orders_count`, `payment_breakdown`.

**DO NOT modify:** Any files outside reservation_types.dart and the 2 dashboard JSONs. No insight files, no widget files.
```

### Round 3 — Portfolio (photographer)
```
## Next Task: Align photographer business type with Figma

You own `lib/config/types/portfolio_types.dart` and `assets/api/business/dashboard/photographer.json`.

- Figma: `../app-figma/src/app/config/types/photographer.ts`
- Figma defaults: `../app-figma/src/app/config/archetype-defaults.ts` → portfolio_inquiry
- Flutter config: `lib/config/types/portfolio_types.dart`
- Flutter defaults: `lib/config/archetype_defaults/portfolio_inquiry_defaults.dart`

**photographer:** Portfolio archetype — no cart, customers send inquiries. Dashboard should have: stats (inquiries, portfolio_views, shares), pending_requests, active quotes.
- Services: تصوير أعراس 15000, تصوير مناسبات 8000, تصوير منتجات 5000, بورتريه 3000

Compare config, complete fixture with portfolio-specific sections. Same 2-step pattern as your previous round.

**DO NOT modify:** Any files outside portfolio_types.dart and photographer dashboard JSON. No insight files.
```

### Round 4 — Delivery (gas_delivery + water_delivery)
```
## Next Task: Align delivery business types with Figma

You own `lib/config/types/catalog_types/delivery_types.dart` and fixtures for gas_delivery + water_delivery.

- Figma: `../app-figma/src/app/config/types/gas-delivery.ts` + `../app-figma/src/app/config/types/water-delivery.ts`
- Figma defaults: `../app-figma/src/app/config/archetype-defaults.ts` → catalog_order
- Flutter config: `lib/config/types/catalog_types/delivery_types.dart`
- Flutter defaults: `lib/config/archetype_defaults/catalog_order_defaults.dart`

**gas_delivery:** Compare config, update if needed. Complete `assets/api/business/dashboard/gas_delivery.json`: delivery_route with Amman areas, low_stock (gas cylinders: أسطوانة 12 كغ, أسطوانة 25 كغ), recurring_tomorrow, customer_insights. Prices: 12kg cylinder ~700 piasters, 25kg ~1400.

**water_delivery:** Verify config matches Figma (likely already good). Verify `assets/api/business/dashboard/water_delivery.json` is complete.

Same 2-step pattern. **DO NOT modify:** Any files outside delivery_types.dart and the 2 dashboard JSONs. No insight files.
```

---

## Session 3: Villa → Misc → Grocery → Catalog

### Round 1 — Villa Manage Tab
```
## Your Task: Villa Manage Tab — Align with Figma

Read the plan at `~/.claude/plans/tender-weaving-quill.md` and execute it.

**Summary:** Move villa management from Settings sub-screen → Manage tab, matching Figma `VillaManage.tsx` pixel-perfectly. Create VillaManagePage, route it in business_home_page.dart, remove from settings.

**Files:**
- CREATE: `lib/features/business/catalog_management/presentation/pages/villa_manage_page.dart`
- MODIFY: `lib/features/business/dashboard/presentation/pages/business_home_page.dart` (route villa to VillaManagePage)
- MODIFY: `lib/features/business/page_settings/presentation/pages/settings_page.dart` (remove villa settings entry)
- MODIFY: `assets/api/pages/page_villa.json` (add active_price_change)

**Figma (PIXEL-PERFECT):** `../app-figma/src/app/components/business-mode/VillaManage.tsx`

**DO NOT modify:** Any config files, insight files, dashboard fixtures, or other type's settings.
```

### Round 2 — Misc (bank, directory, government)
```
## Next Task: Align misc business types with Figma

You own `lib/config/types/misc_types.dart` and fixtures for bank, directory, government.

- Figma: `../app-figma/src/app/config/types/misc-types.ts` (bank) + `../app-figma/src/app/config/types/directory.ts` + `../app-figma/src/app/config/types/government.ts`
- Figma defaults: `../app-figma/src/app/config/archetype-defaults.ts` → follow_only (bank, government), directory (directory)
- Flutter config: `lib/config/types/misc_types.dart`

**bank:** follow_only archetype. Dashboard fixture DOES NOT EXIST — CREATE `assets/api/business/dashboard/bank.json`. Minimal: stats (page_views, followers), no revenue. Posts/alerts focus.

**directory:** Verify config. Verify `assets/api/business/dashboard/directory.json` has data for all sections (recently_linked, tenant stats).

**government:** Verify config matches Figma. Verify fixture complete.

**For each:** Compare Figma config fields to Flutter. Update if different. Ensure dashboard fixtures have data for all configured sections. Add `yesterday`, `orders_count`, `payment_breakdown` where applicable.

**DO NOT modify:** Any files outside misc_types.dart and the 3 dashboard JSONs. No insight files, no widget files.
```

### Round 3 — Grocery (mini_market, butcher, produce)
```
## Next Task: Align grocery business types with Figma

Same pattern as your previous round — config compare + fixture complete.

You own `lib/config/types/catalog_types/grocery_types.dart` and fixtures for mini_market, butcher, produce.

- Figma: `../app-figma/src/app/config/types/catalog-types.ts` (find supermarket→mini_market, butcher, fruit_veg→produce)
- Figma defaults: `../app-figma/src/app/config/archetype-defaults.ts` → catalog_order
- Flutter config: `lib/config/types/catalog_types/grocery_types.dart`
- Flutter defaults: `lib/config/archetype_defaults/catalog_order_defaults.dart`

**mini_market:** Daily essentials (حليب, خبز, بيض, أرز). Prices 50-500 piasters. High volume, low ticket.
**butcher:** Meats (لحم عجل, دجاج, كفتة). Prices per kg: 800-1500 piasters.
**produce:** Fruits & vegetables (بندورة, خيار, تفاح, موز). Prices per kg: 50-300 piasters.

**DO NOT modify:** Any files outside grocery_types.dart and the 3 dashboard JSONs. No insight files.
```

### Round 4 — Catalog (pharmacy, electronics_store)
```
## Next Task: Align catalog business types with Figma

Same pattern — config compare + fixture complete.

You own `lib/config/types/catalog_types/catalog_types.dart` and fixtures for pharmacy + electronics_store.

- Figma: `../app-figma/src/app/config/types/catalog-types.ts` (find pharmacy, electronics_store)
- Flutter config: `lib/config/types/catalog_types/catalog_types.dart`
- Flutter defaults: `lib/config/archetype_defaults/catalog_order_defaults.dart`

**pharmacy:** Medical items (بانادول 150, فيتامينات 500, كريم واقي شمس 350). Focus on availability tracking.
**electronics_store:** Dashboard fixture DOES NOT EXIST — CREATE `assets/api/business/dashboard/electronics_store.json`. Products: سماعات 1000, شاحن 500, كفر جوال 300, سامسونج جالكسي 25000.

**DO NOT modify:** Any files outside catalog_types.dart and the 2 dashboard JSONs. No insight files.
```

---

## Session 4: Food → Service Group → Retail

### Round 1 — Food Group (cafe, bakery, juice_bar + verify restaurant)
```
## Your Task: Align food business types with Figma

You own `lib/config/types/food_types.dart` and dashboard fixtures for: cafe, bakery, juice_bar, restaurant.

**For each type, do these 2 steps:**

### Step A — Compare & align config
- Read Figma config: `../app-figma/src/app/config/types/food-types.ts` (cafe, bakery, juice_bar) and `../app-figma/src/app/config/types/restaurant.ts`
- Read Figma archetype defaults: `../app-figma/src/app/config/archetype-defaults.ts` → menu_order
- Read Flutter config: `lib/config/types/food_types.dart`
- Read Flutter defaults: `lib/config/archetype_defaults/menu_order_defaults.dart`
- Compare: dashboard.statsLabels, sections, quickActions, orderLabels, features, itemManagement
- Update Flutter config if different. Use `createType()` — only override what differs from defaults.
- **restaurant** likely already matches — just verify, don't change unless Figma differs.

### Step B — Complete dashboard fixtures
For each of: `assets/api/business/dashboard/cafe.json`, `bakery.json`, `juice_bar.json`, `restaurant.json`:
- Ensure data exists for EVERY section in the type's dashboard config
- `today_revenue` must have: `total`, `yesterday`, `orders_count`, `payment_breakdown` (cash/cliq/bank)
- Use realistic Arabic food/drink items and Amman JOD prices in piasters:
  - Cafe: قهوة عربية 150, لاتيه 250, كابتشينو 250, كيك 300, كرواسون 200
  - Bakery: مناقيش زعتر 50, خبز عربي 15, فطيرة لحمة 75, كعك 100
  - Juice bar: عصير برتقال 150, سموذي 250, كوكتيل فواكه 300
  - Restaurant: (verify existing data is complete)

**DO NOT modify:** Any files outside `config/types/food_types.dart` and `assets/api/business/dashboard/{cafe,bakery,juice_bar,restaurant}.json`. No insight files, no shared widgets.
```

### Round 2 — Service Group (11 types)
```
## Next Task: Align service_booking business types with Figma

Same pattern as your food round — config compare + fixture complete. But bigger: 11 types.

You own `lib/config/types/service_types.dart` and dashboard fixtures for 11 types. Work through them in 3 batches.

**Read first:**
- Figma configs: `../app-figma/src/app/config/types/service-types.ts` (bulk) + `../app-figma/src/app/config/types/salon.ts` + `../app-figma/src/app/config/types/clinic.ts`
- Figma defaults: `../app-figma/src/app/config/archetype-defaults.ts` → service_booking
- Flutter config: `lib/config/types/service_types.dart`
- Flutter defaults: `lib/config/archetype_defaults/service_booking_defaults.dart`

**Batch 1 — clinic, gym, car_wash:**
- clinic: May need medical-specific stats (patients_today, consultations). Figma has dedicated config.
- gym: Dashboard fixture DOES NOT EXIST — CREATE `assets/api/business/dashboard/gym.json` with membership/class data. Realistic gym prices: monthly 3000-6000 piasters, day pass 500-1000, PT session 1500-2500.
- car_wash: Queue-based. Fixture should have active_queue, today_schedule data.

**Batch 2 — laundry, oil_change, tailor:**
- laundry: Dropoff-based. Fixture should have dropoff tracking data.
- oil_change: Queue-based. Services: تغيير زيت, فلتر, فحص سوائل.
- tailor: Service-based. Services: تعديل بنطلون, تفصيل ثوب, تضييق.

**Batch 3 — shoe_repair, mobile_repair, watch_repair, tire_shop + verify salon:**
- All repair types: quote/service mix. Realistic repair prices.
- salon: Already complete — just verify config matches Figma, fixture has all section data.

**For EACH type:**
1. Compare Figma config to Flutter config. Update if different.
2. Read dashboard fixture. Ensure data for all configured sections. Add `yesterday`, `orders_count`, `payment_breakdown` if missing.
3. Use realistic Arabic names, Amman neighborhoods, JOD piaster prices.

**DO NOT modify:** Any files outside `config/types/service_types.dart` and `assets/api/business/dashboard/{type}.json` for the 11 types listed. No insight files.
```

### Round 3 — Retail (clothes_store, online_store)
```
## Next Task: Align retail business types with Figma

Same pattern — config compare + fixture complete. 2 types.

You own `lib/config/types/catalog_types/retail_types.dart` and fixtures for clothes_store + online_store.

- Figma: `../app-figma/src/app/config/types/clothes-store.ts` + `../app-figma/src/app/config/types/online-store.ts`
- Figma defaults: `../app-figma/src/app/config/archetype-defaults.ts` → catalog_order
- Flutter config: `lib/config/types/catalog_types/retail_types.dart`
- Flutter defaults: `lib/config/archetype_defaults/catalog_order_defaults.dart`

**clothes_store:** Fashion items (فستان 2500-6000, بلوزة 1000-2000, بنطلون 1500-3500). Best sellers, low stock, today_revenue.

**online_store:** Mixed catalog (electronics accessories, fashion, home items). Shipping-focused dashboard sections.

**For each:** Compare config, update fixture with complete data for all sections including payment_breakdown.

**DO NOT modify:** Any files outside retail_types.dart and the 2 dashboard JSONs. No insight files.
```

---

## Quick Reference: What to Paste When

### Starting each session (Round 1 only)
```
[Preamble from SESSION_PREAMBLE.md] + [Round 1 prompt from above]
```

### After each round completes
```
Run `flutter analyze` and report any new issues. Then tell me:
1. Which demo account and business page to test
2. What to check on each screen
3. What the expected values should be
```

### Moving to next round (after verify passes)
```
[Round N prompt from above — no preamble needed, session has context]
```

### If verify reports issues
```
Fix these issues from flutter analyze:
[paste the issues]
```

---

## Summary

| Session | Rounds | Total types | Creates new files? |
|---------|--------|------------|-------------------|
| **1** | 2 | 25 insights | R1: 1 new file, R2: edits 2 existing |
| **2** | 4 | 9 new widgets + 5 types | R1: 9 new files, R2-R4: config+fixture |
| **3** | 4 | villa + 8 types | R1: 1 new file, R2: bank.json, R4: electronics_store.json |
| **4** | 3 | 17 types | R2: gym.json |

**4 sessions, 13 rounds total, 0 file conflicts.**
