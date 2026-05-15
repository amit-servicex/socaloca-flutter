import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/endorsement_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Endorsements Section for Endorse Tab
/// Shows latest endorsement with user details
class EndorsementsSection extends StatelessWidget {
  final List<EndorsementModel> endorsements;
  final bool isLoadingEndorsements;

  const EndorsementsSection({
    super.key,
    required this.endorsements,
    required this.isLoadingEndorsements,
  });

  bool _isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    if (url.startsWith('file:///')) return false;
    return true;
  }

  String _getUserRole(EndorserUserModel? user) {
    if (user == null) return '';
    if (user.isPlayer == true) return 'Player';
    if (user.isCoach == true) return 'Coach';
    if (user.isAdmin == true) return 'Manager';
    if (user.isFan == true) return 'Fan';
    return '';
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const AppLoader(),
      );
    }

    if (endorsements.isEmpty) {
      return const SizedBox.shrink();
    }

    final endorsement = endorsements.first;
    final user = endorsement.userDetails;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Endorsements',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaBlack,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to all endorsements
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: AppColors.socaYellow,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // User Info Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Avatar
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to user profile
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.socaGrey.withOpacity(0.2),
                  ),
                  child: ClipOval(
                    child: _isValidImageUrl(user?.imageUrl)
                        ? CachedNetworkImage(
                            imageUrl:
                                '${ApiConstants.mediaBaseUrl}${user!.imageUrl}',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const AppLoader(),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.person,
                              color: AppColors.socaGrey,
                              size: 25,
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            color: AppColors.socaGrey,
                            size: 25,
                          ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // User Details and Comment
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Name and Role
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${user?.firstName ?? ''} ${user?.lastName ?? ''}'
                                .trim(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ),
                        if (_getUserRole(user).isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.socaYellow.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _getUserRole(user),
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.socaBlack,
                              ),
                            ),
                          ),
                      ],
                    ),

                    // Academy Name (if available)
                    if (endorsement.academy?.name != null) ...[
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {
                          // TODO: Navigate to academy
                        },
                        child: Text(
                          endorsement.academy!.name!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: AppColors.socaYellow,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 8),

                    // Comment
                    if (endorsement.comment != null &&
                        endorsement.comment!.isNotEmpty)
                      Text(
                        endorsement.comment!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: AppColors.socaBlack,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                    const SizedBox(height: 8),

                    // Date
                    Text(
                      _formatDate(endorsement.addedOn),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: AppColors.socaGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
