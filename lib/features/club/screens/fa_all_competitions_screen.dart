import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/fa_bio_model.dart';

class FaAllCompetitionsScreen extends StatelessWidget {
  final String faName;
  final List<FaCompModel> competitions;

  const FaAllCompetitionsScreen({
    super.key,
    required this.faName,
    required this.competitions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          faName,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.socaBlack,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.socaBlack),
      ),
      body: competitions.isEmpty
          ? const Center(
              child: Text(
                'No competitions found.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: AppColors.socaBlack,
                ),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: competitions.length,
              separatorBuilder: (_, __) => const Divider(
                height: 1,
                thickness: 0.8,
                color: AppColors.socaGrey,
              ),
              itemBuilder: (context, i) => _buildRow(competitions[i]),
            ),
    );
  }

  Widget _buildRow(FaCompModel comp) {
    final imageUrl = comp.fullImageUrl;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.socaGrey,
            ),
            child: ClipOval(
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const Icon(
                        Icons.emoji_events,
                        size: 24,
                        color: AppColors.socaBlack,
                      ),
                    )
                  : const Icon(
                      Icons.emoji_events,
                      size: 24,
                      color: AppColors.socaBlack,
                    ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              comp.compName,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.socaBlack,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
