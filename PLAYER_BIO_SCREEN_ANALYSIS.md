# Player Bio Screen - Android Implementation Analysis

## Overview
The Player Bio screen (`NewPlayerBioFragment.java`) is a comprehensive profile view for players with two main tabs: **Stats** and **Endorse**. The Endorse tab is selected by default.

## Screen Structure

### Header Section (Always Visible)
- **Player Avatar** (circular, clickable for zoom)
- **Player Name** (First Name + Last Name)
- **Profile Name** (username/handle)
- **Socaloca ID** (SCL ID)
- **GHA ID** (if available)
- **Country Flag Icon**
- **Verification Badge** (if verified)
- **Online/Offline Status Indicator**
- **Preferred Jersey Number** (top-left corner)

### Two Tabs
1. **Stats Tab** (Tab 1)
2. **Endorse Tab** (Tab 2 - Default Selected)

---

## Tab 1: Stats Tab

### Year Dropdown
- Dropdown to select year for viewing player match stats
- Shows stats for selected year
- Separate dropdowns for Football and Futsal

### Competition Stats (Football & Futsal)
**API**: `GET_PLAYER_STATS` (`/getPlayerStats`)
**Parameters**:
- `playerId`: Player's user ID
- `year`: Selected year (default: current year)

**Response Fields**:
- `stats` (Football stats object)
- `statsFutsal` (Futsal stats object)

**Each stats object contains**:
- `matchCount` - Appearances
- `goalCount` - Goals
- `assistCount` - Assists (or cleanSheetCount for goalkeepers)
- `mvpCount` - MVP awards
- `yellowCardCount` - Yellow cards
- `redCardCount` - Red cards
- `cleanSheetCount` - Clean sheets (goalkeepers only)

**Display**:
- Two sections: Football and Futsal
- Each shows: Appearances, Goals, MVP, Assists/Clean Sheets, Yellow Cards, Red Cards
- Year label: "Football, 2024" / "Futsal, 2024"
- "Past Years" link to view all historical stats

---

## Tab 2: Endorse Tab (Default)

### Action Icons Row
- **Follow Button** (FOLLOW/FOLLOWING)
- **Share Icon** (external share)
- **Like/Cheer Icon** (heart icon)
- **Block User Icon** (only for other users)
- **Report User Icon** (only for other users)

### Bio Details Section
**API**: `GET_PLAYER_BIO` (`/getPlayerBio`)
**Parameters**:
- `userId`: Current user's ID
- `playerId`: Player's ID to view

**Response**: `playerDetails` object containing:
- `firstName`, `lastName`, `profileName`
- `imageUrl` - Profile image
- `playPosition` - Position (Goalkeeper, Defender, Attack, Midfield)
- `playPositionType` - Specific position type
- `country`, `countryIso` - Country name and ISO code
- `nationality`, `nationalityIso` - Nationality and ISO
- `preferredJersey` - Jersey number
- `height` - Height in cm
- `preferredFoot` - Left/Right/Both
- `playLevel` - Playing level
- `jerseySize` - Jersey size
- `shoeSize`, `shoeSizeUnit` - Shoe size and unit
- `gender` - Male/Female
- `dob` - Date of birth (dd-MM-yyyy)
- `yearOfBirth` - Year of birth (for added players)
- `type` - USER or ADDED_PLAYER
- `aboutMe` - Bio text
- `postCount` - Number of posts
- `likeCount` - Number of cheers/likes
- `followCount` - Number of followers
- `followingCount` - Number of following
- `followedByMe` - Boolean
- `likedByMe` - Boolean
- `isOnline` - Boolean
- `lastOnline` - Timestamp
- `isVerifyBadge` - Boolean
- `sclId` - Socaloca ID
- `ghaId` - GHA ID (optional)
- `isPlayer`, `isCoach`, `isAdmin`, `isFan` - Role booleans

**Display Fields**:
- Born: Year only (or full date if own profile)
- Height: cm (hidden for youth/child)
- Gender: Male/Female (shown for youth/child only)
- Preferred Foot: Left/Right/Both
- Playing Level: Level text
- Jersey Size: Size
- Shoe Size: Size (unit)
- About Me: Bio text (if available)

### Stats Counters (4 boxes)
- **Posts**: Number of posts (clickable)
- **Cheers**: Number of likes (clickable)
- **Followers**: Number of followers (clickable)
- **Following**: Number of following (clickable)

### Endorsements Section
**API**: `GET_ENDORSES` (`/getEndorses`)
**Parameters**:
- `userId`: Player's ID
- `endType`: "accept" (ENDORSE_ACCEPT)
- `start`: 0
- `limit`: 1 (shows only latest endorsement)

**Response**: `ends` array containing:
- `comment` - Endorsement text
- `addedOn` - Timestamp
- `published` - Published status
- `userDetails` - Endorser user object
  - `firstName`, `lastName`
  - `imageUrl`
  - `isPlayer`, `isCoach`, `isAdmin`, `isFan`
- `academy` - Academy info (if endorser is from academy)
  - `name` - Academy name
  - `academyId`

**Display**:
- User avatar (circular, clickable)
- Review text (endorsement comment)
- Full name of endorser
- Role (Player/Coach/Manager/Fan)
- Academy name (if applicable, clickable)
- Published date (dd.MM.yyyy format)
- "View All" button to see all endorsements

### Competition Stats Summary
Same as Stats Tab but shows current year only (no dropdown)

### My Matches Details (Football)
**API**: `GET_MINI_ACTIVITY` (`/getMiniActivity`)
**Parameters**:
- `playerId`: Player's ID

**Response**:
- `football` - Football match stats object
- `futsal` - Futsal match stats object
- `trainCurrMonth` - Current month training stats
- `trainPrevMonth` - Previous month training stats
- `lastYear` - Last year with data

**Football Match Stats**:
- `matches` - Number of matches
- `mins` - Minutes played
- `goals` - Number of goals
- `assists` - Number of assists (or cleanSheetCount for GK)
- `rating` - Average match rating (decimal)
- `year` - Year of stats
- `cleanSheetCount` - Clean sheets (goalkeepers)

**Display**:
- Number of Matches
- Minutes Played
- Number of Goals
- Number of Assists (or Clean Sheets for GK)
- Average Match Rating (2 decimal places)
- Year label: "Football, 2024"
- "View All" button
- "Add" button (if own profile and no data)

### My Matches Details (Futsal)
Same structure as Football but for Futsal
- Year label: "Futsal, 2024"

### Training Stats Details
**From same API**: `GET_MINI_ACTIVITY`

**Training Stats Objects**:
- `trainCurrMonth`:
  - `sessions` - Number of sessions
  - `mins` - Training minutes
  - `month` - Month number
- `trainPrevMonth`: Same structure

**Display**:
- Two columns: Previous Month | Current Month
- Month name (full name like "January")
- Number of Sessions
- Training Minutes
- "View All" button
- "Add" button (if own profile and no data)

### Teams List
**API**: `GET_PLAYER_TEAMS` (`/getPlayerTeams`)
**Parameters**:
- `playerId`: Player's ID
- `start`: Pagination offset
- `limit`: 20

**Response**: `teams` array containing:
- `teamId`
- `teamName`
- `imageUrl` - Team logo
- Other team details

**Display**:
- Horizontal scrollable list
- Team logo (circular) + Team name
- Left/Right arrow buttons for navigation
- Pagination on scroll

### Academies List
**API**: `GET_USER_ACADEMY` (`/getUserAcademy`)
**Parameters**:
- `userId`: Player's ID

**Response**: `academys` array containing:
- `academyId`
- `name` - Academy name
- `imageUrl` - Academy logo
- Other academy details

**Display**:
- Horizontal scrollable list
- Academy logo + Academy name
- Left/Right arrow buttons
- Clickable to view academy bio

### Tournaments List
**API**: `GET_PLAYER_TMNTS` (`/getPlayerTmnts`)
**Parameters**:
- `playerId`: Player's ID
- `start`: Pagination offset
- `limit`: 20

**Response**: `tmnts` array containing:
- Tournament details
- Tournament name
- Tournament image

**Display**:
- Horizontal scrollable list
- Tournament image + name
- Left/Right arrow buttons
- Pagination on scroll

### Rating/Skills Section
**API**: `GET_PLAYER_SKILLS` (`/getPlayerSkills`)
**Parameters**:
- `userId`: Current user's ID
- `playerId`: Player's ID
- `start`: 0
- `limit`: 5

**Response**: Skills array with ratings
- Skill name
- Skill rating value
- Overall rating calculated

**Display**:
- List of skills with ratings
- Overall rating display
- "View All" button to see all ratings
- "Rate" button (if not own profile)

### Top Posts Section
**API**: `GET_USER_POSTS` (`/getUserPosts`)
**Parameters**:
- `userId`: Player's ID
- `myId`: Current user's ID
- `start`: 0
- `limit`: 5

**Response**: `posts` array containing:
- `postId`
- `text` - Post content
- `addedOn` - Timestamp
- `likeCount`, `commentCount`, `shareCount`
- `sources` - Array of media files (images/videos)
  - `url` - File URL
  - `type` - IMAGE_URL or VIDEO_URL
  - `thumbnail` - Thumbnail URL

**Display**:
- Horizontal scrollable list
- Post images/videos
- "View All" button
- Sorted by addedOn (newest first)

### Tagged Posts/Videos Section
**API**: `GET_PLAYER_ACA_VDOS` (`/getPlayerAcaVdos`)
**Parameters**:
- `userId`: Current user's ID
- `playerId`: Player's ID

**Response**: `vdos` array containing:
- Academy post details
- `tags` - Array of tagged user IDs
- `academy` - Academy info object
- Video/image URL
- `addedOn` - Timestamp

**Display**:
- Horizontal scrollable list
- Tagged videos/posts from academies
- "View All" button
- Sorted by addedOn (newest first)

---

## API Summary

### Primary APIs (Called on Load)
1. **`/getPlayerBio`** - Main player profile data
2. **`/getEndorses`** - Latest endorsement
3. **`/getPlayerStats`** - Competition stats (Football & Futsal)
4. **`/getMiniActivity`** - My matches & training stats
5. **`/getPlayerTeams`** - Teams list
6. **`/getUserAcademy`** - Academies list
7. **`/getPlayerTmnts`** - Tournaments list
8. **`/getPlayerSkills`** - Skills/ratings
9. **`/getUserPosts`** - Top posts
10. **`/getPlayerAcaVdos`** - Tagged videos

### Action APIs
- **`/followUser`** - Follow/unfollow player
- **`/likeUser`** - Like/unlike player
- **`/blockUser`** - Block user
- **`/reportUser`** - Report user
- **`/inviteTeamPlayer`** - Invite player to team
- **`/checkTeamInvite`** - Check if can invite

---

## UI/UX Notes

### Visibility Rules
1. **Follow/Like/Share**: Hidden for youth/child profiles (age-based)
2. **Block/Report**: Only shown for other users (not own profile)
3. **Create Post**: Only shown on own profile
4. **Rate Button**: Only shown for Player/Coach/Admin roles
5. **Invite Box**: Only shown for Coach/Admin viewing other players
6. **Add Buttons**: Only shown on own profile when no data exists
7. **Height**: Hidden for youth/child, shown for adults
8. **Gender**: Shown for youth/child, hidden for adults
9. **Endorsements**: Hidden if no endorsements exist

### Tab Behavior
- **Default Tab**: Endorse tab (Tab 2) is selected by default
- **Stats Tab**: Shows year dropdown for historical data
- **Endorse Tab**: Shows current year stats only (no dropdown)

### Special Cases
- **Goalkeepers**: Show "Clean Sheets" instead of "Assists"
- **Added Players**: Show year of birth instead of full DOB
- **Own Profile**: Show full DOB, edit options, add buttons
- **Other Profiles**: Show year only, follow/like/block options

### Scroll Behavior
- Teams, Academies, Tournaments: Horizontal scroll with arrow buttons
- Posts, Tagged Videos: Horizontal scroll
- Skills/Ratings: Vertical list

---

## Data Models Needed

### PlayerBioModel
- All fields from `playerDetails` response
- Includes user info, stats counters, bio details

### EndorseModel
- Endorsement details
- Endorser user info
- Academy info (optional)

### GameStatsModel
- Football and Futsal stats
- Match counts, goals, assists, cards, MVP

### MatchTrainingStatusModel
- Match stats (football/futsal)
- Training stats (current/previous month)
- Year information

### SkillModel
- Skill name and rating

### TeamModel
- Team ID, name, image

### AcademyModel
- Academy ID, name, image

### TournamentModel
- Tournament details

### PostModel
- Post content, media files, counts

### TaggedPostModel
- Academy post with tags

---

## Implementation Priority

### Phase 1: Basic Profile (High Priority)
1. Header section with player info
2. Tab structure (Stats/Endorse)
3. Bio details section
4. Stats counters (Posts, Cheers, Followers, Following)
5. Action buttons (Follow, Like, Share)

### Phase 2: Stats & Data (Medium Priority)
1. Competition stats (Football/Futsal)
2. My Matches details
3. Training stats
4. Endorsements section

### Phase 3: Lists & Collections (Medium Priority)
1. Teams list
2. Academies list
3. Tournaments list
4. Skills/Ratings list

### Phase 4: Content (Lower Priority)
1. Top posts section
2. Tagged videos section
3. Block/Report functionality

---

## Notes for Flutter Implementation

1. **Use TabBar** for Stats/Endorse tabs
2. **Default to Endorse tab** (initialIndex: 1)
3. **Horizontal Lists**: Use ListView.builder with horizontal scroll
4. **Arrow Buttons**: Show/hide based on scroll position
5. **Pagination**: Implement for teams, tournaments lists
6. **Image Loading**: Handle null/empty URLs gracefully
7. **Age-Based Logic**: Implement visibility rules based on DOB
8. **Role-Based Logic**: Show/hide features based on user role
9. **Goalkeeper Logic**: Switch Assists/Clean Sheets based on position
10. **Error Handling**: Handle API failures gracefully
11. **Loading States**: Show shimmer/skeleton loaders
12. **Empty States**: Show appropriate messages when no data

---

## API Endpoints Reference

```dart
// In ApiConstants
static const String getPlayerBio = '/getPlayerBio';
static const String getEndorses = '/getEndorses';
static const String getPlayerStats = '/getPlayerStats';
static const String getMiniActivity = '/getMiniActivity';
static const String getPlayerTeams = '/getPlayerTeams';
static const String getUserAcademy = '/getUserAcademy';
static const String getPlayerTmnts = '/getPlayerTmnts';
static const String getPlayerSkills = '/getPlayerSkills';
static const String getUserPosts = '/getUserPosts';
static const String getPlayerAcaVdos = '/getPlayerAcaVdos';
static const String followUser = '/followUser';
static const String likeUser = '/likeUser';
static const String blockUser = '/blockUser';
static const String reportUser = '/reportUser';
static const String inviteTeamPlayer = '/inviteTeamPlayer';
static const String checkTeamInvite = '/checkTeamInvite';
```
