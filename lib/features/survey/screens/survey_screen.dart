import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';

/// 4-step survey screen matching Android SurveyActivity flow:
///   Step 0 — Rating (1–5)
///   Step 1 — Favourite features (multi-select)
///   Step 2 — Feedback text (max 150 chars)
///   Step 3 — Thank you
class SurveyScreen extends ConsumerStatefulWidget {
  const SurveyScreen({super.key});

  @override
  ConsumerState<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends ConsumerState<SurveyScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  // Survey data
  int? _rating;
  final Set<String> _selectedFeatures = {};
  final _feedbackCtrl = TextEditingController();
  bool _isSubmitting = false;

  // Matches Android feature keys sent to the API
  static const _features = [
    _Feature('Feed', 'FEED'),
    _Feature('My Bio', 'MY BIO'),
    _Feature('Pick-Up Match', 'PICK-UP MATCH'),
    _Feature('Endorsements', 'ENDORSEMENTS'),
    _Feature('Tournaments', 'TOURNAMENTS'),
    _Feature('Academies', 'ACADEMIES'),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _feedbackCtrl.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skip() {
    if (_currentPage == 0) _rating = null;
    if (_currentPage == 1) _selectedFeatures.clear();
    if (_currentPage == 2) {
      _submitSurvey(feedback: null);
      return;
    }
    _goNext();
  }

  Future<void> _submitSurvey({String? feedback}) async {
    setState(() => _isSubmitting = true);
    try {
      final userId = StorageService.userId ?? '';
      await ApiClient.instance.post(
        ApiConstants.submitSurvey,
        body: {
          'userId': userId,
          'ratePoint': _rating ?? 0,
          'features': _selectedFeatures.toList(),
          'feedback': feedback ?? _feedbackCtrl.text.trim(),
        },
      );
    } catch (_) {
      // Silently ignore errors — survey submission is best-effort
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
      _goNext();
    }
  }

  void _close() => Navigator.of(context).pop();

  // ── Build ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (p) => setState(() => _currentPage = p),
            children: [
              _RatingPage(
                progress: 0,
                selectedRating: _rating,
                onRatingSelected: (r) => setState(() => _rating = r),
                onSkip: _skip,
                onNext: () {
                  if (_rating == null) {
                    _showToast('Please select a rating');
                    return;
                  }
                  _goNext();
                },
                onClose: _close,
              ),
              _FeaturesPage(
                progress: 34,
                selectedFeatures: _selectedFeatures,
                features: _features,
                onToggle: (key) {
                  setState(() {
                    if (_selectedFeatures.contains(key)) {
                      _selectedFeatures.remove(key);
                    } else {
                      _selectedFeatures.add(key);
                    }
                  });
                },
                onSkip: _skip,
                onNext: _goNext,
                onClose: _close,
              ),
              _FeedbackPage(
                progress: 67,
                controller: _feedbackCtrl,
                isSubmitting: _isSubmitting,
                onSkip: () => _submitSurvey(feedback: null),
                onNext: () => _submitSurvey(feedback: _feedbackCtrl.text.trim()),
                onClose: _close,
              ),
              _ThankYouPage(onDone: _close),
            ],
          ),
        ),
      ),
    );
  }

  void _showToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(fontFamily: 'Poppins')),
        backgroundColor: AppColors.socaBlack,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// ── Shared header ─────────────────────────────────────────────────────────────

class _SurveyHeader extends StatelessWidget {
  const _SurveyHeader({
    required this.title,
    required this.progress,
    required this.onClose,
  });

  final String title;
  final int progress;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onClose,
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.close, size: 30, color: AppColors.socaBlack),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: progress / 100,
              minHeight: 10,
              backgroundColor: AppColors.socaGrey,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.socaBlack),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Shared bottom buttons ─────────────────────────────────────────────────────

class _SurveyBottomButtons extends StatelessWidget {
  const _SurveyBottomButtons({
    required this.onSkip,
    required this.onNext,
    this.nextLabel = 'NEXT',
    this.isLoading = false,
  });

  final VoidCallback onSkip;
  final VoidCallback onNext;
  final String nextLabel;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SKIP button
          GestureDetector(
            onTap: onSkip,
            child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.socaBlack, width: 1),
              ),
              alignment: Alignment.center,
              child: const Text(
                'SKIP',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.socaBlack,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          // NEXT / SUBMIT button
          GestureDetector(
            onTap: isLoading ? null : onNext,
            child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.socaYellow,
                      ),
                    )
                  : Text(
                      nextLabel,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.socaYellow,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Step 0: Rating ────────────────────────────────────────────────────────────

class _RatingPage extends StatelessWidget {
  const _RatingPage({
    required this.progress,
    required this.selectedRating,
    required this.onRatingSelected,
    required this.onSkip,
    required this.onNext,
    required this.onClose,
  });

  final int progress;
  final int? selectedRating;
  final ValueChanged<int> onRatingSelected;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SurveyHeader(
          title: 'Your feedback matters!',
          progress: progress,
          onClose: onClose,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Emoji row (sad ← → happy)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Sad emoji
                    SizedBox(
                      width: 45,
                      child: Text(
                        '😞',
                        style: const TextStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 15 * 3 + 45 * 3), // spacer
                    // Happy emoji
                    SizedBox(
                      width: 45,
                      child: Text(
                        '😊',
                        style: const TextStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // 1-5 rating buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) {
                    final value = i + 1;
                    final isSelected = selectedRating == value;
                    return GestureDetector(
                      onTap: () => onRatingSelected(value),
                      child: Container(
                        width: 45,
                        height: 40,
                        margin: EdgeInsets.only(left: i == 0 ? 0 : 15),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.socaBlack
                              : AppColors.socaGrey,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: AppColors.socaBlack,
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$value',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: isSelected
                                ? AppColors.socaYellow
                                : AppColors.socaBlack,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 50),
                // Illustration
                Image.asset(
                  'assets/images/survey_man.png',
                  width: 260,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.sentiment_satisfied_alt,
                    size: 160,
                    color: AppColors.socaGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
        _SurveyBottomButtons(onSkip: onSkip, onNext: onNext),
      ],
    );
  }
}

// ── Step 1: Favourite Features ────────────────────────────────────────────────

class _FeaturesPage extends StatelessWidget {
  const _FeaturesPage({
    required this.progress,
    required this.selectedFeatures,
    required this.features,
    required this.onToggle,
    required this.onSkip,
    required this.onNext,
    required this.onClose,
  });

  final int progress;
  final Set<String> selectedFeatures;
  final List<_Feature> features;
  final ValueChanged<String> onToggle;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    // Split into 2 rows of 3
    final row1 = features.sublist(0, 3);
    final row2 = features.sublist(3);

    return Column(
      children: [
        _SurveyHeader(
          title: 'Your feedback matters!',
          progress: progress,
          onClose: onClose,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What are your favourite features?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
                const SizedBox(height: 30),
                _featureRow(row1),
                const SizedBox(height: 15),
                _featureRow(row2),
              ],
            ),
          ),
        ),
        _SurveyBottomButtons(onSkip: onSkip, onNext: onNext),
      ],
    );
  }

  Widget _featureRow(List<_Feature> items) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items.map((f) {
        final isSelected = selectedFeatures.contains(f.apiKey);
        return GestureDetector(
          onTap: () => onToggle(f.apiKey),
          child: Container(
            width: 105,
            height: 40,
            margin: EdgeInsets.only(
              left: items.indexOf(f) == 0 ? 0 : 5,
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.socaBlack : AppColors.socaGrey,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColors.socaBlack, width: 1),
            ),
            alignment: Alignment.center,
            child: Text(
              f.label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 11,
                color: isSelected ? AppColors.socaYellow : AppColors.socaBlack,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ── Step 2: Feedback Text ─────────────────────────────────────────────────────

class _FeedbackPage extends StatelessWidget {
  const _FeedbackPage({
    required this.progress,
    required this.controller,
    required this.isSubmitting,
    required this.onSkip,
    required this.onNext,
    required this.onClose,
  });

  final int progress;
  final TextEditingController controller;
  final bool isSubmitting;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SurveyHeader(
          title: 'Your feedback matters!',
          progress: progress,
          onClose: onClose,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10, 20, 50, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Text(
                        'Do you want to offer us some feedback?',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text('😊', style: TextStyle(fontSize: 22)),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: AppColors.socaGrey,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.socaBlack, width: 1),
                  ),
                  child: TextField(
                    controller: controller,
                    maxLength: 150,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: AppColors.socaBlack,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter text here (max 150 characters)',
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(10),
                      counterStyle: const TextStyle(fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _SurveyBottomButtons(
          onSkip: onSkip,
          onNext: onNext,
          nextLabel: 'SUBMIT',
          isLoading: isSubmitting,
        ),
      ],
    );
  }
}

// ── Step 3: Thank You ─────────────────────────────────────────────────────────

class _ThankYouPage extends StatelessWidget {
  const _ThankYouPage({required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header — title changes to "Thank you!"
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Thank you!',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onDone,
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.close, size: 30, color: AppColors.socaBlack),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: const LinearProgressIndicator(
              value: 1.0,
              minHeight: 10,
              backgroundColor: AppColors.socaGrey,
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppColors.socaBlack),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Column(
              children: [
                // Thumbs up icon
                const Icon(
                  Icons.thumb_up_alt_rounded,
                  size: 120,
                  color: AppColors.socaBlack,
                ),
                const SizedBox(height: 40),
                const Text(
                  'We highly value your feedback!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Thank you for giving your feedback, we appreciate your support in helping us to improve the app.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
              ],
            ),
          ),
        ),
        // DONE button
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
          child: GestureDetector(
            onTap: onDone,
            child: Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: const Text(
                'DONE',
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
      ],
    );
  }
}

// ── Data class ────────────────────────────────────────────────────────────────

class _Feature {
  const _Feature(this.label, this.apiKey);
  final String label;
  final String apiKey;
}
