import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/tournament_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Tournaments Section for Endorse Tab
/// Shows horizontal scrollable list of tournaments
class TournamentsSection extends StatelessWidget {
  final List<TournamentModel> tournaments;
  final bool isLoadingTournaments;

  TournamentsSection({
    super.key,
    required this.tournaments,
    required this.isLoadingTournaments,
  });

  bool _isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    if (url.startsWith('file:///')) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingTournaments) {
      return AppLoader();
    }

    if (tournaments.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'TOURNAMENTS'.tr,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaYellow,
                ),
              ),
            ),
            if (tournaments.length > 3)
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to all tournaments
                },
                child: Text(
                  'view all'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.socaGrey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tournaments.length,
              itemBuilder: (context, index) {
                final tournament = tournaments[index];
                return GestureDetector(
                  onTap: () {
                    // TODO: Navigate to tournament detail
                  },
                  child: Container(
                    width: 100,
                    margin: EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.socaGrey.withOpacity(0.2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: _isValidImageUrl(tournament.imageUrl)
                                ? CachedNetworkImage(
                                    imageUrl:
                                        '${ApiConstants.mediaBaseUrl}${tournament.imageUrl}',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => AppLoader(),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.emoji_events,
                                      color: AppColors.socaGrey,
                                      size: 40,
                                    ),
                                  )
                                : Icon(
                                    Icons.emoji_events,
                                    color: AppColors.socaGrey,
                                    size: 40,
                                  ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          tournament.tmntName ?? '',
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
      ],
    );
  }
}
