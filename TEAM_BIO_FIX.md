# Team Bio Screen Fix

## Issue
Error: "type 'Null' is not a subtype of type 'String' in type cast"

This occurred because required String fields in the model were receiving null values from the API.

## Root Cause
1. `teamId` and `teamName` were marked as `required` but API could return null
2. `userId` in TeamPlayerModel was required but could be null
3. Rating stats were in `teamDetails` but API returns them in separate `ratingDetails` object
4. API response structure was incorrectly parsed (was looking for nested `response` object)

## Changes Made

### 1. Updated TeamDetailsModel
**File**: `socaloca-flutter/lib/features/teams/data/models/team_bio_model.dart`

- Made `teamId` and `teamName` optional (nullable)
- Removed rating fields from TeamDetailsModel (teamWork, technical, etc.)
- Added `@JsonKey(name: 'ageCat')` for ageCategory field mapping

### 2. Created RatingDetailsModel
Added new model to match Android's `ratingDetails` structure:
```dart
@freezed
class RatingDetailsModel with _$RatingDetailsModel {
  const factory RatingDetailsModel({
    @JsonKey(name: 'avgTeamWork') @Default(0) int teamWork,
    @JsonKey(name: 'avgTechnical') @Default(0) int technical,
    @JsonKey(name: 'avgAggressiveness') @Default(0) int aggressiveness,
    @JsonKey(name: 'avgTactical') @Default(0) int tactical,
    @JsonKey(name: 'avgOverall') @Default(0) int overall,
  }) = _RatingDetailsModel;
}
```

### 3. Updated TeamPlayerModel
Made `userId` optional to handle null values

### 4. Fixed API Response Parsing
**File**: `socaloca-flutter/lib/features/teams/data/repositories/team_bio_repository.dart`

Changed from:
```dart
response['response']['status']  // ❌ Wrong
```

To:
```dart
response['status']  // ✅ Correct
```

Android uses direct structure: `{ status: 1, teamBio: {...} }`

### 5. Updated Team Bio Screen
**File**: `socaloca-flutter/lib/features/teams/screens/team_bio_screen.dart`

- Added null safety for teamName: `teamDetails.teamName ?? 'Unknown Team'`
- Updated stats to use `teamBio.ratingDetails` instead of `teamDetails`
- Fixed rating calculation: changed from `/10.0` to `/5.0` (Android uses max value of 5)

## API Response Structure

```json
{
  "status": 1,
  "teamBio": {
    "teamDetails": {
      "teamId": "...",
      "teamName": "...",
      "imageUrl": "...",
      "country": "...",
      "ageCat": "U-23",
      "gameType": "Football",
      "coachName": "...",
      "memberCount": 15,
      ...
    },
    "players": [
      {
        "userId": "...",
        "firstName": "...",
        "lastName": "...",
        "imageUrl": "...",
        ...
      }
    ],
    "ratingDetails": {
      "avgTeamWork": 4,
      "avgTechnical": 3,
      "avgAggressiveness": 5,
      "avgTactical": 4,
      "avgOverall": 4
    }
  }
}
```

## Debug Logging

Added comprehensive logging in repository:
- 🔍 Request parameters
- 🔍 Full API response
- 🔍 Response type and keys
- 📋 Team bio data structure
- ❌ Error messages with stack traces

## Testing

Run the app and navigate to a team bio screen:
1. Click VIEW button on any team card
2. Team bio should load without type cast errors
3. Check console for debug logs showing API response structure
4. Verify all sections display correctly:
   - Team name, logo, age category
   - Game type, country, member count
   - Coach name (if available)
   - Rating bars (if ratingDetails present)
   - Players section (if players present)
   - Recent matches section

## Files Modified

1. `socaloca-flutter/lib/features/teams/data/models/team_bio_model.dart`
2. `socaloca-flutter/lib/features/teams/data/repositories/team_bio_repository.dart`
3. `socaloca-flutter/lib/features/teams/screens/team_bio_screen.dart`
