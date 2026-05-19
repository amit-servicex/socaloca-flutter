import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import '../data/models/search_filter_model.dart';
import '../providers/search_provider.dart';
import '../utils/countries_list.dart';

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
    return _FilterDropdown(
      hint: 'By Country'.tr,
      value: _selectedCountry,
      items: ['All', ...CountriesList.countries],
      onChanged: (value) {
        setState(() {
          _selectedCountry = value;
        });
        if (value != null) {
          ref.read(searchProvider.notifier).addFilter(
                SearchFilterType.country,
                value,
              );
        }
      },
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
    return _FilterDropdown(
      hint: 'By Type'.tr,
      value: _selectedType,
      items: const [
        UserTypeFilter.player,
        UserTypeFilter.coach,
        UserTypeFilter.manager,
        UserTypeFilter.referee,
      ],
      onChanged: (value) {
        setState(() {
          _selectedType = value;
        });
        if (value != null) {
          ref.read(searchProvider.notifier).addFilter(
                SearchFilterType.type,
                value,
              );
        }
      },
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
    return _FilterDropdown(
      hint: 'By Choice'.tr,
      value: _selectedChoice,
      items: const [
        SortingFilter.mostPosts,
        SortingFilter.mostAppearances,
        SortingFilter.mostGoals,
      ],
      enabled: widget.enabled,
      onChanged: widget.enabled
          ? (value) {
              setState(() {
                _selectedChoice = value;
              });
              if (value != null) {
                ref.read(searchProvider.notifier).addFilter(
                      SearchFilterType.choice,
                      value,
                    );
              }
            }
          : null,
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final Function(String?)? onChanged;
  final bool enabled;

  const _FilterDropdown({
    required this.hint,
    required this.value,
    required this.items,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            hint,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          value: value,
          isExpanded: true,
          icon: Image.asset(
            "assets/images/dropdown.png",
            width: 14,
            height: 14,
          ),
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item.tr,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: enabled ? onChanged : null,
        ),
      ),
    );
  }
}
