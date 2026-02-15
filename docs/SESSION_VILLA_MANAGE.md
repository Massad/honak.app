# Villa Manage Tab — Rebuild Session

Paste the entire block below (between the ``` markers) into a fresh Claude Code session.

---

```
You are working on the Honak Flutter mobile app at /Users/omar/Documents/projects/super-app-jo/mobile

## MANDATORY: Read These First
Before writing ANY code, read these files in order:
1. `../docs/GUIDELINES.md` — coding rules, config-driven design, component sharing, Figma reference, quality gates. FOLLOW EVERY RULE.
2. `../CLAUDE.md` — product vision, archetypes, interaction model
3. `./CLAUDE.md` — mobile-specific conventions, architecture, build commands

## Project Context
Honak is a Jordanian super app — 42 business types, 8 archetypes, one codebase. Every UI decision flows from `BusinessTypeConfig`. A restaurant and a bakery are both `menuOrder` archetype — they share the same shell but differ via config. If adding a 43rd type requires widget code changes, the architecture is wrong.

## Figma = Visual Source of Truth
The Figma prototype lives at `../app-figma/`. It's a React/TypeScript app that represents the pixel-perfect target. When building/aligning Flutter code:

1. **Read the Figma TSX file** for exact layout, spacing, colors, and component structure
2. **Map Figma values to our design tokens** — never use raw hex colors if a token exists
3. **Match the visual output exactly** — same spacing, same colors, same border radius, same font sizes

### Design Token Mapping (Figma → Flutter)

**Colors:**
| Figma (Tailwind) | Flutter | Hex |
|---|---|---|
| `blue-600` / primary | `AppColors.primary` | #1A73E8 |
| `amber-500` / secondary | `AppColors.secondary` | #FF9800 |
| `red-600` | `AppColors.error` | #E53935 |
| `green-600` | `AppColors.success` | #43A047 |
| `gray-900` | `AppColors.textPrimary` / `colorScheme.onSurface` | #111827 |
| `gray-500` | `AppColors.textSecondary` / `colorScheme.onSurfaceVariant` | #6B7280 |
| `gray-400` | `AppColors.textHint` | #9CA3AF |
| `gray-200` | `AppColors.divider` / `colorScheme.outlineVariant` | #E5E7EB |
| `gray-100` | `AppColors.border` | #F3F4F6 |
| `gray-50` | `AppColors.surfaceVariant` | #F9FAFB |
| `white` | `colorScheme.surface` | #FFFFFF |
| `bg-{color}-50` | `Color(0xFF...).withValues(alpha: 0.1)` or exact Tailwind hex | — |

**Spacing (Figma px → AppSpacing):**
| Figma | Flutter |
|---|---|
| `p-0.5` / 2px | `AppSpacing.xxs` (2) |
| `p-1` / 4px | `AppSpacing.xs` (4) |
| `p-2` / 8px | `AppSpacing.sm` (8) |
| `p-3` / 12px | `AppSpacing.md` (12) |
| `p-4` / 16px | `AppSpacing.lg` (16) |
| `p-5` / 20px | `AppSpacing.xl` (20) |
| `p-6` / 24px | `AppSpacing.xxl` (24) |
| `p-8` / 32px | `AppSpacing.xxxl` (32) |

**Border Radius (Figma → AppRadius):**
| Figma | Flutter |
|---|---|
| `rounded` / 4px | `AppRadius.xxs` (4) |
| `rounded-md` / 8px | `AppRadius.sm` (8) |
| `rounded-xl` / 12px | `AppRadius.md` (12) — use for inner cards, sections |
| `rounded-2xl` / 16px | `AppRadius.lg` (16) — use for main cards |
| `rounded-full` | `AppRadius.pill` (9999) — use for pills, badges |

**Typography:**
| Figma | Flutter |
|---|---|
| `text-xs` (12px) | `context.textTheme.bodySmall` or explicit `fontSize: 12` |
| `text-sm` (14px) | `context.textTheme.bodyMedium` |
| `text-base` (16px) | `context.textTheme.bodyLarge` |
| `text-lg` (18px) | `context.textTheme.titleMedium` |
| `text-xl` (20px) | `context.textTheme.titleLarge` |
| 10px | explicit `fontSize: 10` (smaller than text scale) |
| 9px | explicit `fontSize: 9` |

## Architecture Patterns You MUST Follow

### Config-Driven (from GUIDELINES.md §2)
```dart
// NEVER this:
if (type == 'restaurant') return 'القائمة';
// ALWAYS this:
return config.itemManagement?.itemsLabelAr ?? 'العناصر';
```

### RTL-First
- Use `EdgeInsetsDirectional`, never `EdgeInsets` (except symmetric)
- Arabic is the primary language — `app_ar.arb` is the template
- Back button always on LEFT (put in `actions`, set `automaticallyImplyLeading: false`)

### Money
- Integer piasters (JOD cents): `1500` = 1.500 JOD
- Never use `double` for money
- Format: `(piasters / 100).toStringAsFixed(piasters % 100 == 0 ? 0 : 2)` + ` د.أ`

### Cards & Containers
Standard card pattern matching Figma:
```dart
Container(
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.surface,
    borderRadius: BorderRadius.circular(14), // rounded-xl
    border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
  ),
  padding: const EdgeInsets.all(AppSpacing.lg),
  child: ...
)
```

### Loading States
- ALWAYS skeleton loaders for content loading — NEVER `CircularProgressIndicator`
- Spinners OK only inside action buttons (save, submit)

### File Size Limits
- Widgets: ~300 lines max
- Pages: ~500 lines max
- Split when approaching limits

---

## YOUR TASK: Rebuild VillaManage Tab to Match Spec

### Full Spec
Read `../app-figma/docs/villa-manage-tab-spec.md` — this is your SOURCE OF TRUTH for every detail.

### Figma Reference Files
Read these for exact layout/component structure:
- `../app-figma/src/app/components/business-mode/VillaManage.tsx` (544 lines) — main manage tab
- `../app-figma/src/app/components/business-mode/PropertyFeatures.tsx` (695 lines) — property features overlay
- `../app-figma/src/app/components/business-mode/BlockedDates.tsx` (540 lines) — blocked dates + availability

### What Already Exists (Read These to Understand Current State)
- `lib/features/business/catalog_management/presentation/pages/villa_manage_page.dart` (468 lines) — current manage tab, basic sections
- `lib/features/business/catalog_management/presentation/widgets/villa_manage_sections.dart` (814 lines) — reusable section widgets
- `lib/features/business/page_settings/presentation/widgets/villa_settings.dart` (1,764 lines) — comprehensive settings with edit modes (REUSE patterns/logic from here)
- `lib/features/business/catalog_management/presentation/widgets/price_change/` — price change banner + wizard (FULLY DONE, DO NOT MODIFY)
- `lib/features/pages/domain/entities/seasonal_pricing.dart` — freezed entities (REUSE)
- `lib/features/pages/domain/seasonal_pricing_utils.dart` — calculation utils (REUSE)

### Gap Analysis — What Needs to Change

The current implementation has basic collapsible sections but is missing key features. The spec requires **6 sections** (not 8):

| # | Section | Current Status | What's Needed |
|---|---------|---------------|---------------|
| 1 | **Price Change Banner** | ✅ 100% done | DO NOT TOUCH |
| 2 | **Pricing (sub-tabbed)** | ⚠️ 50% — flat section, no tabs | Add sub-tabs: "الأساسي" (base) + "المواسم والعروض" (seasonal). Base tab has view/edit for weekday/weekend. Seasonal tab has full SeasonalPricing component with seasons, holidays, early bird, last minute — all EDITABLE with toggles and pickers. |
| 3 | **Property Description** | ❌ 30% — just specs chips | REBUILD as full-screen overlay button. Overlay = PropertyFeatures: category-based system with count/toggle items, CRUD, reorder, suggestions, icon mapping. See PropertyFeatures.tsx. |
| 4 | **House Rules** | ✅ 95% done | Add inline edit (tap edit icon → input field, enter/check to save). Currently only add/delete. |
| 5 | **Check-in/Check-out** | ✅ 80% done | Polish — already has view/edit mode with text inputs. Good enough. |
| 6 | **Gallery** | ⚠️ 60% — display only | Add reorder mode (up/down arrows, index badges, "ترتيب" toggle button), delete on images, cover badge. |
| 7 | **Availability** | ❌ 10% — just a link | REBUILD as full-screen overlay button. Overlay = AvailabilityManager: weekly schedule editor (7 days, time pickers, split shifts), blocked dates tab (mini calendar, 3 block types, forms), team tab (optional). |

### Implementation Plan — Work in 4 Phases

#### Phase 1: Restructure VillaManage + Pricing Sub-Tabs
**Files:** `villa_manage_page.dart`, `villa_manage_sections.dart`

1. Refactor `villa_manage_page.dart` to support full-screen overlay state (`_activeOverlay` enum: none, propertyFeatures, availability)
2. Change section list from 8 items to 6 (merge specs+amenities→Property Description button, keep availability as button)
3. Add pricing sub-tabs inside the pricing collapsible section:
   - Tab "الأساسي": existing weekday/weekend view/edit (already works)
   - Tab "المواسم والعروض": editable seasonal pricing component
4. For seasonal pricing tab, extract/adapt logic from `villa_settings.dart`:
   - Season cards with toggle + inline price edit
   - Holiday surcharges with toggle
   - Early bird discount with chip pickers (days: 7/14/21/30, percent: 5/10/15/20)
   - Last minute deals with chip pickers (days: 1/2/3/4, percent: 5/10/15/20)
   - Timeline visualization (12-month bar)
   - Sticky "حفظ التسعير الموسمي" button when changes exist

**Split the seasonal pricing into its own widget file** to respect the 300-line limit:
- NEW: `villa_seasonal_pricing.dart` (~300 lines) — the full seasonal pricing tab content

#### Phase 2: PropertyFeatures Overlay
**NEW file:** `lib/features/business/catalog_management/presentation/widgets/property_features_overlay.dart`

Build the PropertyFeatures full-screen overlay matching `PropertyFeatures.tsx`:
1. Sticky header: back button + "وصف العقار" title + "حفظ" button
2. Category list — each category is a collapsible card with:
   - Header: icon + name + item count + edit/delete buttons
   - Items: count (stepper) or toggle (switch) + edit/delete
   - Add item form (name + type selector + optional count)
   - Suggestions dropdown (quick-add from pool, filtered)
3. Add category button at bottom
4. Reorder mode toggle (moves categories and items with up/down arrows)
5. Icon mapping from item Arabic names (use the ICON_MAP from spec section 6)
6. Default categories builder (from page data: max_guests, bedrooms, bathrooms, amenities)

**Split into 2-3 files** to respect size limits:
- `property_features_overlay.dart` (~400 lines) — main overlay, header, category list
- `property_feature_items.dart` (~300 lines) — item rows, add form, suggestions

#### Phase 3: Gallery Reorder + House Rules Edit
**Files:** `villa_manage_sections.dart` (modify existing widgets)

1. **Gallery reorder mode:**
   - Add "ترتيب" toggle button above grid
   - Normal mode: 3-column grid with index badges, cover badge, delete button
   - Reorder mode: vertical list with grip icons, up/down arrows, "تم الترتيب" button
   - Success message: green banner "تم حفظ الترتيب الجديد" (auto-hide 2s)

2. **House rules inline edit:**
   - Tap pencil on any rule → input field replaces text
   - Check icon saves, X cancels, Enter saves
   - State: `_editingRuleIdx`, `_editingRuleText`

#### Phase 4: Availability Overlay
**NEW file:** `lib/features/business/catalog_management/presentation/widgets/availability_overlay.dart`

Build the AvailabilityManager full-screen overlay matching `BlockedDates.tsx` + spec section 10:
1. Sticky header: back + "إدارة المواعيد" + "حفظ"
2. Tab pills: "الجدول الأسبوعي" | "حظر مواعيد" (| "الفريق" if team exists)
3. **Weekly Schedule tab:**
   - 7 day cards (Saturday-first), each with toggle + time range
   - Expand to edit: time pickers (start/end), split shift support, "نسخ لكل أيام العمل"
   - Default: Sat-Thu enabled 09:00-18:00, Friday disabled
4. **Blocked Dates tab:**
   - Mini calendar (month view, colored dots for block types)
   - 3-button grid: recurring (orange), specific (red), range (purple)
   - Add forms for each type (weekday picker, date input, date range)
   - Grouped list of existing blocks with delete
5. Team tab can be a placeholder for now

**Split into 2-3 files:**
- `availability_overlay.dart` (~400 lines) — main overlay, tabs, weekly schedule
- `blocked_dates_tab.dart` (~300 lines) — mini calendar, block forms, block list

### File Ownership — What You CAN Modify

| File | Action |
|------|--------|
| `lib/features/business/catalog_management/presentation/pages/villa_manage_page.dart` | REWRITE — overlay state, 6 sections, pricing tabs |
| `lib/features/business/catalog_management/presentation/widgets/villa_manage_sections.dart` | MODIFY — gallery reorder, house rules edit, remove specs/amenities sections |
| `lib/features/business/catalog_management/presentation/widgets/villa_seasonal_pricing.dart` | CREATE — seasonal pricing tab content |
| `lib/features/business/catalog_management/presentation/widgets/property_features_overlay.dart` | CREATE — property features full-screen overlay |
| `lib/features/business/catalog_management/presentation/widgets/property_feature_items.dart` | CREATE — feature item rows, forms, suggestions |
| `lib/features/business/catalog_management/presentation/widgets/availability_overlay.dart` | CREATE — availability full-screen overlay |
| `lib/features/business/catalog_management/presentation/widgets/blocked_dates_tab.dart` | CREATE — blocked dates mini calendar + forms |

### DO NOT Modify
- `price_change_banner.dart`, `price_change_history.dart`, `wizard_page.dart`, `wizard_steps.dart` — price change is DONE
- `villa_settings.dart` — keep as-is (will be removed later, use as reference only)
- `seasonal_pricing.dart` (entities) — reuse as-is
- `seasonal_pricing_utils.dart` — reuse as-is
- `business_home_page.dart` — routing already correct
- Any files outside `catalog_management/` feature

### Quality Gates
1. `flutter analyze` — zero new errors/warnings
2. All data realistic for Jordan (Arabic names, JOD prices, Amman areas)
3. RTL layout (EdgeInsetsDirectional everywhere)
4. Config-driven — no hardcoded type checks in widgets
5. Pixel-perfect match to Figma reference
6. File size limits: ~300 lines widgets, ~500 lines pages — SPLIT if needed
7. Accordion pattern: only one collapsible section expanded at a time
8. Full-screen overlays: conditional render (not push navigation)

### Testing
- **Khaled** (0790000030 / 111111) → business mode → "فيلا البحر الميت" → Home → "إدارة" sub-tab
- Price Change Banner visible at top
- Pricing section: sub-tabs work, base edit mode, seasonal pricing editable
- Property Description: tap → full-screen overlay with categories, items, reorder
- House Rules: inline edit, add, delete all work
- Gallery: grid view + reorder mode toggle
- Availability: tap → full-screen overlay with weekly schedule + blocked dates
- Other business types (salon, restaurant) → Manage tab still shows catalog as before

### Work in order: Phase 1 → 2 → 3 → 4. Verify `flutter analyze` after each phase.
```
