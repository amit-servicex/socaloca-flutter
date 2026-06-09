import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import '../data/models/search_filter_model.dart';
import '../providers/search_provider.dart';
import '../utils/countries_list.dart';
import '../../../shared/widgets/searchable_dropdown.dart';

class FilterDropdownsRow extends ConsumerWidget {
  const FilterDropdownsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchProvider);

    return Row(
      children: [
        // By Country
        Expanded(
          child: _CountryDropdown(),
        ),
        const SizedBox(width: 8),

        // By Type
        Expanded(
          child: _TypeDropdown(),
        ),
        const SizedBox(width: 8),

        // By Choice
        Expanded(
          child: Opacity(
            opacity: state.isRefereeSelected ? 0.5 : 1.0,
            child: _ChoiceDropdown(
              enabled: !state.isRefereeSelected,
            ),
          ),
        ),
      ],
    );
  }
}

class _CountryDropdown extends ConsumerStatefulWidget {
  @override
  ConsumerState<_CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends ConsumerState<_CountryDropdown> {
  String? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return SearchableDropdownButton(
      hint: AppStrings.byCountry,
      value: _selectedCountry,
      items: ['All', ...CountriesList.countries],
      onChanged: (value) {
        setState(() => _selectedCountry = value);
        if (value != null) {
          ref
              .read(searchProvider.notifier)
              .addFilter(SearchFilterType.country, value);
        }
      },
      height: 42,
      fontSize: 12,
    );
  }
}

class _TypeDropdown extends ConsumerStatefulWidget {
  @override
  ConsumerState<_TypeDropdown> createState() => _TypeDropdownState();
}

class _TypeDropdownState extends ConsumerState<_TypeDropdown> {
  String? _selectedType;

  @override
  Widget build(BuildContext context) {
    return SearchableDropdownButton(
      hint: AppStrings.byType,
      value: _selectedType,
      items: const [
        UserTypeFilter.player,
        UserTypeFilter.coach,
        UserTypeFilter.manager,
        UserTypeFilter.referee,
      ],
      onChanged: (value) {
        setState(() => _selectedType = value);
        if (value != null) {
          ref
              .read(searchProvider.notifier)
              .addFilter(SearchFilterType.type, value);
        }
      },
      height: 42,
      fontSize: 12,
    );
  }
}

class _ChoiceDropdown extends ConsumerStatefulWidget {
  final bool enabled;

  const _ChoiceDropdown({this.enabled = true});

  @override
  ConsumerState<_ChoiceDropdown> createState() => _ChoiceDropdownState();
}

class _ChoiceDropdownState extends ConsumerState<_ChoiceDropdown> {
  String? _selectedChoice;

  @override
  Widget build(BuildContext context) {
    return SearchableDropdownButton(
      hint: AppStrings.byChoice,
      value: _selectedChoice,
      items: const [
        SortingFilter.mostPosts,
        SortingFilter.mostAppearances,
        SortingFilter.mostGoals,
      ],
      enabled: widget.enabled,
      onChanged: (value) {
        setState(() => _selectedChoice = value);
        if (value != null) {
          ref
              .read(searchProvider.notifier)
              .addFilter(SearchFilterType.choice, value);
        }
      },
      height: 42,
      fontSize: 12,
    );
  }
}
