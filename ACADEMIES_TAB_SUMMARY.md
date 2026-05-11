# Academies Tab - Quick Summary

## What is it?
A main navigation tab that allows users to discover and browse football academies with filtering capabilities.

## Key Features
1. **Search & Filter**: Filter academies by country and category (Cat 1-5)
2. **Academy Cards**: Display academy logo, name, category, and city
3. **Infinite Scroll**: Load more academies as user scrolls
4. **Navigation**: Tap "VIEW" to see academy details

## API
**Endpoint**: `getAcademyList`
**Parameters**:
- userId (required)
- country (optional)
- confed (optional)
- category (optional)
- start (pagination)
- limit (10 per page)

## UI Components
1. Description text about SocaLoca academies
2. Country dropdown (searchable)
3. Category dropdown (Cat 1-5)
4. GO button (triggers search)
5. Academy cards list (vertical scroll)
6. Empty state ("No academies found")

## Academy Card Layout
```
┌─────────────────────────────────┐
│ ⭕ Logo  Elite Academy          │
│          CATEGORY 1             │
│          Mumbai                 │
│          [VIEW]                 │
└─────────────────────────────────┘
```

## Data Flow
1. Load with user's country as default
2. User selects filters
3. Click GO button
4. Display results (sorted by name)
5. Scroll to load more (10 at a time)

## Implementation Files Needed
- `lib/features/academies/data/models/academy_model.dart`
- `lib/features/academies/data/repositories/academies_repository.dart`
- `lib/features/academies/providers/academies_provider.dart`
- `lib/features/academies/screens/academies_screen.dart`
- `lib/features/academies/widgets/academy_card.dart`

## Styling
- **Colors**: Black, Yellow (SocaLoca brand), White, Light Grey
- **Fonts**: Poppins (Regular, Bold)
- **Card**: White background, 10dp radius, 4dp elevation
- **Logo**: 80x80dp circular
- **Button**: Black background, yellow text

## Ready to Implement?
✅ Full specification document created: `ACADEMIES_TAB_SPECIFICATION.md`
✅ API endpoint already exists in Flutter app
✅ All Android code analyzed
✅ UI design documented with measurements

**Awaiting permission to proceed with Flutter implementation.**
