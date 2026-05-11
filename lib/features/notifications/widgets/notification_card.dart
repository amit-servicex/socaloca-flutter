import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/api_constants.dart';
import '../data/models/notification_model.dart';
import '../utils/notification_navigation_handler.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = notification.seen
        ? const Color(0xFFF5F5F5)
        : Colors.white;

    return InkWell(
      onTap: () => _handleCardTap(context),
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatar(context),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Linkify(
                    text: notification.body,
                    onOpen: (link) async {
                      final uri = Uri.parse(link.url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    },
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                    linkStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(notification.generatedOn),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleAvatarTap(context),
      child: ClipOval(
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    final imageUrl = notification.imageUrl;
    
    if (imageUrl == null || imageUrl.isEmpty || imageUrl.startsWith('file:///')) {
      return _buildDefaultImage();
    }

    final fullImageUrl = ApiConstants.getImageUrl(imageUrl);
    
    if (fullImageUrl.isEmpty) {
      return _buildDefaultImage();
    }

    return CachedNetworkImage(
      imageUrl: fullImageUrl,
      width: 60,
      height: 60,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        width: 60,
        height: 60,
        color: Colors.grey[200],
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      errorWidget: (context, url, error) => _buildDefaultImage(),
    );
  }

  Widget _buildDefaultImage() {
    return Container(
      width: 60,
      height: 60,
      color: Colors.grey[200],
      child: Image.asset(
        'assets/images/logo.png',
        width: 40,
        height: 40,
        fit: BoxFit.contain,
      ),
    );
  }

  String _formatTime(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return timeago.format(dateTime, locale: 'en_short');
  }

  void _handleCardTap(BuildContext context) {
    NotificationNavigationHandler.handleNotificationTap(
      context: context,
      notification: notification,
      isAvatarTap: false,
    );
  }

  void _handleAvatarTap(BuildContext context) {
    NotificationNavigationHandler.handleNotificationTap(
      context: context,
      notification: notification,
      isAvatarTap: true,
    );
  }
}
