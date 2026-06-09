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
import 'feed_section_header.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class MostEndorsedSection extends ConsumerWidget {
  const MostEndorsedSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeProvider);
    final state = ref.watch(mostEndorsedProvider);

    if (state.isLoading) return const SizedBox.shrink();
    if (state.items.isEmpty) return const SizedBox.shrink();

    final itemCount = state.items.length + (state.isLoadingMore ? 1 : 0);
    // log("this is the most endorse player ${state.items.map((i) => i.toJson())}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FeedSectionHeader(
          title: AppStrings.mostEndorsedPlayers,
        ),
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
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index == state.items.length - 1 &&
                  state.hasMore &&
                  !state.isLoadingMore) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(mostEndorsedProvider.notifier).loadMore();
                });
              }

              if (index == state.items.length) {
                return const AppLoader();
              }

              final player = state.items[index];
              return InkWell(
                onTap: () {
                  context.push(AppRoutes.playerBio
                      .replaceFirst(':userId', player.userId ?? ''));
                },
                child: Container(
                  // width: 120,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withValues(alpha: 0.05),
                    //     blurRadius: 4,
                    //     offset: const Offset(0, 2),
                    //   ),
                    // ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor:
                                AppColors.socaGrey.withValues(alpha: 0.2),
                            backgroundImage: player.imageUrl != null &&
                                    player.imageUrl!.isNotEmpty &&
                                    !player.imageUrl!.startsWith('file:///')
                                ? NetworkImage(
                                    ApiConstants.getImageUrl(player.imageUrl))
                                : null,
                            child: player.imageUrl == null ||
                                    player.imageUrl!.isEmpty ||
                                    player.imageUrl!.startsWith('file:///')
                                ? const Icon(Icons.person,
                                    size: 30, color: AppColors.socaGrey)
                                : null,
                          ),
                          if (player.endorsementCount > 0)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppColors.socaYellow,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${player.endorsementCount}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      // const SizedBox(height: 8),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8),
                      //   child: Text(
                      //     '${player.firstName ?? ''} ${player.lastName ?? ''}'
                      //         .trim(),
                      //     style: const TextStyle(
                      //       fontFamily: 'Poppins',
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w600,
                      //       color: AppColors.socaBlack,
                      //     ),
                      //     maxLines: 2,
                      //     overflow: TextOverflow.ellipsis,
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),

                      if (player.position != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            player.position!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColors.socaGrey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
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
