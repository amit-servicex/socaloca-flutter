import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../models/match_model.dart';
import 'status_badge.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({
    super.key,
    required this.match,
    this.onTap,
    this.showTournament = false,
  });

  final MatchModel match;
  final VoidCallback? onTap;
  final bool showTournament;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              if (showTournament && match.tournamentName != null) ...[
                Text(
                  match.tournamentName!,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
              ],
              Row(
                children: [
                  Expanded(child: _teamWidget(match.homeTeamLogo, match.homeTeamName, true)),
                  _scoreWidget(),
                  Expanded(child: _teamWidget(match.awayTeamLogo, match.awayTeamName, false)),
                ],
              ),
              if (match.matchDate != null || match.venue != null) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (match.matchDate != null)
                      Text(
                        match.matchDate!,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    if (match.matchDate != null && match.venue != null)
                      const Text(' • ',
                          style: TextStyle(
                              color: AppColors.textSecondary, fontSize: 11)),
                    if (match.venue != null)
                      Flexible(
                        child: Text(
                          match.venue!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _teamWidget(String? logoUrl, String name, bool isHome) {
    return Column(
      children: [
        _teamLogo(logoUrl),
        const SizedBox(height: 4),
        Text(
          name,
          textAlign: isHome ? TextAlign.right : TextAlign.left,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _teamLogo(String? logoUrl) {
    if (logoUrl != null && logoUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: logoUrl,
        width: 44,
        height: 44,
        fit: BoxFit.contain,
        errorWidget: (_, __, ___) => _placeholderLogo(),
      );
    }
    return _placeholderLogo();
  }

  Widget _placeholderLogo() {
    return Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(
        color: AppColors.border,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.sports_soccer, color: AppColors.textSecondary),
    );
  }

  Widget _scoreWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          if (match.status != null)
            StatusBadge.matchStatus(match.status!),
          const SizedBox(height: 6),
          if (match.score != null)
            Text(
              '${match.score!.homeGoals}  -  ${match.score!.awayGoals}',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: AppColors.textPrimary,
              ),
            )
          else
            const Text(
              'vs',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }
}
