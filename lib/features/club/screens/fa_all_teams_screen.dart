import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/fa_bio_model.dart';

class FaAllTeamsScreen extends StatelessWidget {
  final String faName;
  final List<FaTeamModel> teams;

  const FaAllTeamsScreen({
    super.key,
    required this.faName,
    required this.teams,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 1,
      //   title: Text(
      //     faName,
      //     style: TextStyle(
      //       fontFamily: 'Poppins',
      //       fontSize: 16,
      //       fontWeight: FontWeight.w700,
      //       color: AppColors.socaBlack,
      //     ),
      //   ),
      //   iconTheme: IconThemeData(color: AppColors.socaBlack),
      // ),

      body: teams.isEmpty
          ? Center(
              child: Text(
                AppStrings.noTeamsFound,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: AppColors.socaBlack,
                ),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: teams.length,
              separatorBuilder: (_, __) => const Divider(
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
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: AppColors.socaBlack, width: .7))),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.socaGrey,
            ),
            child: ClipOval(
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const Icon(
                        Icons.group,
                        size: 24,
                        color: AppColors.socaBlack,
                      ),
                    )
                  : const Icon(
                      Icons.group,
                      size: 24,
                      color: AppColors.socaBlack,
                    ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      team.teamName,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.socaBlack,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (team.teamTypeLabel.isNotEmpty)
                      Text(
                        team.teamTypeLabel,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.socaBlack,
                        ),
                      ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.socaBlack,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "FEATURED",
                    style: TextStyle(
                        color: AppColors.socaYellow,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
