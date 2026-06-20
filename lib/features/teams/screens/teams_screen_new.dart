import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/api_constants.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/shared/providers/auth_provider.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../player_bio/providers/player_bio_provider.dart';
import '../providers/teams_provider.dart';
import '../widgets/team_card.dart';
import '../widgets/team_filter_section.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Teams screen.
/// - Fans: single "All" view (no tabs).
/// - Players / Coaches / Managers: 4 tabs — ALL, JOINED, PENDING, RECEIVED.
class TeamsScreenNew extends ConsumerStatefulWidget {
  String? status;
  TeamsScreenNew({super.key, this.status});

  @override
  ConsumerState<TeamsScreenNew> createState() => _TeamsScreenNewState();
}

class _TeamsScreenNewState extends ConsumerState<TeamsScreenNew>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _hasLoadedInitially = false;
  late final bool _isFan;
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    final user = StorageService.currentUser;
    _isFan = (user?['isFan'] as bool?) ?? false;

    if (!_isFan) {
      _tabController = TabController(length: 4, vsync: this);
    }

    _scrollController.addListener(_onScroll);
    if (!_hasLoadedInitially) {
      _hasLoadedInitially = true;
      Future.microtask(() {
        if (mounted) ref.read(teamsProvider.notifier).search();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController?.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(teamsProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(currentUserProvider);

    if (_isFan) {
      return Scaffold(
        backgroundColor: AppColors.socaPageBg,
        body: _buildAllTeamsView(),
      );
    }

    final userId = StorageService.userId ?? '';

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: Column(
        children: [
          if (!(user?.isFan ?? false) && widget.status == null) ...[
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController!,
                labelColor: AppColors.socaBlack,
                unselectedLabelColor: AppColors.socaBlack,
                indicatorColor: AppColors.socaBlack,
                indicatorWeight: 3,
                labelStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                tabs: [
                  Tab(text: AppStrings.all.toUpperCase()),
                  Tab(text: AppStrings.joined.toUpperCase()),
                  Tab(text: AppStrings.pending.toUpperCase()),
                  Tab(text: AppStrings.received.toUpperCase()),
                ],
              ),
            ),
          ],
          Expanded(
            child: TabBarView(
              controller: _tabController!,
              children: [
                _buildAllTeamsView(),
                _JoinedTeamsTab(userId: userId),
                _PendingTeamsTab(userId: userId),
                _ReceivedTeamsTab(userId: userId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllTeamsView() {
    final state = ref.watch(teamsProvider);
    final userCountry =
        StorageService.currentUser?['country'] as String? ?? 'India';

    return RefreshIndicator(
      onRefresh: () async => ref.read(teamsProvider.notifier).refresh(),
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: TeamFilterSection(
                userCountry: userCountry,
                onSearch: () {
                  if (!state.filters.hasAnyFilter) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppStrings.pleaseSelectFilter),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  ref.read(teamsProvider.notifier).search(requireFilters: true);
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(child: Divider(height: 1)),
          if (state.isLoading && state.teams.isEmpty)
            const SliverFillRemaining(
              child: AppLoader(),
            )
          else if (state.error != null && state.teams.isEmpty)
            SliverFillRemaining(child: _buildErrorState(state.error!))
          else if (state.teams.isEmpty)
            SliverFillRemaining(child: _buildEmptyState())
          else ...[
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == state.teams.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: AppLoader(),
                      );
                    }
                    return TeamCard(team: state.teams[index]);
                  },
                  childCount:
                      state.teams.length + (state.isLoadingMore ? 1 : 0),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.groups_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            AppStrings.noTeamsFound,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.tryAdjustingYourFilters,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text(
            AppStrings.failedToLoadTeams,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              error,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => ref.read(teamsProvider.notifier).refresh(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.socaBlack,
              foregroundColor: AppColors.socaYellow,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }
}

// ── Shared helpers ─────────────────────────────────────────────────────────────

Widget _emptyTab(String message) {
  return Center(
    child: Text(
      message,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        color: Colors.grey[600],
      ),
    ),
  );
}

Widget _errorTab(String error, VoidCallback onRetry) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
        const SizedBox(height: 12),
        Text(AppStrings.errorMessage(error),
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 13)),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onRetry,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.socaBlack,
            foregroundColor: AppColors.socaYellow,
          ),
          child: Text(AppStrings.retry,
              style: const TextStyle(fontFamily: 'Poppins')),
        ),
      ],
    ),
  );
}

Widget _teamListTile(
  BuildContext context,
  Map<String, dynamic> team, {
  Widget? actionButtons,
}) {
  final teamId = team['teamId'] as String? ?? team['_id'] as String? ?? '';
  final teamName = team['teamName'] as String? ?? AppStrings.unknownTeam;
  final imageUrl = team['imageUrl'] as String? ?? '';
  final country = team['country'] as String? ?? '';
  final memberText = team['memberText'] as String? ?? '';
  final gameTypeYear = team['gameTypeYear'] as String? ?? '';
  final rating = (team['rating'] as num?)?.toDouble() ?? 0.0;
  final progressValue = (rating / 5.0).clamp(0.0, 1.0);

  void navigate() {
    if (teamId.isNotEmpty) {
      context.push(AppRoutes.teamBio.replaceFirst(':teamId', teamId));
    }
  }

  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    color: Colors.white,
    elevation: 4,
    shadowColor: Colors.black12,
    child: InkWell(
      onTap: navigate,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              clipBehavior: Clip.antiAlias,
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: ApiConstants.getImageUrl(imageUrl),
                      fit: BoxFit.cover,
                      placeholder: (_, __) => const AppLoader(),
                      errorWidget: (_, __, ___) => const Icon(
                          Icons.emoji_events,
                          size: 32,
                          color: Colors.grey),
                    )
                  : const Icon(Icons.emoji_events,
                      size: 32, color: Colors.grey),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (gameTypeYear.isNotEmpty) ...[
                    Text(
                      gameTypeYear,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                  Text(
                    teamName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaBlack,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (country.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      country,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ],
                  if (memberText.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      memberText,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        AppStrings.ratingLabel,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: AppColors.socaBlack,
                        ),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: LinearProgressIndicator(
                            value: progressValue,
                            minHeight: 3,
                            backgroundColor: AppColors.socaBlack,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.socaBlack,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: navigate,
                        child: Container(
                          width: 80,
                          height: 48,
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          decoration: BoxDecoration(
                            color: AppColors.socaBlack,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            AppStrings.viewUpper,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.socaYellow,
                            ),
                          ),
                        ),
                      ),
                      if (actionButtons != null) ...[
                        const SizedBox(width: 8),
                        actionButtons,
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ── JOINED tab ─────────────────────────────────────────────────────────────────

class _JoinedTeamsTab extends ConsumerStatefulWidget {
  final String userId;
  const _JoinedTeamsTab({required this.userId});

  @override
  ConsumerState<_JoinedTeamsTab> createState() => _JoinedTeamsTabState();
}

class _JoinedTeamsTabState extends ConsumerState<_JoinedTeamsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Map<String, dynamic>> _teams = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final user = StorageService.currentUser;
      final country = (user?['country'] as String?) ?? '';
      final repo = ref.read(playerBioRepositoryProvider);
      final teams = await repo.getPlayerJoinedTeams(
          playerId: widget.userId, country: country);
      if (mounted) {
        final sorted = List<Map<String, dynamic>>.from(teams)
          ..sort((a, b) {
            final aSort = a['sortId']?.toString() ?? '';
            final bSort = b['sortId']?.toString() ?? '';
            return bSort.compareTo(aSort);
          });
        setState(() {
          _teams = sorted;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_isLoading) {
      return const AppLoader();
    }
    if (_error != null) return _errorTab(_error!, _load);
    if (_teams.isEmpty) return _emptyTab(AppStrings.noJoinedTeams);

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _teams.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) => _teamListTile(context, _teams[i]),
      ),
    );
  }
}

// ── PENDING tab ────────────────────────────────────────────────────────────────

class _PendingTeamsTab extends ConsumerStatefulWidget {
  final String userId;
  const _PendingTeamsTab({required this.userId});

  @override
  ConsumerState<_PendingTeamsTab> createState() => _PendingTeamsTabState();
}

class _PendingTeamsTabState extends ConsumerState<_PendingTeamsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Map<String, dynamic>> _teams = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final repo = ref.read(playerBioRepositoryProvider);
      final teams = await repo.getPlayerPendingTeams(playerId: widget.userId);
      if (mounted) {
        setState(() {
          _teams = teams;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _cancel(int index) async {
    final team = _teams[index];
    final teamId = team['teamId'] as String? ?? team['_id'] as String? ?? '';
    if (teamId.isEmpty) return;
    try {
      final repo = ref.read(playerBioRepositoryProvider);
      final success = await repo.cancelTeamJoinRequest(
        playerId: widget.userId,
        teamId: teamId,
      );
      if (success && mounted) {
        setState(() => _teams.removeAt(index));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppStrings.requestCancelled,
                style: const TextStyle(fontFamily: 'Poppins')),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppStrings.errorMessage(e),
                style: const TextStyle(fontFamily: 'Poppins')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_isLoading) {
      return const AppLoader();
    }
    if (_error != null) return _errorTab(_error!, _load);
    if (_teams.isEmpty) return _emptyTab(AppStrings.noPendingRequests);

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _teams.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) => _teamListTile(
          context,
          _teams[i],
          actionButtons: Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaBlack,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () => _cancel(i),
              child: Text(
                AppStrings.cancel,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColors.socaYellow,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── RECEIVED tab ───────────────────────────────────────────────────────────────

class _ReceivedTeamsTab extends ConsumerStatefulWidget {
  final String userId;
  const _ReceivedTeamsTab({required this.userId});

  @override
  ConsumerState<_ReceivedTeamsTab> createState() => _ReceivedTeamsTabState();
}

class _ReceivedTeamsTabState extends ConsumerState<_ReceivedTeamsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final List<Map<String, dynamic>> _teams = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  String? _error;
  int _start = 0;
  static const int _limit = 5;
  bool _hasMore = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _load();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isLoadingMore &&
        _hasMore) {
      _loadMore();
    }
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final repo = ref.read(playerBioRepositoryProvider);
      final teams = await repo.getTeamPlayerInvites(
          userId: widget.userId, start: 0, limit: _limit);
      if (mounted) {
        final sorted = List<Map<String, dynamic>>.from(teams)
          ..sort((a, b) {
            final aSort = a['sortId']?.toString() ?? '';
            final bSort = b['sortId']?.toString() ?? '';
            return bSort.compareTo(aSort);
          });
        setState(() {
          _teams.clear();
          _teams.addAll(sorted);
          _start = _limit;
          _hasMore = teams.length == _limit;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadMore() async {
    if (!_hasMore || _isLoadingMore) return;
    setState(() => _isLoadingMore = true);
    try {
      final repo = ref.read(playerBioRepositoryProvider);
      final teams = await repo.getTeamPlayerInvites(
          userId: widget.userId, start: _start, limit: _limit);
      if (mounted) {
        final sorted = List<Map<String, dynamic>>.from(teams)
          ..sort((a, b) {
            final aSort = a['sortId']?.toString() ?? '';
            final bSort = b['sortId']?.toString() ?? '';
            return bSort.compareTo(aSort);
          });
        setState(() {
          _teams.addAll(sorted);
          _start += _limit;
          _hasMore = teams.length == _limit;
          _isLoadingMore = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    }
  }

  Widget _buildReceivedCard(BuildContext context, int i) {
    final team = _teams[i];
    final teamId = team['teamId'] as String? ?? team['_id'] as String? ?? '';
    final teamName = team['teamName'] as String? ?? '';
    final imageUrl = team['imageUrl'] as String? ?? '';
    final country = team['country'] as String? ?? '';
    final gameTypeYear = team['gameTypeYear'] as String? ?? '';
    final rating = (team['rating'] as num?)?.toDouble() ?? 0.0;
    final progressValue = (rating / 5.0).clamp(0.0, 1.0);

    final rawCount = team['memberCount'] ?? team['members'];
    final memberText = rawCount != null
        ? '$rawCount Members'
        : (team['memberText'] as String? ?? '');

    final invitor = team['invitor'] as Map<String, dynamic>?;
    final invitorFirst = invitor?['firstName'] as String? ?? '';
    final invitorLast = invitor?['lastName'] as String? ?? '';
    final inviterName = '$invitorFirst $invitorLast'.trim();
    final inviterImage = invitor?['imageUrl'] as String? ?? '';
    final invitorUserId = invitor?['userId'] as String? ?? '';
    final invitorIsPlayer = invitor?['isPlayer'] == true;

    void navigateToInvitor() {
      if (invitorUserId.isEmpty) return;
      if (invitorIsPlayer) {
        log("this si the clientable event player ");

        context
            .push(AppRoutes.playerBio.replaceFirst(':userId', invitorUserId));
      } else {
        log("this si the clientable event ");

        context.push(
            AppRoutes.coachAdminBio.replaceFirst(':userId', invitorUserId));
      }
    }

    void navigate() {
      if (teamId.isNotEmpty) {
        context.push(AppRoutes.teamBio.replaceFirst(':teamId', teamId));
      }
    }

    return Column(
      children: [
        if (inviterName.isNotEmpty) ...[
          const Divider(height: 1, color: AppColors.socaBlack),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: navigateToInvitor,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Colors.grey[200],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: inviterImage.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: ApiConstants.getImageUrl(inviterImage),
                            fit: BoxFit.cover,
                            errorWidget: (_, __, ___) => const Icon(
                                Icons.person,
                                size: 20,
                                color: Colors.grey),
                          )
                        : const Icon(Icons.person,
                            size: 20, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: navigateToInvitor,
                    child: Text(
                      '$inviterName has invited you to join',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.socaBlack),
        ],
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.white,
          elevation: 4,
          shadowColor: Colors.black12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Inviter row ──────────────────────────────────────────

              // ── Team info ─────────────────────────────────────────────
              GestureDetector(
                onTap: navigate,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: imageUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: ApiConstants.getImageUrl(imageUrl),
                                fit: BoxFit.cover,
                                placeholder: (_, __) => const AppLoader(),
                                errorWidget: (_, __, ___) => const Icon(
                                    Icons.emoji_events,
                                    size: 28,
                                    color: Colors.grey),
                              )
                            : const Icon(Icons.emoji_events,
                                size: 28, color: Colors.grey),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (gameTypeYear.isNotEmpty) ...[
                              Text(
                                gameTypeYear,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 2),
                            ],
                            Text(
                              teamName,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.socaBlack,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (country.isNotEmpty) ...[
                              const SizedBox(height: 3),
                              Text(
                                country,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  color: AppColors.socaBlack,
                                ),
                              ),
                            ],
                            if (memberText.isNotEmpty) ...[
                              const SizedBox(height: 3),
                              Text(
                                memberText,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: AppColors.socaBlack,
                                ),
                              ),
                            ],
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  AppStrings.ratingLabel,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: AppColors.socaBlack,
                                  ),
                                ),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: LinearProgressIndicator(
                                      value: progressValue,
                                      minHeight: 3,
                                      backgroundColor: Colors.grey[300],
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                        AppColors.socaBlack,
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
                ),
              ),

              const SizedBox(height: 14),

              // ── ACCEPT / DECLINE buttons ──────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _respond(i, true),
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: AppColors.socaBlack, width: 1.5),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            AppStrings.accept.toUpperCase(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _respond(i, false),
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                            color: AppColors.socaBlack,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            AppStrings.decline.toUpperCase(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _respond(int index, bool accept) async {
    final team = _teams[index];
    final currentUser = StorageService.currentUser;
    final teamId = team['teamId'] as String? ?? team['_id'] as String? ?? '';
    if (teamId.isEmpty) return;

    try {
      final repo = ref.read(playerBioRepositoryProvider);
      final success = await repo.respondTeamPlayer(
        teamId: teamId,
        userId: widget.userId,
        accept: accept,
        teamName: team['teamName'] as String? ?? '',
        myName:
            '${currentUser?['firstName'] ?? ''} ${currentUser?['lastName'] ?? ''}'
                .trim(),
        myImageUrl: currentUser?['imageUrl'] as String? ?? '',
      );
      if (success && mounted) {
        setState(() => _teams.removeAt(index));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              accept ? 'Invitation accepted.' : 'Invitation declined.',
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
            backgroundColor: accept ? Colors.green : Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppStrings.errorMessage(e),
                style: const TextStyle(fontFamily: 'Poppins')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_isLoading) {
      return const AppLoader();
    }
    if (_error != null) return _errorTab(_error!, _load);
    if (_teams.isEmpty) return _emptyTab(AppStrings.noTeamInvitations);

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: _teams.length + (_isLoadingMore ? 1 : 0),
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          if (i == _teams.length) {
            return const AppLoader();
          }
          return _buildReceivedCard(context, i);
        },
      ),
    );
  }
}
