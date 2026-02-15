# S04 — Reorder Section on Home Feed

> **Size:** Small (3-4 files, ~2 hours)
> **Priority:** P1
> **Figma reference:** `app-figma/src/app/components/feed/ReorderSection.tsx`

---

## What This Is

A horizontal scrollable strip on the home feed showing the customer's recent completed orders with a quick "reorder" action. Appears for logged-in customers who have past orders.

## Why It Matters

Reorder is the #1 driver of repeat usage for catalog/menu businesses (water delivery, restaurants, cafes). Making it one tap from the home feed reduces friction.

## Current State in Flutter

**Already working:**
- `guest_welcome_banner.dart` — shows welcome banner for guests with "Explore" + "Create Account" CTAs. Rendered in `home_page.dart` when `authState is AuthGuest`. This is the "guest journey" equivalent — already done.
- `orders_page.dart` — full orders page with 4 tabs (Active, Upcoming, History, Subscriptions), search, filtering by status
- `CustomerRequest` entity in `lib/features/requests/domain/entities/customer_request.dart` — has type, status, items, timeline. Types: order, booking, quote, inquiry, reservation.
- Home page layout: Stories → Guest Banner → Quick Categories → Promo Carousel → Posts → Nearby Pages → More Posts

**What's missing:**
- No "recently ordered" section in the home feed
- No reorder button/action anywhere
- No `reorder` or `quickReorder` field on the entity
- No home widget for recent orders

## Requirements

### 1. Reorder Section Widget

Create `lib/features/home/presentation/widgets/reorder_section.dart`:

Position: after stories bar + guest banner, before quick categories (only for authenticated users with completed orders).

- Horizontal scrollable list of last 3-5 completed orders (type = `order` or `booking`, status = `completed` or `delivered`)
- Each card shows:
  - Business avatar (40x40 circle)
  - Business name (single line, truncated)
  - Order summary: first item name + total item count (e.g., "مياه + 3 عناصر")
  - Relative date ("قبل 3 أيام")
  - Total price
  - "إعادة الطلب" (Reorder) action button
- Card width: ~200px, height: compact
- If no completed orders, this section is hidden entirely (no empty state)

### 2. Reorder Action

Tapping the reorder button:
- Navigate to the business page detail (`Routes.pagePath(handle)`)
- Future enhancement: pre-fill the request sheet with the same items (not required for MVP, just navigate to the page)

Tapping the card body (not the button):
- Navigate to the order detail page

### 3. Data Source

Use existing `customerRequestsProvider` filtered for:
- Status: `completed` or `delivered`
- Type: `order` (catalog orders) — these are the ones that make sense to reorder
- Limit to 5 most recent
- If no matching requests, return empty list and hide the section

### 4. Home Page Integration

In `home_page.dart`, add the reorder section to the `CustomScrollView` slivers:
- After the guest banner / quick categories area
- Before the feed posts
- Wrapped in visibility check: only show when authenticated AND has completed orders

## Files to Create

1. `lib/features/home/presentation/widgets/reorder_section.dart` — the horizontal strip widget

## Files to Modify

1. `lib/features/home/presentation/pages/home_page.dart` — add reorder section to sliver list

## Acceptance Criteria

- [ ] Reorder section appears on home feed for authenticated users with past completed orders
- [ ] Cards show business avatar, name, order summary, date, price
- [ ] Tap card → order detail page
- [ ] Tap reorder → business page detail
- [ ] Section hidden when no completed orders or when guest
- [ ] Scrollable horizontally with 3-5 cards

## Patterns to Follow

- Same horizontal scroll pattern as `stories_bar.dart` or `promo_banner_carousel.dart`
- Use `SizedBox(height: X)` for section spacing, matching other home feed sections
- Use `EdgeInsetsDirectional` for RTL support
- Fetch from existing providers — don't create new API calls
- Arabic labels from `app_ar.arb` localization
- Money display via `Money` class
