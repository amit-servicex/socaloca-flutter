# Notifications Feature - Complete Specification

## Overview
The Notifications feature displays a list of all notifications for the logged-in user. Notifications inform users about various activities such as likes, follows, team invitations, match requests, endorsements, tournament invites, and more. Each notification type has specific navigation behavior when tapped.

**Source Analysis**: 
- Android Fragment: `CommonNotificationsFragment.java` (1018 lines)
- Model: `CommonNotification.java`
- Adapter: `CommonNotificationAdapter.java`
- API: `getNotifications`

---

## API Integration

### Endpoint
**API Name**: `getNotifications`  
**Method**: POST  
**Base URL**: `https://organise.socaloca.football:9757/`

### Request Parameters
```json
{
  "userId": "string (required)",
  "start": "number (required, for pagination)",
  "limit": "number (required, items per page)"
}
```

### Pagination
- **Items per page**: 15
- **Infinite scroll**: Load more when user scrolls to bottom
- **Start calculation**: `start = currentPage * 15`

### Response Structure
```json
{
  "status": 1,
  "notifications": [
    {
      "_id": "string",
      "forUserId": "string",
      "notificationType": "string",
      "imageUrl": "string (optional)",
      "title": "string",
      "body": "string",
      "payload": {
        // Dynamic object based on notification type
      },
      "seen": "boolean",
      "generatedOn": "number (timestamp)"
    }
  ]
}
```

---

## Data Model

### NotificationModel Fields
| Field | Type | Description |
|-------|------|-------------|
| `id` | String | Unique notification ID (`_id` from API) |
| `forUserId` | String | User ID this notification is for |
| `notificationType` | String | Type of notification (see types below) |
| `imageUrl` | String? | Optional image URL (user avatar, team logo, etc.) |
| `title` | String | Notification title |
| `body` | String | Notification body text |
| `payload` | Map<String, dynamic> | Dynamic payload with type-specific data |
| `seen` | bool | Whether notification has been read |
| `generatedOn` | int | Timestamp when notification was generated |

---

## UI Layout

### Screen Structure
```
┌─────────────────────────────────────┐
│  Notifications                      │  ← AppBar
├─────────────────────────────────────┤
│  ┌───────────────────────────────┐  │
│  │ [Avatar] Title            Time │  │  ← Notification Card
│  │          Body text...          │  │
│  └───────────────────────────────┘  │
│  ┌───────────────────────────────┐  │
│  │ [Avatar] Title            Time │  │
│  │          Body text...          │  │
│  └───────────────────────────────┘  │
│  ┌───────────────────────────────┐  │
│  │ [Avatar] Title            Time │  │
│  │          Body text...          │  │
│  └───────────────────────────────┘  │
│                                     │
│  [Loading more...]                  │  ← Infinite scroll
└─────────────────────────────────────┘
```

### Notification Card Components
1. **Avatar/Image** (left side):
   - Circular image (60x60)
   - Shows user avatar, team logo, or default SocaLoca logo
   - Tappable → navigates to bio/profile screen

2. **Content** (center):
   - **Title**: Bold text, notification title
   - **Body**: Regular text, notification message
   - **Time**: Small gray text, relative time (e.g., "2 hours ago")

3. **Background Color**:
   - **Unseen**: White background
   - **Seen**: Light gray background (#F5F5F5)

4. **Tap Behavior**:
   - Tapping card body → navigates based on notification type
   - Tapping avatar → navigates to user/team/organization bio

---

## Notification Types & Navigation

### 50+ Notification Types

#### 1. User Social Actions
| Type | Navigation (Card Tap) | Navigation (Avatar Tap) |
|------|----------------------|------------------------|
| `LIKE_USER` | User Bio | User Bio |
| `FOLLOW_USER` | User Bio | User Bio |
| `NEW_USER_JOIN` | User Bio | User Bio |

#### 2. Team Actions
| Type | Navigation (Card Tap) | Navigation (Avatar Tap) |
|------|----------------------|------------------------|
| `REQ_TEAM_JOIN` | Team Bio | User Bio |
| `RESP_TEAM_JOIN` | Team Bio | Team Bio |
| `INVITE_TEAM_USER` | Team Bio | Team Bio |
| `INVITE_TEAM_PLAYER` | Player Admin Team Landing (tab 3) | Team Bio |
| `ACCEPT_TEAM_PLAYER` | Manage Team Landing (New Players tab) | Manage Team Landing |
| `DECLINE_TEAM_PLAYER` | Manage Team Landing | Manage Team Landing |
| `EDIT_TEAM` | Team Bio | Team Bio |
| `TEAM_ADD_PLAYER` | Team All Players | Team Bio |
| `NEW_TEAM_ALERT` | Team Bio | Team Bio |

#### 3. Match Actions
| Type | Navigation (Card Tap) | Navigation (Avatar Tap) |
|------|----------------------|------------------------|
| `HOST_MATCH` | Match Requests (One-Off Received tab) | User Bio |
| `RESPOND_MATCH_REQ` | Match Manage | User Bio |
| `SEND_MATCH_SCORE` | Match Manage | User Bio |
| `ACCEPT_MATCH_SCORE` | Match Manage | User Bio |
| `SAVE_MATCH_RATING` | Match Manage | User Bio |
| `MATCH_NEWS` | Match Details | Match Details |
| `TEAM_MATCH_RESULT` | Match Details or One-Off Match Details | Match Details |
| `MATCH_ACTIVITY` | Match Stats | User Bio |
| `LIVE_MATCH_UPDATE` | Live Match Details | Live Match Details |

#### 4. Pick-Up Matches
| Type | Navigation (Card Tap) | Navigation (Avatar Tap) |
|------|----------------------|------------------------|
| `PICK_UP_MATCH_REQUEST` | Pick-Up Match Details | User Bio |
| `ACCEPT_PICK_UP_REQUEST` | Pick-Up Match Details | User Bio |
| `NEAR_PICK_UP` | Pick-Up Match Details | Pick-Up Match Details |

#### 5. Tournament Actions
| Type | Navigation (Card Tap) | Navigation (Avatar Tap) |
|------|----------------------|------------------------|
| `TMNT_INVITE` | Tournament Details | Tournament Details |
| `TMNT_ACCEPT` | Tournament Details | Tournament Details |
| `TMNT_CONFIRM` | Tournament Details | Tournament Details |
| `LEAGUE_NOTICE` | Tournament Details | Tournament Details |
| `TEAM_TOURNAMENT` | Tournament Details or Cup Details | Tournament Details |
| `NEW_TMNT_ALERT` | Tournament Details or Cup Details | Tournament Details |
| `FIXTURE_CHANGE` | Tournament Details or Cup Details | Tournament Details |

#### 6. Cup Tournament Actions
| Type | Navigation (Card Tap) | Navigation (Avatar Tap) |
|------|----------------------|------------------------|
| `CUP_INVITE` | Cup Details | Cup Details |
| `CUP_CONFIRM` | Cup Details | Cup Details |
| `CUP_ACCEPT` | Cup Details | Cup Details |
| `CUP_NOTICE` | Cup Details | Cup Details |

#### 7. Social Feed Actions
| Type | Navigation (Card Tap) | Navigation (Avatar Tap) |
|------|----------------------|------------------------|
| `LIKE_POST` | User Gallery | User Bio |
| `NEW_USER_POST` | User Gallery | User Bio |
| `USER_SKILL_POST` | User Gallery | User Bio |
| `USER_TAG_POST` | User Gallery | User Bio |
| `FEED_COMMENT` | User Gallery | User Bio |
| `FEED_COMMENT_LIKE` | User Gallery | User Bio |

#### 8. Endorsements
| Type | Navigation (Card Tap) | Navigation (Avatar Tap) |
|------|----------------------|------------------------|
| `ENDORSE_PLAYER` | Endorsement List | User Bio |
| `NEW_ENDORSE` | Endorsement List | User Bio |

#### 9. Training Activity
| Type | Navigation (Card Tap) | Navigation (Avatar Tap) |
|------|----------------------|------------------------|
| `TRAIN_ACTIVITY` | Training Stats | User Bio |

#### 10. Organization Actions
| Type | Navigation (Card Tap) | Navigation (Avatar Tap) |
|------|----------------------|------------------------|
| `FROM_CLUB` | Club Bio | Club Bio |
| `FROM_FA` | FA Bio | FA Bio |
| `FROM_CONFED` | Confederation Bio | Confederation Bio |
| `FROM_CHARITY_NGO` | Charity Bio | Charity Bio |
| `FROM_SPONSOR` | Sponsor Bio | Sponsor Bio |
| `FROM_ACADEMY` | Academy Bio | Academy Bio |
| `ACCEPT_ACADEMY` | Academy Bio | Academy Bio |

#### 11. Referee Actions
| Type | Navigation (Card Tap) | Navigation (Avatar Tap) |
|------|----------------------|------------------------|
| `ASSIGN_REFEREE` | Referee My Matches | Referee My Matches |

---

## Payload Structure by Type

### User Actions Payload
```json
{
  "userId": "string",
  "isPlayer": "boolean",
  "isCoach": "boolean",
  "isAdmin": "boolean",
  "isFan": "boolean"
}
```

### Team Actions Payload
```json
{
  "teamId": "string",
  "teamDetails": "string (JSON)" // For ACCEPT/DECLINE_TEAM_PLAYER
}
```

### Match Actions Payload
```json
{
  "matchId": "string",
  "matchType": "string", // LEAGUE_MATCH, CUP_GROUP, CUP_KNOCK, ONE_OFF
  "tournamentId": "string (optional)",
  "isAdmin": "boolean (optional)"
}
```

### Tournament Actions Payload
```json
{
  "tournamentId": "string",
  "tmntType": "string" // LEAGUE or CUP
}
```

### Post Actions Payload
```json
{
  "createdBy": "string",
  "postId": "string"
}
```

### Organization Actions Payload
```json
{
  "clubId": "string",
  "faId": "string",
  "confedId": "string",
  "charityId": "string",
  "sponsorId": "string",
  "academyId": "string"
}
```

---

## UI Specifications

### Colors
- **Unseen background**: `Colors.white`
- **Seen background**: `Color(0xFFF5F5F5)` (light gray)
- **Title text**: `Colors.black` (bold)
- **Body text**: `Colors.black87`
- **Time text**: `Colors.grey`

### Typography
- **Title**: 16sp, FontWeight.w600
- **Body**: 14sp, FontWeight.w400
- **Time**: 12sp, FontWeight.w400

### Spacing
- **Card padding**: 16px all sides
- **Avatar size**: 60x60
- **Avatar to content gap**: 12px
- **Title to body gap**: 4px
- **Body to time gap**: 4px
- **Card to card gap**: 1px (divider)

### Images
- **Avatar**: Circular, 60x60
- **Default image**: SocaLoca logo (when imageUrl is null/empty)
- **Image base URL**: `https://soca-loca.s3-us-west-2.amazonaws.com/dev/`

### Time Display
Use relative time format:
- "Just now" (< 1 minute)
- "X minutes ago" (< 60 minutes)
- "X hours ago" (< 24 hours)
- "X days ago" (< 7 days)
- "X weeks ago" (< 4 weeks)
- "X months ago" (< 12 months)
- "X years ago" (>= 12 months)

---

## States

### 1. Loading State
- Show shimmer loading cards (5-6 cards)
- Display while initial data is loading

### 2. Empty State
- Show when no notifications exist
- Display icon + "No notifications yet" message

### 3. Error State
- Show error message if API fails
- Display retry button

### 4. Loaded State
- Display list of notifications
- Show loading indicator at bottom when loading more

---

## Implementation Notes

### 1. Infinite Scroll
- Load 15 notifications initially
- When user scrolls to bottom (80% threshold), load next 15
- Show loading indicator at bottom during pagination
- Stop loading when no more data

### 2. Image Handling
- Check for null/empty imageUrl → use default logo
- Reject `file:///` URLs → use default logo
- Use circular crop for all images
- Cache images for performance

### 3. Time Formatting
- Convert `generatedOn` timestamp to relative time
- Update time display when screen is visible
- Use `timeago` package or custom formatter

### 4. Navigation Logic
- Parse `notificationType` to determine navigation
- Extract required IDs from `payload`
- Check user role flags (isPlayer, isCoach, isAdmin, isFan)
- Navigate to appropriate screen with required parameters

### 5. Seen/Unseen
- Display different background colors
- API handles marking as seen (no client action needed)
- Refresh list when returning from navigation

### 6. Link Detection
- Body text may contain URLs
- Make URLs tappable (use linkify)
- Open URLs in browser

---

## Flutter Implementation Structure

### Files to Create
```
lib/features/notifications/
├── data/
│   ├── models/
│   │   └── notification_model.dart (freezed)
│   └── repositories/
│       └── notifications_repository.dart
├── providers/
│   └── notifications_provider.dart (Riverpod)
├── screens/
│   └── notifications_screen.dart
└── widgets/
    ├── notification_card.dart
    └── notification_shimmer.dart
```

### Dependencies
- `freezed` + `json_serializable` for model
- `riverpod` for state management
- `cached_network_image` for image caching
- `timeago` for relative time formatting
- `flutter_linkify` for URL detection

---

## Testing Checklist

- [ ] Load initial 15 notifications
- [ ] Infinite scroll loads more notifications
- [ ] Seen/unseen background colors display correctly
- [ ] Avatar images load correctly
- [ ] Default logo shows when imageUrl is null/empty
- [ ] Relative time displays correctly
- [ ] Card tap navigates to correct screen for each type
- [ ] Avatar tap navigates to bio screen
- [ ] URLs in body text are tappable
- [ ] Empty state displays when no notifications
- [ ] Error state displays on API failure
- [ ] Loading states display correctly
- [ ] All 50+ notification types navigate correctly

---

## API Response Example

```json
{
  "response": {
    "notifications": [
      {
        "_id": "507f1f77bcf86cd799439011",
        "forUserId": "507f191e810c19729de860ea",
        "notificationType": "LIKE_USER",
        "imageUrl": "users/avatar123.jpg",
        "title": "John Doe liked your profile",
        "body": "John Doe liked your profile. Check out their profile!",
        "payload": {
          "userId": "507f191e810c19729de860eb",
          "isPlayer": true,
          "isCoach": false,
          "isAdmin": false,
          "isFan": false
        },
        "seen": false,
        "generatedOn": 1715184000000
      },
      {
        "_id": "507f1f77bcf86cd799439012",
        "forUserId": "507f191e810c19729de860ea",
        "notificationType": "TMNT_INVITE",
        "imageUrl": "tournaments/logo456.jpg",
        "title": "Tournament Invitation",
        "body": "You have been invited to join Summer League 2024",
        "payload": {
          "tournamentId": "507f191e810c19729de860ec"
        },
        "seen": true,
        "generatedOn": 1715097600000
      }
    ]
  }
}
```

---

## Summary

The Notifications feature is a comprehensive system that handles 50+ notification types with dynamic navigation based on notification type and payload data. The UI is simple and clean with a list of notification cards showing avatar, title, body, and relative time. Each notification type has specific navigation logic for both card tap and avatar tap actions.

**Key Features**:
- 15 items per page with infinite scroll
- Seen/unseen visual distinction
- Dynamic navigation based on notification type
- Avatar tap for bio navigation
- URL detection in body text
- Relative time display
- Image caching and fallback handling
