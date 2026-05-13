import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/feed_rec_user_model.dart';
import '../providers/home_feed_providers.dart';

class RecommendedUsersSection extends ConsumerStatefulWidget {
  const RecommendedUsersSection({super.key});

  @override
  ConsumerState<RecommendedUsersSection> createState() =>
      _RecommendedUsersSectionState();
}

class _RecommendedUsersSectionState
    extends ConsumerState<RecommendedUsersSection> {
  final PageController _pageController = PageController();
  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_pageController.hasClients) return;

      final state = ref.read(feedRecUsersProvider);
      if (state.items.isEmpty) return;

      int currentPage = _pageController.page?.round() ?? 0;
      int totalCount = state.items.length + (state.hasMore ? 1 : 0);

      if (currentPage >= totalCount - 1) {
        if (!state.hasMore) {
          // Loop back to the beginning if no more items
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
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

  void _nextPage() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_pageController.hasClients) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onShare(FeedRecUserModel user) {
    final currentUserId = StorageService.userId ?? '';
    final userId = user.userId ?? '';
    final isPlayer = (user.userType ?? '').toLowerCase() == 'player';
    final path = isPlayer ? 'pl' : 'cm';
    final url =
        'https://share.socaloca.football/$path/$userId/u/$currentUserId';
    final name = '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
    SharePlus.instance.share(ShareParams(
      text: '$name - Check out this post on SocaLoca. $url',
    ));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(feedRecUsersProvider);

    if (state.isLoading) return const SizedBox.shrink();
    if (state.items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Custom Black Header
        Container(
          color: AppColors.socaBlack,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Recently Joined',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaYellow,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        // Slider Container
        Container(
          color: Colors.white,
          height: 380, // Approximate height for the card
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: state.items.length + (state.hasMore ? 1 : 0),
                onPageChanged: (index) {
                  if (index == state.items.length - 1 &&
                      state.hasMore &&
                      !state.isLoadingMore) {
                    ref.read(feedRecUsersProvider.notifier).loadMore();
                  }
                },
                itemBuilder: (context, index) {
                  if (index == state.items.length) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final user = state.items[index];
                  final name =
                      '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();

                  return _buildUserCard(user, name);
                },
              ),

              // Left Chevron
              Positioned(
                left: 0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new,
                      size: 32, color: Colors.black54),
                  onPressed: _prevPage,
                ),
              ),

              // Right Chevron
              Positioned(
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios,
                      size: 32, color: Colors.black54),
                  onPressed: _nextPage,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserCard(FeedRecUserModel user, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top bar: Socaloca profile
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.socaBlack,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    'assets/images/logo_transparent.png',
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        'SocaLoca',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.socaBlack,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.verified,
                          size: 16, color: AppColors.socaBlack),
                    ],
                  ),
                  const Text(
                    '5 hrs', // Static placeholder as per design
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Announcement text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.socaBlack,
                fontSize: 15,
              ),
              children: [
                TextSpan(
                    text:
                        '${user.firstName ?? 'A user'} has joined SocaLoca!!! '),
                const TextSpan(
                  text: 'Check his bio',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Grey section with photo and details
        Expanded(
          child: Container(
            color: const Color(0xFFF9F9F9),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Photo + Flag
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.socaGrey.withOpacity(0.2),
                      backgroundImage: user.imageUrl != null &&
                              user.imageUrl!.isNotEmpty &&
                              !user.imageUrl!.startsWith('file:///')
                          ? NetworkImage(
                              ApiConstants.getImageUrl(user.imageUrl!))
                          : null,
                      child: user.imageUrl == null ||
                              user.imageUrl!.isEmpty ||
                              user.imageUrl!.startsWith('file:///')
                          ? const Icon(Icons.person,
                              size: 40, color: AppColors.socaGrey)
                          : null,
                    ),
                    const SizedBox(height: 8),
                    const Text('🇬🇭',
                        style: TextStyle(fontSize: 24)), // Hardcoded for now
                  ],
                ),
                const SizedBox(width: 16),
                // Name and Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.socaBlack,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  _buildDetailRow('Born', '-'),
                                  const SizedBox(height: 16),
                                  _buildDetailRow('Height (cms)', '-'),
                                  const SizedBox(height: 16),
                                  _buildDetailRow('Preferred Foot', '-'),
                                ],
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 90,
                              color: Colors.grey.shade400,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDetailRow('Playing Level', '-'),
                                  const SizedBox(height: 16),
                                  _buildDetailRow('Jersey Size', '-'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // SHARE button at bottom
        GestureDetector(
          onTap: () => _onShare(user),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(color: AppColors.socaGrey, width: 1)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.ios_share_rounded,
                    size: 22, color: AppColors.socaBlack),
                SizedBox(width: 8),
                Text(
                  'SHARE',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.socaBlack,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.socaBlack,
          ),
        ),
      ],
    );
  }
}
