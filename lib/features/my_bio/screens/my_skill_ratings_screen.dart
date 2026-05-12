import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../player_bio/providers/player_bio_provider.dart';
import '../data/skill_rating_model.dart';

// ── Skill category constants (mirror Android MyEndorsementsFragment) ──────────
const _technical = [
  'First Touch',
  'Short Passing',
  'Tackling',
  'Dribbling',
  'Pressing',
  'Long Passing',
  'Heading',
  'Shooting',
  'Finishing',
  'Free Kick',
  'Crossing',
];
const _physical = [
  'Acceleration',
  'Strength',
  'Stamina',
  'Balance',
  'Work Rate',
];
const _mental = [
  'Awareness',
  'Positioning',
  'Aggression',
  'Composure',
  'Creativity',
  'Team Work',
  'Leadership',
];
const _goalkeeper = [
  'Aerial Ability',
  'Command of Area',
  'Handling',
  'Kicking',
  'Reflexes',
  'Throwing',
];

/// My Skill Ratings screen — mirrors Android MyEndorsementsFragment.
class MySkillRatingsScreen extends ConsumerStatefulWidget {
  final String userId;

  const MySkillRatingsScreen({super.key, required this.userId});

  @override
  ConsumerState<MySkillRatingsScreen> createState() =>
      _MySkillRatingsScreenState();
}

class _MySkillRatingsScreenState extends ConsumerState<MySkillRatingsScreen> {
  bool _isLoading = true;
  String? _error;
  double _overall = 0;
  double _technicalAvg = 0;
  double _physicalAvg = 0;
  double _mentalAvg = 0;
  double _goalkeeperAvg = 0;

  List<SkillRatingModel> _technicalSkills = [];
  List<SkillRatingModel> _physicalSkills = [];
  List<SkillRatingModel> _mentalSkills = [];
  List<SkillRatingModel> _goalkeeperSkills = [];

  @override
  void initState() {
    super.initState();
    _load();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bioState = ref.read(playerBioProvider(widget.userId));
      if (bioState.playerBio == null && !bioState.isLoading) {
        ref.read(playerBioProvider(widget.userId).notifier).load();
      }
    });
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getMySkillSet,
        body: {'playerId': widget.userId},
      );

      if (response['response']?['status'] == 1) {
        final raw = response['response'];
        _overall = (raw['overall'] as num?)?.toDouble() ?? 0;
        final avrgs = raw['avrgs'] as Map<String, dynamic>? ?? {};
        _technicalAvg = (avrgs['technical'] as num?)?.toDouble() ?? 0;
        _physicalAvg = (avrgs['physical'] as num?)?.toDouble() ?? 0;
        _mentalAvg = (avrgs['mental'] as num?)?.toDouble() ?? 0;
        _goalkeeperAvg = (avrgs['goalkeeper'] as num?)?.toDouble() ?? 0;

        final skills = (raw['skills'] as List?)
                ?.map(
                    (s) => SkillRatingModel.fromJson(s as Map<String, dynamic>))
                .toList() ??
            [];

        _technicalSkills =
            skills.where((s) => _technical.contains(s.skillName)).toList();
        _physicalSkills =
            skills.where((s) => _physical.contains(s.skillName)).toList();
        _mentalSkills =
            skills.where((s) => _mental.contains(s.skillName)).toList();
        _goalkeeperSkills =
            skills.where((s) => _goalkeeper.contains(s.skillName)).toList();
      } else {
        _error = 'Failed to load ratings';
      }
    } catch (e) {
      _error = e.toString();
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: SafeArea(child: SafeArea(child: _buildBody())),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.socaYellow),
      );
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 16),
            Text(_error!,
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 14)),
            const SizedBox(height: 16),
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

    final bioState = ref.watch(playerBioProvider(widget.userId));
    final playerBio = bioState.playerBio;
    final playPosition = playerBio?.playPosition ?? '';

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 1. User Profile Section ──────────────────────────────────────
          _ProfileSection(
            imageUrl: playerBio?.imageUrl,
            firstName: playerBio?.firstName ?? '',
            lastName: playerBio?.lastName ?? '',
            isOnline: playerBio?.isOnline ?? false,
            playPosition: playPosition,
            playPositionType: playerBio?.playPositionType ?? '',
            overall: _overall,
          ),

          // ── 2. Thin divider ──────────────────────────────────────────────
          const Divider(height: 1, thickness: 0.5, color: AppColors.socaBlack),

          // ── 3. Rating Legend ─────────────────────────────────────────────
          const _RatingLegend(),

          // ── 4. Category Boxes ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                if (_technicalSkills.isNotEmpty) ...[
                  _CategoryBox(
                    title: 'Technical',
                    avg: _technicalAvg,
                    skills: _technicalSkills,
                    userId: widget.userId,
                  ),
                  const SizedBox(height: 12),
                ],
                if (_physicalSkills.isNotEmpty) ...[
                  _CategoryBox(
                    title: 'Physical',
                    avg: _physicalAvg,
                    skills: _physicalSkills,
                    userId: widget.userId,
                  ),
                  const SizedBox(height: 12),
                ],
                if (_mentalSkills.isNotEmpty) ...[
                  _CategoryBox(
                    title: 'Mental',
                    avg: _mentalAvg,
                    skills: _mentalSkills,
                    userId: widget.userId,
                  ),
                  const SizedBox(height: 12),
                ],
                if (_goalkeeperSkills.isNotEmpty &&
                    playPosition == 'Goalkeeper') ...[
                  _CategoryBox(
                    title: 'Goalkeeper',
                    avg: _goalkeeperAvg,
                    skills: _goalkeeperSkills,
                    userId: widget.userId,
                  ),
                  const SizedBox(height: 12),
                ],
                if (_technicalSkills.isEmpty &&
                    _physicalSkills.isEmpty &&
                    _mentalSkills.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text(
                        'No skill ratings yet.\nGet endorsed by coaches and managers to see your ratings here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Profile Section ────────────────────────────────────────────────────────────

class _ProfileSection extends StatelessWidget {
  final String? imageUrl;
  final String firstName;
  final String lastName;
  final bool isOnline;
  final String playPosition;
  final String playPositionType;
  final double overall;

  const _ProfileSection({
    required this.imageUrl,
    required this.firstName,
    required this.lastName,
    required this.isOnline,
    required this.playPosition,
    required this.playPositionType,
    required this.overall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.socaPageBg,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              color: Colors.grey.shade200,
            ),
            child: ClipOval(
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? Image.network(
                      ApiConstants.getImageUrl(imageUrl),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.grey,
                      ),
                    )
                  : const Icon(Icons.person, size: 40, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 12),

          // Name + position
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First name row with online indicator
                Row(
                  children: [
                    Text(
                      firstName,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    if (isOnline) ...[
                      const SizedBox(width: 6),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ],
                ),
                // Last name
                Text(
                  lastName,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
                if (playPosition.isNotEmpty)
                  Text(
                    playPosition,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaBlack,
                    ),
                  ),
                if (playPositionType.isNotEmpty)
                  Text(
                    playPositionType,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.socaBlack,
                    ),
                  ),
              ],
            ),
          ),

          // Overall score box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.socaBlack,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'OVERALL\nSCORE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.socaYellow,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  overall.toStringAsFixed(1),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaYellow,
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

// ── Rating Legend ──────────────────────────────────────────────────────────────

class _RatingLegend extends StatelessWidget {
  const _RatingLegend();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Skill & Attribute Rating',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.socaBlack,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '1 - Basic  |  2 - Average  |  3 - Good  |  4 - Very Good  |  5 - Outstanding',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Category Box ───────────────────────────────────────────────────────────────

class _CategoryBox extends StatelessWidget {
  final String title;
  final double avg;
  final List<SkillRatingModel> skills;
  final String userId;

  const _CategoryBox({
    required this.title,
    required this.avg,
    required this.skills,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
                Text(
                  avg.toStringAsFixed(1),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
              ],
            ),
          ),

          // Skills list in rounded grey container
          Container(
            margin: const EdgeInsets.fromLTRB(8, 0, 8, 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                for (int i = 0; i < skills.length; i++)
                  _SkillCell(
                    skill: skills[i],
                    isLast: i == skills.length - 1,
                    userId: userId,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Skill Cell ─────────────────────────────────────────────────────────────────

class _SkillCell extends StatelessWidget {
  final SkillRatingModel skill;
  final bool isLast;
  final String userId;

  const _SkillCell(
      {required this.skill, required this.isLast, required this.userId});

  String _displayName(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    // The API returns properly formatted names like "First Touch"
    return raw;
  }

  @override
  Widget build(BuildContext context) {
    final count = skill.ratingCounter;
    final hasRatings = count > 0;
    final endorseText =
        count == 1 ? '1 person endorsed' : '$count people endorsed';

    return GestureDetector(
      onTap: () {
        if (skill.skillName == null) return;
        context.push(
          AppRoutes.skillDetail,
          extra: {
            'playerId': userId,
            'skillName': _displayName(skill.skillName),
            'skillShort': skill.skillShort ?? skill.skillName ?? '',
          },
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left: skill name + endorsement count
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _displayName(skill.skillName),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaBlack,
                        ),
                      ),
                      if (hasRatings) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            endorseText,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Right: average rating (only if rated)
                if (hasRatings)
                  Text(
                    skill.skillAvg.toStringAsFixed(1),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.socaBlack,
                    ),
                  ),
              ],
            ),
          ),
          if (!isLast)
            const Divider(height: 1, thickness: 0.5, color: Colors.black12),
        ],
      ),
    );
  }
}
