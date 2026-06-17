import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/core/constants/app_strings.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/club_bio_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// NPS Survey Screen — matches Android NPSSurveyActivity.
///
/// 5 mandatory radio-group questions (q1–q5, values 1–5) plus one optional
/// free-text comment field (max 300 characters).
/// Triggered from [ClubBioScreen] when the server returns npsSurvey: true.
class NpsSurveyScreen extends ConsumerStatefulWidget {
  const NpsSurveyScreen({super.key});

  @override
  ConsumerState<NpsSurveyScreen> createState() => _NpsSurveyScreenState();
}

class _NpsSurveyScreenState extends ConsumerState<NpsSurveyScreen> {
  // 0 means unselected; valid selection is 1–5
  int _q1 = 0;
  int _q2 = 0;
  int _q3 = 0;
  int _q4 = 0;
  int _q5 = 0;

  final _commentController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  // ── Question definitions (exact labels from Android activity_npssurvey.xml) ─

  static const _q1Options = [
    'Not Likely',
    'Fairly Likely',
    'Likely',
    'Very Likely',
    'Extremely Likely',
  ];

  static const _q2Options = [
    'Very Dissatisfied',
    'Somewhat Dissatisfied',
    'Neither',
    'Somewhat Satisfied',
    'Very Satisfied',
  ];

  static const _q3Options = [
    'Very Low Quality',
    'Low Quality',
    'Neither',
    'High Quality',
    'Very High Quality',
  ];

  static const _q4Options = [
    'Not At All Responsive',
    'Somewhat Responsive',
    'Not So Responsive',
    'Very Responsive',
    'Extremely Responsive',
  ];

  static const _q5Options = [
    'Not At All Likely',
    'Not So Likely',
    'Somewhat Likely',
    'Very Likely',
    'Extremely Likely',
  ];

  // ── Actions ───────────────────────────────────────────────────────────────

  void _reset() {
    setState(() {
      _q1 = 0;
      _q2 = 0;
      _q3 = 0;
      _q4 = 0;
      _q5 = 0;
      _commentController.clear();
    });
  }

  Future<void> _save() async {
    // Validate all 5 mandatory questions (same as Android toast check)
    if (_q1 == 0 || _q2 == 0 || _q3 == 0 || _q4 == 0 || _q5 == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.pleaseAnswerAllMandatoryQuestions),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final params = (
      q1: _q1,
      q2: _q2,
      q3: _q3,
      q4: _q4,
      q5: _q5,
      comment: _commentController.text.trim(),
    );

    try {
      final success = await ref.read(saveNpsProvider(params).future);

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (success) {
        // Match Android: showPopupConfirmationSurvey() then finish()
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (Diglogconx) => Dialog(
            backgroundColor: Colors.white,
            insetPadding: const EdgeInsets.symmetric(horizontal: 28),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 52, 22, 34),
                  child: Text(
                    '${AppStrings.npsThankYouTitle}${AppStrings.npsThankYouBody}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.28,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.socaGrey,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(82, 16, 82, 36),
                  child: SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(Diglogconx).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.socaBlack,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        AppStrings.ok.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaYellow,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        if (mounted) Navigator.of(context).pop(); // finish screen
      }
      // Silent failure: stay on screen (same as Android onFetchFailure)
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: SizedBox(
          width: 0,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            color: AppColors.socaBlack,
            height: 2,
          ),
        ),
        centerTitle: true,
        title: Text(
          AppStrings.rateYourExperience.replaceFirst('!', ''),
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.socaBlack,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuestion(
                  question: AppStrings.npsQ1,
                  options: _q1Options,
                  selected: _q1,
                  onChanged: (v) => setState(() => _q1 = v),
                ),
                _divider(),
                _buildQuestion(
                  question: AppStrings.npsQ2,
                  options: _q2Options,
                  selected: _q2,
                  onChanged: (v) => setState(() => _q2 = v),
                ),
                _divider(),
                _buildQuestion(
                  question: AppStrings.npsQ3,
                  options: _q3Options,
                  selected: _q3,
                  onChanged: (v) => setState(() => _q3 = v),
                ),
                _divider(),
                _buildQuestion(
                  question: AppStrings.npsQ4,
                  options: _q4Options,
                  selected: _q4,
                  onChanged: (v) => setState(() => _q4 = v),
                ),
                _divider(),
                _buildQuestion(
                  question: AppStrings.npsQ5,
                  options: _q5Options,
                  selected: _q5,
                  onChanged: (v) => setState(() => _q5 = v),
                ),
                _divider(),

                // Q6 — optional comment
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    AppStrings.npsQ6,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _commentController,
                    maxLength: 300,
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.socaBlack),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: AppColors.socaBlack, width: 1.5),
                      ),
                      hintText: '',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),

          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: AppLoader(),
            ),
        ],
      ),

      // Bottom action buttons: RESET | SAVE (matches Android layout)
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _isLoading ? null : _reset,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.socaBlack),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  AppStrings.resetUpper,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaBlack,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                ),
                child: Text(
                  AppStrings.save.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaYellow,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _buildQuestion({
    required String question,
    required List<String> options,
    required int selected,
    required ValueChanged<int> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: AppColors.socaBlack,
          padding: const EdgeInsets.fromLTRB(6, 8, 10, 8),
          child: Text(
            question.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w800,
              height: 1.25,
              color: AppColors.socaYellow,
            ),
          ),
        ),
        // 5 radio options using RadioGroup (Flutter 3.32+ API)
        RadioGroup<int>(
          groupValue: selected,
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
          child: Column(
            children: List.generate(options.length, (i) {
              final value = i + 1;
              return InkWell(
                onTap: () => onChanged(value),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 12, 5),
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.3,
                        child: Radio<int>(
                          value: value,
                          activeColor: AppColors.socaBlack,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          splashRadius: 24,
                          visualDensity: const VisualDensity(
                            horizontal: 1,
                            vertical: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          options[i],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _divider() =>
      Divider(height: 8, thickness: 0.8, color: AppColors.socaGrey);
}
