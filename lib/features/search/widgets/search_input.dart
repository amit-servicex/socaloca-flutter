import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socaloca/core/constants/app_strings.dart';

class SearchInput extends StatefulWidget {
  final Function(String) onSearch;

  SearchInput({
    super.key,
    required this.onSearch,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSearch() {
    widget.onSearch(_controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Player/Coach/Manager/Referee'.tr,
                hintStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black54,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')),
              ],
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _handleSearch(),
              onChanged: (value) {
                // Auto-search when text is cleared
                if (value.isEmpty) {
                  _handleSearch();
                }
              },
            ),
          ),
          IconButton(
            icon: Image.asset(
              'assets/icons/ic_search.png',
              width: 26,
              height: 26,
            ),
            onPressed: _handleSearch,
          ),
        ],
      ),
    );
  }
}
