import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart' show SharePlus, ShareParams;

import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../player_bio/providers/player_bio_provider.dart';
import '../../player_bio/widgets/player_bio_header.dart';
import '../../player_bio/widgets/player_bio_stats_counters.dart';
import '../../player_bio/widgets/player_bio_details_section.dart';
import '../../player_bio/widgets/stats_tab_content.dart';
import '../../player_bio/widgets/competition_stats_summary_section.dart';
import '../../player_bio/widgets/my_matches_section.dart';
import '../../player_bio/widgets/training_stats_section.dart';
import '../../player_bio/widgets/player_teams_section.dart';
import '../../player_bio/widgets/player_skills_section.dart';
import '../../player_bio/widgets/player_posts_section.dart';
import '../../player_bio/widgets/endorsements_section.dart';
import '../../player_bio/widgets/academies_section.dart';
import '../../player_bio/widgets/tournaments_section.dart';
import '../../player_bio/widgets/tagged_videos_section.dart';

/// My Bio screen — shows the logged-in user's own bio profile.
/// Single scrollable layout — no tabs.
class MyBioScreen extends ConsumerStatefulWidget {
  const MyBioScreen({super.key});

  @override
  ConsumerState<MyBioScreen> createState() => _MyBioScreenState();
}

class _MyBioScreenState extends ConsumerState<MyBioScreen> {
  late String _userId;

  @override
  void initState() {
    super.initState();
    _userId = StorageService.userId ?? '';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_userId.isNotEmpty) {
        ref.read(playerBioProvider(_userId).notifier).load();
      }
    });
  }

  void _showAddMatchSheet(String gameType) {
    context.push(
      AppRoutes.myActivities,
      extra: {
        'userId': _userId,
        'initialTab': 'match',
        'gameType': gameType,
      },
    );
  }

  void _showAddTrainingSheet() {
    context.push(
      AppRoutes.myActivities,
      extra: {
        'userId': _userId,
        'initialTab': 'training',
      },
    );
  }

  void _handleShare() {
    final state = ref.read(playerBioProvider(_userId));
    final playerBio = state.playerBio;
    if (playerBio == null) return;
    final name =
        '${playerBio.firstName ?? ''} ${playerBio.lastName ?? ''}'.trim();
    SharePlus.instance.share(ShareParams(
      text: '$name is inviting you to join Socaloca! '
          'Download: https://tinyurl.com/yxrtynk4 '
          'or AppStore: https://tinyurl.com/y6yqlovr',
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (_userId.isEmpty) {
      return const Scaffold(
        backgroundColor: AppColors.socaPageBg,
        body: Center(
          child: Text(
            'User not logged in',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
          ),
        ),
      );
    }

    final state = ref.watch(playerBioProvider(_userId));

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leadingWidth: 100,
      //   leading: Row(
      //     children: [
      //       const SizedBox(width: 8),
      //       GestureDetector(
      //         onTap: () => context.pop(),
      //         child: const Icon(Icons.arrow_back_ios_new,
      //             color: AppColors.socaBlack, size: 20),
      //       ),
      //       const SizedBox(width: 8),
      //       const Text(
      //         'My Bio',
      //         style: TextStyle(
      //           fontFamily: 'Poppins',
      //           fontSize: 16,
      //           fontWeight: FontWeight.w600,
      //           color: AppColors.socaBlack,
      //         ),
      //       ),
      //     ],
      //   ),
      //   title: Image.asset(
      //     'assets/images/logo.png',
      //     height: 35,
      //     errorBuilder: (_, __, ___) =>
      //         const Icon(Icons.sports_soccer, color: AppColors.socaBlack),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       icon:
      //           const Icon(Icons.search, color: AppColors.socaBlack, size: 24),
      //       onPressed: () {},
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.notifications_none,
      //           color: AppColors.socaBlack, size: 24),
      //       onPressed: () {},
      //     ),
      //     const SizedBox(width: 8),
      //   ],
      // ),

      body: _buildBody(state),
    );
  }

  Widget _buildBody(PlayerBioState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.socaYellow),
      );
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
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
              onPressed: () =>
                  ref.read(playerBioProvider(_userId).notifier).load(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                foregroundColor: AppColors.socaYellow,
              ),
              child:
                  const Text('Retry', style: TextStyle(fontFamily: 'Poppins')),
            ),
          ],
        ),
      );
    }

    if (state.playerBio == null) {
      return const Center(
        child: Text(
          'Profile not found',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Profile header (photo, name, jersey, verify badge) ──────────
          PlayerBioHeader(
            playerBio: state.playerBio!,
            isOwnProfile: true,
          ),

          Divider(height: 1, color: AppColors.socaBlack),

          // ── Engagement stats (Posts · Cheers · Followers · Following) ───
          PlayerBioStatsCounters(playerBio: state.playerBio!),

          Divider(height: 1, color: AppColors.socaBlack),

          // ── Quick action buttons ─────────────────────────────────────────
          _buildActionButtons(),

          // ── All bio sections ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlayerBioDetailsSection(
                  playerBio: state.playerBio!,
                  isOwnProfile: true,
                ),
                const SizedBox(height: 20),
                CompetitionStatsSummarySection(
                  footballStats: state.footballStats,
                  futsalStats: state.futsalStats,
                  playerBio: state.playerBio!,
                  isLoadingStats: state.isLoadingStats,
                ),
                const SizedBox(height: 20),
                MyMatchesSection(
                  footballMatches: state.footballMatches,
                  futsalMatches: state.futsalMatches,
                  playerBio: state.playerBio!,
                  isOwnProfile: true,
                  isLoadingMatches: state.isLoadingMatches,
                  onAddFootball: () => _showAddMatchSheet('Football'),
                  onAddFutsal: () => _showAddMatchSheet('Futsal'),
                ),
                const SizedBox(height: 20),
                TrainingStatsSection(
                  trainCurrMonth: state.trainCurrMonth,
                  trainPrevMonth: state.trainPrevMonth,
                  isOwnProfile: true,
                  isLoadingMatches: state.isLoadingMatches,
                  onAdd: _showAddTrainingSheet,
                ),
                const SizedBox(height: 20),
                EndorsementsSection(
                  endorsements: state.endorsements,
                  isLoadingEndorsements: state.isLoadingEndorsements,
                ),
                if (state.endorsements.isNotEmpty) const SizedBox(height: 20),
                PlayerTeamsSection(
                  teams: state.teams,
                  isLoadingTeams: state.isLoadingTeams,
                ),
                if (state.teams.isNotEmpty) const SizedBox(height: 20),
                AcademiesSection(
                  academies: state.academies,
                  isLoadingAcademies: state.isLoadingAcademies,
                ),
                if (state.academies.isNotEmpty) const SizedBox(height: 20),
                TournamentsSection(
                  tournaments: state.tournaments,
                  isLoadingTournaments: state.isLoadingTournaments,
                ),
                if (state.tournaments.isNotEmpty) const SizedBox(height: 20),
                PlayerSkillsSection(
                  skills: state.skills,
                  overallRating: state.overallRating,
                  isLoadingSkills: state.isLoadingSkills,
                  isOwnProfile: true,
                ),
                const SizedBox(height: 20),
                PlayerPostsSection(
                  posts: state.posts,
                  isLoadingPosts: state.isLoadingPosts,
                ),
                if (state.posts.isNotEmpty) const SizedBox(height: 20),
                TaggedVideosSection(
                  taggedVideos: state.taggedVideos,
                  isLoadingTaggedVideos: state.isLoadingTaggedVideos,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ActionBtn(
              label: 'CREATE A POST',
              onTap: () => context.push(AppRoutes.createPost),
            ),
            _ActionBtn(
              label: 'MY STATS',
              onTap: () => context.push(
                AppRoutes.myActivities,
                extra: {'userId': _userId, 'initialTab': 'match'},
              ),
            ),
            _ActionBtn(
              label: 'ENDORSEMENTS',
              onTap: () => context.push(
                AppRoutes.myEndorsementList,
                extra: {'userId': _userId, 'isOwnProfile': true},
              ),
            ),
            _ActionBtn(
              label: 'RATINGS',
              onTap: () => context.push(
                AppRoutes.mySkillRatings,
                extra: {'userId': _userId},
              ),
            ),
            GestureDetector(
              onTap: _handleShare,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Icon(Icons.share, color: AppColors.socaBlack, size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: AppColors.socaBlack,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: AppColors.socaYellow,
          ),
        ),
      ),
    );
  }
}
