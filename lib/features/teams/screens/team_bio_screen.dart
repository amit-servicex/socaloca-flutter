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

class TeamBioScreen extends ConsumerWidget {
  final String teamId;

  TeamBioScreen({
    super.key,
    required this.teamId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamBioProvider(teamId));

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: _buildBody(context, ref, state),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, TeamBioState state) {
    if (state.isLoading) {
      return AppLoader();
    }

    if (state.error != null) {
      return _buildErrorState(context, ref, state.error!);
    }

    if (state.teamBio == null) {
      return Center(
        child: Text('No team data available'.tr),
      );
    }

    final teamBio = state.teamBio!;
    final teamDetails = teamBio.teamDetails;

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(teamBioProvider(teamId).notifier).refresh();
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Image
            _buildBannerSection(teamDetails),

            // Team Info Section
            _buildTeamInfoSection(context, ref, teamBio, state),

            SizedBox(height: 8),

            // Players Section
            if (teamBio.players.isNotEmpty)
              _buildPlayersSection(context, teamBio),

            SizedBox(height: 8),

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
      padding: EdgeInsets.fromLTRB(18, 18, 18, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            teamDetails.teamName ?? 'Unknown Team'.tr,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.socaBlack,
            ),
          ),
          SizedBox(height: 12),
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
                      SizedBox(height: 8),
                      _buildTeamActionButton(
                        label: state.isFollowing ? 'FOLLOWING'.tr : 'FOLLOW'.tr,
                        isLoading: state.isFollowLoading,
                        onPressed: state.isFollowLoading
                            ? null
                            : () async {
                                try {
                                  await ref
                                      .read(teamBioProvider(teamId).notifier)
                                      .toggleFollow();
                                } catch (e) {
                                  _showActionError(context, e);
                                }
                              },
                      ),
                    ],
                    SizedBox(height: 4),
                    Text(
                      _followerCountText(state.followCount),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
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
                            padding: EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.socaBlack,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              teamDetails.ageCategory!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.socaYellow,
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                        ],
                        Flexible(
                          child: Text(
                            teamDetails.gameType ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
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
                      SizedBox(height: 3),
                      Text(
                        teamDetails.country!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ],
                    SizedBox(height: 3),
                    Text(
                      '${teamDetails.memberCount} Member${teamDetails.memberCount == 1 ? "" : "s"}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    if (teamDetails.coachName != null &&
                        teamDetails.coachName!.isNotEmpty) ...[
                      SizedBox(height: 3),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: AppColors.socaBlack,
                          ),
                          children: [
                            TextSpan(text: '${'Coach'.tr}  '),
                            TextSpan(
                              text: teamDetails.coachName!,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (state.isArchive) ...[
                      SizedBox(height: 10),
                      Text(
                        'This team is archived'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ] else if (canRequest || state.isPending) ...[
                      SizedBox(height: 12),
                      _buildTeamActionButton(
                        label: state.isPending
                            ? 'REQUEST PENDING'.tr
                            : 'SEND REQUEST'.tr,
                        width: state.isPending ? 132 : 112,
                        isLoading: state.isRequestLoading,
                        onPressed: (!canRequest || state.isRequestLoading)
                            ? null
                            : () async {
                                try {
                                  await ref
                                      .read(teamBioProvider(teamId).notifier)
                                      .requestToJoin();
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Request sent'.tr,
                                          style:
                                              TextStyle(fontFamily: 'Poppins'),
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  _showActionError(context, e);
                                }
                              },
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (teamBio.ratingDetails != null) ...[
            SizedBox(height: 20),
            _buildTeamStats(teamBio.ratingDetails!),
          ],
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
          padding: EdgeInsets.symmetric(horizontal: 8),
          minimumSize: Size(width, 28),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
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
                  style: TextStyle(
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
    final label = count == 1 ? 'Follower'.tr : 'Followers'.tr;
    return '$count $label';
  }

  void _showActionError(BuildContext context, Object error) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error.toString(),
          style: TextStyle(fontFamily: 'Poppins'),
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
                child: AppLoader(),
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
          style: TextStyle(
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
      child: Icon(Icons.emoji_events, size: 36, color: Colors.grey),
    );
  }

  Widget _buildTeamStats(RatingDetailsModel ratingDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (ratingDetails.teamWork > 0)
          _buildStatBar('Team Work', ratingDetails.teamWork.toDouble()),
        if (ratingDetails.technical > 0)
          _buildStatBar('Technical', ratingDetails.technical.toDouble()),
        if (ratingDetails.aggressiveness > 0)
          _buildStatBar(
              'Aggressiveness', ratingDetails.aggressiveness.toDouble()),
        if (ratingDetails.tactical > 0)
          _buildStatBar('Tactical', ratingDetails.tactical.toDouble()),
        if (ratingDetails.overall > 0)
          _buildStatBar('Overall Rating', ratingDetails.overall.toDouble()),
      ],
    );
  }

  Widget _buildStatBar(String label, double value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: value / 5.0,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                minHeight: 3,
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
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Players'.tr,
                style: TextStyle(
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
                        padding: EdgeInsets.only(right: 5),
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
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      'VIEW ALL'.tr,
                      style: TextStyle(
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
          SizedBox(height: 16),
          // Show first 4 players in a horizontal row
        ],
      ),
    );
  }

  Widget _buildRecentMatchesSection(TeamBioModel teamBio) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Matches'.tr,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          if (teamBio.recentMatches.isEmpty)
            Center(
              child: Text(
                'No matches played yet'.tr,
                style: TextStyle(
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
              physics: NeverScrollableScrollPhysics(),
              itemCount: teamBio.recentMatches.length,
              separatorBuilder: (context, index) => SizedBox(height: 12),
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Match details: ${match.matchId}'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(18, 18, 18, 16),
        decoration: BoxDecoration(
          color: Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: Offset(0, 3),
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
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _buildScoreTeam(
                    imageUrl: team1?.teamImage,
                    name: team1?.teamName ?? 'Team 1',
                    alignEnd: false,
                  ),
                ),
                SizedBox(
                  width: 82,
                  child: Text(
                    scoreText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
                    name: team2?.teamName ?? 'Team 2',
                    alignEnd: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              'Full time'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
            if (dateText.isNotEmpty) ...[
              SizedBox(height: 14),
              Text(
                dateText,
                style: TextStyle(
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
        SizedBox(height: 7),
        Text(
          name,
          textAlign: alignEnd ? TextAlign.right : TextAlign.left,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
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
    if (score == null) return 'vs';

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
          child: AppLoader(),
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
        child: AppLoader(),
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
          SizedBox(height: 16),
          Text(
            'Failed to load team bio'.tr,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
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
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ref.read(teamBioProvider(teamId).notifier).refresh();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.socaBlack,
              foregroundColor: AppColors.socaYellow,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text('Retry'.tr),
          ),
        ],
      ),
    );
  }
}
