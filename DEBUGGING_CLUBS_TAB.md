# Debugging Clubs Tab

## Current Status

The Clubs tab implementation is complete with extensive logging. If you're seeing only the "Clubs & Partners" header text but no clubs list, follow these debugging steps:

## How to Debug

### 1. Run the app and check console logs

When you navigate to the Clubs & Partners tab, you should see these logs in order:

```
🔵 ClubsNotifier.load() called
🔵 Current state - country: , partnership: 
🔵 UserId: <your-user-id>
📡 Calling getClubs API...
📦 API Response keys: [response]
📦 Full API Response: {response: {...}}
📦 Response data keys: [clubs]
📦 Response data type: _Map<String, dynamic>
📦 Clubs data type: List<dynamic>
✅ Found X clubs in response
✅ Parsing clubs...
✅ Successfully parsed X clubs
🔵 Received X clubs from repository
🔵 State updated - clubs count: X
🔵 ClubsScreen build - isLoading: false, clubs: X, error: null
```

### 2. Common Issues and Solutions

#### Issue 1: No userId
**Symptom:** Log shows `🔵 UserId: ` (empty)
**Solution:** User is not logged in. Check `StorageService.userId`

#### Issue 2: API returns empty clubs array
**Symptom:** Log shows `✅ Found 0 clubs in response`
**Solution:** 
- Check if the API endpoint is correct
- Check if filters are too restrictive
- Try with empty filters (country='', partnership='')

#### Issue 3: Parsing errors
**Symptom:** Logs show `❌ Error parsing club at index X`
**Solution:** Check the club JSON structure in the error log and update `ClubModel.fromApiJson()`

#### Issue 4: Response structure is different
**Symptom:** Log shows `🔴 No response data found` or `🔴 Clubs is not a List`
**Solution:** The API response structure doesn't match expectations. Check the full response structure.

### 3. Check the Debug Widget

The screen now has a yellow debug bar showing:
```
Debug: Loading=false, Clubs=0, Error=none
```

This tells you:
- **Loading**: Whether data is currently being fetched
- **Clubs**: Number of clubs in state
- **Error**: Any error message

### 4. Manual API Test

You can test the API directly using curl:

```bash
curl -X POST https://organise.socaloca.football:9757/getClubs \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "userId": "YOUR_USER_ID",
    "country": "",
    "confed": "",
    "partnerShip": "",
    "trial": "",
    "start": 0,
    "limit": 100
  }'
```

### 5. Check Response Structure

Based on your provided response, the structure should be:
```json
{
  "response": {
    "clubs": [
      {
        "_id": "...",
        "clubId": "...",
        "clubName": "...",
        "partnerType": "platinum",
        "country": "Ghana",
        ...
      }
    ]
  }
}
```

If your actual response is different, update the repository parsing logic.

## Quick Fixes

### Fix 1: Remove unnecessary cast warning

In `club_repository.dart` line 63, change:
```dart
final clubsJson = clubsData as List;
```
to:
```dart
final clubsJson = clubsData;
```

### Fix 2: If clubs are loading but not showing

Check if the issue is in the UI rendering:
1. Verify `ClubCard` widget is rendering correctly
2. Check if `ListView.builder` has correct itemCount
3. Verify `ClubModel` has all required fields

### Fix 3: If API is not being called

Check if the provider is being initialized:
1. Verify `clubsProvider` is being watched in `ClubsScreen`
2. Check if `load()` is being called in `initState`
3. Verify `WidgetsBinding.instance.addPostFrameCallback` is executing

## Testing Checklist

- [ ] User is logged in (userId is not empty)
- [ ] API endpoint is correct (`getClubs`)
- [ ] API returns data (check logs for "Found X clubs")
- [ ] Clubs are being parsed (check logs for "Successfully parsed X clubs")
- [ ] State is being updated (check logs for "State updated - clubs count: X")
- [ ] UI is rebuilding (check logs for "ClubsScreen build")
- [ ] Debug widget shows correct club count
- [ ] ClubCard widgets are rendering

## Next Steps

1. Run the app with `flutter run` and watch the console
2. Navigate to Clubs & Partners tab
3. Copy all the logs and share them
4. Check the debug widget values
5. If clubs are loading but not showing, the issue is in the UI
6. If clubs are not loading, the issue is in the API/repository

## Remove Debug Code Later

Once everything is working, remove:
1. All `print()` statements
2. The yellow debug widget in `clubs_screen.dart`
3. Extra logging in `clubs_provider.dart`
