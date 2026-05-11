import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/home_feed_providers.dart';
import 'feed_section_header.dart';

class NewTeamsSection extends ConsumerStatefulWidget {
  const NewTeamsSection({super.key});

  @override
  ConsumerState<NewTeamsSection> createState() => _NewTeamsSectionState();
}

class _NewTeamsSectionState extends ConsumerState<NewTeamsSection> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(feedNewTeamsProvider);
    log("this is the data of the recently joined teams ${state.items}");

    if (state.isLoading) return const SizedBox.shrink();
    if (state.items.isEmpty) return const SizedBox.shrink();

    final itemCount = state.items.length + (state.isLoadingMore ? 1 : 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          width: double.infinity,
          color: AppColors.socaBlack,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recently Joined Teams',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaYellow,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to view all recently joined teams
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey.shade100, // Matches the spacing background
          height: 380, // adjusted height
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);

              if (index == state.items.length - 1 &&
                  state.hasMore &&
                  !state.isLoadingMore) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(feedNewTeamsProvider.notifier).loadMore();
                });
              }
            },
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index == state.items.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                );
              }

              final team = state.items[index];
              final teamLocation = [team.city, team.country]
                  .where((e) => e != null && e.isNotEmpty)
                  .join(', ');
              final joinedText = team.createdOn != null
                  ? _formatCreatedOn(team.createdOn!)
                  : null;

              final isFirst = _currentPage == 0;
              final isLast = _currentPage == state.items.length - 1;

              return Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Announcement section ───────────────────────────
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.asset(
                                    'assets/images/logo_transparent.png',
                                    color: Colors.white,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.sports_soccer,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Text(
                                          'SocaLoca',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.socaBlack,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.verified,
                                          color: AppColors.socaBlack,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      joinedText ?? '',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.socaGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: AppColors.socaBlack,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '${team.teamName ?? 'Team'} has joined SocaLoca!!!\n',
                                ),
                                const TextSpan(
                                  text: 'Check team bio',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Divider ────────────────────────────────────────
                    Container(
                        height: 0.5,
                        color: AppColors.socaGrey.withOpacity(0.2)),

                    // ── Profile row with chevron navigation ───────────
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 24),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: isFirst
                                ? null
                                : () => _pageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 350),
                                      curve: Curves.easeInOut,
                                    ),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 32,
                              color: isFirst
                                  ? AppColors.socaGrey.withOpacity(0.3)
                                  : AppColors.socaBlack,
                            ),
                          ),
                          const SizedBox(width: 12),
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.socaGrey.withAlpha(36),
                            backgroundImage: team.teamLogo != null &&
                                    team.teamLogo!.isNotEmpty &&
                                    !team.teamLogo!.startsWith('file:///')
                                ? NetworkImage(
                                    ApiConstants.getImageUrl(team.teamLogo))
                                : null,
                            child: team.teamLogo == null ||
                                    team.teamLogo!.isEmpty ||
                                    team.teamLogo!.startsWith('file:///')
                                ? const Icon(Icons.groups,
                                    size: 40, color: AppColors.socaGrey)
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        team.teamName ?? 'Team',
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.socaBlack,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (team.country != null &&
                                        team.country!.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          _countryFlag(team.country),
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  team.teamType ?? 'Club',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.socaBlack,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  teamLocation,
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
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: isLast
                                ? null
                                : () => _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 350),
                                      curve: Curves.easeInOut,
                                    ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 32,
                              color: isLast
                                  ? AppColors.socaGrey.withOpacity(0.3)
                                  : AppColors.socaBlack,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Divider ────────────────────────────────────────
                    Container(
                        height: 0.5,
                        color: AppColors.socaGrey.withOpacity(0.2)),

                    // ── Share button ───────────────────────────────────
                    InkWell(
                      onTap: () {
                        // TODO: implement share
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.share,
                                size: 18, color: AppColors.socaBlack),
                            SizedBox(width: 8),
                            Text(
                              'SHARE',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.socaBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // ── Page indicator dots ──────────────────────────────────────────
        if (state.items.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                state.items.length.clamp(0, 8),
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentPage == i ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? AppColors.primary
                        : AppColors.socaGrey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),

        const SizedBox(height: 16),
      ],
    );
  }

  String _formatCreatedOn(int createdOn) {
    final parsed = DateTime.fromMillisecondsSinceEpoch(createdOn);
    return '${_monthName(parsed.month)} ${parsed.day}, ${_formatTime(parsed)}';
  }

  String _formatTime(DateTime dateTime) {
    final hour =
        dateTime.hour == 0 || dateTime.hour == 12 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  String _monthName(int month) {
    const names = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return names[month - 1];
  }
}

class _TeamCard extends StatelessWidget {
  const _TeamCard({
    required this.team,
    required this.teamLocation,
    this.joinedText,
    this.onPrevious,
    this.onNext,
  });

  final dynamic team; // Replace with your actual Team model type
  final String teamLocation;
  final String? joinedText;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Announcement section ───────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _TeamAvatar(team: team, radius: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            team.teamName ?? 'Team',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (joinedText != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              joinedText!,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF888888),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.verified,
                      color: Color(0xFF1A73E8),
                      size: 22,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '${team.teamName ?? 'Team'} has joined SocaLoca!!!',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Check team bio',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),

          // ── Divider ────────────────────────────────────────────────────
          Container(height: 0.5, color: const Color(0xFFE8E8E8)),

          // ── Team profile row with navigation ──────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              children: [
                // Left chevron
                _NavChevron(
                  icon: Icons.chevron_left,
                  onTap: onPrevious,
                  enabled: onPrevious != null,
                ),
                const SizedBox(width: 4),

                // Team logo
                _TeamAvatar(team: team, radius: 28),
                const SizedBox(width: 12),

                // Team info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              team.teamName ?? 'Team',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A1A),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (team.country != null &&
                              team.country!.isNotEmpty) ...[
                            const SizedBox(width: 6),
                            Text(
                              _countryFlag(team.country),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 3),
                      if (team.teamType != null)
                        Text(
                          team.teamType!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF888888),
                          ),
                        ),
                      if (teamLocation.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          teamLocation,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 4),
                // Right chevron
                _NavChevron(
                  icon: Icons.chevron_right,
                  onTap: onNext,
                  enabled: onNext != null,
                ),
              ],
            ),
          ),

          // ── Divider ────────────────────────────────────────────────────
          Container(height: 0.5, color: const Color(0xFFE8E8E8)),

          // ── Share button ───────────────────────────────────────────────
          InkWell(
            onTap: () {
              // TODO: implement share
            },
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.ios_share_rounded,
                      size: 18, color: Color(0xFF1A1A1A)),
                  SizedBox(width: 8),
                  Text(
                    'SHARE',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                      letterSpacing: 0.5,
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

/// Naive flag emoji helper — replace with a proper package if needed.
String _countryFlag(String? country) {
  if (country == null) return '';
  const map = {
    'Ghana': '🇬🇭',
    'Nigeria': '🇳🇬',
    'USA': '🇺🇸',
    'UK': '🇬🇧',
    'Brazil': '🇧🇷',
    'France': '🇫🇷',
    'Germany': '🇩🇪',
    'Spain': '🇪🇸',
    'India': '🇮🇳',
  };
  return map[country] ?? '🇬🇭'; // Default to Ghana as fallback if unknown
}

// ─── Reusable sub-widgets ────────────────────────────────────────────────────

class _TeamAvatar extends StatelessWidget {
  const _TeamAvatar({required this.team, required this.radius});
  final dynamic team;
  final double radius;

  bool get _hasLogo =>
      team.teamLogo != null &&
      team.teamLogo!.isNotEmpty &&
      !team.teamLogo!.startsWith('file:///');

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFFEEEEEE),
      backgroundImage: _hasLogo
          ? NetworkImage(ApiConstants.getImageUrl(team.teamLogo))
          : null,
      child: _hasLogo
          ? null
          : Icon(Icons.groups,
              size: radius * 1.1, color: const Color(0xFF888888)),
    );
  }
}

class _NavChevron extends StatelessWidget {
  const _NavChevron({
    required this.icon,
    required this.enabled,
    this.onTap,
  });
  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 28,
        color: enabled ? const Color(0xFF888888) : const Color(0xFFCCCCCC),
      ),
    );
  }
}
