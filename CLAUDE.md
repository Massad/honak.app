# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Context

This is the Flutter mobile app for **Honak** — see `../CLAUDE.md` for product vision, archetypes, and full docs index. **Read `../docs/GUIDELINES.md` first** — it covers coding rules, config-driven design, naming conventions, component sharing, and Figma reference that apply to all work. This file covers mobile-specific conventions only.

Currently in **Phase 1** with mock data. No real backend integration yet.

## Build & Run Commands

```bash
# Run the app
flutter run

# Code generation (after changing @freezed entities or Riverpod annotations)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for code generation during development
dart run build_runner watch --delete-conflicting-outputs

# Run all tests
flutter test

# Run a single test file
flutter test test/path/to/test.dart

# Analyze code
flutter analyze

# Generate l10n files (auto-runs on build, but can force)
flutter gen-l10n

# Regenerate fixture files (after adding/editing page_*.json files)
dart run tool/generate_fixtures.dart
```

## Architecture

### Feature-First + Domain Layering

```
lib/
├── main.dart / app.dart / bootstrap.dart   # Entry, MaterialApp.router, init
├── config/env.dart                          # Environment: mock/dev/prod
├── core/                                    # Router, theme, l10n, extensions, constants
├── shared/                                  # API client, auth, entities, providers, widgets
├── features/{feature}/                      # Domain modules
│   ├── domain/entities/                     # @freezed data classes
│   ├── data/repository/                     # API calls
│   └── presentation/
│       ├── providers/                       # Riverpod providers
│       ├── pages/                           # Full screens
│       └── widgets/                         # Feature-specific UI
└── fixtures/                                # Local JSON mock data
```

### State Management — Riverpod

- **Global providers** in `shared/providers/`: `apiClientProvider`, `appModeProvider` (customer/business toggle), `localeProvider` (ar/en)
- **Auth** uses `AsyncNotifierProvider<AuthNotifier, AuthState>` — sealed union: `AuthLoading | Authenticated | AuthGuest | Unauthenticated`
- **Feature data** uses `FutureProvider.family` for async fetching
- **Simple state** uses `StateProvider` (mode, locale)
- Entities use `@freezed` for immutability + JSON serialization

### Routing — GoRouter

Router in `core/router/app_router.dart`. Route constants in `core/router/routes.dart` with helper methods (`Routes.pagePath(handle)`, `Routes.productPath(id)`, etc.).

- **Auth redirect**: watches `authProvider`, redirects unauthenticated users to `/login`, authenticated users away from auth routes
- **App shell**: `StatefulShellRoute.indexedStack` with 5 tabs (Home, Explore, Quick Actions, Chat, Profile)
- **Guest browsing**: supported — home, explore, page detail, product detail accessible without login
- **Business mode routes**: prefixed `/biz/`

### Mock API System

Two-tier fixtures:
- `lib/fixtures/*.json` — lightweight data for simple lists
- `assets/api/{domain}/*.json` — detailed responses organized by domain

`MockApiClient` in `shared/api/mock_api_client.dart`:
- Routes API paths to fixture files via **generated manifest** (`assets/api/generated/manifest.json`)
- Sub-resources (items, dashboard, etc.) resolved by **convention**: `products/items_{business_type_id}.json`, `business/dashboard/{business_type_id}.json`
- Phone-based user switching (e.g. `0790000001` → Sara, `0790000002` → Ahmad)
- OTP code is always `123456` in mock mode (or per-account codes: Sara=111111, Ahmad=222222)
- `ApiClient` interface swaps between `MockApiClient` and `DioApiClient` via `envConfigProvider`

### Adding a New Business Page

**`page_*.json` files are the source of truth.** Never manually edit `pages_list.json`, `manifest.json`, or `categories.json` — they are auto-generated.

```bash
# 1. Create the page fixture
#    Required fields: id, name, slug, business_type_id, business_type_name,
#    explore_category, archetype, avatar_url, cover_url, location, is_verified
cp assets/api/pages/page_restaurant.json assets/api/pages/page_newbiz.json
# Edit page_newbiz.json with your page data

# 2. (If new business TYPE) Create items/dashboard fixtures:
#    assets/api/products/items_{business_type_id}.json
#    assets/api/business/items_{business_type_id}.json
#    assets/api/business/dashboard/{business_type_id}.json

# 3. Regenerate derived files
dart run tool/generate_fixtures.dart

# 4. If owned by a demo account, update the user fixture's pages array
```

This generates `pages_list.json` (explore/search), `generated/manifest.json` (page routing), and `categories.json` (explore categories). Empty categories are auto-hidden.

### Theme System

Material 3 theme in `core/theme/`:
- `AppColors` — primary blue (#1A73E8), semantic colors, light/dark variants
- `AppTypography` — Material 3 text scale
- `AppSpacing` — padding/margin constants
- `AppRadius` — border radius constants
- `AppShadows` — elevation shadows
- `FeedColors` — ThemeExtension for feed-specific styling

## Key Conventions

### RTL-First (Arabic Primary)

- Template ARB file is `app_ar.arb` (Arabic is source language)
- Use `EdgeInsetsDirectional` not `EdgeInsets`
- Action button rows: `textDirection: TextDirection.ltr` to keep Cancel left, Confirm right
- `import 'package:intl/intl.dart' hide TextDirection;` to avoid shadowing

### Money

`shared/entities/money.dart` — integer piasters (JOD cents) internally. `Money.fromCents()`, `money.format()`, arithmetic operators. Never use `double` for money.

### Config-Driven UI

Never hardcode interaction labels. All behavior flows from business type config → archetype:
- "Order" vs "Booking" vs "Quote" comes from `config.orderLabels`
- Dashboard sections come from `config.dashboard.sections`
- Features checked via `config.features.contains('...')`

### Mock Data Conventions

- Prices: integer piasters (`250` = 2.50 JOD)
- Timestamps: Unix epoch seconds (integer)
- IDs: prefixed strings (`usr_`, `pg_`, `prd_`, `ord_`, `pst_`)
- Use real Amman neighborhoods, realistic JOD prices, Arabic business names
- Images: deterministic picsum.photos URLs

### Code Generation

Generated files excluded from analysis (`analysis_options.yaml`):
- `*.g.dart` — JSON serialization
- `*.freezed.dart` — freezed classes

Lint rule: `prefer_single_quotes: true`

### File Size Limits

~300 lines for widgets, ~500 for pages/providers. Split by area when approaching.

## Visual Reference

Figma prototype at `../app-figma/` — read React components there for layout/spacing/color reference, then build Flutter equivalents. Key paths:
- `app-figma/src/app/config/` — business type configs to port to Dart
- `app-figma/src/api/pages/pages.json` — 51 demo pages to port to fixtures
- `app-figma/src/app/components/business/sections/` — 8 archetype section UIs
