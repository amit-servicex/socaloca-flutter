import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';
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
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: TextStyle(
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
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
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
          SliverToBoxAdapter(child: Divider(height: 1)),
          if (state.isLoading && state.teams.isEmpty)
            SliverFillRemaining(
              child: AppLoader(),
            )
          else if (state.error != null && state.teams.isEmpty)
            SliverFillRemaining(child: _buildErrorState(state.error!))
          else if (state.teams.isEmpty)
            SliverFillRemaining(child: _buildEmptyState())
          else ...[
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == state.teams.length) {
                      return Padding(
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
          SizedBox(height: 16),
          Text(
            AppStrings.noTeamsFound,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
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
          SizedBox(height: 16),
          Text(
            AppStrings.failedToLoadTeams,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
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
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => ref.read(teamsProvider.notifier).refresh(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.socaBlack,
              foregroundColor: AppColors.socaYellow,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
        SizedBox(height: 12),
        Text(AppStrings.errorMessage(error),
            style: TextStyle(fontFamily: 'Poppins', fontSize: 13)),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: onRetry,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.socaBlack,
            foregroundColor: AppColors.socaYellow,
          ),
          child:
              Text(AppStrings.retry, style: TextStyle(fontFamily: 'Poppins')),
        ),
      ],
    ),
  );
}

Widget _teamListTile(
  BuildContext context,
  Map<String, dynamic> team, {
  Widget? trailing,
}) {
  final teamId = team['teamId'] as String? ?? team['_id'] as String? ?? '';
  final teamName = team['teamName'] as String? ?? AppStrings.unknownTeam;
  final imageUrl = team['imageUrl'] as String? ?? '';

  return Card(
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: ListTile(
      leading: CircleAvatar(
        backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
        backgroundColor: AppColors.socaGrey,
        child: imageUrl.isEmpty
            ? Icon(Icons.group, color: AppColors.socaBlack)
            : null,
      ),
      title: Text(
        teamName,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: AppColors.socaBlack,
        ),
      ),
      trailing:
          trailing ?? Icon(Icons.chevron_right, color: AppColors.socaBlack),
      onTap: teamId.isNotEmpty
          ? () =>
              context.push(AppRoutes.teamBio.replaceFirst(':teamId', teamId))
          : null,
    ),
  );
}

// ── JOINED tab ─────────────────────────────────────────────────────────────────

class _JoinedTeamsTab extends ConsumerStatefulWidget {
  final String userId;
  _JoinedTeamsTab({required this.userId});

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
            final aSort = (a['sortId'] as num?)?.toInt() ?? 0;
            final bSort = (b['sortId'] as num?)?.toInt() ?? 0;
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
      return AppLoader();
    }
    if (_error != null) return _errorTab(_error!, _load);
    if (_teams.isEmpty) return _emptyTab(AppStrings.noJoinedTeams);

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.separated(
        padding: EdgeInsets.all(12),
        itemCount: _teams.length,
        separatorBuilder: (_, __) => SizedBox(height: 8),
        itemBuilder: (context, i) => _teamListTile(context, _teams[i]),
      ),
    );
  }
}

// ── PENDING tab ────────────────────────────────────────────────────────────────

class _PendingTeamsTab extends ConsumerStatefulWidget {
  final String userId;
  _PendingTeamsTab({required this.userId});

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
                style: TextStyle(fontFamily: 'Poppins')),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppStrings.errorMessage(e),
                style: TextStyle(fontFamily: 'Poppins')),
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
      return AppLoader();
    }
    if (_error != null) return _errorTab(_error!, _load);
    if (_teams.isEmpty) return _emptyTab(AppStrings.noPendingRequests);

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.separated(
        padding: EdgeInsets.all(12),
        itemCount: _teams.length,
        separatorBuilder: (_, __) => SizedBox(height: 8),
        itemBuilder: (context, i) => _teamListTile(
          context,
          _teams[i],
          trailing: TextButton(
            onPressed: () => _cancel(i),
            child: Text(
              AppStrings.cancel,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.red,
                fontWeight: FontWeight.w600,
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
  _ReceivedTeamsTab({required this.userId});

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
  static int _limit = 5;
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
            final aSort = (a['sortId'] as num?)?.toInt() ?? 0;
            final bSort = (b['sortId'] as num?)?.toInt() ?? 0;
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
            final aSort = (a['sortId'] as num?)?.toInt() ?? 0;
            final bSort = (b['sortId'] as num?)?.toInt() ?? 0;
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
              style: TextStyle(fontFamily: 'Poppins'),
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
                style: TextStyle(fontFamily: 'Poppins')),
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
      return AppLoader();
    }
    if (_error != null) return _errorTab(_error!, _load);
    if (_teams.isEmpty) return _emptyTab(AppStrings.noTeamInvitations);

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.all(12),
        itemCount: _teams.length + (_isLoadingMore ? 1 : 0),
        separatorBuilder: (_, __) => SizedBox(height: 8),
        itemBuilder: (context, i) {
          if (i == _teams.length) {
            return AppLoader();
          }
          final team = _teams[i];
          final teamId =
              team['teamId'] as String? ?? team['_id'] as String? ?? '';
          final teamName =
              team['teamName'] as String? ?? AppStrings.unknownTeam;
          final imageUrl = team['imageUrl'] as String? ?? '';

          return Card(
            margin: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                    backgroundColor: AppColors.socaGrey,
                    child: imageUrl.isEmpty
                        ? Icon(Icons.group, color: AppColors.socaBlack)
                        : null,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: teamId.isNotEmpty
                          ? () => context.push(
                              AppRoutes.teamBio.replaceFirst(':teamId', teamId))
                          : null,
                      child: Text(
                        teamName,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _respond(i, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      elevation: 0,
                    ),
                    child: Text(AppStrings.accept,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 12)),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () => _respond(i, false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      elevation: 0,
                    ),
                    child: Text(AppStrings.decline,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 12)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
