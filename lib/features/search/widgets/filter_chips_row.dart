import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/search_provider.dart';

class FilterChipsRow extends ConsumerWidget {
  const FilterChipsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchProvider);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: state.filters.map((filter) {
        return Chip(
          label: Text(
            filter.value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
            ),
          ),
          deleteIcon: const Icon(Icons.close, size: 16),
          onDeleted: () {
            ref.read(searchProvider.notifier).removeFilter(filter.type);
          },
          backgroundColor: const Color(0xFFE0E0E0),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        );
      }).toList(),
    );
  }
}
