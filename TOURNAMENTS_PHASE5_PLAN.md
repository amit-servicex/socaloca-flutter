# Tournaments Refactoring - Phase 5 Plan

## Phase 5: Match Management (Admin/Referee/Coach Features)

### Status: 🚧 **In Progress**

---

## Overview

Phase 5 implements comprehensive match management functionality for users with Admin, Referee, or Coach roles. This allows authorized users to:
- Enter and manage match scores
- Record goal scorers with timestamps
- Track yellow and red cards
- Select Man of the Match
- Manage team squads and lineups
- Upload match photos and videos (optional)

---

## Scope

### Core Features (Must Have):
1. ✅ Match score entry and submission
2. ✅ Goal scorers management (player + minute)
3. ✅ Cards management (yellow/red with player + minute)
4. ✅ MVP (Man of the Match) selection
5. ✅ Squad management (starting lineup + substitutes)

### Optional Features (Nice to Have):
6. ⏳ Match photos upload
7. ⏳ Match videos upload
8. ⏳ Match rating system

---

## Architecture

### New Files to Create:

#### 1. Match Management Tab (League)
- `lib/features/tournaments/screens/league/tabs/league_match_management_tab.dart`
  - Main container for match management
  - Shows list of matches with management options
  - Only visible to Admin/Referee/Coach

#### 2. Match Management Screen (Shared)
- `lib/features/tournaments/screens/match_management/match_management_screen.dart`
  - Full-screen match management interface
  - Tabs: Score, Goals, Cards, MVP, Squad
  - Works for both League and Cup matches

#### 3. Match Management Widgets
- `lib/features/tournaments/widgets/match_management/score_entry_widget.dart`
- `lib/features/tournaments/widgets/match_management/goal_entry_widget.dart`
- `lib/features/tournaments/widgets/match_management/card_entry_widget.dart`
- `lib/features/tournaments/widgets/match_management/mvp_selection_widget.dart`
- `lib/features/tournaments/widgets/match_management/squad_management_widget.dart`

#### 4. Match Management Providers
- Providers already exist in `tournament_providers.dart` and `cup_providers.dart`
- Need to add state notifiers for match management actions

---

## Data Flow

### Match Score Entry:
```
User enters score
    ↓
API: sendMatchScore
    ↓
Score pending approval
    ↓
Opponent/Admin: acceptMatchScore
    ↓
Score confirmed
```

### Goal Entry:
```
User taps "Add Goal"
    ↓
Select player from squad
    ↓
Enter minute
    ↓
API: saveMatchGoalDetails
    ↓
Goal recorded
```

### Card Entry:
```
User taps "Add Card"
    ↓
Select card type (Yellow/Red)
    ↓
Select player
    ↓
Enter minute
    ↓
API: saveMatchCardDetails
    ↓
Card recorded
```

### MVP Selection:
```
User taps "Select MVP"
    ↓
Choose from match participants
    ↓
API: saveMatchMvp
    ↓
MVP recorded
```

### Squad Management:
```
User taps "Manage Squad"
    ↓
Select starting 11
    ↓
Select substitutes
    ↓
API: updateMatchPlayers
    ↓
Squad saved
```

---

## UI Design

### Match Management Tab (League Details):
```
┌────────────────────────────────────────┐
│  MATCHES  │  POINTS  │  STATS  │ MANAGE│  ← New tab
├────────────────────────────────────────┤
│  Match List (with management actions)  │
│  ┌──────────────────────────────────┐  │
│  │ Team A vs Team B                 │  │
│  │ Date: 2024-05-10                 │  │
│  │ Status: LIVE                     │  │
│  │ [Manage Match] button            │  │
│  └──────────────────────────────────┘  │
└────────────────────────────────────────┘
```

### Match Management Screen:
```
┌────────────────────────────────────────┐
│  Team A  2 - 1  Team B                 │  ← Score header
├────────────────────────────────────────┤
│  SCORE │ GOALS │ CARDS │ MVP │ SQUAD   │  ← Tabs
├────────────────────────────────────────┤
│  [Tab Content]                         │
│                                        │
│  Score Tab:                            │
│    Team A: [__] - Team B: [__]        │
│    [Submit Score] button               │
│                                        │
│  Goals Tab:                            │
│    Goal 1: Player Name (23')          │
│    Goal 2: Player Name (45')          │
│    [+ Add Goal] button                 │
│                                        │
│  Cards Tab:                            │
│    Yellow: Player Name (30')          │
│    Red: Player Name (67')             │
│    [+ Add Card] button                 │
│                                        │
│  MVP Tab:                              │
│    Current MVP: Player Name           │
│    [Change MVP] button                 │
│                                        │
│  Squad Tab:                            │
│    Starting XI (11 players)           │
│    Substitutes (7 players)            │
│    [Edit Squad] button                 │
└────────────────────────────────────────┘
```

---

## API Integration

### Endpoints Used (from match_management_repository.dart):
- `sendMatchScore` - Submit match score
- `acceptMatchScore` - Accept submitted score
- `saveMatchGoalDetails` - Save goal information
- `saveMatchCardDetails` - Save card information
- `saveMatchMvp` - Save Man of the Match
- `updateMatchPlayers` - Update squad lineup

---

## Access Control

### Role-Based Visibility:
- **Admin**: Full access to all matches in their tournaments
- **Referee**: Access to assigned matches only
- **Coach/Manager**: Access to matches involving their teams
- **Player/Fan**: No access (tab hidden)

### Implementation:
```dart
bool canManageMatch(User user, Match match) {
  if (user.isAdmin && match.tournamentId == user.managedTournamentId) {
    return true;
  }
  if (user.isReferee && match.refereeId == user.id) {
    return true;
  }
  if (user.isCoach && (match.homeTeamId == user.teamId || match.awayTeamId == user.teamId)) {
    return true;
  }
  return false;
}
```

---

## Implementation Steps

### Step 1: Add Match Management Tab to League Details ✅
- Modify `league_tournament_details_screen.dart`
- Add 4th tab "MANAGE"
- Show only if user has management permissions

### Step 2: Create Match Management Screen ✅
- Full-screen match management interface
- 5 tabs: Score, Goals, Cards, MVP, Squad
- Navigation from match list

### Step 3: Implement Score Entry Widget ✅
- Text fields for home/away scores
- Submit button
- Accept/Reject buttons (for opponent)
- Status display (pending/confirmed)

### Step 4: Implement Goal Entry Widget ✅
- List of recorded goals
- Add goal dialog (player selector + minute input)
- Delete goal option
- Team selector (home/away)

### Step 5: Implement Card Entry Widget ✅
- List of recorded cards
- Add card dialog (type + player + minute)
- Delete card option
- Visual distinction (yellow/red)

### Step 6: Implement MVP Selection Widget ✅
- Current MVP display
- Player selector dialog
- Confirm selection

### Step 7: Implement Squad Management Widget ✅
- Starting XI grid (11 players)
- Substitutes list (7 players)
- Player selector
- Position assignment

### Step 8: Add Providers for Match Management ✅
- State notifiers for each action
- Error handling
- Loading states
- Success feedback

### Step 9: Testing ✅
- Test all CRUD operations
- Test role-based access
- Test error scenarios
- Test UI responsiveness

---

## Timeline Estimate

| Task | Estimated Time |
|------|---------------|
| Match Management Tab | 1 hour |
| Match Management Screen | 2 hours |
| Score Entry Widget | 1 hour |
| Goal Entry Widget | 1.5 hours |
| Card Entry Widget | 1.5 hours |
| MVP Selection Widget | 1 hour |
| Squad Management Widget | 2 hours |
| Providers & State Management | 2 hours |
| Testing & Bug Fixes | 2 hours |
| **Total** | **14 hours (~2 days)** |

---

## Success Criteria

- ✅ Match management tab visible to authorized users only
- ✅ Score entry and acceptance workflow functional
- ✅ Goal scorers can be added/removed with timestamps
- ✅ Cards can be added/removed with player and minute
- ✅ MVP can be selected from match participants
- ✅ Squad lineup can be managed
- ✅ All API calls successful with proper error handling
- ✅ UI is responsive and user-friendly
- ✅ Loading and success states displayed
- ✅ Matches Android functionality

---

## Notes

- Match photos/videos upload is optional and can be added later
- Match rating system is optional
- Focus on core match management features first
- Ensure proper validation (e.g., minute must be 0-90+)
- Handle extra time minutes (90+1, 90+2, etc.)
- Support penalty shootout scores for Cup matches

---

*Phase 5 Planning Document - Created: Current Session*
