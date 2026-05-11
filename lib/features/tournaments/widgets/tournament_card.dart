import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/tournament_models.dart';

/// Tournament list card — mirrors Android CommonOngoingTournamentsAdapter item
class TournamentCard extends StatelessWidget {
  const TournamentCard({
    super.key,
    required this.tournament,
    this.onTap,
  });

  final TournamentModel tournament;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final imageUrl = ApiConstants.getImageUrl(tournament.logo);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circular logo
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.socaGrey,
                ),
                child: ClipOval(
                  child: imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.socaYellow,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.emoji_events,
                            color: AppColors.socaBlack,
                            size: 28,
                          ),
                        )
                      : const Icon(
                          Icons.emoji_events,
                          color: AppColors.socaBlack,
                          size: 28,
                        ),
                ),
              ),

              const SizedBox(width: 12),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      tournament.name ?? '',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.socaBlack,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // Age group + game type
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        if (tournament.ageGroup != null &&
                            tournament.ageGroup!.isNotEmpty)
                          _Tag(label: tournament.ageGroup!),
                        if (tournament.gameType != null &&
                            tournament.gameType!.isNotEmpty)
                          _Tag(
                            label: tournament.gameType!,
                            color: AppColors.socaBlack.withOpacity(0.08),
                          ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Location
                    if (tournament.location != null &&
                        tournament.location!.isNotEmpty)
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 13,
                              color: AppColors.socaBlack.withOpacity(0.5)),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              tournament.location!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                color: AppColors.socaBlack.withOpacity(0.6),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 4),

                    // Followers + teams
                    Row(
                      children: [
                        Icon(Icons.people,
                            size: 13,
                            color: AppColors.socaBlack.withOpacity(0.5)),
                        const SizedBox(width: 3),
                        Text(
                          _followText(tournament.followCount),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            color: AppColors.socaBlack.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.groups,
                            size: 13,
                            color: AppColors.socaBlack.withOpacity(0.5)),
                        const SizedBox(width: 3),
                        Text(
                          '${tournament.teamCount} teams',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            color: AppColors.socaBlack.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Status badge
              if (tournament.status != null)
                _StatusBadge(status: tournament.status!),
            ],
          ),
        ),
      ),
    );
  }

  String _followText(int count) {
    return count == 1 ? '1 follower' : '$count followers';
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, this.color});
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color ?? AppColors.socaYellow.withOpacity(0.25),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        _label,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Color get _color {
    switch (status.toLowerCase()) {
      case 'live':
        return Colors.red;
      case 'fixture':
        return Colors.blue;
      case 'init':
        return const Color(0xFF1565C0);
      case 'end':
        return Colors.grey;
      default:
        return AppColors.socaBlack;
    }
  }

  String get _label {
    switch (status.toLowerCase()) {
      case 'live':
        return 'LIVE';
      case 'fixture':
        return 'FIXTURE';
      case 'init':
        return 'UPCOMING';
      case 'end':
        return 'ENDED';
      default:
        return status.toUpperCase();
    }
  }
}
