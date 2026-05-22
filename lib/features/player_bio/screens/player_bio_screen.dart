import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/player_bio_provider.dart';
import 'endorse_player_screen.dart';
import 'player_stats_screen.dart';
import '../../my_bio/screens/my_skill_ratings_screen.dart';
import '../widgets/player_bio_header.dart';
import '../widgets/player_bio_stats_counters.dart';
import '../widgets/player_bio_details_section.dart';
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
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Player Bio Screen with Stats and Endorse tabs
class PlayerBioScreen extends ConsumerStatefulWidget {
  final String playerId;
  final bool isCoachAdminProfile;

  PlayerBioScreen({
    super.key,
    required this.playerId,
    this.isCoachAdminProfile = false,
  });

  @override
  ConsumerState<PlayerBioScreen> createState() => _PlayerBioScreenState();
}

class _PlayerBioScreenState extends ConsumerState<PlayerBioScreen> {
  StateNotifierProvider<PlayerBioNotifier, PlayerBioState> get _bioProvider =>
      widget.isCoachAdminProfile
          ? coachAdminBioProvider(widget.playerId)
          : playerBioProvider(widget.playerId);

  @override
  void initState() {
    super.initState();
    // Load player bio data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(_bioProvider.notifier).load();
    });
  }

  void _handleShare() {
    final state = ref.read(_bioProvider);
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

  Future<void> _showBlockDialog(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final nav = Navigator.of(context);
    final playerBio = ref.read(_bioProvider).playerBio;
    final playerName = playerBio != null
        ? '${playerBio.firstName ?? ''} ${playerBio.lastName ?? ''}'.trim()
        : 'User';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          "Block $playerName's Profile",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: AppColors.socaBlack,
          ),
        ),
        content: Text(
          'You will no longer receive any post or view any comment from the user you are blocking. '
          'People you block can no longer tag you, start a conversation with you, add you in his/her network or see '
          'things you post in the SocaLoca feed. If you follow each other, blocking will automatically unfollow that user.',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            color: AppColors.socaBlack,
            height: 1.5,
          ),
        ),
        actionsPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.socaBlack, width: 1.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    'No'.tr,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.socaBlack,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    'Yes'.tr,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final userId = StorageService.userId;
    if (userId == null) return;
    try {
      final repo = ref.read(playerBioRepositoryProvider);
      await repo.blockUser(userId: userId, toUserId: widget.playerId);
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content:
              Text('User blocked.'.tr, style: TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.green,
        ),
      );
      nav.pop();
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text('Error: $e', style: TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _showReportDialog(BuildContext context) async {
    final causes = [
      'Fake Account',
      'Fake Name',
      'Inappropriate Post',
      'Misguiding Content',
    ];
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        String selectedCause = causes.first;
        return StatefulBuilder(
          builder: (ctx, setSheetState) => Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Report A User',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(ctx),
                      child: Icon(Icons.close,
                          size: 22, color: AppColors.socaBlack),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Bold heading
                Text(
                  'Please select a problem',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
                SizedBox(height: 8),
                // Description
                Text(
                  'If you feel the user post to be inappropriate and can cause harm please report it to SocaLoca. Choose a reason from below.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: AppColors.socaBlack,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 16),
                // Reason chips
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: causes.map((cause) {
                    final isSelected = selectedCause == cause;
                    return GestureDetector(
                      onTap: () => setSheetState(() => selectedCause = cause),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? AppColors.socaBlack : Colors.white,
                          border: Border.all(
                              color: AppColors.socaBlack, width: 1.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          cause,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color:
                                isSelected ? Colors.white : AppColors.socaBlack,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 24),
                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx, selectedCause),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.socaBlack,
                      side: BorderSide(color: AppColors.socaBlack, width: 1.2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                    ),
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (confirmed == null || !mounted) return;
    final userId = StorageService.userId;
    if (userId == null) return;
    try {
      final repo = ref.read(playerBioRepositoryProvider);
      await repo.reportUser(
          userId: userId, toUserId: widget.playerId, cause: confirmed);
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text('Report submitted. Thank you.'.tr,
              style: TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text('Error: $e', style: TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_bioProvider);
    final currentUserId = StorageService.userId;
    final isOwnProfile = currentUserId == widget.playerId;

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: state.isLoading
          ? AppLoader()
          : state.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48,
                        color: AppColors.error,
                      ),
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
                        onPressed: () => ref.read(_bioProvider.notifier).load(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.socaBlack,
                          foregroundColor: AppColors.socaYellow,
                        ),
                        child: Text('Retry'.tr),
                      ),
                    ],
                  ),
                )
              : state.playerBio == null
                  ? Center(
                      child: Text(
                        'Player not found'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          // Header Section
                          PlayerBioHeader(
                            playerBio: state.playerBio!,
                            isOwnProfile: isOwnProfile,
                          ),
                          Divider(height: 1, color: AppColors.socaBlack),

                          // Stats Counters
                          PlayerBioStatsCounters(
                            playerBio: state.playerBio!,
                          ),

                          Divider(height: 1, color: AppColors.socaBlack),

                          // Tab Buttons (Stats, Endorse, Rate)
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // STATS
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlayerStatsScreen(
                                          playerId: widget.playerId,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 90,
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: AppColors.socaBlack,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      'STATS'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.socaBlack,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                // ENDORSE
                                InkWell(
                                  onTap: () {
                                    final playerBio = state.playerBio;
                                    final playerName = playerBio != null
                                        ? '${playerBio.firstName ?? ''} ${playerBio.lastName ?? ''}'
                                            .trim()
                                        : 'Player';
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EndorsePlayerScreen(
                                          playerId: widget.playerId,
                                          playerName: playerName,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 90,
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.socaBlack,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      'ENDORSE'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.socaYellow,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                // RATE
                                if (!isOwnProfile)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => MySkillRatingsScreen(
                                            userId: widget.playerId,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 90,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      decoration: BoxDecoration(
                                        color: AppColors.socaBlack,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        'RATE'.tr,
                                        textAlign: TextAlign.center,
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

                          Divider(height: 1, color: AppColors.socaBlack),

                          // Action Buttons Row
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 0,
                              children: [
                                // Follow Button
                                if (!isOwnProfile)
                                  GestureDetector(
                                    onTap: () => ref
                                        .read(_bioProvider.notifier)
                                        .toggleFollow(),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
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

                                if (!isOwnProfile) SizedBox(width: 10),

                                // Share Button
                                GestureDetector(
                                  onTap: _handleShare,
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        // color: AppColors.socaPageBg,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Image.asset(
                                        "assets/icons/ic_share.png",
                                        width: 24,
                                        height: 24,
                                      )),
                                ),

                                SizedBox(width: 10),

                                // Like Button
                                // if (!isOwnProfile)
                                //   GestureDetector(
                                //     onTap: () => ref
                                //         .read(playerBioProvider(widget.playerId)
                                //             .notifier)
                                //         .toggleLike(),
                                //     child: Container(
                                //       padding: EdgeInsets.all(8),
                                //       decoration: BoxDecoration(
                                //         color: AppColors.socaPageBg,
                                //         borderRadius: BorderRadius.circular(5),
                                //       ),
                                //       child: Icon(
                                //         state.isLiked
                                //             ? Icons.favorite
                                //             : Icons.favorite_border,
                                //         size: 20,
                                //         color: state.isLiked
                                //             ? Colors.red
                                //             : AppColors.socaBlack,
                                //       ),
                                //     ),
                                //   ),

                                // Endorse, Block & Report buttons
                                if (!isOwnProfile) ...[
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(_bioProvider.notifier)
                                          .toggleLike();
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: AppColors.socaPageBg,
                                          border: Border.all(
                                              color: AppColors.socaBlack),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Image.asset(
                                          "assets/icons/ic_like.png",
                                          width: 18,
                                          height: 18,
                                          color: state.isLiked
                                              ? AppColors.socaYellow
                                              : AppColors.socaBlack,
                                        )),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () => _showBlockDialog(context),
                                    child: Image.asset(
                                      "assets/icons/block_user.png",
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                      onTap: () => _showReportDialog(context),
                                      child: Image.asset(
                                        "assets/icons/report_user.png",
                                        width: 32,
                                        height: 32,
                                      )),
                                ],
                              ],
                            ),
                          ),

                          // Main View
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Bio Details Section
                                PlayerBioDetailsSection(
                                  playerBio: state.playerBio!,
                                  isOwnProfile: isOwnProfile,
                                ),

                                SizedBox(height: 20),

                                // Competition Stats Summary
                                CompetitionStatsSummarySection(
                                  footballStats: state.footballStats,
                                  futsalStats: state.futsalStats,
                                  playerBio: state.playerBio!,
                                  isLoadingStats: state.isLoadingStats,
                                ),

                                SizedBox(height: 20),

                                // My Matches (Football & Futsal)
                                MyMatchesSection(
                                  footballMatches: state.footballMatches,
                                  futsalMatches: state.futsalMatches,
                                  playerBio: state.playerBio!,
                                  isOwnProfile: isOwnProfile,
                                  isLoadingMatches: state.isLoadingMatches,
                                ),

                                SizedBox(height: 20),

                                // Training Stats
                                TrainingStatsSection(
                                  trainCurrMonth: state.trainCurrMonth,
                                  trainPrevMonth: state.trainPrevMonth,
                                  isOwnProfile: isOwnProfile,
                                  isLoadingMatches: state.isLoadingMatches,
                                ),

                                SizedBox(height: 20),

                                // Endorsements
                                EndorsementsSection(
                                  endorsements: state.endorsements,
                                  isLoadingEndorsements:
                                      state.isLoadingEndorsements,
                                ),

                                if (state.endorsements.isNotEmpty)
                                  SizedBox(height: 20),

                                // Teams List
                                PlayerTeamsSection(
                                  teams: state.teams,
                                  isLoadingTeams: state.isLoadingTeams,
                                ),

                                if (state.teams.isNotEmpty)
                                  SizedBox(height: 20),

                                // Academies List
                                AcademiesSection(
                                  academies: state.academies,
                                  isLoadingAcademies: state.isLoadingAcademies,
                                ),

                                if (state.academies.isNotEmpty)
                                  SizedBox(height: 20),

                                // Tournaments List
                                TournamentsSection(
                                  tournaments: state.tournaments,
                                  isLoadingTournaments:
                                      state.isLoadingTournaments,
                                ),

                                if (state.tournaments.isNotEmpty)
                                  SizedBox(height: 20),

                                // Skills & Ratings
                                PlayerSkillsSection(
                                  skills: state.skills,
                                  overallRating: state.overallRating,
                                  isLoadingSkills: state.isLoadingSkills,
                                  isOwnProfile: isOwnProfile,
                                ),

                                SizedBox(height: 20),

                                // Top Posts
                                PlayerPostsSection(
                                  posts: state.posts,
                                  isLoadingPosts: state.isLoadingPosts,
                                ),

                                if (state.posts.isNotEmpty)
                                  SizedBox(height: 20),

                                // Tagged Videos
                                TaggedVideosSection(
                                  taggedVideos: state.taggedVideos,
                                  isLoadingTaggedVideos:
                                      state.isLoadingTaggedVideos,
                                ),

                                if (state.taggedVideos.isNotEmpty)
                                  SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
