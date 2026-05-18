import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/referee_match_model.dart';
import '../providers/referee_providers.dart';
import '../widgets/referee_shared_widgets.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class RefereeLiveMatchesScreen extends ConsumerStatefulWidget {
  RefereeLiveMatchesScreen({super.key});

  @override
  ConsumerState<RefereeLiveMatchesScreen> createState() =>
      _RefereeLiveMatchesScreenState();
}

class _RefereeLiveMatchesScreenState
    extends ConsumerState<RefereeLiveMatchesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(refereeLiveMatchesProvider.notifier).load();
      ref.invalidate(refereeLiveDropdownProvider);
    });
  }

  void _onTournamentChanged(String? tournamentId) {
    ref.read(refereeSelectedTmntLiveProvider.notifier).state = tournamentId;
    ref.read(refereeLiveMatchesProvider.notifier).load(
          tournamentId: tournamentId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final matchesState = ref.watch(refereeLiveMatchesProvider);
    final dropdownAsync = ref.watch(refereeLiveDropdownProvider);
    final selectedTmnt = ref.watch(refereeSelectedTmntLiveProvider);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: dropdownAsync.when(
            data: (items) => RefereeTournamentDropdown(
              items: items,
              selectedId: selectedTmnt,
              onChanged: _onTournamentChanged,
            ),
            loading: () => RefereeDropdownLoading(),
            error: (_, __) => SizedBox.shrink(),
          ),
        ),
        Expanded(
          child: matchesState.when(
            loading: () => AppLoader(),
            error: (e, _) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: AppColors.error),
                  SizedBox(height: 12),
                  Text(e.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 13)),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(refereeLiveMatchesProvider.notifier).load(
                              tournamentId: selectedTmnt,
                            ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.socaBlack,
                        foregroundColor: AppColors.socaYellow),
                    child: Text('Retry'.tr,
                        style: TextStyle(fontFamily: 'Poppins')),
                  ),
                ],
              ),
            ),
            data: (matches) => matches.isEmpty
                ? RefereeEmptyState(
                    message: 'No live matches right now',
                    icon: Icons.live_tv_outlined,
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(12),
                    itemCount: matches.length,
                    itemBuilder: (ctx, i) => _LiveMatchCard(
                      match: matches[i],
                      onViewDetails: () => context.push(
                        '/live-match/${matches[i].matchId}',
                        extra: {'tournamentId': matches[i].tournamentId ?? ''},
                      ),
                      onUpdate: () => context.push(
                        '/referee/match/${matches[i].matchId}/live-update',
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

class _LiveMatchCard extends StatelessWidget {
  _LiveMatchCard({
    required this.match,
    required this.onViewDetails,
    required this.onUpdate,
  });

  final RefereeMatchModel match;
  final VoidCallback onViewDetails;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    final minute = match.currentMinute;
    final hasScore = match.teamAScore != null && match.teamBScore != null;

    return GestureDetector(
      onTap: onViewDetails,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.shade400, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: tournament + round + LIVE badge + minute
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${match.tournamentName ?? ''}${match.roundName != null ? ' — ${match.roundName}' : ''}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  _LiveBadge(minute: minute),
                ],
              ),
              SizedBox(height: 12),

              // Score row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      match.teamA ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.socaBlack),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      hasScore
                          ? '${match.teamAScore} - ${match.teamBScore}'
                          : 'vs',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: Colors.red),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      match.teamB ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.socaBlack),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Meta info chips
              Wrap(
                spacing: 12,
                runSpacing: 4,
                children: [
                  if (match.matchDate != null)
                    RefereeInfoChip(
                        icon: Icons.calendar_today, text: match.matchDate!),
                  if (match.matchTime != null)
                    RefereeInfoChip(
                        icon: Icons.access_time, text: match.matchTime!),
                  if (match.venue != null)
                    RefereeInfoChip(
                        icon: Icons.location_on, text: match.venue!),
                ],
              ),
              SizedBox(height: 12),

              // Referee roles row
              if (_hasRefereeInfo(match)) ...[
                _RefereeRolesRow(match: match),
                SizedBox(height: 10),
              ],

              // UPDATE MATCH button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onUpdate,
                  icon: Icon(Icons.edit, size: 16),
                  label: Text(
                    'UPDATE MATCH'.tr,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _hasRefereeInfo(RefereeMatchModel m) =>
      (m.mainRef?.isNotEmpty == true) ||
      (m.asstRef1?.isNotEmpty == true) ||
      (m.asstRef2?.isNotEmpty == true) ||
      (m.matchCommis?.isNotEmpty == true);
}

class _LiveBadge extends StatefulWidget {
  _LiveBadge({this.minute});
  final String? minute;

  @override
  State<_LiveBadge> createState() => _LiveBadgeState();
}

class _LiveBadgeState extends State<_LiveBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.4, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
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
              widget.minute != null && widget.minute!.isNotEmpty
                  ? "LIVE ${widget.minute}'"
                  : 'LIVE',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _RefereeRolesRow extends StatelessWidget {
  _RefereeRolesRow({required this.match});
  final RefereeMatchModel match;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 4,
      children: [
        if (match.mainRef?.isNotEmpty == true) _roleChip('REF', match.mainRef!),
        if (match.asstRef1?.isNotEmpty == true)
          _roleChip('AR1', match.asstRef1!),
        if (match.asstRef2?.isNotEmpty == true)
          _roleChip('AR2', match.asstRef2!),
        if (match.matchCommis?.isNotEmpty == true)
          _roleChip('MC', match.matchCommis!),
      ],
    );
  }

  Widget _roleChip(String role, String name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.socaGrey,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$role: $name',
        style: TextStyle(
            fontFamily: 'Lato', fontSize: 11, color: AppColors.socaBlack),
      ),
    );
  }
}
