# Round 2 Prompts — Copy & Paste

Paste the appropriate prompt into the session that just finished Round 1.
No preamble needed — session already has full context.

---

## Session 1 → Insights Batch

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

### Session 1 → Verify (after R2 completes)
```
Run `flutter analyze`. Confirm all 25 generators are registered. List the total `_typeGenerators` map (should have 31 entries: 6 existing + 25 new).
```

---

## Session 2 → Reservation Config

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

### Session 2 → Verify
```
Run `flutter analyze`. Tell me which demo accounts have these businesses and what dashboard sections each should show.
```

---

## Session 3 → Misc Types

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

### Session 3 → Verify
```
Run `flutter analyze`. Tell me which demo accounts have these businesses and what dashboard sections each should show.
```

---

## Session 4 → Service Group (11 types)

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

### Session 4 → Verify
```
Run `flutter analyze`. List all 11 types and their status (config aligned? fixture complete?). Tell me which demo accounts to test each with.
```

---

# Round 3 Prompts

## Session 2 → Portfolio (photographer)

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

---

## Session 3 → Grocery (mini_market, butcher, produce)

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

---

## Session 4 → Retail (clothes_store, online_store)

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

# Round 4 Prompts

## Session 2 → Delivery (gas_delivery + water_delivery)

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

## Session 3 → Catalog (pharmacy, electronics_store)

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
