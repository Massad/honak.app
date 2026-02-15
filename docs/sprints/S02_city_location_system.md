# S02 — City / Location Detection System

> **Size:** Large (10-15 files, ~8-10 hours)
> **Priority:** P2 (defer to after MVP core)
> **Figma reference:** `app-figma/src/app/components/location/` — CityBar.tsx, CityDetection.tsx, CityPickerSheet.tsx, CoverageBanner.tsx, OutsideCoverageSheet.tsx, ProactiveSuggestionCard.tsx, TravelingCard.tsx

---

## What This Is

A city-aware location system that:
1. Detects the user's current city (Amman, Irbid, Aqaba, etc.)
2. Shows a city bar at the top of explore/home indicating current context
3. Filters content by city — pages, posts, explore results
4. Handles edge cases: outside coverage areas, traveling between cities, manual city selection

## Why It Matters

Jordan has distinct local markets. A customer in Irbid doesn't need to see Amman businesses cluttering their feed. City-awareness makes discovery relevant and prevents the "everything everywhere" problem that kills local apps.

## Why P2 (Defer)

- Phase 1 uses mock data with all businesses in Amman — no real multi-city scenario yet
- Needs backend support for location-based queries (Phase 2)
- GPS permissions add friction to onboarding
- Can be added post-MVP without breaking changes

## Current State in Flutter

- Pages have `location` data in fixtures (neighborhood, coordinates)
- No city detection, no city picker, no location filtering
- No coverage zone awareness

## Requirements (When Ready)

### 1. City Detection
- On app launch, detect city from device GPS (with permission)
- Fall back to manual selection if GPS denied
- Persist selected city in storage

### 2. City Bar
- Thin bar below app bar showing current city name
- Tap to open city picker sheet
- Animate on city change

### 3. City Picker Sheet
- List of supported cities with search
- "Use my location" option at top
- Show city with region grouping (North, Central, South)

### 4. Coverage Banner
- Show when user is outside all coverage zones
- Friendly message: "We're not in your area yet, but here's what's nearby"

### 5. Content Filtering
- Home feed filtered by city
- Explore results filtered by city
- Page detail shows distance from user

### 6. Traveling Card
- When user's city changes (GPS detects movement), show a contextual card
- "Looks like you're in Aqaba! Here are popular pages here."

## Patterns to Follow

- Location provider in `lib/shared/providers/`
- City data as a simple enum + JSON fixture (not a complex entity)
- Use `geolocator` package for GPS
- Permission flow follows platform conventions (iOS/Android)

## Deferred — Do Not Start Until

- [ ] Phase 2 backend provides location-based API
- [ ] Multi-city fixture data exists
- [ ] MVP core features are complete and stable
