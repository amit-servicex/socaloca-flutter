import 'dart:developer';
import 'package:socaloca/core/constants/app_strings.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socaloca/shared/models/team_model.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Teams Horizontal List Widget
/// Displays tournament teams in a horizontal scrollable list
/// Matches Android TournamentTeamAdapter
class TeamsHorizontalList extends StatelessWidget {
  final List<TeamModel> teams;
  final VoidCallback? onViewAllTap;
  final Function(String teamId)? onTeamTap;

  TeamsHorizontalList({
    super.key,
    required this.teams,
    this.onViewAllTap,
    this.onTeamTap,
  });

  @override
  Widget build(BuildContext context) {
    if (teams.isEmpty) return SizedBox.shrink();

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Teams Playing (${teams.length})',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ],
                ),
                if (onViewAllTap != null && teams.length > 4)
                  TextButton(
                    onPressed: onViewAllTap,
                    child: Text(
                      'View All'.tr,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.socaYellow,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 12),

          // Horizontal List
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12),
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                return _buildTeamCard(team);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamCard(TeamModel team) {
    // log("this is the teams id ${team.logo} ${team.id}");

    return GestureDetector(
      onTap: onTeamTap != null ? () => onTeamTap!(team.id) : null,
      child: Container(
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Team Logo
            ClipOval(
              child: _buildTeamLogo(ApiConstants.getImageUrl(team.logo), 80),
            ),

            SizedBox(height: 8),

            // Team Name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                team.name ?? 'Unknown',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.socaBlack,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamLogo(String? logoUrl, double size) {
    log("this is the image url ${logoUrl}");
    if (logoUrl == null || logoUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.shield,
          size: size * 0.5,
          color: Colors.grey[400],
        ),
      );
    }

    final fullImageUrl = ApiConstants.getImageUrl(logoUrl);

    if (fullImageUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.shield,
          size: size * 0.5,
          color: Colors.grey[400],
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
        child: AppLoader(),
      ),
      errorWidget: (context, url, error) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.shield,
          size: size * 0.5,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}
