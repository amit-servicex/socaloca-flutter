import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_loader.dart';
import '../data/tournament_models.dart';

class TournamentHeaderWidget extends StatelessWidget {
  const TournamentHeaderWidget({
    super.key,
    required this.tournament,
    required this.isFollowing,
    required this.followCount,
    this.onFollowTap,
    this.onLogoTap,
    this.showFollow = true,
  });

  final TournamentModel tournament;
  final bool isFollowing;
  final int followCount;
  final VoidCallback? onFollowTap;
  final VoidCallback? onLogoTap;
  final bool showFollow;

  @override
  Widget build(BuildContext context) {
    final imageUrl = ApiConstants.getImageUrl(tournament.logo);
    final ageLabel = (tournament.ageCat?.isNotEmpty == true)
        ? tournament.ageCat
        : tournament.ageGroup;

    return Container(
      color: AppColors.socaPageBg,
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: onLogoTap,
                child: Container(
                  width: 80,
                  height: 80,
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.socaBlack,
                  ),
                  child: ClipOval(
                    child: imageUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const AppLoader(),
                            errorWidget: (context, url, error) =>
                                const _LogoFallback(),
                          )
                        : const _LogoFallback(),
                  ),
                ),
              ),
              if (showFollow) ...[
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: onFollowTap,
                  child: Container(
                    width: 85,
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.socaBlack,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      isFollowing ? 'FOLLOWING' : 'FOLLOW',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: AppColors.socaYellow,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _followCountText(),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: AppColors.socaBlack,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderTagRow(
                    ageGroup: ageLabel,
                    gameType: tournament.gameType ?? '',
                  ),
                  const SizedBox(height: 3),
                  Text(
                    tournament.name ?? '',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.socaBlack,
                      height: 1.2,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (tournament.location != null &&
                      tournament.location!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      tournament.location!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: AppColors.socaBlack,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 2),
                  _buildDateInfo(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateInfo() {
    final startDate = tournament.startDate ?? '';
    if (startDate.isEmpty) return const SizedBox.shrink();

    final status = tournament.status?.toLowerCase() ?? '';
    final dateText = (status == 'init' || status == 'fixture')
        ? 'Starts $startDate'
        : 'Started on $startDate';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateText,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: AppColors.socaBlack,
          ),
        ),
        if ((status == 'init' || status == 'fixture') &&
            tournament.fsdGmtMs > 0) ...[
          const SizedBox(height: 2),
          Text(
            'Final Submission ${_formatFsdDate(tournament.fsdGmtMs)}',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: AppColors.socaBlack,
            ),
          ),
        ],
      ],
    );
  }

  String _followCountText() {
    if (followCount == 1) return '1 follower';
    return '$followCount followers';
  }

  String _formatFsdDate(int ms) {
    final dt = DateTime.fromMillisecondsSinceEpoch(ms);
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

class _LogoFallback extends StatelessWidget {
  const _LogoFallback();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.emoji_events,
      color: AppColors.socaYellow,
      size: 36,
    );
  }
}

class _HeaderTagRow extends StatelessWidget {
  const _HeaderTagRow({this.ageGroup, required this.gameType});

  final String? ageGroup;
  final String gameType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (ageGroup != null && ageGroup!.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                ageGroup!,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: AppColors.socaYellow,
                ),
              ),
            ),
          if (ageGroup != null && ageGroup!.isNotEmpty)
            const SizedBox(width: 5),
          if (gameType.isNotEmpty)
            Text(
              gameType,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: AppColors.socaBlack,
              ),
            ),
        ],
      ),
    );
  }
}
