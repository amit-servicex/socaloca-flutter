import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/pickup_match_model.dart';

/// Pickup Match Card Widget
class PickupMatchCard extends StatelessWidget {
  PickupMatchCard({
    super.key,
    required this.match,
    this.onTap,
  });

  final PickupMatchModel match;
  final VoidCallback? onTap;

  String _formatDate() {
    if (match.startTimeGmt == 0) return match.matchDate ?? '';
    final date = DateTime.fromMillisecondsSinceEpoch(match.startTimeGmt);
    return DateFormat('MMM dd, yyyy').format(date);
  }

  String _formatTime() {
    return '${match.startTime ?? ''} - ${match.endTime ?? ''}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Host info
              Row(
                children: [
                  _HostAvatar(imageUrl: match.createdByImage),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          match.createdByName ?? 'Host',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.socaBlack,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Host'.tr,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: AppColors.socaBlack.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Request count badge
                  if (match.requestCount > 0)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.socaYellow.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${match.requestCount} requests',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 12),
              Divider(height: 1),
              SizedBox(height: 12),

              // Match details
              Row(
                children: [
                  Expanded(
                    child: _DetailItem(
                      icon: Icons.calendar_today,
                      text: _formatDate(),
                    ),
                  ),
                  Expanded(
                    child: _DetailItem(
                      icon: Icons.access_time,
                      text: _formatTime(),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: _DetailItem(
                      icon: Icons.location_on,
                      text: match.venueName ?? 'Venue',
                    ),
                  ),
                  Expanded(
                    child: _DetailItem(
                      icon: Icons.people,
                      text: '${match.maxPlayer} players',
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8),

              // Game type and age group
              Row(
                children: [
                  if (match.gameType != null)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.socaGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        match.gameType!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                  if (match.gameType != null && match.avgAge != null)
                    SizedBox(width: 8),
                  if (match.avgAge != null)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.socaGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        match.avgAge!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                  if (match.gender != null) ...[
                    SizedBox(width: 8),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.socaGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        match.gender!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                  ],
                ],
              ),

              // Match note
              if (match.matchNote != null && match.matchNote!.isNotEmpty) ...[
                SizedBox(height: 12),
                Text(
                  match.matchNote!,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: AppColors.socaBlack.withOpacity(0.7),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _HostAvatar extends StatelessWidget {
  _HostAvatar({this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final url = ApiConstants.getImageUrl(imageUrl);
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.socaGrey,
      ),
      child: ClipOval(
        child: url.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Icon(
                  Icons.person,
                  color: AppColors.socaBlack,
                  size: 24,
                ),
              )
            : Icon(Icons.person, color: AppColors.socaBlack, size: 24),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  _DetailItem({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: AppColors.socaBlack.withOpacity(0.6),
        ),
        SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: AppColors.socaBlack.withOpacity(0.8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
