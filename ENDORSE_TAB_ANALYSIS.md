# Endorse Tab - Complete Analysis & Implementation Plan

## Overview
The Endorse tab is the default tab (Tab 2) in the Player Bio screen. It displays comprehensive player information including bio details, endorsements, stats, matches, training, teams, academies, tournaments, skills, and posts.

## Sections in Endorse Tab (Top to Bottom)

### 1. ✅ Bio Details Section (IMPLEMENTED)
**Location**: Top of Endorse tab
**Data Source**: `getPlayerBio` API
**Display**:
- Born (year or full date)
- Height (cm) - hidden for youth/child
- Gender - shown for youth/child only
- Preferred Foot
- Playing Level
- Jersey Size
- Shoe Size (with unit)
- Nationality
- About Me (if available)

**Status**: ✅ Already implemented in `PlayerBioDetailsSection`

---

### 2. ⏳ Endorsements Section
**API**: `GET_ENDORSES` (`/getEndorses`)
**Parameters**:
```json
{
  "userId": "playerId",
  "endType": "accept",
  "start": 0,
  "limit": 1
}
```

**Response**:
```json
{
  "status": 1,
  "ends": [
    {
      "comment": "Great player with excellent skills",
      "addedOn": 1234567890,
      "published": 1,
      "userDetails": {
        "userId": "user123",
        "firstName": "John",
        "lastName": "Doe",
        "imageUrl": "profile.jpg",
        "isPlayer": true,
        "isCoach": false,
        "isAdmin": false,
        "isFan": false
      },
      "academy": {
        "academyId": "aca123",
        "name": "Elite Football Academy"
      }
    }
  ]
}
```

**Display**:
- User avatar (circular, clickable)
- Review text (endorsement comment)
- Full name of endorser
- Role (Player/Coach/Manager/Fan)
- Academy name (if applicable, clickable)
- Published date (dd.MM.yyyy format)
- "View All" button

**Visibility**: Hidden if no endorsements

---

### 3. ⏳ Competition Stats Summary
**API**: Same as Stats tab (`/getPlayerStats`) but displayed differently
**Display**: Current year only (no year dropdown)
- Football section with 6 stats
- Futsal section with 6 stats
- Same layout as Stats tab but without year selector

---

### 4. ⏳ My Matches Details (Football)
**API**: `GET_MINI_ACTIVITY` (`/getMiniActivity`)
**Parameters**:
```json
{
  "playerId": "user123"
}
```

**Response**:
```json
{
  "status": 1,
  "football": {
    "matches": 25,
    "mins": 2250,
    "goals": 12,
    "assists": 8,
    "rating": 7.5,
    "year": 2024,
    "cleanSheetCount": 0
  },
  "futsal": { ... },
  "trainCurrMonth": { ... },
  "trainPrevMonth": { ... },
  "lastYear": "2024"
}
```

**Display**:
- Number of Matches
- Minutes Played
- Number of Goals
- Number of Assists (or Clean Sheets for GK)
- Average Match Rating (2 decimal places)
- Year label: "Football, 2024"
- "View All" button
- "Add" button (if own profile and no data)

---

### 5. ⏳ My Matches Details (Futsal)
**API**: Same as above (`/getMiniActivity`)
**Display**: Same structure as Football
- Year label: "Futsal, 2024"

---

### 6. ⏳ Training Stats Details
**API**: Same as above (`/getMiniActivity`)
**Response Fields**:
```json
{
  "trainCurrMonth": {
    "sessions": 12,
    "mins": 720,
    "month": 5
  },
  "trainPrevMonth": {
    "sessions": 10,
    "mins": 600,
    "month": 4
  }
}
```

**Display**:
- Two columns: Previous Month | Current Month
- Month name (full name like "January")
- Number of Sessions
- Training Minutes
- "View All" button
- "Add" button (if own profile and no data)

---

### 7. ⏳ Teams List
**API**: `GET_PLAYER_TEAMS` (`/getPlayerTeams`)
**Parameters**:
```json
{
  "playerId": "user123",
  "start": 0,
  "limit": 20
}
```

**Response**:
```json
{
  "status": 1,
  "teams": [
    {
      "teamId": "team123",
      "teamName": "FC Barcelona",
      "imageUrl": "team_logo.jpg"
    }
  ]
}
```

**Display**:
- Horizontal scrollable list
- Team logo (circular) + Team name
- Left/Right arrow buttons for navigation
- Pagination on scroll
- Clickable to view team bio

---

### 8. ⏳ Academies List
**API**: `GET_USER_ACADEMY` (`/getUserAcademy`)
**Parameters**:
```json
{
  "userId": "user123"
}
```

**Response**:
```json
{
  "status": 1,
  "academys": [
    {
      "academyId": "aca123",
      "name": "Elite Football Academy",
      "imageUrl": "academy_logo.jpg"
    }
  ]
}
```

**Display**:
- Horizontal scrollable list
- Academy logo + Academy name
- Left/Right arrow buttons
- Clickable to view academy bio

---

### 9. ⏳ Tournaments List
**API**: `GET_PLAYER_TMNTS` (`/getPlayerTmnts`)
**Parameters**:
```json
{
  "playerId": "user123",
  "start": 0,
  "limit": 20
}
```

**Response**:
```json
{
  "status": 1,
  "tmnts": [
    {
      "tmntId": "tmnt123",
      "tmntName": "Champions League",
      "imageUrl": "tournament_logo.jpg"
    }
  ]
}
```

**Display**:
- Horizontal scrollable list
- Tournament image + name
- Left/Right arrow buttons
- Pagination on scroll

---

### 10. ⏳ Skills/Ratings Section
**API**: `GET_PLAYER_SKILLS` (`/getPlayerSkills`)
**Parameters**:
```json
{
  "userId": "currentUserId",
  "playerId": "user123",
  "start": 0,
  "limit": 5
}
```

**Response**:
```json
{
  "status": 1,
  "skills": [
    {
      "skillName": "Dribbling",
      "rating": 8.5
    },
    {
      "skillName": "Passing",
      "rating": 7.8
    }
  ],
  "overall": 8.2
}
```

**Display**:
- List of skills with ratings
- Overall rating display
- "View All" button to see all ratings
- "Rate" button (if not own profile)

---

### 11. ⏳ Top Posts Section
**API**: `GET_USER_POSTS` (`/getUserPosts`)
**Parameters**:
```json
{
  "userId": "user123",
  "myId": "currentUserId",
  "start": 0,
  "limit": 5
}
```

**Response**:
```json
{
  "status": 1,
  "posts": [
    {
      "postId": "post123",
      "text": "Great match today!",
      "addedOn": 1234567890,
      "likeCount": 25,
      "commentCount": 10,
      "shareCount": 5,
      "sources": [
        {
          "url": "image1.jpg",
          "type": "IMAGE_URL",
          "thumbnail": "thumb1.jpg"
        }
      ]
    }
  ]
}
```

**Display**:
- Horizontal scrollable list
- Post images/videos
- "View All" button
- Sorted by addedOn (newest first)

---

### 12. ⏳ Tagged Posts/Videos Section
**API**: `GET_PLAYER_ACA_VDOS` (`/getPlayerAcaVdos`)
**Parameters**:
```json
{
  "userId": "currentUserId",
  "playerId": "user123"
}
```

**Response**:
```json
{
  "status": 1,
  "vdos": [
    {
      "postId": "vdo123",
      "url": "video1.mp4",
      "thumbnail": "thumb1.jpg",
      "addedOn": 1234567890,
      "tags": ["user123", "user456"],
      "academy": {
        "academyId": "aca123",
        "name": "Elite Academy"
      }
    }
  ]
}
```

**Display**:
- Horizontal scrollable list
- Tagged videos/posts from academies
- "View All" button
- Sorted by addedOn (newest first)

---

## Implementation Priority

### Phase 2A: Stats & Matches (High Priority)
1. ✅ Competition Stats Summary (reuse Stats tab component)
2. ⏳ My Matches Details (Football)
3. ⏳ My Matches Details (Futsal)
4. ⏳ Training Stats Details
5. ⏳ Endorsements Section

### Phase 2B: Lists (Medium Priority)
6. ⏳ Teams List
7. ⏳ Academies List
8. ⏳ Tournaments List
9. ⏳ Skills/Ratings List

### Phase 2C: Content (Lower Priority)
10. ⏳ Top Posts Section
11. ⏳ Tagged Videos Section

---

## Data Models Needed

### EndorseModel
```dart
class EndorseModel {
  final String? comment;
  final int? addedOn;
  final int? published;
  final UserModel? userDetails;
  final AcademyModel? academy;
}
```

### MatchTrainingStatusModel
```dart
class MatchTrainingStatusModel {
  final int? matches;
  final int? mins;
  final int? goals;
  final int? assists;
  final double? rating;
  final int? year;
  final int? cleanSheetCount;
  final int? sessions; // for training
  final int? month; // for training
}
```

### SkillModel
```dart
class SkillModel {
  final String? skillName;
  final double? rating;
}
```

### TeamModel (may already exist)
```dart
class TeamModel {
  final String? teamId;
  final String? teamName;
  final String? imageUrl;
}
```

### AcademyModel
```dart
class AcademyModel {
  final String? academyId;
  final String? name;
  final String? imageUrl;
}
```

### TournamentModel
```dart
class TournamentModel {
  final String? tmntId;
  final String? tmntName;
  final String? imageUrl;
}
```

### PostModel
```dart
class PostModel {
  final String? postId;
  final String? text;
  final int? addedOn;
  final int? likeCount;
  final int? commentCount;
  final int? shareCount;
  final List<MediaFile>? sources;
}
```

### TaggedPostModel
```dart
class TaggedPostModel {
  final String? postId;
  final String? url;
  final String? thumbnail;
  final int? addedOn;
  final List<String>? tags;
  final AcademyModel? academy;
}
```

---

## UI Components Needed

### Widgets to Create:
1. `EndorsementSection` - Display latest endorsement
2. `CompetitionStatsSection` - Stats summary (reuse from Stats tab)
3. `MyMatchesSection` - Football/Futsal matches
4. `TrainingStatsSection` - Training stats
5. `HorizontalTeamsList` - Teams horizontal scroll
6. `HorizontalAcademiesList` - Academies horizontal scroll
7. `HorizontalTournamentsList` - Tournaments horizontal scroll
8. `SkillsRatingsSection` - Skills list with ratings
9. `TopPostsSection` - Posts horizontal scroll
10. `TaggedVideosSection` - Tagged videos horizontal scroll

---

## API Endpoints Summary

| Section | API Endpoint | Status |
|---------|-------------|--------|
| Bio Details | `/getPlayerBio` | ✅ Implemented |
| Endorsements | `/getEndorses` | ⏳ TODO |
| Competition Stats | `/getPlayerStats` | ✅ Implemented |
| Matches & Training | `/getMiniActivity` | ⏳ TODO |
| Teams | `/getPlayerTeams` | ⏳ TODO |
| Academies | `/getUserAcademy` | ⏳ TODO |
| Tournaments | `/getPlayerTmnts` | ⏳ TODO |
| Skills | `/getPlayerSkills` | ⏳ TODO |
| Posts | `/getUserPosts` | ⏳ TODO |
| Tagged Videos | `/getPlayerAcaVdos` | ⏳ TODO |

---

## Notes

- All sections should have loading states
- All sections should have empty states
- Horizontal lists need left/right arrow buttons
- Pagination for teams and tournaments
- Position-based logic for assists/clean sheets
- Own profile vs other profile visibility rules
- Age-based visibility rules
- Click handlers for navigation to detail screens
