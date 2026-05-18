import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/teams_provider.dart';

class TeamFilterSection extends ConsumerStatefulWidget {
  final String userCountry;
  final VoidCallback onSearch;

  TeamFilterSection({
    super.key,
    required this.userCountry,
    required this.onSearch,
  });

  @override
  ConsumerState<TeamFilterSection> createState() => _TeamFilterSectionState();
}

class _TeamFilterSectionState extends ConsumerState<TeamFilterSection> {
  final TextEditingController _locationController = TextEditingController();

  final List<String> _gameTypes = ['Game', 'Football', 'Futsal'];
  final List<String> _genders = ['Gender', 'Male', 'Female'];
  final List<String> _ageRanges = [
    'Age Range',
    '<13',
    '<15',
    '<18',
    '<20',
    '21-30',
    '31-40',
    '>40'
  ];
  final List<String> _ageCategories = [
    'Age Category',
    'U-7',
    'U-8',
    'U-9',
    'U-10',
    'U-11',
    'U-12',
    'U-13',
    'U-14',
    'U-15',
    'U-16',
    'U-17',
    'U-18',
    'U-19',
    'U-20',
    'U-21',
    'U-22',
    'U-23',
    'Senior',
    'Veteran'
  ];

  String _selectedGameType = 'Game';
  String _selectedGender = 'Gender';
  String _selectedAgeRange = 'Age Range';
  String _selectedAgeCategory = 'Age Category';

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Country and Location Row
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.userCountry,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: 'Location'.tr,
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (value) {
                  ref.read(teamsProvider.notifier).setLocation(value);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        // Game Type and Gender Row
        Row(
          children: [
            Expanded(
              child: _buildDropdown(
                value: _selectedGameType,
                items: _gameTypes,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedGameType = value);
                  ref
                      .read(teamsProvider.notifier)
                      .setGameType(value == 'Game' ? '' : value);
                },
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildDropdown(
                value: _selectedGender,
                items: _genders,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedGender = value);
                  ref
                      .read(teamsProvider.notifier)
                      .setGender(value == 'Gender' ? '' : value);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        // Age Range Dropdown
        _buildDropdown(
          value: _selectedAgeRange,
          items: _ageRanges,
          onChanged: (value) {
            if (value == null) return;
            setState(() => _selectedAgeRange = value);
            ref
                .read(teamsProvider.notifier)
                .setAgeRange(value == 'Age Range' ? '' : value);
          },
        ),
        SizedBox(height: 12),

        // Age Category Dropdown
        _buildDropdown(
          value: _selectedAgeCategory,
          items: _ageCategories,
          onChanged: (value) {
            if (value == null) return;
            setState(() => _selectedAgeCategory = value);
            ref
                .read(teamsProvider.notifier)
                .setAgeCategory(value == 'Age Category' ? '' : value);
          },
        ),
        SizedBox(height: 16),

        // GO Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.onSearch,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.socaBlack,
              foregroundColor: AppColors.socaYellow,
              padding: EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              'GO'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Divider(
          color: AppColors.socaBlack,
        ),
        Row(
          children: [
            Radio(
              value: true,
              autofocus: true,
              groupValue: true,
              activeColor: Colors.black,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            Text("      All temas".tr)
          ],
        ),
        Divider(
          color: AppColors.socaBlack,
        )
      ],
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: Colors.black54),
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.black87,
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
