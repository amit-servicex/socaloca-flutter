import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/feed_providers.dart';
import '../widgets/feed_header.dart';
import '../widgets/feed_post_card.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Social Feed Screen matching Android CommonHomeFeedFragment.
class SocialFeedScreen extends ConsumerStatefulWidget {
  const SocialFeedScreen({super.key});

  @override
  ConsumerState<SocialFeedScreen> createState() => _SocialFeedScreenState();
}

class _SocialFeedScreenState extends ConsumerState<SocialFeedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(feedProvider.notifier);
      if (!notifier.isInitialized) {
        notifier.loadFeed();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(feedProvider);

    return feedState.when(
      data: (feed) {
        final posts = feed.posts;

        return Column(
          children: [
            const FeedHeaderWidget(),
            if (posts.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  'No posts yet'.tr,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: AppColors.socaBlack,
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: posts.length,
                itemBuilder: (context, index) =>
                    FeedPostCard(post: posts[index]),
              ),
          ],
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(32),
        child: AppLoader(),
      ),
      error: (error, stack) => Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                'Error loading feed'.tr,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: AppColors.socaBlack,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(feedProvider.notifier).refresh(),
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
    );
  }
}
