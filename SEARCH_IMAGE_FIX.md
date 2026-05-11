# Search Feature - Image URL Fix ✅

## Issue
The search screen was showing null for profile images even though the API was returning image URLs correctly.

### Root Cause
**API Response Field**: `imageUrl`  
**Model Field**: `profileImage`

The API returns:
```json
{
  "imageUrl": "img_1627051900842_794x1024.png"
}
```

But the model was expecting:
```json
{
  "profileImage": "img_1627051900842_794x1024.png"
}
```

## Solution
Added `@JsonKey` annotation to map the API field name to the model field name:

```dart
@JsonKey(name: 'imageUrl') String? profileImage,
```

This tells the JSON serializer to read from `imageUrl` in the API response and store it in the `profileImage` field of the model.

## Files Modified
- `lib/features/search/data/models/search_user_model.dart`
  - Added `@JsonKey(name: 'imageUrl')` annotation to `profileImage` field

## Verification
The generated code in `search_user_model.g.dart` now correctly maps:
```dart
profileImage: json['imageUrl'] as String?,
```

## Testing
After this fix:
1. Search for users
2. Verify profile images are displayed correctly
3. Check that default avatar is shown only when imageUrl is truly null/empty

## Related Files
- `lib/features/search/data/models/search_user_model.dart` - Model definition
- `lib/features/search/data/models/search_user_model.g.dart` - Generated JSON serialization
- `lib/features/search/widgets/search_result_card.dart` - Uses `user.profileImage`

## Build Command Used
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This regenerated the freezed files with the correct mapping.
