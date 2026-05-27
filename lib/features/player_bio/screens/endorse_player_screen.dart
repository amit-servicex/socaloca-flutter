import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/player_bio_provider.dart';

class EndorsePlayerScreen extends ConsumerStatefulWidget {
  final String playerId;
  final String playerName;

  EndorsePlayerScreen({
    super.key,
    required this.playerId,
    required this.playerName,
  });

  @override
  ConsumerState<EndorsePlayerScreen> createState() =>
      _EndorsePlayerScreenState();
}

class _EndorsePlayerScreenState extends ConsumerState<EndorsePlayerScreen> {
  final _commentController = TextEditingController();
  bool _hasError = false;
  bool _isSubmitting = false;

  static int _maxChars = 200;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _reset() {
    _commentController.clear();
    setState(() => _hasError = false);
  }

  Future<void> _submit() async {
    final comment = _commentController.text.trim();
    if (comment.isEmpty) {
      setState(() => _hasError = true);
      return;
    }
    setState(() {
      _hasError = false;
      _isSubmitting = true;
    });

    final userId = StorageService.userId;
    final currentUser = StorageService.currentUser;
    if (userId == null || currentUser == null) {
      setState(() => _isSubmitting = false);
      return;
    }

    try {
      final repo = ref.read(playerBioRepositoryProvider);
      final success = await repo.endorsePlayer(
        userId: userId,
        toUserId: widget.playerId,
        comment: comment,
        isAdmin: currentUser['isAdmin'] as bool? ?? false,
        isPlayer: currentUser['isPlayer'] as bool? ?? false,
        isCoach: currentUser['isCoach'] as bool? ?? false,
        isFan: currentUser['isFan'] as bool? ?? false,
        firstName: currentUser['firstName'] as String? ?? '',
        lastName: currentUser['lastName'] as String? ?? '',
        myImageUrl: currentUser['imageUrl'] as String? ?? '',
      );
      if (!mounted) return;
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'It will update as soon as ${widget.playerName} accepts it.',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit endorsement. Try again.'.tr,
                style: TextStyle(fontFamily: 'Poppins')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e', style: TextStyle(fontFamily: 'Poppins')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      // appBar: AppBar(
      //   backgroundColor: AppColors.socaBlack,
      //   foregroundColor: AppColors.socaYellow,
      //   elevation: 0,
      //   titleSpacing: 0,
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Black header banner ───────────────────────────────────────────
          Container(
            margin: EdgeInsets.only(left: 16, top: 10),
            color: AppColors.socaBlack,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Text(
              'Endorse'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.socaYellow,
              ),
            ),
          ),

          // ── Body ─────────────────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Subtitle
                  Text(
                    'Assist other Players & Coaches by giving an endorsement'
                        .tr,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  TextField(
                    controller: _commentController,
                    maxLines: 8,
                    maxLength: _maxChars,
                    buildCounter: (_,
                            {required currentLength,
                            required isFocused,
                            maxLength}) =>
                        null,
                    onChanged: (_) {
                      if (_hasError) setState(() => _hasError = false);
                      setState(() {});
                    },
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: AppColors.socaBlack,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),

                  // Text input with plain border
                  SizedBox(height: 16),

                  // max characters label
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        'max $_maxChars characters',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 24),

                  // ADD / RESET buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _ActionButton(
                        label: 'ADD',
                        onPressed: _isSubmitting ? null : _submit,
                        isLoading: _isSubmitting,
                      ),
                      SizedBox(width: 16),
                      _ActionButton(
                        label: 'RESET',
                        onPressed: _isSubmitting ? null : _reset,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  _ActionButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 12),
        color: onPressed == null ? Colors.grey.shade400 : AppColors.socaBlack,
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.socaYellow,
                ),
              )
            : Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.socaYellow,
                ),
              ),
      ),
    );
  }
}
