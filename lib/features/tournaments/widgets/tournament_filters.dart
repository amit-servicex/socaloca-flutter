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
      color: AppColors.socaPageBg,
      padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: _ToggleBtn(
              label: 'NATIONAL',
              active: visibility == 'local',
              onTap: () => onChanged('local'),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _ToggleBtn(
              label: 'GLOBAL',
              active: visibility == 'global',
              onTap: () => onChanged('global'),
            ),
          ),
        ],
      ),
    );
  }
}

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

  void _setVisibility(String v) {
    setState(() => _filters = _filters.copyWith(visibility: v));
  }

  void _applyFilters() {
    final location = _locationController.text.trim();
    final updated = _filters.copyWith(
      location: location.isEmpty ? null : location,
      country: _selectedCountry,
    );
    setState(() => _filters = updated);
    widget.onFiltersChanged(updated);
  }

  void _clearFilters() {
    _locationController.clear();
    final cleared = _filters.clearFilters();
    setState(() {
      _filters = cleared;
      _selectedCountry = StorageService.currentUser?['country'] as String?;
    });
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
    onSelected(result);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.socaPageBg,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Country Dropdown
          _DropdownField(
            hint: _selectedCountry ?? 'India',
            onTap: () {
              // TODO: Implement country picker
              // For now, just show a simple dialog
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Select Country'.tr),
                  content: Text('Country picker coming soon'.tr),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: Text('OK'.tr),
                    ),
                  ],
                ),
              );
            },
          ),

          SizedBox(height: 12),

          // Location TextField
          _TextField(
            controller: _locationController,
            hint: 'Location',
          ),

          SizedBox(height: 12),

          // Game and Gender Row
          Row(
            children: [
              Expanded(
                child: _DropdownField(
                  hint: _filters.gameType ?? 'Game',
                  onTap: () => _pickOption(
                    title: 'Game Type',
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
                    title: 'Gender',
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

          SizedBox(height: 12),

          // Age Group Dropdown
          _DropdownField(
            hint: _filters.ageGroup ?? 'Age Group',
            onTap: () => _pickOption(
              title: 'Age Group',
              options: _ageGroups,
              current: _filters.ageGroup,
              onSelected: (v) {
                setState(() => _filters = _filters.copyWith(ageGroup: v));
              },
            ),
          ),

          SizedBox(height: 16),

          // GO Button
          GestureDetector(
            onTap: _applyFilters,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'GO'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.socaYellow,
                  ),
                ),
              ),
            ),
          ),
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
          borderRadius: BorderRadius.circular(8),
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
              fontSize: 14,
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
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hint,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
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
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: AppColors.socaBlack,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
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
              // Clear option
              if (current != null)
                GestureDetector(
                  onTap: () => Navigator.pop(context, null),
                  child: Text(
                    'Clear'.tr,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Colors.red,
                    ),
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
