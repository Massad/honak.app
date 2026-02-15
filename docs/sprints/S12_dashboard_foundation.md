# S12 — Business Dashboard Foundation: Setup Checklist + Revenue Overview

> **Size:** Medium-Large (~8-10 files, ~6-8 hours)
> **Priority:** P0 (first thing business owners see)
> **Figma reference:** `SetupProgress.tsx` (212 lines), `RevenueOverview.tsx` (165 lines), `BizDashboard.tsx` (415 lines)

---

## What This Is

Enhance the business dashboard to match the Figma prototype: add a setup checklist card at the top for new/incomplete pages, and replace the basic revenue section with a prominent blue gradient revenue overview with period switching and payment breakdown.

## Why It Matters

The dashboard is the **first screen** every business owner sees. Currently it jumps straight to stats + sections. The Figma prototype has a clear onboarding path (setup checklist) and a prominent revenue card — both critical for retention and usability.

## Current State in Flutter (VERIFIED)

### What Already Exists

**Dashboard Page** (`business_dashboard_page.dart` — 443 lines):
- `BusinessDashboardPage` — ConsumerWidget with stats row, quick actions, sections, recurring
- Config-driven via `businessContextProvider` → `config.dashboard`
- Stats row with 4 colored cards (amber, blue, green, purple)
- Quick actions grid (4 columns, placeholder onTap showing snackbar)
- Section cards rendered from `dashboard.sections` config
- Recurring customers section (hardcoded mock data)

**Revenue Section** (`core_sections.dart`):
- `TodayRevenueSection` — flat list showing total + item breakdown
- `TodaySummarySection` — completed/upcoming/cancelled chips + revenue
- Basic formatting, no period switching, no gradient card

**Dashboard Fixtures** (`assets/api/business/dashboard/{type}.json`):
- Each has `stats` object + section-specific data
- Revenue data: `today_revenue` with `amount`, `yesterday`, `orders_count`, `items` array
- NO week/month data, NO payment breakdown

**Business Type Config** (`business_type_config.dart` — 716 lines):
- Full config system with `DashboardConfig`, `DashboardSection`, `DashboardStatLabel`
- 19 section types in `DashboardSectionType` enum
- NO setup checklist configuration

### What's Missing

1. No `SetupProgressCard` widget — no onboarding checklist on dashboard
2. No `RevenueOverviewCard` — no blue gradient revenue widget with period tabs
3. Revenue fixtures don't have week/month/payment breakdown data
4. No setup step configuration per archetype
5. Dashboard page renders sections flat — no setup card at top, no revenue overview card

## Requirements

### Part A: Setup Checklist Widget

#### 1. Setup Progress Card

Create `lib/features/business/dashboard/presentation/widgets/setup_progress_card.dart`:

**SetupProgressCard** — expandable card showing page setup completion status.

**Structure:**
```
White card, rounded-xl, border gray-100, shadow-sm
├── Header (tap to expand/collapse)
│   ├── Gradient blue circle (32x32) with rocket icon
│   ├── Title: "أكمل إعداد صفحتك" (xs, gray-900)
│   ├── Subtitle: "X من Y خطوات مكتملة" (10px, gray-400)
│   ├── Progress percentage (xs, primary blue)
│   └── Expand/collapse chevron
├── Progress Bar
│   └── 8px height, gray-100 bg, gradient blue fill (animated)
└── Steps List (when expanded)
    ├── Step items (5-6 per archetype)
    │   ├── Done: green-50/50 bg, CheckCircle green icon, strikethrough text
    │   └── Pending: gray-50 bg, Circle gray icon, normal text, blue action pill
    └── Motivational message card
        └── Gradient blue-50 to indigo-50, sparkles icon, dynamic text
```

**Setup Steps (config-driven per archetype):**

| Step ID | Label | Icon | Check Logic | Action |
|---------|-------|------|-------------|--------|
| `logo` | أضف شعار / صورة الصفحة | Camera | page has non-placeholder logo | إضافة |
| `location` | حدد موقعك على الخريطة | MapPin | page has location or address | تحديد |
| `hours` | أضف ساعات العمل | Clock | page has working_hours | إضافة |
| `products` | Dynamic per archetype* | Package | page has catalog/services/menu | إضافة |
| `payment` | حدد طرق الدفع المقبولة | CreditCard | page has payment_methods | تحديد |
| `team` | أضف فريق العمل (optional) | People | page has team members | إضافة |

*Products step label:
- `menu_order`: "أضف أصناف القائمة"
- `service_booking`: "أضف خدماتك"
- `catalog_order`: "أضف منتجاتك"
- Default: "أضف محتوى صفحتك"

**Team step** only shown for: `service_booking` archetype.

**Demo mode:** First 3 steps shown as done (60% progress).

**Motivational messages:**
- `< 50%`: "أكمل الإعداد خلال ٣ دقائق وابدأ باستقبال الطلبات!"
- `50-99%`: "أوشكت! خطوتين فقط وتصير صفحتك جاهزة"
- `100%`: "ممتاز! صفحتك جاهزة لاستقبال العملاء"

**Behavior:**
- Default expanded
- Hides completely when all steps are done (100%)
- `onAction` callback for each incomplete step
- Smooth animation on expand/collapse

### Part B: Revenue Overview Widget

#### 2. Revenue Overview Card

Create `lib/features/business/dashboard/presentation/widgets/revenue_overview_card.dart`:

**RevenueOverviewCard** — prominent blue gradient card with period switching.

**Structure:**
```
Blue gradient card (rounded-2xl, p-4, shadow-lg)
├── Period Tabs Row
│   ├── "اليوم" (today)
│   ├── "هذا الأسبوع" (week)
│   └── "هذا الشهر" (month)
├── Main Amount
│   ├── Period label (10px, white/60%)
│   ├── Amount (text-3xl, white) + currency (xs, white/60%)
│   ├── Delta % with trend icon (green-300 or red-300)
│   └── Previous period comparison (9px, white/40%)
├── Orders Count (divider + orders + average)
└── Payment Breakdown (today only)
    ├── Label: "طرق الدفع اليوم" (9px, white/40%)
    ├── Cash: banknote icon (green-300) + "كاش" + amount
    ├── CliQ: phone icon (purple-300) + "CliQ" + amount
    └── Bank: credit card icon (blue-200) + "تحويل" + amount
```

**Visual Design:**
- Background: `LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft, colors: [#1A73E8, blue-600])`
- All text: white with varying opacity
- Period tabs: selected = white/25% bg, white text; unselected = white/60% text
- Tabs: pill shape (rounded-full), 10px text
- Shadow: blue shadow with 40% opacity

**Data Model:**
```dart
class RevenueData {
  final int today;      // piasters
  final int yesterday;
  final int week;
  final int lastWeek;
  final int month;
  final int lastMonth;
  final int ordersToday;
  final PaymentBreakdown? paymentBreakdown;
}

class PaymentBreakdown {
  final int cash;   // piasters
  final int cliq;
  final int bank;
}
```

**Period switching logic:**
- Today: compare to yesterday
- Week: compare to last week
- Month: compare to last month
- Delta % = ((current - previous) / previous) * 100

**Visibility:** Only shown when `engagement == full` AND archetype NOT `directory` or `followOnly`.

### Part C: Dashboard Integration

#### 3. Modify BusinessDashboardPage

Update `business_dashboard_page.dart` to render in this order:

```
SetupProgressCard (if setup incomplete)
RevenueOverviewCard (if engagement == full && not directory/followOnly)
Stats Row
Quick Actions
Dashboard Sections
Recurring Customers
```

#### 4. Enhance Dashboard Fixtures

Update each dashboard JSON to include revenue overview data:

```json
{
  "today_revenue": {
    "amount": 4750,
    "yesterday": 3800,
    "orders_count": 8,
    "payment_breakdown": {
      "cash": 2800,
      "cliq": 1250,
      "bank": 700
    }
  }
}
```

Week/month data derived from daily data (× multipliers) in the widget, same as Figma does.

## Files to Create

1. `lib/features/business/dashboard/presentation/widgets/setup_progress_card.dart`
2. `lib/features/business/dashboard/presentation/widgets/revenue_overview_card.dart`

## Files to Modify

1. `lib/features/business/dashboard/presentation/pages/business_dashboard_page.dart` — integrate both new widgets
2. Dashboard fixture JSON files — add `payment_breakdown` to `today_revenue` where missing

## DO NOT Modify

- `business_type_config.dart` — no new config fields needed (steps derived from page data)
- `core_sections.dart` — existing `TodayRevenueSection` still used as a dashboard section card
- `business_shell.dart` — no changes
- `business_home_page.dart` — no changes

## Testing

**Demo accounts to verify:**
- **Sara** (0790000001/111111) → switch to business → select any page → should see setup checklist at top + revenue card
- **Ahmad** (0790000002/222222) → select "water_delivery" → full dashboard with setup + revenue + delivery route
- **Ahmad** → select "restaurant" → setup + revenue + queue + best sellers
- **Khaled** (0790000030/111111) → select "directory" → NO revenue overview (directory archetype), NO setup checklist visible
- Test expand/collapse on setup checklist
- Test period switching on revenue card (today/week/month)
- Verify delta % calculation and trend arrows

## Acceptance Criteria

- [ ] SetupProgressCard renders with 5-6 steps based on archetype
- [ ] Progress bar shows animated fill
- [ ] Steps show done (green) / pending (gray) state correctly
- [ ] Dynamic label for products step per archetype (menu/service/catalog)
- [ ] Team step only shows for service_booking
- [ ] Motivational message changes based on progress
- [ ] Card hides when 100% complete
- [ ] Expand/collapse toggle works
- [ ] RevenueOverviewCard renders with blue gradient
- [ ] Period tabs switch between today/week/month
- [ ] Delta % with trend icon (up green, down red)
- [ ] Payment breakdown shows only for "today" period
- [ ] Revenue card hidden for directory and followOnly archetypes
- [ ] Dashboard renders: SetupProgress → Revenue → Stats → Actions → Sections → Recurring
- [ ] All existing functionality preserved
- [ ] `flutter analyze` passes
- [ ] App runs without errors

## Patterns to Follow

- Widget pattern: StatelessWidget or StatefulWidget (for expand state), ConsumerWidget if needs providers
- RTL: `EdgeInsetsDirectional`, Arabic labels
- Colors: `AppColors.primary` for blue, `AppColors.success` for green
- Gradient: `LinearGradient` with blue shades
- Animation: `AnimatedContainer` for expand/collapse, `TweenAnimationBuilder` for progress bar
- Money: integer piasters, format with `formatJod()` from core_sections.dart
- Data: read from `dashboardStatsProvider` fixture data
- Spacing: `AppSpacing.*` constants
- Border radius: `AppRadius.*` or literal `BorderRadius.circular()`
