import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/team_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class TeamCard extends StatelessWidget {
  final TeamModel team;

  const TeamCard({
    super.key,
    required this.team,
  });

  static const double _logoSize = 80;

  @override
  Widget build(BuildContext context) {
    final ratingValue = team.rating.clamp(0.0, double.infinity);
    final progressValue = (ratingValue / 5.0).clamp(0.0, 1.0);

    String gameTypeYear = '';
    try {
      gameTypeYear = '${team.gameTypeYear}';
    } catch (_) {}

    String teamName = '';
    try {
      teamName = '${team.teamName}';
    } catch (_) {}

    String memberText = '';
    try {
      memberText = '${team.memberText}';
    } catch (_) {}

    String country = '';
    try {
      final c = team.country;
      if (c != null) country = c.toString();
    } catch (_) {}

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.black12,
      child: InkWell(
        onTap: () => _navigate(context),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLogo(),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Football | 2024
                    if (gameTypeYear.isNotEmpty) ...[
                      Text(
                        gameTypeYear,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 2),
                    ],

                    // BLUE DEVILS FC
                    Text(
                      teamName,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.socaBlack,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // India
                    if (country.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        country,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ],

                    // 0 Member
                    if (memberText.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        memberText,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ],

                    const SizedBox(height: 8),

                    // Rating ——
                    Row(
                      children: [
                        const Text(
                          'Rating  ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: AppColors.socaBlack,
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: progressValue,
                              minHeight: 3,
                              backgroundColor: AppColors.socaBlack,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.socaBlack,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // VIEW button
                    GestureDetector(
                      onTap: () => _navigate(context),
                      child: Container(
                        width: 80,
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        decoration: BoxDecoration(
                          color: AppColors.socaBlack,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'VIEW',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.socaYellow,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    String imageUrl = '';
    try {
      final raw = team.teamImage?.toString() ?? '';
      imageUrl = raw.isNotEmpty ? ApiConstants.getImageUrl(raw) : '';
    } catch (_) {}

    return Container(
      width: _logoSize,
      height: _logoSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => const AppLoader(),
              errorWidget: (_, __, ___) => _logoFallback(),
            )
          : _logoFallback(),
    );
  }

  Widget _logoFallback() {
    return const Icon(Icons.emoji_events, size: 32, color: Colors.grey);
  }

  void _navigate(BuildContext context) {
    context.push('/teams/${team.teamId}');
  }
}
