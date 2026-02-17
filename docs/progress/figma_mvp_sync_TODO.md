# Figma MVP Sync TODO (app-figma -> mobile)

## Source Baseline
- Demo repo: `/Users/omar/Documents/projects/super-app-jo/app-figma`
- Pulled to: `main` at commit `8fe67d9` (from `ff9c69c`)
- Flutter app target: `/Users/omar/Documents/projects/super-app-jo/mobile`

## Objective
Bring Flutter parity with latest MVP/demo behaviors and visuals, while strictly reusing existing app primitives and avoiding local duplicates.

## Non-Negotiable Engineering Rules
- Use shared wrappers only: `AppScreen`, `AppTopBar`, `showAppSheet`, `showAppDialog`, `showAppPopup`, shared `Button`.
- No feature-level raw Material APIs for sheets/dialogs/buttons.
- Keep one source of truth for chat message rendering contracts (message type -> card widget).
- No duplicated card chrome/layout code; create one shared chat card frame if needed.

## Delta Summary (from app-figma commit)
- Chat surface expanded significantly:
  - New cards/actions in demo: `send_update`, `send_portfolio`, `send_location`, `send_receipt`.
  - New chat modules: `ChatMessages`, `ChatOrderFlow`, `EditHistorySheet`, `useChatSelection`, `useChatSend`.
  - Power chat action map updated per archetype.
- API fixtures split/restructured in demo:
  - `messages.json` removed, per-business/per-customer message fixture files added.

## Gap Analysis vs mobile (current)
1. `PowerChatMenu` in mobile exposes only:
   - `send_product`, `send_availability`, `ask_info`, `send_quote`.
2. Message type rendering in mobile chat does not include:
   - `update_card`, `portfolio_card`, `location_card`, `receipt_card`.
3. Domain metadata models in mobile (`power_chat_types.dart`) missing parsers for the new card payloads.
4. Chat screen architecture in mobile is still partially monolithic vs demo split pattern.
5. Fixture parity is partial; mobile has many chat fixtures, but not aligned to demo’s latest segmented sources and new card message examples.

## Implementation Plan (No-Duplicate Path)

### Phase A - Chat Contract Foundation
- [ ] Extend message contract:
  - Add new `MessageType` mappings for `update_card`, `portfolio_card`, `location_card`, `receipt_card`.
  - Update parser + serialization handling in chat entities.
- [ ] Extend `power_chat_types.dart`:
  - Add read models for update/location/portfolio/receipt payloads.
  - Keep backward-compatible parsing for existing metadata formats.

### Phase B - Reusable Chat Card Primitives
- [ ] Create shared card frame for action cards (single reusable container):
  - Header, status chip, body slots, footer actions.
  - Theme + RTL-aware spacing via shared tokens.
- [ ] Build the 4 missing card widgets on top of shared frame:
  - `UpdateCardMessage`
  - `PortfolioCardMessage`
  - `LocationCardMessage`
  - `ReceiptCardMessage`

### Phase C - Power Chat Menu Parity
- [ ] Expand archetype action map to include Tier-2 actions where applicable.
- [ ] Wire menu callbacks in chat detail actions.
- [ ] Add sheet/template flows for action input:
  - update composer
  - location sender
  - receipt builder
  - portfolio picker

### Phase D - Chat Screen Refactor (Structure)
- [ ] Split detail chat flow into composable modules similar to demo:
  - message list module
  - selection state module
  - send pipeline module
- [ ] Keep state in providers/controllers; avoid widget-local duplicated logic.
- [ ] Keep existing shared overlay contracts (`showAppSheet`, `showAppDialog`).

### Phase E - Fixture/Data Parity
- [ ] Align fixture structure for new message types and archetype scenarios.
- [ ] Add at least one fixture conversation per new card type.
- [ ] Ensure both customer-mode and business-mode rendering paths covered.

### Phase F - Pixel-Perfect Pass
- [ ] Visual parity pass against `app-figma` for:
  - card spacing
  - icon sizing
  - typography hierarchy
  - badge/status placement
  - bottom sheet heights and action placements
- [ ] RTL/LTR parity checks for all new cards and action sheets.

## Test/Guardrail Requirements
- [ ] Add widget tests for each new card widget (basic render + status variants).
- [ ] Add action-order and direction tests for new action sheets/dialogs.
- [ ] Update golden coverage with at least:
  - location card
  - receipt card
  - update card
  - portfolio card
- [ ] Keep `./scripts/check_ui_contract.sh --strict` at 0 violations.
- [ ] Keep `./scripts/rtl_foundation_preflight.sh` passing.

## Definition of Done
- New demo chat actions are available and functional in Flutter.
- New chat card types render correctly in both business and customer contexts.
- No duplicate local button/sheet/dialog implementations introduced.
- Visual parity approved by side-by-side check with app-figma screens.
