# Search Feature - Complete Specification

## Overview
The Search feature allows users to search for players, coaches, managers, and referees with advanced filtering options. Users can filter by country, user type, and sorting criteria (most posts, most appearances, most goals).

**Source Analysis**: 
- Android Fragment: `SearchNewFragment.java` (753 lines)
- API: `advSearch`
- Screenshot provided shows the UI layout

---

## UI Layout (Based on Screenshot)

### Top Bar
```
┌─────────────────────────────────────────────────────┐
│ ← Search          [Profile] [Search] [Bell] [Menu]  │
└─────────────────────────────────────────────────────┘
```

### Search Input
```
┌─────────────────────────────────────────────────────┐
│  Player/Coach/Manager/Referee              [🔍]     │
└─────────────────────────────────────────────────────┘
```

### Filter Dropdowns
```
┌──────────────┬──────────────┬──────────────┐
│ By Country ▼ │ By Type    ▼ │ By Choice  ▼ │
└──────────────┴──────────────┴──────────────┘
```

### Active Filters (Chips)
```
┌─────────────────────────────────────────────────────┐
│  [India ×]  [Player ×]  [Most Posts ×]              │
└─────────────────────────────────────────────────────┘
```

### Search Results List
```
┌─────────────────────────────────────────────────────┐
│  ┌────┐  Abhishek Pachal                            │
│  │ 👤 │  Goalkeeper | Goalkee...                    │
│  └────┘  Nationality: India                         │
│          5 Appearances                               │
│          3 Posts                                     │
│                                    3         20      │
│                              ENDORSED BY  FOLLOWERS  │
├─────────────────────────────────────────────────────┤
│  ┌────┐  Abhishek Pachal                            │
│  │ 👤 │  Goalkeeper | Goalkee...                    │
│  └────┘  Nationality: India                         │
│          0 Appearance                                │
│          0 Post                                      │
│                                    0          6      │
│                              ENDORSED BY  FOLLOWERS  │
└─────────────────────────────────────────────────────┘
```

---

## API Integration

### Endpoint
**API Name**: `advSearch`  
**Method**: POST  
**Base URL**: `https://organise.socaloca.football:9757/`

### Request Parameters
```json
{
  "userId": "string (required)",
  "searchText": "string (search query)",
  "country": "string (country filter, empty for all)",
  "userType": "string (player/coach/manager/referee, lowercase)",
  "choice": "string (posts/appearance/goals, empty for default)",
  "start": "number (pagination offset)",
  "limit": "number (items per page, default: 25)"
}
```

### Pagination
- **Items per page**: 25
- **Infinite scroll**: Load more when scrolled to bottom
- **Start calculation**: `start = currentPage * 25`

### Response Structure
```json
{
  "status": 1,
  "result": [
    {
      "userId": "string",
      "_id": "string",
      "firstName": "string",
      "lastName": "string",
      "profileName": "string",
      "profileImage": "string",
      "country": "string",
      "playPosition": "string",
      "isPlayer": "boolean",
      "isCoach": "boolean",
      "isAdmin": "boolean",
      "isReferee": "boolean",
      "isFan": "boolean",
      "appearance": "number",
      "goals": "number",
      "postCount": "number",
      "endorsedBy": "number",
      "followers": "number"
    }
  ]
}
```

---

## Filter Options

### 1. By Country Filter
**Type**: Searchable Dropdown  
**Options**: 
- "All" (default)
- List of all countries (from confederation data)

**Behavior**:
- Shows searchable spinner with all countries
- Default selection: User's current country (optional)
- Selecting "All" removes country filter
- Selecting a country adds/updates country filter chip

**API Parameter**: `country`
- Value: Country name (e.g., "India", "Brazil")
- Empty string for "All"

### 2. By Type Filter
**Type**: Dropdown  
**Options**:
- "By Type" (placeholder)
- "Player"
- "Coach"
- "Manager"
- "Referee"

**Behavior**:
- Selecting a type adds/updates type filter chip
- When "Referee" is selected, "By Choice" filter is disabled
- Type is sent as lowercase to API

**API Parameter**: `userType`
- Value: "player", "coach", "manager", "referee" (lowercase)
- Empty string for no filter

### 3. By Choice Filter (Sorting)
**Type**: Dropdown  
**Options**:
- "By Choice" (placeholder)
- "Most Posts"
- "Most Appearances"
- "Most Goals"

**Behavior**:
- Disabled when "Referee" type is selected
- Selecting an option adds/updates choice filter chip
- Results are sorted by selected criteria

**API Parameter**: `choice`
- "Most Posts" → `choice: "posts"`
- "Most Appearances" → `choice: "appearance"`
- "Most Goals" → `choice: "goals"`
- Default → `choice: ""`

**Client-Side Sorting**:
After receiving results, sort by:
- **Most Appearances**: Sort by `appearance` DESC, then by name ASC
- **Most Posts**: Sort by `postCount` DESC, then by name ASC
- **Most Goals**: Sort by `goals` DESC, then by name ASC
- **Default**: Sort by full name ASC

---

## Search Behavior

### Search Input
- **Placeholder**: "Player/Coach/Manager/Referee"
- **Search Icon**: Magnifying glass button on right
- **Trigger**: 
  - Click search icon
  - Press Enter/Search key on keyboard
  - Auto-search when text is cleared (empty search)

### Search Flow
1. User types search query
2. User clicks search icon or presses Enter
3. API call with current filters + search text
4. Results displayed in list
5. Scroll to bottom → load more results

### Empty Search
- When search text is cleared, automatically fetch results with current filters
- Shows all users matching current filters

---

## Filter Chips

### Display
- Shown horizontally below filter dropdowns
- Each active filter shows as a chip with close button (×)
- Format: `[FilterValue ×]`

### Behavior
- Clicking × removes that filter
- Removing a filter triggers new search with remaining filters
- Filters persist until manually removed

### Filter Types
1. **Country Chip**: Shows country name (e.g., "India")
2. **Type Chip**: Shows user type (e.g., "Player")
3. **Choice Chip**: Shows sorting option (e.g., "Most Posts")

---

## Search Result Card

### Layout
```
┌────────────────────────────────────────────────┐
│  ┌────┐  Name (First Last)                     │
│  │ 👤 │  Position | Role                       │
│  └────┘  Nationality: Country                  │
│          X Appearances                          │
│          X Posts                                │
│                              X            X     │
│                        ENDORSED BY   FOLLOWERS  │
└────────────────────────────────────────────────┘
```

### Components

1. **Avatar** (Left)
   - Circular profile image (60x60)
   - Default avatar if no image

2. **Name** (Top)
   - Format: `firstName lastName`
   - Bold, 16sp

3. **Position/Role** (Below name)
   - Shows `playPosition` for players
   - Shows role for coaches/managers/referees
   - Gray text, 14sp

4. **Nationality** (Below position)
   - Format: "Nationality: {country}"
   - Gray text, 12sp

5. **Stats** (Below nationality)
   - Appearances count
   - Posts count
   - Gray text, 12sp

6. **Endorsements & Followers** (Bottom right)
   - Two columns
   - Numbers with labels
   - Gray text, 12sp

### Tap Behavior
- Tapping card navigates to user bio:
  - Player → Player Bio Screen
  - Coach/Manager → Coach/Admin Bio Screen
  - Referee → Referee Bio Screen

---

## UI Specifications

### Colors
- **Background**: White
- **Search input background**: Light gray (#F5F5F5)
- **Filter dropdown background**: Light gray (#F5F5F5)
- **Filter chip background**: Light gray (#E0E0E0)
- **Text**: Black (#000000)
- **Secondary text**: Gray (#757575)
- **Divider**: Light gray (#E0E0E0)

### Typography
- **Name**: 16sp, Bold
- **Position/Role**: 14sp, Regular
- **Stats**: 12sp, Regular
- **Labels**: 10sp, Regular, Uppercase

### Spacing
- **Card padding**: 16px
- **Card margin**: 8px vertical
- **Avatar to text gap**: 12px
- **Text line spacing**: 4px
- **Filter chips gap**: 8px

### Icons
- **Search icon**: Magnifying glass
- **Close icon**: × (for filter chips)
- **Dropdown icon**: ▼

---

## States

### 1. Initial State
- Empty search input
- No filters applied
- Shows all users (or recent searches if implemented)

### 2. Loading State
- Show loading indicator while fetching results
- Disable search input and filters

### 3. Results State
- Display list of search results
- Show filter chips if filters applied
- Enable infinite scroll

### 4. Empty Results State
- Show "No searches" message
- Display when no results found

### 5. Error State
- Show error message if API fails
- Display retry button

---

## Implementation Notes

### 1. Search Debouncing
- Don't search on every keystroke
- Wait for user to click search icon or press Enter
- Auto-search when text is cleared

### 2. Filter Management
- Store active filters in state
- Each filter type can have only one value
- Adding same filter type replaces previous value

### 3. Pagination
- Load 25 results initially
- Load next 25 when scrolled to 80% of list
- Stop loading when no more results

### 4. Sorting
- API returns unsorted results
- Client-side sorting based on "By Choice" filter
- Default sort by name alphabetically

### 5. Navigation
- Determine user type from flags (isPlayer, isCoach, etc.)
- Navigate to appropriate bio screen
- Pass userId to bio screen

### 6. Filter Interactions
- "By Choice" disabled when "Referee" selected
- Removing "Referee" re-enables "By Choice"
- Changing any filter triggers new search

---

## Flutter Implementation Structure

### Files to Create
```
lib/features/search/
├── data/
│   ├── models/
│   │   ├── search_user_model.dart (freezed)
│   │   └── search_filter_model.dart
│   └── repositories/
│       └── search_repository.dart
├── providers/
│   └── search_provider.dart (Riverpod)
├── screens/
│   └── search_screen.dart
└── widgets/
    ├── search_input.dart
    ├── filter_dropdown.dart
    ├── filter_chip.dart
    ├── search_result_card.dart
    └── search_shimmer.dart
```

### Dependencies
- `freezed` + `json_serializable` for models
- `riverpod` for state management
- `cached_network_image` for avatars
- Existing dropdown widgets

---

## Testing Checklist

- [ ] Search with text query
- [ ] Search with empty query (show all)
- [ ] Filter by country
- [ ] Filter by type (Player, Coach, Manager, Referee)
- [ ] Filter by choice (Most Posts, Most Appearances, Most Goals)
- [ ] Combine multiple filters
- [ ] Remove individual filters
- [ ] "By Choice" disabled when Referee selected
- [ ] Infinite scroll pagination
- [ ] Navigate to correct bio screen
- [ ] Empty results state
- [ ] Error state
- [ ] Loading states

---

## API Request Examples

### Example 1: Search for "Abhishek" in India, Players only
```json
{
  "userId": "507f191e810c19729de860ea",
  "searchText": "Abhishek",
  "country": "India",
  "userType": "player",
  "choice": "",
  "start": 0,
  "limit": 25
}
```

### Example 2: Search all users, sorted by Most Posts
```json
{
  "userId": "507f191e810c19729de860ea",
  "searchText": "",
  "country": "",
  "userType": "",
  "choice": "posts",
  "start": 0,
  "limit": 25
}
```

### Example 3: Search Referees (no sorting)
```json
{
  "userId": "507f191e810c19729de860ea",
  "searchText": "",
  "country": "",
  "userType": "referee",
  "choice": "",
  "start": 0,
  "limit": 25
}
```

---

## Summary

The Search feature provides a powerful way to find users with:
- **Text search**: Search by name or profile name
- **Country filter**: Filter by nationality
- **Type filter**: Filter by user role
- **Sorting**: Sort by posts, appearances, or goals
- **Infinite scroll**: Load more results seamlessly
- **Filter chips**: Visual representation of active filters
- **Navigation**: Direct access to user bio screens

**Key Features**:
- Advanced filtering with 3 filter types
- Client-side sorting for better UX
- Infinite scroll pagination (25 items per page)
- Filter chips for easy filter management
- Type-based navigation to appropriate bio screens
- Empty and error state handling
