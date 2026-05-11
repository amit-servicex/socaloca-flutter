import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/match_training_status_model.dart';
import '../data/models/player_bio_model.dart';

/// My Matches Section for Endorse Tab
/// Shows Football and Futsal matches separately
class MyMatchesSection extends StatelessWidget {
  final MatchTrainingStatusModel? footballMatches;
  final MatchTrainingStatusModel? futsalMatches;
  final PlayerBioModel playerBio;
  final bool isOwnProfile;
  final bool isLoadingMatches;

  const MyMatchesSection({
    super.key,
    required this.footballMatches,
    required this.futsalMatches,
    required this.playerBio,
    required this.isOwnProfile,
    required this.isLoadingMatches,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Football Matches
        _buildMatchSection(
          context,
          'Football',
          footballMatches,
        ),

        const SizedBox(height: 16),

        // Futsal Matches
        _buildMatchSection(
          context,
          'Futsal',
          futsalMatches,
        ),
      ],
    );
  }

  Widget _buildMatchSection(
    BuildContext context,
    String type,
    MatchTrainingStatusModel? matches,
  ) {
    final isGoalkeeper = playerBio.playPosition?.toLowerCase() == 'goalkeeper';

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
              Text(
                'My Matches Details',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaBlack,
                ),
              ),
              if (matches != null)
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to all matches
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
          const SizedBox(height: 8),
          Text(
            '$type, ${matches?.year ?? DateTime.now().year}',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: AppColors.socaGrey,
            ),
          ),
          const SizedBox(height: 16),
          if (isLoadingMatches)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(
                  color: AppColors.socaYellow,
                ),
              ),
            )
          else if (matches == null || matches.matches == 0)
            Column(
              children: [
                const Text(
                  'No matches available',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: AppColors.socaGrey,
                  ),
                ),
                if (isOwnProfile) ...[
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to add match
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socaBlack,
                      foregroundColor: AppColors.socaYellow,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ],
            )
          else
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        'Number of Matches',
                        matches.matches?.toString() ?? '0',
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        'Minutes Played',
                        matches.mins?.toString() ?? '0',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        'Number of Goals',
                        matches.goals?.toString() ?? '0',
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        isGoalkeeper ? 'Clean Sheets' : 'Number of Assists',
                        isGoalkeeper
                            ? (matches.cleanSheetCount?.toString() ?? '0')
                            : (matches.assists?.toString() ?? '0'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        'Average Match Rating',
                        matches.rating != null
                            ? matches.rating!.toStringAsFixed(2)
                            : '0.00',
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            color: AppColors.socaGrey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.socaBlack,
          ),
        ),
      ],
    );
  }
}
