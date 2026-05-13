import 'package:flutter/material.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.socaGrey,
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          isExpanded: true,
          value: selectedId,
          hint: const Text('All Tournaments',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
          items: [
            const DropdownMenuItem<String?>(
              value: null,
              child: Text('All Tournaments',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
            ),
            ...items.map((t) => DropdownMenuItem<String?>(
                  value: t.tournamentId,
                  child: Text(
                    t.tournamentName ?? '',
                    style: const TextStyle(
                        fontFamily: 'Poppins', fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
          ],
          onChanged: onChanged,
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
          Icon(icon, size: 60, color: AppColors.socaGrey),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
                fontFamily: 'Poppins', fontSize: 14, color: Colors.grey),
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
