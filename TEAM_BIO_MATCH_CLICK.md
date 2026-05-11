# Team Bio - Recent Match Click Handler

## Update Summary
Added click functionality to recent match cards in the Team Bio screen to navigate to match details.

## Android Implementation Analysis

### How it works in Android:
1. In `FanRecentMatchesAdapter`, each match card has a click listener
2. On click, it calls `mContext.matchDetails(socaLocaMatch)`
3. The `matchDetails()` method navigates to `MatchDetailsFragment` with:
   - `matchId`: The unique match identifier
   - `tournamentId`: The tournament the match belongs to
   - `manageable`: Boolean flag (set to false for fan view)

### Code Reference (Android):
```java
itemView.setOnClickListener(new View.OnClickListener() {
    @Override
    public void onClick(View v) {
        mContext.matchDetails(socaLocaMatch);
    }
});

public void matchDetails(SocaLocaMatch match) {
    if (match.getTournamentId() == null){
        return;
    }
    MatchDetailsFragment playedMatchDetailsFragment = new MatchDetailsFragment();
    playedMatchDetailsFragment.setMatchId(match.getMatchId());
    playedMatchDetailsFragment.setTournamentId(match.getTournamentId());
    playedMatchDetailsFragment.setManageable(false);
    pushFragments(playedMatchDetailsFragment, false, true, null);
}
```

## Flutter Implementation

### Changes Made
**File**: `socaloca-flutter/lib/features/teams/screens/team_bio_screen.dart`

Wrapped the match card Container in an `InkWell` widget with `onTap` handler:

```dart
Widget _buildMatchCard(TeamMatchModel match) {
  return InkWell(
    onTap: () {
      if (match.matchId != null && match.matchId!.isNotEmpty) {
        // TODO: Navigate to match details screen
        // context.push('/matches/${match.matchId}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Match details: ${match.matchId}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    },
    child: Container(
      // ... existing match card UI
    ),
  );
}
```

### Current Behavior
- Match cards are now tappable with visual feedback (InkWell ripple effect)
- Clicking shows a SnackBar with the match ID (temporary placeholder)
- Only matches with valid matchId are clickable

### Next Steps

To complete the implementation, you need to:

1. **Uncomment the navigation line** when match details screen is implemented:
   ```dart
   context.push('/matches/${match.matchId}');
   ```

2. **Add tournamentId to TeamMatchModel** if needed for match details:
   ```dart
   @freezed
   class TeamMatchModel with _$TeamMatchModel {
     const factory TeamMatchModel({
       String? matchId,
       String? tournamentId,  // Add this
       // ... other fields
     }) = _TeamMatchModel;
   }
   ```

3. **Update the repository** to include tournamentId in the match data:
   ```dart
   final simplifiedMatch = <String, dynamic>{
     'matchId': matchJson['matchId'],
     'tournamentId': matchJson['tournamentId'],  // Add this
     // ... other fields
   };
   ```

4. **Create/Update Match Details Screen** to accept matchId parameter

5. **Add route** in `app_routes.dart`:
   ```dart
   static const String matchDetail = '/matches/:matchId';
   ```

6. **Add route handler** in `app_router.dart`:
   ```dart
   GoRoute(
     path: AppRoutes.matchDetail,
     name: 'matchDetail',
     builder: (ctx, state) {
       final matchId = state.pathParameters['matchId']!;
       return MatchDetailsScreen(matchId: matchId);
     },
   ),
   ```

## Testing

1. Navigate to any team bio screen
2. Scroll to Recent Matches section
3. Tap on a match card
4. Verify:
   - InkWell ripple effect appears
   - SnackBar shows with match ID
   - Match card is visually responsive to touch

## Files Modified

1. `socaloca-flutter/lib/features/teams/screens/team_bio_screen.dart`

## Notes

- The temporary SnackBar implementation allows testing the click functionality
- Once match details screen is implemented, simply uncomment the navigation line
- The InkWell provides Material Design ripple effect for better UX
- Only matches with valid matchId will be clickable (null check in place)
