import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Custom dropdown widget for player filters
class PlayerFilterDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final double? width;

  const PlayerFilterDropdown({
    super.key,
    required this.hint,
    this.value,
    required this.items,
    required this.onChanged,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.socaGrey,
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.socaBlack,
            ),
          ),
          isExpanded: true,
          icon: Image.asset(
            "assets/images/dropdown.png",
            width: 14,
            height: 12,
          ),
          dropdownColor: Colors.white,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.socaBlack,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
