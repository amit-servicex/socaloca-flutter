import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../data/tournament_models.dart';
import '../data/tournament_repository.dart';
import '../widgets/tournament_card.dart';
import '../widgets/tournament_filters.dart';
import 'tournament_featured_screen.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Status integer constants — matches Android Params.java exactly
int _kOngoing = 1;
int _kUpcoming = 2;
int _kClosed = 3;

/// CommonOngoingTournamentsFragment / CommonUpcomingTournamentsFragment equivalent
class TournamentListScreen extends ConsumerStatefulWidget {
  TournamentListScreen({
    super.key,
    required this.status,
  });

  /// 'ongoing' | 'upcoming' | 'my' | 'closed'
  final String status;

  @override
  ConsumerState<TournamentListScreen> createState() =>
      _TournamentListScreenState();
}

class _TournamentListScreenState extends ConsumerState<TournamentListScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  List<TournamentModel> _tournaments = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _start = 0;
  final int _limit = 10;

  TournamentFilters _filters = TournamentFilters();

  @override
  bool get wantKeepAlive => true;

  /// Map string status to the integer the API expects
  int get _statusInt {
    switch (widget.status) {
      case 'upcoming':
        return _kUpcoming;
      case 'closed':
        return _kClosed;
      default:
        return _kOngoing;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTournaments();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8 &&
        !_isLoading &&
        _hasMore) {
      _loadMore();
    }
  }

  Future<void> _loadTournaments({bool refresh = false}) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      if (refresh) {
        _start = 0;
        _tournaments = [];
        _hasMore = true;
      }
    });

    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      List<TournamentModel> newTournaments;

      if (widget.status == 'my') {
        newTournaments = await ref
            .read(tournamentRepositoryProvider)
            .getMyTournaments(userId: currentUser.id);
      } else {
        newTournaments =
            await ref.read(tournamentRepositoryProvider).getTournaments(
                  userId: currentUser.id,
                  status: _statusInt,
                  // Always send all filter fields — empty string = no filter
                  gameType: _filters.gameType ?? '',
                  ageGroup: _filters.ageGroup ?? '',
                  gender: _filters.gender ?? '',
                  country: _filters.country ?? '',
                  confed: _filters.confed ?? '',
                  location: _filters.location ?? '',
                  visibility: _filters.visibility,
                  // ownCountry is required by the API
                  ownCountry: currentUser.country ?? '',
                  start: _start,
                  limit: _limit,
                );
      }

      setState(() {
        if (refresh) {
          _tournaments = newTournaments;
        } else {
          _tournaments.addAll(newTournaments);
        }
        _hasMore = newTournaments.length >= _limit;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadMore() async {
    _start += _limit;
    await _loadTournaments();
  }

  void _onFiltersChanged(TournamentFilters filters) {
    setState(() => _filters = filters);
    _loadTournaments(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // For 'my' tab there are no filters at all
    final showFilters = widget.status != 'my';

    return Column(
      children: [
        // ── Fixed: NATIONAL / GLOBAL toggle ────────────────────────────
        if (showFilters)
          TournamentVisibilityToggle(
            visibility: _filters.visibility,
            onChanged: (v) {
              setState(() => _filters = _filters.copyWith(visibility: v));
              _loadTournaments(refresh: true);
            },
          ),

        // ── Scrollable area (filters + list) ───────────────────────────
        Expanded(
          child: _tournaments.isEmpty && !_isLoading
              // Empty state
              ? Column(
                  children: [
                    if (showFilters)
                      TournamentFiltersWidget(
                        filters: _filters,
                        onFiltersChanged: _onFiltersChanged,
                      ),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.emoji_events_outlined,
                              size: 64,
                              color: AppColors.socaBlack.withOpacity(0.3),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No tournaments found'.tr,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: AppColors.socaBlack.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              // Normal list state
              : RefreshIndicator(
                  onRefresh: () => _loadTournaments(refresh: true),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      // Filter dropdowns scroll with the list
                      if (showFilters)
                        SliverToBoxAdapter(
                          child: TournamentFiltersWidget(
                            filters: _filters,
                            onFiltersChanged: _onFiltersChanged,
                          ),
                        ),

                      // Tournament cards
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              if (index >= _tournaments.length) {
                                return AppLoader();
                              }

                              final t = _tournaments[index];
                              return TournamentCard(
                                tournament: t,
                                onTap: () {
                                  final id = t.effectiveId;
                                  if (id.isEmpty) return;

                                  final tmntType = t.tmntType?.toUpperCase() ??
                                      t.rule?.toUpperCase() ??
                                      '';

                                  if (tmntType == 'CUP') {
                                    context.push('/cups/$id');
                                  } else {
                                    context.push('/tournaments/$id');
                                  }
                                },
                              );
                            },
                            childCount:
                                _tournaments.length + (_isLoading ? 1 : 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
