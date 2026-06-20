import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/player_bio_model.dart';

/// Player bio header with avatar, name, country, etc.
class PlayerBioHeader extends StatelessWidget {
  final PlayerBioModel playerBio;
  final bool isOwnProfile;

  const PlayerBioHeader({
    super.key,
    required this.playerBio,
    required this.isOwnProfile,
  });

  @override
  Widget build(BuildContext context) {
    final firstName = playerBio.firstName ?? '';
    final lastName = playerBio.lastName ?? '';
    final profileName = playerBio.profileName ?? '';
    final imageUrl = playerBio.imageUrl;
    final preferredJersey = playerBio.preferredJersey;
    final isVerified = playerBio.isVerifyBadge ?? false;
    final flagIso = _flagIsoCode(playerBio);

    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      color: Colors.white,
      child: Column(
        children: [
          // Player Avatar with Online indicator
          Stack(
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.socaBlack,
                    width: 2.5,
                  ),
                ),
                child: ClipOval(
                  child: imageUrl != null &&
                          imageUrl.isNotEmpty &&
                          !imageUrl.startsWith('file:///')
                      ? Image.network(
                          ApiConstants.getImageUrl(imageUrl),
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: AppColors.socaGrey,
                            child: const Icon(Icons.person,
                                size: 60, color: Colors.white),
                          ),
                        )
                      : Container(
                          color: AppColors.socaGrey,
                          child: const Icon(Icons.person,
                              size: 60, color: Colors.white),
                        ),
                ),
              ),
              // Online indicator
              Positioned(
                top: 5,
                right: 0,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.socaYellow,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.socaBlack,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Player Name and Jersey
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$firstName $lastName'.trim(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaBlack,
                ),
              ),
              if (isVerified) ...[
                const SizedBox(width: 5),
                const Icon(
                  Icons.verified,
                  size: 20,
                  color: Colors.blue,
                ),
              ],
              if (preferredJersey != null && preferredJersey.isNotEmpty) ...[
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.socaBlack,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    preferredJersey,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaYellow,
                    ),
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 5),

          // Profile Name
          if (profileName.isNotEmpty)
            Text(
              profileName,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.socaBlack,
              ),
            ),

          const SizedBox(height: 15),

          // Android uses nationalityIso first, then falls back to country name.
          if (flagIso != null)
            Container(
              width: 45,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(2),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                'https://flagcdn.com/w40/${flagIso.toLowerCase()}.png',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.flag,
                  color: Colors.green,
                ),
              ),
            ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "SocaLoca ID: ".tr,
            style: const TextStyle(
                color: AppColors.socaBlack,
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
          Text("${playerBio.sclId}",
              style: const TextStyle(
                  color: AppColors.socaBlack,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  String? _flagIsoCode(PlayerBioModel bio) {
    final directIso =
        _normalizeIso(bio.nationalityIso) ?? _normalizeIso(bio.countryIso);
    if (directIso != null) return directIso;

    final country = bio.country?.trim().toLowerCase();
    if (country == null || country.isEmpty) return null;
    return _countryNameToIso[country];
  }

  String? _normalizeIso(String? value) {
    final iso = value?.trim();
    if (iso == null || iso.isEmpty) return null;
    return iso.length == 2 ? iso.toUpperCase() : null;
  }
}

const Map<String, String> _countryNameToIso = {
  'afghanistan': 'AF',
  'albania': 'AL',
  'algeria': 'DZ',
  'argentina': 'AR',
  'australia': 'AU',
  'austria': 'AT',
  'bangladesh': 'BD',
  'belgium': 'BE',
  'brazil': 'BR',
  'canada': 'CA',
  'chile': 'CL',
  'china': 'CN',
  'colombia': 'CO',
  'denmark': 'DK',
  'egypt': 'EG',
  'england': 'GB',
  'finland': 'FI',
  'france': 'FR',
  'germany': 'DE',
  'greece': 'GR',
  'india': 'IN',
  'indonesia': 'ID',
  'ireland': 'IE',
  'republic of ireland': 'IE',
  'italy': 'IT',
  'japan': 'JP',
  'kenya': 'KE',
  'korea republic': 'KR',
  'south korea': 'KR',
  'malaysia': 'MY',
  'mexico': 'MX',
  'netherlands': 'NL',
  'new zealand': 'NZ',
  'nigeria': 'NG',
  'norway': 'NO',
  'pakistan': 'PK',
  'peru': 'PE',
  'philippines': 'PH',
  'poland': 'PL',
  'portugal': 'PT',
  'russia': 'RU',
  'saudi arabia': 'SA',
  'singapore': 'SG',
  'south africa': 'ZA',
  'spain': 'ES',
  'sweden': 'SE',
  'switzerland': 'CH',
  'thailand': 'TH',
  'türkiye': 'TR',
  'turkey': 'TR',
  'ukraine': 'UA',
  'united arab emirates': 'AE',
  'usa': 'US',
  'united states': 'US',
  'united states of america': 'US',
  'vietnam': 'VN',
};
