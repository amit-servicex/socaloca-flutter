import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
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
import 'package:socaloca/shared/widgets/app_loader.dart';

/// My Bio screen — shows the logged-in user's own bio profile.
/// Single scrollable layout — no tabs.
class MyBioScreen extends ConsumerStatefulWidget {
  MyBioScreen({super.key});

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
      return Scaffold(
        backgroundColor: AppColors.socaPageBg,
        body: Center(
          child: Text(
            AppStrings.userNotLoggedIn,
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
      //       SizedBox(width: 8),
      //       GestureDetector(
      //         onTap: () => context.pop(),
      //         child: Icon(Icons.arrow_back_ios_new,
      //             color: AppColors.socaBlack, size: 20),
      //       ),
      //       SizedBox(width: 8),
      //       Text(
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
      //         Icon(Icons.sports_soccer, color: AppColors.socaBlack),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       icon:
      //           Icon(Icons.search, color: AppColors.socaBlack, size: 24),
      //       onPressed: () {},
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.notifications_none,
      //           color: AppColors.socaBlack, size: 24),
      //       onPressed: () {},
      //     ),
      //     SizedBox(width: 8),
      //   ],
      // ),

      body: _buildBody(state),
    );
  }

  Widget _buildBody(PlayerBioState state) {
    if (state.isLoading) {
      return AppLoader();
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColors.error),
            SizedBox(height: 16),
            Text(
              state.error!,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  ref.read(playerBioProvider(_userId).notifier).load(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                foregroundColor: AppColors.socaYellow,
              ),
              child: Text(AppStrings.retry,
                  style: TextStyle(fontFamily: 'Poppins')),
            ),
          ],
        ),
      );
    }

    if (state.playerBio == null) {
      return Center(
        child: Text(
          AppStrings.profileNotFound,
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
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlayerBioDetailsSection(
                  playerBio: state.playerBio!,
                  isOwnProfile: true,
                ),
                SizedBox(height: 20),
                CompetitionStatsSummarySection(
                  footballStats: state.footballStats,
                  futsalStats: state.futsalStats,
                  playerBio: state.playerBio!,
                  isLoadingStats: state.isLoadingStats,
                ),
                SizedBox(height: 20),
                MyMatchesSection(
                  footballMatches: state.footballMatches,
                  futsalMatches: state.futsalMatches,
                  playerBio: state.playerBio!,
                  isOwnProfile: true,
                  isLoadingMatches: state.isLoadingMatches,
                  onAddFootball: () => _showAddMatchSheet('Football'),
                  onAddFutsal: () => _showAddMatchSheet('Futsal'),
                ),
                SizedBox(height: 20),
                TrainingStatsSection(
                  trainCurrMonth: state.trainCurrMonth,
                  trainPrevMonth: state.trainPrevMonth,
                  isOwnProfile: true,
                  isLoadingMatches: state.isLoadingMatches,
                  onAdd: _showAddTrainingSheet,
                ),
                SizedBox(height: 20),
                EndorsementsSection(
                    endorsements: state.endorsements,
                    isLoadingEndorsements: state.isLoadingEndorsements,
                    userid: _userId),
                if (state.endorsements.isNotEmpty) SizedBox(height: 20),
                PlayerTeamsSection(
                  teams: state.teams,
                  isLoadingTeams: state.isLoadingTeams,
                ),
                if (state.teams.isNotEmpty) SizedBox(height: 20),
                AcademiesSection(
                  academies: state.academies,
                  isLoadingAcademies: state.isLoadingAcademies,
                ),
                if (state.academies.isNotEmpty) SizedBox(height: 20),
                TournamentsSection(
                  tournaments: state.tournaments,
                  isLoadingTournaments: state.isLoadingTournaments,
                ),
                if (state.tournaments.isNotEmpty) SizedBox(height: 20),
                PlayerSkillsSection(
                    skills: state.skills,
                    overallRating: state.overallRating,
                    isLoadingSkills: state.isLoadingSkills,
                    isOwnProfile: true,
                    userid: _userId),
                SizedBox(height: 20),
                PlayerPostsSection(
                  posts: state.posts,
                  isLoadingPosts: state.isLoadingPosts,
                ),
                if (state.posts.isNotEmpty) SizedBox(height: 20),
                TaggedVideosSection(
                  taggedVideos: state.taggedVideos,
                  isLoadingTaggedVideos: state.isLoadingTaggedVideos,
                ),
                SizedBox(height: 40),
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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ActionBtn(
              label: AppStrings.createPostUpper,
              onTap: () => context.push(AppRoutes.createPost),
            ),
            _ActionBtn(
              label: AppStrings.myStats.toUpperCase(),
              onTap: () => context.push(
                AppRoutes.myActivities,
                extra: {'userId': _userId, 'initialTab': 'match'},
              ),
            ),
            _ActionBtn(
              label: AppStrings.endorsements.toUpperCase(),
              onTap: () => context.push(
                AppRoutes.myEndorsementList,
                extra: {'userId': _userId, 'isOwnProfile': true},
              ),
            ),
            _ActionBtn(
              label: AppStrings.ratings.toUpperCase(),
              onTap: () => context.push(
                AppRoutes.mySkillRatings,
                extra: {'userId': _userId},
              ),
            ),
            GestureDetector(
              onTap: _handleShare,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset(
                  "assets/icons/ic_share.png",
                  width: 24,
                  height: 24,
                ),
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

  _ActionBtn({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        margin: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: AppColors.socaBlack,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
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
