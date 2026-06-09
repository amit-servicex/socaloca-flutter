import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/theme/app_colors.dart';

/// Language selection bottom sheet shown on first home screen load.
/// Matches language_change_popup.xml layout.
/// Wires into [localeProvider] to actually change the app locale on save.
class LanguageSelectionBottomSheet extends ConsumerStatefulWidget {
  final Function(String languageCode, String languageName) onLanguageSelected;

  const LanguageSelectionBottomSheet({
    super.key,
    required this.onLanguageSelected,
  });

  @override
  ConsumerState<LanguageSelectionBottomSheet> createState() =>
      _LanguageSelectionBottomSheetState();
}

class _LanguageSelectionBottomSheetState
    extends ConsumerState<LanguageSelectionBottomSheet> {
  int? _selectedIndex;
  bool _showError = false;

  // Matches Utils.getLanguages() from Android
  final List<Map<String, String>> _languages = [
    {'name': 'English', 'code': 'en'},
    {'name': 'Spanish', 'code': 'es'},
    {'name': 'Portugese', 'code': 'pt'},
    {'name': 'French', 'code': 'fr'},
  ];

  String _languageDisplayName(String code) {
    switch (code) {
      case 'es':
        return AppStrings.spanishLanguage;
      case 'pt':
        return AppStrings.portugueseLanguage;
      case 'fr':
        return AppStrings.frenchLanguage;
      case 'en':
      default:
        return AppStrings.englishLanguage;
    }
  }

  @override
  void initState() {
    super.initState();
    final currentCode = AppStrings.currentLanguage;
    final index =
        _languages.indexWhere((language) => language['code'] == currentCode);
    _selectedIndex = index >= 0 ? index : 0;
  }

  Future<void> _handleSave() async {
    if (_selectedIndex == null) {
      setState(() => _showError = true);
      return;
    }

    final selected = _languages[_selectedIndex!];
    final code = selected['code']!;
    final name = selected['name']!;

    // Update locale in app + persist to SharedPreferences
    await ref.read(localeProvider.notifier).setLocale(code, name);

    if (!mounted) return;
    widget.onLanguageSelected(code, name);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(localeProvider);

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 1, color: AppColors.socaBlack),

            Padding(
              padding: const EdgeInsets.only(left: 24, right: 8),
              child: Row(
                children: [
                  const Spacer(),
                  Text(
                    AppStrings.selectLanguage,
                    style: const TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFF777777),
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),

            Container(
                height: 0.8, color: AppColors.socaBlack.withOpacity(0.35)),

            // Description
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
              child: Text(
                AppStrings.selectLanguageDesc,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  height: 1.15,
                  fontWeight: FontWeight.w400,
                  color: AppColors.socaBlack,
                ),
              ),
            ),

            // Language Grid (2 columns)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 44),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3.45,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  final language = _languages[index];
                  final isSelected = _selectedIndex == index;

                  return InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        _showError = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.socaBlack : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: AppColors.socaBlack,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _languageDisplayName(language['code']!),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight:
                                isSelected ? FontWeight.w800 : FontWeight.w700,
                            fontSize: 12,
                            color: isSelected
                                ? AppColors.socaYellow
                                : AppColors.socaBlack,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // Error message
            if (_showError)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  AppStrings.pleaseSelectLanguage,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),

            // Save button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: InkWell(
                borderRadius: BorderRadius.circular(28),
                onTap: _handleSave,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.socaBlack,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Text(
                    AppStrings.save.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: AppColors.socaYellow,
                    ),
                  ),
                ),
              ),
            ),

            Container(
              width: 114,
              height: 3,
              margin: const EdgeInsets.only(bottom: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF777777),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
