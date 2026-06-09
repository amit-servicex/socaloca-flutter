import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/one_off_matches_providers.dart';
import '../widgets/recent_match_card.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Full list of recent matches with pagination
class RecentMatchesScreen extends ConsumerStatefulWidget {
  RecentMatchesScreen({super.key});

  @override
  ConsumerState<RecentMatchesScreen> createState() =>
      _RecentMatchesScreenState();
}

class _RecentMatchesScreenState extends ConsumerState<RecentMatchesScreen> {
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
      ref.read(recentMatchesPaginationProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final matchesState = ref.watch(recentMatchesPaginationProvider);

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        title: Text(
          AppStrings.recentMatches,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.socaBlack,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.socaBlack),
      ),
      body: matchesState.when(
        data: (matches) {
          if (matches.isEmpty) {
            return Center(
              child: Text(
                AppStrings.noRecentMatches,
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
                  .read(recentMatchesPaginationProvider.notifier)
                  .refresh();
            },
            child: ListView.builder(
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: matches.length + 1,
              itemBuilder: (context, index) {
                if (index == matches.length) {
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: AppLoader(),
                  );
                }

                final match = matches[index];
                return RecentMatchCard(
                  match: match,
                  onTap: () {
                    // TODO: Navigate to match details
                  },
                );
              },
            ),
          );
        },
        loading: () => AppLoader(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.errorLoadingMatches,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(recentMatchesPaginationProvider.notifier).refresh();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaYellow,
                ),
                child: Text(
                  AppStrings.retry,
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
