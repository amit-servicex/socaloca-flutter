import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../data/models/pickup_match_model.dart';
import '../data/repositories/pickup_match_repository.dart';

/// Pickup Match Details Screen
/// Shows detailed information about a pickup match
class PickupMatchDetailsScreen extends ConsumerStatefulWidget {
  const PickupMatchDetailsScreen({
    super.key,
    required this.matchId,
  });

  final String matchId;

  @override
  ConsumerState<PickupMatchDetailsScreen> createState() =>
      _PickupMatchDetailsScreenState();
}

class _PickupMatchDetailsScreenState
    extends ConsumerState<PickupMatchDetailsScreen> {
  PickupMatchModel? _match;
  bool _isLoading = true;
  String? _errorMessage;
  bool _isRequesting = false;

  @override
  void initState() {
    super.initState();
    _loadMatchDetails();
  }

  Future<void> _loadMatchDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = ref.read(currentUserProvider);
      if (user == null) {
        setState(() {
          _errorMessage = 'User not found';
          _isLoading = false;
        });
        return;
      }

      final match =
          await ref.read(pickupMatchRepositoryProvider).getPickupMatchDetails(
                userId: user.id,
                matchId: widget.matchId,
              );

      if (mounted) {
        setState(() {
          _match = match;
          _isLoading = false;
          if (match == null) {
            _errorMessage = 'Match not found';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error loading match details';
          _isLoading = false;
        });
      }
    }
  }

  bool _isHost() {
    final user = ref.read(currentUserProvider);
    if (user == null || _match == null) return false;
    return _match!.createdBy == user.id;
  }

  Future<void> _requestToJoin() async {
    if (_isRequesting) return;

    setState(() => _isRequesting = true);

    try {
      final user = ref.read(currentUserProvider);
      if (user == null) {
        _showError('User not found');
        return;
      }

      final success =
          await ref.read(pickupMatchRepositoryProvider).requestPickupMatch(
                userId: user.id,
                matchId: widget.matchId,
              );

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Request sent successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          // Reload match details to update request status
          _loadMatchDetails();
        } else {
          _showError('Failed to send request. Please try again.');
        }
      }
    } catch (e) {
      _showError('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _isRequesting = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  String _formatDate() {
    if (_match == null) return '';
    if (_match!.startTimeGmt == 0) return _match!.matchDate ?? '';
    final date = DateTime.fromMillisecondsSinceEpoch(_match!.startTimeGmt);
    return DateFormat('EEEE, MMM dd, yyyy').format(date);
  }

  String _formatTime() {
    if (_match == null) return '';
    return '${_match!.startTime ?? ''} - ${_match!.endTime ?? ''}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        title: const Text(
          'Match Details',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.socaBlack,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.socaBlack),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.socaYellow,
              ),
            )
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _errorMessage!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadMatchDetails,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.socaYellow,
                        ),
                        child: const Text(
                          'Retry',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : _match == null
                  ? const Center(child: Text('Match not found'))
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Match Info Card
                                _buildMatchInfoCard(),

                                const SizedBox(height: 16),

                                // Host Info Card
                                _buildHostInfoCard(),

                                const SizedBox(height: 16),

                                // Location Card
                                if (_match!.locationName != null &&
                                    _match!.locationName!.isNotEmpty)
                                  _buildLocationCard(),
                              ],
                            ),
                          ),
                        ),

                        // Action Button
                        _buildActionButton(),
                      ],
                    ),
    );
  }

  Widget _buildMatchInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Match Information',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: AppColors.socaBlack,
            ),
          ),

          const SizedBox(height: 16),

          // Badges
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (_match!.gameType != null)
                _buildBadge(_match!.gameType!, Icons.sports_soccer),
              if (_match!.avgAge != null)
                _buildBadge(_match!.avgAge!, Icons.cake),
              if (_match!.gender != null)
                _buildBadge(_match!.gender!, Icons.people),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // Details
          _buildDetailRow(Icons.stadium, 'Venue', _match!.venueName ?? 'N/A'),
          const SizedBox(height: 12),
          _buildDetailRow(
              Icons.people, 'Max Players', '${_match!.maxPlayer} players'),
          const SizedBox(height: 12),
          _buildDetailRow(Icons.calendar_today, 'Date', _formatDate()),
          const SizedBox(height: 12),
          _buildDetailRow(Icons.access_time, 'Time', _formatTime()),

          // Match Note
          if (_match!.matchNote != null && _match!.matchNote!.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            const Text(
              'Match Note',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _match!.matchNote!,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack.withOpacity(0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHostInfoCard() {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to host profile
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Host Avatar
            _buildHostAvatar(),
            const SizedBox(width: 12),

            // Host Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hosted by',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _match!.createdByName ?? 'Host',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            color: AppColors.socaYellow,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Location',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _match!.locationName!,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
              ],
            ),
          ),
          // Map button
          IconButton(
            onPressed: () {
              // TODO: Open map with location
            },
            icon: const Icon(
              Icons.map,
              color: AppColors.socaBlack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    final isHost = _isHost();

    // Determine button state
    String buttonText;
    Color buttonColor;
    Color textColor;
    bool isEnabled;
    VoidCallback? onPressed;

    if (isHost) {
      buttonText = 'VIEW REQUESTS';
      buttonColor = AppColors.socaBlack;
      textColor = AppColors.socaYellow;
      isEnabled = true;
      onPressed = () {
        context.push(
          '${AppRoutes.pickupMatches}/${widget.matchId}/requests',
        );
      };
    } else {
      // Check request status from match data
      final requestStatus = _match!.requestStatus;

      if (requestStatus == 'accepted') {
        buttonText = 'ACCEPTED';
        buttonColor = Colors.green;
        textColor = Colors.white;
        isEnabled = false;
        onPressed = null;
      } else if (requestStatus == 'declined') {
        buttonText = 'DECLINED';
        buttonColor = Colors.red;
        textColor = Colors.white;
        isEnabled = false;
        onPressed = null;
      } else if (requestStatus == 'pending') {
        buttonText = 'REQUEST PENDING';
        buttonColor = Colors.grey;
        textColor = Colors.white;
        isEnabled = false;
        onPressed = null;
      } else {
        buttonText = 'REQUEST TO JOIN';
        buttonColor = AppColors.socaBlack;
        textColor = AppColors.socaYellow;
        isEnabled = !_isRequesting;
        onPressed = _requestToJoin;
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            disabledBackgroundColor: buttonColor.withOpacity(0.6),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _isRequesting
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(AppColors.socaYellow),
                  ),
                )
              : Text(
                  buttonText,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildHostAvatar() {
    final url = ApiConstants.getImageUrl(_match!.createdByImage);
    return Container(
      width: 56,
      height: 56,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.socaGrey,
      ),
      child: ClipOval(
        child: url.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const Icon(
                  Icons.person,
                  color: AppColors.socaBlack,
                  size: 28,
                ),
              )
            : const Icon(Icons.person, color: AppColors.socaBlack, size: 28),
      ),
    );
  }

  Widget _buildBadge(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.socaYellow.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.socaBlack),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.socaBlack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.socaBlack.withOpacity(0.6),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: AppColors.socaBlack.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.socaBlack,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
