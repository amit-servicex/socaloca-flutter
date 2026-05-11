# Academies Tab - Complete Specification & Implementation Guide

## Overview
The Academies tab is a main navigation tab in the SocaLoca app that allows users to discover and browse football academies. Users can filter academies by country and category, view academy details, and navigate to academy bio pages.

---

## 📱 UI Structure (Based on Android Implementation)

### Screen Layout

```
┌─────────────────────────────────────────┐
│  ← Academies          🔍 🔔 ☰          │ ← Header
├─────────────────────────────────────────┤
│                                         │
│  SocaLoca is the home for football      │ ← Description Text
│  academies of any scale, age category,  │
│  playing level, or location. SocaLoca   │
│  provides an innovative and intuitive   │
│  platform designed around the modern    │
│  needs of a football academy.           │
│                                         │
│  ┌───────────────────────────────────┐ │
│  │ India                          ▼  │ │ ← Country Dropdown
│  └───────────────────────────────────┘ │
│                                         │
│  ┌───────────────────────────────────┐ │
│  │ CATEGORY                       ▼  │ │ ← Category Dropdown
│  └───────────────────────────────────┘ │
│                                         │
│  ┌───────────────────────────────────┐ │
│  │             GO                    │ │ ← Search Button
│  └───────────────────────────────────┘ │
│                                         │
│  ─────────────────────────────────────  │ ← Divider
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ ⭕ [Logo]  Elite Academy        │   │ ← Academy Card
│  │            CATEGORY 1           │   │
│  │            Mumbai               │   │
│  │            [VIEW]               │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ ⭕ [Logo]  Champions Academy    │   │ ← Academy Card
│  │            CATEGORY 2           │   │
│  │            Delhi                │   │
│  │            [VIEW]               │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ... (more academy cards)               │
│                                         │
│  [Load more on scroll]                  │
│                                         │
└─────────────────────────────────────────┘
│  HOME  TEAMS  TOURNAMENTS  CLUBS  ACADEMIES │ ← Bottom Nav
└─────────────────────────────────────────┘
```

---

## 🎨 UI Components Breakdown

### 1. Header Section
- **Title**: "Academies"
- **Back Button**: Left arrow (if navigated from elsewhere)
- **Action Icons**: Search, Notifications, Menu (top right)

### 2. Description Text
**Content**:
```
SocaLoca is the home for football academies of any scale, age category, 
playing level, or location. SocaLoca provides an innovative and intuitive 
platform designed around the modern needs of a football academy.
```

**Styling**:
- Font: Poppins Regular
- Size: 12sp
- Color: Black
- Padding: 20dp horizontal, 10dp top, 5dp bottom
- Alignment: Left

### 3. Country Filter Dropdown
**Type**: Searchable Spinner
**Default Value**: User's current country
**Options**: 
- "All" (shows all countries)
- List of all countries from confederation data

**Styling**:
- Height: 42dp
- Background: Light grey rounded (5dp radius)
- Font: Poppins Bold, 12sp
- Padding: 25dp left, 15dp right
- Dropdown arrow: Right side

**Behavior**:
- Opens searchable country list
- On selection, updates filter and triggers search after 250ms delay
- Resets pagination (start = 0)
- Clears existing results

### 4. Category Filter Dropdown
**Type**: Standard Spinner
**Default Value**: "CATEGORY" (placeholder)
**Options**:
- "CATEGORY" (no filter)
- "Cat 1"
- "Cat 2"
- "Cat 3"
- "Cat 4"
- "Cat 5"

**Styling**:
- Height: 42dp
- Background: Light grey rounded (5dp radius)
- Font: Poppins Bold, 12sp
- Padding: 25dp left, 15dp right
- Dropdown arrow: Right side

**Behavior**:
- On selection, updates category filter
- Does NOT auto-trigger search (waits for GO button)

### 5. GO Button
**Type**: Button
**Text**: "GO" (uppercase)

**Styling**:
- Height: 42dp
- Background: Black rounded (5dp radius)
- Font: Poppins Bold, 14sp
- Text Color: Yellow
- Margin: 15dp top

**Behavior**:
- Triggers academy search with current filters
- Resets pagination (start = 0)
- Clears existing results
- Hides keyboard
- Debounced (1500ms) to prevent multiple clicks

### 6. Divider Line
- Height: 0.5dp
- Color: Black
- Margin: 15dp top

### 7. Academy Cards (RecyclerView)
**Layout**: Vertical list with cards

**Card Structure**:
```
┌─────────────────────────────────────┐
│  ⭕ [Logo]  Elite Football Academy  │
│  80x80      CATEGORY 1              │
│             Mumbai, India           │
│             [VIEW]                  │
└─────────────────────────────────────┘
```

**Card Styling**:
- Background: White
- Corner Radius: 10dp
- Elevation: 4dp
- Margin: 5dp horizontal, 10dp top, 5dp bottom
- Padding: 15dp horizontal, 20dp vertical

**Card Components**:

#### a. Academy Logo
- Size: 80x80dp
- Shape: Circular
- Position: Left side, center vertical
- Padding: 3dp
- Fallback: Default logo image
- Image Loading: Glide with crossfade (500ms)

#### b. Academy Name
- Font: Poppins Bold, 16sp
- Color: Black
- Position: Right of logo, 17dp margin
- Max Lines: 2 (with ellipsis)

#### c. Category Label
- Text: "CATEGORY {number}" (e.g., "CATEGORY 1")
- Font: Poppins Bold, 13sp (uppercase)
- Color: Black
- Single line

#### d. City/Location
- Font: Poppins Regular, 12sp
- Color: Black
- Single line

#### e. VIEW Button
- Text: "VIEW" (uppercase)
- Font: Poppins Bold, 12sp
- Background: Black rounded (5dp radius)
- Text Color: Yellow
- Width: 80dp
- Padding: 8dp vertical
- Position: Below details, 12dp margin top
- Alignment: Left aligned with details

**Behavior**:
- Click on "VIEW" button → Navigate to Academy Bio screen
- Pass academyId to bio screen

### 8. Empty State
**Display When**: No academies found after search

**Content**:
- Text: "No academies found."
- Font: Poppins Bold, 12sp
- Color: Black
- Position: Center of screen, 50dp below divider
- Initially hidden (visibility: gone)

### 9. Infinite Scroll
**Behavior**:
- Detects when user scrolls to bottom
- Automatically loads next page (10 items)
- Increments start parameter by limit (10)
- Appends new results to existing list
- Prevents duplicate API calls with loading flag

---

## 📡 API Specification

### Endpoint
**Name**: `getAcademyList`
**Method**: POST
**URL**: `{baseUrl}/getAcademyList`

### Request Parameters

```json
{
  "userId": "string",      // Current user's ID (required)
  "country": "string",     // Country name or empty string for all
  "confed": "string",      // Confederation name (derived from country)
  "category": "string",    // Category number (1-5) or empty string
  "start": 0,              // Pagination start index
  "limit": 10              // Number of items per page
}
```

**Parameter Details**:

| Parameter | Type | Required | Description | Example |
|-----------|------|----------|-------------|---------|
| userId | string | Yes | Current user's ID | "user123" |
| country | string | No | Country name for filtering | "India", "" (all) |
| confed | string | No | Confederation name | "AFC", "" |
| category | string | No | Category number | "1", "2", "" (all) |
| start | number | Yes | Pagination offset | 0, 10, 20 |
| limit | number | Yes | Items per page | 10 |

**Confederation Logic**:
- When country is selected, derive confederation from country
- Use `Utils.Confed.getConfedInfoByCountry(countryName)` logic
- If "All" selected, both country and confed are empty strings

### Response Structure

```json
{
  "status": 1,
  "academys": [
    {
      "academyId": "aca123",
      "type": "academy",
      "name": "Elite Football Academy",
      "headOfAcademy": "John Doe",
      "director": "Jane Smith",
      "manager": "Bob Johnson",
      "countryCode": "+91",
      "countryIso": "IN",
      "mobile": "9876543210",
      "email": "info@eliteacademy.com",
      "address": "123 Main Street",
      "country": "India",
      "city": "Mumbai",
      "formedYear": "2010",
      "category": "1",
      "imageUrl": "academy_logo.jpg",
      "liveTrial": "yes",
      "lat": "19.0760",
      "lng": "72.8777",
      "location": "Mumbai, Maharashtra",
      "about": "Premier football academy...",
      "lastUpdateBy": "admin123",
      "module": "academy",
      "website": "https://eliteacademy.com",
      "createdOn": 1234567890,
      "lastUpdated": 1234567890,
      "isDelete": false,
      "verified": true,
      "verifyBadge": true,
      "profile": true,
      "following": false,
      "survey": 0,
      "step": 0,
      "seq": 1
    }
  ]
}
```

**Response Fields**:

| Field | Type | Description |
|-------|------|-------------|
| status | number | 1 = success, 0 = failure |
| academys | array | Array of academy objects |

**Academy Object Fields**:

| Field | Type | Description | Display Usage |
|-------|------|-------------|---------------|
| academyId | string | Unique academy ID | Navigation parameter |
| name | string | Academy name | Card title |
| category | string | Category number (1-5) | "CATEGORY {number}" label |
| city | string | City name | Location display |
| imageUrl | string | Logo image path | Academy logo |
| country | string | Country name | Location display |
| following | boolean | User follows academy | Follow button state |
| verifyBadge | boolean | Verified badge | Badge display |
| about | string | Academy description | Bio screen |
| formedYear | string | Year established | Bio screen |
| email | string | Contact email | Bio screen |
| mobile | string | Contact phone | Bio screen |
| website | string | Website URL | Bio screen |
| address | string | Full address | Bio screen |
| lat | string | Latitude | Map display |
| lng | string | Longitude | Map display |

---

## 🔄 Data Flow & State Management

### Initial Load
1. Screen opens
2. Set country filter to user's current country
3. Set category to "CATEGORY" (no filter)
4. Automatically trigger `getAcademyList` API
5. Display results in list

### Filter Change Flow
```
User selects country
  ↓
Update country filter
  ↓
Derive confederation from country
  ↓
Wait 250ms (debounce)
  ↓
Reset pagination (start = 0)
  ↓
Clear existing results
  ↓
Call getAcademyList API
  ↓
Display new results
```

### GO Button Flow
```
User clicks GO button
  ↓
Disable button (1500ms debounce)
  ↓
Hide keyboard
  ↓
Reset pagination (start = 0)
  ↓
Clear existing results
  ↓
Call getAcademyList API with current filters
  ↓
Display results
  ↓
Re-enable button
```

### Infinite Scroll Flow
```
User scrolls to bottom
  ↓
Check if not already loading
  ↓
Set loading flag = true
  ↓
Increment start by limit (10)
  ↓
Call getAcademyList API
  ↓
Append new results to existing list
  ↓
Set loading flag = false
```

### Sorting Logic
After receiving results, sort academies by name (alphabetically):
```dart
academies.sort((a, b) => a.name.compareTo(b.name));
```

---

## 🎯 User Interactions

### 1. Country Selection
- **Action**: Tap country dropdown
- **Result**: Opens searchable country list
- **On Select**: Updates filter, auto-searches after 250ms

### 2. Category Selection
- **Action**: Tap category dropdown
- **Result**: Opens category list (Cat 1-5)
- **On Select**: Updates filter (no auto-search)

### 3. GO Button
- **Action**: Tap GO button
- **Result**: Searches with current filters
- **Feedback**: Button disabled for 1.5s

### 4. Academy Card
- **Action**: Tap "VIEW" button
- **Result**: Navigate to Academy Bio screen
- **Data Passed**: academyId

### 5. Scroll to Bottom
- **Action**: Scroll to end of list
- **Result**: Loads next 10 academies
- **Feedback**: Loading indicator (optional)

---

## 📋 State Variables

```dart
// Filters
String? selectedCountry;        // Selected country name
String? selectedConfederation;  // Derived confederation
String? selectedCategory;       // Category number (1-5) or null

// Pagination
int start = 0;                  // Current offset
final int limit = 10;           // Items per page

// Data
List<AcademyModel> academies = [];  // Academy list
bool isLoading = false;             // Loading flag
bool hasMore = true;                // More items available

// UI State
bool showEmptyState = false;    // Show "no academies" message
```

---

## 🎨 Styling Constants

### Colors
```dart
// From Android colors.xml
static const Color newWhite = Color(0xFFFFFFFF);
static const Color newBlack = Color(0xFF000000);
static const Color newYellow = Color(0xFFFFD700);  // SocaLoca yellow
static const Color newGrey = Color(0xFFF5F5F5);    // Light grey
```

### Typography
```dart
// Poppins font family
static const String fontFamily = 'Poppins';

// Font sizes
static const double headerTextSize = 12.0;
static const double cardTitleSize = 16.0;
static const double categorySize = 13.0;
static const double citySize = 12.0;
static const double buttonSize = 12.0;
static const double goButtonSize = 14.0;
```

### Spacing
```dart
static const double horizontalPadding = 20.0;
static const double cardPadding = 15.0;
static const double cardMargin = 5.0;
static const double logoSize = 80.0;
static const double buttonHeight = 42.0;
static const double cornerRadius = 5.0;
static const double cardCornerRadius = 10.0;
```

---

## 🔧 Technical Implementation Notes

### 1. Country List
- Use confederation data utility
- Include "All" option at top
- Default to user's country
- Searchable dropdown

### 2. Image Loading
- Use CachedNetworkImage
- Circular crop for logos
- Crossfade transition (500ms)
- Fallback to default logo
- Thumbnail loading (0.5f)

### 3. Pagination
- Load 10 items per page
- Detect scroll to bottom
- Prevent duplicate API calls
- Append to existing list
- Sort by name after each load

### 4. Debouncing
- Country change: 250ms delay
- GO button: 1500ms disable
- Prevents rapid API calls

### 5. Error Handling
- Network errors: Show error message
- Empty results: Show "No academies found"
- Invalid data: Skip malformed items

### 6. Performance
- RecyclerView for efficient scrolling
- Image caching with Glide/CachedNetworkImage
- Lazy loading with pagination
- Debounced search triggers

---

## 📱 Navigation

### From Academies Tab
**Destination**: Academy Bio Screen
**Trigger**: Tap "VIEW" button on academy card
**Data Passed**: 
```dart
{
  'academyId': 'aca123'
}
```

### To Academies Tab
**From**: Bottom navigation bar
**Icon**: Academies icon (5th position)
**Behavior**: 
- If already on tab, scroll to top
- If coming from other tab, load fresh data

---

## ✅ Acceptance Criteria

### Functional Requirements
- ✅ Display list of academies with logo, name, category, city
- ✅ Filter by country (searchable dropdown)
- ✅ Filter by category (Cat 1-5)
- ✅ GO button triggers search
- ✅ Infinite scroll loads more academies
- ✅ VIEW button navigates to academy bio
- ✅ Empty state shows when no results
- ✅ Default country is user's country
- ✅ Results sorted alphabetically by name

### UI Requirements
- ✅ Match Android design exactly
- ✅ Circular academy logos
- ✅ Card-based layout with elevation
- ✅ Yellow GO button with black background
- ✅ Description text at top
- ✅ Proper spacing and padding
- ✅ Responsive to different screen sizes

### Performance Requirements
- ✅ Smooth scrolling
- ✅ Fast image loading
- ✅ Debounced search triggers
- ✅ Efficient pagination
- ✅ No duplicate API calls

---

## 🚀 Implementation Checklist

### Phase 1: Data Layer
- [ ] Create `AcademyModel` with freezed
- [ ] Create `AcademiesRepository` with `getAcademyList` method
- [ ] Add API constant (already exists: `getAcademyList`)
- [ ] Test API integration

### Phase 2: State Management
- [ ] Create `AcademiesProvider` with Riverpod
- [ ] Implement filter state (country, category)
- [ ] Implement pagination state (start, limit)
- [ ] Implement loading state
- [ ] Implement search methods

### Phase 3: UI Components
- [ ] Create `AcademiesScreen` main screen
- [ ] Create description text widget
- [ ] Create country filter dropdown
- [ ] Create category filter dropdown
- [ ] Create GO button
- [ ] Create `AcademyCard` widget
- [ ] Create empty state widget

### Phase 4: Integration
- [ ] Connect UI to provider
- [ ] Implement infinite scroll
- [ ] Implement navigation to academy bio
- [ ] Add to bottom navigation
- [ ] Test all interactions

### Phase 5: Polish
- [ ] Add loading indicators
- [ ] Add error handling
- [ ] Add image loading states
- [ ] Test on different screen sizes
- [ ] Performance optimization

---

## 📸 Reference Images
Based on the provided screenshot, the implementation should match:
- Header with "Academies" title
- Description text block
- Country dropdown (showing "India")
- Category dropdown
- Black GO button with yellow text
- Empty state message: "No academies found."
- Bottom navigation with Academies highlighted

---

**Status**: ⏳ Documentation Complete - Ready for Implementation
**Next Step**: Get user permission to proceed with Flutter implementation
