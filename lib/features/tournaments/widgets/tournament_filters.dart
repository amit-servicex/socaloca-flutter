import 'package:flutter/material.dart';
import 'package:socaloca/core/storage/storage_service.dart';

import '../../../core/theme/app_colors.dart';
import '../data/tournament_models.dart';

/// Tournament filters — Local/Global toggle + filter dropdowns
/// Mirrors Android CommonOngoingTournamentsFragment filter section
class TournamentFiltersWidget extends StatefulWidget {
  const TournamentFiltersWidget({
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

  static const _gameTypes = ['Football', 'Futsal'];
  static const _ageGroups = [
    '<10',
    '<12',
    '<15',
    '<18',
    '<20',
    '21-30',
    '31-40',
    '>40'
  ];
  static const _genders = ['Male', 'Female'];

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
      shape: const RoundedRectangleBorder(
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Local / Global toggle
          Row(
            children: [
              Expanded(
                child: _ToggleBtn(
                  label: 'NATIONAL',
                  active: _filters.visibility == 'local',
                  onTap: () => _setVisibility('local'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ToggleBtn(
                  label: 'GLOBAL',
                  active: _filters.visibility == 'global',
                  onTap: () => _setVisibility('global'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Country Dropdown
          _DropdownField(
            hint: _selectedCountry ?? 'India',
            onTap: () {
              // TODO: Implement country picker
              // For now, just show a simple dialog
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Select Country'),
                  content: const Text('Country picker coming soon'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          // Location TextField
          _TextField(
            controller: _locationController,
            hint: 'Location',
          ),

          const SizedBox(height: 12),

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
              const SizedBox(width: 12),
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

          const SizedBox(height: 12),

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

          const SizedBox(height: 16),

          // GO Button
          GestureDetector(
            onTap: _applyFilters,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'GO',
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
  const _ToggleBtn({
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
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: active ? AppColors.socaBlack : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: active ? AppColors.socaBlack : Colors.grey.shade300,
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
  const _DropdownField({
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hint,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.hint,
  });
  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
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
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

/// Bottom sheet picker for filter options
class _PickerSheet extends StatelessWidget {
  const _PickerSheet({
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
        const SizedBox(height: 12),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
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
                  child: const Text(
                    'Clear',
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
        const Divider(),
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
                  ? const Icon(Icons.check, color: AppColors.socaBlack)
                  : null,
              onTap: () => Navigator.pop(context, option),
            )),
        const SizedBox(height: 16),
      ],
    );
  }
}
