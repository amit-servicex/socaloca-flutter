import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/tournament_models.dart';
import '../../../providers/tournament_providers.dart';
import '../../../widgets/match_card.dart';

/// League Matches Tab
/// Shows upcoming and played matches in sub-tabs
/// Matches Android TournamentMatchesFragment
class LeagueMatchesTab extends ConsumerStatefulWidget {
  final String tournamentId;

  const LeagueMatchesTab({
    super.key,
    required this.tournamentId,
  });

  @override
  ConsumerState<LeagueMatchesTab> createState() => _LeagueMatchesTabState();
}

class _LeagueMatchesTabState extends ConsumerState<LeagueMatchesTab>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.socaBlack,
            unselectedLabelColor: AppColors.socaBlack.withOpacity(0.5),
            indicatorColor: AppColors.socaYellow,
            indicatorWeight: 2,
            labelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
            tabs: const [
              Tab(text: 'UPCOMING'),
              Tab(text: 'PLAYED'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _MatchesList(
                tournamentId: widget.tournamentId,
                isUpcoming: true,
              ),
              _MatchesList(
                tournamentId: widget.tournamentId,
                isUpcoming: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MatchesList extends ConsumerStatefulWidget {
  final String tournamentId;
  final bool isUpcoming;

  const _MatchesList({
    required this.tournamentId,
    required this.isUpcoming,
  });

  @override
  ConsumerState<_MatchesList> createState() => _MatchesListState();
}

class _MatchesListState extends ConsumerState<_MatchesList>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  List<TournamentMatchModel> _matches = [];
  bool _isLoadingMore = false;
  bool _hasMore = true;
  int _start = 0;
  final int _limit = 10;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadMatches();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8 &&
        !_isLoadingMore &&
        _hasMore) {
      _loadMore();
    }
  }

  Future<void> _loadMatches({bool refresh = false}) async {
    if (refresh) {
      setState(() {
        _start = 0;
        _matches = [];
        _hasMore = true;
      });
    }

    final params = TournamentMatchesParams(
      tournamentId: widget.tournamentId,
      isUpcoming: widget.isUpcoming,
      start: _start,
      limit: _limit,
    );

    final matchesAsync = await ref.read(tournamentMatchesProvider(params).future);

    if (mounted) {
      setState(() {
        if (refresh) {
          _matches = matchesAsync;
        } else {
          _matches.addAll(matchesAsync);
        }
        _hasMore = matchesAsync.length >= _limit;
        _isLoadingMore = false;
      });
    }
  }

  Future<void> _loadMore() async {
    setState(() {
      _isLoadingMore = true;
      _start += _limit;
    });
    await _loadMatches();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_matches.isEmpty && !_isLoadingMore) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sports_soccer,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              widget.isUpcoming ? 'No upcoming matches' : 'No played matches',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _loadMatches(refresh: true),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(12),
        itemCount: _matches.length + (_isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= _matches.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(
                  color: AppColors.socaYellow,
                ),
              ),
            );
          }

          final match = _matches[index];
          return MatchCard(
            match: match,
            onTap: () {
              final matchId = match.effectiveId;
              if (matchId.isNotEmpty) {
                context.push(
                  AppRoutes.matchDetail.replaceFirst(':matchId', matchId),
                );
              }
            },
          );
        },
      ),
    );
  }
}
