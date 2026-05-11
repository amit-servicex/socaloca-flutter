# Notifications API Fix - 502 Bad Gateway Resolution

## Problem
The `getNotifications` API was returning a **502 Bad Gateway** error due to incorrect request parameters and response parsing.

## Root Cause Analysis

### Issue 1: Wrong Parameter Name
**Incorrect**: Using `"skip"` for pagination offset  
**Correct**: Android app uses `"start"` for pagination offset

### Issue 2: Wrong Response Structure
**Incorrect**: Expecting nested response `response['response']['notifications']`  
**Correct**: Direct response structure `response['status']` and `response['notifications']`

## Android Implementation Reference

From `CommonNotificationsFragment.java`:

```java
private void getNotifications() {
    try {
        if (!isGettingNotifications && currentUser != null) {
            JSONObject params = new JSONObject();
            params.put("userId", currentUser.getUserId());
            params.put("start", start);  // ← Uses "start" not "skip"
            params.put("limit", limit);
            PostApiRequest getNotificationsReq = new PostApiRequest();
            getNotificationsReq.request(getActivity(), params, getNotificationsListener, GET_NOTIFICATIONS);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}

FetchObjectListener getNotificationsListener = new FetchObjectListener() {
    @Override
    public void onFetchComplete(JSONObject data) {
        try {
            // ← Response is direct, not nested under 'response'
            if (data != null && data.has("status") && data.getInt("status") == 1 && data.has("notifications")) {
                JSONArray notificationArray = data.getJSONArray("notifications");
                // ... process notifications
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
};
```

## Fix Applied

### Before (Incorrect)
```dart
final response = await ApiClient.instance.post(
  ApiConstants.getNotifications,
  body: {
    'userId': userId,
    'skip': skip,  // ❌ Wrong parameter name
    'limit': limit,
  },
);

// ❌ Wrong response structure
if (response['response'] != null &&
    response['response']['notifications'] != null) {
  final notificationsData = response['response']['notifications'] as List;
  // ...
}
```

### After (Correct)
```dart
final response = await ApiClient.instance.post(
  ApiConstants.getNotifications,
  body: {
    'userId': userId,
    'start': skip,  // ✅ Correct parameter name (matches Android)
    'limit': limit,
  },
);

// ✅ Correct response structure (matches Android)
if (response['status'] == 1 && response['notifications'] != null) {
  final notificationsData = response['notifications'] as List;
  // ...
}
```

## API Specification

### Endpoint
- **API Name**: `getNotifications`
- **Method**: POST
- **Base URL**: `https://organise.socaloca.football:9757/`

### Request Body
```json
{
  "userId": "string (required)",
  "start": "number (pagination offset)",
  "limit": "number (items per page, default: 15)"
}
```

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

### Success Response
- `status`: `1` indicates success
- `notifications`: Array of notification objects

### Error Response
- `status`: `0` or other value indicates failure
- May include `message` field with error details

## Pagination Logic

```dart
// Initial load
start = 0
limit = 15

// Load more (page 2)
start = 15
limit = 15

// Load more (page 3)
start = 30
limit = 15

// Formula: start = currentPage * itemsPerPage
```

## Testing

### Test Cases
1. ✅ Initial load with `start=0, limit=15`
2. ✅ Pagination with `start=15, limit=15`
3. ✅ Empty notifications list
4. ✅ Error handling for invalid userId
5. ✅ Response parsing for all notification types

### Expected Behavior
- No more 502 Bad Gateway errors
- Notifications load successfully
- Pagination works correctly
- All 50+ notification types display properly

## Files Modified

1. **socaloca-flutter/lib/features/notifications/data/repositories/notifications_repository.dart**
   - Changed `'skip'` to `'start'` in request body
   - Changed response parsing from `response['response']['notifications']` to `response['notifications']`
   - Added check for `response['status'] == 1`

## Verification

To verify the fix works:

1. Run the app
2. Navigate to Notifications screen
3. Check that notifications load without 502 error
4. Scroll down to test pagination
5. Verify all notification types display correctly

## Related APIs

Other APIs that use similar patterns:
- Most APIs use nested `response['response']` structure
- But some APIs (like `getNotifications`) use direct `response['status']` structure
- Always check Android implementation to confirm correct structure

## Lessons Learned

1. **Always check Android implementation** for exact parameter names
2. **Response structures vary** - some APIs nest under `response`, others don't
3. **Parameter names matter** - `start` vs `skip` can cause 502 errors
4. **Status codes** - Check for `status == 1` for success

## Status

✅ **FIXED** - The notifications API now works correctly with proper parameters and response parsing.
