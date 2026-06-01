import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

import '../../core/theme/app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Shared bottom-sheet picker used by both widget variants below.
// ─────────────────────────────────────────────────────────────────────────────

Future<String?> showSearchableSheet({
  required BuildContext context,
  required String title,
  required List<String> items,
  List<String>? values, // parallel value list; if null, items are the values
  String? selected,
}) async {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _SearchableSheet(
      title: title,
      items: items,
      values: values,
      selected: selected,
    ),
  );
}

class _SearchableSheet extends StatefulWidget {
  const _SearchableSheet({
    required this.title,
    required this.items,
    this.values,
    this.selected,
  });

  final String title;
  final List<String> items;
  final List<String>? values;
  final String? selected;

  @override
  State<_SearchableSheet> createState() => _SearchableSheetState();
}

class _SearchableSheetState extends State<_SearchableSheet> {
  final _searchCtrl = TextEditingController();
  List<int> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = List.generate(widget.items.length, (i) => i);
    _searchCtrl.addListener(_onSearch);
  }

  void _onSearch() {
    final q = _searchCtrl.text.toLowerCase();
    setState(() {
      _filtered = List.generate(widget.items.length, (i) => i)
          .where((i) => widget.items[i].toLowerCase().contains(q))
          .toList();
    });
  }

  String _valueAt(int i) =>
      widget.values != null ? widget.values![i] : widget.items[i];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxH = MediaQuery.of(context).size.height * 0.75;
    final width = MediaQuery.of(context).size.width * 0.85;

    return Container(
      height: maxH,
      width: width,
      decoration: const BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // handle bar
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              // borderRadius: BorderRadius.circular(2),
            ),
          ),
          // title
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          // search field
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              autofocus: true,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                hintText: 'Search...'.tr,
                hintStyle: const TextStyle(
                    fontFamily: 'Poppins', fontSize: 13, color: Colors.grey),
                prefixIcon: const Icon(Icons.search, size: 30),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                border: InputBorder.none,
                // OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(8),
                //   borderSide: BorderSide(color: Colors.grey.shade300),
                // ),
                enabledBorder: InputBorder.none,

                //   OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(8),
                //   borderSide: BorderSide(color: Colors.grey.shade300),
                // ),
                focusedBorder: InputBorder.none,
                // OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(8),
                //   borderSide: const BorderSide(color: AppColors.socaBlack),
                // ),
              ),
            ),
          ),
          const Divider(height: 1),
          // list
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Text(
                      'No results found'.tr,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filtered.length,
                    itemBuilder: (_, pos) {
                      final i = _filtered[pos];
                      final label = widget.items[i];
                      final val = _valueAt(i);
                      final isSelected =
                          val == widget.selected || label == widget.selected;
                      return InkWell(
                        onTap: () => Navigator.of(context).pop(val),
                        child: Container(
                          // color: isSelected
                          //     ? AppColors.socaYellow.withValues(alpha: 0.15)
                          //     : null,
                          decoration: BoxDecoration(
                            border: const Border(
                              bottom: const BorderSide(
                                color: AppColors.socaGrey,
                                width: .8,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  label,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    color: AppColors.socaBlack,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Icon(Icons.check,
                                    size: 18, color: AppColors.socaBlack),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 1. Form-field style — outlined border, label, error text
//    Replaces the _dropdownField() helper in form screens.
// ─────────────────────────────────────────────────────────────────────────────

class SearchableDropdownField extends StatelessWidget {
  const SearchableDropdownField({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
    this.values,
    this.error,
  });

  final String hint;
  final String? value;
  final List<String> items;
  final List<String>? values;
  final ValueChanged<String> onChanged;
  final String? error;

  String? get _displayLabel {
    if (value == null) return null;
    if (values != null) {
      final idx = values!.indexOf(value!);
      if (idx >= 0 && idx < items.length) return items[idx];
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final label = _displayLabel;
    final hasValue = label != null && label.isNotEmpty;
    return GestureDetector(
      onTap: () async {
        final picked = await showSearchableSheet(
          context: context,
          title: hint,
          items: items,
          values: values,
          selected: value,
        );
        if (picked != null) onChanged(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
              color: error != null ? Colors.red : const Color(0xFFDDDDDD)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                hasValue ? label : hint,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: hasValue ? Colors.black87 : Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Image.asset(
              'assets/images/dropdown.png',
              width: 14,
              height: 14,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.arrow_drop_down, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. Button / chip style — grey pill, for filter rows and profile screens
//    Drop-in replacement for DropdownButtonHideUnderline + DropdownButton.
// ─────────────────────────────────────────────────────────────────────────────

class SearchableDropdownButton extends StatelessWidget {
  const SearchableDropdownButton({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
    this.values,
    this.width,
    this.height = 48,
    this.backgroundColor,
    this.fontSize = 13,
    this.enabled = true,
  });

  final String hint;
  final String? value;
  final List<String> items;
  final List<String>? values;
  final ValueChanged<String?> onChanged;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final double fontSize;
  final bool enabled;

  String? get _displayLabel {
    if (value == null) return null;
    if (values != null) {
      final idx = values!.indexOf(value!);
      if (idx >= 0 && idx < items.length) return items[idx];
    }
    // Fall back: search items directly
    if (items.contains(value)) return value;
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final label = _displayLabel;
    final hasValue = label != null && label.isNotEmpty;
    return GestureDetector(
      onTap: enabled
          ? () async {
              final picked = await showSearchableSheet(
                context: context,
                title: hint,
                items: items,
                values: values,
                selected: value,
              );
              if (picked != null) onChanged(picked);
            }
          : null,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.socaGrey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                hasValue ? label : hint,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                  color: hasValue
                      ? AppColors.socaBlack
                      : AppColors.socaBlack.withValues(alpha: 0.6),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Image.asset(
              'assets/images/dropdown.png',
              width: 14,
              height: 14,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.arrow_drop_down, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
