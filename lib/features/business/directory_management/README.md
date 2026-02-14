# Directory Management — Shared Foundation

## Domain Entities (`domain/entities/`)

### `tenant.dart`
- **`Tenant`** — @freezed entity
  - Fields: `id`, `name`, `nameEn`, `category`, `floorId`, `unit`, `isOpen`, `temporarilyClosed`, `pageId`, `logoUrl`, `tags`, `linkedAt`, `invitedAt`
  - Computed: `status` getter derives `TenantStatus` from `pageId`/`linkedAt`/`invitedAt`
  - Import: `package:honak/features/business/directory_management/domain/entities/tenant.dart`

### `tenant_status.dart`
- **`TenantStatus`** — enum: `claimed`, `newTenant`, `invited`, `unclaimed`
  - Extensions: `label` (Arabic), `color`, `icon`
  - Import: `package:honak/features/business/directory_management/domain/entities/tenant_status.dart`

### `directory_floor.dart`
- **`DirectoryFloor`** — @freezed: `id`, `name`, `label`, `tenantCount`
  - Import: `package:honak/features/business/directory_management/domain/entities/directory_floor.dart`

### `directory_manage_stats.dart`
- **`DirectoryManageStats`** — @freezed: `total`, `claimed`, `invited`, `unclaimed`, `newThisWeek`
  - Import: `package:honak/features/business/directory_management/domain/entities/directory_manage_stats.dart`

### `directory_manage_data.dart`
- **`DirectoryManageData`** — @freezed: `tenants`, `floors`, `categories`, `amenities`, `featuredTenantIds`, `stats`
  - Import: `package:honak/features/business/directory_management/domain/entities/directory_manage_data.dart`

## Data Layer (`data/`)

### `directory_repository.dart`
- **`DirectoryRepository`** — takes `ApiClient`, provides:
  - `getDirectoryManageData(pageId)` → `DirectoryManageData`
  - `addTenant(pageId, data)` → `Tenant`
  - `updateTenant(pageId, tenantId, data)` → `Tenant`
  - `deleteTenant(pageId, tenantId)`
  - `sendInvite(pageId, tenantId, targetPageId)`
  - `unlinkTenant(pageId, tenantId)`
  - `updateFloors(pageId, floors)`
  - `updateCategories(pageId, categories)`
  - `updateAmenities(pageId, amenities)`
  - `updateFeatured(pageId, tenantIds)`
- Import: `package:honak/features/business/directory_management/data/directory_repository.dart`

## Providers (`presentation/providers/`)

### `directory_manage_provider.dart`
- **`directoryRepositoryProvider`** — `Provider<DirectoryRepository>`
- **`directoryManageDataProvider`** — `FutureProvider.family<DirectoryManageData, String>` (keyed by pageId)
- Import: `package:honak/features/business/directory_management/presentation/providers/directory_manage_provider.dart`

## Shared Widgets (`presentation/widgets/shared/`)

### `tenant_card.dart`
- **`TenantCard`** — Customer-facing: logo, name, unit + category, open/closed badge, chevron if navigable, 60% opacity if no pageId. Supports `compact` variant.

### `tenant_manage_card.dart`
- **`TenantManageCard`** — Business-facing with 4 states: status dot, badge (new/invited), subtitle with time ago, menu button.

### `tenant_coverage_bar.dart`
- **`TenantCoverageBar`** — Segmented progress bar (green=claimed, orange=invited), percentage, legend dots, "X من Y وحدة" label.

## Mock Fixtures (`assets/api/business/directory/`)

- **`city-mall.json`** — 26 tenants, 4 floors, stats: 23 claimed / 1 invited / 2 unclaimed / 2 new this week
- **`shmeisani-center.json`** — 10 tenants, 2 floors, stats: 8 claimed / 1 invited / 1 unclaimed

API path convention: `/v1/biz/pages/{pageId}/directory`

## Other Changes

- **`pubspec.yaml`** — Added `assets/api/business/directory/` to flutter assets
