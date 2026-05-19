import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import '../providers/search_provider.dart';

class FilterChipsRow extends ConsumerWidget {
  const FilterChipsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchProvider);

    return Wrap(
      spacing: 5,
      runSpacing: 8,
      children: state.filters.map((filter) {
        return Chip(
          label: Text(
            filter.value.tr,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Colors.white,
            ),
          ),
          deleteIcon: const Icon(Icons.close, size: 16, color: Colors.grey),
          onDeleted: () {
            ref.read(searchProvider.notifier).removeFilter(filter.type);
          },
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        );
      }).toList(),
    );
  }
}
