import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/referee_match_model.dart';

/// Tournament filter dropdown — reused across Requests, Matches, Live tabs.
class RefereeTournamentDropdown extends StatelessWidget {
  const RefereeTournamentDropdown({
    super.key,
    required this.items,
    required this.selectedId,
    required this.onChanged,
  });

  final List<TournamentDropdownItem> items;
  final String? selectedId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final dropdownItems = <TournamentDropdownItem>[];
    final values = <String>{};
    for (final item in items) {
      final id = item.tournamentId;
      if (id == null || id.isEmpty || !values.add(id)) continue;
      dropdownItems.add(item);
    }
    final selectedValue =
        selectedId != null && values.contains(selectedId) ? selectedId : '';
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width * .7,
      padding: const EdgeInsets.symmetric(horizontal: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.socaBlack, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: DropdownButton<String>(
            value: selectedValue,
            isExpanded: true,
            focusColor: Colors.transparent,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: AppColors.socaBlack,
              size: 32,
            ),
            dropdownColor: Colors.white,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.socaBlack,
            ),
            items: [
              DropdownMenuItem<String>(
                value: '',
                child: Text(
                  AppStrings.selectTournamentRequired,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),
              ...dropdownItems.map(
                (item) => DropdownMenuItem<String>(
                  value: item.tournamentId,
                  child: Text(
                    item.tournamentName ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ),
              ),
            ],
            onChanged: (value) => onChanged(
              value == null || value.isEmpty ? null : value,
            ),
          ),
        ),
      ),
    );
  }
}

/// Generic empty-state widget used across referee list screens.
class RefereeEmptyState extends StatelessWidget {
  const RefereeEmptyState({
    super.key,
    required this.message,
    required this.icon,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60, color: AppColors.socaBlack),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.socaBlack),
          ),
        ],
      ),
    );
  }
}

/// Loading dropdown placeholder shown while tournament list is fetching.
class RefereeDropdownLoading extends StatelessWidget {
  const RefereeDropdownLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 48,
      child: Center(
        child: LinearProgressIndicator(
          color: AppColors.socaYellow,
          backgroundColor: AppColors.socaGrey,
        ),
      ),
    );
  }
}

/// Info chip (icon + text) used inside match cards.
class RefereeInfoChip extends StatelessWidget {
  const RefereeInfoChip({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: Colors.grey),
        const SizedBox(width: 3),
        Text(text,
            style: const TextStyle(
                fontFamily: 'Lato', fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
