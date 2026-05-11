# Tournaments Feature Implementation

## Overview
Implemented the tournaments feature in Flutter matching the Android app functionality. The feature includes tournament listings with filters, tabs for different tournament statuses, and integration with the backend APIs.

## Files Created

### 1. Models (`lib/features/tournaments/data/tournament_models.dart`)
- **TournamentModel**: Main tournament data model with all fields from Android
- **BannerModel**: Tournament banner/slider images
- **TournamentMatchModel**: Tournament match data
- **PointsTableEntry**: Points table entry for league standings
- **TournamentFilters**: Filter criteria for tournament search

### 2. Repository (`lib/features/tournaments/data/tournament_repository.dart`)
- **getTournaments()**: Get tournaments by status (ongoing, upcoming, closed)
- **getMyTournaments()**: Get user's participating tournaments
- **getTournamentDetails()**: Get detailed tournament information
- **followTournament()**: Follow/unfollow a tournament
- **getTournamentMatches()**: Get tournament matches
- **getPointsTable()**: Get league points table

### 3. Screens

#### `lib/features/tournaments/screens/tournaments_landing_screen.dart`
- Main tournaments screen with 4 tabs:
  - **ONGOING**: Currently active tournaments
  - **UPCOMING**: Future tournaments
  - **MY LEAGUES**: User's participating tournaments
  - **CLOSED**: Completed tournaments
- Matches Android `CommonTournamentsLandingFragment`

#### `lib/features/tournaments/screens/tournament_list_screen.dart`
- Tournament list with infinite scroll
- Pull-to-refresh functionality
- Filter integration
- Empty state handling
- Matches Android `CommonOngoingTournamentsFragment`

### 4. Widgets

#### `lib/features/tournaments/widgets/tournament_card.dart`
- Tournament card UI component
- Shows:
  - Tournament logo
  - Name, age group, game type
  - Location
  - Follower count, team count
  - Status indicator (LIVE, FIXTURE, ENDED)
- Matches Android tournament list item layout

#### `lib/features/tournaments/widgets/tournament_filters.dart`
- Filter UI component
- Local/Global toggle
- Game Type, Age Group, Gender dropdowns
- Matches Android filter section

### 5. API Constants
Updated `lib/core/constants/api_constants.dart` with:
- `getMyTmnts`
- `getTmntMatches`
- `getTmntPointsTable`

### 6. Router
Updated `lib/core/router/app_router.dart`:
- Added tournaments route
- Imported `TournamentsLandingScreen`

## API Endpoints Used

| Endpoint | Purpose | Status |
|----------|---------|--------|
| `getVisTmnts` | Get visible tournaments (ongoing/upcoming/closed) | ✅ Implemented |
| `getMyTmnts` | Get user's tournaments | ✅ Implemented |
| `getTmntDetails` | Get tournament details | ✅ Implemented |
| `followTournament` | Follow/unfollow tournament | ✅ Implemented |
| `getTmntMatches` | Get tournament matches | ✅ Implemented |
| `getTmntPointsTable` | Get points table | ✅ Implemented |

## Features Implemented

### ✅ Completed
1. **Tournament Listing**
   - 4 tabs (Ongoing, Upcoming, My Leagues, Closed)
   - Infinite scroll pagination
   - Pull-to-refresh
   - Empty states

2. **Filters**
   - Local/Global visibility toggle
   - Game Type filter
   - Age Group filter
   - Gender filter

3. **Tournament Card**
   - Logo display with caching
   - Tournament info (name, location, age group, game type)
   - Follow count and team count
   - Status indicators

4. **API Integration**
   - All tournament list APIs
   - Tournament details API
   - Follow tournament API
   - Matches and points table APIs

### 🚧 To Be Implemented (Phase 2)

1. **Tournament Details Screen**
   - Banner slider
   - Follow button
   - Tabs: Matches, Points Table, Stats
   - Team list
   - Sponsor list

2. **Filter Dialogs**
   - Game Type picker
   - Age Group picker
   - Gender picker
   - Country/Location picker

3. **Tournament Matches**
   - Upcoming matches list
   - Played matches list
   - Match details navigation

4. **Points Table**
   - League standings
   - Team statistics
   - Sorting options

5. **Tournament Stats**
   - Top scorers
   - Top assists
   - Cards statistics
   - Man of the Match

## Usage

### Navigation
The tournaments screen is accessible from the bottom navigation bar:
```dart
context.go(AppRoutes.tournaments);
```

### Accessing Tournament Data
```dart
// Get tournaments
final tournaments = await ref.read(tournamentRepositoryProvider).getTournaments(
  userId: currentUser.id,
  status: 'ongoing',
  visibility: 'local',
);

// Get tournament details
final tournament = await ref.read(tournamentRepositoryProvider).getTournamentDetails(
  userId: currentUser.id,
  tournamentId: tournamentId,
);

// Follow tournament
final success = await ref.read(tournamentRepositoryProvider).followTournament(
  userId: currentUser.id,
  tournamentId: tournamentId,
  myName: userName,
);
```

## Testing Checklist

- [ ] Tournaments landing screen loads
- [ ] All 4 tabs display correctly
- [ ] Tournament list loads with data
- [ ] Infinite scroll works
- [ ] Pull-to-refresh works
- [ ] Local/Global toggle works
- [ ] Tournament cards display correctly
- [ ] Empty states show when no data
- [ ] Loading states show during API calls
- [ ] Error handling works
- [ ] Navigation to tournament details (when implemented)

## Android Equivalents

| Flutter | Android |
|---------|---------|
| `TournamentsLandingScreen` | `CommonTournamentsLandingFragment` |
| `TournamentListScreen` | `CommonOngoingTournamentsFragment` |
| `TournamentCard` | `tournament_item.xml` layout |
| `TournamentFiltersWidget` | Filter section in fragment |
| `TournamentModel` | `Tournament.java` |
| `TournamentRepository` | API calls in fragments |

## Next Steps

1. **Implement Tournament Details Screen**
   - Create `tournament_details_screen.dart`
   - Add banner slider
   - Add follow button functionality
   - Add tabs for Matches, Points Table, Stats

2. **Implement Filter Dialogs**
   - Create picker dialogs for filters
   - Add search functionality
   - Persist filter selections

3. **Add Navigation**
   - Tournament card → Tournament details
   - Match card → Match details
   - Team card → Team profile

4. **Add More Features**
   - Share tournament
   - Report tournament
   - Request to join tournament
   - Withdraw from tournament

## Notes

- All models use Freezed for immutability and code generation
- Repository uses async/await pattern
- Screens use ConsumerStatefulWidget for Riverpod integration
- Widgets follow Material Design guidelines
- Code matches Android functionality and UI as closely as possible
- API responses are handled with proper error checking
- Images use CachedNetworkImage for performance
- Lists use infinite scroll for better UX

## Dependencies Used

- `freezed_annotation`: Model generation
- `flutter_riverpod`: State management
- `cached_network_image`: Image caching
- `go_router`: Navigation

## Build Commands

```bash
# Generate model files
flutter pub run build_runner build --delete-conflicting-outputs

# Run app
flutter run

# Check for errors
flutter analyze
```

## Status: Phase 1 Complete ✅

The basic tournaments feature is now functional with:
- ✅ Tournament listing with 4 tabs
- ✅ Filters (Local/Global, Game Type, Age Group, Gender)
- ✅ Tournament cards with all info
- ✅ API integration
- ✅ Infinite scroll and pull-to-refresh
- ✅ Empty and loading states

Ready for testing and Phase 2 implementation!
