# S07 — Extract Shared Status Picker & Card Parts from Queue/Dropoff

> **Size:** Medium (4-6 files, ~3 hours)
> **Priority:** P1
> **Figma reference:** `app-figma/SESSION_CHANGES.md` §10

---

## What This Is

Queue and dropoff systems have duplicated UI patterns for status pickers, action icon/color mappings, and card sub-components (photo buttons, status badges). This sprint extracts the duplicated parts into shared components.

## Why It Matters

- Adding a 3rd service type (e.g., delivery jobs, repairs) would require copying the same patterns a third time
- Bug fixes currently need to be applied in two places
- Aligns with the Figma prototype's shared component architecture

## Current State in Flutter

### Already Shared (DO NOT REDO)
- **Activity log UI rendering** — `lib/features/business/shared/widgets/activity_log.dart` already exists with:
  - `ActivityLogEntry` generic data class
  - `showActivityLogSheet()` full-screen bottom sheet with timeline, date grouping, detail boxes
  - `ActivityLogPreview` compact inline preview
  - Both queue and dropoff already delegate their rendering to this shared widget

### What's Duplicated (EXTRACT THESE)

**1. Action Icon/Color Mapping:**
- Queue: `queue_activity_utils.dart` — `QueueActivityAction` enum (8 actions), `activityActionIcon()`, `activityActionColor()`
- Dropoff: `activity_log_utils.dart` — `TicketActivityAction` enum (9 actions), `activityActionIcon()`, `activityActionColor()`
- Same pattern, different action sets — both map action → icon + color

**2. Status Picker Sheet:**
- Queue: `_StatusPickerSheet` in `queue_entry_card_widgets.dart` — shows current status highlight, forward/backward detection, "تراجع" (backward) badge in orange
- Dropoff: `_StatusPickerSheet` in `dropoff_status_picker.dart` — same structure, plus embedded activity log preview
- Nearly identical UI pattern

**3. Status Configuration:**
- Queue: inline `_StatusConfig` class in `queue_entry_card.dart` — color, icon, label per status
- Dropoff: separate `DropoffStatusConfig` class in `dropoff_status_config.dart` — color, bgColor, borderColor, icon, label, static map
- Dropoff's approach is better (separate file, static map, reusable)

**4. Photo Toggle Buttons:**
- Queue: `_PhotoToggle` in `queue_entry_card_widgets.dart` — before/after photo buttons with active states
- Dropoff: `_buildPhotoButtons()` inline in `dropoff_entry_card.dart` — similar before/after buttons
- Nearly identical UI

### What's NOT Shared (Keep Domain-Specific)
- Activity log generators (`generateQueueActivity` vs `generateMockActivity`) — different mock data logic
- Queue-only widgets: `_SourceBadge`, `_OnTheWayBadge`, `_LiveTimer` — specific to queue flow
- Action enums themselves are domain-specific (different action sets)

## Requirements

### 1. Generic Status Picker Sheet

Create `lib/features/business/shared/widgets/generic_status_picker_sheet.dart`:
- Takes: current status, available statuses list, status label/color/icon functions, status order (for forward/backward detection)
- Shows: current status highlighted, available moves with forward (blue) and backward (orange "تراجع") styling
- Optional: activity log preview section with callback to show full log
- Both queue and dropoff picker widgets become thin wrappers around this

### 2. Shared Status Config Base

Create `lib/features/business/shared/entities/status_config.dart`:
- Abstract `StatusConfig` with: color, bgColor, borderColor, icon, label, nextAction
- Follow dropoff's pattern (separate file, static map) since it's better organized
- Queue's inline `_StatusConfig` migrates to this pattern

### 3. Shared Photo Toggle Widget

Create `lib/features/business/shared/widgets/photo_toggle_button.dart`:
- Takes: label, hasPhoto flag, onTap callback
- Renders dashed border when empty, solid with checkmark when has photo
- Both queue and dropoff use this instead of their inline implementations

### 4. Shared Action Config Pattern

Create `lib/features/business/shared/entities/activity_action_config.dart`:
- `ActivityActionConfig` class with: label, icon, color
- Helper function `buildActivityLogEntry()` that converts domain entries → `ActivityLogEntry` using a config map
- Queue and dropoff define their own config maps but use the shared conversion logic

## Migration Strategy

- Create shared components first
- Wire one feature (dropoff, since it's more cleanly structured) to use shared components
- Then wire queue
- Old inline implementations can be removed once both are migrated

## Files to Create

1. `lib/features/business/shared/widgets/generic_status_picker_sheet.dart`
2. `lib/features/business/shared/widgets/photo_toggle_button.dart`
3. `lib/features/business/shared/entities/status_config.dart`
4. `lib/features/business/shared/entities/activity_action_config.dart`

## Files to Modify

1. `lib/features/business/dropoff/presentation/widgets/dropoff_status_picker.dart` — use shared picker
2. `lib/features/business/dropoff/presentation/widgets/dropoff_entry_card.dart` — use shared photo toggle
3. `lib/features/business/queue/presentation/widgets/queue_entry_card_widgets.dart` — use shared picker + photo toggle
4. `lib/features/business/queue/presentation/widgets/queue_entry_card.dart` — migrate inline `_StatusConfig`

## Acceptance Criteria

- [ ] `GenericStatusPickerSheet` works for both queue and dropoff
- [ ] Photo toggle widget works for both queue and dropoff
- [ ] Shared status config pattern established
- [ ] Shared activity action config pattern established
- [ ] All existing queue and dropoff functionality unchanged (no regressions)
- [ ] Code duplication between queue and dropoff entry cards reduced by ~150 lines

## Patterns to Follow

- Shared business widgets go in `lib/features/business/shared/widgets/`
- Shared business entities go in `lib/features/business/shared/entities/` (or domain/)
- Status enums stay in their respective feature domains
- Generic widgets accept functions for customization (color, label, icon), not hardcoded values
- Follow dropoff's status config structure as the template (better organized than queue's)
