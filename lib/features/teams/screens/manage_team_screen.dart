import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/socaloca_text_field.dart';
import '../data/models/team_bio_model.dart';
import '../data/repositories/team_manage_repository.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';
import 'package:socaloca/features/teams/widgets/team_header_widget.dart';

class ManageTeamScreen extends StatelessWidget {
  final String teamId;
  final TeamDetailsModel teamDetails;

  const ManageTeamScreen({
    super.key,
    required this.teamId,
    required this.teamDetails,
  });

  @override
  Widget build(BuildContext context) {
    final repo = TeamManageRepository(teamId: teamId);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.socaPageBg,
        body: Column(
          children: [
            ColoredBox(
              color: Colors.white,
              child: TabBar(
                isScrollable: true,
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
                  Tab(text: AppStrings.newRequests.toUpperCase()),
                  Tab(text: AppStrings.newPlayers.toUpperCase()),
                  Tab(text: AppStrings.jerseyAssigned.toUpperCase()),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _JoinRequestsTab(repo: repo, teamDetails: teamDetails),
                  _NewPlayersTab(repo: repo, teamDetails: teamDetails),
                  _JerseyAssignedTab(repo: repo, teamDetails: teamDetails),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Tab 0: Join Requests ──────────────────────────────────────────────────────

class _JoinRequestsTab extends StatefulWidget {
  final TeamManageRepository repo;
  final TeamDetailsModel teamDetails;
  const _JoinRequestsTab({required this.repo, required this.teamDetails});

  @override
  State<_JoinRequestsTab> createState() => _JoinRequestsTabState();
}

class _JoinRequestsTabState extends State<_JoinRequestsTab>
    with AutomaticKeepAliveClientMixin {
  List<TeamJoinRequestModel>? _requests;
  bool _loading = true;
  String? _error;
  final _responding = <String>{};

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final data = await widget.repo.getJoinRequests();
      if (mounted) {
        setState(() {
          _requests = data;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  Future<void> _respond(TeamJoinRequestModel req, bool accept) async {
    final pid = req.playerId ?? '';
    if (pid.isEmpty || _responding.contains(pid)) return;
    setState(() => _responding.add(pid));
    try {
      await widget.repo.respondJoinRequest(
        playerId: pid,
        accept: accept,
        teamName: widget.teamDetails.teamName ?? '',
        teamImageUrl: widget.teamDetails.teamImage ?? '',
      );
      if (!mounted) return;
      setState(() {
        _requests?.removeWhere((r) => r.playerId == pid);
        _responding.remove(pid);
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          accept ? 'Request accepted' : 'Request rejected',
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: accept ? Colors.green : AppColors.socaBlack,
      ));
    } catch (e) {
      if (mounted) {
        setState(() => _responding.remove(pid));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(e.toString(), style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget content;
    if (_loading) {
      content = const SliverFillRemaining(child: Center(child: AppLoader()));
    } else if (_error != null) {
      content = SliverFillRemaining(
          child: _ErrorRetry(message: _error!, onRetry: _load));
    } else {
      final requests = _requests ?? [];
      if (requests.isEmpty) {
        content = const SliverFillRemaining(
            child: _EmptyState(
          message: 'No request for now ',
        ));
      } else {
        content = SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) {
                if (i.isOdd) return const SizedBox(height: 10);
                final index = i ~/ 2;
                final req = requests[index];
                final pid = req.playerId ?? '';
                final isResponding = _responding.contains(pid);
                return Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    child: Row(
                      children: [
                        _PlayerAvatar(
                          imageUrl: req.imageUrl,
                          name: req.name,
                          size: 44,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                req.name ?? 'Unknown',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: AppColors.socaBlack,
                                ),
                              ),
                              if (req.country?.isNotEmpty ?? false)
                                Text(
                                  req.country!,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              Text(
                                req.isCoach
                                    ? 'Coach'
                                    : req.isPlayer
                                        ? 'Player'
                                        : 'Member',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isResponding)
                          const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: AppColors.socaBlack),
                          )
                        else ...[
                          IconButton(
                            icon: const Icon(Icons.check_circle_outline,
                                color: Colors.green),
                            tooltip: 'Accept',
                            onPressed: () => _respond(req, true),
                          ),
                          IconButton(
                            icon: const Icon(Icons.cancel_outlined,
                                color: Colors.red),
                            tooltip: 'Reject',
                            onPressed: () => _respond(req, false),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
              childCount: math.max(0, requests.length * 2 - 1),
            ),
          ),
        );
      }
    }
    return RefreshIndicator(
      onRefresh: _load,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: TeamHeader(teamDetails: widget.teamDetails),
          ),
          content,
        ],
      ),
    );
  }
}

// ── Tab 1: New Players ────────────────────────────────────────────────────────

class _NewPlayersTab extends StatefulWidget {
  final TeamManageRepository repo;
  final TeamDetailsModel teamDetails;
  const _NewPlayersTab({required this.repo, required this.teamDetails});

  @override
  State<_NewPlayersTab> createState() => _NewPlayersTabState();
}

class _NewPlayersTabState extends State<_NewPlayersTab>
    with AutomaticKeepAliveClientMixin {
  List<TeamMemberModel>? _players;
  bool _loading = true;
  String? _error;
  bool _isSaving = false;

  /// In-progress jersey assignments keyed by player effectiveId
  final Map<String, TextEditingController> _jerseyCtrl = {};

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    for (final c in _jerseyCtrl.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final data = await widget.repo.getNewPlayers();
      if (mounted) {
        // Build controllers for each player
        for (final c in _jerseyCtrl.values) {
          c.dispose();
        }
        _jerseyCtrl.clear();
        for (final p in data) {
          _jerseyCtrl[p.effectiveId] =
              TextEditingController(text: p.jerseyNo ?? '');
        }
        setState(() {
          _players = data;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  Future<void> _assignAll() async {
    final players = _players;
    if (players == null || players.isEmpty) return;
    setState(() => _isSaving = true);
    try {
      final payload = players
          .map((p) => {
                'playerId': p.effectiveId,
                'teamJerseyNo': _jerseyCtrl[p.effectiveId]?.text.trim() ?? '',
              })
          .toList();
      await widget.repo.assignJerseys(payload);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.jerseysAssigned,
              style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.green,
        ),
      );
      _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(e.toString(), style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _openAddPlayer(BuildContext context) {
    context
        .pushNamed(
          'addTeamPlayer',
          pathParameters: {'teamId': widget.repo.teamId},
          extra: widget.teamDetails,
        )
        .then((_) => _load());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final header = _AddPlayerHeader(
      label: 'New Players',
      onAdd: () => _openAddPlayer(context),
    );

    Widget content;
    if (_loading) {
      content = const SliverFillRemaining(child: Center(child: AppLoader()));
    } else if (_error != null) {
      content = SliverFillRemaining(
          child: _ErrorRetry(message: _error!, onRetry: _load));
    } else {
      final players = _players ?? [];
      if (players.isEmpty) {
        content = const SliverFillRemaining(
            child: _EmptyState(message: 'No new players to assign jerseys'));
      } else {
        content = SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) {
                if (i.isOdd) return const SizedBox(height: 10);
                final index = i ~/ 2;
                final p = players[index];
                final ctrl = _jerseyCtrl[p.effectiveId];
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.name ?? 'Unknown',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.socaBlack,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${p.playPositionType ?? ''}  ${p.ageString}'
                                  .trim(),
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.socaBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 80,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border:
                            Border.all(color: AppColors.socaBlack, width: 1),
                      ),
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: ctrl,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        maxLength: 5,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.socaBlack,
                        ),
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          counterText: '',
                        ),
                      ),
                    ),
                  ],
                );
              },
              childCount: math.max(0, players.length * 2 - 1),
            ),
          ),
        );
      }
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: TeamHeader(teamDetails: widget.teamDetails),
          ),
          SliverToBoxAdapter(child: header),
          content,
          if (_players != null &&
              _players!.isNotEmpty &&
              !_loading &&
              _error == null)
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 70,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _assignAll,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.socaBlack,
                          disabledBackgroundColor: AppColors.socaBlack,
                          foregroundColor: AppColors.socaYellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          elevation: 0,
                        ),
                        child: _isSaving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.socaYellow),
                              )
                            : const Text(
                                'Assign Jersey',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: AppColors.socaYellow,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Tap in the empty square to add a jersey number',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Tab 2: Jersey Assigned ────────────────────────────────────────────────────

class _JerseyAssignedTab extends StatefulWidget {
  final TeamManageRepository repo;
  final TeamDetailsModel teamDetails;
  const _JerseyAssignedTab({required this.repo, required this.teamDetails});

  @override
  State<_JerseyAssignedTab> createState() => _JerseyAssignedTabState();
}

class _JerseyAssignedTabState extends State<_JerseyAssignedTab>
    with AutomaticKeepAliveClientMixin {
  List<TeamMemberModel>? _players;
  bool _loading = true;
  String? _error;
  final _acting = <String>{};

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final data = await widget.repo.getAssignedPlayers();
      if (mounted) {
        setState(() {
          _players = data;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  Future<void> _editJersey(TeamMemberModel player) async {
    final ctrl = TextEditingController(text: player.jerseyNo ?? '');
    final newNo = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'Edit Jersey — ${player.name ?? 'Player'}',
          style: const TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 15),
        ),
        content: CreateProfileTextField(
          controller: ctrl,
          autofocus: true,
          maxLength: 5,
          keyboardType: TextInputType.text,
          hintText: AppStrings.jerseyNumberHint,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(AppStrings.cancel.toUpperCase(),
                style:
                    const TextStyle(fontFamily: 'Poppins', color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.socaBlack,
              foregroundColor: AppColors.socaYellow,
              elevation: 0,
            ),
            onPressed: () => Navigator.of(ctx).pop(ctrl.text.trim()),
            child: Text(AppStrings.save,
                style: const TextStyle(fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
    ctrl.dispose();
    if (newNo == null || newNo.isEmpty || !mounted) return;

    final pid = player.effectiveId;
    setState(() => _acting.add(pid));
    try {
      await widget.repo.editJersey(playerId: pid, newJerseyNo: newNo);
      if (mounted) _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(e.toString(), style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ));
        setState(() => _acting.remove(pid));
      }
    }
  }

  Future<void> _removePlayer(TeamMemberModel player) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Text(
          'Remove ${player.name ?? 'this player'} from the team?',
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.socaBlack,
              side: const BorderSide(color: AppColors.socaBlack),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(AppStrings.yes,
                style: const TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.socaBlack,
              foregroundColor: AppColors.socaYellow,
              elevation: 0,
            ),
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(AppStrings.no,
                style: const TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final pid = player.effectiveId;
    setState(() => _acting.add(pid));
    try {
      await widget.repo.removePlayer(playerId: pid);
      if (mounted) _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(e.toString(), style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ));
        setState(() => _acting.remove(pid));
      }
    }
  }

  Future<void> _toggleAdmin(TeamMemberModel player) async {
    final pid = player.effectiveId;
    setState(() => _acting.add(pid));
    try {
      await widget.repo.toggleAdmin(playerId: pid, makeAdmin: !player.isAdmin);
      if (mounted) _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(e.toString(), style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ));
        setState(() => _acting.remove(pid));
      }
    }
  }

  TeamMemberModel? get _currentMember {
    final currentUserId = StorageService.userId ?? '';
    if (currentUserId.isEmpty) return null;
    for (final player in _players ?? <TeamMemberModel>[]) {
      if (player.effectiveId == currentUserId) return player;
    }
    return null;
  }

  bool _canAssignCoachManager(TeamMemberModel player, {required bool isCoach}) {
    if (player.isAdmin) return false;
    if (isCoach ? player.isCoach : player.isManager) return false;

    final current = _currentMember;
    if (current == null || current.isAdmin) return true;

    final currentIsCoachManager = current.isCoach || current.isManager;
    if (!currentIsCoachManager) return false;

    if (player.isCoach || player.isManager) return false;
    return true;
  }

  bool _canAccountTransfer(TeamMemberModel player) {
    final currentUserId = StorageService.userId ?? '';
    return player.type == 'addedPlayer' &&
        player.effectiveId.isNotEmpty &&
        player.effectiveId != currentUserId &&
        !player.isAdmin;
  }

  void _showActionSheet(TeamMemberModel player) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade200,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  player.jerseyNo?.isNotEmpty == true
                      ? player.jerseyNo!
                      : (player.name != null && player.name!.isNotEmpty
                          ? player.name![0].toUpperCase()
                          : ''),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                player.name ?? 'Unknown',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: AppColors.socaBlack,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                player.isPlayer
                    ? (player.playPositionType ?? '').trim()
                    : player.roleLabel,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Divider(height: 1, thickness: 1, color: Colors.grey.shade400),
              _buildActionItem('Edit jersey number', () {
                Navigator.pop(context);
                _editJersey(player);
              }),
              _buildActionItem(player.isAdmin ? 'Remove Admin' : 'Make Admin',
                  () {
                Navigator.pop(context);
                _toggleAdmin(player);
              }),
              if (_canAssignCoachManager(player, isCoach: true))
                _buildActionItem('Assign Team Coach', () {
                  Navigator.pop(context);
                  _assignCoachManager(player, isCoach: true);
                }),
              if (_canAssignCoachManager(player, isCoach: false))
                _buildActionItem('Assign Team Manager', () {
                  Navigator.pop(context);
                  _assignCoachManager(player, isCoach: false);
                }),
              if (_canAccountTransfer(player))
                _buildActionItem('Account Transfer', () {
                  Navigator.pop(context);
                  _accountTransfer(player);
                }),
              _buildActionItem('Remove From Team', () {
                Navigator.pop(context);
                _removePlayer(player);
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionItem(String title, VoidCallback onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.socaBlack,
              ),
            ),
          ),
        ),
        Divider(height: 1, thickness: 1, color: Colors.grey.shade400),
      ],
    );
  }

  Future<void> _assignCoachManager(
    TeamMemberModel player, {
    required bool isCoach,
  }) async {
    final pid = player.effectiveId;
    if (pid.isEmpty || _acting.contains(pid)) return;
    setState(() => _acting.add(pid));
    try {
      await widget.repo.assignCoachManager(playerId: pid, isCoach: isCoach);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          isCoach ? 'Team coach assigned' : 'Team manager assigned',
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.green,
      ));
      _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(e.toString(), style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ));
        setState(() => _acting.remove(pid));
      }
    }
  }

  Future<void> _accountTransfer(TeamMemberModel player) async {
    final pid = player.effectiveId;
    if (pid.isEmpty || _acting.contains(pid)) return;
    final transferred = await _showAccountTransferDialog(player);
    if (transferred == true && mounted) {
      _load();
    }
  }

  Future<bool?> _showAccountTransferDialog(TeamMemberModel player) async {
    final currentUser = StorageService.currentUser ?? {};
    final mobileCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final otpCtrl = TextEditingController();
    final countryCodeCtrl = TextEditingController(
      text: currentUser['phoneCode']?.toString() ??
          currentUser['countryDialCode']?.toString() ??
          currentUser['countryCode']?.toString() ??
          '',
    );
    final countryIsoCtrl = TextEditingController(
      text: currentUser['countryIso']?.toString() ??
          currentUser['countryIsoCode']?.toString() ??
          '',
    );
    final countryCtrl = TextEditingController(
      text: currentUser['country']?.toString() ?? '',
    );
    var otpRequested = false;
    var loading = false;
    String? error;

    try {
      return await showDialog<bool>(
        context: context,
        barrierDismissible: !loading,
        builder: (ctx) => StatefulBuilder(
          builder: (ctx, setDialogState) {
            Future<void> requestOtp() async {
              final mobile = mobileCtrl.text.trim();
              final password = passwordCtrl.text.trim();
              final countryCode = countryCodeCtrl.text.trim();
              final countryIso = countryIsoCtrl.text.trim();
              final country = countryCtrl.text.trim();

              if (mobile.isEmpty) {
                setDialogState(() => error = 'Please enter a mobile number');
                return;
              }
              if (mobile.length < 7) {
                setDialogState(
                    () => error = 'Please enter a valid mobile number');
                return;
              }
              if (password.isEmpty) {
                setDialogState(() => error = 'Please enter password');
                return;
              }

              setDialogState(() {
                loading = true;
                error = null;
              });
              try {
                final duplicate = await widget.repo.requestPlayerTransfer(
                  playerId: player.effectiveId,
                  mobile: mobile,
                  countryCode: countryCode,
                  countryIso: countryIso,
                  country: country,
                  password: password,
                );
                setDialogState(() {
                  loading = false;
                  otpRequested = !duplicate;
                  error = duplicate
                      ? 'Account with this mobile number already exists'
                      : null;
                });
              } catch (e) {
                setDialogState(() {
                  loading = false;
                  error = e.toString();
                });
              }
            }

            Future<void> verifyOtp() async {
              final otp = int.tryParse(otpCtrl.text.trim());
              if (otp == null) {
                setDialogState(() => error = 'Please enter OTP');
                return;
              }
              setDialogState(() {
                loading = true;
                error = null;
              });
              try {
                await widget.repo.verifyPlayerTransfer(
                  playerId: player.effectiveId,
                  otp: otp,
                );
                if (!ctx.mounted) return;
                Navigator.of(ctx).pop(true);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    'Account transfer successful',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  backgroundColor: Colors.green,
                ));
              } catch (e) {
                setDialogState(() {
                  loading = false;
                  error = e.toString();
                });
              }
            }

            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: Text(
                'Account Transfer — ${player.name ?? 'Player'}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CreateProfileTextField(
                      controller: mobileCtrl,
                      enabled: !otpRequested && !loading,
                      keyboardType: TextInputType.phone,
                      hintText: AppStrings.mobileNumber,
                    ),
                    const SizedBox(height: 8),
                    CreateProfileTextField(
                      controller: countryCodeCtrl,
                      enabled: !otpRequested && !loading,
                      hintText: AppStrings.countryCode,
                    ),
                    const SizedBox(height: 8),
                    CreateProfileTextField(
                      controller: countryIsoCtrl,
                      enabled: !otpRequested && !loading,
                      hintText: AppStrings.countryIso,
                    ),
                    const SizedBox(height: 8),
                    CreateProfileTextField(
                      controller: countryCtrl,
                      enabled: !otpRequested && !loading,
                      hintText: AppStrings.country,
                    ),
                    const SizedBox(height: 8),
                    CreateProfileTextField(
                      controller: passwordCtrl,
                      enabled: !otpRequested && !loading,
                      obscureText: true,
                      hintText: AppStrings.passwordHint,
                    ),
                    if (otpRequested) ...[
                      const SizedBox(height: 8),
                      CreateProfileTextField(
                        controller: otpCtrl,
                        enabled: !loading,
                        keyboardType: TextInputType.number,
                        hintText: AppStrings.otp,
                      ),
                    ],
                    if (error != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        error!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed:
                      loading ? null : () => Navigator.of(ctx).pop(false),
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.socaBlack,
                    foregroundColor: AppColors.socaYellow,
                    elevation: 0,
                  ),
                  onPressed:
                      loading ? null : (otpRequested ? verifyOtp : requestOtp),
                  child: loading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.socaYellow,
                          ),
                        )
                      : Text(
                          otpRequested ? 'VERIFY OTP' : 'SEND OTP',
                          style: const TextStyle(fontFamily: 'Poppins'),
                        ),
                ),
              ],
            );
          },
        ),
      );
    } finally {
      mobileCtrl.dispose();
      passwordCtrl.dispose();
      otpCtrl.dispose();
      countryCodeCtrl.dispose();
      countryIsoCtrl.dispose();
      countryCtrl.dispose();
    }
  }

  void _openAddPlayer(BuildContext context) {
    context
        .pushNamed(
          'addTeamPlayer',
          pathParameters: {'teamId': widget.repo.teamId},
          extra: widget.teamDetails,
        )
        .then((_) => _load());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final header = _AddPlayerHeader(
      label: 'Jersey Assigned',
      onAdd: () => _openAddPlayer(context),
    );

    Widget content;
    if (_loading) {
      content = const SliverFillRemaining(child: Center(child: AppLoader()));
    } else if (_error != null) {
      content = SliverFillRemaining(
          child: _ErrorRetry(message: _error!, onRetry: _load));
    } else {
      final players = _players ?? [];
      if (players.isEmpty) {
        content = const SliverFillRemaining(
            child: _EmptyState(message: 'No players with assigned jerseys'));
      } else {
        content = SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) {
                if (i.isOdd) return const SizedBox(height: 10);
                final index = i ~/ 2;
                final p = players[index];
                final pid = p.effectiveId;
                final isActing = _acting.contains(pid);
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _PlayerAvatar(
                          imageUrl: p.imageUrl,
                          name: p.name,
                          size: 40,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      p.name ?? 'Unknown',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: AppColors.socaBlack,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: AppColors.socaYellow,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppColors.socaBlack,
                                          width: 0.5),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                p.isPlayer
                                    ? '${p.playPositionType ?? ''}  ${p.ageString}'
                                        .trim()
                                    : p.ageString,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.socaBlack,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  if (p.roleLabel.isNotEmpty)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      margin: const EdgeInsets.only(right: 6),
                                      decoration: BoxDecoration(
                                        color: AppColors.socaBlack,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        p.roleLabel.toUpperCase(),
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 9,
                                          color: AppColors.socaYellow,
                                        ),
                                      ),
                                    ),
                                  if (p.isPlayer &&
                                      p.jerseyNo?.isNotEmpty == true)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.socaBlack,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        '#${p.jerseyNo}',
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 9,
                                          color: AppColors.socaYellow,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (isActing)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: AppColors.socaBlack),
                          )
                        else
                          IconButton(
                            icon: const Icon(Icons.more_vert,
                                color: AppColors.socaBlack),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => _showActionSheet(p),
                          ),
                      ],
                    ),
                  ),
                );
              },
              childCount: math.max(0, players.length * 2 - 1),
            ),
          ),
        );
      }
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: TeamHeader(teamDetails: widget.teamDetails),
          ),
          SliverToBoxAdapter(child: header),
          content,
        ],
      ),
    );
  }
}

enum _MemberAction {
  editJersey,
  toggleAdmin,
  assignTeamCoach,
  assignTeamManager,
  accountTransfer,
  remove,
}

// ── Shared helpers ────────────────────────────────────────────────────────────

/// Header row shown at the top of New Players and Jersey Assigned tabs.
/// Matches Android's right-aligned `addPlayers` LinearLayout (ic_person_add + "Add").
class _AddPlayerHeader extends StatelessWidget {
  final String label;
  final VoidCallback onAdd;
  const _AddPlayerHeader({required this.label, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: AppColors.socaBlack,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onAdd,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/ic_person_add.png',
                  width: 24,
                  height: 24,
                  color: AppColors.socaBlack,
                ),
                const SizedBox(width: 4),
                const Text(
                  'Add',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.socaBlack,
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

class _PlayerAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  const _PlayerAvatar({
    required this.imageUrl,
    this.name,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final url = (imageUrl != null && imageUrl!.isNotEmpty)
        ? '${ApiConstants.imageBaseUrl}$imageUrl'
        : '';
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color: Colors.grey.shade300,
        child: url.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => _defaultIcon(size),
              )
            : _defaultIcon(size),
      ),
    );
  }

  Widget _defaultIcon(double size) {
    if (name != null && name!.trim().isNotEmpty) {
      final parts = name!.trim().split(' ');
      String initials = '';
      if (parts.length > 1) {
        initials = '${parts.first[0]}${parts.last[0]}';
      } else {
        initials = parts.first.substring(0, math.min(2, parts.first.length));
      }
      return Center(
        child: Text(
          initials.toLowerCase(),
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: size * 0.45,
            color: Colors.grey.shade700,
          ),
        ),
      );
    }
    return Icon(
      Icons.person,
      size: size * 0.55,
      color: Colors.grey.shade600,
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String message;
  const _EmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.socaBlack,
          ),
        ),
      ),
    );
  }
}

class _ErrorRetry extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorRetry({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.socaBlack,
              foregroundColor: AppColors.socaYellow,
              elevation: 0,
            ),
            child: Text(AppStrings.retry,
                style: const TextStyle(fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }
}
