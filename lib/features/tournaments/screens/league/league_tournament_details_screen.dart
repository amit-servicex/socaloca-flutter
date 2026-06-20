import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/tournament_models.dart';
import '../../providers/tournament_providers.dart';
import 'league_info_details_screen.dart';
import 'tabs/league_matches_tab.dart';
import 'tabs/league_points_table_tab.dart';
import 'tabs/league_stats_tab.dart';

/// League Tournament Details Screen
/// Shows banner, "VIEW TOURNAMENT DETAILS" bar, and Matches/Points Table/Stats tabs.
/// Matches Android TournamentDetailsFragment.
class LeagueTournamentDetailsScreen extends ConsumerStatefulWidget {
  final String tournamentId;

  const LeagueTournamentDetailsScreen({
    super.key,
    required this.tournamentId,
  });

  @override
  ConsumerState<LeagueTournamentDetailsScreen> createState() =>
      _LeagueTournamentDetailsScreenState();
}

class _LeagueTournamentDetailsScreenState
    extends ConsumerState<LeagueTournamentDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _tabs = ['MATCHES', 'POINTS TABLE', 'STATS'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tournamentAsync =
        ref.watch(tournamentDetailsProvider(widget.tournamentId));

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      // appBar: AppBar(
      //   title: Text(
      //     'Tournament'.tr,
      //     style: const TextStyle(
      //       fontFamily: 'Poppins',
      //       fontWeight: FontWeight.w700,
      //       fontSize: 18,
      //       color: AppColors.socaBlack,
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: AppColors.socaBlack),
      //     onPressed: () => context.pop(),
      //   ),
      // ),

      body: tournamentAsync.when(
        data: (tournament) {
          if (tournament == null) {
            return Center(child: Text(AppStrings.tournamentNotFound));
          }
          return _buildContent(tournament);
        },
        loading: () => const AppLoader(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(AppStrings.errorLoadingTournament(error)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref
                    .invalidate(tournamentDetailsProvider(widget.tournamentId)),
                child: Text(AppStrings.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(TournamentModel tournament) {
    return Column(
      children: [
        // Banner
        if (tournament.banners != null && tournament.banners!.isNotEmpty) ...[
          _buildBanner(tournament.banners!.first),
        ] else ...[
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                // Banner Image (placeholder for now)
                Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey[300]!,
                          Colors.grey[400]!,
                        ],
                      ),
                    ),
                    child: Image.asset(
                        "assets/images/tournament_defalut_banner.jpg",
                        fit: BoxFit.cover)),
              ],
            ),
          )
        ],
        // "VIEW TOURNAMENT DETAILS" bar
        _buildDetailsBar(),

        // Tabs
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.socaBlack,
            unselectedLabelColor: AppColors.socaBlack,
            indicatorColor: AppColors.socaBlack,
            indicatorWeight: 3,
            labelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            tabs: _tabs.map((t) => Tab(text: t)).toList(),
          ),
        ),

        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              LeagueMatchesTab(tournamentId: widget.tournamentId),
              LeaguePointsTableTab(tournamentId: widget.tournamentId),
              LeagueStatsTab(tournamentId: widget.tournamentId),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBanner(BannerModel banner) {
    final imageUrl = ApiConstants.getImageUrl(banner.imageUrl);
    if (imageUrl.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      width: double.infinity,
      height: 180,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey[200],
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: Icon(Icons.image_not_supported,
              size: 48, color: Colors.grey[400]),
        ),
      ),
    );
  }

  Widget _buildDetailsBar() {
    return GestureDetector(
      onTap: _openInfoDetails,
      child: Container(
        color: AppColors.socaBlack,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'VIEW TOURNAMENT DETAILS ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.socaYellow,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            IconButton(
              icon: Image.asset(
                "assets/icons/ic_info.png",
                width: 24,
                height: 24,
              ),
              onPressed: _openInfoDetails,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }

  void _openInfoDetails() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            LeagueInfoDetailsScreen(tournamentId: widget.tournamentId),
      ),
    );
  }
}
