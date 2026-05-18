import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
            ElevatedButton(
              onPressed: _refresh,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                foregroundColor: AppColors.socaYellow,
              ),
              child: Text('Retry'.tr,
                  style: TextStyle(
                      fontFamily: 'Poppins', color: AppColors.socaBlack)),
            ),
          ],
        ),
      );
    }

    if (_endorsements.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              color: AppColors.socaBlack,
              child: Text(
                "Endorsements".tr,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.socaYellow,
                ),
              ),
            ),
            Text(
              "View your Endorsements received by other Players &amp; Coaches Choose to either Publish or Reject the Endorsements received by you."
                  .tr,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.socaBlack),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                'No endorsements yet.'.tr,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      color: AppColors.socaYellow,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            color: AppColors.socaBlack,
            child: Text(
              "Endorsements".tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.socaYellow,
              ),
            ),
          ),
          Text(
            "View your Endorsements received by other Players &amp; Coaches Choose to either Publish or Reject the Endorsements received by you."
                .tr,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.socaBlack),
          ),
          SizedBox(
            height: 16,
          ),
          ListView.separated(
            padding: EdgeInsets.all(16),
            itemCount: _endorsements.length + (_hasMore ? 1 : 0),
            separatorBuilder: (_, __) => SizedBox(height: 12),
            itemBuilder: (ctx, i) {
              if (i == _endorsements.length) {
                _loadMore();
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: AppLoader(),
                );
              }
              return _EndorsementCard(
                raw: _endorsements[i],
                isPublishable: widget.isOwnProfile,
                onPublish: () => _respond(_endorsements[i], 'publish'),
                onReject: () => _respond(_endorsements[i], 'reject'),
              );
            },
          ),
        ],
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
    if (user['isPlayer'] == true) return 'Player';
    if (user['isCoach'] == true) return 'Coach';
    if (user['isAdmin'] == true) return 'Manager';
    if (user['isFan'] == true) return 'Fan';
    return '';
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Endorser header ─────────────────────────────────────────
          Row(
            children: [
              _Avatar(imageUrl: imageUrl),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.isEmpty ? 'Unknown' : name,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    if (role.isNotEmpty)
                      Text(
                        role,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: AppColors.socaGrey,
                        ),
                      ),
                    if (academyName != null && academyName.isNotEmpty)
                      Text(
                        academyName,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: AppColors.socaGrey,
                        ),
                      ),
                  ],
                ),
              ),
              if (publishedOn.isNotEmpty)
                Text(
                  publishedOn,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    color: AppColors.socaGrey,
                  ),
                ),
            ],
          ),

          // ── Review text ─────────────────────────────────────────────
          if (reviewText != null && reviewText.isNotEmpty) ...[
            SizedBox(height: 12),
            Text(
              reviewText,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: AppColors.socaBlack,
                height: 1.5,
              ),
            ),
          ],

          // ── Publish / Reject buttons (own profile, pending) ─────────
          if (isPublishable && isPending) ...[
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReject,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: BorderSide(color: AppColors.error),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: Text(
                      'Reject'.tr,
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPublish,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socaBlack,
                      foregroundColor: AppColors.socaYellow,
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: Text(
                      'Publish'.tr,
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
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

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: 22,
        backgroundColor: Colors.grey.shade200,
        backgroundImage: NetworkImage(imageUrl!),
        onBackgroundImageError: (_, __) {},
      );
    }
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.grey.shade200,
      child: Icon(Icons.person, color: AppColors.socaGrey, size: 24),
    );
  }
}
