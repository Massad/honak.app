# S11 — Reservation Lifecycle: Guest Journey + Deposit Tracking + Property Condition

> **Size:** Large (~10-12 files, ~6-8 hours)
> **Priority:** P1
> **Figma reference:** `app-figma/src/app/components/orders/GuestJourneyCard.tsx` (420 lines), `app-figma/src/app/components/orders/ReservationManagementSection.tsx` (294 lines), `app-figma/src/app/components/business-mode/DepositTracker.tsx` (448 lines), `app-figma/src/app/components/business-mode/PropertyConditionRecorder.tsx` (618 lines)

---

## What This Is

A complete reservation lifecycle feature for villa rentals and event venues. Replaces the generic "pending → accepted → completed" flow with a rich booking journey: confirmation → deposit → pre-arrival → check-in → checkout. Includes deposit payment tracking, property condition documentation, and an order terms snapshot.

## Why It Matters

Reservations are fundamentally different from orders/bookings. A villa rental involves:
- **Deposit tracking** — business needs to record partial payments (cash, CliQ, bank transfer)
- **Property condition** — before/after documentation to protect both parties
- **Guest journey** — multi-day lifecycle with reminders and check-in/out milestones
- **Terms snapshot** — locked-in pricing and cancellation policy at booking time

Khaled's demo account has 2 reservation pages (villa_rental + event_venue) that currently show generic order handling. This sprint gives them proper reservation lifecycle UI.

## Current State in Flutter (VERIFIED)

### What Already Exists

**BizRequest Entity** (`biz_request.dart`):
- Has `type` field ('order', 'booking', 'quote', 'inquiry', 'reservation')
- Has reservation-relevant fields: `dateRange`, `guestCount`, `serviceLocation`
- Complete @freezed entity with JSON serialization

**Order Management** (`lib/features/business/order_management/`):
- `detail_page.dart` — request detail (being enhanced in parallel S10 with tabs)
- `request_detail_sections.dart` — reusable section widgets
- `request_actions.dart` — status-based action buttons
- All handle reservation type generically (same as orders)

**Business Type Registry**:
- `villa_rental` → archetype: `reservation`
- `event_venue` → archetype: `reservation`
- Both registered with full configs

**Mock Fixtures**:
- `page_villa_rental.json` exists (Khaled's villa)
- `page_event_venue.json` exists (Khaled's event venue)
- Generic request fixtures exist but have no deposit/journey/inspection data

### What's Missing (THE ACTUAL GAP)

- No reservation lifecycle entities (JourneyStage, DepositLedger, PropertyInspection, etc.)
- No GuestJourneyCard widget (reservation-specific timeline)
- No DepositTracker widget (payment recording with methods)
- No PropertyConditionRecorder widget (check-in/out photos, damage reports, inventory)
- No ReservationManagementSection wrapper widget
- No OrderSnapshotDisplay (locked-in terms at booking time)
- No reservation-specific mock fixture data

## Requirements

### Part A: Domain Entities

#### 1. Reservation Lifecycle Entities

Create `lib/features/business/order_management/domain/entities/reservation_lifecycle.dart`:

**JourneyStage** — plain Dart class:
- `id` (String): 'confirmed', 'deposit', 'pre_arrival', 'checked_in', 'checkout_reminder', 'checked_out'
- `label` (String): Arabic stage name
- `icon` (IconData): Material icon for the stage
- `color` (Color): stage color
- `bgColor` (Color): stage background color
- `statusTrigger` (String): which request status activates this stage

**JourneyNotificationTemplate** — plain Dart class:
- `title` (String)
- `message` (String)
- `includeMap` (bool)
- `includeNearby` (bool)

**6 predefined stages** (as a const list):
1. **confirmed** — "تأكيد الحجز", Check icon, green, triggers on 'accepted'
2. **deposit** — "استلام العربون", Banknote icon, amber, triggers on 'deposit_received'
3. **pre_arrival** — "تذكير قبل الوصول", Bell icon, blue, triggers on 'deposit_received' (sent manually)
4. **checked_in** — "تسجيل الوصول", DoorOpen icon, blue, triggers on 'checked_in'
5. **checkout_reminder** — "تذكير بالمغادرة", Clock icon, amber, triggers on 'checked_in' (sent during stay)
6. **checked_out** — "تسجيل المغادرة", Logout icon, gray, triggers on 'completed'

Each stage has a notification template with placeholders for {customer}, {space}, {checkin}, {checkout}.

#### 2. Deposit Entities

Create `lib/features/business/order_management/domain/entities/deposit_ledger.dart`:

**DepositMethod** — enum: cash, cliq, bankTransfer, other

**DepositRecord** — plain Dart class:
- `id` (String)
- `amount` (int, piasters)
- `method` (DepositMethod)
- `methodDetail` (String?, e.g. CliQ alias or bank name)
- `date` (String, ISO 8601)
- `notes` (String?)
- `receiptPhoto` (String?, URL)
- `recordedBy` (String)

**RefundRecord** — plain Dart class:
- `id` (String)
- `amount` (int, piasters)
- `method` (DepositMethod)
- `date` (String, ISO 8601)
- `reason` (String)

**DepositLedger** — plain Dart class:
- `requiredAmount` (int, piasters)
- `totalPrice` (int, piasters)
- `remainingBalance` (int, piasters)
- `deposits` (List<DepositRecord>)
- `refunds` (List<RefundRecord>)
- `status` (String: 'pending', 'partial', 'received', 'refunded', 'partially_refunded')

Helper methods: `totalDeposited`, `totalRefunded`, `netDeposited`, `progressPercent`.

**Method labels map:**
- cash → "كاش"
- cliq → "CliQ"
- bankTransfer → "تحويل بنكي"
- other → "أخرى"

#### 3. Property Inspection Entities

Create `lib/features/business/order_management/domain/entities/property_inspection.dart`:

**ConditionPhoto** — plain Dart class:
- `id` (String)
- `url` (String)
- `area` (String?, e.g. "غرفة المعيشة")
- `timestamp` (String, ISO 8601)

**PropertyConditionRecord** — plain Dart class:
- `photos` (List<ConditionPhoto>)
- `notes` (String)
- `timestamp` (String, ISO 8601)
- `recordedBy` (String)

**DamageSeverity** — enum: minor, moderate, severe

**DamageResolution** — enum: pending, customerPays, coveredByDeposit, waived, disputed

**DamageReport** — plain Dart class:
- `id` (String)
- `description` (String)
- `area` (String)
- `photos` (List<ConditionPhoto>)
- `costEstimate` (int, piasters)
- `severity` (DamageSeverity)
- `resolution` (DamageResolution)
- `reportedAt` (String, ISO 8601)

**InventoryItem** — plain Dart class:
- `id` (String)
- `name` (String)
- `quantity` (int)
- `checkedIn` (bool)
- `checkedOut` (bool)

**PropertyInspection** — plain Dart class:
- `checkIn` (PropertyConditionRecord?)
- `checkOut` (PropertyConditionRecord?)
- `damages` (List<DamageReport>)
- `inventory` (List<InventoryItem>)

**Predefined property areas** (const list):
`غرفة المعيشة`, `المطبخ`, `غرفة النوم`, `الحمام`, `المسبح`, `الحديقة`, `الشرفة`, `المدخل`, `الممرات`, `المرآب`, `منطقة الشواء`, `أخرى`

**Severity labels:** minor → "بسيط", moderate → "متوسط", severe → "شديد"

**Resolution labels:** pending → "بانتظار الحل", customerPays → "يدفع العميل", coveredByDeposit → "مغطى بالعربون", waived → "تم التنازل", disputed → "نزاع"

### Part B: Guest Journey Card Widget

#### 4. GuestJourneyCard

Create `lib/features/business/order_management/presentation/widgets/guest_journey_card.dart`:

A timeline card showing the reservation lifecycle stages. Business view has expand/collapse with notification previews and action buttons. Customer view is read-only.

**Card structure:**
```
White card, rounded-xl, border gray-100, shadow-sm
├── Header: "مراحل الحجز" + subtitle
└── Timeline (vertical):
    ├── Stage 1: confirmed (green check if done)
    ├── Stage 2: deposit (amber if active)
    ├── Stage 3: pre_arrival (blue)
    ├── Stage 4: checked_in (blue)
    ├── Stage 5: checkout_reminder (amber)
    └── Stage 6: checked_out (gray)
```

**Each stage row:**
- Timeline column: 28x28 rounded circle (colored bg + icon if done, gray if future) + vertical connector line
- Content column: stage label + badges ("تم" green if done, "أُرسل" blue if notification sent)
- Business: chevron to expand notification preview

**Expanded section (business only):**
- Gray-50 bg, rounded-lg, p-2.5
- Notification preview text (filled template with customer/space/dates)
- Google Maps link button (if stage includes map)
- Action buttons row: "إرسال إشعار" (blue) + "تأكيد [stage label]" (green, for status-advancing stages)

**Status → Stage mapping** function:
- pending / pending_review → before confirmed (index -1)
- accepted → confirmed (index 0)
- deposit_received → deposit (index 1)
- checked_in → checked_in (index 3)
- completed → checked_out (index 5)

**Props:** request (BizRequest), page (optional, for location), viewMode ('customer' | 'business'), onStatusChange callback, onSendNotification callback

### Part C: Deposit Tracker Widget

#### 5. DepositTracker

Create `lib/features/business/order_management/presentation/widgets/deposit_tracker.dart`:

An expand/collapse card for deposit payment management.

**Collapsed view:**
- Green receipt icon (9x9 container, green-10 bg)
- Title: "العربون والمدفوعات"
- Status badge (pill): مستلم (green), جزئي (amber), بانتظار (gray), مسترد (red)
- Subtitle: "{net} / {required} د.أ عربون · المبلغ الكلي {total} د.أ"

**Expanded view:**
- Progress bar (h-2, rounded-full): green if ≥100%, amber if >0%, gray if 0%
- Summary cards (3-col grid): required / received / remaining
- Deposit records list: method icon + amount + method label + date + recorded_by + receipt photo placeholder
- Refund records list: Undo icon + negative amount + date + reason (red-50 bg)
- Action buttons: "تسجيل دفعة" (green) + "استرداد" (gray, only if deposits > 0)

**Add Deposit form** (inline, shown when button pressed):
- Green-tinted bg with border
- Amount input (number, LTR dir)
- Method selector (4 buttons: كاش, CliQ, تحويل بنكي, أخرى) — active has green bg
- Method detail input (shown for CliQ/bank_transfer: "اسم حساب CliQ" or "اسم البنك")
- Receipt photo upload placeholder (dashed border)
- Notes input
- Save + Cancel buttons

**Add Refund form** (inline):
- Red-tinted bg with border
- Max amount warning
- Amount input + Reason input (required)
- Confirm + Cancel buttons

**readOnly prop** — hides all action buttons and forms (for customer view)

### Part D: Property Condition Recorder

#### 6. PropertyConditionRecorder

Create `lib/features/business/order_management/presentation/widgets/property_condition_recorder.dart`:

4 collapsible sections for property documentation.

**Section 1: Check-in Record** ("حالة العقار — الوصول")
- Blue LogIn icon, blue-50 bg
- If recorded: show photo grid (20x20 thumbnails with area label) + notes + timestamp
- If not recorded: "بدء توثيق الوصول" button (dashed blue border, Camera icon)
- Available when status is deposit_received or confirmed

**Section 2: Check-out Record** ("حالة العقار — المغادرة")
- Orange LogOut icon, orange-10 bg
- Same pattern as check-in
- Available when status is checked_in

**Section 3: Damage Reports** ("تقارير الأضرار")
- Red AlertTriangle icon, red-50 bg
- Damage count badge
- Each damage: description + area + severity pill (minor amber, moderate amber, severe red) + cost estimate + resolution status
- Add damage form: description textarea + area picker (12 predefined areas as chips) + severity selector (3 buttons) + cost input + photo upload placeholder

**Section 4: Inventory Checklist** ("قائمة الجرد")
- Purple ClipboardCheck icon, purple-50 bg
- Checklist items with checkboxes (check-in and check-out phases)
- Add item input with quantity

**ConditionSection** — reusable wrapper with title, subtitle, icon, expand/collapse, badge.

### Part E: Reservation Management Section + Snapshot

#### 7. ReservationManagementSection

Create `lib/features/business/order_management/presentation/widgets/reservation_management_section.dart`:

Wrapper that combines deposit tracker + property condition + order snapshot.

```dart
Column(
  children: [
    if (ledger.requiredAmount > 0) DepositTracker(...),
    if (isBusiness) PropertyConditionRecorder(...),
    if (snapshot != null) OrderSnapshotDisplay(...),
  ],
)
```

#### 8. OrderSnapshotDisplay

Create `lib/features/business/order_management/presentation/widgets/order_snapshot_display.dart`:

An expand/collapse card showing the locked-in booking terms.

**Collapsed:**
- Purple Lock icon, purple-50 bg
- Title: "شروط الحجز المثبّتة" + "مرجع" badge
- Subtitle: capture date

**Expanded:**
- Info banner (purple): "هذه نسخة مثبّتة من شروط الحجز..."
- Price snapshot: base price per night, total nights, cleaning fee, discount, total, deposit required
- Cancellation policy snapshot: late cancel message + fee type (keep_deposit, percentage, fixed)
- House rules snapshot: bullet list
- Safety disclaimers: typed icons (safety/responsibility/policy/custom) with acknowledgement status
- Customer question answers: Q&A pairs
- Payment methods at booking time: pill badges

### Part F: Mock Data

#### 9. Reservation Mock Data

Create `lib/features/business/order_management/data/reservation_mock_data.dart`:

Generate mock data for reservation requests (villa_rental type):

**Mock deposit ledger:**
- Required: 150 JOD (15000 piasters), total: 400 JOD
- 2 deposits: 100 JOD cash + 50 JOD CliQ
- Status: 'received'

**Mock property inspection:**
- Check-in: 3 mock photos (living room, kitchen, pool), timestamped
- No check-out yet, no damages, 5 inventory items (مناشف, مفاتيح, ريموت التكييف, أدوات المطبخ, مفتاح المسبح)

**Mock order snapshot:**
- Price: 80 JOD/night × 5 nights = 400 JOD, cleaning 20 JOD, discount 20 JOD (عرض الموسم)
- Deposit required: 150 JOD
- Cancellation: "الإلغاء مجاني حتى 48 ساعة قبل الوصول" + keep_deposit for late cancel
- House rules: ["ممنوع التدخين داخل الفيلا", "ممنوع الحيوانات الأليفة", "هدوء بعد الساعة 11 مساءً", "الحد الأقصى 8 أشخاص"]
- 2 disclaimers: safety ("المسبح بدون حارس") + responsibility ("الضيف مسؤول عن أي أضرار")

**Nearby places** (Dead Sea mock data):
- منتجع وسبا البحر الميت (سبا, ١.٢ كم)
- مطعم البحيرة (مطعم, ٨٠٠ م)
- سوبرماركت الشاطئ (بقالة, ٥٠٠ م)
- الشاطئ العام (ترفيه, ٣٠٠ م)
- صيدلية الأمل (صيدلية, ١.٥ كم)

## Files to Create

1. `lib/features/business/order_management/domain/entities/reservation_lifecycle.dart`
2. `lib/features/business/order_management/domain/entities/deposit_ledger.dart`
3. `lib/features/business/order_management/domain/entities/property_inspection.dart`
4. `lib/features/business/order_management/presentation/widgets/guest_journey_card.dart`
5. `lib/features/business/order_management/presentation/widgets/deposit_tracker.dart`
6. `lib/features/business/order_management/presentation/widgets/property_condition_recorder.dart`
7. `lib/features/business/order_management/presentation/widgets/reservation_management_section.dart`
8. `lib/features/business/order_management/presentation/widgets/order_snapshot_display.dart`
9. `lib/features/business/order_management/data/reservation_mock_data.dart`

## Files to Modify

NONE — all widgets are standalone. Integration into the detail page will happen separately after this sprint and S10 (which adds tabs to the detail page) are both validated.

## DO NOT Modify

- `detail_page.dart` — being modified by S10 in parallel
- `biz_request.dart` — keep existing entity as-is
- `request_detail_sections.dart` — keep as-is
- `request_actions.dart` — keep as-is
- Any shared activity log files

## Testing

Since these are standalone widgets, create a simple test harness:

**Option A — Direct testing via import:**
After S10 finishes (adds tabs), add reservation widgets to the detail page's Summary tab:
```dart
if (_request.type == 'reservation') ...[
  GuestJourneyCard(request: _request, viewMode: 'business', ...),
  ReservationManagementSection(request: _request, viewMode: 'business', ...),
],
```

**Option B — Verify via analyzer:**
- Ensure all files compile cleanly
- Verify imports are correct
- Check that entities have proper constructors and helper methods

**Demo accounts for eventual integration testing:**
- **Khaled** (0790000030/111111) → switch to business → select "villa_rental" page → Requests tab → tap reservation request
- GuestJourneyCard should show timeline with stages
- Deposit tracker should show payment progress
- Property condition should show check-in/out recording
- Order snapshot should show locked-in terms

## Acceptance Criteria

- [ ] JourneyStage entity with 6 predefined stages created
- [ ] Notification templates with Arabic text and placeholders
- [ ] DepositLedger entity with records, refunds, and helper methods
- [ ] PropertyInspection entity with photos, damages, inventory
- [ ] GuestJourneyCard renders timeline with colored stages
- [ ] GuestJourneyCard: business view can expand stages for notifications
- [ ] GuestJourneyCard: done/current/future stages styled differently
- [ ] DepositTracker: collapsed shows progress summary
- [ ] DepositTracker: expanded shows records, refunds, summary cards, progress bar
- [ ] DepositTracker: add deposit form with method selection
- [ ] DepositTracker: add refund form with max amount validation
- [ ] PropertyConditionRecorder: 4 collapsible sections
- [ ] PropertyConditionRecorder: check-in/out start recording buttons
- [ ] PropertyConditionRecorder: damage report form with area picker and severity
- [ ] PropertyConditionRecorder: inventory checklist with add/toggle/remove
- [ ] OrderSnapshotDisplay: price breakdown, cancellation policy, house rules, disclaimers
- [ ] ReservationManagementSection: combines deposit + condition + snapshot
- [ ] Mock data created with realistic Arabic villa rental scenario
- [ ] All entities use piasters for money (int), not doubles
- [ ] `flutter analyze` passes
- [ ] App compiles without errors

## Patterns to Follow

- Entities: plain Dart classes (read-only view models, no freezed needed since no JSON deserialization for mock)
- Money: integer piasters via `Money` class — display with `Money(cents).toFormattedArabic()`
- RTL: `EdgeInsetsDirectional`, Arabic labels
- Colors: `AppColors.primary` (#1A73E8), `AppColors.success` (#43A047), `AppColors.warning` (#FF9800), `AppColors.error` (#E53935)
- Expand/collapse: manage with `useState`-like local state
- Card style: white bg, rounded-xl, border gray-100, shadow-sm
- Section header: 36x36 icon container (colored bg) + title (sm, gray-900) + subtitle (10px, gray-400) + chevron
- Forms: colored tint bg, dashed border for photo uploads, action buttons at bottom
