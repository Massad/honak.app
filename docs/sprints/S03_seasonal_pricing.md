# S03 — Villa Seasonal Pricing (Customer Display + Business Editor)

> **Size:** Large (8-12 files, ~6-8 hours)
> **Priority:** P1
> **Figma reference:** `app-figma/SESSION_CHANGES.md` §1-3, `SeasonalPricing.tsx`, `VillaSection.tsx`, `price/seasonal-types.ts`, `price/seasonal-helpers.ts`

---

## What This Is

Two connected features for villa/farm-stay pages:

1. **Business editor** — configure seasonal pricing rules, holiday surcharges, early-bird discounts, and last-minute deals
2. **Customer display** — see current season pricing, last-minute deal banners, season timeline, and dynamic booking CTA

## Why It Matters

Villa and farm-stay rentals in Jordan have dramatically different pricing by season (summer peak in Dead Sea/Aqaba, winter peak in Amman highlands). Without seasonal pricing, owners can't accurately represent their rates, and customers see misleading flat prices.

## Current State in Flutter (VERIFIED)

### What Already Exists

**Villa Detail Card** (`lib/features/pages/presentation/widgets/sections/villa_detail_card.dart`):
- Shows weekday vs weekend pricing cards ("أيام الأسبوع" / "نهاية الأسبوع") with "من {price}/ليلة"
- Gallery strip (200px, horizontal scroll)
- Info chips: bedrooms, bathrooms, max guests, check-in/check-out times
- Amenities section with 12 icons (pool, wifi, parking, ac, garden, bbq, tv, kitchen, washer, gym, playground, fireplace)
- House rules with amber warning styling
- Book CTA: "طلب حجز — من {price}/ليلة"

**Villa Settings** (`lib/features/business/page_settings/presentation/widgets/villa_settings.dart`):
- Edit weekday/weekend prices in JOD
- Property specs (guests, bedrooms, bathrooms)
- Amenities management (12 predefined)
- House rules (add/remove/edit)
- Check-in/check-out times
- Gallery (placeholder — "قريباً")
- Availability calendar link

**Villa Pricing Entity** (`lib/features/pages/domain/entities/page_sub_entities.dart` lines 170-181):
```
VillaPricing: weekdayCents (int), weekendCents (int), currency (String, default 'JOD')
```

**PriceChange Entity** (same file, lines 119-133):
- Defined but UNUSED anywhere: direction, method, value, scope, reason (includes 'seasonal'), status
- This could potentially be repurposed or serve as inspiration

**Feature Flag**: `per_night_pricing` exists in `lib/config/types/reservation_types.dart` but is NOT used in any UI conditional rendering.

**Villa Fixture** (`assets/api/pages/page_villa.json`):
- Only basic pricing: `{ "weekday_cents": 15000, "weekend_cents": 20000 }`
- NO seasonal_pricing object

### What's Missing (THE ACTUAL GAP)

- No `SeasonRule`, `HolidaySurcharge`, `EarlyBirdDiscount`, `LastMinuteDeal` entities
- No seasonal date ranges anywhere
- No price calculation logic (per-night with modifiers)
- No seasonal pricing editor in villa settings
- No season card / last-minute banner / timeline on customer page
- No `seasonal_pricing` data in villa fixture
- `per_night_pricing` feature flag not used for any UI gating

## Requirements

### Part A: Domain Layer

#### 1. Seasonal Pricing Entities (freezed)

Add to `page_sub_entities.dart` or create new file:

- **SeasonRule** — id, name, icon (sun/snowflake/tree/waves/star/calendar), startMonth, startDay, endMonth, endDay, weekdayCents (int piasters), weekendCents (int piasters), currency, active, color (hex)
- **HolidaySurcharge** — id, name, startDate (MM-DD string), endDate (MM-DD string), surchargePercent (int), active
- **EarlyBirdDiscount** — daysAhead (int), discountPercent (int), active
- **LastMinuteDeal** — hoursBeforeCheckin (int), daysAhead (int), discountPercent (int), active, label (String)
- **SeasonalPricing** — seasons (list), holidays (list), earlyBird, lastMinute — wraps all the above

#### 2. Pricing Calculation Utility

Create `lib/features/pages/domain/seasonal_pricing_utils.dart` (pure Dart, no Flutter):

- `isDateInSeason(month, day, season)` — handles year-wrap (e.g., Nov–Feb)
- `getSeasonForDate(date, seasons)` — find which season a date falls into
- `getCurrentSeason(seasons)` — convenience for today
- `getHolidayForDate(date, holidays)` — check if date is in a holiday period
- `isJordanWeekend(date)` — Friday (day 5) + Saturday (day 6)
- `calculateNightPrice(date, seasons, holidays, earlyBird?, lastMinute?, bookingDate?, basePricing?)` — returns price + breakdown with all modifiers applied
- `calculateStayTotal(checkIn, checkOut, ...)` — multi-night total with per-night breakdown and savings

**Pricing priority chain:**
1. Base = season weekday/weekend price (fallback to VillaPricing if no season)
2. \+ Holiday surcharge (percentage on base)
3. \- Last-minute deal (if booking within X hours of check-in) — **mutually exclusive with early bird**
4. \- Early bird discount (if booking X+ days before) — only if last-minute NOT applied

#### 3. Default Constants

Provide in the utility file:
- 4 default seasons: summer peak (Jun 1–Sep 15), winter (Dec 1–Feb 28), spring (Mar 1–May 31), autumn (Sep 16–Nov 30, inactive)
- 4 default holidays: Eid Fitr, Eid Adha, New Year, Independence Day
- Default early bird: 14 days, 10%, inactive
- Default last-minute: 48 hours (2 days), 20%, inactive

### Part B: Business Editor (Settings)

#### 4. Seasonal Pricing Editor

Add a new section to `villa_settings.dart` (or create a sub-widget):

- **Seasons section** — list of rules, each with name, date range, weekday/weekend prices, active toggle, color picker
- **Holidays section** — list of surcharges with name, date range, percentage, active toggle
- **Early bird section** — collapsible toggle with days-ahead picker + discount percent picker
- **Last-minute deals section** — collapsible toggle with days picker (1/2/3/4) + discount percent (5/10/15/20)
- Save persists to page settings

Only show this editor for pages with `per_night_pricing` feature flag — use `BusinessTypeRegistry` to check.

### Part C: Customer Display

#### 5. Current Season Card

On `villa_detail_card.dart`, between pricing cards and amenities:
- Current season name + icon + date range
- Season-specific weekday/weekend prices
- Gradient background using season's color
- Holiday notice if today is in a holiday period (orange, surcharge %)
- Early bird notice if active (purple, days + discount %)

#### 6. Last-Minute Deal Banner

Prominent full-width banner when last-minute is active AND tomorrow qualifies:
- Deal label, discount %, original price strikethrough, discounted price, date/day name
- Red gradient styling

#### 7. Mini Season Timeline

12-column bar (months), colored by season, current month highlighted. Legend below with price ranges.

#### 8. Modified Booking CTA

Two variants:
- Last-minute active: urgent styling, "احجز الآن — X د.أ/ليلة" with discount badge
- Normal: standard, "طلب حجز — من X د.أ/ليلة"

### Part D: Mock Data

#### 9. Fixture Updates

Add `seasonal_pricing` object to `page_villa.json` (and any farm-stay fixtures):
- 2-3 active seasons with realistic Jordan pricing
- 1-2 active holidays
- Early bird and last-minute inactive by default

Run `dart run tool/generate_fixtures.dart` after fixture changes.

## Files to Create

1. Seasonal pricing entities (freezed) — either extend `page_sub_entities.dart` or new file
2. `lib/features/pages/domain/seasonal_pricing_utils.dart` — pure calculation logic
3. Seasonal pricing editor widget(s) in `lib/features/business/page_settings/presentation/widgets/`

## Files to Modify

1. `lib/features/pages/presentation/widgets/sections/villa_detail_card.dart` — add season card, banner, timeline, modified CTA
2. `lib/features/business/page_settings/presentation/widgets/villa_settings.dart` — add seasonal pricing section
3. `assets/api/pages/page_villa.json` — add seasonal_pricing data
4. Possibly `page_sub_entities.dart` — add entities (if not in a new file)

## Acceptance Criteria

- [ ] SeasonRule, HolidaySurcharge, EarlyBirdDiscount, LastMinuteDeal entities created with freezed
- [ ] Price calculation utility works correctly (unit-testable pure functions)
- [ ] Business can view and edit seasonal pricing in villa settings
- [ ] Customer sees current season card on villa detail page
- [ ] Last-minute banner shows when applicable
- [ ] Season timeline renders with month colors
- [ ] Booking CTA reflects current pricing state
- [ ] `per_night_pricing` feature flag gates visibility of seasonal editor
- [ ] Mock fixture includes seasonal pricing data
- [ ] `dart run build_runner build --delete-conflicting-outputs` runs clean after entity changes
- [ ] `dart run tool/generate_fixtures.dart` runs clean after fixture changes

## Patterns to Follow

- Entities: `@freezed` with `part 'X.freezed.dart'` and `part 'X.g.dart'`
- Prices always in piasters (int) using `Money` class — never doubles
- Weekend = Friday + Saturday (Jordan-specific)
- Use `per_night_pricing` feature flag (from `BusinessTypeConfig.features`) to gate UI, NOT archetype name
- Settings section follows existing pattern in `villa_settings.dart` (collapsible sections with save)
- Customer display follows existing `villa_detail_card.dart` patterns (spacing, typography, card styling)
- Arabic labels from `app_ar.arb`
- RTL: `EdgeInsetsDirectional`
