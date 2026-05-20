import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_loader.dart';
import '../../../shared/widgets/searchable_dropdown.dart';
import '../models/live_match_models.dart';
import '../providers/live_match_providers.dart';

class PlayerLiveMatchListScreen extends ConsumerStatefulWidget {
  PlayerLiveMatchListScreen({super.key});

  @override
  ConsumerState<PlayerLiveMatchListScreen> createState() =>
      _PlayerLiveMatchListScreenState();
}

class _PlayerLiveMatchListScreenState
    extends ConsumerState<PlayerLiveMatchListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(liveMatchTournamentDropdownProvider);
      ref.invalidate(liveMatchCountryDropdownProvider);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      ref.read(playerLiveMatchProvider.notifier).loadMore();
    }
  }

  void _onTournamentChanged(String? id) {
    ref.read(playerLiveSelectedTournamentProvider.notifier).state = id;
    ref.read(playerLiveMatchProvider.notifier).load(
          tournamentId: id,
          country: ref.read(playerLiveSelectedCountryProvider),
        );
  }

  void _onCountryChanged(String? country) {
    ref.read(playerLiveSelectedCountryProvider.notifier).state = country;
    ref.read(playerLiveMatchProvider.notifier).load(
          tournamentId: ref.read(playerLiveSelectedTournamentProvider),
          country: country,
        );
  }

  @override
  Widget build(BuildContext context) {
    final matchState = ref.watch(playerLiveMatchProvider);
    final tournamentAsync = ref.watch(liveMatchTournamentDropdownProvider);
    final countryAsync = ref.watch(liveMatchCountryDropdownProvider);
    final selectedTmnt = ref.watch(playerLiveSelectedTournamentProvider);
    final selectedCountry = ref.watch(playerLiveSelectedCountryProvider);

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            // width: 250,
            decoration: BoxDecoration(color: AppColors.socaBlack),
            child: Text(
              'Live Matches'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.socaYellow,
              ),
            ),
          ),
          // ── Filter row ─────────────────────────────────────────────────────
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                // Tournament dropdown
                Expanded(
                  child: tournamentAsync.when(
                    data: (items) => SearchableDropdownButton(
                      hint: 'All Tournaments'.tr,
                      value: selectedTmnt ?? '',
                      items: ['All Tournaments'.tr, ...items.map((t) => (t['tournamentName'] as String?) ?? '')],
                      values: ['', ...items.map((t) => (t['tournamentId'] as String?) ?? '')],
                      onChanged: (v) => _onTournamentChanged(v == null || v.isEmpty ? null : v),
                      height: 36,
                      fontSize: 12,
                    ),
                    loading: () => SizedBox(
                      height: 36,
                      child: Center(
                          child: SizedBox(
                              width: 16,
                              height: 16,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2))),
                    ),
                    error: (_, __) => SizedBox.shrink(),
                  ),
                ),
                SizedBox(width: 8),
                // Country dropdown
                Expanded(
                  child: countryAsync.when(
                    data: (countries) => SearchableDropdownButton(
                      hint: 'All Countries'.tr,
                      value: selectedCountry ?? '',
                      items: ['All Countries'.tr, ...countries],
                      values: ['', ...countries],
                      onChanged: (v) => _onCountryChanged(v == null || v.isEmpty ? null : v),
                    ),
                    loading: () => SizedBox.shrink(),
                    error: (_, __) => SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),

          // ── Match list ─────────────────────────────────────────────────────
          Expanded(
            child: matchState.isLoading && matchState.matches.isEmpty
                ? AppLoader()
                : matchState.error != null && matchState.matches.isEmpty
                    ? _ErrorState(
                        onRetry: () =>
                            ref.read(playerLiveMatchProvider.notifier).load(),
                      )
                    : matchState.matches.isEmpty
                        ? _EmptyState()
                        : ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.all(12),
                            itemCount: matchState.matches.length +
                                (matchState.isLoadingMore ? 1 : 0),
                            itemBuilder: (ctx, i) {
                              if (i == matchState.matches.length) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                              final item = matchState.matches[i];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (item.uniqueTournamentId &&
                                      item.tournamentName?.isNotEmpty == true)
                                    _TournamentHeader(
                                      name: item.tournamentName!,
                                      logoUrl: item.tournamentLogoUrl,
                                      country: item.tournamentCountry,
                                    ),
                                  _LiveMatchCard(
                                    item: item,
                                    onTap: () => context.push(
                                      AppRoutes.liveMatchDetails.replaceFirst(
                                          ':matchId', item.matchId),
                                      extra: {
                                        'tournamentId': item.tournamentId,
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}

// ─── Tournament section header ────────────────────────────────────────────────

class _TournamentHeader extends StatelessWidget {
  _TournamentHeader({
    required this.name,
    this.logoUrl,
    this.country,
  });
  final String name;
  final String? logoUrl;
  final String? country;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 4),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.socaBlack,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            if (logoUrl != null && logoUrl!.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.network(
                  ApiConstants.getImageUrl(logoUrl!),
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => SizedBox(width: 24, height: 24),
                ),
              ),
              SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.socaYellow,
                ),
              ),
            ),
            if (country != null && country!.isNotEmpty)
              Text(
                country!,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 11,
                  color: Colors.white60,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── Match card ───────────────────────────────────────────────────────────────

class _LiveMatchCard extends StatelessWidget {
  _LiveMatchCard({required this.item, required this.onTap});

  final LiveMatchListItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasScore = item.homeGoals > 0 || item.awayGoals > 0;
    final state = item.state ?? MatchState.unknown;

    // Format match date
    String dateStr = '';
    if (item.matchDateTimeGmt != null) {
      final dt =
          DateTime.fromMillisecondsSinceEpoch(item.matchDateTimeGmt! * 1000)
              .toLocal();
      dateStr = DateFormat('d MMM yyyy, HH:mm').format(dt);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: state.isLive ? Colors.red.shade400 : AppColors.border,
            width: state.isLive ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Column(
            children: [
              // Live badge + date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (state.isLive) _LivePulseBadge(stateLabel: state.label),
                  if (!state.isLive)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.socaGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        state.label,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: AppColors.socaBlack),
                      ),
                    ),
                  if (dateStr.isNotEmpty)
                    Text(
                      dateStr,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          color: AppColors.textSecondary),
                    ),
                ],
              ),
              SizedBox(height: 12),

              // Teams + score
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Home team
                  Expanded(
                    child: Column(
                      children: [
                        _SmallTeamLogo(imageUrl: item.homeTeam?.imageUrl),
                        SizedBox(height: 4),
                        Text(
                          item.homeTeam?.teamName ?? '',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Score
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      hasScore
                          ? '${item.homeGoals}  —  ${item.awayGoals}'
                          : 'vs',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        fontSize: hasScore ? 22 : 16,
                        color: state.isLive ? Colors.red : AppColors.socaBlack,
                      ),
                    ),
                  ),

                  // Away team
                  Expanded(
                    child: Column(
                      children: [
                        _SmallTeamLogo(imageUrl: item.awayTeam?.imageUrl),
                        SizedBox(height: 4),
                        Text(
                          item.awayTeam?.teamName ?? '',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmallTeamLogo extends StatelessWidget {
  _SmallTeamLogo({this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl != null && imageUrl!.isNotEmpty
        ? ApiConstants.getImageUrl(imageUrl)
        : '';
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.socaGrey,
        border: Border.all(color: AppColors.border),
      ),
      child: url.isNotEmpty
          ? ClipOval(
              child: Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.sports_soccer,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ),
            )
          : Icon(Icons.sports_soccer, size: 20, color: AppColors.textSecondary),
    );
  }
}

// ─── Animated live badge ──────────────────────────────────────────────────────

class _LivePulseBadge extends StatefulWidget {
  _LivePulseBadge({required this.stateLabel});
  final String stateLabel;

  @override
  State<_LivePulseBadge> createState() => _LivePulseBadgeState();
}

class _LivePulseBadgeState extends State<_LivePulseBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.4, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.circle, size: 7, color: Colors.white),
            SizedBox(width: 4),
            Text(
              'LIVE · ${widget.stateLabel}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Empty / error states ─────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.live_tv_outlined,
              size: 56, color: AppColors.textSecondary),
          SizedBox(height: 12),
          Text(
            'No live matches right now'.tr,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Matches update automatically every minute'.tr,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  _ErrorState({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: AppColors.error),
          SizedBox(height: 12),
          Text(
            'Failed to load live matches'.tr,
            style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.socaBlack,
              foregroundColor: AppColors.socaYellow,
            ),
            child: Text('Retry'.tr, style: TextStyle(fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }
}
