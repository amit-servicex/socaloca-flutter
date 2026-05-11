import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Live match banner matching Android CommonHomeActivity LiveMatchBox.
/// Always visible at the bottom of the home screen body.
class LiveMatchBanner extends StatefulWidget {
  const LiveMatchBanner({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<LiveMatchBanner> createState() => _LiveMatchBannerState();
}

class _LiveMatchBannerState extends State<LiveMatchBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 1.0, end: 0.2).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 3),
      decoration: BoxDecoration(
        color: AppColors.socaGrey,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Row(
          children: [
            // Animated live indicator — pulsing red dot + "LIVE" text
            FadeTransition(
              opacity: _opacity,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              'LIVE',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Colors.red,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Live Match Update',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: AppColors.socaBlack,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: widget.onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.socaBlack,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'VIEW',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: AppColors.socaYellow,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
