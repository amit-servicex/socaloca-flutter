import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/player_bio_provider.dart';
import '../widgets/stats_tab_content.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class PlayerStatsScreen extends ConsumerStatefulWidget {
  final String playerId;

  const PlayerStatsScreen({
    super.key,
    required this.playerId,
  });

  @override
  ConsumerState<PlayerStatsScreen> createState() => _PlayerStatsScreenState();
}

class _PlayerStatsScreenState extends ConsumerState<PlayerStatsScreen> {
  int? _selectedYear;

  static final List<int> _years = List.generate(
    10,
    (i) => DateTime.now().year - i,
  );

  void _onYearChanged(int? year) {
    if (year == null) return;
    setState(() => _selectedYear = year);
    ref.read(playerBioProvider(widget.playerId).notifier).loadStats(year);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(playerBioProvider(widget.playerId));

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: state.isLoading
          ? const AppLoader()
          : state.playerBio == null
              ? const Center(
                  child: Text(
                    'Player not found',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: AppColors.socaBlack,
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Header ────────────────────────────────────────────────
                    Container(
                      margin: const EdgeInsets.only(left: 16, top: 16),
                      // width: double.infinity,
                      color: AppColors.socaBlack,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: const Text(
                        'Match Stats',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: AppColors.socaYellow,
                        ),
                      ),
                    ),

                    // ── Year selector ─────────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Select year to view players Match Stats',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.socaBlack,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _YearDropdown(
                            selectedYear: _selectedYear,
                            years: _years,
                            onChanged: _onYearChanged,
                          ),
                        ],
                      ),
                    ),

                    // ── Stats content ─────────────────────────────────────────
                    if (_selectedYear != null)
                      Expanded(
                        child: state.isLoadingStats
                            ? const AppLoader()
                            : StatsTabContent(
                                playerId: widget.playerId,
                                playerBio: state.playerBio!,
                                embedded: false,
                              ),
                      ),
                  ],
                ),
    );
  }
}

class _YearDropdown extends StatelessWidget {
  const _YearDropdown({
    required this.selectedYear,
    required this.years,
    required this.onChanged,
  });

  final int? selectedYear;
  final List<int> years;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: selectedYear,
          hint: const Text(
            'select year *',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.socaBlack),
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            color: AppColors.socaBlack,
          ),
          items: years
              .map((y) => DropdownMenuItem(
                    value: y,
                    child: Text(y.toString()),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
