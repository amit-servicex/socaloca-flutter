# Tournaments Tab Refactoring Plan

## Overview
Refactor the Flutter tournaments feature to match the comprehensive Android implementation documented in `TOURNAMENTS_TAB_DOCUMENTATION.md`.

## Current State Analysis

### Existing Implementation
- ✅ Basic tournament listing (Ongoing, Upcoming, My Leagues, Closed)
- ✅ Tournament filters (game type, age group, gender, country, visibility)
- ✅ Tournament detail screen with banner slider
- ✅ Basic matches, points table, and stats tabs
- ✅ Follow/unfollow functionality
- ✅ Repository with API integration

### Missing Features
- ❌ Separate League vs Cup tournament types
- ❌ Cup-specific screens (Group Stage, Knockout Bracket)
- ❌ Tournament management tab (Admin/Referee only)
- ❌ Full tournament details screen (separate from featured)
- ❌ Match management features
- ❌ Cup stats (Group Mode vs Match Mode)
- ❌ Invitation system
- ❌ Request to join flow
- ❌ Withdraw from tournament
- ❌ Role-based access control

## Architecture Changes

### 1. Data Models (Freezed)

#### New Models Needed:
```dart
// Cup-specific models
- TournamentCupModel (extends TournamentModel with rounds, startedOn, etc.)
- CupRoundModel (roundId, roundName, mode: GROUP/KNOCKOUT, etc.)
- CupGroupModel (groupId, groupName, leg1, leg2 matches)
- CupLeagueModel (match within a group)
- CupMatchModel (knockout bracket match)

// Match management models
- MatchScoreModel
- MatchGoalModel
- MatchCardModel
- MatchMVPModel
- MatchPlayerModel

// Invitation models
- TournamentInviteModel
- JoinRequestModel
```

### 2. Screen Hierarchy

```
TournamentsLandingScreen (with LOCAL/GLOBAL toggle)
├── OngoingTournamentsTab
├── UpcomingTournamentsTab
├── MyLeaguesCupsTab
└── ClosedTournamentsTab
    │
    └── [Tap tournament card]
        │
        ├── [If tmntType = LEAGUE]
        │   └── LeagueTournamentDetailsScreen
        │       ├── Banner + Header + Info Card
        │       ├── Teams & Sponsors sections
        │       ├── [Request to Join] button
        │       └── Tabs:
        │           ├── MatchesTab (Upcoming/Played sub-tabs)
        │           ├── PointsTableTab
        │           └── ManageTab (Admin/Referee only)
        │
        └── [If tmntType = CUP]
            └── CupTournamentDetailsScreen
                ├── Banner + Header + Info Card
                ├── Teams & Sponsors sections
                ├── [Request to Join] button
                └── Tabs:
                    ├── InfoTab (tournament details)
                    ├── StageTab
                    │   ├── [If group stage] GroupModeView
                    │   │   ├── Group selector
                    │   │   ├── Matches list
                    │   │   └── [View Standings] → GroupPointTableScreen
                    │   └── [If knockout] KnockoutBracketView
                    │       └── Bracket tree visualization
                    └── StatsTab
                        ├── GroupModeStats (Goals/Assists/Cards/MOM)
                        └── MatchModeStats (Goals/Assists/Cards/MOM)
```

### 3. Repository Methods

#### Existing (Keep):
- ✅ getTournaments()
- ✅ getMyTournaments()
- ✅ getTournamentDetails()
- ✅ followTournament()
- ✅ getTournamentMatches()
- ✅ getPointsTable()
- ✅ getTournamentStats()

#### New Methods Needed:
```dart
// Cup-specific
- getCupDetails()
- getCupReadyDetail()
- getCupGroupMatches()
- getCupLeagueTable()
- getCupKnockMatches()
- getCupGroupStats() (goals, assists, cards, mom)
- getCupMatchStats() (goals, assists, cards, mom)

// Join/Invite flow
- checkReqForTmnt()
- getMyTeamsForTmnt()
- requestTmnt()
- acceptTmntRequest()
- checkReqForCup()
- getMyTeamsForCup()
- requestCup()
- acceptCupRequest()
- getWithdrawTmntTeams()
- withdrawTeam()

// Match management (Admin/Referee)
- sendMatchScore()
- acceptMatchScore()
- saveMatchGoalDetails()
- saveMatchCardDetails()
- saveMatchMvp()
- updateMatchPlayers()
- saveMatchPhotos()
- saveMatchVideos()
- saveMatchRating()
```

### 4. Providers (Riverpod)

```dart
// Tournament list providers
- ongoingTournamentsProvider (family with filters)
- upcomingTournamentsProvider (family with filters)
- myTournamentsProvider
- closedTournamentsProvider (family with filters)

// Detail providers
- tournamentDetailsProvider (family by tournamentId)
- cupDetailsProvider (family by tournamentId)

// Match providers
- tournamentMatchesProvider (family by tournamentId + isUpcoming)
- pointsTableProvider (family by tournamentId)
- tournamentStatsProvider (family by tournamentId + statType)

// Cup-specific providers
- cupGroupMatchesProvider (family by tournamentId + roundId + groupId)
- cupGroupPointTableProvider (family by tournamentId + groupId)
- cupKnockoutMatchesProvider (family by tournamentId + roundId)
- cupGroupStatsProvider (family by tournamentId + statType)
- cupMatchStatsProvider (family by tournamentId + statType)

// Management providers
- matchManagementProvider (family by matchId)
- invitationsProvider (family by tournamentId)
- joinRequestProvider
```

## Implementation Phases

### Phase 1: Core Data Layer (Priority: HIGH)
1. Create all Freezed models for Cup tournaments
2. Add Cup-specific repository methods
3. Generate freezed files
4. Update API constants if needed

### Phase 2: League Tournament Details (Priority: HIGH)
1. Create comprehensive LeagueTournamentDetailsScreen
2. Implement full info card with all fields
3. Add teams and sponsors horizontal lists
4. Implement invitation system UI
5. Add "Request to Join" flow

### Phase 3: Cup Tournament Details (Priority: HIGH)
1. Create CupTournamentDetailsScreen
2. Implement Group Stage view
   - Group selector
   - Matches list per group
   - Group point table
3. Implement Knockout Bracket view
   - Bracket tree visualization
   - Round selector
4. Add Cup-specific stats tabs

### Phase 4: Match Management (Priority: MEDIUM)
1. Create ManageTab (role-based visibility)
2. Implement score entry UI
3. Add goal scorers management
4. Add cards management
5. Add MVP selection
6. Add squad management

### Phase 5: Enhanced Features (Priority: LOW)
1. Add withdraw from tournament
2. Implement match photos/videos upload
3. Add match rating system
4. Enhance search and filters
5. Add tournament creation (if needed)

## File Structure

```
lib/features/tournaments/
├── data/
│   ├── models/
│   │   ├── tournament_models.dart (existing - enhance)
│   │   ├── cup_models.dart (new)
│   │   ├── match_management_models.dart (new)
│   │   └── invitation_models.dart (new)
│   └── repositories/
│       ├── tournament_repository.dart (existing - enhance)
│       ├── cup_repository.dart (new)
│       └── match_management_repository.dart (new)
├── providers/
│   ├── tournament_providers.dart (new)
│   ├── cup_providers.dart (new)
│   └── match_management_providers.dart (new)
├── screens/
│   ├── tournaments_landing_screen.dart (existing - enhance)
│   ├── tournament_list_screen.dart (existing - keep)
│   ├── league/
│   │   ├── league_tournament_details_screen.dart (new)
│   │   ├── league_matches_tab.dart (new)
│   │   ├── league_points_table_tab.dart (new)
│   │   ├── league_stats_tab.dart (new)
│   │   └── league_manage_tab.dart (new)
│   ├── cup/
│   │   ├── cup_tournament_details_screen.dart (new)
│   │   ├── cup_info_tab.dart (new)
│   │   ├── cup_stage_tab.dart (new)
│   │   ├── cup_group_mode_screen.dart (new)
│   │   ├── cup_group_point_table_screen.dart (new)
│   │   ├── cup_knockout_bracket_screen.dart (new)
│   │   └── cup_stats_tab.dart (new)
│   └── management/
│       ├── match_score_screen.dart (new)
│       ├── match_goals_screen.dart (new)
│       ├── match_cards_screen.dart (new)
│       └── match_mvp_screen.dart (new)
└── widgets/
    ├── tournament_card.dart (existing - keep)
    ├── tournament_filters.dart (existing - enhance)
    ├── tournament_info_card.dart (new)
    ├── teams_horizontal_list.dart (new)
    ├── sponsors_horizontal_list.dart (new)
    ├── cup_bracket_widget.dart (new)
    ├── group_selector_widget.dart (new)
    └── match_management_card.dart (new)
```

## Key Differences from Android

### Simplifications:
1. Use single repository pattern instead of separate adapters
2. Riverpod providers instead of ViewPagers
3. GoRouter navigation instead of fragment transactions
4. Unified theme system (AppColors)

### Enhancements:
1. Type-safe navigation with GoRouter
2. Immutable state with Freezed
3. Better error handling with ApiException
4. Reactive UI with Riverpod
5. Cached network images

## Testing Strategy

1. Unit tests for all repository methods
2. Widget tests for key screens
3. Integration tests for join/invite flow
4. Manual testing with different user roles

## Migration Notes

- Keep existing `tournament_featured_screen.dart` for backward compatibility
- Gradually migrate to new detail screens
- Update routes in `app_router.dart`
- Add new route constants in `app_routes.dart`

## Timeline Estimate

- Phase 1: 2-3 days
- Phase 2: 3-4 days
- Phase 3: 4-5 days
- Phase 4: 3-4 days
- Phase 5: 2-3 days

**Total: ~14-19 days**

## Next Steps

1. Review and approve this plan
2. Start with Phase 1 (Core Data Layer)
3. Implement incrementally with testing
4. Update documentation as we go
