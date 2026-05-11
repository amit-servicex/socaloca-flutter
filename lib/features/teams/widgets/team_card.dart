import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/team_model.dart';

class TeamCard extends StatelessWidget {
  final TeamModel team;

  const TeamCard({
    super.key,
    required this.team,
  });

  @override
  Widget build(BuildContext context) {
    // Safely parse rating to avoid runtime exceptions from String/null mismatches
    double ratingValue = 0.0;
    try {
      dynamic r = team.rating;
      if (r != null) {
        if (r is num) {
          ratingValue = r.toDouble();
        } else {
          ratingValue = double.tryParse(r.toString()) ?? 0.0;
        }
      }
    } catch (_) {}
    double progressValue = (ratingValue / 5.0).clamp(0.0, 1.0);
    if (progressValue.isNaN) progressValue = 0.0;

    // Safely extract properties to prevent model getter exceptions from crashing layout
    String safeGameTypeYear = '';
    try {
      safeGameTypeYear = '${team.gameTypeYear}';
    } catch (_) {}

    String safeTeamName = '';
    try {
      safeTeamName = '${team.teamName}';
    } catch (_) {}

    String safeMemberText = '';
    try {
      safeMemberText = '${team.memberText}';
    } catch (_) {}

    String safeCountry = '';
    try {
      final c = team.country;
      if (c != null) safeCountry = c.toString();
    } catch (_) {}
    return Card(
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      elevation: 4,
      child: InkWell(
        onTap: () => _handleViewTap(context),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Team Logo
              _buildTeamLogo(),
              const SizedBox(width: 17),

              // Team Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Game Type & Year
                    if (safeGameTypeYear.isNotEmpty)
                      Text(
                        safeGameTypeYear,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    if (safeGameTypeYear.isNotEmpty) const SizedBox(height: 4),

                    // Team Name
                    Text(
                      safeTeamName,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.socaBlack,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Country
                    if (safeCountry.isNotEmpty)
                      Text(
                        safeCountry,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    if (safeCountry.isNotEmpty) const SizedBox(height: 4),

                    // Member Count
                    if (safeMemberText.isNotEmpty)
                      Text(
                        safeMemberText,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    if (safeMemberText.isNotEmpty) const SizedBox(height: 8),

                    // Rating
                    Row(
                      children: [
                        const Text(
                          'Rating ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 4,
                            child: LinearProgressIndicator(
                              value: progressValue,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.socaYellow,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // VIEW Button
                    SizedBox(
                      width: 80,
                      child: ElevatedButton(
                        onPressed: () => _handleViewTap(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.socaBlack,
                          foregroundColor: AppColors.socaYellow,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'VIEW',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamLogo() {
    String? imageUrl;
    try {
      imageUrl = team.teamImage?.toString();
    } catch (_) {}

    if (imageUrl == null || imageUrl.isEmpty) {
      return _buildDefaultLogo();
    }

    String fullImageUrl = '';
    try {
      fullImageUrl = ApiConstants.getImageUrl(imageUrl);
    } catch (_) {}

    if (fullImageUrl.isEmpty) {
      return _buildDefaultLogo();
    }

    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: fullImageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: 60,
          height: 60,
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => _buildDefaultLogo(),
      ),
    );
  }

  Widget _buildDefaultLogo() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.emoji_events,
        size: 30,
        color: Colors.grey,
      ),
    );
  }

  void _handleViewTap(BuildContext context) {
    // Navigate to Team Bio screen
    context.push('/teams/${team.teamId}');
  }
}
