import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/tournament_models.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Tournament list card — logo left, info right, VIEW + optional FOLLOW buttons.
///
/// [showFollow] should be driven by the user's role. Pass `true` to show
/// the FOLLOW / FOLLOWING button alongside VIEW.
class TournamentCard extends StatelessWidget {
  const TournamentCard({
    super.key,
    required this.tournament,
    this.onTap,
    this.onFollow,
    this.showFollow = false,
  });

  final TournamentModel tournament;
  final VoidCallback? onTap;
  final VoidCallback? onFollow;

  /// Show the FOLLOW button only when the current user is NOT an organiser.
  final bool showFollow;

  @override
  Widget build(BuildContext context) {
    final imageUrl = ApiConstants.getImageUrl(tournament.logo);
    final startLabel = _formatStartDate(tournament.startDate);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          // margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.socaGrey,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Left: circular logo ──────────────────────────────────
                _TournamentLogo(imageUrl: imageUrl),

                const SizedBox(width: 14),

                // ── Right: tags + info + buttons ─────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Age-group pill + sport label
                      _TagRow(
                        ageGroup: tournament.ageGroup,
                        gameType: _sportLabel(tournament.gameType),
                      ),

                      const SizedBox(height: 7),

                      // Tournament name (bold)
                      Text(
                        tournament.name ?? '',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: AppColors.socaBlack,
                          height: 1.25,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 5),

                      // Location
                      if (tournament.location != null &&
                          tournament.location!.isNotEmpty)
                        Text(
                          tournament.location!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.socaBlack.withOpacity(0.55),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                      const SizedBox(height: 3),

                      // Start date
                      if (startLabel.isNotEmpty)
                        Text(
                          startLabel,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.socaBlack.withOpacity(0.55),
                          ),
                        ),

                      const SizedBox(height: 12),

                      // Buttons row
                      Row(
                        children: [
                          // VIEW — always shown
                          _ActionButton(
                            label: 'VIEW',
                            filled: true,
                            onTap: onTap,
                          ),

                          // FOLLOW — role-gated
                          if (showFollow) ...[
                            const SizedBox(width: 10),
                            _ActionButton(
                              label: tournament.isFollowing
                                  ? 'FOLLOWING'
                                  : 'FOLLOW',
                              filled: false,
                              onTap: onFollow,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Maps raw gameType value to a display label.
  String _sportLabel(String? gameType) {
    if (gameType == null || gameType.isEmpty) return 'Football';
    switch (gameType.toLowerCase()) {
      case 'futsal':
        return 'Futsal';
      case 'beach':
        return 'Beach Soccer';
      case 'football':
      case 'soccer':
        return 'Football';
      default:
        return gameType[0].toUpperCase() + gameType.substring(1);
    }
  }

  /// Parses ISO date string → "Started on MMM D, YYYY".
  String _formatStartDate(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    try {
      final dt = DateTime.parse(raw);
      const months = [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return 'Started on ${months[dt.month]} ${dt.day}, ${dt.year}';
    } catch (_) {
      return 'Started on $raw';
    }
  }
}

// ── Age-group pill + sport label ────────────────────────────────────────────

class _TagRow extends StatelessWidget {
  const _TagRow({this.ageGroup, required this.gameType});

  final String? ageGroup;
  final String gameType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          // Age group — dark pill (matches design: "21-30")
          if (ageGroup != null && ageGroup!.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                ageGroup!,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.socaYellow,
                ),
              ),
            ),

          if (ageGroup != null && ageGroup!.isNotEmpty)
            const SizedBox(width: 8),

          // Sport label — plain text, no pill
          Text(
            gameType,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.socaBlack.withOpacity(0.65),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Circular tournament logo ────────────────────────────────────────────────

class _TournamentLogo extends StatelessWidget {
  const _TournamentLogo({required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF1A1A1A),
        border: Border.all(color: AppColors.socaBlack, width: 3),
      ),
      child: ClipOval(
        child: imageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const AppLoader(),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(
                    Icons.emoji_events,
                    color: AppColors.socaYellow,
                    size: 32,
                  ),
                ),
              )
            : const Center(
                child: Icon(
                  Icons.emoji_events,
                  color: AppColors.socaYellow,
                  size: 32,
                ),
              ),
      ),
    );
  }
}

// ── Action button (VIEW / FOLLOW) ───────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.filled,
    this.onTap,
  });

  final String label;
  final bool filled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 9),
        decoration: BoxDecoration(
          color: filled ? AppColors.socaBlack : Colors.white,
          border: filled
              ? null
              : Border.all(color: AppColors.socaBlack, width: 1.5),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: filled ? Colors.white : AppColors.socaBlack,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }
}
