import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/academies_provider.dart';
import '../widgets/academy_card.dart';

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
      // appBar: AppBar(
      //   title: const Text('Academies'),
      //   backgroundColor: AppColors.socaBlack,
      //   foregroundColor: AppColors.socaYellow,
      //   elevation: 0,
      // ),

      body: Column(
        children: [
          // Description and Filters Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description Text
                const Text(
                  'SocaLoca is the home for football academies of any scale, age category, playing level, or location. SocaLoca provides an innovative and intuitive platform designed around the modern needs of a football academy.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: AppColors.socaBlack,
                  ),
                ),

                const SizedBox(height: 15),

                // Country Dropdown
                Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: AppColors.socaGrey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCountry,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down, size: 20),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.socaBlack,
                      ),
                      items: _countries.map((String country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                      onChanged: _onCountryChanged,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Category Dropdown
                Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: AppColors.socaGrey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCategory,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down, size: 20),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.socaBlack,
                      ),
                      items: _categories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: _onCategoryChanged,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // GO Button
                GestureDetector(
                  onTap: _onGoPressed,
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.socaBlack,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        'GO',
                        style: TextStyle(
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

          // Divider
          Container(
            height: 0.5,
            color: AppColors.socaBlack,
          ),

          // Academies List
          Expanded(
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.socaYellow,
                    ),
                  )
                : state.error != null
                    ? Center(
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
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : state.academies.isEmpty
                        ? const Center(
                            child: Text(
                              'No academies found.',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.socaBlack,
                              ),
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            itemCount: state.academies.length +
                                (state.isLoadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == state.academies.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.socaYellow,
                                    ),
                                  ),
                                );
                              }

                              final academy = state.academies[index];
                              return AcademyCard(
                                academy: academy,
                                onViewTap: () =>
                                    _onAcademyTap(academy.academyId),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
