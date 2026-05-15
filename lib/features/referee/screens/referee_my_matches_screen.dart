import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/referee_match_model.dart';
import '../providers/referee_providers.dart';
import '../widgets/referee_shared_widgets.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class RefereeMyMatchesScreen extends ConsumerStatefulWidget {
  const RefereeMyMatchesScreen({super.key});

  @override
  ConsumerState<RefereeMyMatchesScreen> createState() =>
      _RefereeMyMatchesScreenState();
}

class _RefereeMyMatchesScreenState
    extends ConsumerState<RefereeMyMatchesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(refereeMatchesProvider.notifier).load();
      ref.invalidate(refereeTournamentDropdownProvider);
    });
  }

  void _onTournamentChanged(String? tournamentId) {
    ref.read(refereeSelectedTmntMatchesProvider.notifier).state = tournamentId;
    ref.read(refereeMatchesProvider.notifier).load(
          tournamentId: tournamentId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final matchesState = ref.watch(refereeMatchesProvider);
    final dropdownAsync = ref.watch(refereeTournamentDropdownProvider);
    final selectedTmnt = ref.watch(refereeSelectedTmntMatchesProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: dropdownAsync.when(
            data: (items) => RefereeTournamentDropdown(
              items: items,
              selectedId: selectedTmnt,
              onChanged: _onTournamentChanged,
            ),
            loading: () => const RefereeDropdownLoading(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ),
        Expanded(
          child: matchesState.when(
            loading: () => const AppLoader(),
            error: (e, _) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      size: 48, color: AppColors.error),
                  const SizedBox(height: 12),
                  Text(e.toString(),
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontFamily: 'Poppins', fontSize: 13)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(refereeMatchesProvider.notifier).load(
                              tournamentId: selectedTmnt,
                            ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.socaBlack,
                        foregroundColor: AppColors.socaYellow),
                    child: const Text('Retry',
                        style: TextStyle(fontFamily: 'Poppins')),
                  ),
                ],
              ),
            ),
            data: (matches) => matches.isEmpty
                ? const RefereeEmptyState(
                    message: 'No accepted matches yet',
                    icon: Icons.sports_soccer_outlined,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: matches.length,
                    itemBuilder: (ctx, i) => _MatchCard(
                      match: matches[i],
                      onTap: () => context.push(
                        '/referee/match/${matches[i].matchId}/manage',
                        extra: matches[i],
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _MatchCard extends StatelessWidget {
  const _MatchCard({required this.match, required this.onTap});

  final RefereeMatchModel match;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isLive = match.matchStatus == 'live';
    final isCompleted = match.matchStatus == 'completed';
    final scoreSubmitted = match.scoreStatus == '1';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isLive ? AppColors.socaYellow : const Color(0xFFE0E0E0),
            width: isLive ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row: tournament + live badge / score submitted badge
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${match.tournamentName ?? ''}${match.roundName != null ? ' — ${match.roundName}' : ''}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ),
                  if (isLive)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('LIVE',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: Colors.white)),
                    )
                  else if (scoreSubmitted)
                    const Icon(Icons.check_circle,
                        color: Colors.green, size: 18),
                ],
              ),
              const SizedBox(height: 10),
              // Score row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      match.teamA ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.socaBlack),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      (isLive || isCompleted) &&
                              match.teamAScore != null &&
                              match.teamBScore != null
                          ? '${match.teamAScore} - ${match.teamBScore}'
                          : 'vs',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: isLive ? Colors.red : AppColors.socaBlack),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      match.teamB ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.socaBlack),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 12,
                runSpacing: 4,
                children: [
                  if (match.matchDate != null)
                    _infoChip(Icons.calendar_today, match.matchDate!),
                  if (match.matchTime != null)
                    _infoChip(Icons.access_time, match.matchTime!),
                  if (match.venue != null)
                    _infoChip(Icons.location_on, match.venue!),
                ],
              ),
              const SizedBox(height: 10),
              // Manage button
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.socaBlack,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    isCompleted ? 'VIEW DETAILS' : 'MANAGE MATCH',
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                        color: AppColors.socaYellow),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: Colors.grey),
        const SizedBox(width: 3),
        Text(text,
            style: const TextStyle(
                fontFamily: 'Lato', fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
