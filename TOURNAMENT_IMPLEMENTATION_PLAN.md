# Tournament Feature Implementation Plan

## Overview
Complete implementation plan for migrating the Android tournament feature to Flutter, matching exact UI, flow, and functionality.

---

## Current Status

### ✅ Phase 1 Completed
- Basic models with Freezed
- Repository with API methods
- Landing screen with 4 tabs
- List screen with infinite scroll
- Tournament card widget
- Filter widget skeleton
- Router integration

### ✅ Phase 2 Completed (Core Structure Fixed)
- ✅ Updated models with all missing fields (ageCat, rule, venue, notes, description, prize, regFee, orgDetails, etc.)
- ✅ Added TeamModel, SponsorModel, ItineraryModel, PlayerStatEntry
- ✅ Updated repository with all missing methods (checkInvites, acceptDeclineInvite, getMyTeamsForTournament, requestToJoinTournament, getTournamentStats)
- ✅ Created TournamentFeaturedScreen (banner slider + header + tabs)
- ✅ Created TournamentBannerSlider widget (auto-scrolling with page indicators)
- ✅ Created TournamentHeaderWidget (logo, name, info, follow button)
- ✅ Updated TournamentCard to match Android design exactly
- ✅ Updated TournamentFiltersWidget with Local/Global toggle + bottom sheet pickers
- ✅ Created MatchCard widget
- ✅ Created TournamentMatchesTab (upcoming + played matches)
- ✅ Created TournamentPointsTableTab (scrollable table with all columns)
- ✅ Created TournamentStatsTab (Goals, Assists, Cards, MOM sub-tabs)
- ✅ Updated navigation to open featured screen on card tap
- ✅ All files compile with 0 errors

### ⚠️ Remaining Work
The core structure now matches Android. Remaining items:

1. **Tournament Details Screen**: Full details screen with all info sections (not yet created)
2. **Request to Join Flow**: Dialog to show user's teams and send join request
3. **Invitations Flow**: Accept/decline invitations section
4. **Image Zoom**: Full-screen image viewer for logos and banners
5. **Linkify**: Make URLs clickable in notes, description, prizes, fees, organizer details
6. **Itinerary**: PDF/document viewer
7. **View All Matches**: Full list screens for upcoming/played matches
8. **UI Polish**: Exact color matching, animations, empty states

---

## Android App Architecture Analysis

### Screen Hierarchy

```
CommonTournamentsLandingFragment (Main Entry)
├── Tab 1: Ongoing Tournaments
│   ├── Local/Global Toggle
│   ├── Filters (Country, Game Type, Age Group, Gender, Location)
│   ├── Tournament List (RecyclerView with infinite scroll)
│   └── Click → TournamentsFragment (Featured Tournament View)
│
├── Tab 2: Upcoming Tournaments
│   └── Same structure as Ongoing
│
├── Tab 3: My Leagues/Cups
│   └── User's participating tournaments
│
└── Tab 4: Closed Tournaments
    └── Past tournaments

TournamentsFragment (Featured Tournament Screen)
├── Auto-scrolling Banner Slider (top)
├── Tournament Logo (circular)
├── Tournament Info (name, location, age, game type, dates)
├── Follow Button + Follower Count
├── "View Tournament Details" Button
└── Tabs (Matches, Points Table, Stats)
    ├── TournamentMatchesFragment
    ├── TournamentsPointTableFragment
    └── LeagueStatsFragment
```

### Key Android Components

#### 1. **CommonTournamentsLandingFragment**
- 4 tabs using ViewPager + TabLayout
- Each tab is a separate fragment
- Bottom navigation highlights "Tournaments" icon

#### 2. **CommonOngoingTournamentsFragment** (List Screen)
- **Local/Global Toggle Buttons** (prominent at top)
- **Filter Row**:
  - Country (SearchableSpinner with search)
  - Game Type (Spinner: Football/Futsal)
  - Age Group (Spinner: <10, <12, <15, <18, <20, 21-30, 31-40, >40)
  - Gender (Spinner: Male/Female)
  - Location (EditText with search)
  - GO Button (applies filters)
- **RecyclerView** with infinite scroll
- **Tournament Card** shows:
  - Logo (circular)
  - Name
  - Location
  - Age Group
  - Game Type
  - Status badge
  - Team count
  - Match count
  - Follow count

#### 3. **TournamentsFragment** (Featured Tournament View)
- **Banner Slider** (AutoScrollViewPager)
  - Multiple banners with auto-scroll (2.5s interval)
  - Page indicators
  - Swipeable
- **Tournament Header**:
  - Logo (circular, clickable for zoom)
  - Name
  - Age Group
  - Game Type
  - Location
  - Start Date / Started On
  - Final Submission Date (for upcoming)
  - Follow Button (Following/Follow)
  - Follower Count
- **"View Tournament Details" Button**
- **Tabs** (ViewPager + TabLayout):
  - Matches
  - Points Table
  - Stats

#### 4. **TournamentDetailsFragment** (Full Details Screen)
- Same banner slider
- Same header info
- **Additional Details**:
  - Age Category
  - Gender
  - Game Type
  - Tournament Type (League/Cup)
  - Country
  - Place
  - Tournament Date
  - Venue
  - Total Teams
  - Players Per Team
  - Tournament Note (with clickable links)
  - Description (with clickable links)
  - Prizes (with clickable links)
  - Registration Fees (with clickable links)
  - Organizer Details (with clickable links)
- **Teams Playing** (horizontal RecyclerView)
- **Sponsors** (horizontal RecyclerView)
- **Request to Join** button (for admins/coaches)
- **Invites** section (for pending invitations)
- **Itinerary** button (if available)

#### 5. **TournamentMatchesFragment**
- Two sections:
  - Upcoming Matches
  - Played Matches
- Each match card shows:
  - Team logos
  - Team names
  - Date/Time
  - Venue
  - Score (for played matches)

#### 6. **TournamentsPointTableFragment**
- Table with columns:
  - Position
  - Team Logo
  - Team Name
  - Played (P)
  - Won (W)
  - Drawn (D)
  - Lost (L)
  - Goals For (GF)
  - Goals Against (GA)
  - Goal Difference (GD)
  - Points (Pts)

#### 7. **LeagueStatsFragment**
- Top Scorers
- Top Assists
- Cards Statistics
- Man of the Match

---

## API Endpoints Analysis

### From Android Code

1. **GET_VIS_TMNTS** (`getVisTmnts`)
   - Get visible tournaments (ongoing/upcoming/closed)
   - Filters: userId, country, confed, location, gender, ageGroup, gameType, start, limit, status, ownCountry, visibility
   - Response: `{ status, visibility, tournaments: [...] }`

2. **GET_MY_TMNTS** (`getMyTmnts`)
   - Get user's participating tournaments
   - Params: userId, start, limit
   - Response: `{ status, tournaments: [...] }`

3. **GET_TMNT_DETAILS** (`getTmntDetails`)
   - Get tournament details
   - Params: userId, tournamentId
   - Response: `{ status, details: {...}, teams: [...], sponsors: [...], itinerary: {...} }`
   - Details include: banners array

4. **FOLLOW_TOURNAMENT** (`followTournament`)
   - Follow/unfollow tournament
   - Params: userId, tournamentId, myName, myImageUrl, country, gender, birthYear, isPlayer, isCoach, isAdmin, isFan, followType
   - Response: `{ status, isFollow, success }`

5. **GET_TMNT_MATCHES** (`getTmntMatches`)
   - Get tournament matches
   - Params: tournamentId, status (upcoming/played)
   - Response: `{ status, matches: [...] }`

6. **GET_TMNT_POINTS_TABLE** (`getTmntPointsTable`)
   - Get points table
   - Params: tournamentId
   - Response: `{ status, pointsTable: [...] }`

7. **CHECK_REQ_FOR_LIMIT** (`checkReqForLimit`)
   - Check for tournament invitations
   - Params: userId, tournamentId
   - Response: `{ status, teams: [...] }`

8. **ACCEPT_TMNT_REQUEST** (`acceptTmntRequest`)
   - Accept/decline invitation
   - Params: userId, tournamentId, teamId, accept, parentId, teamName, tmntName
   - Response: `{ status, success, accept }`

9. **GET_MY_TEAMS_FOR_TMNT** (`getMyTeamsForTmnt`)
   - Get user's teams eligible for tournament
   - Params: userId, tournamentId
   - Response: `{ status, teams: [...] }`

10. **REQUEST_TMNT** (`requestTmnt`)
    - Request to join tournament
    - Params: userId, tournamentId, parentId, teamId, teamName, tmntName
    - Response: `{ status, success }`

---

## Flutter Implementation Plan

### Phase 2: Fix Core Structure (PRIORITY)

#### 2.1 Update Models
- [ ] Add missing fields to `TournamentModel`:
  - `ageCat`, `rule`, `venue`, `teamCount`, `teamPlayerLimit`, `teamPlayerType`
  - `notes`, `description`, `prize`, `regFee`, `orgDetails`
  - `parentId`, `createdBy`, `fsdDate`, `fsdTime`, `fsdGmtMs`
  - `visibility`, `confed`
- [ ] Add `ItineraryModel` (doc, canView)
- [ ] Update `BannerModel` to include `seq` for sorting

#### 2.2 Create Featured Tournament Screen
**File**: `lib/features/tournaments/screens/tournament_featured_screen.dart`

This is the screen that opens when clicking a tournament card.

**Structure**:
```dart
- AutoScrolling Banner Slider (carousel_slider package)
  - Page indicators
  - 2.5s auto-scroll interval
- Tournament Header Card
  - Circular logo (clickable for zoom)
  - Name, Age Group, Game Type
  - Location
  - Date info (Starts/Started on + Final Submission)
  - Follow button + follower count
- "View Tournament Details" Button
- TabBarView with 3 tabs:
  - Matches Tab
  - Points Table Tab
  - Stats Tab
```

**Key Features**:
- Auto-scroll pauses on user interaction
- Banner images from S3
- Follow/Unfollow with API integration
- Navigate to full details screen

#### 2.3 Update Tournament List Screen
**File**: `lib/features/tournaments/screens/tournament_list_screen.dart`

**Changes Needed**:
- [ ] Add **Local/Global toggle** at top (prominent buttons)
- [ ] Move filters to **dialog-based** system (not inline)
- [ ] Update tournament card to match Android design exactly
- [ ] Fix infinite scroll to use ScrollView + ViewTreeObserver pattern
- [ ] Add pull-to-refresh
- [ ] Show proper empty state

**Filter Dialog Structure**:
```dart
- Country: Searchable dropdown with all countries
- Game Type: Football / Futsal
- Age Group: <10, <12, <15, <18, <20, 21-30, 31-40, >40
- Gender: Male / Female
- Location: Text input with search
- GO button to apply filters
```

#### 2.4 Create Tournament Details Screen
**File**: `lib/features/tournaments/screens/tournament_details_screen.dart`

Full details screen with all information.

**Structure**:
```dart
- Same banner slider
- Same header
- Expandable sections:
  - Basic Info (age, gender, game type, tournament type, country, place, date, venue)
  - Team Info (total teams, players per team)
  - Notes (with linkify)
  - Description (with linkify)
  - Prizes (with linkify)
  - Registration Fees (with linkify)
  - Organizer Details (with linkify)
- Teams Playing (horizontal scroll)
- Sponsors (horizontal scroll)
- Request to Join button (conditional)
- Invites section (conditional)
- Itinerary button (conditional)
```

#### 2.5 Create Matches Tab Screen
**File**: `lib/features/tournaments/screens/tabs/tournament_matches_tab.dart`

**Structure**:
```dart
- Two sections with headers:
  - Upcoming Matches
  - Played Matches
- Match cards showing:
  - Team logos (both teams)
  - Team names
  - Date/Time
  - Venue
  - Score (for played)
  - Status badge
```

#### 2.6 Create Points Table Tab Screen
**File**: `lib/features/tournaments/screens/tabs/tournament_points_table_tab.dart`

**Structure**:
```dart
- Scrollable table with columns:
  - Pos | Logo | Team | P | W | D | L | GF | GA | GD | Pts
- Sortable columns
- Highlight user's team
- Color coding for positions (top 4, relegation zone)
```

#### 2.7 Create Stats Tab Screen
**File**: `lib/features/tournaments/screens/tabs/tournament_stats_tab.dart`

**Structure**:
```dart
- Top Scorers List
  - Player photo
  - Player name
  - Team name
  - Goals count
- Top Assists List
  - Player photo
  - Player name
  - Team name
  - Assists count
- Cards Statistics
  - Yellow cards
  - Red cards
- Man of the Match
```

#### 2.8 Update Repository
**File**: `lib/features/tournaments/data/tournament_repository.dart`

**Add Missing Methods**:
- [ ] `checkInvites()` - Check for tournament invitations
- [ ] `acceptDeclineInvite()` - Accept/decline invitation
- [ ] `getMyTeamsForTournament()` - Get eligible teams
- [ ] `requestToJoinTournament()` - Request to join
- [ ] `getTournamentStats()` - Get stats (top scorers, assists, etc.)

#### 2.9 Create Widgets

**Banner Slider Widget**
**File**: `lib/features/tournaments/widgets/tournament_banner_slider.dart`
- Auto-scrolling carousel
- Page indicators
- Clickable for zoom
- Pause on interaction

**Tournament Header Widget**
**File**: `lib/features/tournaments/widgets/tournament_header.dart`
- Reusable header for featured and details screens
- Logo, name, info, follow button

**Match Card Widget**
**File**: `lib/features/tournaments/widgets/match_card.dart`
- Team logos, names, score, date, venue

**Points Table Row Widget**
**File**: `lib/features/tournaments/widgets/points_table_row.dart`
- Table row with all columns

**Player Stats Card Widget**
**File**: `lib/features/tournaments/widgets/player_stats_card.dart`
- Player photo, name, team, stats

**Filter Dialog Widget**
**File**: `lib/features/tournaments/widgets/tournament_filter_dialog.dart`
- Complete filter dialog matching Android

#### 2.10 Update Router
**File**: `lib/core/router/app_router.dart`

**Add Routes**:
```dart
- /tournaments/featured/:id - Featured tournament view
- /tournaments/details/:id - Full details view
- /tournaments/match/:id - Match details
- /tournaments/team/:id - Team profile
```

---

### Phase 3: UI Polish & Exact Matching

#### 3.1 Colors & Styling
- [ ] Extract exact colors from Android XML layouts
- [ ] Match font sizes, weights, spacing
- [ ] Match border radius, shadows, elevations
- [ ] Match button styles (Local/Global toggle, Follow button)

#### 3.2 Animations
- [ ] Banner auto-scroll animation
- [ ] Page transition animations
- [ ] Pull-to-refresh animation
- [ ] Shimmer loading states

#### 3.3 Empty States
- [ ] No tournaments found
- [ ] No matches
- [ ] No teams
- [ ] No sponsors
- [ ] Network error states

---

### Phase 4: Advanced Features

#### 4.1 Image Zoom
- [ ] Implement image zoom for logos and banners
- [ ] Full-screen image viewer

#### 4.2 Linkify
- [ ] Make URLs clickable in notes, description, prizes, fees, organizer details
- [ ] Open in browser or in-app webview

#### 4.3 Request to Join Flow
- [ ] Show user's teams in dialog
- [ ] Send join request
- [ ] Handle success/error states

#### 4.4 Invitations Flow
- [ ] Show pending invitations
- [ ] Accept/Decline with confirmation
- [ ] Update UI after action

#### 4.5 Itinerary
- [ ] Open PDF/document viewer
- [ ] Handle document download

---

### Phase 5: Testing & Optimization

#### 5.1 Testing
- [ ] Test all filter combinations
- [ ] Test infinite scroll
- [ ] Test pull-to-refresh
- [ ] Test follow/unfollow
- [ ] Test navigation flows
- [ ] Test with empty data
- [ ] Test with network errors

#### 5.2 Performance
- [ ] Optimize image loading (cached_network_image)
- [ ] Implement pagination properly
- [ ] Lazy load tabs
- [ ] Debounce filter changes

#### 5.3 Accessibility
- [ ] Add semantic labels
- [ ] Test with screen reader
- [ ] Ensure proper contrast ratios
- [ ] Add tooltips where needed

---

## File Structure

```
lib/features/tournaments/
├── data/
│   ├── tournament_models.dart (UPDATE)
│   └── tournament_repository.dart (UPDATE)
├── screens/
│   ├── tournaments_landing_screen.dart (EXISTING)
│   ├── tournament_list_screen.dart (UPDATE)
│   ├── tournament_featured_screen.dart (NEW)
│   ├── tournament_details_screen.dart (NEW)
│   └── tabs/
│       ├── tournament_matches_tab.dart (NEW)
│       ├── tournament_points_table_tab.dart (NEW)
│       └── tournament_stats_tab.dart (NEW)
└── widgets/
    ├── tournament_card.dart (UPDATE)
    ├── tournament_filters.dart (UPDATE to dialog)
    ├── tournament_banner_slider.dart (NEW)
    ├── tournament_header.dart (NEW)
    ├── match_card.dart (NEW)
    ├── points_table_row.dart (NEW)
    ├── player_stats_card.dart (NEW)
    └── tournament_filter_dialog.dart (NEW)
```

---

## Dependencies to Add

```yaml
dependencies:
  carousel_slider: ^4.2.1  # For banner slider
  flutter_linkify: ^6.0.0  # For clickable links
  photo_view: ^0.14.0      # For image zoom
  flutter_pdfview: ^1.3.2  # For itinerary documents
```

---

## Key Differences from Current Implementation

| Current | Android (Correct) |
|---------|-------------------|
| Direct tournament details | Featured tournament view with tabs |
| Inline filters | Dialog-based filters |
| No Local/Global toggle | Prominent Local/Global toggle |
| Simple list | List with infinite scroll + pull-to-refresh |
| No banner slider | Auto-scrolling banner slider |
| Wrong tab structure | Matches, Points Table, Stats tabs |
| Missing follow functionality | Follow button with count |
| No request to join | Request to join for admins/coaches |
| No invitations | Invitations section |
| No itinerary | Itinerary button |

---

## Implementation Priority

1. **CRITICAL** (Phase 2): Fix core structure to match Android
2. **HIGH** (Phase 3): UI polish and exact matching
3. **MEDIUM** (Phase 4): Advanced features
4. **LOW** (Phase 5): Testing and optimization

---

## Estimated Timeline

- Phase 2: 3-4 days
- Phase 3: 2 days
- Phase 4: 2-3 days
- Phase 5: 1-2 days

**Total**: 8-11 days for complete implementation

---

## Notes

- The Android app has separate implementations for Fan, Common, and Referee users
- Current Flutter implementation should handle all user types
- Banner slider is a key visual element - must be implemented correctly
- Local/Global toggle is critical for filtering
- Follow functionality is important for user engagement
- Request to join and invitations are admin/coach features
- All text fields with links must use Linkify
- Images must be zoomable
- Infinite scroll must be smooth and performant

---

## Next Steps

1. Review this plan with team
2. Start Phase 2.1 (Update Models)
3. Implement Phase 2.2 (Featured Tournament Screen)
4. Continue sequentially through phases
5. Test each phase before moving to next
