import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/fa_bio_model.dart';

class FaAllTeamsScreen extends StatelessWidget {
  final String faName;
  final List<FaTeamModel> teams;

  FaAllTeamsScreen({
    super.key,
    required this.faName,
    required this.teams,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          faName,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.socaBlack,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.socaBlack),
      ),
      body: teams.isEmpty
          ? Center(
              child: Text(
                AppStrings.noTeamsFound,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: AppColors.socaBlack,
                ),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: teams.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                thickness: 0.8,
                color: AppColors.socaGrey,
              ),
              itemBuilder: (context, i) => _buildRow(teams[i]),
            ),
    );
  }

  Widget _buildRow(FaTeamModel team) {
    final imageUrl = team.fullImageUrl;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.socaGrey,
            ),
            child: ClipOval(
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Icon(
                        Icons.group,
                        size: 24,
                        color: AppColors.socaBlack,
                      ),
                    )
                  : Icon(
                      Icons.group,
                      size: 24,
                      color: AppColors.socaBlack,
                    ),
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  team.teamName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.socaBlack,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (team.teamTypeLabel.isNotEmpty)
                  Text(
                    team.teamTypeLabel,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
