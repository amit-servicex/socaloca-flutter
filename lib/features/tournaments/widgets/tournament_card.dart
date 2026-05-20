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
    final ageLabel = (tournament.ageCat?.isNotEmpty == true)
        ? tournament.ageCat
        : tournament.ageGroup;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(top: 5, bottom: 15),
        color: AppColors.socaGrey,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.socaGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                        ageGroup: ageLabel,
                        gameType: tournament.gameType ?? '',
                      ),

                      const SizedBox(height: 4),

                      // Tournament name (bold)
                      Text(
                        tournament.name ?? '',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
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
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.socaBlack,
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
                            color: AppColors.socaBlack,
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
  /// Parses date string → Android-style "Starts/Started on MMM D, YYYY".
  String _formatStartDate(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    final prefix =
        (tournament.status?.toLowerCase() == 'init') ? 'Starts' : 'Started on';
    try {
      final dt = _parseDate(raw);
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
      return '$prefix ${months[dt.month]} ${dt.day}, ${dt.year}';
    } catch (_) {
      return '$prefix $raw';
    }
  }

  DateTime _parseDate(String raw) {
    final iso = DateTime.tryParse(raw);
    if (iso != null) return iso;
    final parts = raw.split('-');
    if (parts.length == 3) {
      final day = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final year = int.tryParse(parts[2]);
      if (day != null && month != null && year != null) {
        return DateTime(year, month, day);
      }
    }
    throw FormatException('Unsupported date: $raw');
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Age group — dark pill (matches design: "21-30")
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
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.socaYellow,
                ),
              ),
            ),

          if (ageGroup != null && ageGroup!.isNotEmpty)
            const SizedBox(width: 5),

          // Sport label — plain text, no pill
          Text(
            gameType,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.socaBlack,
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
        constraints: const BoxConstraints(minWidth: 85),
        decoration: BoxDecoration(
          color: filled ? AppColors.socaBlack : Colors.white,
          border:
              filled ? null : Border.all(color: AppColors.socaBlack, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: filled ? AppColors.socaYellow : AppColors.socaBlack,
          ),
        ),
      ),
    );
  }
}
