import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/tagged_video_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Tagged Videos Section for Endorse Tab
/// Shows horizontal scrollable list of tagged videos from academies
class TaggedVideosSection extends StatelessWidget {
  final List<TaggedVideoModel> taggedVideos;
  final bool isLoadingTaggedVideos;

  TaggedVideosSection({
    super.key,
    required this.taggedVideos,
    required this.isLoadingTaggedVideos,
  });

  bool _isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    if (url.startsWith('file:///')) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingTaggedVideos) {
      return AppLoader();
    }

    if (taggedVideos.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'TAGGED SKILL VIDEOS'.tr,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaYellow,
                ),
              ),
            ),
            if (taggedVideos.length > 3)
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to all tagged videos
                },
                child: Text(
                  'view all'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.socaGrey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: taggedVideos.length,
              itemBuilder: (context, index) {
                final video = taggedVideos[index];
                return GestureDetector(
                  onTap: () {
                    // TODO: Navigate to video detail
                  },
                  child: Container(
                    width: 120,
                    margin: EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.socaGrey.withOpacity(0.2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                if (_isValidImageUrl(video.thumbnail))
                                  CachedNetworkImage(
                                    imageUrl:
                                        '${ApiConstants.mediaBaseUrl}${video.thumbnail}',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => AppLoader(),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.videocam,
                                      color: AppColors.socaGrey,
                                      size: 40,
                                    ),
                                  )
                                else
                                  Icon(
                                    Icons.videocam,
                                    color: AppColors.socaGrey,
                                    size: 40,
                                  ),

                                // Play button overlay
                                Center(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 6),

                        // Academy name
                        if (video.academy?.name != null)
                          Text(
                            video.academy!.name!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.socaBlack,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
