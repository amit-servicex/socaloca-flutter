import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/home_feed_providers.dart';
import 'feed_section_header.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Most Followed Teams Section
/// Matches Android CommonHomeFeedFragment teams section
class MostFollowedTeamsSection extends ConsumerWidget {
  const MostFollowedTeamsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeProvider);
    final state = ref.watch(feedTeamsProvider);

    if (state.isLoading) return const SizedBox.shrink();
    if (state.items.isEmpty) return const SizedBox.shrink();

    final itemCount = state.items.length + (state.isLoadingMore ? 1 : 0);
    // log("this is the most followed teams section, item count: ${state.items.first.toJson()}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FeedSectionHeader(title: AppStrings.mostFollowedTeams),
        Divider(
          color: AppColors.socaBlack,
          thickness: .7,
          height: 0,
          // indent: 12,
          // endIndent: 12,
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 65,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              // Trigger load more when near end
              if (index == state.items.length - 1 &&
                  state.hasMore &&
                  !state.isLoadingMore) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(feedTeamsProvider.notifier).loadMore();
                });
              }

              // Show loading indicator
              if (index == state.items.length) {
                return const AppLoader();
              }

              final team = state.items[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to team bio
                  context.push('${AppRoutes.teams}/${team.id}');
                },
                child: Container(
                  // width: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Team Logo
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.socaGrey.withOpacity(0.2),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: team.logo != null &&
                                  team.logo!.isNotEmpty &&
                                  !team.logo!.startsWith('file:///')
                              ? Image.network(
                                  ApiConstants.getImageUrl(team.logo!),
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.shield,
                                    size: 30,
                                    color: AppColors.socaGrey,
                                  ),
                                )
                              : const Icon(
                                  Icons.shield,
                                  size: 30,
                                  color: AppColors.socaGrey,
                                ),
                        ),
                      ),
                      // const SizedBox(height: 6),
                      // // Team Name
                      // Text(
                      //   team.name,
                      //   style: const TextStyle(
                      //     fontFamily: 'Poppins',
                      //     fontSize: 11,
                      //     fontWeight: FontWeight.w600,
                      //     color: AppColors.socaBlack,
                      //   ),
                      //   maxLines: 2,
                      //   overflow: TextOverflow.ellipsis,
                      //   textAlign: TextAlign.center,
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
