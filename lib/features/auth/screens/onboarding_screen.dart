import 'dart:async';
import 'package:socaloca/core/constants/app_strings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';

/// OnboardingOneFragment–OnboardingFourFragment equivalent.
/// Shown once to first-time users. On completion marks onboarding done
/// and sends the user to RoleChoiceScreen.
class OnboardingScreen extends ConsumerStatefulWidget {
  OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  Timer? _autoTimer;
  int _currentPage = 0;

  // Image slider pages matching Android onboarding
  static final _pages = [
    _OnboardingPage(
      imagePath: 'assets/images/sp_one.jpg',
      title: 'Welcome to SocaLoca',
      subtitle: 'Your football journey starts here',
    ),
    _OnboardingPage(
      imagePath: 'assets/images/sp_two.jpg',
      title: 'Connect with Players',
      subtitle: 'Find teammates and build your squad',
    ),
    _OnboardingPage(
      imagePath: 'assets/images/sp_three.jpg',
      title: 'Organize Matches',
      subtitle: 'Schedule games and track your performance',
    ),
    _OnboardingPage(
      imagePath: 'assets/images/sp_four.jpg',
      title: 'Join Tournaments',
      subtitle: 'Compete in leagues and cups',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoAdvance();
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoAdvance() {
    // Auto-scroll every 3 seconds (matching Android interval)
    final _autoTimer = Timer.periodic(Duration(seconds: 3), (_) {
      if (_currentPage < _pages.length - 1) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        // On last page, auto-navigate after 2.5 seconds
        Future.delayed(Duration(milliseconds: 2500), () {
          if (mounted) _complete();
        });
      }
    });
  }

  Future<void> _complete() async {
    await StorageService.setOnboardingComplete();
    if (mounted) context.go(AppRoutes.roleChoice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1C), // new_black color
      body: Stack(
        children: [
          // ── Image Slider ──────────────────────────────────────────
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (i) {
              setState(() => _currentPage = i);
              // Reset auto-advance timer on manual swipe
              _autoTimer?.cancel();
              _startAutoAdvance();
            },
            itemBuilder: (_, i) => _OnboardingSlide(page: _pages[i]),
          ),

          // ── Skip Button ───────────────────────────────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: TextButton(
              onPressed: _complete,
              style: TextButton.styleFrom(
                backgroundColor: Colors.black.withValues(alpha: 0.5),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Skip'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),

          // ── Page Indicators ───────────────────────────────────────
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (i) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == i ? 32 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? AppColors.primary
                        : Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage {
  _OnboardingPage({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  final String imagePath;
  final String title;
  final String subtitle;
}

class _OnboardingSlide extends StatelessWidget {
  _OnboardingSlide({required this.page});

  final _OnboardingPage page;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Image.asset(
          page.imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Fallback gradient if image not found
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.8),
                    Color(0xFF1C1C1C),
                  ],
                ),
              ),
            );
          },
        ),

        // Gradient Overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.7),
              ],
            ),
          ),
        ),

        // Text Content
        Positioned(
          bottom: 150,
          left: 24,
          right: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                page.title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 12),
              Text(
                page.subtitle,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
