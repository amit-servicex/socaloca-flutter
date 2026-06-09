import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../data/tournament_models.dart';
import '../../data/tournament_repository.dart';
import '../../widgets/match_card.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Matches tab — mirrors Android TournamentMatchesFragment
/// Shows upcoming and played matches (3 each, with "View All" button)
class TournamentMatchesTab extends ConsumerStatefulWidget {
  TournamentMatchesTab({super.key, required this.tournamentId});
  final String tournamentId;

  @override
  ConsumerState<TournamentMatchesTab> createState() =>
      _TournamentMatchesTabState();
}

class _TournamentMatchesTabState extends ConsumerState<TournamentMatchesTab>
    with AutomaticKeepAliveClientMixin {
  List<TournamentMatchModel> _upcoming = [];
  List<TournamentMatchModel> _played = [];
  bool _loading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    final repo = ref.read(tournamentRepositoryProvider);

    final results = await Future.wait([
      repo.getTournamentMatches(
        userId: user.id,
        tournamentId: widget.tournamentId,
        isUpcoming: true,
        limit: 3,
      ),
      repo.getTournamentMatches(
        userId: user.id,
        tournamentId: widget.tournamentId,
        isUpcoming: false,
        limit: 3,
      ),
    ]);

    if (mounted) {
      setState(() {
        _upcoming = results[0];
        _played = results[1];
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_loading) {
      return AppLoader();
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() => _loading = true);
        await _load();
      },
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Upcoming matches section
          _SectionHeader(
            title: AppStrings.upcomingMatches,
            showViewAll: _upcoming.isNotEmpty,
            onViewAll: () {
              // TODO: navigate to full upcoming matches list
            },
          ),
          SizedBox(height: 8),
          if (_upcoming.isEmpty)
            _EmptyState(message: AppStrings.noUpcomingMatches)
          else
            ..._upcoming.map((m) => MatchCard(
                  match: m,
                  onTap: () => _openMatchDetails(context, m),
                )),

          SizedBox(height: 20),

          // Played matches section
          _SectionHeader(
            title: AppStrings.playedMatches,
            showViewAll: _played.isNotEmpty,
            onViewAll: () {
              // TODO: navigate to full played matches list
            },
          ),
          SizedBox(height: 8),
          if (_played.isEmpty)
            _EmptyState(message: AppStrings.noPlayedMatches)
          else
            ..._played.map((m) => MatchCard(
                  match: m,
                  onTap: () => _openMatchDetails(context, m),
                )),
        ],
      ),
    );
  }

  void _openMatchDetails(BuildContext context, TournamentMatchModel match) {
    final matchId = match.effectiveId;
    if (matchId.isEmpty) return;
    context.push(
      AppRoutes.liveMatchDetails.replaceFirst(':matchId', matchId),
      extra: {
        'tournamentId': widget.tournamentId,
        'preferMatchData': true,
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  _SectionHeader({
    required this.title,
    required this.showViewAll,
    this.onViewAll,
  });
  final String title;
  final bool showViewAll;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: AppColors.socaBlack,
          ),
        ),
        if (showViewAll)
          GestureDetector(
            onTap: onViewAll,
            child: Text(
              AppStrings.viewAll,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.socaBlack,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  _EmptyState({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: AppColors.socaBlack.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}
