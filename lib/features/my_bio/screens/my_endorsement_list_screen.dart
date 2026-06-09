import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/theme/app_colors.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Paginated endorsement list screen — mirrors Android EndorsementListFragment.
/// When [isOwnProfile] = true, shows ALL endorsements (pending + accepted)
/// and allows publish / reject actions.
///
/// Stores raw JSON maps to access endId (not present in EndorsementModel).
class MyEndorsementListScreen extends ConsumerStatefulWidget {
  final String userId;
  final bool isOwnProfile;

  MyEndorsementListScreen({
    super.key,
    required this.userId,
    this.isOwnProfile = false,
  });

  @override
  ConsumerState<MyEndorsementListScreen> createState() =>
      _MyEndorsementListScreenState();
}

class _MyEndorsementListScreenState
    extends ConsumerState<MyEndorsementListScreen> {
  final List<Map<String, dynamic>> _endorsements = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _start = 0;
  static int _limit = 5;
  String? _error;

  // endType: 0 = all (own), 2 = accepted (other)
  int get _endType => widget.isOwnProfile ? 0 : 2;

  @override
  void initState() {
    super.initState();
    _loadMore();
  }

  Future<void> _loadMore() async {
    if (_isLoading || !_hasMore) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.getEndorses,
        body: {
          'userId': widget.userId,
          'endType': _endType,
          'start': _start,
          'limit': _limit,
        },
      );

      if (response['response']?['status'] == 1) {
        final raw = response['response']['ends'] as List? ?? [];
        final items = raw.cast<Map<String, dynamic>>();
        setState(() {
          _endorsements.addAll(items);
          _start += items.length;
          if (items.length < _limit) _hasMore = false;
        });
      } else {
        setState(() => _hasMore = false);
      }
    } catch (e) {
      setState(() => _error = e.toString());
    }
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _refresh() async {
    setState(() {
      _endorsements.clear();
      _start = 0;
      _hasMore = true;
      _error = null;
    });
    await _loadMore();
  }

  Future<void> _respond(Map<String, dynamic> raw, String respondType) async {
    final endId = raw['endId']?.toString() ?? '';
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.repondEndorse,
        body: {
          'userId': widget.userId,
          'endId': endId,
          'publish': respondType,
        },
      );
      if (response['response']?['status'] == 1) {
        await _refresh();
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_endorsements.isEmpty && _isLoading) {
      return AppLoader();
    }

    if (_endorsements.isEmpty && _error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColors.error),
            SizedBox(height: 16),
            Text(_error!,
                style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
            SizedBox(height: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _refresh,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaBlack,
                  foregroundColor: AppColors.socaYellow,
                ),
                child: Text(AppStrings.retry,
                    style: TextStyle(
                        fontFamily: 'Poppins', color: AppColors.socaBlack)),
              ),
            ),
          ],
        ),
      );
    }

    if (_endorsements.isEmpty) {
      return RefreshIndicator(
        onRefresh: _refresh,
        color: AppColors.socaYellow,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.socaBlack,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    AppStrings.endorsements.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaYellow,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  AppStrings.endorsementsDescription,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: AppColors.socaBlack.withOpacity(0.8)),
                ),
                SizedBox(height: 32),
                Center(
                  child: Text(
                    AppStrings.noEndorsementsYet,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.socaBlack.withOpacity(0.6)),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      color: AppColors.socaYellow,
      child: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: _endorsements.length + (_hasMore ? 2 : 1),
        separatorBuilder: (_, i) => SizedBox(height: 12),
        itemBuilder: (ctx, i) {
          if (i == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.socaBlack,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    AppStrings.endorsements.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaYellow,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  AppStrings.endorsementsDescription,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: AppColors.socaBlack.withOpacity(0.8)),
                ),
                SizedBox(height: 8),
              ],
            );
          }
          final index = i - 1;
          if (index == _endorsements.length) {
            _loadMore();
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: AppLoader(),
            );
          }
          return _EndorsementCard(
            raw: _endorsements[index],
            isPublishable: widget.isOwnProfile,
            onPublish: () => _respond(_endorsements[index], 'publish'),
            onReject: () => _respond(_endorsements[index], 'reject'),
          );
        },
      ),
    );
  }
}

// ── Card widget ───────────────────────────────────────────────────────────────

class _EndorsementCard extends StatelessWidget {
  final Map<String, dynamic> raw;
  final bool isPublishable;
  final VoidCallback onPublish;
  final VoidCallback onReject;

  _EndorsementCard({
    required this.raw,
    required this.isPublishable,
    required this.onPublish,
    required this.onReject,
  });

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return '';
    final ts = (timestamp as num).toInt();
    final date = DateTime.fromMillisecondsSinceEpoch(ts * 1000);
    return DateFormat('dd.MM.yyyy').format(date);
  }

  String _role(Map<String, dynamic>? user) {
    if (user == null) return '';
    List<String> roles = [];
    if (user['isPlayer'] == true) roles.add('Player');
    if (user['isCoach'] == true) roles.add('Coach');
    if (user['isAdmin'] == true) roles.add('Manager');
    if (user['isFan'] == true) roles.add('Fan');
    return roles.join('/');
  }

  @override
  Widget build(BuildContext context) {
    final user = raw['userDetails'] as Map<String, dynamic>?;
    final academy = raw['academy'] as Map<String, dynamic>?;

    final firstName = user?['firstName'] as String? ?? '';
    final lastName = user?['lastName'] as String? ?? '';
    final name = '$firstName $lastName'.trim();
    final imageUrl = user?['imageUrl'] as String?;
    final role = _role(user);
    final academyName = academy?['name'] as String?;
    final reviewText = raw['comment'] as String?;
    final publishedOn = _formatDate(raw['addedOn']);
    final published = (raw['published'] as num?)?.toInt() ?? 0;
    final isPending = published == 0;

    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.socaGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              publishedOn,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: AppColors.socaBlack.withOpacity(0.7),
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Avatar(imageUrl: imageUrl),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (reviewText != null && reviewText.isNotEmpty) ...[
                      Text(
                        reviewText,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                      ),
                      SizedBox(height: 6),
                    ],
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: AppColors.socaBlack.withOpacity(0.8),
                        ),
                        children: [
                          TextSpan(
                            text: name.isEmpty ? AppStrings.unknown : name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.socaBlack,
                            ),
                          ),
                          if (role.isNotEmpty)
                            TextSpan(
                              text: ' | $role',
                            ),
                        ],
                      ),
                    ),
                    if (academyName != null && academyName.isNotEmpty) ...[
                      SizedBox(height: 4),
                      Text(
                        academyName.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: AppColors.socaBlack.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          // ── Publish / Reject buttons (own profile, pending) ─────────
          if (isPublishable && isPending) ...[
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReject,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: BorderSide(color: AppColors.error),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      AppStrings.reject,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPublish,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socaBlack,
                      foregroundColor: AppColors.socaYellow,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      AppStrings.publish,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? imageUrl;

  _Avatar({this.imageUrl});

  bool _isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    if (url.startsWith('file:///')) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: ClipOval(
        child: _isValidImageUrl(imageUrl)
            ? CachedNetworkImage(
                imageUrl: ApiConstants.getImageUrl(imageUrl!),
                fit: BoxFit.cover,
                placeholder: (context, url) => AppLoader(),
                errorWidget: (context, url, error) => Icon(
                  Icons.person,
                  color: AppColors.socaBlack.withOpacity(0.2),
                  size: 32,
                ),
              )
            : Icon(
                Icons.person,
                color: AppColors.socaBlack.withOpacity(0.2),
                size: 32,
              ),
      ),
    );
  }
}
