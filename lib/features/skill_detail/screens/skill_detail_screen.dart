import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/router/app_routes.dart';
import '../data/skill_rater_model.dart';
import '../widgets/skill_rater_tile.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Shows all raters (coaches / players / managers / fans) for one skill.
/// Mirrors Android SkillDetailsFragment.
class SkillDetailScreen extends StatefulWidget {
  final String playerId;
  final String skillName;
  final String skillShort;

  const SkillDetailScreen({
    super.key,
    required this.playerId,
    required this.skillName,
    required this.skillShort,
  });

  @override
  State<SkillDetailScreen> createState() => _SkillDetailScreenState();
}

class _SkillDetailScreenState extends State<SkillDetailScreen> {
  bool _isLoading = true;
  String? _error;
  int _totalCount = 0;

  List<SkillRaterModel> _coaches = [];
  List<SkillRaterModel> _players = [];
  List<SkillRaterModel> _admins = [];
  List<SkillRaterModel> _fans = [];

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
      final userId = StorageService.userId ?? '';
      final response = await ApiClient.instance.post(
        ApiConstants.getEndorsesSummary,
        body: {
          'userId': userId,
          'playerId': widget.playerId,
          'skillShort': widget.skillShort,
        },
      );
      final raw = response['response'];
      if ((raw?['status'] as num?)?.toInt() == 1) {
        _totalCount = (raw['totalCount'] as num?)?.toInt() ?? 0;
        _coaches = _parseList(raw['coaches']);
        _players = _parseList(raw['players']);
        _admins = _parseList(raw['admins']);
        _fans = _parseList(raw['fans']);
      } else {
        _error = 'Failed to load endorsements';
      }
    } catch (e) {
      _error = e.toString();
    }
    if (mounted) setState(() => _isLoading = false);
  }

  List<SkillRaterModel> _parseList(dynamic raw) {
    if (raw is! List) return [];
    return raw
        .map((e) => SkillRaterModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  void _viewAll(String role, String roleLabel) {
    context.push(
      AppRoutes.skillDetailViewAll,
      extra: {
        'playerId': widget.playerId,
        'skillName': widget.skillName,
        'skillShort': widget.skillShort,
        'role': role,
        'roleLabel': roleLabel,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const AppLoader();
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 12),
            Text(_error!,
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 14)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _load,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                foregroundColor: AppColors.socaYellow,
              ),
              child:
                  const Text('Retry', style: TextStyle(fontFamily: 'Poppins')),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header: skill name + total endorsed count ──────────────────
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Text(
                  widget.skillName,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
                const SizedBox(width: 10),
                if (_totalCount > 0)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$_totalCount ${_totalCount == 1 ? 'person' : 'people'} endorsed',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),

          // ── Role sections ──────────────────────────────────────────────
          _RoleSection(
            title: 'Coaches',
            raters: _coaches,
            emptyText: 'Coaches yet to endorse',
            onViewAll: () => _viewAll('coach', 'Coaches'),
          ),
          const SizedBox(height: 12),
          _RoleSection(
            title: 'Players',
            raters: _players,
            emptyText: 'Players yet to endorse',
            showPosition: true,
            onViewAll: () => _viewAll('player', 'Players'),
          ),
          const SizedBox(height: 12),
          _RoleSection(
            title: 'Managers',
            raters: _admins,
            emptyText: 'Managers yet to endorse',
            onViewAll: () => _viewAll('admin', 'Managers'),
          ),
          const SizedBox(height: 12),
          _RoleSection(
            title: 'Fans',
            raters: _fans,
            emptyText: 'Fans yet to endorse',
            onViewAll: () => _viewAll('fan', 'Fans'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Role Section ───────────────────────────────────────────────────────────────

class _RoleSection extends StatelessWidget {
  final String title;
  final List<SkillRaterModel> raters;
  final String emptyText;
  final bool showPosition;
  final VoidCallback onViewAll;

  const _RoleSection({
    required this.title,
    required this.raters,
    required this.emptyText,
    this.showPosition = false,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row: title + view all button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
                if (raters.isNotEmpty)
                  GestureDetector(
                    onTap: onViewAll,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.socaBlack,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.socaYellow,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 0.5, color: Colors.black12),

          // List or empty state
          if (raters.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  emptyText,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          else
            Column(
              children: [
                for (int i = 0; i < raters.length; i++)
                  SkillRaterTile(
                    rater: raters[i],
                    showPosition: showPosition,
                    isLast: i == raters.length - 1,
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
