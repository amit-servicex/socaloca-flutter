import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/features/tournaments/data/tournament_repository.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/providers/auth_provider.dart';
import '../../../data/tournament_models.dart';
import '../../../providers/tournament_providers.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// League Match Management Tab
/// Shows list of matches with management options for Admin/Referee/Coach
/// Matches Android TournamentMatchManageFragment
class LeagueMatchManagementTab extends ConsumerStatefulWidget {
  final String tournamentId;

  const LeagueMatchManagementTab({
    super.key,
    required this.tournamentId,
  });

  @override
  ConsumerState<LeagueMatchManagementTab> createState() =>
      _LeagueMatchManagementTabState();
}

class _LeagueMatchManagementTabState
    extends ConsumerState<LeagueMatchManagementTab>
    with AutomaticKeepAliveClientMixin {
  int _currentPage = 0;
  final int _pageSize = 10;
  final List<TournamentMatchModel> _allMatches = [];
  bool _isLoadingMore = false;
  bool _hasMore = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadMatches();
  }

  Future<void> _loadMatches() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() => _isLoadingMore = true);

    try {
      final user = ref.read(currentUserProvider);
      if (user == null) return;

      final repository = ref.read(tournamentRepositoryProvider);

      // Load both upcoming and played matches for management
      final upcomingMatches = await repository.getTournamentMatches(
        userId: user.id,
        tournamentId: widget.tournamentId,
        isUpcoming: true,
        start: _currentPage * _pageSize,
        limit: _pageSize,
      );

      final playedMatches = await repository.getTournamentMatches(
        userId: user.id,
        tournamentId: widget.tournamentId,
        isUpcoming: false,
        start: _currentPage * _pageSize,
        limit: _pageSize,
      );

      final newMatches = [...upcomingMatches, ...playedMatches];

      if (mounted) {
        setState(() {
          _allMatches.addAll(newMatches);
          _hasMore = newMatches.length >= _pageSize;
          _currentPage++;
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _allMatches.clear();
      _currentPage = 0;
      _hasMore = true;
    });
    await _loadMatches();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final user = ref.watch(currentUserProvider);

    // Check if user has management permissions
    if (user == null || !_canManageMatches(user)) {
      return _buildNoAccessView();
    }

    if (_allMatches.isEmpty && !_isLoadingMore) {
      return _buildEmptyView();
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      color: AppColors.socaYellow,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >=
              scrollInfo.metrics.maxScrollExtent * 0.9) {
            _loadMatches();
          }
          return false;
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _allMatches.length + (_hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _allMatches.length) {
              return _buildLoadingIndicator();
            }
            return _buildMatchCard(_allMatches[index]);
          },
        ),
      ),
    );
  }

  bool _canManageMatches(user) {
    // Admin, Coach, or Referee can manage matches
    return user.isAdmin || user.isCoach || user.isReferee;
  }

  Widget _buildNoAccessView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Access Restricted',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Only admins, coaches, and referees\ncan manage matches',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
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
            'No Matches',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'No matches available for management',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: const AppLoader(),
    );
  }

  Widget _buildMatchCard(TournamentMatchModel match) {
    final isUpcoming = match.status == 'UPCOMING' || match.status == 'FIXTURE';
    final isLive = match.status == 'LIVE';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _navigateToMatchManagement(match),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Match status badge
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isLive
                          ? Colors.red
                          : isUpcoming
                              ? AppColors.socaYellow
                              : Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      match.status ?? 'UNKNOWN',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: isLive || isUpcoming
                            ? AppColors.socaBlack
                            : Colors.grey[700],
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (match.matchDate != null)
                    Text(
                      match.matchDate!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),

              // Teams
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        if (match.homeTeamLogo != null)
                          Image.network(
                            match.homeTeamLogo!,
                            width: 40,
                            height: 40,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.shield,
                              size: 40,
                              color: Colors.grey,
                            ),
                          )
                        else
                          const Icon(
                            Icons.shield,
                            size: 40,
                            color: Colors.grey,
                          ),
                        const SizedBox(height: 8),
                        Text(
                          match.homeTeamName ?? 'Team A',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        if (!isUpcoming &&
                            match.homeScore != null &&
                            match.awayScore != null)
                          Text(
                            '${match.homeScore} - ${match.awayScore}',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.socaBlack,
                            ),
                          )
                        else
                          const Text(
                            'VS',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        if (match.awayTeamLogo != null)
                          Image.network(
                            match.awayTeamLogo!,
                            width: 40,
                            height: 40,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.shield,
                              size: 40,
                              color: Colors.grey,
                            ),
                          )
                        else
                          const Icon(
                            Icons.shield,
                            size: 40,
                            color: Colors.grey,
                          ),
                        const SizedBox(height: 8),
                        Text(
                          match.awayTeamName ?? 'Team B',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Manage button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _navigateToMatchManagement(match),
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Manage Match'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.socaYellow,
                    foregroundColor: AppColors.socaBlack,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMatchManagement(TournamentMatchModel match) {
    // Navigate to match management screen
    context.push(
      '/match-management/${match.matchId}',
      extra: {
        'match': match,
        'tournamentId': widget.tournamentId,
      },
    );
  }
}
