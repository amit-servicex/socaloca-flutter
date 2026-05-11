import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/features/home/widgets/most_followed_teams_section.dart';
import 'package:socaloca/shared/providers/auth_provider.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../social_feed/providers/feed_providers.dart';
import '../../social_feed/screens/social_feed_screen.dart';
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
      PageController(viewportFraction: 0.92);
  bool _showFeedbackBanner = false;
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
    // 1. Get blocked users (first call in Android)
    ref.read(blockedUsersProvider);

    // 2. Get user profile details (must load before feed)
    await ref.read(userProfileDetailsProvider.future);

    // 3. Get match updates (for Player/Coach/Manager/Admin only)
    final user = ref.read(currentUserProvider);
    if (user != null && !user.isFan) {
      ref.read(matchUpdatesProvider);
    }

    // 4. Check language selection
    _checkAndShowLanguageSelection();

    // 5. Check feedback visibility
    _checkFeedbackVisibility();

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

  Widget _buildActionItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.socaBlack),
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
          child: const Text(
            'Match Updates',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.socaYellow,
            ),
          ),
        ),

        SizedBox(
          height: 340,
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
                const months = [
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
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Tournament logo + name row ──────────────────
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
                      child: Row(
                        children: [
                          if (item.tournamentLogo.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                ApiConstants.getImageUrl(item.tournamentLogo),
                                width: 32,
                                height: 32,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.emoji_events,
                                  size: 28,
                                  color: AppColors.socaGrey,
                                ),
                              ),
                            )
                          else
                            const Icon(Icons.emoji_events,
                                size: 28, color: AppColors.socaGrey),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              tournamentName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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

                    // ── Divider ────────────────────────────────────
                    Container(
                        height: 0.5,
                        color: AppColors.socaGrey.withOpacity(0.2)),

                    // ── Venue ──────────────────────────────────────
                    if (venue.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          venue,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),

                    // ── Teams + Score row ──────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Left chevron
                          GestureDetector(
                            onTap: isFirst
                                ? null
                                : () =>
                                    _matchUpdatesPageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 350),
                                      curve: Curves.easeInOut,
                                    ),
                            child: Icon(
                              Icons.chevron_left,
                              size: 28,
                              color: isFirst
                                  ? AppColors.socaGrey.withOpacity(0.3)
                                  : AppColors.socaGrey,
                            ),
                          ),

                          // Home team
                          Expanded(
                            child: Column(
                              children: [
                                _buildMatchUpdateTeamLogo(homeLogo),
                                const SizedBox(height: 8),
                                Text(
                                  homeName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: AppColors.socaBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Score + date/time
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                Text(
                                  scoreText,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.socaBlack,
                                  ),
                                ),
                                if (dateText.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    dateText,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color:
                                          AppColors.socaBlack.withOpacity(0.6),
                                    ),
                                  ),
                                  Text(
                                    timeText,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color:
                                          AppColors.socaBlack.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          // Away team
                          Expanded(
                            child: Column(
                              children: [
                                _buildMatchUpdateTeamLogo(awayLogo),
                                const SizedBox(height: 8),
                                Text(
                                  awayName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: AppColors.socaBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Right chevron
                          GestureDetector(
                            onTap: isLast
                                ? null
                                : () => _matchUpdatesPageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 350),
                                      curve: Curves.easeInOut,
                                    ),
                            child: Icon(
                              Icons.chevron_right,
                              size: 28,
                              color: isLast
                                  ? AppColors.socaGrey.withOpacity(0.3)
                                  : AppColors.socaGrey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Divider ────────────────────────────────────
                    Container(
                        height: 0.5,
                        color: AppColors.socaGrey.withOpacity(0.2)),

                    // ── View Details button ────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: navigate to match details
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.socaBlack,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'VIEW DETAILS',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
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
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: AppColors.border,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.sports_soccer, color: AppColors.textSecondary),
      );
    }
    return Container(
      width: 40,
      height: 40,
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

  @override
  Widget build(BuildContext context) {
    final userId = StorageService.userId ?? '';
    final user = ref.watch(currentUserProvider);
    final matchUpdates = ref.watch(matchUpdatesProvider);

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
              child: const Text(
                '⚠️ Not logged in - Home feed sections will be empty',
                style: TextStyle(
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
                  ref.read(userProfileDetailsProvider.future),
                  if (user != null && !user.isFan)
                    ref.read(matchUpdatesProvider.future),
                  ref.read(feedLiveTmntsProvider.notifier).refresh(),
                  ref.read(feedNewTeamsProvider.notifier).refresh(),
                  ref.read(feedRecUsersProvider.notifier).refresh(),
                  ref.read(mostEndorsedProvider.notifier).refresh(),
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
                    expandedHeight: 150,
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
                                    const Text('Hello,',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14)),
                                    Text(user?.name ?? 'User!',
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _buildStatColumn('0', 'POSTS'),
                                    const SizedBox(width: 12),
                                    _buildStatColumn('0', 'CHEERS'),
                                    const SizedBox(width: 12),
                                    _buildStatColumn('0', 'FOLLOWERS'),
                                    const SizedBox(width: 12),
                                    _buildStatColumn('0', 'FOLLOWING'),
                                  ],
                                ),
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor:
                                      AppColors.socaGrey.withOpacity(0.2),
                                  backgroundImage: user?.profileImage != null &&
                                          user!.profileImage!.isNotEmpty &&
                                          !user.profileImage!
                                              .startsWith('file:///')
                                      ? NetworkImage(user.profileImage!)
                                      : null,
                                  child: user?.profileImage == null ||
                                          user!.profileImage!.isEmpty ||
                                          user.profileImage!
                                              .startsWith('file:///')
                                      ? const Icon(Icons.person,
                                          color: AppColors.socaBlack)
                                      : null,
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(color: Colors.grey.shade300),
                                  bottom:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildActionItem(
                                      Icons.edit_document, 'My Bio'),
                                  Container(
                                      width: 1,
                                      height: 20,
                                      color: Colors.grey.shade300),
                                  _buildActionItem(
                                      Icons.image_outlined, 'My Posts'),
                                  Container(
                                      width: 1,
                                      height: 20,
                                      color: Colors.grey.shade300),
                                  _buildActionItem(
                                      Icons.star_border, 'My Ratings'),
                                  Container(
                                      width: 1,
                                      height: 20,
                                      color: Colors.grey.shade300),
                                  _buildActionItem(
                                      Icons.photo_library_outlined, 'Gallery'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // bottom: PreferredSize(
                    //   preferredSize: const Size.fromHeight(50),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       border: Border(
                    //         top: BorderSide(color: Colors.grey.shade300),
                    //         bottom: BorderSide(color: Colors.grey.shade300),
                    //       ),
                    //     ),
                    //     padding: const EdgeInsets.symmetric(vertical: 12),
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
                            child: const Icon(Icons.add,
                                size: 16, color: AppColors.socaBlack),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Share a photo or video and write\nsomething.',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.socaBlack,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'CREATE A POST',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.socaYellow,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: MostEndorsedSection()),
                  const SliverToBoxAdapter(child: MostFollowedTeamsSection()),
                  const SliverToBoxAdapter(child: NewTeamsSection()),
                  const SliverToBoxAdapter(child: LiveTournamentsSection()),
                  if (user != null && !user.isFan)
                    SliverToBoxAdapter(
                      child: matchUpdates.when(
                        data: (matches) => _buildMatchUpdatesSection(matches),
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                      ),
                    ),
                  const SliverToBoxAdapter(child: RecommendedUsersSection()),
                  const SliverToBoxAdapter(child: SocialFeedScreen()),
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
          LiveMatchBanner(onTap: () => context.push(AppRoutes.matches)),
        ],
      ),
    );
  }
}
