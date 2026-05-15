import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/team_bio_model.dart';
import '../providers/team_players_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class TeamPlayersScreen extends ConsumerWidget {
  final String teamId;

  const TeamPlayersScreen({
    super.key,
    required this.teamId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamPlayersProvider(teamId));

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: AppColors.socaBlack,
      //   foregroundColor: AppColors.socaYellow,
      //   title: const Text(
      //     'Players',
      //     style: TextStyle(
      //       fontFamily: 'Poppins',
      //       fontWeight: FontWeight.w600,
      //       fontSize: 18,
      //     ),
      //   ),
      // ),

      body: _buildBody(context, ref, state),
    );
  }

  Widget _buildBody(
      BuildContext context, WidgetRef ref, TeamPlayersState state) {
    if (state.isLoading) {
      return const AppLoader();
    }

    if (state.error != null) {
      return _buildErrorState(context, ref, state.error!);
    }

    if (state.allPlayers.isEmpty) {
      return const Center(
        child: Text('No players found'),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(teamPlayersProvider(teamId).notifier).refresh();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with total count
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'Players',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.socaGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${state.allPlayers.length} total player${state.allPlayers.length == 1 ? "" : "s"}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Goalkeepers
            if (state.goalkeepers.isNotEmpty) ...[
              _buildPositionSection(context, 'Goalkeepers', state.goalkeepers),
              const SizedBox(height: 35),
            ],
            // Defenders
            if (state.defenders.isNotEmpty) ...[
              _buildPositionSection(context, 'Defenders', state.defenders),
              const SizedBox(height: 35),
            ],
            // Midfielders
            if (state.midfielders.isNotEmpty) ...[
              _buildPositionSection(context, 'Midfielders', state.midfielders),
              const SizedBox(height: 35),
            ],

            // Attackers
            if (state.attackers.isNotEmpty) ...[
              _buildPositionSection(context, 'Attackers', state.attackers),
              const SizedBox(height: 35),
            ],

            // Coaches/Managers
            if (state.coaches.isNotEmpty) ...[
              _buildPositionSection(context, 'Coaches & Managers', state.coaches),
              const SizedBox(height: 35),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildPositionSection(BuildContext context, String title, List<TeamPlayerModel> players) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: AppColors.socaGrey, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Players List
              Container(
                padding: const EdgeInsets.only(right: 18),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: players.length,
                  separatorBuilder: (_, index) => const Divider(
                    height: 1,
                    thickness: .6,
                    color: AppColors.socaBlack,
                    indent: 80,
                  ),
                  itemBuilder: (_, index) {
                    final player = players[index];
                    return _buildPlayerCard(context, player);
                  },
                ),
              ),
              // Section Header
              Positioned(
                top: -25,
                left: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.socaBlack,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaYellow,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerCard(BuildContext context, TeamPlayerModel player) {
    return InkWell(
      onTap: () {
        final userId = player.userId;
        if (userId != null && userId.isNotEmpty) {
          context.push(
            AppRoutes.playerBio.replaceFirst(':userId', userId),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Jersey Number
            SizedBox(
              width: 40,
              child: Text(
                player.jerseyNumber ?? '',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(width: 12),

            // Player Avatar
            ClipOval(
              child: _buildPlayerAvatar(player.profileImage, 50),
            ),

            const SizedBox(width: 16),

            // Player Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Player Name
                  Text(
                    player.fullName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Position and Country
                  Row(
                    children: [
                      if (player.playPosition != null &&
                          player.playPosition!.isNotEmpty)
                        Text(
                          _getPositionAbbreviation(player.playPosition!),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      if (player.playPosition != null &&
                          player.playPosition!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[600],
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      // Show jersey number as role if no position (for coaches)
                      if ((player.playPosition == null ||
                              player.playPosition!.isEmpty) &&
                          player.jerseyNumber != null &&
                          player.jerseyNumber!.isNotEmpty)
                        Text(
                          player.jerseyNumber!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      if ((player.playPosition == null ||
                              player.playPosition!.isEmpty) &&
                          player.jerseyNumber != null &&
                          player.jerseyNumber!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[600],
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      Text(
                        'India', // TODO: Get from player data if available
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPositionAbbreviation(String position) {
    switch (position.toLowerCase()) {
      case 'goalkeeper':
        return 'Goalkeeper (GK)';
      case 'defender':
        return 'Defender';
      case 'midfield':
        return 'Midfielder';
      case 'attack':
        return 'Attacker';
      case 'coach':
        return 'Coach';
      case 'manager':
        return 'Manager';
      default:
        return position;
    }
  }

  Widget _buildPlayerAvatar(String? imageUrl, double size) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person,
          size: size * 0.5,
          color: Colors.grey,
        ),
      );
    }

    final fullImageUrl = ApiConstants.getImageUrl(imageUrl);

    if (fullImageUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person,
          size: size * 0.5,
          color: Colors.grey,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: fullImageUrl,
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        width: size,
        height: size,
        color: Colors.grey[200],
        child: const AppLoader(),
      ),
      errorWidget: (context, url, error) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person,
          size: size * 0.5,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load players',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              error,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ref.read(teamPlayersProvider(teamId).notifier).refresh();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.socaBlack,
              foregroundColor: AppColors.socaYellow,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
