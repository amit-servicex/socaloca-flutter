import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../data/repositories/pickup_match_repository.dart';

/// Model for pickup match request
class PickupMatchRequest {
  final String userId;
  final String userName;
  final String? userImage;
  final String status; // 'pending', 'accepted', 'declined'

  PickupMatchRequest({
    required this.userId,
    required this.userName,
    this.userImage,
    required this.status,
  });

  factory PickupMatchRequest.fromJson(Map<String, dynamic> json) {
    return PickupMatchRequest(
      userId: json['userId'] ?? json['_id'] ?? '',
      userName: json['userName'] ?? json['name'] ?? 'User',
      userImage: json['userImage'] ?? json['image'],
      status: json['status'] ?? 'pending',
    );
  }
}

/// Pickup Match Requests Screen
/// Shows list of users who requested to join the match (host only)
class PickupMatchRequestsScreen extends ConsumerStatefulWidget {
  const PickupMatchRequestsScreen({
    super.key,
    required this.matchId,
  });

  final String matchId;

  @override
  ConsumerState<PickupMatchRequestsScreen> createState() =>
      _PickupMatchRequestsScreenState();
}

class _PickupMatchRequestsScreenState
    extends ConsumerState<PickupMatchRequestsScreen> {
  List<PickupMatchRequest> _requests = [];
  bool _isLoading = true;
  String? _errorMessage;
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Pending', 'Accepted', 'Declined'];

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
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

      final response = await ApiClient.instance.post(
        ApiConstants.pickupMatchReqList,
        body: {
          'userId': user.id,
          'matchId': widget.matchId,
          'start': 0,
          'limit': 100,
        },
      );

      final data = response['response'] as Map<String, dynamic>?;
      if (data != null && data['status'] == 1) {
        final requestsList = data['requests'] as List? ?? [];
        final parsed = requestsList
            .map((r) => PickupMatchRequest.fromJson(r as Map<String, dynamic>))
            .toList();

        if (mounted) {
          setState(() {
            _requests = parsed;
            _isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _requests = [];
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      print('❌ Error loading requests: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Error loading requests';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleRequest(
      PickupMatchRequest request, String status) async {
    try {
      final user = ref.read(currentUserProvider);
      if (user == null) {
        _showError('User not found');
        return;
      }

      // Optimistic update
      setState(() {
        final index = _requests.indexWhere((r) => r.userId == request.userId);
        if (index != -1) {
          _requests[index] = PickupMatchRequest(
            userId: request.userId,
            userName: request.userName,
            userImage: request.userImage,
            status: status,
          );
        }
      });

      final success = await ref
          .read(pickupMatchRepositoryProvider)
          .acceptDeclineRequest(
            userId: user.id,
            matchId: widget.matchId,
            requestedUserId: request.userId,
            status: status,
          );

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Request ${status == 'accepted' ? 'accepted' : 'declined'}'),
              backgroundColor: status == 'accepted' ? Colors.green : Colors.red,
            ),
          );
        } else {
          // Revert optimistic update on failure
          _loadRequests();
          _showError('Failed to update request. Please try again.');
        }
      }
    } catch (e) {
      // Revert optimistic update on error
      _loadRequests();
      _showError('Error: $e');
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

  List<PickupMatchRequest> get _filteredRequests {
    if (_selectedFilter == 'All') return _requests;
    return _requests
        .where((r) => r.status.toLowerCase() == _selectedFilter.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredRequests = _filteredRequests;

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        title: const Text(
          'Match Requests',
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
      body: Column(
        children: [
          // Filter Chips
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters.map((filter) {
                  final isSelected = _selectedFilter == filter;
                  final count = filter == 'All'
                      ? _requests.length
                      : _requests
                          .where((r) =>
                              r.status.toLowerCase() == filter.toLowerCase())
                          .length;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text('$filter ($count)'),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _selectedFilter = filter);
                      },
                      backgroundColor: Colors.grey.shade200,
                      selectedColor: AppColors.socaYellow,
                      labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: isSelected
                            ? AppColors.socaBlack
                            : AppColors.socaBlack.withOpacity(0.7),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Requests List
          Expanded(
            child: _isLoading
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
                              onPressed: _loadRequests,
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
                    : filteredRequests.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inbox,
                                  size: 64,
                                  color: AppColors.socaBlack.withOpacity(0.3),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  _selectedFilter == 'All'
                                      ? 'No requests yet'
                                      : 'No $_selectedFilter requests',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: AppColors.socaBlack.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: _loadRequests,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: filteredRequests.length,
                              itemBuilder: (context, index) {
                                final request = filteredRequests[index];
                                return _RequestListItem(
                                  request: request,
                                  onAccept: () =>
                                      _handleRequest(request, 'accepted'),
                                  onDecline: () =>
                                      _handleRequest(request, 'declined'),
                                );
                              },
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}

/// Request List Item Widget
class _RequestListItem extends StatelessWidget {
  const _RequestListItem({
    required this.request,
    required this.onAccept,
    required this.onDecline,
  });

  final PickupMatchRequest request;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
          // User Avatar
          _buildAvatar(),
          const SizedBox(width: 12),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.userName,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: AppColors.socaBlack,
                  ),
                ),
                const SizedBox(height: 4),
                _buildStatusBadge(),
              ],
            ),
          ),

          // Action Buttons
          if (request.status == 'pending') ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: onDecline,
              icon: const Icon(Icons.close, color: Colors.red),
              style: IconButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.1),
                padding: const EdgeInsets.all(8),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onAccept,
              icon: const Icon(Icons.check, color: Colors.green),
              style: IconButton.styleFrom(
                backgroundColor: Colors.green.withOpacity(0.1),
                padding: const EdgeInsets.all(8),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final url = ApiConstants.getImageUrl(request.userImage);
    return Container(
      width: 48,
      height: 48,
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
                  size: 24,
                ),
              )
            : const Icon(Icons.person, color: AppColors.socaBlack, size: 24),
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color color;
    String text;

    switch (request.status.toLowerCase()) {
      case 'accepted':
        color = Colors.green;
        text = 'Accepted';
        break;
      case 'declined':
        color = Colors.red;
        text = 'Declined';
        break;
      default:
        color = Colors.orange;
        text = 'Pending';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
