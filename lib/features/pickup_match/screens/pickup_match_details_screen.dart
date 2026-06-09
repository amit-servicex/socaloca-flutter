import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
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
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Pickup Match Details Screen
/// Shows detailed information about a pickup match
class PickupMatchDetailsScreen extends ConsumerStatefulWidget {
  PickupMatchDetailsScreen({
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
          _errorMessage = AppStrings.userNotFound;
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
            _errorMessage = AppStrings.matchNotFound;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = AppStrings.errorLoadingMatchDetails;
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
        _showError(AppStrings.userNotFound);
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
            SnackBar(
              content: Text('Request sent successfully!'.tr),
              backgroundColor: Colors.green,
            ),
          );
          // Reload match details to update request status
          _loadMatchDetails();
        } else {
          _showError(AppStrings.failedToSendRequest);
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
        title: Text(
          'Match Details'.tr,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.socaBlack,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.socaBlack),
      ),
      body: _isLoading
          ? AppLoader()
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _errorMessage!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadMatchDetails,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.socaYellow,
                        ),
                        child: Text(
                          'Retry'.tr,
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
                  ? Center(child: Text('Match not found'.tr))
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Match Info Card
                                _buildMatchInfoCard(),

                                SizedBox(height: 16),

                                // Host Info Card
                                _buildHostInfoCard(),

                                SizedBox(height: 16),

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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Match Information'.tr,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: AppColors.socaBlack,
            ),
          ),

          SizedBox(height: 16),

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

          SizedBox(height: 16),
          Divider(height: 1),
          SizedBox(height: 16),

          // Details
          _buildDetailRow(Icons.stadium, AppStrings.venue, _match!.venueName ?? AppStrings.na),
          SizedBox(height: 12),
          _buildDetailRow(
              Icons.people, AppStrings.maxPlayers, '${_match!.maxPlayer} players'),
          SizedBox(height: 12),
          _buildDetailRow(Icons.calendar_today, AppStrings.date, _formatDate()),
          SizedBox(height: 12),
          _buildDetailRow(Icons.access_time, AppStrings.time, _formatTime()),

          // Match Note
          if (_match!.matchNote != null && _match!.matchNote!.isNotEmpty) ...[
            SizedBox(height: 16),
            Divider(height: 1),
            SizedBox(height: 16),
            Text(
              'Match Note'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
            ),
            SizedBox(height: 8),
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
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Host Avatar
            _buildHostAvatar(),
            SizedBox(width: 12),

            // Host Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hosted by'.tr,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _match!.createdByName ?? AppStrings.host,
                    style: TextStyle(
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
            Icon(
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: AppColors.socaYellow,
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  _match!.locationName!,
                  style: TextStyle(
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
            icon: Icon(
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
      buttonText = AppStrings.viewRequestsUpper;
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
        buttonText = AppStrings.acceptedUpper;
        buttonColor = Colors.green;
        textColor = Colors.white;
        isEnabled = false;
        onPressed = null;
      } else if (requestStatus == 'declined') {
        buttonText = AppStrings.declinedUpper;
        buttonColor = Colors.red;
        textColor = Colors.white;
        isEnabled = false;
        onPressed = null;
      } else if (requestStatus == 'pending') {
        buttonText = AppStrings.requestPendingUpper;
        buttonColor = Colors.grey;
        textColor = Colors.white;
        isEnabled = false;
        onPressed = null;
      } else {
        buttonText = AppStrings.requestToJoin.toUpperCase();
        buttonColor = AppColors.socaBlack;
        textColor = AppColors.socaYellow;
        isEnabled = !_isRequesting;
        onPressed = _requestToJoin;
      }
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            disabledBackgroundColor: buttonColor.withOpacity(0.6),
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _isRequesting
              ? AppLoader(size: 24, centered: false)
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
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.socaGrey,
      ),
      child: ClipOval(
        child: url.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Icon(
                  Icons.person,
                  color: AppColors.socaBlack,
                  size: 28,
                ),
              )
            : Icon(Icons.person, color: AppColors.socaBlack, size: 28),
      ),
    );
  }

  Widget _buildBadge(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.socaYellow.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.socaBlack),
          SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
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
        SizedBox(width: 12),
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
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
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
