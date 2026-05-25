import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../data/skill_rater_model.dart';
import '../widgets/skill_rater_tile.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Paginated list of raters for one role (coaches / players / managers / fans).
/// Mirrors Android SkillViewAllFragment.
class SkillDetailViewAllScreen extends StatefulWidget {
  final String playerId;
  final String skillName;
  final String skillShort;
  final String role;
  final String roleLabel;

  SkillDetailViewAllScreen({
    super.key,
    required this.playerId,
    required this.skillName,
    required this.skillShort,
    required this.role,
    required this.roleLabel,
  });

  @override
  State<SkillDetailViewAllScreen> createState() =>
      _SkillDetailViewAllScreenState();
}

class _SkillDetailViewAllScreenState extends State<SkillDetailViewAllScreen> {
  static int _limit = 20;

  final List<SkillRaterModel> _raters = [];
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  bool _hasMore = true;
  String? _error;
  int _start = 0;

  @override
  void initState() {
    super.initState();
    _fetchPage();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isLoading &&
        _hasMore) {
      _fetchPage();
    }
  }

  Future<void> _fetchPage() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final userId = StorageService.userId ?? '';
      final response = await ApiClient.instance.post(
        ApiConstants.getEndorseRoleUsers,
        body: {
          'userId': userId,
          'playerId': widget.playerId,
          'skillShort': widget.skillShort,
          'role': widget.role,
          'start': _start,
          'limit': _limit,
        },
      );
      final raw = response['response'];
      if ((raw?['status'] as num?)?.toInt() == 1) {
        final list = (raw['endorses'] as List? ?? [])
            .map((e) => SkillRaterModel.fromJson(e as Map<String, dynamic>))
            .toList();
        setState(() {
          _raters.addAll(list);
          _start += list.length;
          _hasMore = list.length >= _limit;
        });
      } else {
        setState(() => _error = 'Failed to load');
      }
    } catch (e) {
      setState(() => _error = e.toString());
    }
    if (mounted) setState(() => _isLoading = false);
  }

  String get _emptyText {
    switch (widget.role) {
      case 'coach':
        return 'Coaches yet to endorse';
      case 'player':
        return 'Players yet to endorse';
      case 'admin':
        return 'Managers yet to endorse';
      case 'fan':
        return 'Fans yet to endorse';
      default:
        return 'No endorsements yet';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      // appBar: AppBar(
      //   backgroundColor: AppColors.socaBlack,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios_new,
      //         color: Color.fromARGB(255, 65, 141, 255), size: 20),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   title: Text(
      //     widget.roleLabel,
      //     style: TextStyle(
      //       fontFamily: 'Poppins',
      //       fontSize: 16,
      //       fontWeight: FontWeight.w600,
      //       color: AppColors.socaYellow,
      //     ),
      //   ),
      // ),

      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    // Initial load state
    if (_raters.isEmpty && _isLoading) {
      return AppLoader();
    }

    // Error on first load
    if (_raters.isEmpty && _error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColors.error),
            SizedBox(height: 12),
            Text(_error!,
                style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                _start = 0;
                _hasMore = true;
                _raters.clear();
                _fetchPage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                foregroundColor: AppColors.socaYellow,
              ),
              child: Text('Retry'.tr, style: TextStyle(fontFamily: 'Poppins')),
            ),
          ],
        ),
      );
    }

    // Empty state (loaded but nothing)
    if (_raters.isEmpty && !_isLoading) {
      return Center(
        child: Text(
          _emptyText,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(12),
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
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _raters.length + (_isLoading || _hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _raters.length) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: AppLoader(),
            );
          }
          return SkillRaterTile(
            rater: _raters[index],
            showPosition: widget.role == 'player',
            isLast: index == _raters.length - 1 && !_hasMore,
          );
        },
      ),
    );
  }
}
