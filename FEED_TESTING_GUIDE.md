# Feed Loading Testing Guide

## Purpose
This guide helps verify that the feed loading fix is working correctly.

## Prerequisites
- Flutter app built and running
- Valid user credentials for login
- Access to console logs

## Testing Steps

### 1. Clean Start
```bash
cd socaloca-flutter
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

### 2. Login Flow
1. Launch the app
2. Complete onboarding (if first time)
3. Select a role (Player, Coach, Fan, etc.)
4. Login with valid credentials
5. Accept policy if prompted

### 3. Monitor Console Logs
Look for these log messages in order:

#### User Loading
```
🔵 loadFeed: User loaded
  id: <user_id>
  name: <user_name>
  isFan: true/false, isPlayer: true/false, isCoach: true/false, isAdmin: true/false
```

#### API Request
```
🔵 getFeed called with:
  userId: <user_id>
  isFan: true/false, isPlayer: true/false, isCoach: true/false, isAdmin: true/false
  lastId: null, limit: 10
```

#### API Response
```
🟢 getFeed response status: 1
🟢 getFeed response keys: [status, feed, lastId, ...]
🟢 Feed list length: <number>
🟢 loadFeed: Loaded <number> posts
```

### 4. Verify UI
After successful API call, check:
- [ ] Feed posts are visible on home screen
- [ ] Post cards display correctly with:
  - User name and image
  - Post content
  - Like and comment counts
  - Post images/videos (if any)
- [ ] Pull-to-refresh works
- [ ] Scroll to load more posts works

### 5. Test Different User Roles
Test with different user types to verify role-specific feed:
- [ ] Player account
- [ ] Coach account
- [ ] Fan account
- [ ] Admin account (if available)

Each role may see different feed content based on their role flags.

## Expected Results

### Success Indicators
✅ Console shows all log messages in correct order  
✅ API response status is 1  
✅ Feed list length > 0  
✅ Posts display on home screen  
✅ No error messages in console  
✅ Pull-to-refresh loads new posts  
✅ Infinite scroll loads more posts  

### Failure Indicators
❌ "User not logged in" error  
❌ API response status is 0  
❌ Feed list length is 0  
❌ "No posts yet" message displayed  
❌ Error messages in console  
❌ Red error screen with retry button  

## Troubleshooting

### Issue: "User not logged in"
**Cause**: User data not loaded from storage  
**Fix**: Check auth provider and storage service

### Issue: API returns status 0
**Cause**: Invalid user ID or role flags  
**Fix**: 
1. Check user data in console logs
2. Verify login response includes role flags
3. Check API endpoint and parameters

### Issue: Feed list length is 0
**Cause**: User has no feed content OR API filtering issue  
**Fix**:
1. Verify user has posts/activity in Android app
2. Check role flags are correct
3. Test with different user account

### Issue: Posts not displaying
**Cause**: FeedPost model parsing error  
**Fix**:
1. Check console for parsing errors
2. Verify API response format matches FeedPost model
3. Check FeedPostCard widget

## Debug Mode

### Enable Verbose Logging
The current implementation includes debug logging. To see all logs:
```bash
flutter run --verbose
```

### Check API Response
To see full API response, add this to `feed_repository.dart`:
```dart
print('🟢 Full API response: ${jsonEncode(data)}');
```

### Check User Data
To see full user data, add this to `feed_providers.dart`:
```dart
print('🔵 Full user data: ${jsonEncode(user.toJson())}');
```

## Cleanup After Testing

Once confirmed working, remove debug print statements:
1. `lib/features/social_feed/data/feed_repository.dart` - Remove all print statements
2. `lib/features/social_feed/providers/feed_providers.dart` - Remove all print statements
3. Run `flutter analyze` to verify no issues

## Performance Testing

### Test Pagination
1. Scroll to bottom of feed
2. Verify "Loading..." indicator appears
3. Verify more posts load automatically
4. Check console for `lastId` being updated
5. Repeat until no more posts

### Test Refresh
1. Pull down from top of feed
2. Verify refresh indicator appears
3. Verify feed reloads from beginning
4. Check console for `lastId: null` on refresh

## API Endpoint Verification

### Endpoint
```
POST /getFeed
```

### Request Body
```json
{
  "userId": "string",
  "isFan": boolean,
  "isPlayer": boolean,
  "isCoach": boolean,
  "isAdmin": boolean,
  "lastId": "string or null",
  "limit": 10,
  "deviceType": "android"
}
```

### Expected Response
```json
{
  "status": 1,
  "message": "Success",
  "feed": [
    {
      "_id": "string",
      "type": "userPost",
      "userId": "string",
      "userName": "string",
      "userImage": "string",
      "content": "string",
      "images": [],
      "likeCount": 0,
      "commentCount": 0,
      "isLiked": false,
      "createdAt": "ISO date string"
    }
  ],
  "lastId": "string"
}
```

---

**Last Updated**: May 5, 2026  
**Version**: 1.0  
**Status**: Ready for Testing
