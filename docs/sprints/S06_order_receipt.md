# S06 — Add Receipt to Order Management Terminal States

> **Size:** Tiny (1-2 files, ~30 minutes)
> **Priority:** P0
> **Figma reference:** `app-figma/SESSION_CHANGES.md` §5

---

## What This Is

When a business order reaches a terminal state (completed, delivered, declined), the business should be able to send a receipt to the customer. Currently, terminal states show only a green/red badge with no action buttons.

## Why It Matters

Receipts are most useful AFTER service completion. The dropoff feature already has this — order management should be consistent.

## Current State in Flutter

**Already working:**
- `ReceiptSheet` exists at `lib/shared/widgets/receipt_sheet.dart` — fully functional, accepts `businessName`, `customerName`, `referenceNumber`, `items` (list of `ReceiptLineItem`), `totalCents`, `paymentMethod`, `statusLabel`, `date`, `time`, `notes`
- **Dropoff terminal states already show receipt** — `_buildTerminalBottomBar()` in `dropoff_detail_view.dart` shows "إرسال إيصال" (Send Receipt) + "محادثة" (Chat) for delivered/cancelled tickets

**What's missing:**
- `lib/features/business/order_management/presentation/widgets/request_actions.dart` — terminal statuses (`completed`, `delivered`) render `_buildCompletedBadge()` (green badge only, no action buttons). `declined` renders `_buildDeclinedBadge()` (red badge only).
- No receipt button, no receipt data mapping, no bottom bar for terminal states in order management

## Requirements

### 1. Add Receipt Button to Completed/Delivered Orders

In the order detail or request actions widget, when status is `completed` or `delivered`:
- Show "إرسال إيصال" (Send Receipt) button — primary style
- Optionally show "محادثة" (Chat) button alongside — secondary style
- Follow the same layout pattern as dropoff's `_buildTerminalBottomBar()`

### 2. Map Order Data to ReceiptSheet

Call `showReceiptSheet()` with:
- `businessName` from the business page
- `customerName` and `customerPhone` from the request
- `referenceNumber` from the order/request ID
- `items` mapped from request line items → `ReceiptLineItem`
- `totalCents` from the order total
- `paymentMethod`, `date`, `time`, `notes` as available

## Files to Touch

1. `lib/features/business/order_management/presentation/widgets/request_actions.dart` — add receipt button for terminal statuses
2. Possibly the order detail page if the receipt needs to open from there too

## Acceptance Criteria

- [ ] Completed and delivered orders show a "Send Receipt" button
- [ ] Tapping it opens `ReceiptSheet` with correct order data
- [ ] Declined orders remain badge-only (no receipt for declined)
- [ ] Active orders remain unchanged

## Patterns to Follow

- Copy the exact pattern from `dropoff_detail_view.dart` lines 1087-1305 — terminal bottom bar + `_showReceipt()` method
- Use existing `showReceiptSheet()` function from `lib/shared/widgets/receipt_sheet.dart`
- Use existing `ReceiptLineItem` class — no new entities needed
