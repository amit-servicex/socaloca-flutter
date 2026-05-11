# Home Screen Implementation Plan

## Task
Implement the Android home screen UI and functionality in Flutter with exact same behavior.

## Android Home Screen Analysis

### Structure (CommonHomeActivity)
The Android app has a complex home screen with:

1. **Header Bar** (56dp height)
   - Back button (left, hidden by default)
   - Logo (center)
   - Search icon
   - Notification icon with unseen badge
   - Hamburger menu (commented out in latest version)

2. **Main Content Area**
   - Fragment container for different screens
   - Default: CommonHomeFeedFragment (social feed)

3. **Live Match Banner** (optional, above footer)
   - Animated GIF icon
   - "Live Match Update" text
   - "VIEW" button

4. **Feedback Box** (optional, above footer)
   - Survey icon
   - "Help us to improve" text
   - "FEEDBACK" button

5. **Bottom Navigation** (6 tabs)
   - Home (Feed)
   - Teams
   - Leagues/Cups
   - Clubs/Partners
   - Trials
   - Academies

6. **Side Drawer Menu** (right side)
   - User profile section
   - SocaLoca ID with copy button
   - Menu items:
     - My Gallery
     - Update Profile
     - Help Desk
     - Change Password
     - Legacy Contact
     - Download Activities
     - Deactivate/Delete Account
     - Change Language
     - Privacy Settings
     - Help Us To Improve
     - Data Policy
     - Terms & Conditions
   - Sign Out

### Key Features

#### Bottom Navigation Behavior
- 6 tabs with icons and labels
- Active tab has yellow circular background
- Tapping tab loads corresponding fragment
- Tab types (from Params.java):
  - `TYPE_FEED = 1` → CommonHomeFeedFragment
  - `TYPE_TEAMS = 2` → PlayerAdminTeamLandingFragment
  - `TYPE_LEAGUES_CUPS = 3` → CommonMatchesLandingFragment
  - `TYPE_CLUB_PARTNERS = 4` → CommonClubsPartnersLandingFragment
  - `TYPE_TRIALS = 5` → Trials screen
  - `TYPE_ACADEMIES = 6` → Academies screen

#### Header Behavior
- Logo always centered
- Back button shows/hides based on navigation
- Search icon opens search screen
- Notification icon shows badge if unseen notifications
- Notification count updated every 5 seconds

#### API Calls
1. **Get Blocked Users** (`GET_USER_BLOCKED`)
   - Called on onCreate
   - Stores blocked user list globally

2. **Get Notification Count** (`getNotificationCount`)
   - Called every 5 seconds via Handler
   - Updates notification badge

3. **Check App Update** (`checkAppUpdate`)
   - Checks for new version
   - Shows "What's New" popup if available

4. **Get Feed** (in CommonHomeFeedFragment)
   - Loads social feed posts
   - Pagination support

---

## Flutter Implementation Plan

### Phase 1: Update Main Shell Screen ✅ (Current)

**Current State:**
- Basic bottom navigation with 5 tabs
- Generic icons
- Routes to different screens

**Required Changes:**
1. Update to 6 tabs matching Android
2. Add custom icons matching Android design
3. Implement yellow circular background for active tab
4. Add proper labels (uppercase, 8sp)
5. Match Android spacing and sizing

### Phase 2: Implement Home Screen Layout

**File:** `lib/features/home/screens/home_screen.dart`

**Components:**
1. **AppBar** (custom)
   - Logo (center)
   - Search icon (right)
   - Notification icon with badge (right)
   - Back button (left, conditional)

2. **Body**
   - Social feed (default)
   - Live match banner (conditional)
   - Feedback box (conditional)

3. **Drawer** (right side)
   - User profile header
   - Menu items list
   - Sign out button

**APIs to Implement:**
- `getUserBlocked` - Get blocked users
- `getNotificationCount` - Get notification count
- `checkAppUpdate` - Check for updates

### Phase 3: Implement Social Feed

**File:** `lib/features/social_feed/screens/social_feed_screen.dart`

**Features:**
- Pull to refresh
- Infinite scroll
- Post types:
  - User posts
  - Club posts
  - Match events
  - Tournament events
- Like, comment, share actions
- Translation support

**API:** `getFeed`

### Phase 4: Implement Other Tab Screens

1. **Teams Tab**
   - File: `lib/features/teams/screens/teams_landing_screen.dart`
   - Shows user's teams
   - Create team button

2. **Leagues/Cups Tab**
   - File: `lib/features/tournaments/screens/tournaments_landing_screen.dart`
   - Shows tournaments and matches
   - Filter by ongoing/upcoming/closed

3. **Clubs/Partners Tab**
   - File: `lib/features/club/screens/clubs_partners_landing_screen.dart`
   - Shows clubs, FAs, sponsors, charities
   - Filter and search

4. **Trials Tab**
   - File: `lib/features/trials/screens/trials_landing_screen.dart`
   - Shows available trials
   - Register for trials

5. **Academies Tab**
   - File: `lib/features/academy/screens/academies_landing_screen.dart`
   - Shows academies
   - Join academy

### Phase 5: Implement Drawer Menu

**File:** `lib/features/home/widgets/home_drawer.dart`

**Features:**
- User profile section with image
- SocaLoca ID with copy functionality
- Menu items with navigation
- Sign out with confirmation

---

## Implementation Priority

### High Priority (MVP)
1. ✅ Update bottom navigation to 6 tabs
2. ✅ Implement custom app bar with logo, search, notifications
3. ✅ Implement social feed screen
4. ✅ Implement notification count API
5. ✅ Implement drawer menu

### Medium Priority
6. Implement teams tab
7. Implement tournaments tab
8. Implement clubs/partners tab
9. Implement live match banner
10. Implement feedback box

### Low Priority
11. Implement trials tab
12. Implement academies tab
13. Implement app update check
14. Implement what's new popup

---

## API Endpoints Required

| Endpoint | Purpose | Priority |
|----------|---------|----------|
| `getFeed` | Get social feed posts | High |
| `getUserBlocked` | Get blocked users | High |
| `getNotificationCount` | Get notification count | High |
| `getMyTeams` | Get user's teams | Medium |
| `getTmnts` | Get tournaments | Medium |
| `getClubs` | Get clubs | Medium |
| `checkAppUpdate` | Check for updates | Low |

---

## Design Specifications

### Colors (from Android)
- Background: `#F6F6F6` (new_white)
- Header: `#FFFFFF` (white)
- Footer: `#FFFFFF` (white)
- Active tab: `#FFD700` (new_yellow)
- Text: `#000000` (new_black)
- Grey: `#EAEAE8` (new_grey)

### Typography
- Header title: Lato Bold, 14sp
- Tab labels: Lato Bold, 8sp, uppercase
- Body text: Poppins Regular, 14sp

### Spacing
- Header height: 56dp
- Footer height: 56dp
- Tab icon size: 30dp
- Tab padding: 8dp (padding_footer)

### Icons
- Home: `ic_home_new`
- Teams: `ic_teams_new`
- Leagues/Cups: `ic_leagues_cups_new`
- Clubs/Partners: `ic_clubs_partners_new`
- Trials: `ic_trials_new`
- Academies: `ic_academies_new_2`

---

## File Structure

```
lib/features/home/
├── screens/
│   ├── main_shell_screen.dart (update)
│   └── home_screen.dart (new)
├── widgets/
│   ├── home_app_bar.dart (new)
│   ├── home_drawer.dart (new)
│   ├── live_match_banner.dart (new)
│   └── feedback_box.dart (new)
├── providers/
│   ├── notification_provider.dart (new)
│   └── blocked_users_provider.dart (new)
└── repositories/
    └── home_repository.dart (new)

lib/features/social_feed/
├── screens/
│   └── social_feed_screen.dart (update)
├── widgets/
│   ├── feed_post_card.dart (new)
│   ├── post_actions.dart (new)
│   └── post_comments.dart (new)
└── repositories/
    └── feed_repository.dart (update)
```

---

## Next Steps

1. Read CommonHomeFeedFragment to understand feed implementation
2. Read feed API structure
3. Implement updated main_shell_screen.dart
4. Implement home_app_bar.dart
5. Implement social_feed_screen.dart with API integration
6. Implement home_drawer.dart
7. Test complete flow

---

**Status**: Planning Complete  
**Date**: May 5, 2026  
**Estimated Time**: 8-10 hours for complete implementation
