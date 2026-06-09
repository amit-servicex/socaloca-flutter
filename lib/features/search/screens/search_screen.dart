import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/search_provider.dart';
import '../widgets/filter_chips_row.dart';
import '../widgets/filter_dropdowns_row.dart';
import '../widgets/search_input.dart';
import '../widgets/search_result_card.dart';
import '../widgets/search_shimmer.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(searchProvider.notifier).search();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.98) {
      ref.read(searchProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProvider);

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: SearchInput(
              onSearch: (query) {
                ref.read(searchProvider.notifier).setSearchQuery(query);
                ref.read(searchProvider.notifier).search();
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: FilterDropdownsRow(),
          ),
          const SizedBox(height: 12),
          const Divider(
              height: 0.5, thickness: 0.5, color: AppColors.socaBlack),
          if (state.filters.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: FilterChipsRow(),
            ),
            const SizedBox(height: 12),
            const Divider(
              height: 0.5,
              thickness: 0.5,
              color: AppColors.socaBlack,
            ),
          ],
          Expanded(child: _buildBody(state)),
        ],
      ),
    );
  }

  Widget _buildBody(SearchState state) {
    if (state.isLoading && state.users.isEmpty) {
      return const SearchShimmer();
    }

    if (state.error != null && state.users.isEmpty) {
      return _buildMessage(AppStrings.somethingWentWrong);
    }

    if (state.users.isEmpty) {
      return _buildMessage(AppStrings.noResultsFound);
    }

    return RefreshIndicator(
      onRefresh: () async => ref.read(searchProvider.notifier).refresh(),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: state.users.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.users.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: AppLoader(),
            );
          }
          return SearchResultCard(
            user: state.users[index],
            isLast: index == state.users.length - 1,
          );
        },
      ),
    );
  }

  Widget _buildMessage(String message) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
