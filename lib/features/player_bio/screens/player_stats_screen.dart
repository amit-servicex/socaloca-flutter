import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/player_bio_provider.dart';
import '../widgets/stats_tab_content.dart';

class PlayerStatsScreen extends ConsumerWidget {
  final String playerId;

  const PlayerStatsScreen({
    super.key,
    required this.playerId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playerBioProvider(playerId));

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
    
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.socaYellow),
            )
          : state.playerBio == null
              ? const Center(
                  child: Text(
                    'Player not found',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: AppColors.socaBlack,
                    ),
                  ),
                )
              : StatsTabContent(
                  playerId: playerId,
                  playerBio: state.playerBio!,
                  embedded: false,
                ),
    );
  }
}
