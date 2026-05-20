import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/tournament_models.dart';
import '../../../providers/tournament_providers.dart';
import '../../../widgets/match_card.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

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
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  final List<TournamentMatchModel> _upcomingMatches = [];
  bool _isLoadingUpcoming = false;
  bool _hasMoreUpcoming = true;
  int _startUpcoming = 0;

  final List<TournamentMatchModel> _playedMatches = [];
  bool _isLoadingPlayed = false;
  bool _hasMorePlayed = true;
  int _startPlayed = 0;

  final int _limit = 10;
  bool _isInit = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitial();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadInitial() async {
    setState(() {
      _isLoadingUpcoming = true;
    });

    await _fetchUpcoming();
    if (!_hasMoreUpcoming) {
      await _fetchPlayed();
    }

    if (mounted) {
      setState(() {
        _isInit = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      if (_hasMoreUpcoming && !_isLoadingUpcoming) {
        _fetchUpcoming();
      } else if (!_hasMoreUpcoming && _hasMorePlayed && !_isLoadingPlayed) {
        _fetchPlayed();
      }
    }
  }

  Future<void> _fetchUpcoming() async {
    setState(() => _isLoadingUpcoming = true);
    final params = TournamentMatchesParams(
      tournamentId: widget.tournamentId,
      isUpcoming: true,
      start: _startUpcoming,
      limit: _limit,
    );
    final matches = await ref.read(tournamentMatchesProvider(params).future);
    if (mounted) {
      setState(() {
        _upcomingMatches.addAll(matches);
        _hasMoreUpcoming = matches.length >= _limit;
        _startUpcoming += _limit;
        _isLoadingUpcoming = false;
      });

      if (!_hasMoreUpcoming &&
          _playedMatches.isEmpty &&
          _hasMorePlayed &&
          !_isLoadingPlayed) {
        _fetchPlayed();
      }
    }
  }

  Future<void> _fetchPlayed() async {
    setState(() => _isLoadingPlayed = true);
    final params = TournamentMatchesParams(
      tournamentId: widget.tournamentId,
      isUpcoming: false,
      start: _startPlayed,
      limit: _limit,
    );
    final matches = await ref.read(tournamentMatchesProvider(params).future);
    if (mounted) {
      setState(() {
        _playedMatches.addAll(matches);
        _hasMorePlayed = matches.length >= _limit;
        _startPlayed += _limit;
        _isLoadingPlayed = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      _upcomingMatches.clear();
      _playedMatches.clear();
      _startUpcoming = 0;
      _startPlayed = 0;
      _hasMoreUpcoming = true;
      _hasMorePlayed = true;
    });
    await _loadInitial();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_isInit) {
      return const AppLoader();
    }

    final items = <Widget>[];

    if (_upcomingMatches.isNotEmpty) {
      items.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Text(
            'Upcoming Matches',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.socaBlack,
            ),
          ),
        ),
      );
      items.addAll(_upcomingMatches.map((m) => _buildMatch(m)));
    }

    if (_isLoadingUpcoming) {
      items.add(const Padding(
        padding: EdgeInsets.all(16.0),
        child: AppLoader(),
      ));
    }

    if (!_hasMoreUpcoming && _playedMatches.isNotEmpty) {
      items.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Text(
            'Played Matches',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.socaBlack,
            ),
          ),
        ),
      );
      items.addAll(_playedMatches.map((m) => _buildMatch(m)));
    }

    if (!_hasMoreUpcoming && _isLoadingPlayed) {
      items.add(const Padding(
        padding: EdgeInsets.all(16.0),
        child: AppLoader(),
      ));
    }

    if (_upcomingMatches.isEmpty &&
        _playedMatches.isEmpty &&
        !_isLoadingUpcoming &&
        !_isLoadingPlayed) {
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
              'No matches found',
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
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(bottom: 24),
        itemCount: items.length,
        itemBuilder: (context, index) => items[index],
      ),
    );
  }

  Widget _buildMatch(TournamentMatchModel match) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: MatchCard(
        match: match,
        onTap: () {
          final matchId = match.effectiveId;
          if (matchId.isNotEmpty) {
            context.push(
              AppRoutes.liveMatchDetails.replaceFirst(':matchId', matchId),
              extra: {
                'tournamentId': widget.tournamentId,
                'preferMatchData': true,
              },
            );
          }
        },
      ),
    );
  }
}
