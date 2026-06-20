import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:socaloca/features/teams/data/models/team_match_model.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/team_bio_model.dart';
import '../providers/team_bio_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class TeamBioScreen extends ConsumerStatefulWidget {
  final String teamId;

  const TeamBioScreen({
    super.key,
    required this.teamId,
  });

  @override
  ConsumerState<TeamBioScreen> createState() => _TeamBioScreenState();
}

class _TeamBioScreenState extends ConsumerState<TeamBioScreen> {
  String get teamId => widget.teamId;

  // ── Visibility helpers ────────────────────────────────────────────────────

  /// Android rule: editManageBox visible when isAdmin == true.
  bool _canEditManage(TeamBioState state) => state.isAdmin;

  /// Android rule: delete visible when isAdmin == true AND
  /// currentUserId == team.createdBy (only creator can delete).
  bool _canDelete(TeamBioState state) {
    // return true;
    final uid = StorageService.userId;
    return state.isAdmin &&
        uid != null &&
        uid.isNotEmpty &&
        state.createdBy != null &&
        uid == state.createdBy;
  }

  // ── Delete flow ───────────────────────────────────────────────────────────

  Future<void> _onDeleteTap(TeamBioState state) async {
    final confirmed = await _showDeleteConfirmation();
    if (!confirmed || !mounted) return;

    try {
      await ref.read(teamBioProvider(teamId).notifier).deleteTeam();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Team Deleted Successfully.',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Mirrors Android's `team_delete_popup.xml` confirmation dialog.
  Future<bool> _showDeleteConfirmation() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: const Text(
          'Are you sure to\ndelete this team?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.socaBlack,
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          Row(spacing: 20, children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.socaBlack,
                  side: const BorderSide(color: AppColors.socaBlack),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                ),
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text(
                  'YES',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                ),
              ),
            ),
            // NO — black filled / yellow text (Android negative button style)
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaBlack,
                  foregroundColor: AppColors.socaYellow,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                ),
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text(
                  'NO',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ])
          // YES — white/outlined (Android positive button style)
        ],
      ),
    );
    return result ?? false;
  }

  // ── Edit / Manage placeholders ────────────────────────────────────────────

  void _onEditTap() {
    final details = ref.read(teamBioProvider(teamId)).teamBio?.teamDetails;
    if (details == null) return;
    context
        .pushNamed(
      'editTeam',
      pathParameters: {'teamId': teamId},
      extra: details,
    )
        .then((_) {
      // Refresh bio after returning — user may have saved changes.
      ref.read(teamBioProvider(teamId).notifier).refresh();
    });
  }

  void _onManageTap() {
    final details = ref.read(teamBioProvider(teamId)).teamBio?.teamDetails;
    if (details == null) return;
    context.pushNamed(
      'manageTeam',
      pathParameters: {'teamId': teamId},
      extra: details,
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teamBioProvider(teamId));

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      // appBar: AppBar(
      //   backgroundColor: AppColors.socaBlack,
      //   foregroundColor: AppColors.socaYellow,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () => Navigator.of(context).maybePop(),
      //   ),
      //   actions: [
      //     if (_canDelete(state))
      //       state.isDeleteLoading
      //           ? const Padding(
      //               padding: EdgeInsets.all(14),
      //               child: SizedBox(
      //                 width: 20,
      //                 height: 20,
      //                 child: CircularProgressIndicator(
      //                   strokeWidth: 2,
      //                   color: AppColors.socaYellow,
      //                 ),
      //               ),
      //             )
      //           : IconButton(
      //               icon: const Icon(Icons.delete_outline),
      //               tooltip: 'Delete team',
      //               onPressed: () => _onDeleteTap(state),
      //             ),
      //   ],
      // ),

      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, TeamBioState state) {
    if (state.isLoading) {
      return const AppLoader();
    }

    if (state.error != null) {
      return _buildErrorState(context, ref, state.error!);
    }

    if (state.teamBio == null) {
      return Center(
        child: Text(AppStrings.noTeamDataAvailable),
      );
    }

    final teamBio = state.teamBio!;
    final teamDetails = teamBio.teamDetails;

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(teamBioProvider(teamId).notifier).refresh();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Image
            _buildBannerSection(teamDetails),

            // Team Info Section
            _buildTeamInfoSection(context, ref, teamBio, state),

            const SizedBox(height: 8),

            // Players Section
            if (teamBio.players.isNotEmpty)
              _buildPlayersSection(context, teamBio),

            const SizedBox(height: 8),

            // Recent Matches Section
            _buildRecentMatchesSection(teamBio),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerSection(TeamDetailsModel teamDetails) {
    return SizedBox(
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
              child: Image.asset("assets/images/tournament_defalut_banner.jpg",
                  fit: BoxFit.cover)),
        ],
      ),
    );
  }

  Widget _buildTeamInfoSection(
    BuildContext context,
    WidgetRef ref,
    TeamBioModel teamBio,
    TeamBioState state,
  ) {
    final teamDetails = teamBio.teamDetails;
    final currentUserId = StorageService.userId;
    final isCreator = currentUserId != null &&
        state.createdBy != null &&
        currentUserId == state.createdBy;
    final canFollow = !state.isArchive && !isCreator;
    final canRequest = !state.isArchive &&
        !state.isMember &&
        !state.isPending &&
        !state.joinRequest;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            teamDetails.teamName ?? AppStrings.unknownTeam,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.socaBlack,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 84,
                child: Column(
                  children: [
                    _buildTeamLogo(
                      teamDetails.teamImage,
                      shortName: teamDetails.teamShortName,
                    ),
                    if (canFollow) ...[
                      const SizedBox(height: 8),
                      _buildTeamActionButton(
                        label: state.isFollowing
                            ? AppStrings.following.toUpperCase()
                            : AppStrings.follow.toUpperCase(),
                        isLoading: state.isFollowLoading,
                        onPressed: state.isFollowLoading
                            ? null
                            : () async {
                                try {
                                  await ref
                                      .read(teamBioProvider(teamId).notifier)
                                      .toggleFollow();
                                } catch (e) {
                                  if (mounted) {
                                    _showActionError(this.context, e);
                                  }
                                }
                              },
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      _followerCountText(state.followCount),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (teamDetails.ageCategory != null &&
                            teamDetails.ageCategory!.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.socaBlack,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              teamDetails.ageCategory!,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.socaYellow,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Flexible(
                          child: Text(
                            teamDetails.gameType ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (teamDetails.country != null &&
                        teamDetails.country!.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        teamDetails.country!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ],
                    const SizedBox(height: 3),
                    Text(
                      '${teamDetails.memberCount} Member${teamDetails.memberCount == 1 ? "" : "s"}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    if (teamDetails.coachName != null &&
                        teamDetails.coachName!.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: AppColors.socaBlack,
                          ),
                          children: [
                            TextSpan(text: '${AppStrings.coach}  '),
                            TextSpan(
                              text: teamDetails.coachName!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (state.isArchive) ...[
                      const SizedBox(height: 10),
                      Text(
                        AppStrings.thisTeamIsArchived,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ] else if (canRequest || state.isPending) ...[
                      const SizedBox(height: 12),
                      _buildTeamActionButton(
                        label: state.isPending
                            ? AppStrings.requestPendingUpper
                            : AppStrings.sendRequestUpper,
                        width: state.isPending ? 132 : 112,
                        isLoading: state.isRequestLoading,
                        onPressed: (!canRequest || state.isRequestLoading)
                            ? null
                            : () async {
                                final messenger = ScaffoldMessenger.of(context);
                                try {
                                  await ref
                                      .read(teamBioProvider(teamId).notifier)
                                      .requestToJoin();
                                  if (mounted) {
                                    messenger.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          AppStrings.requestSent,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins'),
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  if (mounted) {
                                    _showActionError(this.context, e);
                                  }
                                }
                              },
                      ),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (_canEditManage(state)) ...[
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              OutlinedButton(
                                onPressed: _onEditTap,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.socaBlack,
                                  side: const BorderSide(
                                      color: AppColors.socaBlack),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 6),
                                  minimumSize: const Size(70, 30),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'EDIT',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: _onManageTap,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.socaBlack,
                                  foregroundColor: AppColors.socaYellow,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 6),
                                  minimumSize: const Size(80, 30),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'MANAGE',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (_canDelete(state))
                          state.isDeleteLoading
                              ? const Padding(
                                  padding: EdgeInsets.all(14),
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.socaYellow,
                                    ),
                                  ),
                                )
                              : IconButton(
                                  icon: Image.asset("assets/icons/ic_trash.png",
                                      width: 24,
                                      height: 24,
                                      color: AppColors.socaBlack),
                                  tooltip: 'Delete team',
                                  onPressed: () => _onDeleteTap(state),
                                ),
                      ],
                    )
                    // Edit / Manage — visible to team admins (Android: editManageBox)
                  ],
                ),
              ),
            ],
          ),
          // if (teamBio.ratingDetails != null) ...[
          const SizedBox(height: 20),
          _buildTeamStats(teamBio.ratingDetails ?? const RatingDetailsModel()),
          // ],
        ],
      ),
    );
  }

  Widget _buildTeamActionButton({
    required String label,
    required bool isLoading,
    required VoidCallback? onPressed,
    double width = 78,
  }) {
    return SizedBox(
      width: width,
      height: 28,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.socaBlack,
          disabledBackgroundColor: AppColors.socaBlack,
          foregroundColor: AppColors.socaYellow,
          disabledForegroundColor: AppColors.socaYellow,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          minimumSize: Size(width, 28),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.socaYellow,
                  ),
                ),
              )
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  maxLines: 1,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
      ),
    );
  }

  String _followerCountText(int count) {
    return AppStrings.followersCount(count);
  }

  void _showActionError(BuildContext context, Object error) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error.toString(),
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget _buildTeamLogo(String? imageUrl, {String? shortName}) {
    final fullImageUrl = (imageUrl != null && imageUrl.isNotEmpty)
        ? ApiConstants.getImageUrl(imageUrl)
        : '';

    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      clipBehavior: Clip.antiAlias,
      child: fullImageUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: fullImageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                color: Colors.grey[200],
                child: const AppLoader(),
              ),
              errorWidget: (_, __, ___) => _buildDefaultLogo(shortName),
            )
          : _buildDefaultLogo(shortName),
    );
  }

  Widget _buildDefaultLogo([String? shortName]) {
    final initials = shortName?.trim();
    if (initials != null && initials.isNotEmpty) {
      return Container(
        color: AppColors.socaBlack,
        alignment: Alignment.center,
        child: Text(
          initials,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.socaYellow,
          ),
        ),
      );
    }

    return Container(
      color: Colors.grey[200],
      child: const Icon(Icons.emoji_events, size: 36, color: Colors.grey),
    );
  }

  Widget _buildTeamStats(RatingDetailsModel ratingDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (ratingDetails.teamWork > 0)
        _buildStatBar(AppStrings.teamWork, ratingDetails.teamWork.toDouble()),
        // if (ratingDetails.technical > 0)
        _buildStatBar(AppStrings.technical, ratingDetails.technical.toDouble()),
        // if (ratingDetails.aggressiveness > 0)
        _buildStatBar(
            AppStrings.aggressiveness, ratingDetails.aggressiveness.toDouble()),
        // if (ratingDetails.tactical > 0)
        _buildStatBar(AppStrings.tactical, ratingDetails.tactical.toDouble()),
        // if (ratingDetails.overall > 0)
        _buildStatBar(
            AppStrings.overallRating, ratingDetails.overall.toDouble()),
      ],
    );
  }

  Widget _buildStatBar(String label, double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: value / 5.0,
                backgroundColor: Colors.grey[300],
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.socaGrey),
                minHeight: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayersSection(BuildContext context, TeamBioModel teamBio) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppStrings.players,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        teamBio.players.length > 4 ? 4 : teamBio.players.length,
                    itemBuilder: (context, index) {
                      final player = teamBio.players[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.socaBlack),
                              ),
                              child: ClipOval(
                                child:
                                    _buildPlayerAvatar(player.profileImage, 35),
                              ),
                            ),
                            // SizedBox(height: 4),
                            // Text(
                            //   player.firstName ?? '',
                            //   style: TextStyle(
                            //     fontFamily: 'Poppins',
                            //     fontSize: 10,
                            //     color: Colors.black87,
                            //   ),
                            //   maxLines: 1,
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                child: SizedBox(
                  width: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/teams/$teamId/players');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socaBlack,
                      foregroundColor: AppColors.socaYellow,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      AppStrings.viewAll.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Show first 4 players in a horizontal row
        ],
      ),
    );
  }

  Widget _buildRecentMatchesSection(TeamBioModel teamBio) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.recentMatches,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          if (teamBio.recentMatches.isEmpty)
            Center(
              child: Text(
                AppStrings.noMatchesPlayedYet,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: teamBio.recentMatches.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final match = teamBio.recentMatches[index];
                return _buildMatchCard(context, match);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(BuildContext context, TeamMatchModel match) {
    final team1 = match.teams.isNotEmpty ? match.teams[0] : null;
    final team2 = match.teams.length > 1 ? match.teams[1] : null;
    final scoreText = _matchScoreText(match);
    final title = _matchVenueTitle(match);
    final dateText = _formatMatchDate(match.matchDate);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        // Navigate to match details if matchId is available
        if (match.matchId != null && match.matchId!.isNotEmpty) {
          // TODO: Navigate to match details screen
          // context.push('/matches/${match.matchId}');
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Match details: ${match.matchId}'),
          //     duration: Duration(seconds: 2),
          //   ),
          // );
        }
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title.isNotEmpty) ...[
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _buildScoreTeam(
                    imageUrl: team1?.teamImage,
                    name: team1?.teamName ?? AppStrings.teamOne,
                    alignEnd: false,
                  ),
                ),
                SizedBox(
                  width: 82,
                  child: Text(
                    scoreText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 31,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      height: 1.0,
                    ),
                  ),
                ),
                Expanded(
                  child: _buildScoreTeam(
                    imageUrl: team2?.teamImage,
                    name: team2?.teamName ?? AppStrings.teamTwo,
                    alignEnd: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              AppStrings.fullTime,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
            if (dateText.isNotEmpty) ...[
              const SizedBox(height: 14),
              Text(
                dateText,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildScoreTeam({
    required String? imageUrl,
    required String name,
    required bool alignEnd,
  }) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Align(
          alignment: alignEnd ? Alignment.centerRight : Alignment.centerLeft,
          child: _buildTeamMatchLogo(imageUrl, 40),
        ),
        const SizedBox(height: 7),
        Text(
          name,
          textAlign: alignEnd ? TextAlign.right : TextAlign.left,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            height: 1.1,
          ),
        ),
      ],
    );
  }

  String _matchScoreText(TeamMatchModel match) {
    final score = match.score;
    if (score == null) return AppStrings.vsLower;

    final myTeamIsFirst = match.myTeamId != null &&
        match.teams.isNotEmpty &&
        match.teams.first.teamId == match.myTeamId;
    final firstGoals = myTeamIsFirst ? score.myGoals : score.opponentGoals;
    final secondGoals = myTeamIsFirst ? score.opponentGoals : score.myGoals;
    return '$firstGoals : $secondGoals';
  }

  String _matchVenueTitle(TeamMatchModel match) {
    final candidates = [
      match.stadiumName,
      match.fieldName,
      match.locationName,
      match.matchName,
    ];
    for (final value in candidates) {
      final text = value?.trim();
      if (text != null && text.isNotEmpty) return text;
    }
    return '';
  }

  String _formatMatchDate(String? value) {
    if (value == null || value.trim().isEmpty) return '';
    final raw = value.trim();
    for (final pattern in ['dd-MM-yyyy', 'yyyy-MM-dd', 'MM-dd-yyyy']) {
      try {
        final date = DateFormat(pattern).parseStrict(raw);
        return DateFormat('MMM d, yyyy').format(date);
      } catch (_) {
        // Try the next known API date format.
      }
    }
    return raw;
  }

  Widget _buildTeamMatchLogo(String? imageUrl, double size) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.emoji_events,
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
          Icons.emoji_events,
          size: size * 0.5,
          color: Colors.grey,
        ),
      );
    }

    return ClipOval(
      child: CachedNetworkImage(
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
            Icons.emoji_events,
            size: size * 0.5,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerAvatar(String? imageUrl, double size) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.socaBlack),
          ),
          child: Image.asset("assets/images/avatar1.png"));
    }

    final fullImageUrl = ApiConstants.getImageUrl(imageUrl);

    if (fullImageUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.socaBlack),
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
          border: Border.all(color: AppColors.socaBlack),
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
            AppStrings.failedToLoadTeamBio,
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
              ref.read(teamBioProvider(teamId).notifier).refresh();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.socaBlack,
              foregroundColor: AppColors.socaYellow,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }
}
