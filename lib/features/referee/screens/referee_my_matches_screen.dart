import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_loader.dart';
import '../data/models/referee_match_model.dart';
import '../providers/referee_providers.dart';
import '../widgets/referee_shared_widgets.dart';

class RefereeMyMatchesScreen extends ConsumerStatefulWidget {
  const RefereeMyMatchesScreen({super.key});

  @override
  ConsumerState<RefereeMyMatchesScreen> createState() =>
      _RefereeMyMatchesScreenState();
}

class _RefereeMyMatchesScreenState
    extends ConsumerState<RefereeMyMatchesScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(refereeTournamentDropdownProvider);
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels < position.maxScrollExtent - 220) return;
    ref.read(refereeMatchesProvider.notifier).loadMore();
  }

  void _onTournamentChanged(String? tournamentId) {
    ref.read(refereeSelectedTmntMatchesProvider.notifier).state = tournamentId;
    ref.read(refereeMatchesProvider.notifier).load(tournamentId: tournamentId);
  }

  Future<void> _downloadReport(RefereeMatchModel match) async {
    final matchId = match.matchId ?? '';
    final userId = StorageService.userId ?? '';
    final tournamentId = match.tournamentId ?? '';
    if (matchId.isEmpty || userId.isEmpty || tournamentId.isEmpty) return;

    final uri = Uri.parse(
      '${ApiConstants.phpBaseUrl}getRefMtchDowwnload.php'
      '?m=$matchId&u=$userId&t=$tournamentId',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final matchesState = ref.watch(refereeMatchesProvider);
    final dropdownAsync = ref.watch(refereeTournamentDropdownProvider);
    final selectedTmnt = ref.watch(refereeSelectedTmntMatchesProvider);

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, top: 25),
            padding:
                const EdgeInsets.only(left: 10, right: 50, top: 8, bottom: 8),
            color: AppColors.socaBlack,
            child: Text(
              AppStrings.myMatches,
              style: const TextStyle(
                color: AppColors.socaYellow,
                fontFamily: 'Lato',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Text(
              AppStrings.myMatchesTournament,
              style: const TextStyle(
                color: AppColors.socaBlack,
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 25, bottom: 4),
            child: dropdownAsync.when(
              data: (items) => RefereeTournamentDropdown(
                items: items,
                selectedId: selectedTmnt,
                onChanged: _onTournamentChanged,
              ),
              loading: () => const RefereeDropdownLoading(),
              error: (_, __) => RefereeTournamentDropdown(
                items: const [],
                selectedId: selectedTmnt,
                onChanged: _onTournamentChanged,
              ),
            ),
          ),
          Expanded(
            child: matchesState.when(
              loading: () => const AppLoader(),
              error: (e, _) => _ErrorState(
                error: e.toString(),
                onRetry: () => ref
                    .read(refereeMatchesProvider.notifier)
                    .load(tournamentId: selectedTmnt),
              ),
              data: (matches) {
                if (matches.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(
                        AppStrings.noMatchesAreFound,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.socaBlack,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  color: AppColors.socaYellow,
                  backgroundColor: AppColors.socaBlack,
                  onRefresh: () => ref
                      .read(refereeMatchesProvider.notifier)
                      .load(tournamentId: selectedTmnt),
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: matches.length,
                    itemBuilder: (context, index) {
                      final match = matches[index];
                      final previous = index > 0 ? matches[index - 1] : null;
                      final showTournament = previous?.tournamentId == null ||
                          previous?.tournamentId != match.tournamentId;

                      return _AndroidMatchRow(
                        match: match,
                        showTournament: showTournament,
                        currentUserId: StorageService.userId ?? '',
                        onManage: () => context.push(
                          AppRoutes.refereeManageMatch.replaceFirst(
                            ':matchId',
                            match.matchId ?? '',
                          ),
                          extra: match,
                        ),
                        onDownload: () => _downloadReport(match),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AndroidMatchRow extends StatelessWidget {
  const _AndroidMatchRow({
    required this.match,
    required this.showTournament,
    required this.currentUserId,
    required this.onManage,
    required this.onDownload,
  });

  final RefereeMatchModel match;
  final bool showTournament;
  final String currentUserId;
  final VoidCallback onManage;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    final hasScore = match.score != null;
    final canManage = match.canManage(currentUserId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showTournament)
          Container(
            margin: const EdgeInsets.fromLTRB(2, 10, 2, 0),
            padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
            color: AppColors.socaBlack,
            child: Text(
              match.tournamentName ?? '',
              style: const TextStyle(
                color: AppColors.socaYellow,
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          )
        else
          Container(
            height: 0.5,
            margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
            color: AppColors.socaBlack,
          ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _TeamLine(
                          logoUrl: match.teamALogo,
                          name: match.teamA ?? '',
                          blackLogo: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 57, top: 2),
                          child: Text(
                            hasScore
                                ? '${match.score?.myGoals ?? 0} : ${match.score?.opponentGoals ?? 0}'
                                : AppStrings.vsLower,
                            style: TextStyle(
                              color: AppColors.socaBlack,
                              fontFamily: 'Poppins',
                              fontSize: hasScore ? 14 : 12,
                              fontWeight: FontWeight.w700,
                              height: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        _TeamLine(
                          logoUrl: match.teamBLogo,
                          name: match.teamB ?? '',
                          blackLogo: false,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(width: 0.5, color: AppColors.socaBlack),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((match.stadiumName ?? '').isNotEmpty)
                          _DetailText(match.stadiumName!),
                        if ((match.fieldName ?? '').isNotEmpty) ...[
                          const SizedBox(height: 7),
                          _DetailText(match.fieldName!),
                        ],
                        if ((match.matchDateTimeGmt ?? 0) > 0) ...[
                          const SizedBox(height: 7),
                          _DetailText(
                            '${match.matchDate ?? ''} | ${match.matchTime ?? ''}',
                          ),
                        ],
                        if (canManage) ...[
                          const SizedBox(height: 15),
                          _ActionButton(
                            label: AppStrings.manage.toUpperCase(),
                            onTap: onManage,
                          ),
                          if (hasScore) ...[
                            const SizedBox(height: 15),
                            _ActionButton(
                              label:
                                  AppStrings.downloadMatchReport.toUpperCase(),
                              onTap: onDownload,
                              horizontalPadding: 10,
                            ),
                          ],
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TeamLine extends StatelessWidget {
  const _TeamLine({
    required this.logoUrl,
    required this.name,
    required this.blackLogo,
  });

  final String? logoUrl;
  final String name;
  final bool blackLogo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5),
      child: Row(
        children: [
          _TeamLogo(logoUrl: logoUrl, name: name, blackLogo: blackLogo),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.socaBlack,
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamLogo extends StatelessWidget {
  const _TeamLogo({
    required this.logoUrl,
    required this.name,
    required this.blackLogo,
  });

  final String? logoUrl;
  final String name;
  final bool blackLogo;

  @override
  Widget build(BuildContext context) {
    final url = ApiConstants.getImageUrl(logoUrl);
    final fallback = name.isEmpty
        ? AppStrings.teamFallback.toUpperCase()
        : name.substring(0, name.length > 4 ? 4 : name.length).toUpperCase();

    return CircleAvatar(
      radius: 25,
      backgroundColor: AppColors.socaBlack,
      backgroundImage:
          url.isNotEmpty && url != "${ApiConstants.imageBaseUrl}logo.png"
              ? NetworkImage(url)
              : null,
      child: url.isEmpty || url == "${ApiConstants.imageBaseUrl}logo.png"
          ? Text(
              fallback,
              style: const TextStyle(
                color: AppColors.socaYellow,
                fontFamily: 'Poppins',
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            )
          : null,
    );
  }
}

class _DetailText extends StatelessWidget {
  const _DetailText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.socaBlack,
        fontFamily: 'Poppins',
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 1,
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.onTap,
    this.horizontalPadding = 15,
  });

  final String label;
  final VoidCallback onTap;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.socaBlack,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.socaYellow,
            fontFamily: 'Poppins',
            fontSize: 10,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.error, required this.onRetry});

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
            const Icon(Icons.error_outline, size: 42, color: AppColors.error),
            const SizedBox(height: 12),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                foregroundColor: AppColors.socaYellow,
              ),
              child: Text(
                AppStrings.retry,
                style: const TextStyle(fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
