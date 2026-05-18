import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/widgets/app_loader.dart';
import '../models/live_match_models.dart';
import '../providers/live_match_providers.dart';

// ─── Screen entry point ───────────────────────────────────────────────────────

class LiveMatchDetailsScreen extends ConsumerStatefulWidget {
  const LiveMatchDetailsScreen({
    super.key,
    required this.matchId,
    required this.tournamentId,
  });

  final String matchId;
  final String tournamentId;

  @override
  ConsumerState<LiveMatchDetailsScreen> createState() =>
      _LiveMatchDetailsScreenState();
}

class _LiveMatchDetailsScreenState
    extends ConsumerState<LiveMatchDetailsScreen> {
  _TabType _activeTab = _TabType.goals;
  Timer? _clockTimer;
  int _elapsedMinutes = 0;

  @override
  void initState() {
    super.initState();
    _clockTimer = Timer.periodic(
      const Duration(seconds: 60),
      (_) {
        if (mounted) setState(() => _elapsedMinutes++);
      },
    );
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    super.dispose();
  }

  void _selectTab(_TabType tab) => setState(() => _activeTab = tab);

  @override
  Widget build(BuildContext context) {
    final args = (widget.matchId, widget.tournamentId);
    final detailState = ref.watch(liveMatchDetailProvider(args));
    final user = ref.watch(currentUserProvider);
    final isReferee = user?.isReferee == true;

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        backgroundColor: AppColors.socaBlack,
        foregroundColor: Colors.white,
        title: const Text(
          'Live Match',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        actions: [
          if (isReferee)
            TextButton(
              onPressed: () => context.push(
                '/referee/match/${widget.matchId}/live-update',
                extra: {'matchId': widget.matchId, 'tournamentId': widget.tournamentId},
              ),
              child: const Text(
                'MANAGE',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: AppColors.socaYellow,
                ),
              ),
            ),
        ],
      ),
      body: detailState.isLoading && detailState.detail == null
          ? const AppLoader()
          : detailState.error != null && detailState.detail == null
              ? _ErrorView(
                  error: detailState.error!,
                  onRetry: () =>
                      ref.read(liveMatchDetailProvider(args).notifier).refresh(),
                )
              : detailState.detail != null
                  ? _DetailBody(
                      detail: detailState.detail!,
                      activeTab: _activeTab,
                      onTabSelected: _selectTab,
                      isReferee: isReferee,
                      onManageTap: () => context.push(
                        '/referee/match/${widget.matchId}/live-update',
                        extra: {'matchId': widget.matchId, 'tournamentId': widget.tournamentId},
                      ),
                    )
                  : const SizedBox.shrink(),
    );
  }
}

// ─── Tab enum ─────────────────────────────────────────────────────────────────

enum _TabType { goals, cards, substitutions, penalty }

// ─── Main body ────────────────────────────────────────────────────────────────

class _DetailBody extends StatelessWidget {
  const _DetailBody({
    required this.detail,
    required this.activeTab,
    required this.onTabSelected,
    required this.isReferee,
    required this.onManageTap,
  });

  final LiveMatchDetail detail;
  final _TabType activeTab;
  final ValueChanged<_TabType> onTabSelected;
  final bool isReferee;
  final VoidCallback onManageTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Score header card
        _ScoreHeader(detail: detail),

        // Tab bar
        _TabBar(
          activeTab: activeTab,
          hasPenalty: detail.hasPenalties,
          onSelected: onTabSelected,
        ),

        // Tab content
        Expanded(
          child: _TabContent(
            detail: detail,
            activeTab: activeTab,
          ),
        ),
      ],
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

    // Format match date/time
    String dateTimeStr = '';
    if (detail.matchDateTimeGmt != null) {
      final dt = DateTime.fromMillisecondsSinceEpoch(
          detail.matchDateTimeGmt! * 1000);
      final local = dt.toLocal();
      dateTimeStr =
          '${local.day.toString().padLeft(2, '0')}/${local.month.toString().padLeft(2, '0')}/${local.year} '
          '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
    }

    return Container(
      color: AppColors.socaBlack,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        children: [
          // Date/time
          if (dateTimeStr.isNotEmpty)
            Text(
              dateTimeStr,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                color: Colors.white54,
              ),
            ),

          const SizedBox(height: 12),

          // Teams + Score row
          Row(
            children: [
              // Home team
              Expanded(
                child: Column(
                  children: [
                    _TeamLogo(imageUrl: homeTeam?.imageUrl, size: 52),
                    const SizedBox(height: 6),
                    Text(
                      homeTeam?.teamName ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    if (homeTeam?.teamShortName?.isNotEmpty == true)
                      Text(
                        '(${homeTeam!.teamShortName})',
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 10,
                          color: Colors.white60,
                        ),
                      ),
                  ],
                ),
              ),

              // Score
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _ScoreDigit(score: detail.displayHomeGoals),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '—',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        _ScoreDigit(score: detail.displayAwayGoals),
                      ],
                    ),
                    // Penalty score (shown separately if applicable)
                    if (detail.hasPenalties)
                      Text(
                        'Pen: ${detail.myPenalty} — ${detail.opponentPenalty}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: AppColors.socaYellow,
                        ),
                      ),
                    const SizedBox(height: 4),
                    // Match state label
                    _MatchStateBadge(state: detail.state),
                  ],
                ),
              ),

              // Away team
              Expanded(
                child: Column(
                  children: [
                    _TeamLogo(imageUrl: awayTeam?.imageUrl, size: 52),
                    const SizedBox(height: 6),
                    Text(
                      awayTeam?.teamName ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    if (awayTeam?.teamShortName?.isNotEmpty == true)
                      Text(
                        '(${awayTeam!.teamShortName})',
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 10,
                          color: Colors.white60,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScoreDigit extends StatelessWidget {
  const _ScoreDigit({required this.score});
  final int score;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$score',
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w900,
        fontSize: 36,
        color: Colors.white,
      ),
    );
  }
}

class _MatchStateBadge extends StatelessWidget {
  const _MatchStateBadge({required this.state});
  final MatchState state;

  @override
  Widget build(BuildContext context) {
    final isLive = state.isLive;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: isLive ? Colors.red : Colors.white24,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        state.label.toUpperCase(),
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _TeamLogo extends StatelessWidget {
  const _TeamLogo({this.imageUrl, this.size = 52});
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
        border: Border.all(color: Colors.white24, width: 1),
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

// ─── Tab bar ──────────────────────────────────────────────────────────────────

class _TabBar extends StatelessWidget {
  const _TabBar({
    required this.activeTab,
    required this.hasPenalty,
    required this.onSelected,
  });

  final _TabType activeTab;
  final bool hasPenalty;
  final ValueChanged<_TabType> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.socaBlack,
      child: Row(
        children: [
          _TabButton(
            label: 'GOALS',
            isActive: activeTab == _TabType.goals,
            onTap: () => onSelected(_TabType.goals),
          ),
          _TabButton(
            label: 'CARDS',
            isActive: activeTab == _TabType.cards,
            onTap: () => onSelected(_TabType.cards),
          ),
          _TabButton(
            label: 'SUBS',
            isActive: activeTab == _TabType.substitutions,
            onTap: () => onSelected(_TabType.substitutions),
          ),
          if (hasPenalty)
            _TabButton(
              label: 'PENALTY',
              isActive: activeTab == _TabType.penalty,
              onTap: () => onSelected(_TabType.penalty),
            ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? AppColors.socaYellow : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 11,
              color: isActive ? AppColors.socaYellow : Colors.white60,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Tab content ──────────────────────────────────────────────────────────────

class _TabContent extends StatelessWidget {
  const _TabContent({required this.detail, required this.activeTab});

  final LiveMatchDetail detail;
  final _TabType activeTab;

  @override
  Widget build(BuildContext context) {
    switch (activeTab) {
      case _TabType.goals:
        return _GoalsTimeline(detail: detail);
      case _TabType.cards:
        return _CardsTimeline(detail: detail);
      case _TabType.substitutions:
        return _SubsTimeline(detail: detail);
      case _TabType.penalty:
        return _PenaltyTimeline(detail: detail);
    }
  }
}

// ─── Goals tab ────────────────────────────────────────────────────────────────

class _GoalsTimeline extends StatelessWidget {
  const _GoalsTimeline({required this.detail});
  final LiveMatchDetail detail;

  @override
  Widget build(BuildContext context) {
    final allGoals = [...detail.goals, ...detail.extraTimeGoals];
    // Non-missed goals only for sequence numbering, matching Android logic
    final myTeamId = detail.myTeam?.teamId ?? '';
    int mySeq = 0;
    int oppSeq = 0;

    final entries = allGoals.map((g) {
      final isHome = g.teamId == myTeamId;
      int seq = 0;
      if (!g.missed) {
        if (isHome) {
          mySeq++;
          seq = mySeq;
        } else {
          oppSeq++;
          seq = oppSeq;
        }
      }
      return _GoalEntry(goal: g, sequence: seq, isHome: isHome);
    }).toList();

    if (entries.isEmpty) {
      return const _EmptyTimeline(message: 'No goals recorded yet');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: entries.length,
      itemBuilder: (_, i) => entries[i],
    );
  }
}

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
    if (goal.ownGoal) label += ' (OG)';
    if (goal.missed) label = '$label (Penalty missed)';
    if (goal.assistPlayerName?.isNotEmpty == true && !goal.missed) {
      label += '\nAssist: ${goal.assistPlayerName}';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          if (isHome) ...[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        goal.missed
                            ? Icons.close
                            : Icons.sports_soccer,
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
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _MinuteBubble(minute: goal.goalTime, isHome: true),
            const Expanded(child: SizedBox()),
          ] else ...[
            const Expanded(child: SizedBox()),
            _MinuteBubble(minute: goal.goalTime, isHome: false),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          label,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 13,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      if (!goal.missed && sequence > 0)
                        _OrdinalChip(ordinal: ordinal),
                      const SizedBox(width: 4),
                      Icon(
                        goal.missed
                            ? Icons.close
                            : Icons.sports_soccer,
                        size: 16,
                        color: goal.missed ? Colors.red : AppColors.socaBlack,
                      ),
                    ],
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

// ─── Cards tab ────────────────────────────────────────────────────────────────

class _CardsTimeline extends StatelessWidget {
  const _CardsTimeline({required this.detail});
  final LiveMatchDetail detail;

  @override
  Widget build(BuildContext context) {
    final cards = detail.cards;
    if (cards.isEmpty) {
      return const _EmptyTimeline(message: 'No cards recorded yet');
    }
    final myTeamId = detail.myTeam?.teamId ?? '';

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: cards.length,
      itemBuilder: (_, i) {
        final card = cards[i];
        final isHome = card.teamId == myTeamId;
        return _CardEntry(card: card, isHome: isHome);
      },
    );
  }
}

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
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          if (isHome) ...[
            _CardIcon(color: _cardColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                card.playerName,
                style: const TextStyle(fontFamily: 'Lato', fontSize: 13),
              ),
            ),
            _MinuteBubble(minute: card.cardTime, isHome: true),
            const Expanded(child: SizedBox()),
          ] else ...[
            const Expanded(child: SizedBox()),
            _MinuteBubble(minute: card.cardTime, isHome: false),
            Expanded(
              child: Text(
                card.playerName,
                textAlign: TextAlign.end,
                style: const TextStyle(fontFamily: 'Lato', fontSize: 13),
              ),
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

// ─── Substitutions tab ────────────────────────────────────────────────────────

class _SubsTimeline extends StatelessWidget {
  const _SubsTimeline({required this.detail});
  final LiveMatchDetail detail;

  @override
  Widget build(BuildContext context) {
    final subs = detail.subs;
    if (subs.isEmpty) {
      return const _EmptyTimeline(message: 'No substitutions recorded yet');
    }
    final myTeamId = detail.myTeam?.teamId ?? '';

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: subs.length,
      itemBuilder: (_, i) {
        final sub = subs[i];
        final isHome = sub.teamId == myTeamId;
        return _SubEntry(sub: sub, isHome: isHome);
      },
    );
  }
}

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
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          if (isHome) ...[
            const Icon(Icons.swap_horiz, size: 16, color: Colors.green),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                inOut,
                style: const TextStyle(fontFamily: 'Lato', fontSize: 13),
              ),
            ),
            _MinuteBubble(minute: sub.subTime, isHome: true),
            const Expanded(child: SizedBox()),
          ] else ...[
            const Expanded(child: SizedBox()),
            _MinuteBubble(minute: sub.subTime, isHome: false),
            Expanded(
              child: Text(
                inOut,
                textAlign: TextAlign.end,
                style: const TextStyle(fontFamily: 'Lato', fontSize: 13),
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.swap_horiz, size: 16, color: Colors.green),
          ],
        ],
      ),
    );
  }
}

// ─── Penalty tab ──────────────────────────────────────────────────────────────

class _PenaltyTimeline extends StatelessWidget {
  const _PenaltyTimeline({required this.detail});
  final LiveMatchDetail detail;

  @override
  Widget build(BuildContext context) {
    final shots = detail.penaltyShots;
    if (shots.isEmpty) {
      return const _EmptyTimeline(message: 'No penalty data');
    }
    final myTeamId = detail.myTeam?.teamId ?? '';

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: shots.length,
      itemBuilder: (_, i) {
        final shot = shots[i];
        final isHome = shot.teamId == myTeamId;
        return _PenaltyEntry(shot: shot, isHome: isHome);
      },
    );
  }
}

class _PenaltyEntry extends StatelessWidget {
  const _PenaltyEntry({required this.shot, required this.isHome});
  final LivePenaltyEvent shot;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    final ordinal = _ordinal(shot.goalSequence);
    final label =
        '$ordinal penalty${shot.missed ? ' (Missed)' : ''}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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
              child: Text(
                '${shot.playerName}  $label',
                style: const TextStyle(fontFamily: 'Lato', fontSize: 13),
              ),
            ),
            const Expanded(child: SizedBox()),
          ] else ...[
            const Expanded(child: SizedBox()),
            Expanded(
              child: Text(
                '$label  ${shot.playerName}',
                textAlign: TextAlign.end,
                style: const TextStyle(fontFamily: 'Lato', fontSize: 13),
              ),
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
  const _MinuteBubble({required this.minute, required this.isHome});
  final int minute;
  final bool isHome;

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
        style: const TextStyle(
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

class _EmptyTimeline extends StatelessWidget {
  const _EmptyTimeline({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.hourglass_empty,
              size: 48, color: AppColors.textSecondary),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
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
            const Icon(Icons.error_outline,
                size: 48, color: AppColors.error),
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
              child: const Text('Retry',
                  style: TextStyle(fontFamily: 'Poppins')),
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
