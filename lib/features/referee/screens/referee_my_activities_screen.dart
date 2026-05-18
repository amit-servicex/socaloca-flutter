import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/referee_bio_model.dart';
import '../providers/referee_providers.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class RefereeMyActivitiesScreen extends ConsumerStatefulWidget {
  RefereeMyActivitiesScreen({super.key});

  @override
  ConsumerState<RefereeMyActivitiesScreen> createState() =>
      _RefereeMyActivitiesScreenState();
}

class _RefereeMyActivitiesScreenState
    extends ConsumerState<RefereeMyActivitiesScreen> {
  final List<RefereeActivityModel> _activities = [];
  bool _isLoading = true;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  String? _error;
  int _start = 0;
  static int _limit = 10;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _load();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore) {
      _loadMore();
    }
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _start = 0;
      _activities.clear();
    });
    try {
      final repo = ref.read(refereeRepositoryProvider);
      final list = await repo.getActivities(start: 0);
      if (!mounted) return;
      setState(() {
        _activities.addAll(list);
        _start = list.length;
        _hasMore = list.length >= _limit;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !_hasMore) return;
    setState(() => _isLoadingMore = true);
    try {
      final repo = ref.read(refereeRepositoryProvider);
      final list = await repo.getActivities(start: _start);
      if (!mounted) return;
      setState(() {
        _activities.addAll(list);
        _start += list.length;
        _hasMore = list.length >= _limit;
        _isLoadingMore = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoadingMore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.socaBlack),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'My Activities'.tr,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.socaBlack,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return AppLoader();
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColors.error),
            SizedBox(height: 12),
            Text(_error!,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Poppins', fontSize: 13)),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _load,
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaBlack,
                  foregroundColor: AppColors.socaYellow),
              child: Text('Retry'.tr, style: TextStyle(fontFamily: 'Poppins')),
            ),
          ],
        ),
      );
    }

    if (_activities.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_outlined, size: 60, color: AppColors.socaGrey),
            SizedBox(height: 16),
            Text('No activities yet'.tr,
                style: TextStyle(
                    fontFamily: 'Poppins', fontSize: 14, color: Colors.grey)),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.socaYellow,
      onRefresh: _load,
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.all(12),
        itemCount: _activities.length + (_isLoadingMore ? 1 : 0),
        itemBuilder: (ctx, i) {
          if (i == _activities.length) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: AppLoader(),
            );
          }
          return _ActivityCard(activity: _activities[i]);
        },
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  _ActivityCard({required this.activity});
  final RefereeActivityModel activity;

  @override
  Widget build(BuildContext context) {
    final hasScore = activity.teamAScore != null && activity.teamBScore != null;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tournament + round
          Text(
            activity.tournamentName ?? '',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: AppColors.socaBlack,
            ),
          ),
          if (activity.roundName?.isNotEmpty == true) ...[
            SizedBox(height: 2),
            Text(
              activity.roundName!,
              style: TextStyle(
                  fontFamily: 'Lato', fontSize: 12, color: Colors.grey),
            ),
          ],
          SizedBox(height: 8),

          // Teams + score
          Row(
            children: [
              Expanded(
                child: Text(
                  activity.teamA ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: AppColors.socaBlack),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.socaBlack,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  hasScore
                      ? '${activity.teamAScore} - ${activity.teamBScore}'
                      : 'vs',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.socaYellow),
                ),
              ),
              Expanded(
                child: Text(
                  activity.teamB ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: AppColors.socaBlack),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),

          // Date + cards
          Row(
            children: [
              if (activity.matchDate?.isNotEmpty == true) ...[
                Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                SizedBox(width: 4),
                Text(activity.matchDate!,
                    style: TextStyle(
                        fontFamily: 'Lato', fontSize: 12, color: Colors.grey)),
                SizedBox(width: 14),
              ],
              Text(
                '🟡 ${activity.yellowCardsGiven ?? 0}',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(width: 8),
              Text(
                '🔴 ${activity.redCardsGiven ?? 0}',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
