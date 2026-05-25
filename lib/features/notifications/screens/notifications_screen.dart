import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/core/theme/app_colors.dart';
import '../providers/notifications_provider.dart';
import '../widgets/notification_card.dart';
import '../widgets/notification_shimmer.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.microtask(
        () => ref.read(notificationsProvider.notifier).loadNotifications());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(notificationsProvider.notifier).loadMoreNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationsProvider);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Notifications'.tr),
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.black,
      //   elevation: 1,
      // ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(NotificationsState state) {
    if (state.isLoading) {
      return NotificationShimmer();
    }

    if (state.error != null && state.notifications.isEmpty) {
      return _buildErrorState(state.error!);
    }

    if (state.notifications.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(notificationsProvider.notifier).refresh();
      },
      child: ListView.separated(
        controller: _scrollController,
        itemCount: state.notifications.length + (state.isLoadingMore ? 1 : 0),
        separatorBuilder: (context, index) => Divider(height: 1),
        itemBuilder: (context, index) {
          if (index == state.notifications.length) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: AppLoader(),
            );
          }

          final notification = state.notifications[index];
          return NotificationCard(notification: notification);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 80,
            color: AppColors.socaBlack,
          ),
          SizedBox(height: 16),
          Text(
            'No notifications yet'.tr,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.socaBlack,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'When you get notifications, they\'ll show up here'.tr,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.socaBlack,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red[300],
          ),
          SizedBox(height: 16),
          Text(
            'Failed to load notifications'.tr,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              error,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ref.read(notificationsProvider.notifier).refresh();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text('Retry'.tr),
          ),
        ],
      ),
    );
  }
}
