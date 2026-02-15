# Session Preamble — Paste This at the Top of Every Session

Copy everything between the `---` markers below and paste it before your task-specific prompt.

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

## Config System Quick Reference

Business type configs live in `lib/config/types/` organized by archetype:
- `food_types.dart` — restaurant, cafe, bakery, juice_bar, etc.
- `service_types.dart` — salon, clinic, gym, car_wash, laundry, etc.
- `catalog_types/` — water_delivery, clothes_store, pharmacy, etc.
- `quote_types.dart` — plumber, electrician, etc.
- `portfolio_types.dart` — photographer, etc.
- `reservation_types.dart` — villa_rental, event_venue, etc.
- `misc_types.dart` — government, bank, directory

Each type uses `createType()` to inherit archetype defaults and override specific fields.
Registry: `lib/config/business_type_registry.dart`
Archetype defaults: `lib/config/archetype_defaults/`

## Insights System Quick Reference

Generator factory: `lib/features/business/insights/data/insights_mock_data.dart`
- Map `_typeGenerators` dispatches to type-specific functions
- Each returns `InsightsData` with: kpiSections, revenueChart?, topItems?, distribution?, tips
- Chart labels: `lib/features/business/insights/domain/insight_chart_config.dart`
- Use `_periodMultiplier(period)` to scale data (1.0 week, 4.2 month, 52.0 year)
- Study existing generators (_salon, _restaurant, _waterDelivery) as patterns

## Dashboard Fixture Convention

Path: `assets/api/business/dashboard/{business_type_id}.json`
- Must have data for every section in the type's `dashboard.sections` config
- `today_revenue` needs: `total`, `yesterday`, `orders_count`, `payment_breakdown` (cash/cliq/bank)
- All prices in piasters (integer)
- Use realistic Arabic names, real Amman neighborhoods, realistic JOD prices

## Quality Gates (MUST pass before done)
1. `flutter analyze` — zero new issues
2. All data is realistic for Jordan (Arabic names, JOD prices, Amman areas)
3. RTL layout verified (EdgeInsetsDirectional everywhere)
4. Config-driven — no hardcoded type checks in widgets
5. Pixel-perfect match to Figma reference
6. File size limits respected (300 lines widgets, 500 lines pages)
```

---
