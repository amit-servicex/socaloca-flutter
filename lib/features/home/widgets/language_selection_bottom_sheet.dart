import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Language selection bottom sheet shown on first home screen load
/// Matches language_change_popup.xml layout
class LanguageSelectionBottomSheet extends StatefulWidget {
  final Function(String languageCode, String languageName) onLanguageSelected;

  const LanguageSelectionBottomSheet({
    super.key,
    required this.onLanguageSelected,
  });

  @override
  State<LanguageSelectionBottomSheet> createState() =>
      _LanguageSelectionBottomSheetState();
}

class _LanguageSelectionBottomSheetState
    extends State<LanguageSelectionBottomSheet> {
  int? _selectedIndex;
  bool _showError = false;

  // Matches Utils.getLanguages() from Android
  final List<Map<String, String>> _languages = [
    {'name': 'English', 'code': 'en', 'display': 'English'},
    {'name': 'Spanish', 'code': 'es', 'display': 'español'},
    {'name': 'Portugese', 'code': 'pt', 'display': 'português'},
    {'name': 'French', 'code': 'fr', 'display': 'français'},
  ];

  void _handleSave() {
    if (_selectedIndex == null) {
      setState(() {
        _showError = true;
      });
      return;
    }

    final selected = _languages[_selectedIndex!];
    widget.onLanguageSelected(selected['code']!, selected['name']!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              children: [
                const Spacer(),
                const Text(
                  'Select Language',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.socaBlack,
                      size: 24,
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

          // Description
          const Padding(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Text(
              'SocaLoca is available in multiple languages. Please select one to continue.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
            ),
          ),

          // Language Grid (2 columns)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _languages.length,
              itemBuilder: (context, index) {
                final language = _languages[index];
                final isSelected = _selectedIndex == index;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                      _showError = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.socaYellow
                          : AppColors.socaGrey,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.socaBlack
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isSelected)
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.check_circle,
                              color: AppColors.socaBlack,
                              size: 20,
                            ),
                          ),
                        Text(
                          language['display']!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // Error message
          if (_showError)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Please select a language',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: AppColors.socaBlack,
                ),
              ),
            ),

          // Save button
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: InkWell(
              onTap: _handleSave,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.socaBlack,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Text(
                  'SAVE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.socaYellow,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
