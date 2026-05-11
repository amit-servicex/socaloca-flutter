# Players Tab - Android App Analysis & Implementation Plan

## Overview

The Players tab allows users (primarily Fans) to browse and search for players based on various filters like playing position, age group, and gender. This feature helps users discover players in their country and view their profiles.

---

## Android Implementation Analysis

### File Locations

**Fragment**: `Socaloca-legacy/app/src/main/java/com/football/socaloca/fragment/FanPlayersFragment.java`
**Layout**: `Socaloca-legacy/app/src/main/res/layout/fragment_fan_players.xml`
**Player Card**: `Socaloca-legacy/app/src/main/res/layout/fan_player_cell.xml`
**Model**: `Socaloca-legacy/app/src/main/java/com/football/socaloca/model/TeamPlayer.java`
**API**: `getFanPlayers` (APINames.GET_FAN_PLAYERS)

---

## API Details

### Endpoint
```
POST /getFanPlayers
```

### Request Parameters
```json
{
  "userId": "string",           // Current user ID
  "country": "string",          // User's country (auto-filled)
  "playPosition": "string",     // Filter: "Goalkeeper", "Defender", "Attack", "Midfield", or ""
  "gender": "string",           // Filter: "male", "female", or ""
  "ageGroup": "string",         // Filter: "<10", "<12", "<15", "<18", "<20", "21-30", "31-40", ">40", or ""
  "dateToday": "string",        // Current date in plain format
  "start": 0,                   // Pagination offset
  "limit": 10                   // Items per page
}
```

### Response Structure
```json
{
  "status": 1,
  "players": [
    {
      "userId": "string",
      "playerId": "string",
      "firstName": "string",
      "lastName": "string",
      "imageUrl": "string",
      "playPosition": "string",        // e.g., "Goalkeeper", "Defender"
      "playPositionType": "string",    // e.g., "GK", "CB", "LB"
      "teamJerseyNo": "string",
      "yearOfBirth": "string",
      "dob": "string",
      "nationality": "string",
      "isPlayer": boolean,
      "isCoach": boolean,
      "isAdmin": boolean,
      "goalCount": number,
      "assistCount": number,
      "momCount": number,
      "rCard": number,
      "yCard": number,
      "lastOnline": number
    }
  ]
}
```

---

## UI Structure

### 1. Search/Filter Section

**Country Display**
- Shows user's current country (auto-filled, non-editable)
- Grey rounded box, 100dp width
- Font: Poppins Regular, 12sp

**Playing Position Filter**
- Dropdown with options:
  - "Playing Position" (default/placeholder)
  - "Goalkeeper"
  - "Defender"
  - "Attack"
  - "Midfield"
- Grey rounded box with dropdown arrow
- Font: Poppins Regular, 12sp

**Age Group Filter**
- Dropdown with options:
  - "Age Group" (default/placeholder)
  - "<10"
  - "<12"
  - "<15"
  - "<18"
  - "<20"
  - "21-30"
  - "31-40"
  - ">40"
- Grey rounded box with dropdown arrow
- Font: Lato Medium, 12sp
- 49% width (left side)

**Gender Filter**
- Dropdown with options:
  - "Gender" (default/placeholder)
  - "Male"
  - "Female"
- Grey rounded box with dropdown arrow
- Font: Poppins Regular, 12sp
- 49% width (right side)

**GO Button**
- Black background (#000000)
- Yellow text (#FFEB3B)
- Text: "GO" (uppercase)
- Font: Poppins Bold, 14sp
- Height: 42dp
- Rounded corners: 5dp
- Triggers search with selected filters

### 2. Players List

**Player Card Design**
- White card with elevation (4dp)
- Rounded corners (15dp)
- Padding: 20dp horizontal, 10dp vertical
- Margin: 10dp top/bottom

**Card Layout**:

**Left Side (80dp width)**:
- **Player Image**
  - Circular avatar (80dp × 80dp)
  - Black border (2dp)
  - Grey placeholder if no image
  
- **Jersey Number Badge**
  - Below image
  - Grey rounded background (5dp radius)
  - Text: "Jersey N°" + number
  - Font: Poppins Regular (10sp) + Poppins SemiBold (16sp)
  - Padding: 7dp horizontal, 4dp vertical

**Right Side (remaining width)**:
- **Player Name**
  - First name: Poppins Regular, 18sp
  - Last name: Poppins Bold, 18sp
  - Single line, truncated if too long
  
- **Position Info**
  - Playing position (e.g., "Goalkeeper"): Poppins SemiBold, 12sp
  - Dot separator (5dp × 5dp black circle)
  - Position type (e.g., "GK"): Poppins Regular, 12sp
  - All on one line
  
- **View Details Button**
  - Right-aligned
  - Black background, yellow text
  - Text: "VIEW DETAILS" (uppercase)
  - Font: Poppins Bold, 12sp
  - Padding: 12dp horizontal, 8dp vertical
  - Rounded corners: 5dp

### 3. Empty State

**No Players Found**
- Centered text below filters
- Text: "No players found"
- Font: Poppins Bold, 12sp
- Margin top: 50dp
- Only shown when search returns no results

---

## Features & Behavior

### 1. Initial Load
- Automatically loads players from user's country
- No filters applied initially
- Shows first 10 players
- Pagination: loads 10 more on scroll to bottom

### 2. Filtering
- User can select any combination of filters
- Filters are optional (can search with none, one, or all)
- Clicking "GO" button:
  - Resets pagination (start = 0)
  - Clears existing player list
  - Fetches new results with filters
  - Hides keyboard

### 3. Pagination
- Infinite scroll implementation
- Detects when user scrolls to bottom
- Automatically loads next 10 players
- Prevents duplicate API calls (isGettingPlayers flag)
- Increments start offset by limit (10)

### 4. Player Card Interaction
- Tapping "VIEW DETAILS" button:
  - Navigates to player bio screen
  - Passes player's userId
  - Opens `NewPlayerBioFragment`

### 5. Screen Lifecycle
- **onResume**: 
  - Updates footer/navigation to highlight Players tab
  - Shows header with "Players" title
  - Registers scroll listener
  
- **onStop/onDestroy**:
  - Unregisters scroll listener to prevent memory leaks

---

## Data Model

### TeamPlayer Model Fields

```dart
class PlayerModel {
  // Identity
  String userId;
  String playerId;
  String teamId;
  
  // Personal Info
  String firstName;
  String lastName;
  String imageUrl;
  String dob;
  String yearOfBirth;
  String nationality;
  
  // Position Info
  String playPosition;        // "Goalkeeper", "Defender", "Attack", "Midfield"
  String playPositionType;    // "GK", "CB", "LB", "RB", "CDM", "CM", "CAM", "LW", "RW", "ST"
  String teamJerseyNo;
  String preferredJersey;
  String playerJersey;
  String extJersey;
  
  // Role Flags
  bool isPlayer;
  bool isCoach;
  bool isManager;
  bool isAdmin;
  bool teamCoach;
  bool teamManager;
  
  // Stats
  int goalCount;
  int assistCount;
  int momCount;              // Man of the Match count
  int rCard;                 // Red cards
  int yCard;                 // Yellow cards
  
  // Status
  long lastOnline;
  String type;
  
  // Team Reference
  Team team;                 // Optional team object
}
```

---

## UI/UX Specifications

### Colors
- **Background**: `#F6F6F6` (new_white)
- **Card Background**: `#FFFFFF` (white)
- **Filter Boxes**: `#EAEAE8` (new_gray)
- **Text**: `#000000` (new_black)
- **Button Background**: `#000000` (new_black)
- **Button Text**: `#FFEB3B` (new_yellow)
- **Borders**: `#000000` (black, 0.8dp)

### Typography
- **Poppins Regular**: Body text, hints, labels
- **Poppins SemiBold**: Position names, jersey labels
- **Poppins Bold**: Player last names, buttons, headings
- **Lato Medium**: Age group labels

### Spacing
- **Screen Padding**: 20dp horizontal
- **Card Margin**: 10dp vertical
- **Card Padding**: 20dp horizontal, 10dp vertical
- **Filter Spacing**: 4dp between dropdowns
- **Element Spacing**: 10-15dp between sections

### Dimensions
- **Filter Height**: 42dp
- **Button Height**: 42dp
- **Player Image**: 80dp × 80dp
- **Card Corner Radius**: 15dp
- **Button Corner Radius**: 5dp
- **Filter Corner Radius**: 5dp

---

## Flutter Implementation Plan

### Phase 1: Data Layer

#### 1.1 Create Player Model
**File**: `lib/features/players/data/models/player_model.dart`

```dart
@freezed
class PlayerModel with _$PlayerModel {
  const factory PlayerModel({
    @JsonKey(name: 'userId') required String userId,
    @JsonKey(name: 'playerId') String? playerId,
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'lastName') String? lastName,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'playPosition') String? playPosition,
    @JsonKey(name: 'playPositionType') String? playPositionType,
    @JsonKey(name: 'teamJerseyNo') String? teamJerseyNo,
    @JsonKey(name: 'yearOfBirth') String? yearOfBirth,
    @JsonKey(name: 'dob') String? dob,
    @JsonKey(name: 'nationality') String? nationality,
    @JsonKey(name: 'isPlayer') @Default(false) bool isPlayer,
    @JsonKey(name: 'isCoach') @Default(false) bool isCoach,
    @JsonKey(name: 'isAdmin') @Default(false) bool isAdmin,
    @JsonKey(name: 'goalCount') @Default(0) int goalCount,
    @JsonKey(name: 'assistCount') @Default(0) int assistCount,
    @JsonKey(name: 'momCount') @Default(0) int momCount,
    @JsonKey(name: 'rCard') @Default(0) int rCard,
    @JsonKey(name: 'yCard') @Default(0) int yCard,
    @JsonKey(name: 'lastOnline') int? lastOnline,
  }) = _PlayerModel;

  factory PlayerModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerModelFromJson(json);
}
```

#### 1.2 Create Repository
**File**: `lib/features/players/data/repositories/players_repository.dart`

```dart
class PlayersRepository {
  Future<List<PlayerModel>> getPlayers({
    required String userId,
    required String country,
    String playPosition = '',
    String gender = '',
    String ageGroup = '',
    int start = 0,
    int limit = 10,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.getFanPlayers,
      body: {
        'userId': userId,
        'country': country,
        'playPosition': playPosition,
        'gender': gender.toLowerCase(),
        'ageGroup': ageGroup,
        'dateToday': _getPlainDate(),
        'start': start,
        'limit': limit,
      },
    );

    if (response['status'] == 1 && response['players'] != null) {
      final players = response['players'] as List;
      return players
          .map((p) => PlayerModel.fromJson(p as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  String _getPlainDate() {
    final now = DateTime.now();
    return '${now.day}-${now.month}-${now.year}';
  }
}
```

### Phase 2: State Management

#### 2.1 Create Players State
**File**: `lib/features/players/providers/players_provider.dart`

```dart
class PlayersState {
  final List<PlayerModel> players;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final String playPosition;
  final String ageGroup;
  final String gender;

  const PlayersState({
    this.players = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
    this.playPosition = '',
    this.ageGroup = '',
    this.gender = '',
  });
}

class PlayersNotifier extends StateNotifier<PlayersState> {
  PlayersNotifier(this._ref) : super(const PlayersState());

  final Ref _ref;
  static const int _pageSize = 10;

  Future<void> load() async {
    // Load initial players
  }

  Future<void> loadMore() async {
    // Load more players (pagination)
  }

  void setFilters({
    String? playPosition,
    String? ageGroup,
    String? gender,
  }) {
    // Update filters and reload
  }

  Future<void> refresh() async {
    // Refresh players list
  }
}
```

### Phase 3: UI Layer

#### 3.1 Create Players Screen
**File**: `lib/features/players/screens/players_screen.dart`

**Structure**:
- SafeArea wrapper
- SingleChildScrollView with scroll listener
- Filter section (country, position, age, gender)
- GO button
- Players list (ListView.builder with shrinkWrap)
- Empty state widget

#### 3.2 Create Filter Widgets
**Files**:
- `lib/features/players/widgets/player_filter_row.dart`
- `lib/features/players/widgets/player_filter_dropdown.dart`

**Features**:
- Custom dropdown with grey background
- Dropdown arrow icon
- Selected value display
- Popup menu with options

#### 3.3 Create Player Card Widget
**File**: `lib/features/players/widgets/player_card.dart`

**Structure**:
- Card with elevation and rounded corners
- Row layout:
  - Left: Player image + jersey badge
  - Right: Name, position, view details button
- Tap handler for navigation

### Phase 4: Navigation

#### 4.1 Add Route
**File**: `lib/core/router/app_router.dart`

```dart
GoRoute(
  path: '/players',
  name: AppRoutes.players,
  builder: (context, state) => const PlayersScreen(),
),
```

#### 4.2 Add to Bottom Navigation
Update bottom navigation to include Players tab

---

## Implementation Checklist

### Data Layer
- [ ] Create `PlayerModel` with freezed
- [ ] Create `PlayersRepository`
- [ ] Add `getFanPlayers` to `ApiConstants`
- [ ] Run build_runner for code generation

### State Management
- [ ] Create `PlayersState` class
- [ ] Create `PlayersNotifier` with pagination
- [ ] Create `playersProvider`
- [ ] Implement filter logic

### UI Components
- [ ] Create `PlayersScreen` with scroll listener
- [ ] Create `PlayerFilterRow` widget
- [ ] Create `PlayerFilterDropdown` widget
- [ ] Create `PlayerCard` widget
- [ ] Create empty state widget
- [ ] Add loading indicators

### Features
- [ ] Implement initial load
- [ ] Implement filter functionality
- [ ] Implement pagination (infinite scroll)
- [ ] Implement pull-to-refresh
- [ ] Implement navigation to player bio
- [ ] Handle empty states
- [ ] Handle error states

### Testing
- [ ] Test with no filters
- [ ] Test with each filter individually
- [ ] Test with multiple filters
- [ ] Test pagination
- [ ] Test empty results
- [ ] Test error handling
- [ ] Test navigation

---

## Notes for Implementation

### 1. Filter Behavior
- All filters are optional
- Empty string means "no filter"
- Gender must be lowercase ("male", "female")
- Country is auto-filled from user profile

### 2. Pagination
- Use scroll controller to detect bottom
- Load more when within 200px of bottom
- Prevent duplicate calls with loading flag
- Show loading indicator at bottom when loading more

### 3. Performance
- Use `shrinkWrap: true` for ListView inside ScrollView
- Use `physics: NeverScrollableScrollPhysics()` for ListView
- Cache player images
- Debounce scroll events if needed

### 4. Accessibility
- Add semantic labels to all interactive elements
- Ensure sufficient color contrast
- Support screen readers
- Add tap targets of at least 48×48dp

### 5. Error Handling
- Show error message if API fails
- Provide retry button
- Handle network errors gracefully
- Show empty state for no results

---

## Design Assets Needed

### Icons
- Dropdown arrow icon
- Player placeholder avatar
- Jersey badge background

### Images
- Default player avatar (grey circle)
- Loading indicator

### Colors (from Android)
- `socaPageBg`: #F6F6F6
- `socaGrey`: #EAEAE8
- `socaBlack`: #000000
- `socaYellow`: #FFEB3B
- `socaWhite`: #FFFFFF

---

## API Integration Notes

### Endpoint
```
POST https://organise.socaloca.football:9757/getFanPlayers
```

### Headers
```
Content-Type: application/json
Authorization: Bearer <token>
```

### Error Responses
- `status: 0` - Error occurred
- `status: 1` - Success
- Empty `players` array - No results found

---

## Future Enhancements (Not in Current Scope)

1. **Advanced Filters**
   - Country selection (currently auto-filled)
   - Team filter
   - Stats-based filtering (goals, assists, etc.)

2. **Sorting Options**
   - Sort by name
   - Sort by position
   - Sort by stats

3. **Search by Name**
   - Text input for player name search
   - Real-time search suggestions

4. **Favorites/Bookmarks**
   - Save favorite players
   - Quick access to saved players

5. **Player Comparison**
   - Compare multiple players side-by-side
   - Stats comparison

---

**Document Version**: 1.0
**Created**: May 7, 2026
**Status**: Ready for Implementation
**Awaiting**: User approval and screenshots for UI refinement
