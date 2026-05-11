import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/features/pickup_match/data/models/pickup_match_model.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../providers/pickup_match_providers.dart';
import '../widgets/pickup_match_card.dart';

/// Pickup Matches Screen - Shows list of pickup matches with host button
/// Mirrors Android PickUpMatchesFragment
class PickupMatchScreen extends ConsumerStatefulWidget {
  const PickupMatchScreen({super.key});

  @override
  ConsumerState<PickupMatchScreen> createState() => _PickupMatchScreenState();
}

class _PickupMatchScreenState extends ConsumerState<PickupMatchScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      ref.read(pickupMatchesPaginationProvider.notifier).loadMore();
    }
  }

  /// Check if current user can host pickup matches
  /// Only Player, Coach, Admin, and Referee roles can host
  bool _canHostMatch() {
    final user = ref.read(currentUserProvider);
    log("enter the function of the _canHostMatch, the user is ${user?.toJson()}");
    if (user == null) return false;

    // Check role flags
    final isPlayer = user.isPlayer;
    final isCoach = user.isCoach;
    final isAdmin = user.isAdmin;
    final isReferee = user.isReferee;
    log('User Roles - Player: $isPlayer, Coach: $isCoach, Admin: $isAdmin, Referee: $isReferee');
    return isPlayer || isCoach || isAdmin || isReferee;
  }

  void _showHostRestrictionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Cannot Host Match',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        content: const Text(
          'Only Players, Coaches, Admins, and Referees can host pickup matches.',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'OK',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: AppColors.socaYellow,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onHostMatch() {
    log("enter the function of the _onHostMatch");
    if (_canHostMatch()) {
      // Navigate to host match screen
      context.push(AppRoutes.hostPickupMatch).then((result) {
        // Refresh list if match was hosted successfully
        if (result == true) {
          ref.read(pickupMatchesPaginationProvider.notifier).refresh();
        }
      });
    } else {
      _showHostRestrictionDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final matchesState = ref.watch(pickupMatchesPaginationProvider);

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: Column(
        children: [
          // Descriptive Text
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
            child: Text(
              "Can't get 2 full teams to make a match? Fret not. Pick-Up matches allows you to organise an informal kick-about at a specified place and time. Shout out to all nearby that you are organising a pick-up match and get your game on!",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.socaBlack,
                height: 1.4,
              ),
            ),
          ),

          // Host Match Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: _onHostMatch,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.socaBlack,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    'HOST MATCH',
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
          ),

          const SizedBox(height: 24),

          // Upcoming Matches Title
          const Text(
            'Upcoming Matches',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.socaBlack,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          // Matches List
          Expanded(
            child: matchesState.when(
              data: (state) {
                final matches = state.matches;

                if (matches.isEmpty && !state.isLoadingMore) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sports_soccer,
                          size: 64,
                          color: AppColors.socaBlack.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No upcoming pickup matches',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: AppColors.socaBlack.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await ref
                        .read(pickupMatchesPaginationProvider.notifier)
                        .refresh();
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: matches.length + (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      // Show loading indicator at the end if loading more
                      if (index == matches.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.socaYellow,
                            ),
                          ),
                        );
                      }

                      final match = matches[index];
                      return PickupMatchCard(
                        match: match,
                        onTap: () {
                          context.push(
                            '${AppRoutes.pickupMatches}/${match.effectiveId}',
                          );
                        },
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: AppColors.socaYellow,
                ),
              ),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Error loading matches',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(pickupMatchesPaginationProvider.notifier)
                            .refresh();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.socaYellow,
                      ),
                      child: const Text(
                        'Retry',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
