import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/tournament_models.dart';
import 'tabs/score_entry_tab.dart';
import 'tabs/goal_entry_tab.dart';
import 'tabs/card_entry_tab.dart';
import 'tabs/mvp_selection_tab.dart';
import 'tabs/squad_management_tab.dart';

/// Match Management Screen
/// Full-screen interface for managing match details
/// Tabs: Score, Goals, Cards, MVP, Squad
/// Matches Android TournamentMatchManageFragment
class MatchManagementScreen extends ConsumerStatefulWidget {
  final String matchId;
  final TournamentMatchModel match;
  final String tournamentId;

  const MatchManagementScreen({
    super.key,
    required this.matchId,
    required this.match,
    required this.tournamentId,
  });

  @override
  ConsumerState<MatchManagementScreen> createState() =>
      _MatchManagementScreenState();
}

class _MatchManagementScreenState extends ConsumerState<MatchManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        title: Text(
          AppStrings.matchManagement,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.socaBlack,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.socaBlack),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Match Header
          _buildMatchHeader(),

          // Tabs
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.socaBlack,
              unselectedLabelColor: AppColors.socaBlack.withOpacity(0.5),
              indicatorColor: AppColors.socaYellow,
              indicatorWeight: 3,
              isScrollable: true,
              labelStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              tabs: [
                Tab(text: AppStrings.score.toUpperCase()),
                Tab(text: AppStrings.goals.toUpperCase()),
                Tab(text: AppStrings.cards.toUpperCase()),
                Tab(text: AppStrings.mvp.toUpperCase()),
                Tab(text: AppStrings.squad.toUpperCase()),
              ],
            ),
          ),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ScoreEntryTab(
                  matchId: widget.matchId,
                  match: widget.match,
                  tournamentId: widget.tournamentId,
                ),
                GoalEntryTab(
                  matchId: widget.matchId,
                  match: widget.match,
                  tournamentId: widget.tournamentId,
                ),
                CardEntryTab(
                  matchId: widget.matchId,
                  match: widget.match,
                  tournamentId: widget.tournamentId,
                ),
                MvpSelectionTab(
                  matchId: widget.matchId,
                  match: widget.match,
                  tournamentId: widget.tournamentId,
                ),
                SquadManagementTab(
                  matchId: widget.matchId,
                  match: widget.match,
                  tournamentId: widget.tournamentId,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchHeader() {
    final match = widget.match;
    final hasScore = match.homeScore != null && match.awayScore != null;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Teams and Score
          Row(
            children: [
              // Home Team
              Expanded(
                child: Column(
                  children: [
                    if (match.homeTeamLogo != null)
                      Image.network(
                        match.homeTeamLogo!,
                        width: 50,
                        height: 50,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.shield,
                          size: 50,
                          color: Colors.grey,
                        ),
                      )
                    else
                      const Icon(
                        Icons.shield,
                        size: 50,
                        color: Colors.grey,
                      ),
                    const SizedBox(height: 8),
                    Text(
                      match.homeTeamName ?? 'Team A',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Score or VS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    if (hasScore)
                      Text(
                        '${match.homeScore} - ${match.awayScore}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaBlack,
                        ),
                      )
                    else
                      Text(
                        AppStrings.vs,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),

              // Away Team
              Expanded(
                child: Column(
                  children: [
                    if (match.awayTeamLogo != null)
                      Image.network(
                        match.awayTeamLogo!,
                        width: 50,
                        height: 50,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.shield,
                          size: 50,
                          color: Colors.grey,
                        ),
                      )
                    else
                      const Icon(
                        Icons.shield,
                        size: 50,
                        color: Colors.grey,
                      ),
                    const SizedBox(height: 8),
                    Text(
                      match.awayTeamName ?? 'Team B',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Match Info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (match.matchDate != null) ...[
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  match.matchDate!,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
              if (match.venue != null) ...[
                const SizedBox(width: 16),
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  match.venue!,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 8),

          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getStatusColor(match.status),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              match.status ?? 'UNKNOWN',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.socaBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'LIVE':
        return Colors.red;
      case 'UPCOMING':
      case 'FIXTURE':
        return AppColors.socaYellow;
      case 'END':
      case 'COMPLETED':
        return Colors.green[300]!;
      default:
        return Colors.grey[300]!;
    }
  }
}
