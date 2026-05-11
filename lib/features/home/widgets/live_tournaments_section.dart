import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/home_feed_providers.dart';
import 'feed_section_header.dart';

class LiveTournamentsSection extends ConsumerWidget {
  const LiveTournamentsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(feedLiveTmntsProvider);

    if (state.isLoading && state.items.isEmpty) return const SizedBox.shrink();
    if (state.items.isEmpty) return const SizedBox.shrink();

    log("this is the data of the ongoing tournaments ${state.items}");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          width: double.infinity,
          color: AppColors.socaBlack,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ongoing Tournaments',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaYellow,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to view all live tournaments
                },
                child: const Text(
                  'View All',
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
                padding: const EdgeInsets.all(16),
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
                              ? const Icon(Icons.sports_soccer,
                                  color: AppColors.socaGrey)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      (tournament.tmntName ?? 'Tournament')
                                          .toUpperCase(),
                                      style: const TextStyle(
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
                                      padding: const EdgeInsets.only(left: 4),
                                      child: _buildCountryFlag(
                                          tournament.country!),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                tournament.startDate ?? 'Unknown Date',
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

                    const SizedBox(height: 16),

                    // Banner Text
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                        children: [
                          TextSpan(
                              text:
                                  '${tournament.tmntName ?? 'Tournament'} is live!!! '),
                          const TextSpan(
                            text: 'Check tournament details',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

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
                                    ? const Icon(Icons.sports_soccer,
                                        size: 40, color: AppColors.socaGrey)
                                    : null,
                              ),
                              if (index > 0)
                                const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: AppColors.socaBlack,
                                  size: 32,
                                ),
                            ],
                          ),

                          const SizedBox(width: 16),

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
                                          _buildDetailItem('Gender',
                                              'Male'), // Default fallback
                                          _buildDetailItem(
                                              'Game Type',
                                              tournament.tmntType ??
                                                  'Football'),
                                          _buildDetailItem('Country',
                                              tournament.country ?? 'N/A'),
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
                                          _buildDetailItem('Location',
                                              tournament.city ?? 'N/A'),
                                          _buildDetailItem('Tournament Date',
                                              'Started on ${tournament.startDate ?? 'N/A'}'),
                                          _buildDetailItem(
                                              'Tournament Venue',
                                              tournament.city ??
                                                  'N/A'), // Fallback
                                          _buildDetailItem(
                                              'Total Number of Teams',
                                              '${tournament.teamsCount}'),
                                          _buildDetailItem(
                                              'Number of player per team',
                                              'No limit'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (index < state.items.length - 1 ||
                                    state.isLoadingMore)
                                  const Icon(
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
      padding: const EdgeInsets.only(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: AppColors.socaBlack,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
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
      return const Text('🇬🇭', style: TextStyle(fontSize: 18));
    } else if (country.toLowerCase() == 'india') {
      return const Text('🇮🇳', style: TextStyle(fontSize: 18));
    }
    return const Icon(Icons.flag, size: 18);
  }
}
