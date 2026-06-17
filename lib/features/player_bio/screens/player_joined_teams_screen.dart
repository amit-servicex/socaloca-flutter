import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/storage/storage_service.dart';
import '../providers/player_bio_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

final _playerJoinedTeamsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>(
  (ref, playerId) async {
    final user = StorageService.currentUser;
    final country = (user?['country'] as String?) ?? '';
    final repo = ref.watch(playerBioRepositoryProvider);
    return repo.getPlayerJoinedTeams(playerId: playerId, country: country);
  },
);

class PlayerJoinedTeamsScreen extends ConsumerWidget {
  final String playerId;

  PlayerJoinedTeamsScreen({super.key, required this.playerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamsAsync = ref.watch(_playerJoinedTeamsProvider(playerId));

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        title: Text('Joined Teams'.tr),
        backgroundColor: AppColors.socaBlack,
        foregroundColor: AppColors.socaYellow,
        elevation: 0,
      ),
      body: teamsAsync.when(
        loading: () => AppLoader(),
        error: (e, _) => Center(
          child: Text('Error: $e',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
        ),
        data: (teams) {
          if (teams.isEmpty) {
            return Center(
              child: Text(
                'No joined teams.'.tr,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack),
              ),
            );
          }
          // Sort by sortId descending if available
          final sorted = List<Map<String, dynamic>>.from(teams);
          sorted.sort((a, b) {
            final aSort = a['sortId']?.toString() ?? '';
            final bSort = b['sortId']?.toString() ?? '';
            return bSort.compareTo(aSort);
          });
          return ListView.separated(
            padding: EdgeInsets.all(12),
            itemCount: sorted.length,
            separatorBuilder: (_, __) => SizedBox(height: 8),
            itemBuilder: (context, i) {
              final team = sorted[i];
              final teamId =
                  team['teamId'] as String? ?? team['_id'] as String? ?? '';
              final teamName = team['teamName'] as String? ?? 'Unknown Team';
              final imageUrl = team['imageUrl'] as String? ?? '';
              return Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
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
                      Icon(Icons.chevron_right, color: AppColors.socaBlack),
                  onTap: teamId.isNotEmpty
                      ? () => context.push(
                          AppRoutes.teamBio.replaceFirst(':teamId', teamId))
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
