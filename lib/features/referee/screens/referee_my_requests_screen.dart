import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/api_constants.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/referee_match_model.dart';
import '../providers/referee_providers.dart';
import '../widgets/referee_shared_widgets.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

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
    ref.read(refereeSelectedTmntRequestsProvider.notifier).state = tournamentId;
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8, right: 50, top: 8, bottom: 8),
          margin: const EdgeInsets.only(left: 16, top: 16),
          decoration: const BoxDecoration(
            color: AppColors.socaBlack,
          ),
          child: Text(
            AppStrings.myRequests,
            style: const TextStyle(
                color: AppColors.socaYellow,
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Text(AppStrings.myRequestsDescription,
              style: const TextStyle(
                  color: AppColors.socaBlack, fontWeight: FontWeight.w700)),
        ),
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
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: AppColors.socaBlack)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(refereeRequestsProvider.notifier).load(
                              tournamentId: selectedTmnt,
                            ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.socaBlack,
                        foregroundColor: AppColors.socaYellow),
                    child: Text('Retry'.tr,
                        style: const TextStyle(fontFamily: 'Poppins')),
                  ),
                ],
              ),
            ),
            data: (matches) => matches.isEmpty
                ? RefereeEmptyState(
                    message: AppStrings.noPendingMatchRequests,
                    icon: Icons.inbox_outlined,
                  )
                : ListView.builder(
                    // padding: EdgeInsets.all(12),
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
      ref
          .read(refereeRequestsProvider.notifier)
          .removeMatch(match.matchId ?? '');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              accept ? AppStrings.requestAccepted : AppStrings.requestDeclined),
          backgroundColor: AppColors.socaBlack,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Action failed. Please try again.'.tr),
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
        title: Text('Decline Reason'.tr,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 16)),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Enter reason...'.tr,
            hintStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel'.tr,
                style: const TextStyle(
                    fontFamily: 'Poppins', color: AppColors.socaBlack)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                foregroundColor: AppColors.socaYellow),
            child: Text('Submit'.tr,
                style: const TextStyle(fontFamily: 'Poppins')),
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
    final teamAName = match.myTeam?.teamName?.isNotEmpty == true
        ? match.myTeam!.teamName!
        : match.teamA ?? '';
    final teamBName = match.opponentTeam?.teamName?.isNotEmpty == true
        ? match.opponentTeam!.teamName!
        : match.teamB ?? '';

    // log("ghtis isvsjfv ${match.teamALogo}");
    return Container(
      // margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            color: AppColors.socaBlack,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              match.tournamentName?.toUpperCase() ?? '',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.socaYellow,
              ),
            ),
          ),
          // Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Team A
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: Colors.transparent,
                            backgroundImage: match.teamALogo != null &&
                                    match.teamALogo!.isNotEmpty &&
                                    match.teamBLogo != "logo.png"
                                ? NetworkImage(
                                    ApiConstants.getImageUrl(match.teamALogo!))
                                : null,
                            child: match.teamALogo == null ||
                                    match.teamALogo!.isEmpty ||
                                    match.teamBLogo == "logo.png"
                                ? Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: AppColors.socaBlack,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Center(
                                      child: Text(match.teamA ?? '',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: AppColors.socaYellow,
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          )),
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            teamAName,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // VS & Date/Time
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Text(
                            AppStrings.vs.toUpperCase(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                              color: AppColors.socaBlack,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${match.matchDate ?? ''} | ${match.matchTime?.replaceAll(' ', '\n') ?? ''}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Team B
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: Colors.transparent,
                            backgroundImage: match.teamBLogo != null &&
                                    match.teamBLogo!.isNotEmpty &&
                                    match.teamBLogo != "logo.png"
                                ? NetworkImage(
                                    ApiConstants.getImageUrl(match.teamBLogo!))
                                : null,
                            child: match.teamBLogo == null ||
                                    match.teamBLogo!.isEmpty ||
                                    match.teamBLogo == "logo.png"
                                ? Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: AppColors.socaBlack,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Center(
                                      child: Text(match.teamB ?? '',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: AppColors.socaYellow,
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          )),
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            teamBName,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100,
                      child: OutlinedButton(
                        onPressed: onDecline,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.socaBlack,
                          side: const BorderSide(
                              color: AppColors.socaBlack, width: 1.5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'DECLINE'.tr,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: onAccept,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.socaBlack,
                          foregroundColor: AppColors.socaYellow,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'ACCEPT'.tr,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
