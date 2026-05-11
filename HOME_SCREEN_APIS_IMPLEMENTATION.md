# Home Screen APIs Implementation Plan

## Overview

Based on analysis of the Android `CommonHomeFeedFragment.java`, the home screen makes several API calls to populate different sections. The current Flutter implementation only shows the social feed but is missing these additional API calls and their corresponding UI sections.

## APIs Called on Home Screen Load

### 1. **getUserProfile**
- **Purpose**: Get current user's profile data
- **When**: On screen load
- **Response**: User profile information
- **UI Impact**: Used to populate user info in drawer/header

### 2. **getFeedLiveTmnts** 
- **Purpose**: Get live tournaments for the feed
- **Endpoint**: `ApiConstants.getFeedLiveTmnts`
- **Request**:
```dart
{
  'userId': currentUserId,
  'start': 0,
  'limit': 10,
}
```
- **Response**: List of live tournaments
- **UI Impact**: Shows live tournaments section in feed

### 3. **getFeedNewTeams**
- **Purpose**: Get newly created teams
- **Endpoint**: `ApiConstants.getFeedNewTeams`
- **Request**:
```dart
{
  'userId': currentUserId,
  'start': 0,
  'limit': 10,
}
```
- **Response**: List of new teams
- **UI Impact**: "New Teams" horizontal carousel in feed

### 4. **getFeedRecUsers**
- **Purpose**: Get recommended users to follow
- **Endpoint**: `ApiConstants.getFeedRecUsers`
- **Request**:
```dart
{
  'userId': currentUserId,
  'start': 0,
  'limit': 10,
}
```
- **Response**: List of recommended users
- **UI Impact**: "Recommended Users" section in feed

### 5. **getMostEndorsed**
- **Purpose**: Get most endorsed players
- **Endpoint**: `ApiConstants.getMostEndorsed`
- **Request**:
```dart
{
  'userId': currentUserId,
  'start': 0,
  'limit': 10,
}
```
- **Response**: List of most endorsed players
- **UI Impact**: "Most Endorsed" section in feed

### 6. **chkUpdt** (checkAppUpdate)
- **Purpose**: Check for app updates
- **Endpoint**: `ApiConstants.checkAppUpdate` or `ApiConstants.chkUpdt`
- **Request**:
```dart
{
  'userId': currentUserId,
  'version': currentAppVersion,
  'platform': 'android' or 'ios',
}
```
- **Response**: Update information
- **UI Impact**: Shows update dialog if available

## Current Flutter Implementation Status

### ✅ Already Implemented
- Social feed (main feed posts)
- Feedback banner
- Live match banner
- Language selection
- Basic home structure

### ❌ Missing Implementation
- getUserProfile call
- getFeedLiveTmnts section
- getFeedNewTeams carousel
- getFeedRecUsers section
- getMostEndorsed section
- chkUpdt check

## Implementation Plan

### Phase 1: Add API Endpoints to Constants
```dart
// In api_constants.dart - Already exist, verify:
static const String getUserProfile = 'getUserProfile';
static const String getFeedLiveTmnts = 'getFeedLiveTmnts';
static const String getFeedNewTeams = 'getFeedNewTeams';
static const String getFeedRecUsers = 'getFeedRecUsers';
static const String getMostEndorsed = 'getMostEndorsed';
static const String chkUpdt = 'chkUpdt';
```

### Phase 2: Create Data Models

#### Tournament Model (for getFeedLiveTmnts)
```dart
@freezed
class FeedTournamentModel with _$FeedTournamentModel {
  const factory FeedTournamentModel({
    required String tmntId,
    String? tmntName,
    String? imageUrl,
    String? startDate,
    String? endDate,
    String? status, // 'live', 'upcoming', 'completed'
    @Default(0) int teamsCount,
  }) = _FeedTournamentModel;
  
  factory FeedTournamentModel.fromJson(Map<String, dynamic> json) =>
      _$FeedTournamentModelFromJson(json);
}
```

#### New Team Model (for getFeedNewTeams)
```dart
@freezed
class FeedNewTeamModel with _$FeedNewTeamModel {
  const factory FeedNewTeamModel({
    required String teamId,
    String? teamName,
    String? teamLogo,
    String? country,
    String? city,
    @Default(0) int memberCount,
    String? createdOn,
  }) = _FeedNewTeamModel;
  
  factory FeedNewTeamModel.fromJson(Map<String, dynamic> json) =>
      _$FeedNewTeamModelFromJson(json);
}
```

#### Recommended User Model (for getFeedRecUsers)
```dart
@freezed
class FeedRecUserModel with _$FeedRecUserModel {
  const factory FeedRecUserModel({
    required String userId,
    String? firstName,
    String? lastName,
    String? imageUrl,
    String? userType,
    String? country,
    @Default(false) bool isFollowing,
  }) = _FeedRecUserModel;
  
  factory FeedRecUserModel.fromJson(Map<String, dynamic> json) =>
      _$FeedRecUserModelFromJson(json);
}
```

#### Endorsed Player Model (for getMostEndorsed)
```dart
@freezed
class EndorsedPlayerModel with _$EndorsedPlayerModel {
  const factory EndorsedPlayerModel({
    required String userId,
    String? firstName,
    String? lastName,
    String? imageUrl,
    String? position,
    @Default(0) int endorsementCount,
  }) = _EndorsedPlayerModel;
  
  factory EndorsedPlayerModel.fromJson(Map<String, dynamic> json) =>
      _$EndorsedPlayerModelFromJson(json);
}
```

### Phase 3: Create Repository

```dart
// lib/features/home/data/home_repository.dart

class HomeRepository {
  Future<List<FeedTournamentModel>> getFeedLiveTmnts({
    required String userId,
    int start = 0,
    int limit = 10,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.getFeedLiveTmnts,
      body: {
        'userId': userId,
        'start': start,
        'limit': limit,
      },
    );
    
    // Parse response
    final data = response['response'];
    if (data != null && data['tournaments'] != null) {
      return (data['tournaments'] as List)
          .map((t) => FeedTournamentModel.fromJson(t))
          .toList();
    }
    return [];
  }
  
  Future<List<FeedNewTeamModel>> getFeedNewTeams({
    required String userId,
    int start = 0,
    int limit = 10,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.getFeedNewTeams,
      body: {
        'userId': userId,
        'start': start,
        'limit': limit,
      },
    );
    
    // Parse response
    final data = response['response'];
    if (data != null && data['teams'] != null) {
      return (data['teams'] as List)
          .map((t) => FeedNewTeamModel.fromJson(t))
          .toList();
    }
    return [];
  }
  
  Future<List<FeedRecUserModel>> getFeedRecUsers({
    required String userId,
    int start = 0,
    int limit = 10,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.getFeedRecUsers,
      body: {
        'userId': userId,
        'start': start,
        'limit': limit,
      },
    );
    
    // Parse response
    final data = response['response'];
    if (data != null && data['users'] != null) {
      return (data['users'] as List)
          .map((u) => FeedRecUserModel.fromJson(u))
          .toList();
    }
    return [];
  }
  
  Future<List<EndorsedPlayerModel>> getMostEndorsed({
    required String userId,
    int start = 0,
    int limit = 10,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.getMostEndorsed,
      body: {
        'userId': userId,
        'start': start,
        'limit': limit,
      },
    );
    
    // Parse response
    final data = response['response'];
    if (data != null && data['players'] != null) {
      return (data['players'] as List)
          .map((p) => EndorsedPlayerModel.fromJson(p))
          .toList();
    }
    return [];
  }
}
```

### Phase 4: Create Providers

```dart
// lib/features/home/providers/home_feed_providers.dart

final feedLiveTmntsProvider = FutureProvider<List<FeedTournamentModel>>((ref) async {
  final userId = StorageService.userId ?? '';
  return ref.read(homeRepositoryProvider).getFeedLiveTmnts(userId: userId);
});

final feedNewTeamsProvider = FutureProvider<List<FeedNewTeamModel>>((ref) async {
  final userId = StorageService.userId ?? '';
  return ref.read(homeRepositoryProvider).getFeedNewTeams(userId: userId);
});

final feedRecUsersProvider = FutureProvider<List<FeedRecUserModel>>((ref) async {
  final userId = StorageService.userId ?? '';
  return ref.read(homeRepositoryProvider).getFeedRecUsers(userId: userId);
});

final mostEndorsedProvider = FutureProvider<List<EndorsedPlayerModel>>((ref) async {
  final userId = StorageService.userId ?? '';
  return ref.read(homeRepositoryProvider).getMostEndorsed(userId: userId);
});
```

### Phase 5: Update Home Screen UI

```dart
// In home_screen.dart

@override
Widget build(BuildContext context) {
  return Scaffold(
    key: _scaffoldKey,
    backgroundColor: AppColors.socaPageBg,
    body: Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              // Live Tournaments Section
              _buildLiveTournamentsSection(),
              
              // New Teams Section
              _buildNewTeamsSection(),
              
              // Recommended Users Section
              _buildRecommendedUsersSection(),
              
              // Most Endorsed Section
              _buildMostEndorsedSection(),
              
              // Social Feed (existing)
              const SliverToBoxAdapter(
                child: SocialFeedScreen(),
              ),
            ],
          ),
        ),
        
        // Existing banners
        if (_showFeedbackBanner) FeedbackBanner(...),
        LiveMatchBanner(...),
      ],
    ),
  );
}

Widget _buildLiveTournamentsSection() {
  final tournamentsAsync = ref.watch(feedLiveTmntsProvider);
  
  return tournamentsAsync.when(
    data: (tournaments) {
      if (tournaments.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());
      
      return SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Live Tournaments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tournaments.length,
                itemBuilder: (context, index) {
                  return TournamentCard(tournament: tournaments[index]);
                },
              ),
            ),
          ],
        ),
      );
    },
    loading: () => const SliverToBoxAdapter(child: CircularProgressIndicator()),
    error: (_, __) => const SliverToBoxAdapter(child: SizedBox.shrink()),
  );
}

// Similar methods for other sections...
```

## Next Steps

1. ✅ Verify API endpoints exist in `api_constants.dart`
2. ⬜ Create data models for each API response
3. ⬜ Implement repository methods
4. ⬜ Create Riverpod providers
5. ⬜ Create UI widgets for each section
6. ⬜ Update home screen to include all sections
7. ⬜ Test with real API data

## Notes

- The Android app calls these APIs in `CommonHomeFeedFragment.java`
- Each section is displayed as a horizontal carousel or list
- Sections are only shown if they have data
- All sections support pull-to-refresh
- The social feed remains the main content with these sections interspersed

## Priority

Since you mentioned the userId issue with clubs, I recommend:
1. **First**: Fix the login/userId issue so all APIs work
2. **Then**: Implement these home screen APIs in order of importance:
   - getUserProfile (needed for user context)
   - getFeedNewTeams (high visibility)
   - getFeedRecUsers (engagement)
   - getFeedLiveTmnts (if tournaments are active)
   - getMostEndorsed (nice to have)
   - chkUpdt (background check)
