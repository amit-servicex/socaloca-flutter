# One-Off Matches Implementation Plan

## Overview

Based on Android implementation analysis, the "One-Off" matches feature is a second tab within the Tournaments/Matches landing screen that shows standalone matches (not part of tournaments).

**STATUS: ✅ COMPLETE**

---

## Android Implementation Analysis

### Structure:
```
FanMatchesLandingFragment (Container)
├── Tab 1: Tournaments (FanTournamentsLandingFragment) ✅ Already implemented
└── Tab 2: One-Off (FanMatchesFragment) ⏳ To be implemented
```

### FanMatchesFragment Features:
1. **Today's Match** (Featured match happening today)
   - Shows 1 match
   - Live status indicator
   - Team logos, names
   - Game type, age group
   - Stadium, country
   - Tap to view details

2. **Upcoming Matches** (Next 3 matches)
   - Shows up to 3 matches
   - Match date/time
   - Teams
   - "View All" button → Full list

3. **Recent Matches** (Last 3 played matches)
   - Shows up to 3 matches with scores
   - Match date
   - Final scores
   - "View All" button → Full list

---

## API Endpoints

### 1. Get Today's Matches
**API Name:** `getFanTodaysMatches`  
**Endpoint Constant:** `GET_FAN_TODAYS_MATCHES`  
**Method:** POST  
**Parameters:**
- `userId` - Current user ID
- `country` - User's country
- `dateToday` - Today's date (plain format)
- `start` - Pagination offset (0)
- `limit` - Number of matches (1)

**Response:**
```json
{
  "status": 1,
  "matches": [
    {
      "matchId": "...",
      "gameType": "11-a-side",
      "ageGroup": "Senior",
      "stadiumName": "...",
      "country": "...",
      "matchDateTimeGmt": 1234567890,
      "totalTimeMins": 90,
      "teams": [
        {
          "teamId": "...",
          "teamName": "...",
          "imageUrl": "..."
        },
        {
          "teamId": "...",
          "teamName": "...",
          "imageUrl": "..."
        }
      ]
    }
  ]
}
```

### 2. Get Upcoming Matches
**API Name:** `getFanUpcomingMatches`  
**Endpoint Constant:** `GET_FAN_UPCOMING_MATCHES`  
**Method:** POST  
**Parameters:**
- `userId` - Current user ID
- `country` - User's country
- `start` - Pagination offset
- `limit` - Number of matches (3 for preview, more for full list)

**Response:** Same structure as Today's Matches

### 3. Get Played/Recent Matches
**API Name:** `getFanPlayedMatches`  
**Endpoint Constant:** `GET_FAN_PLAYED_MATCHES`  
**Method:** POST  
**Parameters:**
- `userId` - Current user ID
- `country` - User's country
- `start` - Pagination offset
- `limit` - Number of matches (3 for preview, more for full list)

**Response:**
```json
{
  "status": 1,
  "matches": [
    {
      "matchId": "...",
      "gameType": "11-a-side",
      "ageGroup": "Senior",
      "matchDateTimeGmt": 1234567890,
      "teams": [...],
      "score": {
        "homeScore": 2,
        "awayScore": 1,
        "homeExtraTimeScore": 0,
        "awayExtraTimeScore": 0,
        "homePenaltyScore": 0,
        "awayPenaltyScore": 0
      }
    }
  ]
}
```

---

## Implementation Plan

### Phase 1: Data Models ✅ (Use existing)
We can reuse existing models:
- `TournamentMatchModel` (from tournaments feature)
- `MatchScoreModel` (from match management)

### Phase 2: Repository Layer

**File:** `lib/features/one_off_matches/data/repositories/one_off_matches_repository.dart`

**Methods:**
```dart
class OneOffMatchesRepository {
  // Get today's featured match
  Future<TournamentMatchModel?> getTodaysMatch({
    required String userId,
    required String country,
    required String dateToday,
  });

  // Get upcoming matches
  Future<List<TournamentMatchModel>> getUpcomingMatches({
    required String userId,
    required String country,
    int start = 0,
    int limit = 3,
  });

  // Get recent/played matches
  Future<List<TournamentMatchModel>> getPlayedMatches({
    required String userId,
    required String country,
    int start = 0,
    int limit = 3,
  });
}
```

### Phase 3: Providers

**File:** `lib/features/one_off_matches/providers/one_off_matches_providers.dart`

**Providers:**
```dart
// Today's match provider
final todaysMatchProvider = FutureProvider<TournamentMatchModel?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  
  final repository = ref.watch(oneOffMatchesRepositoryProvider);
  return await repository.getTodaysMatch(
    userId: user.id,
    country: user.country ?? '',
    dateToday: getCurrentDate(),
  );
});

// Upcoming matches provider
final upcomingMatchesProvider = FutureProvider<List<TournamentMatchModel>>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];
  
  final repository = ref.watch(oneOffMatchesRepositoryProvider);
  return await repository.getUpcomingMatches(
    userId: user.id,
    country: user.country ?? '',
    limit: 3,
  );
});

// Recent matches provider
final recentMatchesProvider = FutureProvider<List<TournamentMatchModel>>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];
  
  final repository = ref.watch(oneOffMatchesRepositoryProvider);
  return await repository.getPlayedMatches(
    userId: user.id,
    country: user.country ?? '',
    limit: 3,
  );
});
```

### Phase 4: UI Screens

#### 4.1 Main One-Off Matches Screen
**File:** `lib/features/one_off_matches/screens/one_off_matches_screen.dart`

**Layout:**
```
┌─────────────────────────────────────┐
│  TODAY'S MATCH (Featured)           │
│  ┌───────────────────────────────┐  │
│  │ [LIVE] if ongoing              │  │
│  │ Team A Logo  VS  Team B Logo   │  │
│  │ Team A Name      Team B Name   │  │
│  │ 11-a-side • Senior             │  │
│  │ Stadium Name, Country          │  │
│  └───────────────────────────────┘  │
├─────────────────────────────────────┤
│  UPCOMING MATCHES     [View All]    │
│  ┌───────────────────────────────┐  │
│  │ Team A vs Team B               │  │
│  │ Date • Time                    │  │
│  └───────────────────────────────┘  │
│  (3 matches)                        │
├─────────────────────────────────────┤
│  RECENT MATCHES       [View All]    │
│  ┌───────────────────────────────┐  │
│  │ Team A  2 - 1  Team B          │  │
│  │ Date                           │  │
│  └───────────────────────────────┘  │
│  (3 matches)                        │
└─────────────────────────────────────┘
```

#### 4.2 Upcoming Matches Full List
**File:** `lib/features/one_off_matches/screens/upcoming_matches_screen.dart`

**Features:**
- Full list with pagination
- Pull-to-refresh
- Lazy loading
- Empty state

#### 4.3 Recent Matches Full List
**File:** `lib/features/one_off_matches/screens/recent_matches_screen.dart`

**Features:**
- Full list with pagination
- Shows scores
- Pull-to-refresh
- Lazy loading
- Empty state

### Phase 5: Update Tournaments Landing

**File:** `lib/features/tournaments/screens/tournaments_landing_screen.dart`

**Changes:**
- Add second tab "ONE-OFF"
- Update TabController length from 4 to 5 (or create new structure)
- Add OneOffMatchesScreen as second tab

**New Structure:**
```dart
TabController(length: 2) // Main tabs
├── Tab 1: TOURNAMENTS
│   └── TabController(length: 4) // Tournament status tabs
│       ├── ONGOING
│       ├── UPCOMING
│       ├── MY LEAGUES
│       └── CLOSED
└── Tab 2: ONE-OFF
    └── OneOffMatchesScreen
```

---

## File Structure

```
lib/features/one_off_matches/
├── data/
│   └── repositories/
│       └── one_off_matches_repository.dart
├── providers/
│   └── one_off_matches_providers.dart
├── screens/
│   ├── one_off_matches_screen.dart
│   ├── upcoming_matches_screen.dart
│   └── recent_matches_screen.dart
└── widgets/
    ├── todays_match_card.dart
    ├── upcoming_match_card.dart
    └── recent_match_card.dart
```

---

## API Constants to Add

**File:** `lib/core/constants/api_constants.dart`

```dart
// One-Off Matches
static const String getFanTodaysMatches = 'getFanTodaysMatches';
static const String getFanUpcomingMatches = 'getFanUpcomingMatches';
static const String getFanPlayedMatches = 'getFanPlayedMatches';
```

---

## Routing

**File:** `lib/core/router/app_routes.dart`

```dart
static const String oneOffMatches = '/one-off-matches';
static const String upcomingMatches = '/one-off-matches/upcoming';
static const String recentMatches = '/one-off-matches/recent';
```

---

## Implementation Steps

### Step 1: Add API Constants ✅ COMPLETE
Added the 3 new API endpoint constants (already existed)

### Step 2: Create Repository ✅ COMPLETE
Implemented OneOffMatchesRepository with 3 methods

### Step 3: Create Providers ✅ COMPLETE
Implemented 3 FutureProviders + 2 pagination providers for data fetching

### Step 4: Create Widgets ✅ COMPLETE
- TodaysMatchCard (featured match with live indicator)
- UpcomingMatchCard (simple match preview)
- RecentMatchCard (match with score)

### Step 5: Create Main Screen ✅ COMPLETE
OneOffMatchesScreen with 3 sections

### Step 6: Create Full List Screens ✅ COMPLETE
- UpcomingMatchesScreen (with pagination)
- RecentMatchesScreen (with pagination)

### Step 7: Update Tournaments Landing ✅ COMPLETE
Added second tab for One-Off matches with nested tab structure

### Step 8: Add Routing ✅ COMPLETE
Configured routes for all screens

### Step 9: Testing ⏳ PENDING
- Test data loading
- Test navigation
- Test pagination
- Test pull-to-refresh
- Test empty states

---

## Key Features

### Today's Match Card:
- ✅ Large featured card
- ✅ Live indicator (if match is ongoing)
- ✅ Team logos (80x80)
- ✅ Team names
- ✅ Game type and age group badges
- ✅ Stadium and country
- ✅ Tap to view match details

### Upcoming Matches:
- ✅ Compact list view
- ✅ Shows next 3 matches
- ✅ Date and time display
- ✅ "View All" button
- ✅ Empty state if no matches

### Recent Matches:
- ✅ Compact list view with scores
- ✅ Shows last 3 matches
- ✅ Final score display
- ✅ "View All" button
- ✅ Empty state if no matches

---

## Timeline Estimate

| Task | Estimated Time |
|------|---------------|
| API Constants | 5 minutes |
| Repository | 30 minutes |
| Providers | 20 minutes |
| Widgets (3) | 1 hour |
| Main Screen | 1 hour |
| Full List Screens (2) | 1 hour |
| Update Landing | 30 minutes |
| Routing | 15 minutes |
| Testing | 30 minutes |
| **Total** | **~5 hours** |

---

## Success Criteria

- ✅ Today's match displays correctly with live indicator
- ✅ Upcoming matches show next 3 matches
- ✅ Recent matches show last 3 matches with scores
- ✅ "View All" buttons navigate to full lists
- ✅ Full lists have pagination
- ✅ Pull-to-refresh works
- ✅ Empty states display correctly
- ✅ Navigation between tabs is smooth
- ✅ Match details navigation works

---

## Notes

- Reuse existing `TournamentMatchModel` and `MatchScoreModel`
- Reuse existing match card widgets where possible
- Follow same patterns as tournaments feature
- Ensure consistent styling with tournaments
- Add proper error handling
- Include loading states
- Support pull-to-refresh

---

*One-Off Matches Implementation Plan - Created: Current Session*

