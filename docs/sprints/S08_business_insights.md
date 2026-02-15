# S08 — Business Insights Screen (Full Implementation)

> **Size:** Large-XL (~15-18 files, ~8-10 hours)
> **Priority:** P1
> **Figma reference:** `app-figma/INSIGHTS_SCREEN_SPEC.md` (1054 lines — the complete implementation spec)

---

## What This Is

A full config-driven analytics screen for business mode (Tab 2, replacing the current placeholder). Shows KPI cards, revenue charts, ranked lists, distribution donuts, smart tips, and archetype-specific components — all driven by `BusinessTypeConfig`.

## Why It Matters

Business owners need to understand their performance at a glance. The Insights tab is the **second tab** in business mode — high visibility. Currently shows a "coming soon" placeholder for all types except directory (which has real insights). This replaces the placeholder with a production-grade analytics screen.

## Current State in Flutter (VERIFIED)

### What Already Exists

**Insights Page** (`lib/features/business/insights/presentation/pages/insights_page.dart` — 206 lines):
- `BusinessInsightsPage` — ConsumerWidget that switches on archetype
- **Directory archetype**: routes to `_DirectoryInsightsContent` which uses `dashboardStatsProvider` and renders `DirectoryDashboardSection` + `DirectoryInsightsCards` (7 card types, fully working — 437 lines)
- **All other archetypes**: routes to `_DefaultInsightsContent` — placeholder with "coming soon" message + 4 preview cards (views, customers, orders, trust metrics)
- The directory insights implementation is mature and should be **preserved** (not replaced)

**Business Context** (already works):
- `businessContextProvider` gives access to `page`, `config`, `archetype`
- `BusinessTypeConfig` has `archetype`, `id`, `name_ar`, `features` list
- `BusinessTypeRegistry` has 42 types configured

**Theme System** (already aligned):
- `AppColors.primary` = #1A73E8
- `AppColors.success` = #43A047
- `AppColors.error` = #E53935
- Gray scale matches Tailwind gray family
- `AppSpacing`, `AppRadius` constants available

**No fl_chart dependency** — needs to be added to `pubspec.yaml`

### What's Missing (THE ACTUAL GAP)

- No `InsightCard`, `InsightSection`, `TrendDirection`, `ChartLabels` entities
- No `RevenueDataPoint`, `TopItemDataPoint`, `DistributionDataPoint` data models
- No insights provider with period switching
- No mock insight fixture data per business type
- No KPI card grid widget (2x2 with trend badges)
- No revenue area chart (needs fl_chart)
- No ranked list widget (pure Flutter, medals, progress bars)
- No distribution donut chart (needs fl_chart)
- No smart tips section
- No edge case handling (empty state, visibility-only, unclaimed)
- No modifier analytics (menu_order conditional)
- No booking calendar (service_booking/reservation conditional)
- No icon map resolver (string → IconData)
- No archetype chart visibility config
- No period switching (week/month/year tabs)
- No skeleton/shimmer loading states

## Requirements

### Part A: Domain Layer

#### 1. Insight Entities

Create `lib/features/business/insights/domain/entities/insight_entities.dart`:

**InsightCard** — id, label, value, change (nullable), trend (TrendDirection enum: up/down/neutral), icon (string ID)

**InsightSection** — title, cards (List of InsightCard)

**TrendDirection** — enum: up, down, neutral

**ChartLabels** — revenueLabel, topItemsLabel, distributionLabel, revenueTooltip, summaryLabel, ordersTooltip

**RevenueDataPoint** — label (day name), revenue (double JOD), subscriptionRevenue (nullable double), orders (int)

**TopItemDataPoint** — name, count (int), unit (Arabic string like "طلب" or "حجز")

**DistributionDataPoint** — name, value (int percentage 0-100), color (Color)

**InsightsData** — wrapper: pageId, businessType, archetype, period, periodLabel, kpiSections (List InsightSection), revenueChart (nullable), topItems (nullable), distribution (nullable), tips (List String)

These should be plain Dart classes (NOT freezed) since they are read-only view models from API. Spec §3 has the full definitions.

#### 2. Icon Map Resolver

Create `lib/features/business/insights/domain/insight_icon_map.dart`:

Map of 28 string IDs to IconData. Full list in spec §5.2 — banknote, package, utensils, trending-up, users, repeat, etc. Use Material Icons equivalents.

#### 3. Archetype Chart Visibility Config

Create `lib/features/business/insights/domain/insight_chart_config.dart`:

**Chart visibility matrix** (from spec §6.0):
- `catalog_order`: Revenue + RankedList + Distribution
- `menu_order`: Revenue + RankedList + Distribution
- `service_booking`: Revenue + RankedList (NO Distribution)
- `quote_request`: Revenue + Distribution (NO RankedList)
- `portfolio_inquiry`: Revenue only
- `reservation`: Revenue + Distribution (NO RankedList)
- `follow_only`: RankedList + Distribution (NO Revenue)
- `directory`: None (uses existing directory insights)

**Chart labels resolver** — `getChartLabels(typeId)` returns type-specific Arabic labels for revenue chart title, top items title, distribution title, tooltips. 6 type configs + fallback to water_delivery. Full data in spec §9.2.

### Part B: Data Layer

#### 4. Mock Insights Data

Create `lib/features/business/insights/data/insights_mock_data.dart`:

Generate mock `InsightsData` per business type based on the comprehensive data tables in spec §8 (KPI cards per type) and §9 (chart data per type). Must support 3 periods (week/month/year) with different values.

Cover 6 explicit types: water_delivery, restaurant, salon, plumber, villa_rental, government. Plus a fallback for any other type (basic page views + followers).

**Revenue data** — 7-day arrays with Arabic day names for week, 4 week labels for month, 12 month labels for year. Per spec §9.1.

**Top items** — ranked items per type. Colors assigned by rank position: #1A73E8, #4DA3FF, #93C5FD, #BFDBFE, #DBEAFE. Per spec §9.3.

**Distribution data** — percentage segments per type with colors. Per spec §9.4.

**Smart tips** — 2-3 Arabic strings per type. Full text in spec §10.2.

#### 5. Insights Provider

Create `lib/features/business/insights/presentation/providers/insights_provider.dart`:

- `insightsPeriodProvider` — StateProvider for current period (week/month/year), defaults to week
- `insightsDataProvider` — FutureProvider.family that takes pageId, reads businessContext for type/archetype, reads period, returns InsightsData from mock data
- Simulates API delay (300ms) for loading states

### Part C: Screen & KPI Widgets

#### 6. Rewrite BusinessInsightsPage

Rewrite `insights_page.dart` completely:

**Keep** the directory archetype routing — when `archetype == directory`, show existing `_DirectoryInsightsContent` (don't break what works)

**For all other archetypes**, build the full insights screen per spec §2:

```
BusinessInsightsScreen
├── StickyHeader (title + business type badge + PeriodTabs)
├── ScrollableContent
│   ├── InsightSectionBlock[0] (overview KPIs — always first)
│   ├── RevenueChart (conditional per archetype)
│   ├── RankedList (conditional per archetype)
│   ├── InsightSectionBlock[1..N] (remaining sections)
│   ├── DistributionChart (conditional per archetype)
│   ├── SmartTips
│   ├── ModifierAnalytics (menu_order only)
│   └── BookingCalendar (service_booking + reservation only)
```

**Sticky header**: Title "الإحصائيات" + business type badge (icon + name_ar) + period tabs (أسبوعي/شهري/سنوي as pills). White bg, border-bottom gray-100. Spec §4.2.

**Period tabs**: Row of 3 chips. Selected: bg=#1A73E8, text=white. Unselected: bg=#F3F4F6, text=#6B7280. Border-radius full (999). Spec §4.2.

**Content area**: paddingH 16, paddingTop 16, section gap 20, paddingBottom 100 for nav clearance. Background #F5F5F5. Spec §4.3.

**Use archetype chart visibility config** to conditionally show/hide RevenueChart, RankedList, DistributionChart.

#### 7. KPI Card Widgets

Create `lib/features/business/insights/presentation/widgets/insight_section_block.dart`:
- 2-column grid (gap 8) of InsightCardView widgets
- Section title (text-sm, gray-900) above grid

Create `lib/features/business/insights/presentation/widgets/insight_card_view.dart`:
- White card, rounded-12, border gray-100, padding 12, shadow-sm
- Top row: icon container (32x32, blue-50 bg, 8 radius) + change badge
- Change badge: pill with trend icon + text. Colors: up=#F0FDF4/#43A047, down=#FEF2F2/#E53935, neutral=#F9FAFB/#9CA3AF
- Value: text-lg, gray-900
- Label: 10px, gray-500
- Full spec §5.1

### Part D: Chart Widgets

#### 8. Revenue Area Chart

Create `lib/features/business/insights/presentation/widgets/revenue_chart.dart`:

Uses **fl_chart** (add `fl_chart: ^0.69.2` to pubspec.yaml).

- Area chart with gradient fill (primary blue → transparent)
- X-axis: Arabic labels (day/week/month names), 10px gray-400
- Y-axis: numbers, 10px gray-400
- Horizontal dashed grid lines (#F3F4F6)
- Dots on data points (radius 3, active radius 5)
- Custom tooltip (white bg, border, rounded-12, RTL, 11px)
- Legend bar below: revenue dot + label, optional subscription dot, comparison text with trend arrow
- Dual line variant: green subscription line (#43A047) when `subscriptionRevenue` data exists (catalog_order with subscriptions)
- Wrapped in card container (white, rounded-xl, border, padding 16, shadow-sm)
- Full spec §6.1

#### 9. Ranked List

Create `lib/features/business/insights/presentation/widgets/ranked_list.dart`:

**Pure Flutter — NO charting library.** Per spec §6.2.

- Card container (white, rounded-xl, border, padding 16)
- Title + list of max 5 items sorted by count
- Each row: rank indicator (🥇🥈🥉 for top 3, number for 4+) + name + count with unit + progress bar
- Progress bar: height 6, gray-100 bg, colored fill proportional to max
- Colors by rank: #1A73E8, #4DA3FF, #93C5FD
- 500ms width transition animation

#### 10. Distribution Donut Chart

Create `lib/features/business/insights/presentation/widgets/distribution_chart.dart`:

Uses **fl_chart** PieChart.

- Donut shape: inner radius 30, outer radius 55
- Padding angle 3 between segments
- Side legend: color dot + name + percentage
- Wrapped in card with row layout (donut 120x120 left, legend flex-1 right)
- Full spec §6.3

### Part E: Smart Tips + Conditional Components

#### 11. Smart Tips Section

Create `lib/features/business/insights/presentation/widgets/smart_tips_section.dart`:

- Gradient card: linear-gradient(to-left, #EFF6FF → white), border #DBEAFE, rounded-12, padding 16
- Title row: star icon (14px, #FF9800) + "نصائح ذكية" (text-sm, gray-900)
- List of tip cards: white 60% opacity bg, rounded-8, paddingH 12 paddingV 8
- Full spec §10.1

#### 12. Modifier Analytics

Create `lib/features/business/insights/presentation/widgets/modifier_analytics.dart`:

Only shown for `menu_order` archetype. Shows popular menu modifiers ("بدون بصل", "ثومية زيادة").

- Card with title "تحليل التعديلات" + subtitle
- List of modifier items with name, count, progress bar
- Same progress bar style as ranked list
- Spec Appendix C

#### 13. Booking Calendar

Create `lib/features/business/insights/presentation/widgets/booking_calendar.dart`:

Only shown for `service_booking` and `reservation` archetypes.

- Card with title "جدول الحجوزات"
- Week navigator (< الأسبوع الحالي >)
- 7-column grid (سبت through جمعة)
- Cells show booking count with color intensity by density
- Spec Appendix D

### Part F: Edge Cases + Polish

#### 14. Edge Case Widgets

Create `lib/features/business/insights/presentation/widgets/insights_empty_states.dart`:

- **New page** (no data): KPI values show "—", charts show empty states with icon + "لا توجد بيانات كافية". Tips still show.
- **Visibility-only** pages: Only page views + followers. Blue-50 CTA card: "فعّل الطلبات لعرض إحصائيات متقدمة"
- **Unclaimed** pages: Lock icon + "الإحصائيات غير متاحة"
- **follow_only** archetype: No revenue, charts use "المشاهدات" not "الإيرادات"
- Full spec §13

#### 15. Skeleton Loading

- Shimmer 2x2 grid for KPI cards while loading
- Shimmer chart cards while loading
- Show skeleton on initial load and period switch

## Files to Create

1. `lib/features/business/insights/domain/entities/insight_entities.dart`
2. `lib/features/business/insights/domain/insight_icon_map.dart`
3. `lib/features/business/insights/domain/insight_chart_config.dart`
4. `lib/features/business/insights/data/insights_mock_data.dart`
5. `lib/features/business/insights/presentation/providers/insights_provider.dart`
6. `lib/features/business/insights/presentation/widgets/insight_card_view.dart`
7. `lib/features/business/insights/presentation/widgets/insight_section_block.dart`
8. `lib/features/business/insights/presentation/widgets/revenue_chart.dart`
9. `lib/features/business/insights/presentation/widgets/ranked_list.dart`
10. `lib/features/business/insights/presentation/widgets/distribution_chart.dart`
11. `lib/features/business/insights/presentation/widgets/smart_tips_section.dart`
12. `lib/features/business/insights/presentation/widgets/modifier_analytics.dart`
13. `lib/features/business/insights/presentation/widgets/booking_calendar.dart`
14. `lib/features/business/insights/presentation/widgets/insights_empty_states.dart`

## Files to Modify

1. `lib/features/business/insights/presentation/pages/insights_page.dart` — full rewrite (preserve directory routing)
2. `pubspec.yaml` — add `fl_chart: ^0.69.2`

## DO NOT Modify

- `directory_insights_cards.dart` — already working, keep as-is
- `directory_dashboard_section.dart` — already working, keep as-is

## Testing

**Demo accounts to verify:**
- **Ahmad** (0790000002/222222) → switch to business → select "water_delivery" page → Insights tab (catalog_order: Revenue + Ranked + Distribution)
- **Ahmad** → select "restaurant" page (menu_order: Revenue + Ranked + Distribution + ModifierAnalytics)
- **Sara** (0790000001/111111) → select "salon" page (service_booking: Revenue + Ranked + BookingCalendar)
- **Ahmad** → select "plumber" page (quote_request: Revenue + Distribution)
- **Khaled** (0790000030/111111) → select "villa_rental" page (reservation: Revenue + Distribution + BookingCalendar)
- **Khaled** → select "directory" page → should still show existing directory insights (NOT the new screen)
- **Yousef** (0790000040/111111) → select "government" page (follow_only: Ranked + Distribution, NO Revenue)
- Test period switching (week/month/year tabs) on any type

## Acceptance Criteria

- [ ] fl_chart added to pubspec.yaml, `flutter pub get` clean
- [ ] Insight entities created (plain Dart classes, NOT freezed)
- [ ] Icon map resolves all 28 icon IDs to IconData
- [ ] Archetype chart visibility matrix implemented
- [ ] Mock data covers 6 types + fallback, 3 periods each
- [ ] Insights provider with period switching works
- [ ] Sticky header with title + type badge + period tabs renders
- [ ] KPI card grid renders with trend badges and icons
- [ ] Revenue area chart renders with gradient fill and tooltip
- [ ] Ranked list renders with medals, progress bars, count+unit
- [ ] Distribution donut renders with side legend
- [ ] Smart tips section renders per type
- [ ] ModifierAnalytics shows only for menu_order
- [ ] BookingCalendar shows only for service_booking + reservation
- [ ] Edge cases handled (new page, visibility-only, unclaimed)
- [ ] Directory archetype still uses existing insights (not broken)
- [ ] Period switching updates all sections
- [ ] Skeleton/shimmer loading on initial load and period switch
- [ ] `flutter analyze` passes
- [ ] App runs without errors

## Patterns to Follow

- Entities: plain Dart classes (read-only view models, no serialization needed for mock)
- Use `AppColors`, `AppSpacing`, `AppRadius` from theme system
- RTL: `EdgeInsetsDirectional`, `TextDirection.rtl` for charts
- Colors: use exact hex values from spec §14.1 where they differ from theme
- Reference the spec's §14 Design Tokens for all spacing/typography/radius
- Use `businessContextProvider` for archetype + type + config access
- Provider follows existing pattern (FutureProvider.family)
- Preserve existing directory insights routing in insights_page.dart
