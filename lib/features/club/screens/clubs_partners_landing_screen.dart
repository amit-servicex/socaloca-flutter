import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'clubs_screen.dart';
import 'partners_screen.dart';

/// Top-level landing matching Android CommonClubsPartnersLandingFragment:
/// TabLayout (fixed, 2 tabs) → Clubs | Partners
class ClubsPartnersLandingScreen extends StatefulWidget {
  const ClubsPartnersLandingScreen({super.key});

  @override
  State<ClubsPartnersLandingScreen> createState() =>
      _ClubsPartnersLandingScreenState();
}

class _ClubsPartnersLandingScreenState
    extends State<ClubsPartnersLandingScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Clubs & Partners',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.socaBlack,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.socaBlack,
          indicatorWeight: 3,
          labelColor: AppColors.socaBlack,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          tabs: const [
            Tab(text: 'Clubs'),
            Tab(text: 'Partners'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ClubsScreen(),
          PartnersScreen(),
        ],
      ),
    );
  }
}
