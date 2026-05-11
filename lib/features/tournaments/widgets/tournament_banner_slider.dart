import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/tournament_models.dart';

/// Auto-scrolling banner slider — mirrors Android AutoScrollViewPager + TournamentsPagerAdapter
class TournamentBannerSlider extends StatefulWidget {
  const TournamentBannerSlider({
    super.key,
    required this.banners,
    this.height = 200,
    this.onBannerTap,
  });

  final List<BannerModel> banners;
  final double height;
  final void Function(BannerModel)? onBannerTap;

  @override
  State<TournamentBannerSlider> createState() => _TournamentBannerSliderState();
}

class _TournamentBannerSliderState extends State<TournamentBannerSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late List<BannerModel> _sortedBanners;

  @override
  void initState() {
    super.initState();
    // Sort banners by seq — same as Android Collections.sort by seq
    _sortedBanners = List.from(widget.banners)
      ..sort((a, b) => a.seq.compareTo(b.seq));
    if (_sortedBanners.isNotEmpty) {
      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      if (_sortedBanners.length <= 1) return;
      final nextPage = (_currentPage + 1) % _sortedBanners.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_sortedBanners.isEmpty) {
      return _buildPlaceholder();
    }

    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _sortedBanners.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              final banner = _sortedBanners[index];
              final imageUrl = ApiConstants.getImageUrl(banner.imageUrl);
              return GestureDetector(
                onTap: () => widget.onBannerTap?.call(banner),
                child: imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => _buildPlaceholder(),
                        errorWidget: (context, url, error) =>
                            _buildPlaceholder(),
                      )
                    : _buildPlaceholder(),
              );
            },
          ),
          // Page indicators
          if (_sortedBanners.length > 1)
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _sortedBanners.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: _currentPage == index ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppColors.socaYellow
                          : Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: widget.height,
      color: AppColors.socaGrey,
      child: const Center(
        child: Icon(
          Icons.emoji_events,
          size: 60,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }
}
