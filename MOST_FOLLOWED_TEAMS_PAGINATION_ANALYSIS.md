# Most Followed Teams Pagination Analysis

## Working Reference

MostEndorsedSection

- File: `lib/features/home/widgets/most_endorsed_section.dart`
- Provider: `mostEndorsedProvider`
- Notifier: `MostEndorsedNotifier`
- API: `getMostEndorsed`
- Payload: `userId`, `offset`, `limit`
- Response list key: `response.users`

`MostEndorsedSection` works because its horizontal `ListView.builder` triggers `mostEndorsedProvider.notifier.loadMore()` when the last currently loaded item is built. The provider guards duplicate calls with `state.hasMore`, `_isLoadingMore`, and `state.isLoading`, then appends the returned records and updates `_offset`.

## Broken Section

MostFollowedTeamsSection

- File: `lib/features/home/widgets/most_followed_teams_section.dart`
- Provider: `feedTeamsProvider`
- Notifier: `FeedTeamsNotifier`
- API: `getFeedTeamList`
- Payload: `userId`, `start`, `limit`
- Response list key: `response.teams`

The initial page loads correctly, but the next page was not reliably requested when the user reached the end of the horizontal teams row.

## Widget Comparison

`MostEndorsedSection`:

- Uses `ConsumerWidget`.
- Uses horizontal `ListView.builder`.
- Does not use a `ScrollController`.
- Triggers pagination from `itemBuilder` when `index == state.items.length - 1`.
- Loader item is included only while `state.isLoadingMore` is true.

`MostFollowedTeamsSection`:

- Used the same horizontal `ListView.builder` pattern.
- Did not have a `ScrollController` or `NotificationListener`.
- The pagination trigger was only an `itemBuilder` side effect.
- The loader item was included after `isLoadingMore` became true, which is correct and matches `MostEndorsedSection`. The missing piece was an explicit row scroll trigger before the loading state starts.

## State Management Comparison

Both sections use Riverpod `StateNotifierProvider` with the shared `HomeFeedState<T>`:

- `items`
- `isLoading`
- `isLoadingMore`
- `hasMore`

`MostEndorsedNotifier`:

- Tracks `_offset`.
- First page calls `getMostEndorsed(offset: 0, limit: 10)`.
- Next pages call `getMostEndorsed(offset: _offset, limit: 10)`.
- Appends with `items: [...state.items, ...more]`.

`FeedTeamsNotifier`:

- Tracks `_start`.
- First page calls `getFeedTeamList(start: 0, limit: 10)`.
- Next pages should call `getFeedTeamList(start: _start, limit: 10)`.
- Appends with `items: [...state.items, ...more]`.

The provider shape is correct, but `FeedTeamsNotifier` needed stronger reset and loading-more cleanup so a refresh or failed load-more cannot leave pagination blocked.

## Scroll Listener Comparison

Android `CommonHomeFeedFragment` uses a horizontal RecyclerView scroll listener for teams:

- It checks horizontal movement (`dx > 10`).
- It requests more teams near the end: `(visible + firstVisible) >= (total - 4)`.
- It blocks duplicates with `isGettingTeams`.

Flutter `MostEndorsedSection` happens to work with an item-builder trigger.

Flutter `MostFollowedTeamsSection` needed the Android-style explicit horizontal scroll signal because the row is a nested horizontal list inside a Home `CustomScrollView`. Vertical page scrolling does not drive the horizontal list to its end, and relying only on `itemBuilder` is not a robust pagination trigger for this section.

## API Comparison

`getMostEndorsed`:

- Endpoint: `ApiConstants.getMostEndorsed`
- Body: `{ userId, offset, limit }`
- Parses `response.users`
- Model: `EndorsedPlayerModel`

`getFeedTeamList`:

- Endpoint: `ApiConstants.getFeedTeamList`
- Body: `{ userId, start, limit }`
- Parses `response.teams`
- Model: `FeedTeamModel`
- Android uses the same endpoint and parameters: `userId`, `start`, `limit`.

No endpoint change is required.

## Pagination Trigger Comparison

`MostEndorsedSection` trigger:

- Trigger: last built item.
- Calls: `mostEndorsedProvider.notifier.loadMore()`.
- Works in current UI.

`MostFollowedTeamsSection` previous trigger:

- Trigger: last built item only.
- Calls: `feedTeamsProvider.notifier.loadMore()`.
- Failure: no independent horizontal scroll listener, so reaching the visible end of the horizontal row did not reliably call the next-page API.

`MostFollowedTeamsSection` required trigger:

- Add a horizontal `ScrollController`.
- Call `loadMore()` when `pixels >= maxScrollExtent - threshold`.
- Keep the near-end itemBuilder trigger as a fallback/prefetch.
- Prevent duplicate calls through provider guards.

## Root Cause

The root cause is the pagination trigger in `MostFollowedTeamsSection`, not the API endpoint. The section was nested inside the Home screen `CustomScrollView`, but it had no horizontal scroll listener of its own. Its only trigger was a builder-index side effect. As a result, horizontal end-of-row scrolling did not reliably fire `feedTeamsProvider.notifier.loadMore()`.

## Required Fix

- Convert `MostFollowedTeamsSection` to a `ConsumerStatefulWidget`.
- Add a horizontal `ScrollController`.
- Listen to row scroll and trigger `feedTeamsProvider.notifier.loadMore()` near the end.
- Preserve the existing loader behavior: show the loader only while `isLoadingMore` is true.
- Keep provider duplicate guards: `hasMore`, `isLoading`, `isLoadingMore`, `_isLoadingMore`.
- Reset `_start` and `_isLoadingMore` on refresh.
- Clear `isLoadingMore` in `finally` after load-more attempts.

## Risks

- If the backend returns fewer than `limit` items while more pages still exist, `hasMore` can become false early. This matches the existing pagination convention used across the Flutter home feed providers.
- A near-end builder fallback can prefetch before the user reaches the absolute last pixel. Duplicate API calls are still prevented by provider guards.
- The UI should remain unchanged except for the loader appearing at the end while a load-more request is active.
