import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/player_team_model.dart';

/// Player Teams Section for Endorse Tab
/// Shows horizontal scrollable list of teams
class PlayerTeamsSection extends StatelessWidget {
  final List<PlayerTeamModel> teams;
  final bool isLoadingTeams;

  const PlayerTeamsSection({
    super.key,
    required this.teams,
    required this.isLoadingTeams,
  });

  bool _isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    if (url.startsWith('file:///')) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingTeams) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(
              color: AppColors.socaYellow,
            ),
          ),
        ),
      );
    }

    if (teams.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Teams',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaBlack,
                ),
              ),
              if (teams.length > 3)
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to all teams
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: AppColors.socaYellow,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                return GestureDetector(
                  onTap: () {
                    // TODO: Navigate to team bio
                  },
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.socaGrey.withOpacity(0.2),
                          ),
                          child: ClipOval(
                            child: _isValidImageUrl(team.imageUrl)
                                ? CachedNetworkImage(
                                    imageUrl:
                                        '${ApiConstants.mediaBaseUrl}${team.imageUrl}',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.socaYellow,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.shield,
                                      color: AppColors.socaGrey,
                                      size: 30,
                                    ),
                                  )
                                : const Icon(
                                    Icons.shield,
                                    color: AppColors.socaGrey,
                                    size: 30,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          team.teamName ?? '',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            color: AppColors.socaBlack,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
