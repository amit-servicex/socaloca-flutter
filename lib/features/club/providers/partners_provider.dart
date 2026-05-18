import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/partner_models.dart';
import '../data/repositories/partners_repository.dart';

// ═══════════════════════════════════════════════════════════════════════════
// FAs
// ═══════════════════════════════════════════════════════════════════════════

class FasState {
  final List<FaModel> fas;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;

  const FasState({
    this.fas = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
  });

  FasState copyWith({
    List<FaModel>? fas,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
  }) =>
      FasState(
        fas: fas ?? this.fas,
        isLoading: isLoading ?? this.isLoading,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        hasMore: hasMore ?? this.hasMore,
        error: error,
      );
}

class FasNotifier extends StateNotifier<FasState> {
  FasNotifier(this._ref) : super(const FasState());
  final Ref _ref;
  static const int _pageSize = 10;

  Future<void> load() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, error: null);
    try {
      final items =
          await _ref.read(partnersRepositoryProvider).getFAs(start: 0);
      state = state.copyWith(
        fas: items,
        isLoading: false,
        hasMore: items.length >= _pageSize,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;
    state = state.copyWith(isLoadingMore: true);
    try {
      final items = await _ref
          .read(partnersRepositoryProvider)
          .getFAs(start: state.fas.length);
      state = state.copyWith(
        fas: [...state.fas, ...items],
        isLoadingMore: false,
        hasMore: items.length >= _pageSize,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(fas: [], hasMore: true);
    await load();
  }
}

final fasProvider = StateNotifierProvider<FasNotifier, FasState>(
  (ref) => FasNotifier(ref),
);

// ═══════════════════════════════════════════════════════════════════════════
// Confederations
// ═══════════════════════════════════════════════════════════════════════════

class ConfedsState {
  final List<ConfedModel> confeds;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;

  const ConfedsState({
    this.confeds = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
  });

  ConfedsState copyWith({
    List<ConfedModel>? confeds,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
  }) =>
      ConfedsState(
        confeds: confeds ?? this.confeds,
        isLoading: isLoading ?? this.isLoading,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        hasMore: hasMore ?? this.hasMore,
        error: error,
      );
}

class ConfedsNotifier extends StateNotifier<ConfedsState> {
  ConfedsNotifier(this._ref) : super(const ConfedsState());
  final Ref _ref;
  static const int _pageSize = 10;

  Future<void> load() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, error: null);
    try {
      final items =
          await _ref.read(partnersRepositoryProvider).getConfeds(start: 0);
      state = state.copyWith(
        confeds: items,
        isLoading: false,
        hasMore: items.length >= _pageSize,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;
    state = state.copyWith(isLoadingMore: true);
    try {
      final items = await _ref
          .read(partnersRepositoryProvider)
          .getConfeds(start: state.confeds.length);
      state = state.copyWith(
        confeds: [...state.confeds, ...items],
        isLoadingMore: false,
        hasMore: items.length >= _pageSize,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(confeds: [], hasMore: true);
    await load();
  }
}

final confedsProvider = StateNotifierProvider<ConfedsNotifier, ConfedsState>(
  (ref) => ConfedsNotifier(ref),
);

// ═══════════════════════════════════════════════════════════════════════════
// Sponsors
// ═══════════════════════════════════════════════════════════════════════════

class SponsorsState {
  final List<SponsorModel> sponsors;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final String country;
  final String partnership;

  const SponsorsState({
    this.sponsors = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
    this.country = '',
    this.partnership = '',
  });

  SponsorsState copyWith({
    List<SponsorModel>? sponsors,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    String? country,
    String? partnership,
  }) =>
      SponsorsState(
        sponsors: sponsors ?? this.sponsors,
        isLoading: isLoading ?? this.isLoading,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        hasMore: hasMore ?? this.hasMore,
        error: error,
        country: country ?? this.country,
        partnership: partnership ?? this.partnership,
      );
}

class SponsorsNotifier extends StateNotifier<SponsorsState> {
  SponsorsNotifier(this._ref) : super(const SponsorsState());
  final Ref _ref;
  static const int _pageSize = 10;

  Future<void> load() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, error: null);
    try {
      final items = await _ref.read(partnersRepositoryProvider).getSponsors(
            country: state.country,
            partnerShip: state.partnership,
            start: 0,
          );
      state = state.copyWith(
        sponsors: items,
        isLoading: false,
        hasMore: items.length >= _pageSize,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;
    state = state.copyWith(isLoadingMore: true);
    try {
      final items = await _ref.read(partnersRepositoryProvider).getSponsors(
            country: state.country,
            partnerShip: state.partnership,
            start: state.sponsors.length,
          );
      state = state.copyWith(
        sponsors: [...state.sponsors, ...items],
        isLoadingMore: false,
        hasMore: items.length >= _pageSize,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  void setCountry(String country) {
    if (state.country == country) return;
    state = state.copyWith(country: country, sponsors: [], hasMore: true);
    load();
  }

  void setPartnership(String partnership) {
    if (state.partnership == partnership) return;
    state =
        state.copyWith(partnership: partnership, sponsors: [], hasMore: true);
    load();
  }

  Future<void> refresh() async {
    state = state.copyWith(sponsors: [], hasMore: true);
    await load();
  }
}

final sponsorsProvider = StateNotifierProvider<SponsorsNotifier, SponsorsState>(
  (ref) => SponsorsNotifier(ref),
);

// ═══════════════════════════════════════════════════════════════════════════
// Charities & NGOs
// ═══════════════════════════════════════════════════════════════════════════

class CharitiesState {
  final List<CharityModel> charities;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final String country;
  final String partnership;

  const CharitiesState({
    this.charities = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
    this.country = '',
    this.partnership = '',
  });

  CharitiesState copyWith({
    List<CharityModel>? charities,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    String? country,
    String? partnership,
  }) =>
      CharitiesState(
        charities: charities ?? this.charities,
        isLoading: isLoading ?? this.isLoading,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        hasMore: hasMore ?? this.hasMore,
        error: error,
        country: country ?? this.country,
        partnership: partnership ?? this.partnership,
      );
}

class CharitiesNotifier extends StateNotifier<CharitiesState> {
  CharitiesNotifier(this._ref) : super(const CharitiesState());
  final Ref _ref;
  static const int _pageSize = 10;

  Future<void> load() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, error: null);
    try {
      final items = await _ref.read(partnersRepositoryProvider).getCharities(
            country: state.country,
            partnerShip: state.partnership,
            start: 0,
          );
      state = state.copyWith(
        charities: items,
        isLoading: false,
        hasMore: items.length >= _pageSize,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;
    state = state.copyWith(isLoadingMore: true);
    try {
      final items = await _ref.read(partnersRepositoryProvider).getCharities(
            country: state.country,
            partnerShip: state.partnership,
            start: state.charities.length,
          );
      state = state.copyWith(
        charities: [...state.charities, ...items],
        isLoadingMore: false,
        hasMore: items.length >= _pageSize,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  void setCountry(String country) {
    if (state.country == country) return;
    state = state.copyWith(country: country, charities: [], hasMore: true);
    load();
  }

  void setPartnership(String partnership) {
    if (state.partnership == partnership) return;
    state =
        state.copyWith(partnership: partnership, charities: [], hasMore: true);
    load();
  }

  Future<void> refresh() async {
    state = state.copyWith(charities: [], hasMore: true);
    await load();
  }
}

final charitiesProvider =
    StateNotifierProvider<CharitiesNotifier, CharitiesState>(
  (ref) => CharitiesNotifier(ref),
);
