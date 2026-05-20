import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/cup_models.dart';
import '../../providers/cup_providers.dart';
import 'cup_info_details_screen.dart';
import 'widgets/cup_knockout_bracket_view.dart';
import 'widgets/cup_stats_bottom_sheet.dart';

/// Cup Tournament Details Screen
/// Shows banner, "VIEW TOURNAMENT DETAILS" bar, and dynamic round tabs.
/// Each round tab loads getCupKnockMatches for that roundId.
class CupTournamentDetailsScreen extends ConsumerStatefulWidget {
  final String tournamentId;

  const CupTournamentDetailsScreen({
    super.key,
    required this.tournamentId,
  });

  @override
  ConsumerState<CupTournamentDetailsScreen> createState() =>
      _CupTournamentDetailsScreenState();
}

class _CupTournamentDetailsScreenState
    extends ConsumerState<CupTournamentDetailsScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  void _ensureTabController(int count) {
    if (count < 1) count = 1;
    if (_tabController != null && _tabController!.length == count) return;
    _tabController?.dispose();
    _tabController = TabController(length: count, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cupAsync = ref.watch(cupReadyOrDetailsProvider(widget.tournamentId));

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      // appBar: AppBar(
      //   title: Text(
      //     'Cup Tournament'.tr,
      //     style: const TextStyle(
      //       fontFamily: 'Poppins',
      //       fontWeight: FontWeight.w700,
      //       fontSize: 18,
      //       color: AppColors.socaBlack,
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: AppColors.socaBlack),
      //     onPressed: () => context.pop(),
      //   ),
      // ),

      body: cupAsync.when(
        data: (cup) {
          if (cup == null) {
            return Center(child: Text('Cup tournament not found'.tr));
          }
          return _buildContent(cup);
        },
        loading: () => const AppLoader(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading cup: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(cupDetailsProvider(widget.tournamentId));
                  ref.invalidate(cupReadyDetailProvider(widget.tournamentId));
                  ref.invalidate(
                      cupReadyOrDetailsProvider(widget.tournamentId));
                },
                child: Text('Retry'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(TournamentCupModel cup) {
    final rounds = cup.roundsList ?? [];
    _ensureTabController(rounds.isEmpty ? 1 : rounds.length);

    return Column(
      // mainAxisAlignment: MainAxisAlignment.end
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Banner
        if (cup.banners != null && cup.banners!.isNotEmpty) ...[
          _buildBanner(cup.banners!.first),
        ] else ...[
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                // Banner Image (placeholder for now)
                Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey[300]!,
                          Colors.grey[400]!,
                        ],
                      ),
                    ),
                    child: Image.asset(
                        "assets/images/tournament_defalut_banner.jpg",
                        fit: BoxFit.cover)),
              ],
            ),
          )
        ],
        // "VIEW TOURNAMENT DETAILS" bar
        _buildDetailsBar(cup),

        // TabBar
        if (rounds.isNotEmpty)
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController!,
              isScrollable: rounds.length > 3,
              labelColor: AppColors.socaBlack,
              unselectedLabelColor: AppColors.socaBlack.withValues(alpha: 0.45),
              indicatorColor: AppColors.socaBlack,
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
              tabs: rounds.map((r) {
                final label = r.roundName?.isNotEmpty == true
                    ? r.roundName!
                    : 'Round ${r.seq ?? ''}';
                return Tab(text: label.toUpperCase());
              }).toList(),
            ),
          ),
        // STATS button
        if (rounds.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 4),
            child: SizedBox(
              width: 90,
              child: ElevatedButton(
                child: Text(
                  'STATS'.tr,
                  style: const TextStyle(
                    color: AppColors.socaYellow,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                onPressed: () => _showStatsSheet(cup),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.socaBlack,
                  side:
                      const BorderSide(color: AppColors.socaBlack, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),

        // Tab content
        Expanded(
          child: rounds.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.emoji_events_outlined,
                          size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No rounds available'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              : TabBarView(
                  controller: _tabController!,
                  children: rounds.map((round) {
                    return CupKnockoutBracketView(
                      tournamentId: widget.tournamentId,
                      roundId: round.roundId ?? '',
                      cup: cup,
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }

  Widget _buildBanner(CupBannerModel banner) {
    final imageUrl = ApiConstants.getImageUrl(banner.imageUrl);
    if (imageUrl.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      width: double.infinity,
      height: 180,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey[200],
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: Icon(Icons.image_not_supported,
              size: 48, color: Colors.grey[400]),
        ),
      ),
    );
  }

  Widget _buildDetailsBar(TournamentCupModel cup) {
    return GestureDetector(
      onTap: () => _openInfoDetails(),
      child: Container(
        color: AppColors.socaBlack,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'VIEW TOURNAMENT DETAILS',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.socaYellow,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            IconButton(
              icon: Image.asset(
                "assets/icons/ic_info.png",
                width: 24,
                height: 24,
              ),
              onPressed: _openInfoDetails,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }

  void _showStatsSheet(TournamentCupModel cup) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => CupStatsBottomSheet(
        tournamentId: widget.tournamentId,
        cup: cup,
      ),
    );
  }

  void _openInfoDetails() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CupInfoDetailsScreen(
          tournamentId: widget.tournamentId,
        ),
      ),
    );
  }
}
