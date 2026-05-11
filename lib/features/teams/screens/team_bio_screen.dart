import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/features/teams/data/models/team_match_model.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/team_bio_model.dart';
import '../providers/team_bio_provider.dart';

class TeamBioScreen extends ConsumerWidget {
  final String teamId;

  const TeamBioScreen({
    super.key,
    required this.teamId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamBioProvider(teamId));

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        backgroundColor: AppColors.socaBlack,
        foregroundColor: AppColors.socaYellow,
        title: const Text(
          'Team Bio',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: _buildBody(context, ref, state),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, TeamBioState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.socaYellow,
        ),
      );
    }

    if (state.error != null) {
      return _buildErrorState(context, ref, state.error!);
    }

    if (state.teamBio == null) {
      return const Center(
        child: Text('No team data available'),
      );
    }

    final teamBio = state.teamBio!;
    final teamDetails = teamBio.teamDetails;

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(teamBioProvider(teamId).notifier).refresh();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Image
            _buildBannerSection(teamDetails),

            // Team Info Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Team Name
                  Text(
                    teamDetails.teamName ?? 'Unknown Team',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Team Details Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Team Logo
                      _buildTeamLogo(teamDetails.teamImage),
                      const SizedBox(width: 16),

                      // Details Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Age Category Badge
                            if (teamDetails.ageCategory != null &&
                                teamDetails.ageCategory!.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.socaBlack,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  teamDetails.ageCategory!,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.socaYellow,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 8),

                            // Game Type
                            if (teamDetails.gameType != null &&
                                teamDetails.gameType!.isNotEmpty)
                              Text(
                                teamDetails.gameType!,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            const SizedBox(height: 4),

                            // Country
                            if (teamDetails.country != null &&
                                teamDetails.country!.isNotEmpty)
                              Text(
                                teamDetails.country!,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            const SizedBox(height: 4),

                            // Member Count
                            Text(
                              '${teamDetails.memberCount} Member${teamDetails.memberCount == 1 ? "" : "s"}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Coach Name
                            if (teamDetails.coachName != null &&
                                teamDetails.coachName!.isNotEmpty)
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Coach: '),
                                    TextSpan(
                                      text: teamDetails.coachName!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Team Stats
                  if (teamBio.ratingDetails != null)
                    _buildTeamStats(teamBio.ratingDetails!),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Players Section
            if (teamBio.players.isNotEmpty)
              _buildPlayersSection(context, teamBio),

            const SizedBox(height: 8),

            // Recent Matches Section
            _buildRecentMatchesSection(teamBio),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerSection(TeamDetailsModel teamDetails) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          // Banner Image (placeholder for now)
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[300]!,
                  Colors.grey[400]!,
                ],
              ),
            ),
            child: Icon(
              Icons.sports_soccer,
              size: 80,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamLogo(String? imageUrl) {
    Widget logoWidget;

    if (imageUrl == null || imageUrl.isEmpty) {
      logoWidget = _buildDefaultLogo();
    } else {
      final fullImageUrl = ApiConstants.getImageUrl(imageUrl);

      if (fullImageUrl.isEmpty) {
        logoWidget = _buildDefaultLogo();
      } else {
        logoWidget = ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: fullImageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              width: 80,
              height: 80,
              color: Colors.grey[200],
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            errorWidget: (context, url, error) => _buildDefaultLogo(),
          ),
        );
      }
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: logoWidget,
    );
  }

  Widget _buildDefaultLogo() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.emoji_events,
        size: 40,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildTeamStats(RatingDetailsModel ratingDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (ratingDetails.teamWork > 0)
          _buildStatBar('Team Work', ratingDetails.teamWork.toDouble()),
        if (ratingDetails.technical > 0)
          _buildStatBar('Technical', ratingDetails.technical.toDouble()),
        if (ratingDetails.aggressiveness > 0)
          _buildStatBar(
              'Aggressiveness', ratingDetails.aggressiveness.toDouble()),
        if (ratingDetails.tactical > 0)
          _buildStatBar('Tactical', ratingDetails.tactical.toDouble()),
        if (ratingDetails.overall > 0)
          _buildStatBar('Overall Rating', ratingDetails.overall.toDouble()),
      ],
    );
  }

  Widget _buildStatBar(String label, double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value / 5.0, // Android uses max value of 5
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.grey,
              ),
              minHeight: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayersSection(BuildContext context, TeamBioModel teamBio) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Players',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Flexible(
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/teams/$teamId/players');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socaBlack,
                      foregroundColor: AppColors.socaYellow,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'VIEW ALL',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Show first 4 players in a horizontal row
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  teamBio.players.length > 4 ? 4 : teamBio.players.length,
              itemBuilder: (context, index) {
                final player = teamBio.players[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      ClipOval(
                        child: _buildPlayerAvatar(player.profileImage, 40),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        player.firstName ?? '',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentMatchesSection(TeamBioModel teamBio) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Matches',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          if (teamBio.recentMatches.isEmpty)
            const Center(
              child: Text(
                'No matches played yet',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: teamBio.recentMatches.length,
              separatorBuilder: (context, index) => const Divider(height: 24),
              itemBuilder: (context, index) {
                final match = teamBio.recentMatches[index];
                return _buildMatchCard(context, match);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(BuildContext context, TeamMatchModel match) {
    final team1 = match.teams.isNotEmpty ? match.teams[0] : null;
    final team2 = match.teams.length > 1 ? match.teams[1] : null;
    final score = match.score;

    return InkWell(
      onTap: () {
        // Navigate to match details if matchId is available
        if (match.matchId != null && match.matchId!.isNotEmpty) {
          // TODO: Navigate to match details screen
          // context.push('/matches/${match.matchId}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Match details: ${match.matchId}'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            // Match Date & Time
            if (match.matchDate != null || match.matchTime != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  '${match.matchDate ?? ''} ${match.matchTime ?? ''}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),

            // Teams Row
            Row(
              children: [
                // Team 1
                Expanded(
                  child: Column(
                    children: [
                      _buildTeamMatchLogo(team1?.teamImage, 40),
                      const SizedBox(height: 8),
                      Text(
                        team1?.teamName ?? 'Team 1',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Score
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    score != null ? '${score.team1} - ${score.team2}' : 'vs',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),

                // Team 2
                Expanded(
                  child: Column(
                    children: [
                      _buildTeamMatchLogo(team2?.teamImage, 40),
                      const SizedBox(height: 8),
                      Text(
                        team2?.teamName ?? 'Team 2',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMatchLogo(String? imageUrl, double size) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.emoji_events,
          size: size * 0.5,
          color: Colors.grey,
        ),
      );
    }

    final fullImageUrl = ApiConstants.getImageUrl(imageUrl);

    if (fullImageUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.emoji_events,
          size: size * 0.5,
          color: Colors.grey,
        ),
      );
    }

    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: fullImageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: size,
          height: size,
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.emoji_events,
            size: size * 0.5,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerAvatar(String? imageUrl, double size) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person,
          size: size * 0.5,
          color: Colors.grey,
        ),
      );
    }

    final fullImageUrl = ApiConstants.getImageUrl(imageUrl);

    if (fullImageUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person,
          size: size * 0.5,
          color: Colors.grey,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: fullImageUrl,
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        width: size,
        height: size,
        color: Colors.grey[200],
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person,
          size: size * 0.5,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load team bio',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              error,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ref.read(teamBioProvider(teamId).notifier).refresh();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.socaBlack,
              foregroundColor: AppColors.socaYellow,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
