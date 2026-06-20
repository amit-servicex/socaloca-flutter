import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/player_bio_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class PlayerPendingTeamsScreen extends ConsumerStatefulWidget {
  final String playerId;

  const PlayerPendingTeamsScreen({super.key, required this.playerId});

  @override
  ConsumerState<PlayerPendingTeamsScreen> createState() =>
      _PlayerPendingTeamsScreenState();
}

class _PlayerPendingTeamsScreenState
    extends ConsumerState<PlayerPendingTeamsScreen> {
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
      final teams = await repo.getPlayerPendingTeams(playerId: widget.playerId);
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

  Future<void> _cancel(Map<String, dynamic> team, int index) async {
    final teamId = team['teamId'] as String? ?? team['_id'] as String? ?? '';
    if (teamId.isEmpty) return;

    try {
      final repo = ref.read(playerBioRepositoryProvider);
      final success = await repo.cancelTeamJoinRequest(
        playerId: widget.playerId,
        teamId: teamId,
      );
      if (success && mounted) {
        setState(() => _teams.removeAt(index));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Request cancelled.'.tr,
                style: const TextStyle(fontFamily: 'Poppins')),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e',
                style: const TextStyle(fontFamily: 'Poppins')),
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
        title: Text('Pending Requests'.tr),
        backgroundColor: AppColors.socaBlack,
        foregroundColor: AppColors.socaYellow,
        elevation: 0,
      ),
      body: _isLoading
          ? const AppLoader()
          : _error != null
              ? Center(
                  child: Text('Error: $_error',
                      style:
                          const TextStyle(fontFamily: 'Poppins', fontSize: 14)))
              : _teams.isEmpty
                  ? Center(
                      child: Text('No pending requests.'.tr,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: AppColors.socaBlack)))
                  : ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: _teams.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, i) {
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
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: imageUrl.isNotEmpty
                                  ? NetworkImage(imageUrl)
                                  : null,
                              backgroundColor: AppColors.socaGrey,
                              child: imageUrl.isEmpty
                                  ? const Icon(Icons.group,
                                      color: AppColors.socaBlack)
                                  : null,
                            ),
                            title: Text(
                              teamName,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.socaBlack,
                              ),
                            ),
                            trailing: TextButton(
                              onPressed: () => _cancel(team, i),
                              child: Text(
                                'Cancel'.tr,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            onTap: teamId.isNotEmpty
                                ? () => context.push(AppRoutes.teamBio
                                    .replaceFirst(':teamId', teamId))
                                : null,
                          ),
                        );
                      },
                    ),
    );
  }
}
