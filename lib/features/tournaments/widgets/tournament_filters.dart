import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/core/storage/storage_service.dart';

import '../../../core/theme/app_colors.dart';
import '../data/tournament_models.dart';

/// Pinned NATIONAL / GLOBAL visibility toggle.
/// Rendered separately from [TournamentFiltersWidget] so it stays fixed
/// at the top of the screen and never scrolls away.
class TournamentVisibilityToggle extends StatelessWidget {
  TournamentVisibilityToggle({
    super.key,
    required this.visibility,
    required this.onChanged,
  });

  /// Current value: 'local' or 'global'
  final String visibility;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, 15, 16, 5),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 100,
              child: _ToggleBtn(
                label: 'NATIONAL',
                active: visibility == 'local',
                onTap: () => onChanged('local'),
              ),
            ),
            SizedBox(width: 20),
            SizedBox(
              width: 100,
              child: _ToggleBtn(
                label: 'GLOBAL',
                active: visibility == 'global',
                onTap: () => onChanged('global'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _countryOptions = [
  'Afghanistan',
  'Albania',
  'Algeria',
  'Argentina',
  'Australia',
  'Austria',
  'Bangladesh',
  'Belgium',
  'Brazil',
  'Canada',
  'Chile',
  'China',
  'Colombia',
  'Denmark',
  'Egypt',
  'England',
  'Finland',
  'France',
  'Germany',
  'Greece',
  'India',
  'Indonesia',
  'Republic of Ireland',
  'Italy',
  'Japan',
  'Kenya',
  'Korea Republic',
  'Malaysia',
  'Mexico',
  'Netherlands',
  'New Zealand',
  'Nigeria',
  'Norway',
  'Pakistan',
  'Peru',
  'Philippines',
  'Poland',
  'Portugal',
  'Russia',
  'Saudi Arabia',
  'Singapore',
  'South Africa',
  'Spain',
  'Sweden',
  'Switzerland',
  'Thailand',
  'Türkiye',
  'Ukraine',
  'United Arab Emirates',
  'USA',
  'Vietnam',
];

/// Tournament filters — filter dropdowns (country, location, game, gender, age).
/// The NATIONAL/GLOBAL toggle is rendered separately via [TournamentVisibilityToggle].
class TournamentFiltersWidget extends StatefulWidget {
  TournamentFiltersWidget({
    super.key,
    required this.filters,
    required this.onFiltersChanged,
  });

  final TournamentFilters filters;
  final Function(TournamentFilters) onFiltersChanged;

  @override
  State<TournamentFiltersWidget> createState() =>
      _TournamentFiltersWidgetState();
}

class _TournamentFiltersWidgetState extends State<TournamentFiltersWidget> {
  late TournamentFilters _filters;
  final TextEditingController _locationController = TextEditingController();
  String? _selectedCountry;
  bool _showSearchError = false;

  static final _gameTypes = ['Football', 'Futsal'];
  static final _ageGroups = [
    '<10',
    '<12',
    '<15',
    '<18',
    '<20',
    '21-30',
    '31-40',
    '>40'
  ];
  static final _genders = ['Male', 'Female'];

  @override
  void initState() {
    super.initState();
    _filters = widget.filters;
    _locationController.text = _filters.location ?? '';
    _selectedCountry =
        _filters.country ?? StorageService.currentUser?['country'] as String?;
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    final location = _locationController.text.trim();
    final hasAnyFilter = location.isNotEmpty ||
        (_filters.gameType?.isNotEmpty == true) ||
        (_filters.ageGroup?.isNotEmpty == true) ||
        (_filters.gender?.isNotEmpty == true) ||
        (_selectedCountry?.isNotEmpty == true);

    if (!hasAnyFilter) {
      setState(() => _showSearchError = true);
      return;
    }

    final updated = _filters.copyWith(
      location: location.isEmpty ? null : location,
      country: _selectedCountry,
    );
    setState(() {
      _filters = updated;
      _showSearchError = false;
    });
    widget.onFiltersChanged(updated);
  }

  Future<void> _pickOption({
    required String title,
    required List<String> options,
    required String? current,
    required void Function(String?) onSelected,
  }) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => _PickerSheet(
        title: title,
        options: options,
        current: current,
      ),
    );
    if (result != null) {
      onSelected(result);
    }
  }

  Future<void> _pickCountry() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => _PickerSheet(
        title: AppStrings.selectCountry,
        options: _countryOptions,
        current: _selectedCountry,
      ),
    );
    if (result != null) {
      setState(() {
        _selectedCountry = result;
        _showSearchError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(20, 10, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppStrings.tournamentsIntro,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: AppColors.socaBlack,
            ),
          ),
          SizedBox(height: 15),
          // Country Dropdown
          _DropdownField(
            hint: _selectedCountry ?? AppStrings.country,
            onTap: _pickCountry,
          ),

          SizedBox(height: 10),

          // Location TextField
          _TextField(
            controller: _locationController,
            hint: 'Location',
          ),

          SizedBox(height: 10),

          // Game and Gender Row
          Row(
            children: [
              Expanded(
                child: _DropdownField(
                  hint: _filters.gameType ?? 'Game',
                  onTap: () => _pickOption(
                    title: AppStrings.gameType,
                    options: _gameTypes,
                    current: _filters.gameType,
                    onSelected: (v) {
                      setState(() => _filters = _filters.copyWith(gameType: v));
                    },
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _DropdownField(
                  hint: _filters.gender ?? 'Gender',
                  onTap: () => _pickOption(
                    title: AppStrings.genderPlain,
                    options: _genders,
                    current: _filters.gender,
                    onSelected: (v) {
                      setState(() => _filters = _filters.copyWith(gender: v));
                    },
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          // Age Group Dropdown
          _DropdownField(
            hint: _filters.ageGroup ?? 'Age Group',
            onTap: () => _pickOption(
              title: AppStrings.ageGroup,
              options: _ageGroups,
              current: _filters.ageGroup,
              onSelected: (v) {
                setState(() => _filters = _filters.copyWith(ageGroup: v));
              },
            ),
          ),

          SizedBox(height: 15),

          // GO Button
          GestureDetector(
            onTap: _applyFilters,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  AppStrings.goUpper,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.socaYellow,
                  ),
                ),
              ),
            ),
          ),
          if (_showSearchError) ...[
            SizedBox(height: 5),
            Text(
              AppStrings.pleaseSelectFilter,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: AppColors.socaBlack,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ToggleBtn extends StatelessWidget {
  _ToggleBtn({
    required this.label,
    required this.active,
    required this.onTap,
  });
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: active ? AppColors.socaBlack : Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: active ? AppColors.socaBlack : AppColors.socaGrey,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: active ? AppColors.socaYellow : AppColors.socaBlack,
            ),
          ),
        ),
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  _DropdownField({
    required this.hint,
    required this.onTap,
  });
  final String hint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        constraints: BoxConstraints(minHeight: 42),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hint,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: AppColors.socaBlack,
              ),
            ),
            Image.asset("assets/images/dropdown.png", width: 12, height: 12),
          ],
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  _TextField({
    required this.controller,
    required this.hint,
  });
  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      constraints: BoxConstraints(minHeight: 42),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          color: AppColors.socaBlack,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

/// Bottom sheet picker for filter options
class _PickerSheet extends StatelessWidget {
  _PickerSheet({
    required this.title,
    required this.options,
    required this.current,
  });

  final String title;
  final List<String> options;
  final String? current;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 12),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.socaBlack,
                ),
              ),
            ],
          ),
        ),
        Divider(),
        ...options.map((option) => ListTile(
              title: Text(
                option,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight:
                      option == current ? FontWeight.w700 : FontWeight.w400,
                  color: AppColors.socaBlack,
                ),
              ),
              trailing: option == current
                  ? Icon(Icons.check, color: AppColors.socaBlack)
                  : null,
              onTap: () => Navigator.pop(context, option),
            )),
        SizedBox(height: 16),
      ],
    );
  }
}
