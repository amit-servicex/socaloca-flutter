import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/pickup_match_data.dart';

/// Card displaying a single pickup match in the list.
class PickupMatchCard extends StatelessWidget {
  final PickupMatchData match;
  final VoidCallback onTap;

  const PickupMatchCard({
    super.key,
    required this.match,
    required this.onTap,
  });

  String _formatDate() {
    if (match.matchDate.isEmpty) return '';
    try {
      final date = DateFormat('yyyy-MM-dd').parse(match.matchDate);
      return DateFormat('EEE, MMM d').format(date);
    } catch (_) {
      return match.matchDate;
    }
  }

  String _formatTime() {
    if (match.startTimeGmt == 0) return match.startTime;
    final dt =
        DateTime.fromMillisecondsSinceEpoch(match.startTimeGmt).toLocal();
    return DateFormat('h:mm a').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final hasRequest = match.myRequest != null;
    final isAccepted = match.myRequest?.isAccepted ?? false;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Age group + gender badge row
            Container(
              decoration: const BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  _Badge(label: match.ageGroup),
                  const SizedBox(width: 8),
                  _Badge(label: _genderLabel(match.gender)),
                  const Spacer(),
                  if (hasRequest)
                    _StatusChip(
                        isAccepted: isAccepted,
                        isWaiting: match.myRequest?.isWaiting ?? false),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Venue
                  Text(
                    match.venue.isNotEmpty ? match.venue : match.locationName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppColors.socaBlack,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Date & time
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 13, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        '${_formatDate()}  •  ${_formatTime()}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Location
                  if (match.locationName.isNotEmpty)
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 13, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            match.locationName,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),

                  // Footer: creator info + max players
                  Row(
                    children: [
                      _CreatorAvatar(imageUrl: match.creatorDetails?.imageUrl),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          match.creatorDetails?.name ?? 'Host',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppColors.socaBlack,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.group,
                              size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            'Max ${match.maxPlayers}',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _genderLabel(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return 'Male';
      case 'female':
        return 'Female';
      case 'mixed':
        return 'Mixed';
      default:
        return gender;
    }
  }
}

class _Badge extends StatelessWidget {
  final String label;
  const _Badge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.socaYellow,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 11,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final bool isAccepted;
  final bool isWaiting;
  const _StatusChip({required this.isAccepted, required this.isWaiting});

  @override
  Widget build(BuildContext context) {
    final label =
        isAccepted ? 'Accepted' : (isWaiting ? 'Pending' : 'Declined');
    final color = isAccepted
        ? AppColors.success
        : (isWaiting ? AppColors.warning : AppColors.error);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 11,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _CreatorAvatar extends StatelessWidget {
  final String? imageUrl;
  const _CreatorAvatar({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final url = ApiConstants.getImageUrl(imageUrl);
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.socaGrey,
      ),
      child: ClipOval(
        child: url.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const Icon(Icons.person,
                    size: 16, color: AppColors.socaBlack),
              )
            : const Icon(Icons.person, size: 16, color: AppColors.socaBlack),
      ),
    );
  }
}
