import 'package:flutter/material.dart';

import '../../../shared/widgets/searchable_dropdown.dart';

/// Searchable dropdown widget for player filters.
/// Replaces the previous native DropdownButton.
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
    return SearchableDropdownButton(
      hint: hint,
      value: value,
      items: items,
      onChanged: onChanged,
      width: width,
      height: 50,
      fontSize: 12,
    );
  }
}
