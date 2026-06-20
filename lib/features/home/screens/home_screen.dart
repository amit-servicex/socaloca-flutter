import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/features/home/widgets/most_followed_teams_section.dart';
import 'package:socaloca/shared/providers/auth_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../social_feed/models/feed_post.dart';
import '../../social_feed/providers/feed_providers.dart';
import '../../social_feed/widgets/feed_post_card.dart';
import '../data/models/match_update_model.dart';
import '../providers/home_feed_providers.dart';
import '../providers/home_providers.dart';
import '../widgets/feedback_banner.dart';
import '../widgets/language_selection_bottom_sheet.dart';
import '../widgets/live_match_banner.dart';
import '../widgets/live_tournaments_section.dart';
import '../widgets/most_endorsed_section.dart';
import '../widgets/new_teams_section.dart';
import '../widgets/recommended_users_section.dart';

/// Home screen matching Android CommonHomeActivity.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final PageController _matchUpdatesPageController =
      PageController(viewportFraction: 1);
  bool _showFeedbackBanner = false;
  bool _priorityHomeFeedsLoaded = false;
  Timer? _matchUpdatesTimer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Initialize providers in correct sequence
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeHomeScreen();
    });
    _startMatchUpdatesAutoSlide();
  }

  /// Initialize home screen following Android's API call sequence
  Future<void> _initializeHomeScreen() async {
    // 1. Load priority home feed sections first.
    await Future.wait([
      ref.read(feedNewTeamsProvider.notifier).refresh(),
      ref.read(mostEndorsedProvider.notifier).refresh(),
    ]);
    if (!mounted) return;

    // 2. Get blocked users.
    ref.read(blockedUsersProvider);

    // 3. Get user profile details (must load before feed)
    await ref.read(userProfileDetailsProvider.future);

    // 4. Get match updates (for Player/Coach/Manager/Admin only)
    final user = ref.read(currentUserProvider);
    if (user != null && !user.isFan) {
      ref.read(matchUpdatesProvider);
    }

    // 5. Check language selection
    _checkAndShowLanguageSelection();

    // 6. Check feedback visibility
    _checkFeedbackVisibility();

    if (!mounted) return;
    setState(() => _priorityHomeFeedsLoaded = true);

    // Feed providers will auto-load via their constructors
  }

  void _startMatchUpdatesAutoSlide() {
    _matchUpdatesTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_matchUpdatesPageController.hasClients) {
        final matches = ref.read(matchUpdatesProvider).valueOrNull;
        if (matches == null || matches.isEmpty) return;

        int nextPage = _matchUpdatesPageController.page!.round() + 1;
        if (nextPage >= matches.length) {
          nextPage = 0; // Wrap around to the beginning
        }
        _matchUpdatesPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _matchUpdatesTimer?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _matchUpdatesPageController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 300) {
      ref.read(feedProvider.notifier).loadMore();
    }
  }

  Future<void> _checkFeedbackVisibility() async {
    final lastStr = StorageService.getString('lastFeedbackDate');
    final lastFeedback = lastStr != null ? DateTime.tryParse(lastStr) : null;
    final daysSince =
        DateTime.now().difference(lastFeedback ?? DateTime(2000)).inDays;
    if (daysSince > 30 && mounted) {
      setState(() => _showFeedbackBanner = true);
    }
  }

  Future<void> _checkAndShowLanguageSelection() async {
    final languageSelected = StorageService.languageSelected;

    if (!languageSelected && mounted) {
      await showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => LanguageSelectionBottomSheet(
          onLanguageSelected: (code, name) async {
            await StorageService.setLanguageCode(code);
            await StorageService.setLanguageName(name);
            await StorageService.setLanguageSelected();
            if (mounted) setState(() {});
          },
        ),
      );
    }
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.socaBlack,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 8,
            fontWeight: FontWeight.w400,
            color: AppColors.socaBlack,
          ),
        ),
      ],
    );
  }

  Widget _buildActionItem(Image icon, String label) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.socaBlack,
          ),
        ),
      ],
    );
  }

  Widget _buildMatchUpdatesSection(List<MatchUpdateModel> matches) {
    if (matches.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section header ─────────────────────────────────────────────
        Container(
          width: double.infinity,
          color: AppColors.socaBlack,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            AppStrings.matchUpdates,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.socaYellow,
            ),
          ),
        ),

        SizedBox(
          height: 236,
          child: PageView.builder(
            controller: _matchUpdatesPageController,
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final item = matches[index];
              final tournamentName = item.tournamentName.isNotEmpty
                  ? item.tournamentName
                  : '${item.homeTeamName} vs ${item.awayTeamName}';
              final homeName =
                  item.homeTeamName.isNotEmpty ? item.homeTeamName : 'Home';
              final awayName =
                  item.awayTeamName.isNotEmpty ? item.awayTeamName : 'Away';
              final homeLogo = item.homeTeamLogo;
              final awayLogo = item.awayTeamLogo;
              final scoreText = '${item.myGoals} : ${item.opponentGoals}';
              final venue = item.matchInfo?.stadiumName.isNotEmpty == true
                  ? item.matchInfo!.stadiumName
                  : item.matchInfo?.locationName ?? '';

              String dateText = '';
              String timeText = '';
              if (item.matchInfo?.matchDateTimeGmt != null) {
                final dt = DateTime.fromMillisecondsSinceEpoch(
                        item.matchInfo!.matchDateTimeGmt!)
                    .toLocal();
                final months = [
                  'Jan',
                  'Feb',
                  'Mar',
                  'Apr',
                  'May',
                  'Jun',
                  'Jul',
                  'Aug',
                  'Sep',
                  'Oct',
                  'Nov',
                  'Dec',
                ];
                dateText =
                    '${months[dt.month - 1]} ${dt.day.toString().padLeft(2, '0')}';
                final hour = dt.hour == 0 || dt.hour == 12 ? 12 : dt.hour % 12;
                final minute = dt.minute.toString().padLeft(2, '0');
                final period = dt.hour >= 12 ? 'PM' : 'AM';
                timeText = '$hour:$minute $period';
              }

              final isFirst = index == 0;
              final isLast = index == matches.length - 1;

              return Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Tournament logo + name row ──────────────────
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.socaBlack.withOpacity(0.45),
                            width: 0.8,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (item.tournamentLogo.isNotEmpty)
                            ClipOval(
                              child: Image.network(
                                ApiConstants.getImageUrl(item.tournamentLogo),
                                width: 18,
                                height: 18,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.emoji_events,
                                  size: 18,
                                  color: AppColors.socaYellow,
                                ),
                              ),
                            )
                          else
                            const Icon(
                              Icons.emoji_events,
                              size: 18,
                              color: AppColors.socaYellow,
                            ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              tournamentName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.socaBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 14, 0, 12),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 38,
                                  child: Center(
                                    child: Text(
                                      venue,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 13,
                                        height: 1.15,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.socaBlack,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: _buildMatchUpdateTeam(
                                          logoUrl: homeLogo,
                                          name: homeName,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 96,
                                        child: Column(
                                          children: [
                                            Text(
                                              scoreText,
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 34,
                                                height: 1,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 9),
                                            if (dateText.isNotEmpty) ...[
                                              Text(
                                                dateText,
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  height: 1,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.socaBlack,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                timeText,
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  height: 1,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.socaBlack,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: _buildMatchUpdateTeam(
                                          logoUrl: awayLogo,
                                          name: awayName,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                SizedBox(
                                  width: 112,
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      final tournamentId =
                                          item.tmntInfo?.tournamentId ?? '';
                                      if (tournamentId.isNotEmpty) {
                                        context
                                            .push('/tournaments/$tournamentId');
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.socaBlack,
                                      foregroundColor: AppColors.socaYellow,
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      AppStrings.viewDetails.toUpperCase(),
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.socaYellow,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              left: -2,
                              top: 76,
                              child: GestureDetector(
                                onTap: isFirst
                                    ? null
                                    : () => _matchUpdatesPageController
                                            .previousPage(
                                          duration:
                                              const Duration(milliseconds: 350),
                                          curve: Curves.easeInOut,
                                        ),
                                child: Icon(
                                  Icons.chevron_left,
                                  size: 44,
                                  color: isFirst
                                      ? AppColors.socaBlack.withOpacity(0.45)
                                      : AppColors.socaBlack.withOpacity(0.62),
                                ),
                              ),
                            ),
                            Positioned(
                              right: -2,
                              top: 76,
                              child: GestureDetector(
                                onTap: isLast
                                    ? null
                                    : () =>
                                        _matchUpdatesPageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 350),
                                          curve: Curves.easeInOut,
                                        ),
                                child: Icon(
                                  Icons.chevron_right,
                                  size: 44,
                                  color: isLast
                                      ? AppColors.socaBlack.withOpacity(0.45)
                                      : AppColors.socaBlack.withOpacity(0.62),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMatchUpdateTeamLogo(String logoUrl) {
    if (logoUrl.isEmpty) {
      return Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: AppColors.border,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.sports_soccer, color: AppColors.textSecondary),
      );
    }
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border),
      ),
      child: ClipOval(
        child: Image.network(
          ApiConstants.getImageUrl(logoUrl),
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: AppColors.border,
            child:
                const Icon(Icons.sports_soccer, color: AppColors.textSecondary),
          ),
        ),
      ),
    );
  }

  Widget _buildMatchUpdateTeam({
    required String logoUrl,
    required String name,
  }) {
    return Column(
      children: [
        _buildMatchUpdateTeamLogo(logoUrl),
        const SizedBox(height: 8),
        Text(
          name.toUpperCase(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            height: 1.15,
            fontWeight: FontWeight.w400,
            color: AppColors.socaBlack,
          ),
        ),
      ],
    );
  }

  /// Mirrors Android's customizedAdd() in FanHomeFeedFragment / CommonHomeFeedFragment.
  ///
  /// Loops over the original post list and, at every position divisible by 5,
  /// inserts a section widget at that exact index in a growing working list —
  /// exactly as ArrayList.add(pos, item) does in the Java source.
  ///
  /// Section rotation (Android initial currentType = TYPE_INSERT_TEAM = 1):
  ///   injection #0 → pos 0  → NewTeamsSection        (type 1)
  ///   injection #1 → pos 5  → RecommendedUsersSection (type 2)
  ///   injection #2 → pos 10 → LiveTournamentsSection  (type 0, after reset)
  ///   injection #3 → pos 15 → NewTeamsSection         (cycles)
  List<Widget> _buildInjectedFeedList(List<FeedPost> posts) {
    final List<Widget> workingList =
        posts.map<Widget>((p) => FeedPostCard(post: p)).toList();

    const int typeInsertTournaments = 0;
    const int typeInsertTeam = 1;
    const int typeInsertUser = 2;

    int currentType = typeInsertTeam; // matches Android's initial value
    final int originalLen = posts.length;

    for (int pos = 0; pos < originalLen; pos++) {
      if (pos % 5 == 0) {
        // Reset check happens before the switch — matches Android logic
        if (currentType >= 3) currentType = typeInsertTournaments;

        final Widget section;
        switch (currentType) {
          case typeInsertTournaments:
            section = const LiveTournamentsSection();
            break;
          case typeInsertTeam:
            section = const NewTeamsSection();
            break;
          case typeInsertUser:
            section = const RecommendedUsersSection();
            break;
          default:
            section = const SizedBox.shrink();
        }

        // Insert at literal index `pos` in the growing list, exactly as
        // tempFeeds.add(pos, item) in Android.
        workingList.insert(pos, section);
        currentType++;
      }
    }

    return workingList;
  }

  @override
  Widget build(BuildContext context) {
    final userId = StorageService.userId ?? '';
    ref.watch(localeProvider);
    final cachedUser = ref.watch(currentUserProvider);

    // Use the freshly fetched user details if available, otherwise fallback to the cached login user
    var user = cachedUser;
    final profileData = _priorityHomeFeedsLoaded
        ? ref.watch(userProfileDetailsProvider).valueOrNull
        : null;
    if (profileData != null) {
      if (profileData.runtimeType.toString() == 'UserModel') {
        user = profileData as dynamic;
      } else {
        final userDetails =
            profileData['response']?['userDetails'] ?? profileData;
        if (userDetails is Map<String, dynamic>) {
          try {
            user = (cachedUser as dynamic).copyWith(
              firstName:
                  userDetails['firstName'] ?? (cachedUser as dynamic).firstName,
              lastName:
                  userDetails['lastName'] ?? (cachedUser as dynamic).lastName,
              postCount: userDetails['postCount'],
              likeCount: userDetails['likeCount'],
              followersCount: userDetails['followCount'],
              followingCount: userDetails['followingCount'],
              profileImage: userDetails['imageUrl'] ??
                  (cachedUser as dynamic).profileImage,
            );
          } catch (_) {}
        }
      }
    }

    final matchUpdates = _priorityHomeFeedsLoaded
        ? ref.watch(matchUpdatesProvider)
        : const AsyncValue<List<MatchUpdateModel>>.loading();
    final feedState = _priorityHomeFeedsLoaded
        ? ref.watch(feedProvider)
        : const AsyncValue<FeedState>.loading();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.socaPageBg,
      body: Column(
        children: [
          // Debug info - remove after testing
          if (userId.isEmpty)
            Container(
              color: Colors.red.shade100,
              padding: const EdgeInsets.all(8),
              child: Text(
                '⚠️ Not logged in - Home feed sections will be empty'.tr,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.wait([
                  ref.read(feedNewTeamsProvider.notifier).refresh(),
                  ref.read(mostEndorsedProvider.notifier).refresh(),
                ]);
                await Future.wait([
                  ref.read(userProfileDetailsProvider.future),
                  if (user != null && !user.isFan)
                    ref.read(matchUpdatesProvider.future),
                  ref.read(feedLiveTmntsProvider.notifier).refresh(),
                  ref.read(feedRecUsersProvider.notifier).refresh(),
                  ref.read(feedTeamsProvider.notifier).refresh(),
                  ref.read(feedProvider.notifier).refresh(),
                ]);
              },
              child: CustomScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    floating: true,
                    snap: true,
                    pinned: true,
                    surfaceTintColor: AppColors.socaBlack,
                    expandedHeight: user?.isFan == true ? 110 : 160,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 45, 16, 0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(AppStrings.hello,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14)),
                                    Text(user?.firstName ?? 'User!',
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                                if (user?.isFan == false)
                                  Row(
                                    children: [
                                      _buildStatColumn(
                                          (user?.postCount ?? 0).toString(),
                                          AppStrings.posts.toUpperCase()),
                                      const SizedBox(width: 8),
                                      _buildStatColumn(
                                          (user?.likeCount ?? 0).toString(),
                                          AppStrings.cheers),
                                      const SizedBox(width: 8),
                                      _buildStatColumn(
                                          (user?.followersCount ?? 0)
                                              .toString(),
                                          AppStrings.followers.toUpperCase()),
                                      const SizedBox(width: 8),
                                      _buildStatColumn(
                                          (user?.followingCount ?? 0)
                                              .toString(),
                                          AppStrings.following.toUpperCase()),
                                    ],
                                  ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      AppColors.socaGrey.withOpacity(0.2),
                                  backgroundImage: user?.profileImage != null &&
                                          user!.profileImage!.isNotEmpty &&
                                          !user.profileImage!
                                              .startsWith('file:///')
                                      ? NetworkImage(ApiConstants.getImageUrl(
                                          user.profileImage!))
                                      : null,
                                  child: user?.profileImage == null ||
                                          user!.profileImage!.isEmpty ||
                                          user.profileImage!
                                              .startsWith('file:///')
                                      ? Image.asset("assets/images/avatar1.png")
                                      : null,
                                ),
                              ],
                            ),
                            if (user?.isFan == false) ...[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    top:
                                        BorderSide(color: Colors.grey.shade300),
                                    bottom:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          context.push(AppRoutes.myBio),
                                      child: _buildActionItem(
                                          Image.asset(
                                              "assets/icons/ic_my_bio.png",
                                              width: 20,
                                              height: 20),
                                          AppStrings.myBio),
                                    ),
                                    Container(
                                        width: 1,
                                        height: 20,
                                        color: Colors.grey.shade300),
                                    InkWell(
                                      onTap: () => context.push(
                                        AppRoutes.myPosts,
                                        extra: {
                                          'userId': userId,
                                          'isOwnProfile': true,
                                        },
                                      ),
                                      child: _buildActionItem(
                                          Image.asset(
                                            "assets/icons/ic_my_post_feed.png",
                                            width: 20,
                                            height: 20,
                                          ),
                                          AppStrings.myPosts),
                                    ),
                                    Container(
                                        width: 1,
                                        height: 20,
                                        color: Colors.grey.shade300),
                                    InkWell(
                                      onTap: () => context.push(
                                        AppRoutes.mySkillRatings,
                                        extra: {'userId': userId},
                                      ),
                                      child: _buildActionItem(
                                          Image.asset(
                                              "assets/icons/ic_endorsements_bottom_black.png",
                                              width: 20,
                                              height: 20),
                                          AppStrings.myRatings),
                                    ),
                                    Container(
                                        width: 1,
                                        height: 20,
                                        color: Colors.grey.shade300),
                                    InkWell(
                                      onTap: () => context.push(
                                        AppRoutes.gallery,
                                        extra: {
                                          'userId': userId,
                                          'isOwnProfile': true,
                                        },
                                      ),
                                      child: _buildActionItem(
                                          Image.asset(
                                              "assets/icons/ic_gallery.png",
                                              width: 20,
                                              height: 20),
                                          AppStrings.gallery),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                    // bottom: PreferredSize(
                    //   preferredSize: Size.fromHeight(50),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       border: Border(
                    //         top: BorderSide(color: Colors.grey.shade300),
                    //         bottom: BorderSide(color: Colors.grey.shade300),
                    //       ),
                    //     ),
                    //     padding: EdgeInsets.symmetric(vertical: 12),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         _buildActionItem(Icons.edit_document, 'My Bio'),
                    //         Container(
                    //             width: 1,
                    //             height: 20,
                    //             color: Colors.grey.shade300),
                    //         _buildActionItem(Icons.image_outlined, 'My Posts'),
                    //         Container(
                    //             width: 1,
                    //             height: 20,
                    //             color: Colors.grey.shade300),
                    //         _buildActionItem(Icons.star_border, 'My Ratings'),
                    //         Container(
                    //             width: 1,
                    //             height: 20,
                    //             color: Colors.grey.shade300),
                    //         _buildActionItem(
                    //             Icons.photo_library_outlined, 'Gallery'),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ),

                  if (user?.isFan == false)
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.socaBlack, width: 2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 16,
                                color: AppColors.socaBlack,
                                weight: 2,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                AppStrings.sharePostPrompt,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                context.push(AppRoutes.createPost);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.socaBlack,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  AppStrings.createPostUpper,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.socaYellow,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (_priorityHomeFeedsLoaded)
                    const SliverToBoxAdapter(child: MostEndorsedSection())
                  else
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(child: AppLoader()),
                      ),
                    ),

                  if (_priorityHomeFeedsLoaded && user?.isFan == false)
                    const SliverToBoxAdapter(child: MostFollowedTeamsSection()),
                  if (_priorityHomeFeedsLoaded)
                    const SliverToBoxAdapter(child: LiveTournamentsSection()),
                  if (_priorityHomeFeedsLoaded && user != null && !user.isFan)
                    SliverToBoxAdapter(
                      child: matchUpdates.when(
                        data: (matches) => _buildMatchUpdatesSection(matches),
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: feedState.maybeWhen(
                      data: (feed) => feed.socaFeed != null
                          ? FeedPostCard(post: feed.socaFeed!)
                          : const SizedBox.shrink(),
                      orElse: () => const SizedBox.shrink(),
                    ),
                  ),
                  // ── Interleaved feed: posts with section cards every 5 items ──
                  // Matches Android customizedAdd() in FanHomeFeedFragment /
                  // CommonHomeFeedFragment. Section order per batch:
                  //   pos=0  → NewTeamsSection
                  //   pos=5  → RecommendedUsersSection
                  //   pos=10 → LiveTournamentsSection
                  //   pos=15 → NewTeamsSection (cycles)
                  ...feedState.maybeWhen(
                    data: (feed) {
                      final items = _buildInjectedFeedList(feed.posts);
                      if (feed.posts.isEmpty) {
                        return [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: Center(
                                child: Text(
                                  'No posts yet'.tr,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ];
                      }
                      return [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (ctx, i) => items[i],
                            childCount: items.length,
                          ),
                        ),
                      ];
                    },
                    loading: () => [
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: Center(child: AppLoader()),
                        ),
                      ),
                    ],
                    error: (error, _) => [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.error_outline,
                                    size: 48, color: AppColors.error),
                                const SizedBox(height: 16),
                                Text(
                                  'Error loading feed'.tr,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () =>
                                      ref.read(feedProvider.notifier).refresh(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.socaBlack,
                                    foregroundColor: AppColors.socaYellow,
                                  ),
                                  child: Text('Retry'.tr),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    orElse: () => const [],
                  ),
                ],
              ),
            ),
          ),
          if (_showFeedbackBanner)
            FeedbackBanner(
              onTap: () {
                StorageService.setString(
                    'lastFeedbackDate', DateTime.now().toIso8601String());
                setState(() => _showFeedbackBanner = false);
                // TODO: navigate to feedback form
              },
            ),
          LiveMatchBanner(
            onTap: () => context.push(AppRoutes.playerLiveMatches),
          ),
        ],
      ),
    );
  }
}
