import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/providers/auth_provider.dart';
import '../../../data/tournament_models.dart';
import '../../../data/repositories/match_management_repository.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Score Entry Tab
/// Allows authorized users to enter and submit match scores
/// Matches Android score entry functionality
class ScoreEntryTab extends ConsumerStatefulWidget {
  final String matchId;
  final TournamentMatchModel match;
  final String tournamentId;

  const ScoreEntryTab({
    super.key,
    required this.matchId,
    required this.match,
    required this.tournamentId,
  });

  @override
  ConsumerState<ScoreEntryTab> createState() => _ScoreEntryTabState();
}

class _ScoreEntryTabState extends ConsumerState<ScoreEntryTab> {
  final _formKey = GlobalKey<FormState>();
  final _homeScoreController = TextEditingController();
  final _awayScoreController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill if scores exist
    if (widget.match.homeScore != null) {
      _homeScoreController.text = widget.match.homeScore.toString();
    }
    if (widget.match.awayScore != null) {
      _awayScoreController.text = widget.match.awayScore.toString();
    }
  }

  @override
  void dispose() {
    _homeScoreController.dispose();
    _awayScoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.socaYellow.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.socaYellow.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppColors.socaYellow,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      AppStrings.scoreEntryHint,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Score Entry Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Home Team Score
                    _buildScoreField(
                      label: widget.match.homeTeamName ?? 'Home Team',
                      controller: _homeScoreController,
                      logo: widget.match.homeTeamLogo,
                    ),

                    const SizedBox(height: 24),

                    // VS Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey[300])),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            AppStrings.vs,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey[300])),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Away Team Score
                    _buildScoreField(
                      label: widget.match.awayTeamName ?? 'Away Team',
                      controller: _awayScoreController,
                      logo: widget.match.awayTeamLogo,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Submit Button
            const AppLoader(size: 24, centered: false),

            const SizedBox(height: 16),

            // Clear Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _isSubmitting ? null : _clearScores,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.socaBlack,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: const BorderSide(color: AppColors.socaBlack),
                ),
                child: Text(
                  AppStrings.clear,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreField({
    required String label,
    required TextEditingController controller,
    String? logo,
  }) {
    return Row(
      children: [
        // Team Logo
        if (logo != null)
          Image.network(
            logo,
            width: 40,
            height: 40,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.shield,
              size: 40,
              color: Colors.grey,
            ),
          )
        else
          const Icon(
            Icons.shield,
            size: 40,
            color: Colors.grey,
          ),

        const SizedBox(width: 16),

        // Team Name
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Score Input
        SizedBox(
          width: 80,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
            ],
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText: '0'.tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.socaYellow,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Future<void> _submitScore() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final user = ref.read(currentUserProvider);
      if (user == null) {
        throw Exception('User not logged in');
      }

      final repository = ref.read(matchManagementRepositoryProvider);
      final homeScore = int.parse(_homeScoreController.text);
      final awayScore = int.parse(_awayScoreController.text);

      final success = await repository.sendMatchScore(
        userId: user.id,
        matchId: widget.matchId,
        homeScore: homeScore,
        awayScore: awayScore,
        tournamentId: widget.tournamentId,
      );

      if (mounted) {
        setState(() => _isSubmitting = false);

        if (success) {
          _showSuccessDialog('Score submitted successfully!');
        } else {
          _showErrorDialog('Failed to submit score. Please try again.');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        _showErrorDialog('Error: ${e.toString()}');
      }
    }
  }

  void _clearScores() {
    _homeScoreController.clear();
    _awayScoreController.clear();
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppStrings.success,
          style: const TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.ok),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppStrings.error,
          style: const TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.ok),
          ),
        ],
      ),
    );
  }
}
