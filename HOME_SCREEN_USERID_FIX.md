# Home Screen APIs - UserId Fix

## Problem

After login, the home screen was showing:
```
⚠️ Not logged in - Home feed sections will be empty
```

And the home screen APIs were NOT being called:
- `/getFeedLiveTmnts`
- `/getFeedNewTeams`
- `/getFeedRecUsers`
- `/getMostEndorsed`

## Root Cause

**Field Name Mismatch**:

1. **UserModel** stores the user ID in a field called `id`:
   ```dart
   class UserModel {
     required String id,  // ← Field name is "id"
     ...
   }
   ```

2. **StorageService.userId** was looking for `userId` or `_id`:
   ```dart
   static String? get userId {
     final user = currentUser;
     return user?['userId'] ?? user?['_id'];  // ← Missing 'id'
   }
   ```

3. When user logs in:
   - `UserModel.toJson()` creates: `{"id": "123", "name": "John", ...}`
   - `StorageService.setCurrentUser()` saves this JSON
   - `StorageService.userId` tries to read `userId` or `_id`
   - Both are null, so `userId` returns `null`
   - Home screen providers check `if (userId.isEmpty)` and return empty lists
   - APIs are never called!

## Solution

Updated `StorageService.userId` to also check for `id`:

```dart
/// Get current user ID
static String? get userId {
  final user = currentUser;
  return user?['userId'] ?? user?['_id'] ?? user?['id'];  // ✅ Added 'id'
}
```

Now it checks in order:
1. `userId` (for backward compatibility)
2. `_id` (MongoDB style)
3. `id` (UserModel field) ✅ NEW

## Files Modified

1. `lib/core/storage/storage_service.dart`
   - Updated `userId` getter to check for `id` field

## Testing

After this fix:

1. ✅ Login to the app
2. ✅ Go to home screen
3. ✅ Red banner should NOT appear
4. ✅ Console should show:
   ```
   🟢 feedLiveTmntsProvider called
   🟢 feedLiveTmntsProvider userId: <actual-user-id>
   🔵 Calling getFeedLiveTmnts API with userId: <actual-user-id>
   🔵 getFeedLiveTmnts response: 1
   🔵 getFeedLiveTmnts returned X tournaments
   ```
5. ✅ All 4 home screen APIs should be called
6. ✅ Sections should display data (if available)

## Why This Happened

The `UserModel` was created with `id` as the field name (following Dart conventions), but the Android app uses `userId` or `_id` in the JSON. The `StorageService` was written to match the Android JSON structure, but when we serialize `UserModel.toJson()`, it uses the Dart field name `id`.

## Alternative Solutions Considered

### Option 1: Change UserModel field name (Rejected)
```dart
class UserModel {
  @JsonKey(name: 'userId')
  required String userId,  // ← Rename field
}
```
**Why rejected**: Would require changing all code that uses `user.id` to `user.userId`

### Option 2: Add JSON key annotation (Rejected)
```dart
class UserModel {
  @JsonKey(name: 'userId')
  required String id,  // ← Keep field name, change JSON key
}
```
**Why rejected**: Would break existing code that expects `id` in JSON

### Option 3: Update StorageService (✅ Chosen)
```dart
return user?['userId'] ?? user?['_id'] ?? user?['id'];
```
**Why chosen**: 
- Minimal change (one line)
- Backward compatible
- Works with all field name variations
- No breaking changes

## Impact

This fix affects ALL features that use `StorageService.userId`:
- ✅ Home screen APIs (fixed)
- ✅ Clubs tab (already had this issue)
- ✅ Social feed
- ✅ Matches
- ✅ Any other feature that needs userId

## Debug Code to Remove

Once confirmed working, remove from `home_screen.dart`:

```dart
// Remove this debug banner
if (userId.isEmpty)
  Container(
    color: Colors.red.shade100,
    padding: const EdgeInsets.all(8),
    child: const Text(
      '⚠️ Not logged in - Home feed sections will be empty',
      ...
    ),
  ),
```

Also remove debug logging from:
- `lib/features/home/providers/home_feed_providers.dart` (🟢 logs)
- `lib/features/home/data/repositories/home_feed_repository.dart` (🔵 logs)

---

**Fixed Date**: May 7, 2026
**Status**: ✅ Complete - Ready for Testing
