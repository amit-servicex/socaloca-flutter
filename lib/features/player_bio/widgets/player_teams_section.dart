import 'dart:developer';
import 'package:socaloca/core/constants/app_strings.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/player_team_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Player Teams Section for Endorse Tab
/// Shows horizontal scrollable list of teams
class PlayerTeamsSection extends StatelessWidget {
  final List<PlayerTeamModel> teams;
  final bool isLoadingTeams;

  PlayerTeamsSection({
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
    log("this is the teams url in the player bio section ${teams.map((t) => t.imageUrl).toList()}");
    if (isLoadingTeams) {
      return AppLoader();
    }

    if (teams.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.socaGrey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    final team = teams[index];
                    return GestureDetector(
                      onTap: () {
                        final teamId = team.teamId;
                        if (teamId != null && teamId.isNotEmpty) {
                          context.push('/teams/$teamId');
                        }
                      },
                      child: Container(
                        width: 90,
                        margin: EdgeInsets.only(right: 12),
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
                                        imageUrl: ApiConstants.getImageUrl(
                                            team.imageUrl),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            AppLoader(),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.shield,
                                          color: AppColors.socaGrey,
                                          size: 30,
                                        ),
                                      )
                                    : Icon(
                                        Icons.shield,
                                        color: AppColors.socaGrey,
                                        size: 30,
                                      ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              team.teamName ?? '',
                              style: TextStyle(
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
            ),
            Positioned(
              top: -30,
              left: 10,
              child: Container(
                width: MediaQuery.of(context).size.width * .855,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.socaBlack,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'TEAMS'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaYellow,
                        ),
                      ),
                    ),
                    // if (teams.length > 3)
                    //   GestureDetector(
                    //     onTap: () {
                    //       // TODO: Navigate to all teams
                    //     },
                    //     child: Text(
                    //       AppStrings.viewAll,
                    //       style: TextStyle(
                    //         fontFamily: 'Poppins',
                    //         fontSize: 12,
                    //         fontWeight: FontWeight.w700,
                    //         color: AppColors.socaBlack,
                    //       ),
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
