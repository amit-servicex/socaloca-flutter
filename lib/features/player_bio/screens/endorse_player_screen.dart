import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/player_bio_provider.dart';

class EndorsePlayerScreen extends ConsumerStatefulWidget {
  final String playerId;
  final String playerName;

  const EndorsePlayerScreen({
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

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
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
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to submit endorsement. Try again.',
                style: TextStyle(fontFamily: 'Poppins')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e',
                style: const TextStyle(fontFamily: 'Poppins')),
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
      appBar: AppBar(
        title: const Text('Endorse Player'),
        backgroundColor: AppColors.socaBlack,
        foregroundColor: AppColors.socaYellow,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Write your endorsement for ${widget.playerName}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.socaBlack,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _commentController,
              maxLines: 5,
              onChanged: (_) {
                if (_hasError) setState(() => _hasError = false);
              },
              decoration: InputDecoration(
                hintText: 'Share your thoughts about this player...',
                hintStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: _hasError ? Colors.red : Colors.grey.shade300,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: _hasError ? Colors.red : Colors.grey.shade300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: _hasError ? Colors.red : AppColors.socaYellow,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            if (_hasError)
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  'Please enter your endorsement comment.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socaYellow,
                      foregroundColor: AppColors.socaBlack,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.socaBlack,
                            ),
                          )
                        : const Text(
                            'Submit Endorsement',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {
                    _commentController.clear();
                    setState(() => _hasError = false);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
