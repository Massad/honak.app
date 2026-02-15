# S10 — Request Detail Enhancement: Tabbed Layout + Activity Log

> **Size:** Medium (~5-7 files, ~4-5 hours)
> **Priority:** P1
> **Figma reference:** `app-figma/src/app/components/orders/OrderDetailPage.tsx` (635 lines), `app-figma/src/app/components/orders/OrderDetailParts.tsx` (361 lines)

---

## What This Is

Enhance the business-side request detail page to match the Figma prototype: add a 2-tab layout (Summary + Activity Log), status context banners, and a modification diff visualization.

## Why It Matters

The request detail page is where business owners spend most of their decision-making time. Currently it's a flat scroll with items, total, and actions. The Figma prototype adds:
1. **Activity Log tab** — timeline of every status change, note, payment for accountability and tracking
2. **Status context banners** — clarify who needs to act next (amber for "waiting for your response", green for "accepted, start executing")
3. **Modification diff** — show what the customer changed when requesting a modification

## Current State in Flutter (VERIFIED)

### What Already Exists

**Request Detail Page** (`lib/features/business/order_management/presentation/pages/detail_page.dart` — 298 lines):
- `RequestDetailPage` — ConsumerStatefulWidget with local state for request
- Actions: accept, decline, suggest alternative, update status, receipt, chat
- Sections: customer header, status badge, items list, total, notes, decline reason
- BUT: flat single-scroll, no tabs, no activity log

**Request Detail Sections** (`request_detail_sections.dart`):
- `RequestCustomerHeader`, `RequestStatusBadge`, `RequestItemsList`, `RequestTotalRow`, `RequestNoteSection`, `RequestDeclineReasonSection`
- `requestStatusLabel()`, `requestStatusColor()` helpers

**Request Actions** (`request_actions.dart`):
- Smart status-based actions (pending → accept/decline, accepted → begin/deliver, terminal → receipt+chat)

**Shared Activity Log Infrastructure** (`lib/features/business/shared/widgets/activity_log.dart` — 683 lines, BATTLE-TESTED):
- `ActivityLogEntry` — generic UI model (id, timestamp, label, icon, color, actorName, actorRole, from, to, note, amount, method)
- `showActivityLogSheet()` — full-screen bottom sheet with date grouping + timeline
- `ActivityLogPreview` — compact last-3-entries rows with "view full log" link
- `_TimelineEntry` — dot + connector + label + time + actor badge + detail box
- Status from/to pills, payment display, note display
- Time formatting: `formatTimeAgo()`, `formatTime()`, `formatDate()`

**Reference Implementations** (both use the shared activity log):
- Dropoff: `dropoff/presentation/widgets/activity_log_utils.dart` — `generateTicketActivity()`
- Queue: `queue/presentation/widgets/queue_activity_utils.dart` — `generateQueueActivity()`
- Truck overlay: `truck_detail_overlay.dart` (lines 950+) — inline activity timeline

**BizRequest Entity** (`biz_request.dart`):
- Has: id, customer, status, type, items, total, note, declineReason, createdAt
- Has archetype fields: preferredDate, timeSlot, description, dateRange, guestCount, serviceLocation
- Does NOT have: timeline array, modification data

### What's Missing

1. No `RequestActivityAction` enum or generation function
2. No tabs on detail page — just a flat ListView
3. No status context banners (who needs to act next)
4. No modification diff visualization
5. No activity log tab

## Requirements

### 1. Request Activity Generation

Create `lib/features/business/order_management/presentation/widgets/request_activity_utils.dart`:

**`RequestActivityAction` enum:**
- `requestCreated` — request submitted
- `statusChanged` — status transition (from → to)
- `noteAdded` — business/customer added a note
- `declineReasonAdded` — business declined with reason
- `paymentMarked` — payment recorded
- `modificationRequested` — customer requested changes
- `alternativeOffered` — business suggested alternative
- `receiptSent` — business sent receipt

**`generateRequestActivity(BizRequest request)` function:**
- Returns `List<ActivityLogEntry>` using the shared model
- Generates deterministic mock activity based on request state:
  - Always: `requestCreated` entry at `request.createdAt`
  - If status != 'pending': `statusChanged` from 'pending' → 'accepted' (appropriate time offset)
  - If status is 'in_progress', 'preparing', 'ready', 'delivered', 'completed': chain of status changes
  - If status is 'declined': `statusChanged` → 'declined' + `declineReasonAdded` entry
  - If `request.note` != null: `noteAdded` entry
- Use staff pool pattern from dropoff/queue (realistic Arabic names: محمد، أحمد، فاطمة)
- Icons + colors: follow the timeline constants from Figma:
  - pending: Clock, amber
  - accepted: CheckCircle, green
  - in_progress: Truck, blue
  - preparing: Package, blue
  - ready: Package, blue
  - delivered: Truck, green
  - completed: CheckCircle, gray
  - declined: Cancel, red

### 2. Tabbed Detail Page

Modify `lib/features/business/order_management/presentation/pages/detail_page.dart`:

Replace the flat `ListView` with a tabbed layout:

```
AppBar (existing)
├── Header (type label + order ID + timestamp)
├── TabBar (2 tabs: الملخص | السجل)
└── TabBarView
    ├── Tab 1: Summary (existing content + status banners)
    └── Tab 2: Activity Log (timeline from shared widgets)
```

**Header** (above tabs):
- Center: type label from TYPE_LABELS map (`طلب شراء | حجز خدمة | طلب معاينة | استفسار | حجز`) + ` #` + request.id
- Below: creation timestamp in gray-400, 10px

**Tab bar styling:**
- 2 equal-width tabs
- Selected: primary blue (#1A73E8) text + blue bottom border (2px)
- Unselected: gray-400 text + transparent bottom border
- Font size: 12px (xs)
- White background, gray-100 bottom border on the bar itself

**Summary tab content** — current body (customer header, message button, status badge, items, total, notes, actions) PLUS new status context banners (see below).

**Activity Log tab** — use the `showActivityLogSheet` pattern but inline (not a sheet). Render the timeline entries directly in a scrollable view. Use the `_TimelineEntry` pattern from the shared activity log. Show "لا يوجد سجل بعد" with Clock icon if empty.

Use `DefaultTabController(length: 2)` wrapping the Scaffold body.

### 3. Status Context Banners

Add to the TOP of the Summary tab, before the customer header:

**Pending (business view):**
- Amber-50 bg, amber-200 border, rounded-xl, px-4 py-2.5
- Clock icon (14px, amber-600) + text
- Line 1: "العميل أرسل طلب — بانتظار ردك" (xs, amber-800)
- Line 2: "يمكنك قبول أو رفض الطلب" (10px, amber-600)

**Accepted (business view):**
- Green-50 bg, green-100 border, rounded-xl, px-4 py-2.5
- CheckCircle icon (14px, #43A047) + text
- "تم قبول الطلب — بانتظار التنفيذ" (xs, green-800)

**Only show banners for actionable statuses** — not for terminal states (completed, delivered, declined).

### 4. Modification Diff Card (Conditional)

Add a modification diff section to the Summary tab (between items and actions):

**Only shown** if request has modification data (add an optional `modification` field to mock data if needed, or create mock data for testing).

**Design:**
- Amber-50 bg, amber-200 border, rounded-xl, p-4, shadow-sm
- Header: Edit3 icon (14px, amber-600) + "طلب تعديل من العميل" (sm, amber-800)
- Actor: User icon (10px, amber-500) + customer name (10px, amber-600)
- Item changes: each in white/60% bg rounded-lg px-3 py-2
  - Item name (xs, gray-800)
  - Per change: field label (gray-400), old value (line-through, red-400), arrow (→), new value (blue)
- Total comparison: original (line-through, gray-400) vs new total (gray-900), diff badge

**For initial implementation**, the modification section can be shown only when mock data includes it — no need to create new entity fields in BizRequest.

## Files to Create

1. `lib/features/business/order_management/presentation/widgets/request_activity_utils.dart`

## Files to Modify

1. `lib/features/business/order_management/presentation/pages/detail_page.dart` — add tabs, banners, activity log tab

## DO NOT Modify

- `request_detail_sections.dart` — keep existing section widgets as-is (reuse them in Summary tab)
- `request_actions.dart` — keep existing actions widget as-is
- `activity_log.dart` — shared infrastructure, don't touch
- Any dropoff/queue files

## Testing

**Demo accounts to verify:**
- **Ahmad** (0790000002/222222) → switch to business → select "water_delivery" → Requests tab → tap any request → should see tabbed detail
- **Sara** (0790000001/111111) → select "salon" → Requests → tap pending request → should see amber context banner
- Tap "السجل" tab → should see timeline with status entries
- Accept a request → switch to السجل tab → should show new "accepted" entry
- Complete a request → verify terminal receipt/chat buttons still work

## Acceptance Criteria

- [ ] Detail page has 2 tabs: الملخص (Summary) and السجل (Activity Log)
- [ ] Tab bar styled with blue selected indicator
- [ ] Summary tab contains all existing content (customer, items, total, notes, actions)
- [ ] Status context banner shows for pending (amber) and accepted (green) statuses
- [ ] Activity Log tab shows timeline of mock entries
- [ ] Timeline entries use shared ActivityLogEntry model
- [ ] Timeline has icons, colors, actor names matching Figma constants
- [ ] Empty state shown when no activity entries ("لا يوجد سجل بعد")
- [ ] generateRequestActivity() creates deterministic entries from request state
- [ ] All existing functionality preserved (accept, decline, alternative, receipt, chat)
- [ ] `flutter analyze` passes
- [ ] App runs without errors

## Patterns to Follow

- Tab pattern: `DefaultTabController` + `TabBar` + `TabBarView` (same as dashboard page)
- Activity entries: plain `ActivityLogEntry` from `shared/widgets/activity_log.dart`
- Mock generation: follow `generateTicketActivity()` pattern from dropoff
- RTL: `EdgeInsetsDirectional`, Arabic labels
- Colors: `AppColors.primary` for blue, `AppColors.success` for green, `AppColors.warning` for amber, `AppColors.error` for red
- Status labels: reuse `requestStatusLabel()` from request_detail_sections.dart
