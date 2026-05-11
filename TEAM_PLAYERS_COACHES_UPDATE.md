# Team Players Screen - Coaches & Managers Section

## Update Summary
Added a "Coaches & Managers" section at the bottom of the team players screen to display team staff members.

## Changes Made

### 1. Updated TeamPlayersState
**File**: `socaloca-flutter/lib/features/teams/providers/team_players_provider.dart`

Added `coaches` field to state:
```dart
final List<TeamPlayerModel> coaches;
```

### 2. Updated Player Categorization Logic
**File**: `socaloca-flutter/lib/features/teams/providers/team_players_provider.dart`

Enhanced `_loadPlayers()` method to identify coaches/managers:
- Checks if jersey number contains "coach" or "manager"
- Checks if player has no position (null or empty)
- Players without standard positions are categorized as coaches
- Coaches are sorted by jersey number like other positions

**Identification Logic**:
```dart
final jerseyNo = player.jerseyNumber?.toLowerCase() ?? '';
final isCoachManager = jerseyNo.contains('coach') || 
                       jerseyNo.contains('manager') ||
                       position == null || 
                       position.isEmpty;
```

### 3. Updated Screen UI
**File**: `socaloca-flutter/lib/features/teams/screens/team_players_screen.dart`

Added coaches section at the bottom:
```dart
if (state.coaches.isNotEmpty)
  _buildPositionSection('Coaches & Managers', state.coaches),
```

### 4. Enhanced Position Display
**File**: `socaloca-flutter/lib/features/teams/screens/team_players_screen.dart`

Updated `_getPositionAbbreviation()` to handle coach/manager roles:
```dart
case 'coach':
  return 'Coach';
case 'manager':
  return 'Manager';
```

### 5. Improved Player Card Display
**File**: `socaloca-flutter/lib/features/teams/screens/team_players_screen.dart`

Enhanced player card to show jersey number as role for coaches without positions:
- If player has no position but has jersey number, display the jersey number (e.g., "Coach", "Manager")
- Maintains consistent layout with bullet separator

## Display Order

Players are now displayed in this order:
1. **Goalkeepers** (if any)
2. **Defenders** (if any)
3. **Midfielders** (if any)
4. **Attackers** (if any)
5. **Coaches & Managers** (if any) ← NEW

## Coach/Manager Identification

A team member is identified as coach/manager if:
1. Jersey number contains "coach" or "manager" (case-insensitive), OR
2. Player has no `playPosition` field (null or empty), OR
3. Player position doesn't match standard positions (Goalkeeper, Defender, Midfield, Attack)

## UI Example

```
┌─────────────────────────────────────┐
│ Coaches & Managers                  │
└─────────────────────────────────────┘
┌─────────────────────────────────────┐
│  Coach   ○    John Smith            │
│              Coach • India          │
├─────────────────────────────────────┤
│  Manager ○    Mike Johnson          │
│              Manager • India        │
└─────────────────────────────────────┘
```

## Testing

1. Navigate to team players screen
2. Scroll to bottom
3. Verify "Coaches & Managers" section appears if team has coaches
4. Check that coaches display correctly with their role
5. Verify jersey numbers show as roles for coaches without positions

## Files Modified

1. `socaloca-flutter/lib/features/teams/providers/team_players_provider.dart`
2. `socaloca-flutter/lib/features/teams/screens/team_players_screen.dart`

## Notes

- Coaches are sorted by jersey number within their section
- If a coach has a numeric jersey number, it will be sorted numerically
- If a coach has a text jersey number (like "Coach"), it will be sorted alphabetically
- The section only appears if there are coaches/managers in the team
