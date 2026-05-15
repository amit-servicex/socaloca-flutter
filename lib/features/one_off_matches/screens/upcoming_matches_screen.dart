import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/one_off_matches_providers.dart';
import '../widgets/upcoming_match_card.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Full list of upcoming matches with pagination
class UpcomingMatchesScreen extends ConsumerStatefulWidget {
  const UpcomingMatchesScreen({super.key});

  @override
  ConsumerState<UpcomingMatchesScreen> createState() =>
      _UpcomingMatchesScreenState();
}

class _UpcomingMatchesScreenState extends ConsumerState<UpcomingMatchesScreen> {
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
      ref.read(upcomingMatchesPaginationProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final matchesState = ref.watch(upcomingMatchesPaginationProvider);

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        title: const Text(
          'Upcoming Matches',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.socaBlack,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.socaBlack),
      ),
      body: matchesState.when(
        data: (matches) {
          if (matches.isEmpty) {
            return const Center(
              child: Text(
                'No upcoming matches',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.socaBlack,
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(upcomingMatchesPaginationProvider.notifier)
                  .refresh();
            },
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: matches.length + 1,
              itemBuilder: (context, index) {
                if (index == matches.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: const AppLoader(),
                  );
                }

                final match = matches[index];
                return UpcomingMatchCard(
                  match: match,
                  onTap: () {
                    // TODO: Navigate to match details
                  },
                );
              },
            ),
          );
        },
        loading: () => const AppLoader(),
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
                      .read(upcomingMatchesPaginationProvider.notifier)
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
    );
  }
}
