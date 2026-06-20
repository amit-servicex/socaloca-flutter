import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/router/app_routes.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/tournament_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Tournaments Section for Endorse Tab
/// Shows horizontal scrollable list of tournaments
class TournamentsSection extends StatelessWidget {
  final List<TournamentModel> tournaments;
  final bool isLoadingTournaments;

  const TournamentsSection({
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
      return const AppLoader();
    }

    if (tournaments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
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
                      log("this is the tournamentt url ${tournament.imageUrl}");
                      return GestureDetector(
                        onTap: () {
                          // TODO: Navigate to tournament detail
                          String route = AppRoutes.tournamentDetail;

                          route = route.replaceFirst(
                              ':tmntId', tournament.tmntId ?? '');
                          context.push(route);
                        },
                        child: Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 12),
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.socaGrey.withOpacity(0.2),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: _isValidImageUrl(tournament.imageUrl)
                                      ? CachedNetworkImage(
                                          imageUrl: ApiConstants.getImageUrl(
                                              tournament.imageUrl),
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const AppLoader(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.emoji_events,
                                            color: AppColors.socaGrey,
                                            size: 40,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.emoji_events,
                                          color: AppColors.socaGrey,
                                          size: 40,
                                        ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                tournament.tmntName ?? '',
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
              ),
            ),
            Positioned(
              top: -25,
              left: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.socaBlack,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'TOURNAMENTS'.tr,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.socaYellow,
                      ),
                    ),
                  ),
                  // if (tournaments.length > 3)
                  //   GestureDetector(
                  //     onTap: () {
                  //       // TODO: Navigate to all tournaments
                  //     },
                  //     child: Text(
                  //       'view all'.tr,
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
            )
          ],
        ),
      ],
    );
  }
}
