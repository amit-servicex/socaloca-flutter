import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final Function(String) onSearch;

  const SearchInput({
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
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Player/Coach/Manager/Referee',
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
              style: const TextStyle(
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
            icon: const Icon(Icons.search, color: Colors.black54),
            onPressed: _handleSearch,
          ),
        ],
      ),
    );
  }
}
