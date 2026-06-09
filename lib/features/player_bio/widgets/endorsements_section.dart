import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:socaloca/core/router/app_routes.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/endorsement_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Endorsements Section for Endorse Tab
/// Shows latest endorsement with user details
class EndorsementsSection extends StatelessWidget {
  final List<EndorsementModel> endorsements;
  final bool isLoadingEndorsements;
  String? userid;
  EndorsementsSection(
      {super.key,
      required this.endorsements,
      required this.isLoadingEndorsements,
      this.userid});

  bool _isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    if (url.startsWith('file:///')) return false;
    return true;
  }

  String _getUserRole(EndorserUserModel? user) {
    if (user == null) return '';
    List<String> roles = [];
    if (user.isPlayer == true) roles.add('Player');
    if (user.isCoach == true) roles.add('Coach');
    if (user.isAdmin == true) roles.add('Manager');
    if (user.isFan == true) roles.add('Fan');
    return roles.join('/');
  }

  String _formatDate(int? timestamp) {
    if (timestamp == null) return '';
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('dd.MM.yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingEndorsements) {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.socaGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: AppLoader(),
      );
    }

    if (endorsements.isEmpty) {
      return SizedBox.shrink();
    }

    final endorsement = endorsements.first;
    final user = endorsement.userDetails;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
          decoration: BoxDecoration(
            color: AppColors.socaGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  _formatDate(endorsement.addedOn),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: AppColors.socaBlack.withOpacity(0.7),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to user profile
                    },
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: ClipOval(
                        child: _isValidImageUrl(user?.imageUrl)
                            ? CachedNetworkImage(
                                imageUrl:
                                    ApiConstants.getImageUrl(user!.imageUrl),
                                fit: BoxFit.cover,
                                placeholder: (context, url) => AppLoader(),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.person,
                                  color: AppColors.socaBlack.withOpacity(0.2),
                                  size: 32,
                                ),
                              )
                            : Icon(
                                Icons.person,
                                color: AppColors.socaBlack.withOpacity(0.2),
                                size: 32,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (endorsement.comment != null &&
                            endorsement.comment!.isNotEmpty) ...[
                          Text(
                            endorsement.comment!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: AppColors.socaBlack,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6),
                        ],
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              color: AppColors.socaBlack.withOpacity(0.8),
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${user?.firstName ?? ''} ${user?.lastName ?? ''}'
                                        .trim(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.socaBlack,
                                ),
                              ),
                              if (_getUserRole(user).isNotEmpty)
                                TextSpan(
                                  text: ' | ${_getUserRole(user)}',
                                ),
                            ],
                          ),
                        ),
                        if (endorsement.academy?.name != null) ...[
                          SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              // TODO: Navigate to academy
                            },
                            child: Text(
                              endorsement.academy!.name!.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                color: AppColors.socaBlack.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -10,
          left: 16,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.socaBlack,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Endorsements'.tr.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.socaYellow,
              ),
            ),
          ),
        ),
        Positioned(
          top: -10,
          right: 16,
          child: GestureDetector(
            onTap: () {
              context.push(AppRoutes.myEndorsementList,
                  extra: {'userId': user?.userId, "isOwnProfile": false});
            },
            child: Text(
              'View All'.tr.toLowerCase(),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.socaBlack,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
