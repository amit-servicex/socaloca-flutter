import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../player_bio/providers/player_bio_provider.dart';
import '../data/skill_rating_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

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

  Widget _buildBannerSection() {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          // Banner Image (placeholder for now)
          Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey[300]!,
                    Colors.grey[400]!,
                  ],
                ),
              ),
              child: Image.asset("assets/images/tournament_defalut_banner.jpg",
                  fit: BoxFit.cover)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: SafeArea(child: _buildBody())),
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
          _buildBannerSection(),

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
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.socaBlack, width: 3),
              color: AppColors.socaGrey,
            ),
            child: ClipOval(
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? Image.network(
                      ApiConstants.getImageUrl(imageUrl),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.person,
                        size: 40,
                        color: AppColors.socaBlack,
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Skill & Attribute Rating',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.socaBlack,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '1 - Basic  |  2 - Average  |  3 - Good  |  4 - Very Good  |  5 - Outstanding',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.socaBlack,
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
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 5,
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
              color: AppColors.socaGrey,
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

class _SkillCell extends StatefulWidget {
  final SkillRatingModel skill;
  final bool isLast;
  final String userId;

  const _SkillCell(
      {required this.skill, required this.isLast, required this.userId});

  @override
  State<_SkillCell> createState() => _SkillCellState();
}

class _SkillCellState extends State<_SkillCell> {
  late double _sliderValue;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.skill.myRating > 0
        ? widget.skill.myRating.toDouble().clamp(1.0, 5.0)
        : 1.0;
  }

  String _displayName(String? raw) => raw ?? '';

  Future<void> _submitRating(double rating) async {
    if (_isSubmitting) return;
    setState(() => _isSubmitting = true);

    try {
      final user = StorageService.currentUser;
      final myId = user?['userId'] ?? user?['_id'] ?? user?['id'] ?? '';
      final firstName = user?['firstName'] as String? ?? '';
      final lastName = user?['lastName'] as String? ?? '';
      final myName = '$firstName $lastName'.trim();
      final myImageUrl = user?['imageUrl'] as String? ?? '';
      final isPlayer = user?['isPlayer'] as bool? ?? false;
      final isCoach = user?['isCoach'] as bool? ?? false;
      final isAdmin = user?['isAdmin'] as bool? ?? false;
      final isFan = user?['isFan'] as bool? ?? false;

      await ApiClient.instance.post(
        ApiConstants.endorsePlayer,
        body: {
          'userId': myId,
          'playerId': widget.userId,
          'skillShort': widget.skill.skillShort ?? widget.skill.skillName ?? '',
          'skillName': _displayName(widget.skill.skillName),
          'isPlayer': isPlayer,
          'isCoach': isCoach,
          'isAdmin': isAdmin,
          'isFan': isFan,
          'myName': myName,
          'myImageUrl': myImageUrl,
          'myRating': rating.toInt(),
        },
      );
    } catch (_) {
      // silent — slider value is already shown to user
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.skill.ratingCounter;
    final hasRatings = count > 0;
    final endorseText =
        count == 1 ? '1 person endorsed' : '$count people endorsed';
    final isOwnProfile = StorageService.userId == widget.userId;

    return GestureDetector(
      onTap: () {
        if (widget.skill.skillName == null) return;
        context.push(
          AppRoutes.skillDetail,
          extra: {
            'playerId': widget.userId,
            'skillName': _displayName(widget.skill.skillName),
            'skillShort':
                widget.skill.skillShort ?? widget.skill.skillName ?? '',
          },
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left: skill name + endorsement badge
                SizedBox(
                  width: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _displayName(widget.skill.skillName),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaBlack,
                        ),
                      ),
                      if (hasRatings) ...[
                        const SizedBox(height: 2),
                        Text(
                          _isSubmitting ? 'Saving…' : endorseText,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Center: slider with 1 / 5 labels (hidden when viewing own profile)
                if (!isOwnProfile) ...[
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        '1',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.socaBlack,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 2,
                            activeTrackColor: AppColors.socaBlack,
                            inactiveTrackColor: Colors.grey.shade300,
                            thumbColor: AppColors.socaBlack,
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 7),
                            overlayColor:
                                AppColors.socaBlack.withValues(alpha: 0.12),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 14),
                            valueIndicatorColor: AppColors.socaBlack,
                            valueIndicatorTextStyle: const TextStyle(
                              color: AppColors.socaYellow,
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                            showValueIndicator: ShowValueIndicator.onDrag,
                            valueIndicatorShape:
                                const PaddleSliderValueIndicatorShape(),
                          ),
                          child: Slider(
                            value: _sliderValue,
                            min: 1,
                            max: 5,
                            divisions: 4,
                            label: _sliderValue.toInt().toString(),
                            onChanged: (v) => setState(() => _sliderValue = v),
                            onChangeEnd: _submitRating,
                          ),
                        ),
                      ),
                      const Text(
                        '5',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ],
                  ),
                ], // end if (!isOwnProfile)

                // Right: average rating
                const SizedBox(width: 8),
              ],
            ),
          ),
          if (hasRatings)
            SizedBox(
              width: 32,
              child: Text(
                widget.skill.skillAvg.toStringAsFixed(1),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaBlack,
                ),
              ),
            ),
          if (!widget.isLast)
            const Divider(
                height: 1, thickness: 0.5, color: AppColors.socaBlack),
        ],
      ),
    );
  }
}
