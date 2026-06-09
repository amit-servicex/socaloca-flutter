import 'package:socaloca/core/constants/app_strings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/widgets/app_loader.dart';
import '../models/live_match_models.dart';
import '../providers/live_match_providers.dart';
import 'dart:developer';
// ─── Screen entry point ───────────────────────────────────────────────────────

class LiveMatchDetailsScreen extends ConsumerWidget {
  const LiveMatchDetailsScreen({
    super.key,
    required this.matchId,
    required this.tournamentId,
    this.preferMatchData = false,
  });

  final String matchId;
  final String tournamentId;
  final bool preferMatchData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = (matchId, tournamentId, preferMatchData);
    final detailState = ref.watch(liveMatchDetailProvider(args));
    final user = ref.watch(currentUserProvider);
    final isReferee = user?.isReferee == true;

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: detailState.isLoading && detailState.detail == null
          ? AppLoader()
          : detailState.error != null && detailState.detail == null
              ? _ErrorView(
                  error: detailState.error!,
                  onRetry: () => ref
                      .read(liveMatchDetailProvider(args).notifier)
                      .refresh(),
                )
              : detailState.detail != null
                  ? _DetailBody(
                      detail: detailState.detail!,
                      isReferee: isReferee,
                      onManageTap: () => context.push(
                        '/referee/match/$matchId/live-update',
                        extra: {
                          'matchId': matchId,
                          'tournamentId': tournamentId,
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
    );
  }
}

// ─── Main body ────────────────────────────────────────────────────────────────

class _DetailBody extends StatelessWidget {
  const _DetailBody({
    required this.detail,
    required this.isReferee,
    required this.onManageTap,
  });

  final LiveMatchDetail detail;
  final bool isReferee;
  final VoidCallback onManageTap;

  @override
  Widget build(BuildContext context) {
    // log("message")
    final myTeamId = detail.myTeam?.teamId ?? '';
    final homeTeamName = detail.myTeam?.teamName ?? '';
    final awayTeamName = detail.opponentTeam?.teamName ?? '';

    // Split goals by team (exclude missed)
    final allGoals = [...detail.goals, ...detail.extraTimeGoals];
    final homeGoals =
        allGoals.where((g) => g.teamId == myTeamId && !g.missed).toList();
    final awayGoals =
        allGoals.where((g) => g.teamId != myTeamId && !g.missed).toList();

    // Split cards, subs, penalties by team
    final homeCards = detail.cards.where((c) => c.teamId == myTeamId).toList();
    final awayCards = detail.cards.where((c) => c.teamId != myTeamId).toList();
    final homeSubs = detail.subs.where((s) => s.teamId == myTeamId).toList();
    final awaySubs = detail.subs.where((s) => s.teamId != myTeamId).toList();
    final homePens =
        detail.penaltyShots.where((p) => p.teamId == myTeamId).toList();
    final awayPens =
        detail.penaltyShots.where((p) => p.teamId != myTeamId).toList();

    final myPlayers = detail.myTeamPlayers;
    final oppPlayers = detail.opponentTeamPlayers;
    final hasLineup = myPlayers.isNotEmpty || oppPlayers.isNotEmpty;
    return CustomScrollView(
      slivers: [
        // ── Banner ────────────────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            child: Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.grey[300]!, Colors.grey[400]!],
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/tournament_defalut_banner.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                // Back button overlay
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ),
                // Referee MANAGE button
                if (isReferee)
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: onManageTap,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.socaBlack,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              AppStrings.manage.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: AppColors.socaYellow,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        // ── Score header ──────────────────────────────────────────────────────
        SliverToBoxAdapter(child: _ScoreHeader(detail: detail)),

        // ── GOALS section ─────────────────────────────────────────────────────
        SliverToBoxAdapter(
            child: _SectionChip(label: AppStrings.goals.toUpperCase())),
        SliverToBoxAdapter(
          child: _TwoColumnPanel(
            homeTeamName: homeTeamName,
            awayTeamName: awayTeamName,
            homeItems:
                homeGoals.map((g) => _ColItem(text: g.playerName)).toList(),
            awayItems:
                awayGoals.map((g) => _ColItem(text: g.playerName)).toList(),
          ),
        ),

        // ── CARDS section (only when present) ────────────────────────────────
        if (detail.cards.isNotEmpty) ...[
          SliverToBoxAdapter(
              child: _SectionChip(label: AppStrings.cards.toUpperCase())),
          SliverToBoxAdapter(
            child: _TwoColumnPanel(
              homeTeamName: homeTeamName,
              awayTeamName: awayTeamName,
              homeItems: homeCards.map((c) => _ColCardItem(card: c)).toList(),
              awayItems: awayCards.map((c) => _ColCardItem(card: c)).toList(),
            ),
          ),
        ],

        // ── SUBSTITUTIONS section (only when present) ─────────────────────────
        if (detail.subs.isNotEmpty) ...[
          SliverToBoxAdapter(
              child:
                  _SectionChip(label: AppStrings.substitutions.toUpperCase())),
          SliverToBoxAdapter(
            child: _TwoColumnPanel(
              homeTeamName: homeTeamName,
              awayTeamName: awayTeamName,
              homeItems: homeSubs.map((s) => _ColSubItem(sub: s)).toList(),
              awayItems: awaySubs.map((s) => _ColSubItem(sub: s)).toList(),
            ),
          ),
        ],

        // ── PENALTY section (only when present) ───────────────────────────────
        if (detail.hasPenalties) ...[
          SliverToBoxAdapter(
              child: _SectionChip(
                  label: AppStrings.penaltyShootout.toUpperCase())),
          SliverToBoxAdapter(
            child: _TwoColumnPanel(
              homeTeamName: homeTeamName,
              awayTeamName: awayTeamName,
              homeItems: homePens
                  .map((p) => _ColItem(
                      text:
                          '${p.playerName}${p.missed ? ' (${AppStrings.missed})' : ''}'))
                  .toList(),
              awayItems: awayPens
                  .map((p) => _ColItem(
                      text:
                          '${p.playerName}${p.missed ? ' (${AppStrings.missed})' : ''}'))
                  .toList(),
            ),
          ),
        ],

        // ── LINE UP section ───────────────────────────────────────────────────
        if (hasLineup) ...[
          SliverToBoxAdapter(
              child: _SectionChip(label: AppStrings.lineUp.toUpperCase())),
          if (myPlayers.isNotEmpty)
            ..._groupedTeamSlivers(myPlayers, detail.myTeam, detail),
          if (oppPlayers.isNotEmpty)
            ..._groupedTeamSlivers(oppPlayers, detail.opponentTeam, detail),
        ],

        const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
      ],
    );
  }

  /// Builds team sub-header + position-grouped player rows as slivers.
  List<Widget> _groupedTeamSlivers(
      List<MatchPlayer> players, LiveMatchTeam? team, LiveMatchDetail detail) {
    const posOrder = ['Goalkeeper', 'Defender', 'Midfield', 'Attack'];
    final grouped = <String, List<MatchPlayer>>{};
    for (final p in players) {
      final pos =
          p.playPosition?.isNotEmpty == true ? p.playPosition! : 'Unknown';
      grouped.putIfAbsent(pos, () => []).add(p);
    }

    final slivers = <Widget>[
      SliverToBoxAdapter(child: _TeamSubHeader(team: team)),
    ];

    final sortedKeys = [
      ...posOrder.where(grouped.containsKey),
      ...grouped.keys.where((k) => !posOrder.contains(k)),
    ];

    for (final pos in sortedKeys) {
      final posPlayers = grouped[pos]!;
      slivers.add(SliverToBoxAdapter(
        child: _PositionGroupHeader(label: _posLabel(pos)),
      ));
      slivers.add(SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, i) {
            final p = posPlayers[i];
            final jersey = detail.playerJerseyNo(p.userId, team?.teamId ?? '');
            return _PlayerRow(player: p, jerseyNo: jersey);
          },
          childCount: posPlayers.length,
        ),
      ));
    }

    return slivers;
  }
}

// ─── Section header ───────────────────────────────────────────────────────────

// ─── Section chip (pill-style header matching design image) ──────────────────

class _SectionChip extends StatelessWidget {
  const _SectionChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.socaBlack,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: AppColors.socaYellow,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}

// ─── Two-column panel (home | away) ──────────────────────────────────────────

class _TwoColumnPanel extends StatelessWidget {
  const _TwoColumnPanel({
    required this.homeTeamName,
    required this.awayTeamName,
    required this.homeItems,
    required this.awayItems,
  });

  final String homeTeamName;
  final String awayTeamName;
  final List<Widget> homeItems;
  final List<Widget> awayItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Home column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homeTeamName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (homeItems.isEmpty)
                    const Text('—',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 13,
                            color: AppColors.textSecondary))
                  else
                    ...homeItems,
                ],
              ),
            ),
            // Vertical divider
            Container(
              width: 1,
              color: Colors.grey[300],
              margin: const EdgeInsets.symmetric(horizontal: 12),
            ),
            // Away column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    awayTeamName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (awayItems.isEmpty)
                    const Text('—',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 13,
                            color: AppColors.textSecondary))
                  else
                    ...awayItems,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Column item widgets ──────────────────────────────────────────────────────

class _ColItem extends StatelessWidget {
  const _ColItem({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Lato',
          fontSize: 13,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }
}

class _ColCardItem extends StatelessWidget {
  const _ColCardItem({required this.card});
  final LiveCardEvent card;

  Color get _color {
    if (card.redCard) return Colors.red;
    if (card.secondYellowCard) return Colors.orange;
    return Colors.yellow.shade700;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 14,
            margin: const EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Text(
              card.playerName,
              style: const TextStyle(
                  fontFamily: 'Lato', fontSize: 13, color: AppColors.socaBlack),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColSubItem extends StatelessWidget {
  const _ColSubItem({required this.sub});
  final LiveSubEvent sub;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '▲ ${sub.playerName}',
            style: const TextStyle(
                fontFamily: 'Lato', fontSize: 13, color: Colors.green),
          ),
          if (sub.playerOutName?.isNotEmpty == true)
            Text(
              '▼ ${sub.playerOutName}',
              style: const TextStyle(
                  fontFamily: 'Lato', fontSize: 13, color: Colors.red),
            ),
        ],
      ),
    );
  }
}

// ─── Team sub-header (inside LINE UP) ────────────────────────────────────────

class _TeamSubHeader extends StatelessWidget {
  const _TeamSubHeader({required this.team});
  final LiveMatchTeam? team;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: AppColors.socaGrey,
      child: Row(
        children: [
          _TeamLogo(imageUrl: team?.imageUrl, size: 32),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  team?.teamName ?? '',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: AppColors.socaBlack,
                  ),
                ),
                if (team?.teamShortName?.isNotEmpty == true)
                  Text(
                    team!.teamShortName!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Position group header ────────────────────────────────────────────────────

class _PositionGroupHeader extends StatelessWidget {
  const _PositionGroupHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }
}

// ─── Player row ───────────────────────────────────────────────────────────────

class _PlayerRow extends StatelessWidget {
  const _PlayerRow({required this.player, this.jerseyNo});
  final MatchPlayer player;
  final String? jerseyNo;

  @override
  Widget build(BuildContext context) {
    final positionLine = [
      player.playPositionType ?? player.playPosition,
      player.nationality?.isNotEmpty == true ? player.nationality : null,
    ].whereType<String>().where((s) => s.isNotEmpty).join(' • ');

    return Container(
      // color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[100]!, width: 0.8),
        ),
      ),
      child: Row(
        children: [
          // Jersey number — plain, left-aligned
          SizedBox(
            width: 28,
            child: Text(
              jerseyNo?.isNotEmpty == true ? jerseyNo! : '',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Circular avatar
          _PlayerAvatar(imageUrl: player.imageUrl, size: 46),
          const SizedBox(width: 12),
          // Name + position • nationality
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.fullName.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: AppColors.socaBlack,
                  ),
                ),
                if (positionLine.isNotEmpty)
                  Text(
                    positionLine,
                    style: const TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Player avatar ────────────────────────────────────────────────────────────

class _PlayerAvatar extends StatelessWidget {
  const _PlayerAvatar({this.imageUrl, this.size = 46});
  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl != null && imageUrl!.isNotEmpty
        ? ApiConstants.getImageUrl(imageUrl)
        : '';
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: ClipOval(
        child: url.isNotEmpty
            ? Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(Icons.person,
                    size: size * 0.6, color: Colors.grey[400]),
              )
            : Icon(Icons.person, size: size * 0.6, color: Colors.grey[400]),
      ),
    );
  }
}

// ─── Position label helper ────────────────────────────────────────────────────

String _posLabel(String pos) {
  final labels = {
    'Goalkeeper': AppStrings.goalkeepers,
    'Defender': AppStrings.defenders,
    'Midfield': AppStrings.midfielders,
    'Attack': AppStrings.attackers,
  };
  return labels[pos] ?? pos;
}

// ─── Empty note ───────────────────────────────────────────────────────────────

class _EmptyNote extends StatelessWidget {
  const _EmptyNote({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Text(
        message,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

// ─── Score header ─────────────────────────────────────────────────────────────

class _ScoreHeader extends StatelessWidget {
  const _ScoreHeader({required this.detail});
  final LiveMatchDetail detail;

  @override
  Widget build(BuildContext context) {
    final homeTeam = detail.myTeam;
    final awayTeam = detail.opponentTeam;
    final myTeamId = detail.myTeam?.teamId ?? '';

    // All non-missed goals (regular + extra time), split by team
    final allGoals = [...detail.goals, ...detail.extraTimeGoals];
    final homeGoals =
        allGoals.where((g) => g.teamId == myTeamId && !g.missed).toList();
    final awayGoals =
        allGoals.where((g) => g.teamId != myTeamId && !g.missed).toList();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Column(
        children: [
          // ── Logos + Score ──────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Home team logo + name
              Expanded(
                child: Column(
                  children: [
                    _TeamLogo(imageUrl: homeTeam?.imageUrl, size: 80),
                    const SizedBox(height: 8),
                    Text(
                      homeTeam?.teamName ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
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
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${detail.displayHomeGoals}',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w900,
                            fontSize: 40,
                            color: AppColors.socaBlack,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            ':',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900,
                              fontSize: 40,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ),
                        Text(
                          '${detail.displayAwayGoals}',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w900,
                            fontSize: 40,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ],
                    ),
                    if (detail.hasPenalties)
                      Text(
                        '${AppStrings.penShort}: ${detail.myPenalty} - ${detail.opponentPenalty}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: AppColors.socaYellow,
                        ),
                      ),
                    Text(
                      detail.state.label.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ],
                ),
              ),

              // Away team logo + name
              Expanded(
                child: Column(
                  children: [
                    _TeamLogo(imageUrl: awayTeam?.imageUrl, size: 80),
                    const SizedBox(height: 8),
                    Text(
                      awayTeam?.teamName ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
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

          // ── Goal summary (home left, away right) ─────────────
          if (homeGoals.isNotEmpty || awayGoals.isNotEmpty) ...[
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Home goals
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: homeGoals
                        .map((g) => Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text(
                                "${g.playerName} '${g.goalTime}",
                                style: const TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: AppColors.socaBlack,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                // Away goals
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: awayGoals
                        .map((g) => Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text(
                                "${g.playerName} '${g.goalTime}",
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: AppColors.socaBlack,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _TeamLogo extends StatelessWidget {
  const _TeamLogo({this.imageUrl, this.size = 80});
  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl != null && imageUrl!.isNotEmpty
        ? ApiConstants.getImageUrl(imageUrl)
        : '';
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white12,
        border: Border.all(color: AppColors.socaBlack, width: 2),
      ),
      child: url.isNotEmpty
          ? ClipOval(
              child: Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.sports_soccer,
                  color: Colors.white54,
                  size: 24,
                ),
              ),
            )
          : const Icon(Icons.sports_soccer, color: Colors.white54, size: 24),
    );
  }
}

// ─── Goal event row ───────────────────────────────────────────────────────────

class _GoalEntry extends StatelessWidget {
  const _GoalEntry({
    required this.goal,
    required this.sequence,
    required this.isHome,
  });

  final LiveGoalEvent goal;
  final int sequence;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    final ordinal = _ordinal(sequence);
    String label = goal.playerName;
    if (goal.ownGoal) label += ' (${AppStrings.ogShort})';
    if (goal.missed) label = '$label (${AppStrings.penaltyMissed})';
    if (goal.assistPlayerName?.isNotEmpty == true && !goal.missed) {
      label += '\n${AppStrings.assist}: ${goal.assistPlayerName}';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        children: [
          if (isHome) ...[
            Expanded(
              child: Row(
                children: [
                  Icon(
                    goal.missed ? Icons.close : Icons.sports_soccer,
                    size: 16,
                    color: goal.missed ? Colors.red : AppColors.socaBlack,
                  ),
                  const SizedBox(width: 4),
                  if (!goal.missed && sequence > 0)
                    _OrdinalChip(ordinal: ordinal),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      label,
                      style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 13,
                          color: AppColors.socaBlack),
                    ),
                  ),
                ],
              ),
            ),
            _MinuteBubble(minute: goal.goalTime),
            const Expanded(child: SizedBox()),
          ] else ...[
            const Expanded(child: SizedBox()),
            _MinuteBubble(minute: goal.goalTime),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      label,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 13,
                          color: AppColors.socaBlack),
                    ),
                  ),
                  const SizedBox(width: 4),
                  if (!goal.missed && sequence > 0)
                    _OrdinalChip(ordinal: ordinal),
                  const SizedBox(width: 4),
                  Icon(
                    goal.missed ? Icons.close : Icons.sports_soccer,
                    size: 16,
                    color: goal.missed ? Colors.red : AppColors.socaBlack,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Card event row ───────────────────────────────────────────────────────────

class _CardEntry extends StatelessWidget {
  const _CardEntry({required this.card, required this.isHome});
  final LiveCardEvent card;
  final bool isHome;

  Color get _cardColor {
    if (card.redCard) return Colors.red;
    if (card.secondYellowCard) return Colors.orange;
    return Colors.yellow.shade700;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        children: [
          if (isHome) ...[
            _CardIcon(color: _cardColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(card.playerName,
                  style: const TextStyle(fontFamily: 'Lato', fontSize: 13)),
            ),
            _MinuteBubble(minute: card.cardTime),
            const Expanded(child: SizedBox()),
          ] else ...[
            const Expanded(child: SizedBox()),
            _MinuteBubble(minute: card.cardTime),
            Expanded(
              child: Text(card.playerName,
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontFamily: 'Lato', fontSize: 13)),
            ),
            const SizedBox(width: 8),
            _CardIcon(color: _cardColor),
          ],
        ],
      ),
    );
  }
}

class _CardIcon extends StatelessWidget {
  const _CardIcon({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

// ─── Substitution event row ───────────────────────────────────────────────────

class _SubEntry extends StatelessWidget {
  const _SubEntry({required this.sub, required this.isHome});
  final LiveSubEvent sub;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    final inOut = sub.playerOutName?.isNotEmpty == true
        ? '▲ ${sub.playerName}  ▼ ${sub.playerOutName}'
        : '▲ ${sub.playerName}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        children: [
          if (isHome) ...[
            const Icon(Icons.swap_horiz, size: 16, color: Colors.green),
            const SizedBox(width: 6),
            Expanded(
              child: Text(inOut,
                  style: const TextStyle(fontFamily: 'Lato', fontSize: 13)),
            ),
            _MinuteBubble(minute: sub.subTime),
            const Expanded(child: SizedBox()),
          ] else ...[
            const Expanded(child: SizedBox()),
            _MinuteBubble(minute: sub.subTime),
            Expanded(
              child: Text(inOut,
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontFamily: 'Lato', fontSize: 13)),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.swap_horiz, size: 16, color: Colors.green),
          ],
        ],
      ),
    );
  }
}

// ─── Penalty event row ────────────────────────────────────────────────────────

class _PenaltyEntry extends StatelessWidget {
  const _PenaltyEntry({required this.shot, required this.isHome});
  final LivePenaltyEvent shot;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    final ordinal = _ordinal(shot.goalSequence);
    final label =
        '$ordinal ${AppStrings.penalty}${shot.missed ? ' (${AppStrings.missed})' : ''}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        children: [
          if (isHome) ...[
            Icon(
              shot.missed ? Icons.close : Icons.check_circle,
              size: 18,
              color: shot.missed ? Colors.red : Colors.green,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text('${shot.playerName}  $label',
                  style: const TextStyle(fontFamily: 'Lato', fontSize: 13)),
            ),
            const Expanded(child: SizedBox()),
          ] else ...[
            const Expanded(child: SizedBox()),
            Expanded(
              child: Text('$label  ${shot.playerName}',
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontFamily: 'Lato', fontSize: 13)),
            ),
            const SizedBox(width: 6),
            Icon(
              shot.missed ? Icons.close : Icons.check_circle,
              size: 18,
              color: shot.missed ? Colors.red : Colors.green,
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Shared timeline widgets ──────────────────────────────────────────────────

class _MinuteBubble extends StatelessWidget {
  const _MinuteBubble({required this.minute});
  final int minute;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.socaBlack,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "$minute'",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 11,
          color: AppColors.socaYellow,
        ),
      ),
    );
  }
}

class _OrdinalChip extends StatelessWidget {
  const _OrdinalChip({required this.ordinal});
  final String ordinal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: AppColors.socaGrey,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        ordinal,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }
}

// ─── Error view ───────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error, required this.onRetry});
  final String error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 12),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                foregroundColor: AppColors.socaYellow,
              ),
              child: Text('Retry'.tr,
                  style: const TextStyle(fontFamily: 'Poppins')),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Ordinal helper ───────────────────────────────────────────────────────────

String _ordinal(int n) {
  if (n <= 0) return '';
  final suffix = (n % 100 >= 11 && n % 100 <= 13)
      ? 'th'
      : ['th', 'st', 'nd', 'rd', 'th', 'th', 'th', 'th', 'th', 'th'][n % 10];
  return '$n$suffix';
}
