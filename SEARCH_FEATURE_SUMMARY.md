# Search Feature - Implementation Summary

## Overview
Complete specification for implementing the Search functionality in the Flutter app, based on Android implementation analysis and provided screenshot.

---

## Quick Reference

### API
- **Endpoint**: `advSearch`
- **Method**: POST
- **Pagination**: 25 items per page
- **Response**: List of users with stats

### Request Parameters
```dart
{
  'userId': userId,
  'searchText': searchQuery,
  'country': countryFilter,      // empty for all
  'userType': typeFilter,         // player/coach/manager/referee
  'choice': sortingOption,        // posts/appearance/goals
  'start': pageOffset,
  'limit': 25
}
```

---

## UI Components

### 1. Search Input
- Placeholder: "Player/Coach/Manager/Referee"
- Search icon button on right
- Triggers search on click or Enter key

### 2. Three Filter Dropdowns
1. **By Country** - Searchable dropdown with all countries
2. **By Type** - Player, Coach, Manager, Referee
3. **By Choice** - Most Posts, Most Appearances, Most Goals

### 3. Filter Chips
- Display active filters as removable chips
- Format: `[FilterValue ×]`
- Click × to remove filter

### 4. Search Results
- List of user cards with:
  - Avatar (circular, 60x60)
  - Name (bold)
  - Position/Role
  - Nationality
  - Appearances count
  - Posts count
  - Endorsed by count
  - Followers count

---

## Filter Logic

### Country Filter
- **Options**: "All" + list of countries
- **API**: `country` parameter
- **Behavior**: Empty string for "All"

### Type Filter
- **Options**: Player, Coach, Manager, Referee
- **API**: `userType` parameter (lowercase)
- **Special**: Disables "By Choice" when Referee selected

### Choice Filter (Sorting)
- **Options**: Most Posts, Most Appearances, Most Goals
- **API**: `choice` parameter
  - Most Posts → "posts"
  - Most Appearances → "appearance"
  - Most Goals → "goals"
- **Disabled**: When Referee type selected

---

## Sorting Logic

Results are sorted **client-side** after API response:

```dart
switch (sortType) {
  case 'Most Appearances':
    // Sort by appearance DESC, then name ASC
    break;
  case 'Most Posts':
    // Sort by postCount DESC, then name ASC
    break;
  case 'Most Goals':
    // Sort by goals DESC, then name ASC
    break;
  default:
    // Sort by name ASC
}
```

---

## Navigation

Based on user type flags:
- `isPlayer` → Player Bio Screen
- `isCoach` or `isAdmin` → Coach/Admin Bio Screen
- `isReferee` → Referee Bio Screen

---

## Key Features

✅ Text search with query  
✅ Empty search (show all users)  
✅ Country filter (searchable dropdown)  
✅ Type filter (Player/Coach/Manager/Referee)  
✅ Sorting filter (Posts/Appearances/Goals)  
✅ Filter chips (removable)  
✅ Infinite scroll (25 items per page)  
✅ Client-side sorting  
✅ Type-based navigation  
✅ Empty state ("No searches")  
✅ Loading states  

---

## Implementation Checklist

### Data Layer
- [ ] Create `SearchUserModel` with freezed
- [ ] Create `SearchFilterModel` for filter state
- [ ] Create `SearchRepository` with `advSearch` method
- [ ] Handle pagination (start/limit)

### State Management
- [ ] Create `SearchProvider` with Riverpod
- [ ] Manage search query state
- [ ] Manage active filters state
- [ ] Manage pagination state
- [ ] Implement client-side sorting

### UI Layer
- [ ] Create `SearchScreen` with AppBar
- [ ] Create `SearchInput` widget
- [ ] Create filter dropdowns (Country, Type, Choice)
- [ ] Create `FilterChip` widget
- [ ] Create `SearchResultCard` widget
- [ ] Create `SearchShimmer` loading widget
- [ ] Implement infinite scroll
- [ ] Handle empty state
- [ ] Handle error state

### Navigation
- [ ] Add route to `app_router.dart`
- [ ] Implement navigation to bio screens
- [ ] Pass userId to bio screens

---

## File Structure

```
lib/features/search/
├── data/
│   ├── models/
│   │   ├── search_user_model.dart
│   │   └── search_filter_model.dart
│   └── repositories/
│       └── search_repository.dart
├── providers/
│   └── search_provider.dart
├── screens/
│   └── search_screen.dart
└── widgets/
    ├── search_input.dart
    ├── filter_dropdown.dart
    ├── filter_chip.dart
    ├── search_result_card.dart
    └── search_shimmer.dart
```

---

## API Response Example

```json
{
  "status": 1,
  "result": [
    {
      "userId": "123",
      "firstName": "Abhishek",
      "lastName": "Pachal",
      "profileImage": "users/avatar.jpg",
      "country": "India",
      "playPosition": "Goalkeeper",
      "isPlayer": true,
      "isCoach": false,
      "isAdmin": false,
      "isReferee": false,
      "appearance": 5,
      "goals": 0,
      "postCount": 3,
      "endorsedBy": 3,
      "followers": 20
    }
  ]
}
```

---

## UI Specifications

### Colors
- Background: White
- Input/Dropdown: Light gray (#F5F5F5)
- Filter chips: Light gray (#E0E0E0)
- Text: Black
- Secondary text: Gray (#757575)

### Typography
- Name: 16sp, Bold
- Position: 14sp, Regular
- Stats: 12sp, Regular
- Labels: 10sp, Uppercase

### Spacing
- Card padding: 16px
- Card margin: 8px vertical
- Avatar to text: 12px
- Filter chips gap: 8px

---

## Special Behaviors

### 1. Referee Type Selected
- Disables "By Choice" dropdown
- Removes any active "By Choice" filter
- Grays out "By Choice" dropdown

### 2. Empty Search
- Automatically triggers search when text cleared
- Shows all users with current filters

### 3. Filter Changes
- Any filter change triggers new search
- Resets pagination to start
- Maintains other active filters

### 4. Pagination
- Loads 25 results per page
- Triggers at 80% scroll
- Stops when no more results

---

## Documentation

- **Full Specification**: `SEARCH_FEATURE_SPECIFICATION.md`
- **This Summary**: `SEARCH_FEATURE_SUMMARY.md`
- **Android Reference**: `Socaloca-legacy/app/src/main/java/com/football/socaloca/fragment/SearchNewFragment.java`

---

## Status

📋 **DOCUMENTED** - Complete specification ready for implementation

**Next Steps**:
1. Review specification
2. Get approval to implement
3. Create data models
4. Implement repository
5. Create provider
6. Build UI components
7. Test all features
