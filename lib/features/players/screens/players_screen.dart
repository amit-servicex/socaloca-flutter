import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/players_provider.dart';
import '../widgets/player_card.dart';
import '../widgets/player_filter_dropdown.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Players screen matching Android FanPlayersFragment
class PlayersScreen extends ConsumerStatefulWidget {
  PlayersScreen({super.key});

  @override
  ConsumerState<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends ConsumerState<PlayersScreen> {
  final ScrollController _scrollController = ScrollController();

  // Filter options
  final List<String> _playingPositions = [
    'Goalkeeper',
    'Defender',
    'Attack',
    'Midfield',
  ];

  final List<String> _ageGroups = [
    '<10',
    '<12',
    '<15',
    '<18',
    '<20',
    '21-30',
    '31-40',
    '>40',
  ];

  final List<String> _genders = [
    'Male',
    'Female',
  ];

  String? _selectedPosition;
  String? _selectedAgeGroup;
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(playersProvider.notifier).load();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(playersProvider.notifier).loadMore();
    }
  }

  void _onGoPressed() {
    ref.read(playersProvider.notifier).setFilters(
          playPosition: _selectedPosition ?? '',
          ageGroup: _selectedAgeGroup ?? '',
          gender: _selectedGender ?? '',
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(playersProvider);
    final user = StorageService.currentUser;
    final country = user?['country'] ?? 'Country';

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Filter section
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Country and Playing Position row
                          Row(
                            children: [
                              // Country display
                              Container(
                                width: 100,
                                height: 42,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.socaGrey,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  country,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.socaBlack,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              SizedBox(width: 4),

                              // Playing Position dropdown
                              Expanded(
                                child: PlayerFilterDropdown(
                                  hint: 'Playing Position',
                                  value: _selectedPosition,
                                  items: _playingPositions,
                                  onChanged: (value) {
                                    setState(() => _selectedPosition = value);
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10),

                          // Age Group and Gender row
                          Row(
                            children: [
                              // Age Group dropdown
                              Expanded(
                                child: PlayerFilterDropdown(
                                  hint: 'Age Group',
                                  value: _selectedAgeGroup,
                                  items: _ageGroups,
                                  onChanged: (value) {
                                    setState(() => _selectedAgeGroup = value);
                                  },
                                ),
                              ),

                              SizedBox(width: 4),

                              // Gender dropdown
                              Expanded(
                                child: PlayerFilterDropdown(
                                  hint: 'Gender',
                                  value: _selectedGender,
                                  items: _genders,
                                  onChanged: (value) {
                                    setState(() => _selectedGender = value);
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 15),

                          // GO button
                          GestureDetector(
                            onTap: state.isLoading ? null : _onGoPressed,
                            child: Container(
                              width: double.infinity,
                              height: 42,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.socaBlack,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: state.isLoading
                                  ? AppLoader(size: 24, centered: false)
                                  : Text(
                                      'GO'.tr,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.socaYellow,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Players list
                    if (state.isLoading && state.players.isEmpty)
                      Padding(
                        padding: EdgeInsets.all(50),
                        child: AppLoader(),
                      )
                    else if (state.error != null && state.players.isEmpty)
                      Padding(
                        padding: EdgeInsets.all(50),
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48,
                              color: AppColors.error,
                            ),
                            SizedBox(height: 16),
                            Text(
                              state.error!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.socaBlack,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () =>
                                  ref.read(playersProvider.notifier).load(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.socaBlack,
                                foregroundColor: AppColors.socaYellow,
                              ),
                              child: Text('Retry'.tr),
                            ),
                          ],
                        ),
                      )
                    else if (state.players.isEmpty)
                      Padding(
                        padding: EdgeInsets.all(50),
                        child: Text(
                          'No players found'.tr,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.players.length +
                            (state.isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == state.players.length) {
                            return Padding(
                              padding: EdgeInsets.all(16),
                              child: AppLoader(),
                            );
                          }

                          final player = state.players[index];
                          return PlayerCard(
                            player: player,
                            onTap: () {
                              context.push(
                                AppRoutes.playerBio.replaceAll(
                                  ':userId',
                                  player.userId,
                                ),
                              );
                            },
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
