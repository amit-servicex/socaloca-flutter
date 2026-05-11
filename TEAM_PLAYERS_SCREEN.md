# Team Players Screen Implementation

## Overview
Implemented the "VIEW ALL" players screen that displays all team members categorized by position (Goalkeepers, Defenders, Midfielders, Attackers).

## UI Design
Matches the Android app screenshot with:
- Header showing "Players" title and total player count
- Position sections with black/yellow badges
- Player cards showing jersey number, avatar, name, position, and country
- Clean white background with dividers between players

## Files Created

### 1. Screen
**File**: `socaloca-flutter/lib/features/teams/screens/team_players_screen.dart`

Features:
- Displays players grouped by position
- Shows jersey number, avatar, name, position abbreviation
- Pull-to-refresh support
- Error handling with retry button
- Loading state with spinner

### 2. Provider
**File**: `socaloca-flutter/lib/features/teams/providers/team_players_provider.dart`

Features:
- `TeamPlayersState`: Holds all players and categorized lists
- `TeamPlayersNotifier`: Manages state and categorization logic
- Auto-loads players on initialization
- Sorts players by jersey number within each position
- Handles numeric and non-numeric jersey numbers

### 3. Repository
**File**: `socaloca-flutter/lib/features/teams/data/repositories/team_players_repository.dart`

Features:
- API endpoint: `getTeamAllMembers`
- Filters members to only include those with jersey numbers
- Comprehensive debug logging
- Error handling with stack traces

## API Details

### Get Team All Members
**Endpoint**: `getTeamAllMembers`

**Request**:
```json
{
  "userId": "user123",
  "teamId": "team456"
}
```

**Response**:
```json
{
  "status": 1,
  "memberCount": 16,
  "members": [
    {
      "userId": "player1",
      "firstName": "Vedant",
      "lastName": "Pujari",
      "imageUrl": "player1.png",
      "playPosition": "Goalkeeper",
      "teamJerseyNo": "01"
    },
    {
      "userId": "player2",
      "firstName": "Tyrell",
      "lastName": "Fernandes",
      "imageUrl": "player2.png",
      "playPosition": "Defender",
      "teamJerseyNo": "02"
    }
  ]
}
```

## Model Updates

### TeamPlayerModel
**File**: `socaloca-flutter/lib/features/teams/data/models/team_bio_model.dart`

Added field mapping:
```dart
@JsonKey(name: 'teamJerseyNo') String? jerseyNumber,
```

This maps the API's `teamJerseyNo` field to the model's `jerseyNumber` field.

## Routing

### Route Added
**Path**: `/teams/:teamId/players`
**Constant**: `AppRoutes.teamPlayers`

### Navigation
From Team Bio screen, clicking "VIEW ALL" button navigates to:
```dart
context.push('/teams/$teamId/players');
```

## Position Categorization

Players are categorized by the `playPosition` field:
- `"Goalkeeper"` → Goalkeepers section
- `"Defender"` → Defenders section
- `"Midfield"` → Midfielders section
- `"Attack"` → Attackers section

## Sorting Logic

Within each position, players are sorted by jersey number:
1. Numeric jersey numbers sorted numerically (1, 2, 3, ...)
2. Non-numeric jersey numbers sorted alphabetically
3. Empty/null jersey numbers appear last

## UI Components

### Position Section Header
- Black background with yellow text
- Rounded corners
- Shows position name (e.g., "Goalkeepers")

### Player Card
```
┌─────────────────────────────────────┐
│  01    ○    Vedant Pujari           │
│           Goalkeeper (GK) • India   │
└─────────────────────────────────────┘
```

Components:
- Jersey number (left, bold, 40px width)
- Avatar (50x50 circular)
- Name (bold, 16px)
- Position abbreviation and country (14px, grey)

## Position Abbreviations

- Goalkeeper → "Goalkeeper (GK)"
- Defender → "Defender"
- Midfield → "Midfielder"
- Attack → "Attacker"

## Debug Logging

The repository logs:
- 🔍 Request parameters
- 🔍 Full API response
- 🔍 Response type and keys
- ✅ Number of members found
- 📋 First member data structure
- ❌ Parsing errors with member data
- ✅ Successfully parsed player count

## Error Handling

- User not logged in → Exception thrown
- API returns error status → Exception thrown
- No members in response → Returns empty list
- Individual member parsing fails → Logs error, continues with other members
- Network errors → Caught and displayed with retry button

## Testing

1. Navigate to any team bio screen
2. Click "VIEW ALL" button in Players section
3. Verify players are displayed grouped by position
4. Check jersey numbers are sorted correctly
5. Verify avatars load properly
6. Test pull-to-refresh
7. Check console for debug logs showing API response

## Files Modified

1. `socaloca-flutter/lib/features/teams/data/models/team_bio_model.dart` - Added `@JsonKey(name: 'teamJerseyNo')`
2. `socaloca-flutter/lib/features/teams/screens/team_bio_screen.dart` - Added navigation to players screen
3. `socaloca-flutter/lib/core/router/app_router.dart` - Added team players route
4. `socaloca-flutter/lib/core/router/app_routes.dart` - Added `teamPlayers` constant

## Next Steps

- Implement navigation to individual player bio when clicking a player card
- Add search/filter functionality for players
- Consider adding player statistics in the cards
- Add position icons instead of text abbreviations
