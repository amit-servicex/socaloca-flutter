# Teams Feature - Complete Specification

## Overview
Based on the Android app screenshot and `FanTeamsFragment.java` analysis, the Teams screen is a **single screen with filters** (no tabs), allowing users to search for teams with various criteria.

---

## UI Layout (From Screenshot)

```
┌─────────────────────────────────────────────────────┐
│ ← Teams          [Profile] [Search] [Bell] [Menu]   │
├─────────────────────────────────────────────────────┤
│  ┌──────────┐  ┌──────────┐                         │
│  │  India   │  │ Location │                         │
│  └──────────┘  └──────────┘                         │
│  ┌──────────┐  ┌──────────┐                         │
│  │  Game  ▼ │  │ Gender ▼ │                         │
│  └──────────┘  └──────────┘                         │
│  ┌─────────────────────────┐                        │
│  │  Age Range            ▼ │                        │
│  └─────────────────────────┘                        │
│  ┌─────────────────────────┐                        │
│  │  Age Category         ▼ │                        │
│  └─────────────────────────┘                        │
│  ┌─────────────────────────┐                        │
│  │          GO             │                        │
│  └─────────────────────────┘                        │
├─────────────────────────────────────────────────────┤
│  ┌────┐  Football | 2024                            │
│  │ 🏆 │  BLUE DEVILS FC                             │
│  └────┘  India                                      │
│          0 Member                                   │
│          Rating ─────────                           │
│                                    ┌──────┐         │
│                                    │ VIEW │         │
│                                    └──────┘         │
├─────────────────────────────────────────────────────┤
│  ┌────┐  Football | 2024                            │
│  │ 🏆 │  PIRATES FC                                 │
│  └────┘  India                                      │
│          0 Member                                   │
│          Rating ─────────                           │
│                                    ┌──────┐         │
│                                    │ VIEW │         │
│                                    └──────┘         │
└─────────────────────────────────────────────────────┘
```

---

## API Integration

### Endpoint
**API Name**: `getTeams`  
**Method**: POST  
**Base URL**: `https://organise.socaloca.football:9757/`

### Request Parameters
```json
{
  "userId": "string (required)",
  "country": "string (user's country)",
  "city": "string (location filter)",
  "gender": "string (male/female, lowercase)",
  "ageGroup": "string (<13, <15, <18, <20, 21-30, 31-40, >40)",
  "ageCat": "string (U-7 to U-23, Senior, Veteran)",
  "gameType": "string (Football/Futsal)",
  "start": "number (pagination offset)",
  "limit": "number (items per page, default: 10)"
}
```

### Response Structure
```json
{
  "status": 1,
  "teams": [
    {
      "teamId": "string",
      "teamName": "string",
      "teamShortName": "string",
      "teamImage": "string",
      "country": "string",
      "city": "string",
      "gameType": "string",
      "gender": "string",
      "ageCategory": "string",
      "ageGroup": "string",
      "memberCount": "number",
      "rating": "number",
      "createdOn": "number",
      "admins": [],
      "teamPlayers": []
    }
  ]
}
```

---

## Filter Options

### 1. Country (Read-only)
- Shows user's current country
- Not editable (fixed to user's country)

### 2. Location (Text Input)
- Placeholder: "Location"
- Free text input for city/location
- Optional filter

### 3. Game Type (Dropdown)
- Options: "Game" (default), "Football", "Futsal"
- Default: "Game" (no filter)

### 4. Gender (Dropdown)
- Options: "Gender" (default), "Male", "Female"
- Sent as lowercase to API

### 5. Age Range (Dropdown)
- Options: "Age Range" (default), "<13", "<15", "<18", "<20", "21-30", "31-40", ">40"

### 6. Age Category (Dropdown)
- Options: "Age Category" (default), "U-7" through "U-23", "Senior", "Veteran"

---

## Search Behavior

### GO Button
- Triggers search with current filter values
- Shows error if all filters are empty
- Resets pagination (start = 0)
- Clears previous results

### Auto-search on Clear
- When location text is cleared, automatically search with remaining filters

### Infinite Scroll
- Load 10 teams per page
- Load more when scrolled to bottom
- Pagination: `start += limit` after each successful load

---

## Team Card

### Layout
```
┌────────────────────────────────────────────────┐
│  ┌────┐  GameType | Year                       │
│  │ 🏆 │  TEAM NAME                             │
│  └────┘  Country                               │
│          X Member                               │
│          Rating ─────────                      │
│                              ┌──────┐          │
│                              │ VIEW │          │
│                              └──────┘          │
└────────────────────────────────────────────────┘
```

### Components
1. **Team Logo** (Left)
   - Circular image (60x60)
   - Default trophy icon if no image

2. **Game Type & Year** (Top)
   - Format: "Football | 2024"
   - Gray text, 12sp

3. **Team Name** (Below game type)
   - Bold, 16sp, Black

4. **Country** (Below name)
   - Gray text, 14sp

5. **Member Count** (Below country)
   - Format: "X Member" or "X Members"
   - Gray text, 12sp

6. **Rating** (Below members)
   - Progress bar showing team rating
   - Gray text, 12sp

7. **VIEW Button** (Bottom right)
   - Black background, Yellow text
   - Navigates to Team Bio screen

---

## Team Bio Screen

### API
**Endpoint**: `getTeamBio`  
**Parameters**: `{ "teamId": "string" }`

### Response
```json
{
  "status": 1,
  "teamBio": {
    "teamDetails": {
      "teamId": "string",
      "teamName": "string",
      "teamImage": "string",
      "country": "string",
      "ageCategory": "string",
      "gameType": "string",
      "coachName": "string",
      "memberCount": "number",
      "teamWork": "number",
      "technical": "number",
      "aggressiveness": "number",
      "tactical": "number",
      "overall": "number"
    },
    "players": [
      {
        "userId": "string",
        "firstName": "string",
        "lastName": "string",
        "profileImage": "string",
        "playPosition": "string"
      }
    ]
  }
}
```

### UI Sections
1. **Header**
   - Team image/logo
   - Team name
   - Country
   - Age category
   - Game type
   - Coach name (if available)
   - Member count

2. **Team Stats (Progress Bars)**
   - Team Work
   - Technical
   - Aggressiveness
   - Tactical
   - Overall

3. **Players Section**
   - Shows first 4 player avatars
   - "View Players" button to see all
   - Grid of player cards

4. **Recent Matches**
   - Horizontal list of recent matches
   - Match cards with scores

---

## States

### 1. Initial State
- All filters empty (except country)
- No teams displayed
- Shows empty state or initial message

### 2. Loading State
- Show loading indicator while fetching
- Disable GO button and filters

### 3. Results State
- Display list of team cards
- Enable infinite scroll
- Show team count

### 4. Empty Results State
- Show "No teams found" message
- Suggest adjusting filters

### 5. Error State
- Show error message
- Display retry button

---

## Implementation Structure

```
lib/features/teams/
├── data/
│   ├── models/
│   │   ├── team_model.dart (freezed)
│   │   ├── team_bio_model.dart (freezed)
│   │   └── team_filter_model.dart
│   └── repositories/
│       └── teams_repository.dart
├── providers/
│   ├── teams_provider.dart (Riverpod)
│   └── team_bio_provider.dart (Riverpod)
├── screens/
│   ├── teams_screen.dart (NEW - replaces tabbed version)
│   └── team_bio_screen.dart
└── widgets/
    ├── team_filter_section.dart
    ├── team_card.dart
    ├── team_bio_header.dart
    ├── team_stats_section.dart
    ├── team_players_section.dart
    └── team_recent_matches_section.dart
```

---

## Key Differences from Current Implementation

### Current (WRONG)
- Has 4 tabs: All, Joined, Pending, Received
- Tab-based navigation
- Multiple fragments

### Correct (Based on Screenshot)
- **Single screen** with filters
- No tabs
- Filter-based search
- GO button to trigger search
- Infinite scroll for results

---

## Testing Checklist

- [ ] Country shows user's country
- [ ] Location text input works
- [ ] All dropdowns work correctly
- [ ] GO button triggers search
- [ ] Error shown when all filters empty
- [ ] Auto-search when location cleared
- [ ] Infinite scroll loads more teams
- [ ] Team cards display correctly
- [ ] VIEW button navigates to Team Bio
- [ ] Team Bio shows all sections
- [ ] Team Bio loads team details
- [ ] Team Bio shows players
- [ ] Team Bio shows recent matches
- [ ] Empty state shown when no results
- [ ] Error state with retry button

---

## Summary

The Teams feature is a **single-screen filter-based search** (not tabbed) that allows users to find teams by:
- Location (city)
- Game type (Football/Futsal)
- Gender (Male/Female)
- Age range (<13 to >40)
- Age category (U-7 to Veteran)

Each team card has a **VIEW button** that navigates to the **Team Bio screen** showing team details, stats, players, and recent matches.

