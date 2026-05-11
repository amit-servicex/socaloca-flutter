import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/player_bio_provider.dart';
import '../widgets/player_bio_header.dart';
import '../widgets/player_bio_stats_counters.dart';
import '../widgets/player_bio_details_section.dart';
import '../widgets/stats_tab_content.dart';
import '../widgets/competition_stats_summary_section.dart';
import '../widgets/my_matches_section.dart';
import '../widgets/training_stats_section.dart';
import '../widgets/player_teams_section.dart';
import '../widgets/player_skills_section.dart';
import '../widgets/player_posts_section.dart';
import '../widgets/endorsements_section.dart';
import '../widgets/academies_section.dart';
import '../widgets/tournaments_section.dart';
import '../widgets/tagged_videos_section.dart';

/// Player Bio Screen with Stats and Endorse tabs
class PlayerBioScreen extends ConsumerStatefulWidget {
  final String playerId;

  const PlayerBioScreen({
    super.key,
    required this.playerId,
  });

  @override
  ConsumerState<PlayerBioScreen> createState() => _PlayerBioScreenState();
}

class _PlayerBioScreenState extends ConsumerState<PlayerBioScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Default to Endorse tab (index 1)
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);

    // Load player bio data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(playerBioProvider(widget.playerId).notifier).load();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleShare() {
    final state = ref.read(playerBioProvider(widget.playerId));
    final playerBio = state.playerBio;

    if (playerBio != null) {
      final name =
          '${playerBio.firstName ?? ''} ${playerBio.lastName ?? ''}'.trim();
      Share.share(
        '$name is inviting you to join Socaloca! '
        'Download: https://tinyurl.com/yxrtynk4 '
        'or AppStore: https://tinyurl.com/y6yqlovr',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(playerBioProvider(widget.playerId));
    final currentUserId = StorageService.userId;
    final isOwnProfile = currentUserId == widget.playerId;

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        title: const Text('Player Bio'),
        backgroundColor: AppColors.socaBlack,
        foregroundColor: AppColors.socaYellow,
        elevation: 0,
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.socaYellow,
              ),
            )
          : state.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: AppColors.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.error!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref
                            .read(playerBioProvider(widget.playerId).notifier)
                            .load(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.socaBlack,
                          foregroundColor: AppColors.socaYellow,
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
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
                  : Column(
                      children: [
                        // Header Section
                        PlayerBioHeader(
                          playerBio: state.playerBio!,
                          isOwnProfile: isOwnProfile,
                        ),

                        // Action Buttons Row
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Follow Button
                              if (!isOwnProfile)
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => ref
                                        .read(playerBioProvider(widget.playerId)
                                            .notifier)
                                        .toggleFollow(),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: state.isFollowing
                                            ? AppColors.socaYellow
                                            : AppColors.socaBlack,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        state.isFollowing
                                            ? 'FOLLOWING'
                                            : 'FOLLOW',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: state.isFollowing
                                              ? AppColors.socaBlack
                                              : AppColors.socaYellow,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),

                              if (!isOwnProfile) const SizedBox(width: 10),

                              // Share Button
                              GestureDetector(
                                onTap: _handleShare,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.socaGrey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(
                                    Icons.share,
                                    size: 20,
                                    color: AppColors.socaBlack,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              // Like Button
                              if (!isOwnProfile)
                                GestureDetector(
                                  onTap: () => ref
                                      .read(playerBioProvider(widget.playerId)
                                          .notifier)
                                      .toggleLike(),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.socaGrey,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Icon(
                                      state.isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 20,
                                      color: state.isLiked
                                          ? Colors.red
                                          : AppColors.socaBlack,
                                    ),
                                  ),
                                ),

                              // Block & Report buttons (TODO: implement)
                              if (!isOwnProfile) ...[
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    // TODO: Implement block user
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.socaGrey,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(
                                      Icons.block,
                                      size: 20,
                                      color: AppColors.socaBlack,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    // TODO: Implement report user
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.socaGrey,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(
                                      Icons.flag,
                                      size: 20,
                                      color: AppColors.socaBlack,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        // Stats Counters
                        PlayerBioStatsCounters(
                          playerBio: state.playerBio!,
                        ),

                        // Tab Bar
                        Container(
                          color: Colors.white,
                          child: TabBar(
                            controller: _tabController,
                            labelColor: AppColors.socaBlack,
                            unselectedLabelColor: AppColors.socaGrey,
                            indicatorColor: AppColors.socaYellow,
                            indicatorWeight: 3,
                            labelStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                            tabs: const [
                              Tab(text: 'STATS'),
                              Tab(text: 'ENDORSE'),
                            ],
                          ),
                        ),

                        // Tab Views
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              // Stats Tab
                              StatsTabContent(
                                playerId: widget.playerId,
                                playerBio: state.playerBio!,
                              ),

                              // Endorse Tab (Default)
                              SingleChildScrollView(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Bio Details Section
                                    PlayerBioDetailsSection(
                                      playerBio: state.playerBio!,
                                      isOwnProfile: isOwnProfile,
                                    ),

                                    const SizedBox(height: 20),

                                    // Competition Stats Summary
                                    CompetitionStatsSummarySection(
                                      footballStats: state.footballStats,
                                      futsalStats: state.futsalStats,
                                      playerBio: state.playerBio!,
                                      isLoadingStats: state.isLoadingStats,
                                    ),

                                    const SizedBox(height: 20),

                                    // My Matches (Football & Futsal)
                                    MyMatchesSection(
                                      footballMatches: state.footballMatches,
                                      futsalMatches: state.futsalMatches,
                                      playerBio: state.playerBio!,
                                      isOwnProfile: isOwnProfile,
                                      isLoadingMatches: state.isLoadingMatches,
                                    ),

                                    const SizedBox(height: 20),

                                    // Training Stats
                                    TrainingStatsSection(
                                      trainCurrMonth: state.trainCurrMonth,
                                      trainPrevMonth: state.trainPrevMonth,
                                      isOwnProfile: isOwnProfile,
                                      isLoadingMatches: state.isLoadingMatches,
                                    ),

                                    const SizedBox(height: 20),

                                    // Endorsements
                                    EndorsementsSection(
                                      endorsements: state.endorsements,
                                      isLoadingEndorsements:
                                          state.isLoadingEndorsements,
                                    ),

                                    if (state.endorsements.isNotEmpty)
                                      const SizedBox(height: 20),

                                    // Teams List
                                    PlayerTeamsSection(
                                      teams: state.teams,
                                      isLoadingTeams: state.isLoadingTeams,
                                    ),

                                    if (state.teams.isNotEmpty)
                                      const SizedBox(height: 20),

                                    // Academies List
                                    AcademiesSection(
                                      academies: state.academies,
                                      isLoadingAcademies:
                                          state.isLoadingAcademies,
                                    ),

                                    if (state.academies.isNotEmpty)
                                      const SizedBox(height: 20),

                                    // Tournaments List
                                    TournamentsSection(
                                      tournaments: state.tournaments,
                                      isLoadingTournaments:
                                          state.isLoadingTournaments,
                                    ),

                                    if (state.tournaments.isNotEmpty)
                                      const SizedBox(height: 20),

                                    // Skills & Ratings
                                    PlayerSkillsSection(
                                      skills: state.skills,
                                      overallRating: state.overallRating,
                                      isLoadingSkills: state.isLoadingSkills,
                                      isOwnProfile: isOwnProfile,
                                    ),

                                    const SizedBox(height: 20),

                                    // Top Posts
                                    PlayerPostsSection(
                                      posts: state.posts,
                                      isLoadingPosts: state.isLoadingPosts,
                                    ),

                                    if (state.posts.isNotEmpty)
                                      const SizedBox(height: 20),

                                    // Tagged Videos
                                    TaggedVideosSection(
                                      taggedVideos: state.taggedVideos,
                                      isLoadingTaggedVideos:
                                          state.isLoadingTaggedVideos,
                                    ),

                                    if (state.taggedVideos.isNotEmpty)
                                      const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
    );
  }
}
