import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/router/app_routes.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/home_feed_providers.dart';

class LiveTournamentsSection extends ConsumerStatefulWidget {
  LiveTournamentsSection({super.key});

  @override
  ConsumerState<LiveTournamentsSection> createState() =>
      _LiveTournamentsSectionState();
}

class _LiveTournamentsSectionState
    extends ConsumerState<LiveTournamentsSection> {
  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        final state = ref.read(feedLiveTmntsProvider);
        if (state.items.isEmpty) return;

        int nextPage = _pageController.page!.round() + 1;
        if (nextPage >= state.items.length) {
          nextPage = 0; // Wrap around to the beginning
        }
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(localeProvider);
    final state = ref.watch(feedLiveTmntsProvider);

    if (state.isLoading && state.items.isEmpty) return SizedBox.shrink();
    if (state.items.isEmpty) return SizedBox.shrink();

    // log("this is the data of the ongoing tournaments ${state.items}");

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
                AppStrings.ongoingTournaments,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaYellow,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.push(AppRoutes.tournamentslistScreen,
                      extra: {'status': 'ongoing'});
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

        // Slider Content
        Container(
          color: Colors.grey.shade100, // Light background for the content
          height: 400, // Approximate height for the content block
          child: PageView.builder(
            controller: _pageController,
            itemCount: state.items.length,
            onPageChanged: (index) {
              if (index == state.items.length - 1 &&
                  state.hasMore &&
                  !state.isLoadingMore) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(feedLiveTmntsProvider.notifier).loadMore();
                });
              }
            },
            itemBuilder: (context, index) {
              final tournament = state.items[index];

              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Logo, Name, Date
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              AppColors.socaGrey.withValues(alpha: 0.2),
                          backgroundImage: tournament.imageUrl != null &&
                                  tournament.imageUrl!.isNotEmpty &&
                                  !tournament.imageUrl!.startsWith('file:///')
                              ? NetworkImage(
                                  ApiConstants.getImageUrl(tournament.imageUrl))
                              : null,
                          child: tournament.imageUrl == null ||
                                  tournament.imageUrl!.isEmpty ||
                                  tournament.imageUrl!.startsWith('file:///')
                              ? Icon(Icons.sports_soccer,
                                  color: AppColors.socaGrey)
                              : null,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      (tournament.tmntName ??
                                              AppStrings.tournamentFallback)
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.socaBlack,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (tournament.country != null &&
                                      tournament.country!.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(left: 4),
                                      child: _buildCountryFlag(
                                          tournament.country!),
                                    ),
                                ],
                              ),
                              SizedBox(height: 2),
                              Text(
                                tournament.startDate ?? AppStrings.unknownDate,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: AppColors.socaBlack
                                      .withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Banner Text
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                        children: [
                          TextSpan(
                              text: AppStrings.tournamentIsLive(
                                  tournament.tmntName ??
                                      AppStrings.tournamentFallback)),
                          TextSpan(
                            text: AppStrings.checkTournamentDetails,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // Details block
                    Expanded(
                      child: Row(
                        children: [
                          // Large left logo with arrow
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor:
                                    AppColors.socaGrey.withValues(alpha: 0.2),
                                backgroundImage: tournament.imageUrl != null &&
                                        tournament.imageUrl!.isNotEmpty &&
                                        !tournament.imageUrl!
                                            .startsWith('file:///')
                                    ? NetworkImage(ApiConstants.getImageUrl(
                                        tournament.imageUrl))
                                    : null,
                                child: tournament.imageUrl == null ||
                                        tournament.imageUrl!.isEmpty ||
                                        tournament.imageUrl!
                                            .startsWith('file:///')
                                    ? Icon(Icons.sports_soccer,
                                        size: 40, color: AppColors.socaGrey)
                                    : null,
                              ),
                              if (index > 0)
                                Icon(
                                  Icons.arrow_back_ios_new,
                                  color: AppColors.socaBlack,
                                  size: 32,
                                ),
                            ],
                          ),

                          SizedBox(width: 16),

                          // Right side details
                          Expanded(
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _buildDetailItem(
                                              AppStrings.genderPlain,
                                              AppStrings
                                                  .male), // Default fallback
                                          _buildDetailItem(
                                              AppStrings.gameType,
                                              tournament.tmntType ??
                                                  AppStrings.football),
                                          _buildDetailItem(
                                              AppStrings.country,
                                              tournament.country ??
                                                  AppStrings.na),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _buildDetailItem(AppStrings.location,
                                              tournament.city ?? AppStrings.na),
                                          _buildDetailItem(
                                              AppStrings.tournamentDate,
                                              AppStrings.startedOn(
                                                  tournament.startDate ??
                                                      AppStrings.na)),
                                          _buildDetailItem(
                                              AppStrings.tournamentVenue,
                                              tournament.city ??
                                                  AppStrings.na), // Fallback
                                          _buildDetailItem(
                                              AppStrings.totalNumberOfTeams,
                                              '${tournament.teamsCount}'),
                                          _buildDetailItem(
                                              AppStrings.numberOfPlayerPerTeam,
                                              AppStrings.noLimit),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (index < state.items.length - 1 ||
                                    state.isLoadingMore)
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColors.socaBlack,
                                    size: 32,
                                  ),
                              ],
                            ),
                          ),
                        ],
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

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: AppColors.socaBlack,
            ),
          ),
          SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.socaBlack,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildCountryFlag(String country) {
    if (country.toLowerCase() == 'ghana') {
      return Text('🇬🇭'.tr, style: TextStyle(fontSize: 18));
    } else if (country.toLowerCase() == 'india') {
      return Text('🇮🇳'.tr, style: TextStyle(fontSize: 18));
    }
    return Icon(Icons.flag, size: 18);
  }
}
