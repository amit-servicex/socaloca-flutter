import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/tournament_models.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Sponsors Horizontal List Widget
/// Displays tournament sponsors in a horizontal scrollable list
/// Matches Android TournamentSponsorAdapter
class SponsorsHorizontalList extends StatelessWidget {
  final List<SponsorModel> sponsors;

  const SponsorsHorizontalList({
    super.key,
    required this.sponsors,
  });

  @override
  Widget build(BuildContext context) {
    if (sponsors.isEmpty) return const SizedBox.shrink();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.business,
                  color: AppColors.socaBlack,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Sponsors (${sponsors.length})',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Horizontal List
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: sponsors.length,
              itemBuilder: (context, index) {
                final sponsor = sponsors[index];
                return _buildSponsorCard(sponsor);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSponsorCard(SponsorModel sponsor) {
    return GestureDetector(
      onTap: () => _openSponsorWebsite(sponsor.website),
      child: Container(
        width: 120,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sponsor Logo
            _buildSponsorLogo(sponsor.logo, 60),

            const SizedBox(height: 8),

            // Sponsor Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                sponsor.name ?? 'Sponsor',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.socaBlack,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSponsorLogo(String? logoUrl, double size) {
    if (logoUrl == null || logoUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          Icons.business,
          size: size * 0.4,
          color: Colors.grey[400],
        ),
      );
    }

    final fullImageUrl = ApiConstants.getImageUrl(logoUrl);

    if (fullImageUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          Icons.business,
          size: size * 0.4,
          color: Colors.grey[400],
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: CachedNetworkImage(
        imageUrl: fullImageUrl,
        width: size,
        height: size,
        fit: BoxFit.contain,
        placeholder: (context, url) => Container(
          width: size,
          height: size,
          color: Colors.grey[200],
          child: const AppLoader(),
        ),
        errorWidget: (context, url, error) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            Icons.business,
            size: size * 0.4,
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }

  Future<void> _openSponsorWebsite(String? website) async {
    if (website == null || website.isEmpty) return;

    // Ensure URL has a scheme
    String url = website;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
