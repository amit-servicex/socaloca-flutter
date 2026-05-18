import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/one_off_matches_providers.dart';
import '../widgets/recent_match_card.dart';
import '../widgets/todays_match_card.dart';
import '../widgets/upcoming_match_card.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Main One-Off Matches screen with 3 sections:
/// - Today's Match (featured)
/// - Upcoming Matches (next 3)
/// - Recent Matches (last 3 with scores)
class OneOffMatchesScreen extends ConsumerWidget {
  OneOffMatchesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todaysMatch = ref.watch(todaysMatchProvider);
    final upcomingMatches = ref.watch(upcomingMatchesPreviewProvider);
    final recentMatches = ref.watch(recentMatchesPreviewProvider);

    return Container(
        color: AppColors.socaPageBg,
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(todaysMatchProvider);
            ref.invalidate(upcomingMatchesPreviewProvider);
            ref.invalidate(recentMatchesPreviewProvider);
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Today's Match Section
                todaysMatch.when(
                  data: (match) {
                    if (match == null) {
                      return SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: Text(
                            'TODAY\'S MATCH'.tr,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ),
                        TodaysMatchCard(
                          match: match,
                          onTap: () {
                            // TODO: Navigate to match details
                          },
                        ),
                      ],
                    );
                  },
                  loading: () => SizedBox(
                    height: 200,
                    child: AppLoader(),
                  ),
                  error: (_, __) => SizedBox.shrink(),
                ),

                SizedBox(height: 16),

                // Upcoming Matches Section
                upcomingMatches.when(
                  data: (matches) {
                    if (matches.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'No upcoming matches'.tr,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'UPCOMING MATCHES'.tr,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: AppColors.socaBlack,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.push(AppRoutes.upcomingMatches);
                                },
                                child: Text(
                                  'View All'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColors.socaYellow,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...matches.map((match) => UpcomingMatchCard(
                              match: match,
                              onTap: () {
                                // TODO: Navigate to match details
                              },
                            )),
                      ],
                    );
                  },
                  loading: () => SizedBox(
                    height: 150,
                    child: AppLoader(),
                  ),
                  error: (_, __) => Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Error loading upcoming matches'.tr,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // Recent Matches Section
                recentMatches.when(
                  data: (matches) {
                    if (matches.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'No recent matches'.tr,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'RECENT MATCHES'.tr,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: AppColors.socaBlack,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.push(AppRoutes.recentMatches);
                                },
                                child: Text(
                                  'View All'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColors.socaYellow,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...matches.map((match) => RecentMatchCard(
                              match: match,
                              onTap: () {
                                // TODO: Navigate to match details
                              },
                            )),
                      ],
                    );
                  },
                  loading: () => SizedBox(
                    height: 150,
                    child: AppLoader(),
                  ),
                  error: (_, __) => Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Error loading recent matches'.tr,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),
              ],
            ),
          ),
        ));
  }
}
