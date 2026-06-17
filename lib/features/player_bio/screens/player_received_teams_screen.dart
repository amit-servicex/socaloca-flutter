import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/player_bio_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class PlayerReceivedTeamsScreen extends ConsumerStatefulWidget {
  PlayerReceivedTeamsScreen({super.key});

  @override
  ConsumerState<PlayerReceivedTeamsScreen> createState() =>
      _PlayerReceivedTeamsScreenState();
}

class _PlayerReceivedTeamsScreenState
    extends ConsumerState<PlayerReceivedTeamsScreen> {
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
    final userId = StorageService.userId;
    if (userId == null) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final repo = ref.read(playerBioRepositoryProvider);
      final teams = await repo.getTeamPlayerInvites(
          userId: userId, start: 0, limit: _limit);
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
    final userId = StorageService.userId;
    if (userId == null) return;
    setState(() => _isLoadingMore = true);
    try {
      final repo = ref.read(playerBioRepositoryProvider);
      final teams = await repo.getTeamPlayerInvites(
          userId: userId, start: _start, limit: _limit);
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
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  Future<void> _respond(
      Map<String, dynamic> team, int index, bool accept) async {
    final userId = StorageService.userId;
    final currentUser = StorageService.currentUser;
    if (userId == null || currentUser == null) return;

    final teamId = team['teamId'] as String? ?? team['_id'] as String? ?? '';
    if (teamId.isEmpty) return;

    try {
      final repo = ref.read(playerBioRepositoryProvider);
      final success = await repo.respondTeamPlayer(
        teamId: teamId,
        userId: userId,
        accept: accept,
        teamName: team['teamName'] as String? ?? '',
        myName:
            '${currentUser['firstName'] ?? ''} ${currentUser['lastName'] ?? ''}'
                .trim(),
        myImageUrl: currentUser['imageUrl'] as String? ?? '',
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
            content: Text('Error: $e', style: TextStyle(fontFamily: 'Poppins')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        title: Text('Team Invitations'.tr),
        backgroundColor: AppColors.socaBlack,
        foregroundColor: AppColors.socaYellow,
        elevation: 0,
      ),
      body: _isLoading
          ? AppLoader()
          : _error != null
              ? Center(
                  child: Text('Error: $_error',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 14)))
              : _teams.isEmpty
                  ? Center(
                      child: Text('No team invitations.'.tr,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: AppColors.socaBlack)))
                  : ListView.separated(
                      controller: _scrollController,
                      padding: EdgeInsets.all(12),
                      itemCount: _teams.length + (_isLoadingMore ? 1 : 0),
                      separatorBuilder: (_, __) => SizedBox(height: 8),
                      itemBuilder: (context, i) {
                        if (i == _teams.length) {
                          return AppLoader();
                        }
                        final team = _teams[i];
                        final teamId = team['teamId'] as String? ??
                            team['_id'] as String? ??
                            '';
                        final teamName =
                            team['teamName'] as String? ?? 'Unknown Team';
                        final imageUrl = team['imageUrl'] as String? ?? '';
                        return Card(
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: imageUrl.isNotEmpty
                                      ? NetworkImage(imageUrl)
                                      : null,
                                  backgroundColor: AppColors.socaGrey,
                                  child: imageUrl.isEmpty
                                      ? Icon(Icons.group,
                                          color: AppColors.socaBlack)
                                      : null,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: teamId.isNotEmpty
                                        ? () => context.push(AppRoutes.teamBio
                                            .replaceFirst(':teamId', teamId))
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
                                  onPressed: () => _respond(team, i, true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    elevation: 0,
                                  ),
                                  child: Text('Accept'.tr,
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                ),
                                SizedBox(width: 6),
                                ElevatedButton(
                                  onPressed: () => _respond(team, i, false),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    elevation: 0,
                                  ),
                                  child: Text('Decline'.tr,
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
