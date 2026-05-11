import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/search_filter_model.dart';
import '../data/models/search_user_model.dart';
import '../data/repositories/search_repository.dart';

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return SearchRepository();
});

final searchProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier(
    repository: ref.read(searchRepositoryProvider),
  );
});

class SearchState {
  final List<SearchUserModel> users;
  final List<SearchFilterModel> filters;
  final String searchQuery;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final int currentPage;

  SearchState({
    this.users = const [],
    this.filters = const [],
    this.searchQuery = '',
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
    this.currentPage = 0,
  });

  SearchState copyWith({
    List<SearchUserModel>? users,
    List<SearchFilterModel>? filters,
    String? searchQuery,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    int? currentPage,
  }) {
    return SearchState(
      users: users ?? this.users,
      filters: filters ?? this.filters,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: error,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  /// Get active filter value by type
  String? getFilterValue(String filterType) {
    try {
      return filters
          .firstWhere((filter) => filter.type == filterType)
          .value;
    } catch (e) {
      return null;
    }
  }

  /// Check if referee type is selected (disables choice filter)
  bool get isRefereeSelected {
    final typeFilter = getFilterValue(SearchFilterType.type);
    return typeFilter == UserTypeFilter.referee;
  }
}

class SearchNotifier extends StateNotifier<SearchState> {
  final SearchRepository _repository;
  static const int _itemsPerPage = 25;

  SearchNotifier({
    required SearchRepository repository,
  })  : _repository = repository,
        super(SearchState());

  /// Set search query
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  /// Add or update filter
  void addFilter(String filterType, String filterValue) {
    final filters = List<SearchFilterModel>.from(state.filters);
    
    // Remove existing filter of same type
    filters.removeWhere((filter) => filter.type == filterType);
    
    // Add new filter
    filters.add(SearchFilterModel(type: filterType, value: filterValue));
    
    // If referee selected, remove choice filter
    if (filterType == SearchFilterType.type &&
        filterValue == UserTypeFilter.referee) {
      filters.removeWhere(
          (filter) => filter.type == SearchFilterType.choice);
    }
    
    state = state.copyWith(filters: filters);
    
    // Trigger new search
    search();
  }

  /// Remove filter
  void removeFilter(String filterType) {
    final filters = List<SearchFilterModel>.from(state.filters);
    filters.removeWhere((filter) => filter.type == filterType);
    
    state = state.copyWith(filters: filters);
    
    // Trigger new search
    search();
  }

  /// Clear all filters
  void clearFilters() {
    state = state.copyWith(filters: []);
    search();
  }

  /// Perform search
  Future<void> search() async {
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: 0,
    );

    try {
      final users = await _fetchUsers(start: 0);
      
      // Sort users based on choice filter
      final sortedUsers = _sortUsers(users);

      state = state.copyWith(
        users: sortedUsers,
        isLoading: false,
        hasMore: users.length >= _itemsPerPage,
        currentPage: 0,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Load more results
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final moreUsers = await _fetchUsers(start: nextPage * _itemsPerPage);
      
      // Sort new users
      final sortedMoreUsers = _sortUsers(moreUsers);

      state = state.copyWith(
        users: [...state.users, ...sortedMoreUsers],
        isLoadingMore: false,
        hasMore: moreUsers.length >= _itemsPerPage,
        currentPage: nextPage,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  /// Fetch users from API
  Future<List<SearchUserModel>> _fetchUsers({required int start}) async {
    String country = '';
    String userType = '';
    String choice = '';

    // Extract filter values
    for (final filter in state.filters) {
      switch (filter.type) {
        case SearchFilterType.country:
          if (filter.value != 'All') {
            country = filter.value;
          }
          break;
        case SearchFilterType.type:
          userType = filter.value;
          break;
        case SearchFilterType.choice:
          // Map choice to API parameter
          switch (filter.value) {
            case SortingFilter.mostPosts:
              choice = 'posts';
              break;
            case SortingFilter.mostAppearances:
              choice = 'appearance';
              break;
            case SortingFilter.mostGoals:
              choice = 'goals';
              break;
          }
          break;
      }
    }

    return await _repository.advSearch(
      searchText: state.searchQuery,
      country: country,
      userType: userType,
      choice: choice,
      start: start,
      limit: _itemsPerPage,
    );
  }

  /// Sort users based on choice filter
  List<SearchUserModel> _sortUsers(List<SearchUserModel> users) {
    final choiceFilter = state.getFilterValue(SearchFilterType.choice);
    
    if (choiceFilter == null) {
      // Default sort by name
      users.sort((a, b) => a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()));
      return users;
    }

    switch (choiceFilter) {
      case SortingFilter.mostAppearances:
        users.sort((a, b) {
          if (a.appearance != b.appearance) {
            return b.appearance.compareTo(a.appearance); // DESC
          }
          return a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()); // ASC
        });
        break;
      case SortingFilter.mostPosts:
        users.sort((a, b) {
          if (a.postCount != b.postCount) {
            return b.postCount.compareTo(a.postCount); // DESC
          }
          return a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()); // ASC
        });
        break;
      case SortingFilter.mostGoals:
        users.sort((a, b) {
          if (a.goals != b.goals) {
            return b.goals.compareTo(a.goals); // DESC
          }
          return a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()); // ASC
        });
        break;
      default:
        users.sort((a, b) => a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()));
    }

    return users;
  }

  /// Refresh search
  void refresh() {
    search();
  }
}
