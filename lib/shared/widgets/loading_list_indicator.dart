import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'app_loader.dart';

/// Bottom-of-list loading spinner for paginated lists.
class LoadingListIndicator extends StatelessWidget {
  const LoadingListIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: AppLoader(size: 48),
    );
  }
}

/// Shimmer placeholder card for list loading states.
class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key, this.height = 80});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

/// Column of shimmer cards for initial loading state.
class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key, this.itemCount = 5, this.itemHeight = 80});

  final int itemCount;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) => ShimmerCard(height: itemHeight),
    );
  }
}
