import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/teams_provider.dart';
import '../widgets/team_card.dart';
import '../widgets/team_filter_section.dart';

/// Teams screen with filters matching FanTeamsFragment
/// Single screen (no tabs) with location, game type, gender, age filters
class TeamsScreenNew extends ConsumerStatefulWidget {
  const TeamsScreenNew({super.key});

  @override
  ConsumerState<TeamsScreenNew> createState() => _TeamsScreenNewState();
}

class _TeamsScreenNewState extends ConsumerState<TeamsScreenNew> {
  final ScrollController _scrollController = ScrollController();
  bool _hasLoadedInitially = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Load teams on initial screen load (only once)
    if (!_hasLoadedInitially) {
      _hasLoadedInitially = true;
      Future.microtask(() {
        if (mounted) {
          ref.read(teamsProvider.notifier).search();
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(teamsProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teamsProvider);
    final user = StorageService.currentUser;
    final userCountry = user?['country'] ?? 'India';

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        backgroundColor: AppColors.socaBlack,
        title: const Text(
          'Teams',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: TeamFilterSection(
              userCountry: userCountry,
              onSearch: () {
                if (!state.filters.hasAnyFilter) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select at least one filter'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                ref.read(teamsProvider.notifier).search(requireFilters: true);
              },
            ),
          ),

          const Divider(height: 1),

          // Teams List
          Expanded(
            child: _buildBody(state),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(TeamsState state) {
    // Show spinner only on first load (no data yet)
    if (state.isLoading && state.teams.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.socaYellow,
        ),
      );
    }

    // Show error state
    if (state.error != null && state.teams.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async {
          await ref.read(teamsProvider.notifier).refresh();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: _buildErrorState(state.error!),
          ),
        ),
      );
    }

    // Show empty state
    if (state.teams.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async {
          await ref.read(teamsProvider.notifier).refresh();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: _buildEmptyState(),
          ),
        ),
      );
    }

    // Show teams list
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(teamsProvider.notifier).refresh();
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: state.teams.length + (state.isLoadingMore ? 1 : 0),
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          if (index == state.teams.length) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.socaYellow,
                ),
              ),
            );
          }

          final team = state.teams[index];
          return TeamCard(team: team);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.groups_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No teams found',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load teams',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              error,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ref.read(teamsProvider.notifier).refresh();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.socaBlack,
              foregroundColor: AppColors.socaYellow,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
