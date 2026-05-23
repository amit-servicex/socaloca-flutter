import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socaloca/core/router/app_routes.dart';
import 'package:socaloca/core/storage/storage_service.dart';
import 'package:socaloca/features/home/data/models/feed_new_team_model.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/home_feed_providers.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class NewTeamsSection extends ConsumerStatefulWidget {
  NewTeamsSection({super.key});

  @override
  ConsumerState<NewTeamsSection> createState() => _NewTeamsSectionState();
}

class _NewTeamsSectionState extends ConsumerState<NewTeamsSection> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  int _currentPage = 0;
  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (!_pageController.hasClients) return;

      final state = ref.read(feedNewTeamsProvider);
      if (state.items.isEmpty) return;

      int currentPage = _pageController.page?.round() ?? 0;
      int totalCount = state.items.length + (state.hasMore ? 1 : 0);

      if (currentPage >= totalCount - 1) {
        if (!state.hasMore) {
          // Loop back to the beginning if no more items
          _pageController.animateToPage(
            0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      } else {
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onShareTeam(FeedNewTeamModel team) {
    final currentUserId = StorageService.userId ?? '';
    final teamId = team.teamId ?? team.id ?? '';
    final url = 'https://share.socaloca.football/team/$teamId/u/$currentUserId';
    final name = team.teamName ?? 'Team';
    SharePlus.instance.share(ShareParams(
      text: '$name - Check out this post on SocaLoca. $url',
    ));
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(localeProvider);
    final state = ref.watch(feedNewTeamsProvider);
    // log("this is the data of the recently joined teams ${state.items}");

    if (state.isLoading) return SizedBox.shrink();
    if (state.items.isEmpty) return SizedBox.shrink();

    final itemCount = state.items.length + (state.isLoadingMore ? 1 : 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          width: double.infinity,
          color: AppColors.socaBlack,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.recentlyJoinedTeams,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaYellow,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.push(AppRoutes.teams, extra: {'status': 'all'});
                },
                child: Text(
                  AppStrings.viewAll,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey.shade100, // Matches the spacing background
          height: 380, // adjusted height
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);

              if (index == state.items.length - 1 &&
                  state.hasMore &&
                  !state.isLoadingMore) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(feedNewTeamsProvider.notifier).loadMore();
                });
              }
            },
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index == state.items.length) {
                return AppLoader();
              }

              final team = state.items[index];
              final teamLocation = [team.city, team.country]
                  .where((e) => e != null && e.isNotEmpty)
                  .join(', ');
              final joinedText = team.createdOn != null
                  ? _formatCreatedOn(team.createdOn!)
                  : null;

              final isFirst = _currentPage == 0;
              final isLast = _currentPage == state.items.length - 1;

              return Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Announcement section ───────────────────────────
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.black,
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Image.asset(
                                    'assets/images/logo_transparent.png',
                                    color: Colors.white,
                                    errorBuilder: (_, __, ___) => Icon(
                                      Icons.sports_soccer,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'SocaLoca'.tr,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.socaBlack,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.verified,
                                          color: AppColors.socaBlack,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      joinedText ?? '',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.socaGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: AppColors.socaBlack,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '${team.teamName ?? 'Team'} has joined SocaLoca!!!\n',
                                ),
                                TextSpan(
                                  text: 'Check team bio',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Divider ────────────────────────────────────────
                    Container(
                        height: 0.5,
                        color: AppColors.socaGrey.withOpacity(0.2)),

                    // ── Profile row with chevron navigation ───────────
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 24),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: isFirst
                                ? null
                                : () => _pageController.previousPage(
                                      duration: Duration(milliseconds: 350),
                                      curve: Curves.easeInOut,
                                    ),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 32,
                              color: isFirst
                                  ? AppColors.socaGrey.withOpacity(0.3)
                                  : AppColors.socaBlack,
                            ),
                          ),
                          SizedBox(width: 12),
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.socaGrey.withAlpha(36),
                            backgroundImage: team.teamLogo != null &&
                                    team.teamLogo!.isNotEmpty &&
                                    !team.teamLogo!.startsWith('file:///')
                                ? NetworkImage(
                                    ApiConstants.getImageUrl(team.teamLogo))
                                : null,
                            child: team.teamLogo == null ||
                                    team.teamLogo!.isEmpty ||
                                    team.teamLogo!.startsWith('file:///')
                                ? Icon(Icons.groups,
                                    size: 40, color: AppColors.socaGrey)
                                : null,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        team.teamName ?? 'Team',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.socaBlack,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (team.country != null &&
                                        team.country!.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(
                                          _countryFlag(team.country),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Text(
                                  team.teamType ?? 'Club',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.socaBlack,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  teamLocation,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.socaBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          GestureDetector(
                            onTap: isLast
                                ? null
                                : () => _pageController.nextPage(
                                      duration: Duration(milliseconds: 350),
                                      curve: Curves.easeInOut,
                                    ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 32,
                              color: isLast
                                  ? AppColors.socaGrey.withOpacity(0.3)
                                  : AppColors.socaBlack,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Divider ────────────────────────────────────────
                    Divider(
                      color: AppColors.socaBlack,
                      height: 1,
                      thickness: .8,
                    ),
                    // ── Share button ───────────────────────────────────
                    InkWell(
                      onTap: () => _onShareTeam(team),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/ic_share_feed.png",
                              width: 28,
                              height: 28,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'SHARE'.tr,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.socaBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColors.socaBlack,
                      height: 1,
                      thickness: .8,
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // ── Page indicator dots ──────────────────────────────────────────
        if (state.items.length > 1)
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                state.items.length.clamp(0, 8),
                (i) => AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  width: _currentPage == i ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? AppColors.primary
                        : AppColors.socaGrey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),

        SizedBox(height: 16),
      ],
    );
  }

  String _formatCreatedOn(int createdOn) {
    final parsed = DateTime.fromMillisecondsSinceEpoch(createdOn);
    return '${_monthName(parsed.month)} ${parsed.day}, ${_formatTime(parsed)}';
  }

  String _formatTime(DateTime dateTime) {
    final hour =
        dateTime.hour == 0 || dateTime.hour == 12 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  String _monthName(int month) {
    final names = [
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
    return names[month - 1];
  }
}

/// Naive flag emoji helper — replace with a proper package if needed.
String _countryFlag(String? country) {
  if (country == null) return '';
  final map = {
    'Ghana': '🇬🇭',
    'Nigeria': '🇳🇬',
    'USA': '🇺🇸',
    'UK': '🇬🇧',
    'Brazil': '🇧🇷',
    'France': '🇫🇷',
    'Germany': '🇩🇪',
    'Spain': '🇪🇸',
    'India': '🇮🇳',
  };
  return map[country] ?? '🇬🇭'; // Default to Ghana as fallback if unknown
}
