import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/academies_provider.dart';
import '../widgets/academy_card.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';
import '../../../shared/widgets/searchable_dropdown.dart';

/// Academies screen - main tab for browsing academies
class AcademiesScreen extends ConsumerStatefulWidget {
  const AcademiesScreen({super.key});

  @override
  ConsumerState<AcademiesScreen> createState() => _AcademiesScreenState();
}

class _AcademiesScreenState extends ConsumerState<AcademiesScreen> {
  final ScrollController _scrollController = ScrollController();

  // Country list
  final List<String> _countries = ['All'];
  String _selectedCountry = 'All';

  // Category list
  final List<String> _categories = [
    'CATEGORY',
    'Cat 1',
    'Cat 2',
    'Cat 3',
    'Cat 4',
    'Cat 5',
  ];
  String _selectedCategory = 'CATEGORY';

  @override
  void initState() {
    super.initState();
    _initializeCountries();
    _scrollController.addListener(_onScroll);

    // Initial load with user's country
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _performInitialSearch();
    });
  }

  void _initializeCountries() {
    // Add common countries (you can expand this list)
    _countries.addAll([
      'Afghanistan',
      'Albania',
      'Algeria',
      'Argentina',
      'Australia',
      'Austria',
      'Bangladesh',
      'Belgium',
      'Brazil',
      'Canada',
      'Chile',
      'China',
      'Colombia',
      'Denmark',
      'Egypt',
      'England',
      'France',
      'Germany',
      'Ghana',
      'India',
      'Indonesia',
      'Iran',
      'Iraq',
      'Ireland',
      'Italy',
      'Japan',
      'Kenya',
      'Malaysia',
      'Mexico',
      'Morocco',
      'Netherlands',
      'New Zealand',
      'Nigeria',
      'Norway',
      'Pakistan',
      'Peru',
      'Philippines',
      'Poland',
      'Portugal',
      'Qatar',
      'Russia',
      'Saudi Arabia',
      'Scotland',
      'Senegal',
      'Singapore',
      'South Africa',
      'South Korea',
      'Spain',
      'Sri Lanka',
      'Sweden',
      'Switzerland',
      'Thailand',
      'Turkey',
      'UAE',
      'Uganda',
      'Ukraine',
      'United States',
      'Uruguay',
      'Venezuela',
      'Vietnam',
      'Wales',
      'Zimbabwe',
    ]);

    // Set default to user's country if available
    final currentUser = StorageService.currentUser;
    if (currentUser != null && currentUser['country'] != null) {
      final userCountry = currentUser['country'] as String;
      if (_countries.contains(userCountry)) {
        _selectedCountry = userCountry;
      }
    }
  }

  void _performInitialSearch() {
    final notifier = ref.read(academiesProvider.notifier);

    // Set initial country filter
    if (_selectedCountry != 'All') {
      notifier.setCountry(
          _selectedCountry, ''); // TODO: Add confederation logic
    }

    // Perform search
    notifier.search();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(academiesProvider.notifier).loadMore();
    }
  }

  void _onCountryChanged(String? country) {
    if (country == null) return;

    setState(() {
      _selectedCountry = country;
    });

    // Auto-search after country change (with delay)
    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) {
        final notifier = ref.read(academiesProvider.notifier);
        if (country == 'All') {
          notifier.setCountry(null, null);
        } else {
          notifier.setCountry(country, ''); // TODO: Add confederation logic
        }
        notifier.search();
      }
    });
  }

  void _onCategoryChanged(String? category) {
    if (category == null) return;

    setState(() {
      _selectedCategory = category;
    });

    final notifier = ref.read(academiesProvider.notifier);
    if (category == 'CATEGORY') {
      notifier.setCategory(null);
    } else {
      // Extract category number (1-5)
      final categoryNumber = category.split(' ').last;
      notifier.setCategory(categoryNumber);
    }
  }

  void _onGoPressed() {
    // Hide keyboard
    FocusScope.of(context).unfocus();

    // Perform search
    ref.read(academiesProvider.notifier).search();
  }

  void _onAcademyTap(String? academyId) {
    if (academyId == null) return;
    context.push(AppRoutes.academyBio.replaceFirst(':academyId', academyId));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(academiesProvider);

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Description and Filters Section
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description Text
                  Text(
                    AppStrings.academiesDescription,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: AppColors.socaBlack,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Country Dropdown
                  SearchableDropdownButton(
                    hint: AppStrings.country,
                    value: _selectedCountry,
                    items: _countries,
                    onChanged: _onCountryChanged,
                    height: 42,
                    fontSize: 12,
                    backgroundColor: AppColors.socaGrey.withValues(alpha: 0.3),
                  ),

                  const SizedBox(height: 10),

                  // Category Dropdown
                  SearchableDropdownButton(
                    hint: AppStrings.category,
                    value: _selectedCategory,
                    items: _categories,
                    onChanged: _onCategoryChanged,
                    height: 42,
                    fontSize: 12,
                    backgroundColor: AppColors.socaGrey.withValues(alpha: 0.3),
                  ),

                  const SizedBox(height: 15),

                  // GO Button
                  GestureDetector(
                    onTap: _onGoPressed,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.socaBlack,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          AppStrings.goUpper,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.socaYellow,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Divider
          SliverToBoxAdapter(
            child: Container(height: 0.5, color: AppColors.socaBlack),
          ),

          // Academies List
          if (state.isLoading)
            const SliverFillRemaining(
              child: Center(child: AppLoader()),
            )
          else if (state.error != null)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.error!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.socaBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _onGoPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.socaBlack,
                        foregroundColor: AppColors.socaYellow,
                      ),
                      child: Text(AppStrings.retry),
                    ),
                  ],
                ),
              ),
            )
          else if (state.academies.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text(
                  AppStrings.noAcademiesFound,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              sliver: SliverList.builder(
                itemCount:
                    state.academies.length + (state.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.academies.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: AppLoader(),
                    );
                  }
                  final academy = state.academies[index];
                  return AcademyCard(
                    academy: academy,
                    onViewTap: () => _onAcademyTap(academy.academyId),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
