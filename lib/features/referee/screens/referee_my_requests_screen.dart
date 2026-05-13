import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/referee_match_model.dart';
import '../providers/referee_providers.dart';
import '../widgets/referee_shared_widgets.dart';

class RefereeMyRequestsScreen extends ConsumerStatefulWidget {
  const RefereeMyRequestsScreen({super.key});

  @override
  ConsumerState<RefereeMyRequestsScreen> createState() =>
      _RefereeMyRequestsScreenState();
}

class _RefereeMyRequestsScreenState
    extends ConsumerState<RefereeMyRequestsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(refereeRequestsProvider.notifier).load();
      ref.invalidate(refereeRequestsDropdownProvider);
    });
  }

  void _onTournamentChanged(String? tournamentId) {
    ref.read(refereeSelectedTmntRequestsProvider.notifier).state =
        tournamentId;
    ref.read(refereeRequestsProvider.notifier).load(
          tournamentId: tournamentId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final matchesState = ref.watch(refereeRequestsProvider);
    final dropdownAsync = ref.watch(refereeRequestsDropdownProvider);
    final selectedTmnt = ref.watch(refereeSelectedTmntRequestsProvider);

    return Column(
      children: [
        // Tournament filter dropdown
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
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.socaYellow),
            ),
            error: (e, _) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      size: 48, color: AppColors.error),
                  const SizedBox(height: 12),
                  Text(e.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Poppins', fontSize: 13)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(refereeRequestsProvider.notifier).load(
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
                    message: 'No pending match requests',
                    icon: Icons.inbox_outlined,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: matches.length,
                    itemBuilder: (ctx, i) => _RequestCard(
                      match: matches[i],
                      onAccept: () => _respond(matches[i], accept: true),
                      onDecline: () => _showDeclineDialog(matches[i]),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Future<void> _respond(RefereeMatchModel match,
      {required bool accept, String reason = ''}) async {
    final repo = ref.read(refereeRepositoryProvider);
    final ok = await repo.respondToRequest(
      matchId: match.matchId ?? '',
      tournamentId: match.tournamentId ?? '',
      accept: accept,
      reason: reason,
    );
    if (!mounted) return;
    if (ok) {
      ref.read(refereeRequestsProvider.notifier).removeMatch(match.matchId ?? '');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(accept ? 'Request accepted' : 'Request declined'),
          backgroundColor: AppColors.socaBlack,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Action failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _showDeclineDialog(RefereeMatchModel match) async {
    final controller = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Decline Reason',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 16)),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Enter reason...',
            hintStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel',
                style: TextStyle(
                    fontFamily: 'Poppins', color: AppColors.socaBlack)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                foregroundColor: AppColors.socaYellow),
            child: const Text('Submit',
                style: TextStyle(fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await _respond(match, accept: false, reason: controller.text.trim());
    }
    controller.dispose();
  }
}

// ─── Shared widgets used across multiple referee screens ─────────────────────

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.match,
    required this.onAccept,
    required this.onDecline,
  });

  final RefereeMatchModel match;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
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
            // Tournament + round
            Text(
              '${match.tournamentName ?? ''}${match.roundName != null ? ' — ${match.roundName}' : ''}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: AppColors.socaBlack,
              ),
            ),
            const SizedBox(height: 10),
            // Teams
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('vs',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.grey)),
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
            // Date · Time · Venue
            Wrap(
              spacing: 12,
              runSpacing: 4,
              children: [
                if (match.matchDate != null)
                  RefereeInfoChip(icon: Icons.calendar_today, text: match.matchDate!),
                if (match.matchTime != null)
                  RefereeInfoChip(icon: Icons.access_time, text: match.matchTime!),
                if (match.venue != null)
                  RefereeInfoChip(icon: Icons.location_on, text: match.venue!),
                if (match.ageGroup != null)
                  RefereeInfoChip(icon: Icons.group, text: match.ageGroup!),
              ],
            ),
            const SizedBox(height: 14),
            // Accept / Decline buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onAccept,
                    icon: const Icon(Icons.check, size: 16),
                    label: const Text('ACCEPT',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socaBlack,
                      foregroundColor: AppColors.socaYellow,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onDecline,
                    icon: const Icon(Icons.close, size: 16),
                    label: const Text('DECLINE',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 12)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.socaBlack,
                      side: const BorderSide(color: AppColors.socaBlack),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
