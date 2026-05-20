import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/player_bio_provider.dart';
import '../widgets/stats_tab_content.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';
import '../../../shared/widgets/searchable_dropdown.dart';

class PlayerStatsScreen extends ConsumerStatefulWidget {
  final String playerId;

  PlayerStatsScreen({
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
          ? AppLoader()
          : state.playerBio == null
              ? Center(
                  child: Text(
                    'Player not found'.tr,
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
                      margin: EdgeInsets.only(left: 16, top: 16),
                      // width: double.infinity,
                      color: AppColors.socaBlack,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Text(
                        'Match Stats'.tr,
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
                      padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select year to view players Match Stats'.tr,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.socaBlack,
                            ),
                          ),
                          SizedBox(height: 12),
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
                            ? AppLoader()
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
  _YearDropdown({
    required this.selectedYear,
    required this.years,
    required this.onChanged,
  });

  final int? selectedYear;
  final List<int> years;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final strItems = years.map((y) => y.toString()).toList();
    return SizedBox(
      width: 160,
      child: SearchableDropdownButton(
        hint: 'select year *'.tr,
        value: selectedYear?.toString(),
        items: strItems,
        onChanged: (v) => onChanged(v != null ? int.tryParse(v) : null),
        fontSize: 13,
      ),
    );
  }
}
