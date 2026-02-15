# Figma ↔ Flutter — Sync Status & Gap Analysis

> Master tracking document. Updated: 2026-02-14 (verified against actual code)
>
> **Source of truth:** Flutter app is the production codebase. Figma prototype (`app-figma/`) is the design reference.
> **Workflow:** Figma Make AI builds → Omar confirms in demo → pushes to git → we plan + port to Flutter.

---

## How To Use This Document

1. When new Figma changes land, check the relevant section below
2. Update status from `Not Started` → `Planned` → `In Progress` → `Done`
3. For each planned item, create a sprint doc in `docs/sprints/` if it's medium+ size
4. Small items (< 1 hour) can be done directly without a sprint doc

---

## Feature Inventory — What Exists Where

### Legend
- `MATCH` — Flutter and Figma have equivalent implementations
- `FLUTTER AHEAD` — Flutter has more than Figma
- `FIGMA AHEAD` — Figma has features not yet in Flutter (needs porting)

---

### 1. Customer-Facing Features

| Feature | Flutter | Figma | Status | Notes |
|---------|---------|-------|--------|-------|
| Auth (welcome, phone, OTP, profile) | 4 pages, guest mode | 7 components | MATCH | |
| Home Feed (stories bar, post cards) | 5 card types, stories, promo carousel | 18 components | MATCH | |
| Explore (categories, search, filters) | Category grid, browse page, smart badges, **search page with tabs** | 11 components + smart search | MATCH | Search page fully built with recent searches, All/Pages/Products tabs |
| Page Detail (all archetypes) | 8 archetype sections + directory | 17 section components | MATCH | |
| Chat (conversations, messages) | 12+ message types, power chat | 12 components | MATCH | Session D items in progress |
| Requests (order, booking, quote, etc.) | 6 request sheets, detail, timeline | 15 components | MATCH | |
| Orders Tab | Orders page with 4 tabs, search | 7 components + subscriptions | MATCH | Subscriptions tab UI exists (content Phase 4) |
| Notifications | Card, filters, skeleton | 1 component | FLUTTER AHEAD | |
| Profile / Account | Account page, settings, business pages | 1 component (Me.tsx) | FLUTTER AHEAD | |
| Saved / Bookmarks | List page, provider | Not explicit | FLUTTER AHEAD | |
| Stories (viewing) | Story viewer modal | StoryCanvas, StoryViewer | MATCH | |
| Page Claiming | ClaimRequestPage | ClaimRequestFlow, ClaimSteps | MATCH | |
| Location / City System | Basic location on pages | CityBar, CityDetection, CityPicker, CoverageBanner | FIGMA AHEAD | Phase 2 — needs backend |
| Customer Queue View | 8 widgets (tracker, view, modify, cancel) | CustomerQueueView, QueueActiveTracker | MATCH | |
| Customer Dropoff View | customer_dropoff_view.dart | CustomerDropoffView.tsx | MATCH | |
| Guest Welcome Banner | guest_welcome_banner.dart (gradient, 2 CTAs) | GuestFeed components | MATCH | Already built |
| Villa Seasonal Pricing (customer) | Seasonal entities, calc utils, customer display, business editor | VillaSection with seasons, last-minute deals, timeline | MATCH | Done — [S03](sprints/S03_seasonal_pricing.md) |
| Reorder Section | Horizontal strip on home feed | ReorderSection.tsx | MATCH | Done — [S04](sprints/S04_reorder_section.md) |

---

### 2. Business-Mode Features

| Feature | Flutter | Figma | Status | Notes |
|---------|---------|-------|--------|-------|
| Business Shell (tabs, app bar, page switch) | business_shell.dart, business_app_bar.dart | BusinessMode.tsx, BizNav.tsx | MATCH | |
| Dashboard | 8 section types, config-driven | BizDashboard.tsx | MATCH | |
| Order Management / Requests | 20+ widgets, driving mode | BizRequests.tsx + sub-components | MATCH | |
| Request Detail Tabs + Activity Log | Flat single-scroll detail page | OrderDetailPage.tsx (2 tabs: Summary + Log) | FIGMA AHEAD | [S10](sprints/S10_request_detail_tabs.md) |
| Reservation Lifecycle (Guest Journey) | Generic order handling for reservations | GuestJourneyCard + DepositTracker + PropertyCondition (1780+ lines) | FIGMA AHEAD | [S11](sprints/S11_reservation_lifecycle.md) |
| Queue Board | 10+ widgets, activity log, quick-add, **discounts fully built** | 16+ components | MATCH | Discount entity, quick-add UI, card badges, detail breakdown — all done |
| Dropoff Board | 12+ widgets, activity log, quick-add, **receipt in terminal states** | 10+ components | MATCH | Terminal bottom bar with receipt already exists |
| Order Management Receipt | Receipt button on completed/delivered orders | Receipt for completed orders | MATCH | Done — [S06](sprints/S06_order_receipt.md) |
| Directory Management | 17+ widgets, tenant CRUD, floors | 11+ components | MATCH | |
| Page Settings | 30+ widgets, 20+ sub-sections | ~65 components | MATCH | |
| Catalog Management | 19+ widgets, price history, mass actions | ItemWizard, ProductListView | MATCH | |
| Post Creation | Create + form pages | BizCreatePost.tsx | MATCH | |
| Stories (create + manage) | Creator + manager pages | StoryManager.tsx | MATCH | |
| Insights / Analytics | Full insights screen — 14 files, fl_chart, 8 archetypes, 6 type configs | INSIGHTS_SCREEN_SPEC.md (1054 lines), BusinessInsights.tsx | MATCH | Done — [S08](sprints/S08_business_insights.md) |
| Stock Manager | StockManagerSheet with search, filters, steppers, dashboard integration | StockManager.tsx (467 lines) | MATCH | Done — [S09](sprints/S09_stock_manager.md) |
| Quote Builder Sheet | `quote_builder_sheet.dart` — full line-item builder (business → customer) | QuoteBuilderSheet.tsx (474 lines) | MATCH | Already built — line items, discount, validity, total |
| Seasonal Pricing (business editor) | Full seasonal editor in villa settings | SeasonalPricing.tsx (~600 lines) | MATCH | Done — [S03](sprints/S03_seasonal_pricing.md) |
| Shared Activity Log UI | **Already shared** in `business/shared/widgets/activity_log.dart` | ActivityLogSheet.tsx | MATCH | ActivityLogEntry + showActivityLogSheet + preview — all shared |
| Shared Service Card Parts | GenericStatusPickerSheet, PhotoToggleButton, StatusConfig | ServiceCardParts.tsx | MATCH | Done — [S07](sprints/S07_shared_service_components.md) |
| Promoted Post Creator | Not implemented | PromotedPostCreator.tsx | FIGMA AHEAD | Phase 5 — defer |
| Recurring / Subscriptions | Route placeholder | 6 components | FIGMA AHEAD | Phase 4 — defer |
| Alert Management | alert_manager in settings | AlertCreateForm, AlertManage | MATCH | |
| Revenue Overview | Not implemented | RevenueOverview.tsx | FIGMA AHEAD | Phase 5 — defer |

---

### 3. Infrastructure & Config

| Feature | Flutter | Figma | Status |
|---------|---------|-------|--------|
| Business Type Registry | BusinessTypeRegistry + 42 types | 20 config files + archetype-defaults | MATCH |
| Mock API System | MockApiClient + manifest + 64 pages | JSON fixtures in src/api/ | MATCH |
| Theme System | AppColors, AppTypography, Tailwind gray | Tailwind CSS classes | MATCH |
| Routing | GoRouter with guards, 35+ routes | React router in App.tsx | MATCH |

---

## Active Sprint Backlog

### Verified Gaps (ready to implement)

| ID | Feature | Size | Files | Sprint Doc |
|----|---------|------|-------|------------|
| S10 | Request Detail Tabs + Activity Log | Medium | ~5-7 | [S10](sprints/S10_request_detail_tabs.md) |
| S11 | Reservation Lifecycle (Guest Journey + Deposit + Property) | Large | ~10-12 | [S11](sprints/S11_reservation_lifecycle.md) |

### Completed (verified)

| ID | Feature | Status |
|----|---------|--------|
| ~~S03~~ | Villa seasonal pricing | Done — entities, calc utils, customer display, business editor, fixtures |
| ~~S07~~ | Shared status picker + card parts | Done — GenericStatusPickerSheet, PhotoToggleButton, StatusConfig base, ActivityActionConfig |
| ~~S06~~ | Order management receipt in terminal states | Done — receipt button on completed/delivered orders, chat button, declined stays badge-only |
| ~~S04~~ | Reorder section on home feed | Done — horizontal strip with last 5 completed orders, reorder button, hidden for guests |
| ~~S05~~ | Queue manual discounts | Already built before sprint planning |
| ~~S01~~ | Smart search in Explore | Already built before sprint planning |
| ~~S08~~ | Business Insights Screen | Done — 14 new files, fl_chart charts, 8-archetype visibility, 6 type configs, period switching, edge cases |
| ~~S09~~ | Stock Manager + Orders Fixture | Done — StockManagerSheet, stock providers, dashboard integration, 5 per-type order fixtures |

### Deferred (future phases)

| Feature | Size | When |
|---------|------|------|
| City / location detection system | Large | Phase 2 (needs backend) |
| Promoted Post Creator | Medium | Phase 5 |
| Recurring / Subscriptions | Large | Phase 4 |
| Revenue Overview | Medium | Phase 5 |

---

## Parallel Session Guide

### Current Pair: S10 + S11

These two are fully independent — no file overlaps:

**Session A — S10 (Request Detail Tabs + Activity Log):**
- Touches: `lib/features/business/order_management/presentation/pages/detail_page.dart` (modify), creates `request_activity_utils.dart`
- Adds DefaultTabController with 2 tabs (Summary + Activity Log), status context banners, reuses shared activity_log.dart
- All work inside `order_management/presentation/`

**Session B — S11 (Reservation Lifecycle):**
- Creates ~9 NEW files: entities (reservation_lifecycle, deposit_ledger, property_inspection), widgets (guest_journey_card, deposit_tracker, property_condition_recorder, reservation_management_section, order_snapshot_display), mock data
- All NEW files — does NOT modify detail_page.dart or any existing file
- Integration into detail page happens after both sessions are validated

**Zero file overlap.** Session A modifies existing detail_page.dart. Session B creates only new files. Integration is a quick follow-up step.

### Previous Pair: S08 + S09 (completed)

S08 (Business Insights) + S09 (Stock Manager) — zero file overlap, both validated 18/18 and 14/14.

---

## Figma Change Tracking

| Date | Figma Commit | What Changed | Status |
|------|-------------|--------------|--------|
| 2026-02-13 | c5b52f3 | Seasonal pricing, last-minute deals, queue discounts, shared components, receipt terminal states | **COMPLETE** — S03/S04/S06/S07 implemented, S01/S05 were already built |
| 2026-02-14 | latest | Business Insights full spec (1054 lines), StockManager.tsx, QuoteBuilderSheet.tsx, business_orders.json fixture | **COMPLETE** — S08+S09 implemented, QuoteBuilder was already built |

---

## Notes

- Flutter app is **significantly more mature** than initially assessed — many Figma features were already ported
- Always verify against actual Flutter code before planning sprints (this doc was corrected after code verification)
- Figma components are single-file React — Flutter needs entity + provider + widget separation
- The Figma's `SESSION_CHANGES.md` and `DROPOFF_FEATURES.md` contain detailed data shapes for entity design
