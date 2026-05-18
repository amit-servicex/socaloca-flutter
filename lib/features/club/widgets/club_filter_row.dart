import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

import '../../../core/theme/app_colors.dart';

/// Filter row widget for clubs screen — matches Android fragment_common_clubs.xml
/// No GO button (hidden in Android too); filters auto-apply on selection change.
class ClubFilterRow extends StatelessWidget {
  final String selectedCountry;
  final String selectedPartnership;
  final List<String> countries;
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onPartnershipChanged;

  const ClubFilterRow({
    super.key,
    required this.selectedCountry,
    required this.selectedPartnership,
    required this.countries,
    required this.onCountryChanged,
    required this.onPartnershipChanged,
  });

  static const _partnerships = [
    ('', 'Partnership'),
    ('platinum', 'Platinum'),
    ('gold', 'Gold'),
    ('silver', 'Silver'),
    ('nopartner', 'Non-Partner'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "These are the Professional Football Clubs that have partnered with SOCALOCA to provide content and services to our users.\n\n"
            "If you are a Professional Football Club, you can request to become a SOCALOCA partner and gain access to a wide range of features, including an individualized hub with your logo and branding, in-app uploads of game highlights, training sessions, and interviews, the ability to advertise upcoming trials through your club’s dedicated hub, showcase your club teams and top players, engage fans with news, announcements, and recent results, display sponsors, and much more.",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.socaBlack,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  value: selectedCountry,
                  items: [
                    ('', 'All'),
                    ...countries.map((c) => (c, c)),
                  ],
                  onChanged: onCountryChanged,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildDropdown(
                  value: selectedPartnership,
                  items: _partnerships,
                  onChanged: onPartnershipChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<(String, String)> items,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.socaGrey,
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          isDense: true,
          icon: const Icon(Icons.arrow_drop_down, size: 16),
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.socaBlack,
          ),
          dropdownColor: Colors.white,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item.$1,
              child: Text(
                item.$2,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: AppColors.socaBlack,
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) onChanged(newValue);
          },
        ),
      ),
    );
  }
}
