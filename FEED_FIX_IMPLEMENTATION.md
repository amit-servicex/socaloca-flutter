# Feed Loading Fix Implementation

## Issue
After login, the home screen displayed "No posts yet" even though the user should have feed data. The feed API was not being called with the correct parameters.

## Root Cause
The Flutter app was sending incorrect parameters to the `getFeed` API compared to the Android app:

### Android Parameters (Correct)
```java
params.put("userId", currentUser.getUserId());
params.put("isFan", currentUser.isFan());
params.put("isPlayer", currentUser.isPlayer());
params.put("isCoach", currentUser.isCoach());
params.put("isAdmin", currentUser.isAdmin());
params.put("lastId", lastFeedId);
params.put("limit", feedLimit);
params.put("deviceType", "android");
```

### Flutter Parameters (Before Fix)
```dart
{
  'userId': userId,
  'page': page,
  'limit': limit,
}
```

The Flutter app was missing:
- User role flags (`isFan`, `isPlayer`, `isCoach`, `isAdmin`)
- `lastId` for pagination (was using `page` instead)
- `deviceType` parameter

## Changes Made

### 1. Updated UserModel (`lib/shared/models/user_model.dart`)
Added role flags to match Android User model:
```dart
@Default(false) bool isPlayer,
@Default(false) bool isCoach,
@Default(false) bool isAdmin,
@Default(false) bool isFan,
@Default(false) bool isReferee,
```

### 2. Updated Auth Models (`lib/features/auth/data/auth_models.dart`)
Updated `_mapUserDetails` to parse role flags from login response:
```dart
isPlayer: (json['isPlayer'] as bool?) ?? false,
isCoach: (json['isCoach'] as bool?) ?? false,
isAdmin: (json['isAdmin'] as bool?) ?? false,
isFan: (json['isFan'] as bool?) ?? false,
isReferee: (json['isReferee'] as bool?) ?? false,
```

### 3. Updated Feed Repository (`lib/features/social_feed/data/feed_repository.dart`)
Changed `getFeed` method to match Android parameters:
```dart
Future<List<FeedPost>> getFeed({
  required String userId,
  required bool isFan,
  required bool isPlayer,
  required bool isCoach,
  required bool isAdmin,
  String? lastId,  // Changed from page to lastId
  int limit = 10,
})
```

Request body now includes:
```dart
{
  'userId': userId,
  'isFan': isFan,
  'isPlayer': isPlayer,
  'isCoach': isCoach,
  'isAdmin': isAdmin,
  'lastId': lastId,  // Only included if not null
  'limit': limit,
  'deviceType': 'android',
}
```

### 4. Updated Feed Providers (`lib/features/social_feed/providers/feed_providers.dart`)
Changed pagination from page-based to lastId-based:
```dart
String? _lastId;  // Changed from int _page

// On load
final posts = await repository.getFeed(
  userId: user.id,
  isFan: user.isFan,
  isPlayer: user.isPlayer,
  isCoach: user.isCoach,
  isAdmin: user.isAdmin,
  lastId: _lastId,
);

// Store last post ID for pagination
if (posts.isNotEmpty) {
  _lastId = posts.last.id;
}
```

### 5. Added Debug Logging
Added comprehensive logging to track:
- User data and role flags
- API request parameters
- API response status and data
- Feed loading success/failure

## Testing
After these changes:
1. Run the app and login
2. Check console logs for:
   - User role flags being loaded correctly
   - API request with all required parameters
   - API response status and feed data
3. Verify feed posts display on home screen

## Expected Behavior
- Feed API is called with correct parameters matching Android
- User role flags are sent to determine feed content
- Pagination uses `lastId` instead of page numbers
- Feed posts load and display correctly

## Files Modified
1. `lib/shared/models/user_model.dart`
2. `lib/features/auth/data/auth_models.dart`
3. `lib/features/social_feed/data/feed_repository.dart`
4. `lib/features/social_feed/providers/feed_providers.dart`

## Next Steps
1. Test with actual API to verify feed loads
2. Remove debug logging once confirmed working
3. Test pagination by scrolling to load more posts
4. Verify different user roles (player, coach, fan, etc.) get appropriate feed content

---

**Status**: Implementation Complete  
**Date**: May 5, 2026  
**Issue**: Feed not loading after login  
**Resolution**: Fixed API parameters to match Android implementation
