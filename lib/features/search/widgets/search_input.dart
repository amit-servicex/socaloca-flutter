import 'package:flutter/material.dart';
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
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Player/Coach/Manager/Referee'.tr,
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
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
            icon: Icon(Icons.search, color: Colors.black54),
            onPressed: _handleSearch,
          ),
        ],
      ),
    );
  }
}
