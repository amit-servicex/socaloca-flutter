import 'package:flutter/material.dart';
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

class _PlayerBioScreenState extends ConsumerState<PlayerBioScreen> {
  @override
  void initState() {
    super.initState();
    // Load player bio data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(playerBioProvider(widget.playerId).notifier).load();
    });
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

  Future<void> _showBlockDialog(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final nav = Navigator.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Block User',
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        content: const Text('Are you sure you want to block this user?',
            style: TextStyle(fontFamily: 'Poppins')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel',
                style: TextStyle(
                    fontFamily: 'Poppins', color: AppColors.socaBlack)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Block',
                style: TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
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
        const SnackBar(
          content:
              Text('User blocked.', style: TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.green,
        ),
      );
      nav.pop();
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content:
              Text('Error: $e', style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _showReportDialog(BuildContext context) async {
    const causes = [
      'Fake Account',
      'Fake Name',
      'Inappropriate Post',
      'Misguiding Content',
    ];
    final messenger = ScaffoldMessenger.of(context);
    String? selectedCause = causes.first;
    final confirmed = await showDialog<String>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Report User',
              style: TextStyle(
                  fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Select a reason:',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 13)),
              const SizedBox(height: 8),
              RadioGroup<String>(
                groupValue: selectedCause,
                onChanged: (v) => setDialogState(() => selectedCause = v),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: causes
                      .map(
                        (cause) => RadioListTile<String>(
                          value: cause,
                          title: Text(cause,
                              style: const TextStyle(
                                  fontFamily: 'Poppins', fontSize: 13)),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel',
                  style: TextStyle(
                      fontFamily: 'Poppins', color: AppColors.socaBlack)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, selectedCause),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaBlack,
                  foregroundColor: AppColors.socaYellow),
              child: const Text('Report',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
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
        const SnackBar(
          content: Text('Report submitted. Thank you.',
              style: TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content:
              Text('Error: $e', style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ),
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
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          // Header Section
                          PlayerBioHeader(
                            playerBio: state.playerBio!,
                            isOwnProfile: isOwnProfile,
                          ),
                          const Divider(height: 1, color: AppColors.socaBlack),

                          // Stats Counters
                          PlayerBioStatsCounters(
                            playerBio: state.playerBio!,
                          ),

                          const Divider(height: 1, color: AppColors.socaBlack),

                          // Tab Buttons (Stats, Endorse, Rate)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: AppColors.socaBlack,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      'STATS',
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
                                const SizedBox(width: 8),
                                // ENDORSE
                                Container(
                                  width: 90,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppColors.socaBlack,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Text(
                                    'ENDORSE',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.socaYellow,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // RATE
                                if (!isOwnProfile)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              MySkillRatingsScreen(
                                            userId: widget.playerId,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 90,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppColors.socaBlack,
                                            width: 1.5),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Text(
                                        'RATE',
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
                              ],
                            ),
                          ),

                          const Divider(height: 1, color: AppColors.socaBlack),

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
                                          .read(
                                              playerBioProvider(widget.playerId)
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                      color: AppColors.socaPageBg,
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
                                        color: AppColors.socaPageBg,
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

                                // Endorse, Block & Report buttons
                                if (!isOwnProfile) ...[
                                  const SizedBox(width: 10),
                                  GestureDetector(
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
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.socaPageBg,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Icon(
                                        Icons.thumb_up_alt_outlined,
                                        size: 20,
                                        color: AppColors.socaBlack,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () => _showBlockDialog(context),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.socaPageBg,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Icon(
                                        Icons.person_off_outlined,
                                        size: 20,
                                        color: AppColors.socaBlack,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () => _showReportDialog(context),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.socaPageBg,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Icon(
                                        Icons.assignment_ind_outlined,
                                        size: 20,
                                        color: AppColors.socaBlack,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          // Main View
                          Padding(
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
                                  isLoadingAcademies: state.isLoadingAcademies,
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
    );
  }
}
