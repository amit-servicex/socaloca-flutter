import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/features/players/screens/players_screen.dart';
import 'package:socaloca/features/settings/screens/legacy_contact_screen.dart';
import '../../features/live_match/screens/live_match_details_screen.dart';
import '../../features/live_match/screens/player_live_match_list_screen.dart';
import '../../features/academies/screens/academies_screen.dart';
import '../../features/academies/screens/academy_bio_screen.dart';
import '../storage/storage_service.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_landing_screen.dart';
import '../../features/auth/screens/new_login_screen.dart';
import '../../features/auth/screens/club_login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/otp_screen.dart';
import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/auth/screens/reset_password_screen.dart';
import '../../features/auth/screens/role_choice_screen.dart';
import '../../features/auth/screens/onboarding_screen.dart';
import '../../features/auth/screens/age_selection_screen.dart';
import '../../features/auth/screens/youth_consent_screen.dart';
import '../../features/auth/screens/child_consent_screen.dart';
import '../../features/auth/screens/pin_setup_screen.dart';
import '../../features/auth/screens/parental_settings_screen.dart';
import '../../features/auth/screens/social_age_selection_screen.dart';
import '../../features/auth/screens/create_profile_screen.dart';
import '../../features/auth/screens/location_picker_screen.dart';
import '../../features/tournaments/screens/tournaments_landing_screen.dart';
import '../../features/tournaments/screens/league/league_tournament_details_screen.dart';
import '../../features/tournaments/screens/cup/cup_tournament_details_screen.dart';
import '../../features/tournaments/screens/match_management/match_management_screen.dart';
import '../../features/tournaments/data/tournament_models.dart';
import '../../features/one_off_matches/screens/upcoming_matches_screen.dart';
import '../../features/one_off_matches/screens/recent_matches_screen.dart';
import '../../features/pickup_match/screens/host_pickup_match_screen.dart';
import '../../features/pickup_match/screens/pickup_match_details_screen.dart';
import '../../features/pickup_match/screens/pickup_match_requests_screen.dart';
import '../../features/club/screens/clubs_partners_landing_screen.dart';
import '../../features/club/screens/club_bio_screen.dart';
import '../../features/club/screens/fa_bio_screen.dart';
import '../../features/player_bio/screens/player_bio_screen.dart';
import '../../features/player_bio/screens/player_joined_teams_screen.dart';
import '../../features/player_bio/screens/player_pending_teams_screen.dart';
import '../../features/player_bio/screens/player_received_teams_screen.dart';
import '../../features/my_bio/screens/my_bio_screen.dart';
import '../../features/my_bio/screens/my_skill_ratings_screen.dart';
import '../../features/my_bio/screens/my_endorsement_list_screen.dart';
import '../../features/my_bio/screens/my_activities_form_screen.dart';
import '../../features/my_bio/screens/edit_profile_screen.dart';
import '../../features/my_bio/screens/create_post_screen.dart';
import '../../features/my_bio/screens/my_posts_screen.dart';
import '../../features/gallery/screens/gallery_screen.dart';
import '../../features/player_bio/data/models/player_bio_model.dart';
import '../../features/skill_detail/screens/skill_detail_screen.dart';
import '../../features/skill_detail/screens/skill_detail_view_all_screen.dart';
import '../../features/home/screens/main_shell_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/referee/screens/referee_home_screen.dart';
import '../../features/tournaments/screens/tournament_featured_screen.dart';
import '../../features/referee/screens/referee_tournament_screen.dart';
import '../../features/referee/screens/referee_my_requests_screen.dart';
import '../../features/referee/screens/referee_my_matches_screen.dart';
import '../../features/referee/screens/referee_live_matches_screen.dart';
import '../../features/referee/screens/referee_my_bio_screen.dart';
import '../../features/teams/screens/teams_screen_new.dart';
import '../../features/teams/screens/team_bio_screen.dart';
import '../../features/teams/screens/team_players_screen.dart';
import '../../features/club/screens/club_home_screen.dart';
import '../../features/club/screens/club_bio_admin_screen.dart';
import '../../features/club/screens/club_players_screen.dart';
import '../../features/club/screens/club_player_bio_screen.dart';
import '../../features/club/screens/club_gallery_screen.dart';
import '../../features/club/screens/club_trials_screen.dart';
import '../../features/settings/screens/change_password_screen.dart';
import '../../features/settings/screens/privacy_settings_screen.dart';
import '../../shared/providers/auth_provider.dart';
import 'app_routes.dart';

// Bridges Riverpod auth state into GoRouter's refreshListenable so the router
// re-evaluates redirects on auth changes without recreating the GoRouter instance.
class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(Ref ref) {
    ref.listen<AuthState>(authStateProvider, (_, __) => notifyListeners());
  }
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = _AuthRefreshNotifier(ref);
  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);

      final isSplash = state.matchedLocation == AppRoutes.splash;
      // Let splash handle its own navigation via Timer — never redirect away from it
      if (isSplash) return null;

      final isLoggedIn = authState.isAuthenticated;
      final isClubLogin = StorageService.isClubLogin;
      final isAuthRoute = state.matchedLocation.startsWith('/auth');
      final isClubRoute = state.matchedLocation.startsWith('/club');
      final isSettingsRoute = state.matchedLocation.startsWith('/settings');
      if (state.matchedLocation == AppRoutes.onboarding) {
        return AppRoutes.onboarding;
      }
      if (state.matchedLocation == AppRoutes.roleChoice) {
        return AppRoutes.roleChoice;
      }
      if (state.matchedLocation == AppRoutes.createProfile) {
        return AppRoutes.createProfile;
      }
      // Club admin session bypasses regular auth check for club + settings routes
      if (isClubLogin && (isClubRoute || isSettingsRoute)) return null;
      if (!isLoggedIn && !isAuthRoute && !isClubRoute) {
        return AppRoutes.loginLanding;
      }
      log("this is the ksdfhbgsdjfbgsdhfbg${state.matchedLocation}");
      // Allow certain auth routes even when logged in (user needs to complete onboarding)
      final allowedAuthRoutes = [
        AppRoutes.createProfile,
        AppRoutes.otp,
        AppRoutes.pinSetup,
        AppRoutes.parentalSettings,
        AppRoutes.youthConsent,
        AppRoutes.childConsent,
        AppRoutes.ageSelection,
        AppRoutes.signup,
        AppRoutes.login,
        AppRoutes.clubLogin,
      ];
      final currentPath = state.matchedLocation;
      if (isLoggedIn && isAuthRoute) {
        // Check if current path matches any allowed route
        final isAllowed =
            allowedAuthRoutes.any((route) => currentPath.startsWith(route));
        if (!isAllowed) {
          return AppRoutes.home;
        }
      }
      return null;
    },
    routes: [
      // ─── Splash ───────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.splash,
        builder: (ctx, state) => const SplashScreen(),
      ),

      // ─── Auth shell ───────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.loginLanding,
        builder: (ctx, state) => const LoginLandingScreen(),
        routes: [
          GoRoute(
            path: 'login',
            name: 'login',
            builder: (ctx, state) => const NewLoginScreen(),
          ),
          GoRoute(
            path: 'club-login',
            name: 'clubLogin',
            builder: (ctx, state) => const ClubLoginScreen(),
          ),
          GoRoute(
            path: 'signup',
            name: 'signup',
            builder: (ctx, state) => const SignupScreen(),
          ),
          GoRoute(
            path: 'otp',
            name: 'otp',
            builder: (ctx, state) {
              final extra = state.extra as Map<String, String>? ?? {};
              return OtpScreen(
                userId: extra['userId'] ?? '',
                type: extra['type'] ?? 'email',
              );
            },
          ),
          GoRoute(
            path: 'forgot-password',
            name: 'forgotPassword',
            builder: (ctx, state) {
              final isClub = state.extra == true;
              return ForgotPasswordScreen(isClubPath: isClub);
            },
          ),
          GoRoute(
            path: 'reset-password',
            name: 'resetPassword',
            builder: (ctx, state) {
              final isClub = state.extra == true;
              return ResetPasswordScreen(isClubPath: isClub);
            },
          ),
          GoRoute(
            path: 'role-choice',
            name: 'roleChoice',
            builder: (ctx, state) => const RoleChoiceScreen(),
          ),
          GoRoute(
            path: 'age-selection',
            name: 'ageSelection',
            builder: (ctx, state) => const AgeSelectionScreen(),
          ),
          GoRoute(
            path: 'youth-consent',
            name: 'youthConsent',
            builder: (ctx, state) => const YouthConsentScreen(),
          ),
          GoRoute(
            path: 'child-consent',
            name: 'childConsent',
            builder: (ctx, state) => const ChildConsentScreen(),
          ),
          GoRoute(
            path: 'pin-setup',
            name: 'pinSetup',
            builder: (ctx, state) {
              final consentId = state.uri.queryParameters['consentId'] ?? '';
              return PinSetupScreen(consentId: consentId);
            },
          ),
          GoRoute(
            path: 'parental-settings',
            name: 'parentalSettings',
            builder: (ctx, state) {
              final consentId = state.uri.queryParameters['consentId'] ?? '';
              final pin = state.uri.queryParameters['pin'] ?? '';
              return ParentalSettingsScreen(
                consentId: consentId,
                pin: pin,
              );
            },
          ),
          GoRoute(
            path: 'social-age',
            name: 'socialAge',
            builder: (ctx, state) => const SocialAgeSelectionScreen(),
          ),
          GoRoute(
            path: 'create-profile',
            name: 'createProfile',
            builder: (ctx, state) => const CreateProfileScreen(),
          ),
        ],
      ),

      // ─── Onboarding ───────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (ctx, state) => const OnboardingScreen(),
      ),

      // ─── Location Picker ──────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.locationPicker,
        name: 'locationPicker',
        builder: (ctx, state) => const LocationPickerScreen(),
      ),

      // ─── Main app (shell with bottom nav) ────────────────────────────
      ShellRoute(
        builder: (context, state, child) => MainShellScreen(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            builder: (ctx, state) =>

                // Scaffold(
                //   body: Center(child: Text('Home - Coming Soon')),
                // ),
                const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.teams,
            name: 'teams',
            builder: (ctx, state) => const TeamsScreenNew(),
          ),
          GoRoute(
            path: AppRoutes.tournaments,
            name: 'tournaments',
            builder: (ctx, state) =>
                // Scaffold(
                //   body: Center(child: Text('tournaments - Coming Soon')),
                // ),
                const TournamentsLandingScreen(),
          ),
          GoRoute(
            path: AppRoutes.clubsPartners,
            name: 'clubsPartners',
            builder: (ctx, state) => Scaffold(
              body: Center(child: Text('Players - Coming Soon')),
            ),
            // const ClubsPartnersLandingScreen(),
          ),
          GoRoute(
            path: AppRoutes.players,
            name: 'players',
            builder: (ctx, state) => Scaffold(
              body: Center(child: Text('Players - Coming Soon')),
            ),
            // const PlayersScreen(),
          ),
          GoRoute(
            path: AppRoutes.trials,
            name: 'trials',
            builder: (ctx, state) => const Scaffold(
              body: Center(child: Text('Trials - Coming Soon')),
            ),
          ),
          GoRoute(
            path: AppRoutes.academies,
            name: 'academies',
            builder: (ctx, state) => Scaffold(
              body: Center(child: Text('academies - Coming Soon')),
            ),
            // const AcademiesScreen(),
          ),

          // ─── Academy Bio (detail screen outside shell) ────────────────────
          GoRoute(
            path: AppRoutes.academyBio,
            name: 'academyBio',
            builder: (ctx, state) {
              final academyId = state.pathParameters['academyId']!;
              return AcademyBioScreen(academyId: academyId);
            },
          ),

          GoRoute(
            path: AppRoutes.matches,
            name: 'matches',
            builder: (ctx, state) => const SizedBox(),
          ),
          GoRoute(
            path: AppRoutes.notifications,
            name: 'notifications',
            builder: (ctx, state) => Scaffold(
              body: Center(child: Text('Notifications - Coming Soon')),
            ),
            // const NotificationsScreen(),
          ),
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            builder: (ctx, state) => const SizedBox(),
          ),
          GoRoute(
            path: AppRoutes.myBio,
            name: 'myBio',
            builder: (ctx, state) => const MyBioScreen(),
          ),

          // ─── My Bio sub-screens (outside shell) ──────────────────────────
          GoRoute(
            path: AppRoutes.mySkillRatings,
            name: 'mySkillRatings',
            builder: (ctx, state) {
              final extra = state.extra as Map<String, dynamic>?;
              final userId = extra?['userId'] as String? ?? '';
              return MySkillRatingsScreen(userId: userId);
            },
          ),
          GoRoute(
            path: AppRoutes.myEndorsementList,
            name: 'myEndorsementList',
            builder: (ctx, state) {
              final extra = state.extra as Map<String, dynamic>?;
              final userId = extra?['userId'] as String? ?? '';
              final isOwnProfile = extra?['isOwnProfile'] as bool? ?? false;
              return MyEndorsementListScreen(
                userId: userId,
                isOwnProfile: isOwnProfile,
              );
            },
          ),
          GoRoute(
            path: AppRoutes.myActivities,
            name: 'myActivities',
            builder: (ctx, state) {
              final extra = state.extra as Map<String, dynamic>?;
              final userId = extra?['userId'] as String? ?? '';
              final initialTab = extra?['initialTab'] as String? ?? 'match';
              final gameType = extra?['gameType'] as String?;
              return MyActivitiesFormScreen(
                userId: userId,
                initialTab: initialTab,
                initialGameType: gameType,
              );
            },
          ),
          GoRoute(
            path: AppRoutes.myPosts,
            name: 'myPosts',
            builder: (ctx, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return MyPostsScreen(
                userId: extra?['userId'] as String? ?? '',
                isOwnProfile: extra?['isOwnProfile'] as bool? ?? false,
              );
            },
          ),
          GoRoute(
            path: AppRoutes.gallery,
            name: 'gallery',
            builder: (ctx, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return GalleryScreen(
                userId: extra?['userId'] as String? ?? '',
                isOwnProfile: extra?['isOwnProfile'] as bool? ?? false,
              );
            },
          ),
          GoRoute(
            path: AppRoutes.createPost,
            name: 'createPost',
            builder: (ctx, state) => const CreatePostScreen(),
          ),
          GoRoute(
            path: AppRoutes.editProfile,
            name: 'editProfile',
            builder: (ctx, state) {
              final playerBio = state.extra as PlayerBioModel;
              return EditProfileScreen(playerBio: playerBio);
            },
          ),
          GoRoute(
            path: AppRoutes.skillDetail,
            name: 'skillDetail',
            builder: (ctx, state) {
              final extra = state.extra as Map<String, dynamic>;
              return SkillDetailScreen(
                playerId: extra['playerId'] as String,
                skillName: extra['skillName'] as String,
                skillShort: extra['skillShort'] as String,
              );
            },
          ),
          GoRoute(
            path: AppRoutes.skillDetailViewAll,
            name: 'skillDetailViewAll',
            builder: (ctx, state) {
              final extra = state.extra as Map<String, dynamic>;
              return SkillDetailViewAllScreen(
                playerId: extra['playerId'] as String,
                skillName: extra['skillName'] as String,
                skillShort: extra['skillShort'] as String,
                role: extra['role'] as String,
                roleLabel: extra['roleLabel'] as String,
              );
            },
          ),
          // ─── Club Bio (detail screen outside shell) ──────────────────────
          GoRoute(
            path: AppRoutes.clubBio,
            name: 'clubBio',
            builder: (ctx, state) {
              final clubId = state.pathParameters['clubId']!;
              return ClubBioScreen(clubId: clubId);
            },
          ),

          // ─── Player Bio (detail screen outside shell) ────────────────────
          GoRoute(
            path: AppRoutes.playerBio,
            name: 'playerBio',
            builder: (ctx, state) {
              final userId = state.pathParameters['userId']!;
              return PlayerBioScreen(playerId: userId);
            },
          ),

          // ─── Player detail sub-screens ───────────────────────────────────
          GoRoute(
            path: AppRoutes.playerJoinedTeams,
            name: 'playerJoinedTeams',
            builder: (ctx, state) {
              final userId = state.pathParameters['userId']!;
              return PlayerJoinedTeamsScreen(playerId: userId);
            },
          ),
          GoRoute(
            path: AppRoutes.playerPendingTeams,
            name: 'playerPendingTeams',
            builder: (ctx, state) {
              final userId = state.pathParameters['userId']!;
              return PlayerPendingTeamsScreen(playerId: userId);
            },
          ),
          GoRoute(
            path: AppRoutes.playerReceivedTeams,
            name: 'playerReceivedTeams',
            builder: (ctx, state) => const PlayerReceivedTeamsScreen(),
          ),

          // ─── Search (full screen outside shell) ──────────────────────────
          GoRoute(
            path: AppRoutes.search,
            name: 'search',
            builder: (ctx, state) => Scaffold(
              body: Center(child: Text('Search - Coming Soon')),
            ),
            // const SearchScreen(),
          ),

          // ─── Team Bio (detail screen outside shell) ──────────────────────
          GoRoute(
            path: AppRoutes.teamBio,
            name: 'teamBio',
            builder: (ctx, state) {
              final teamId = state.pathParameters['teamId']!;
              return TeamBioScreen(teamId: teamId);
            },
          ),

          // ─── Team Players (detail screen outside shell) ──────────────────
          GoRoute(
            path: AppRoutes.teamPlayers,
            name: 'teamPlayers',
            builder: (ctx, state) {
              final teamId = state.pathParameters['teamId']!;
              return TeamPlayersScreen(teamId: teamId);
            },
          ),

          // ─── Tournament Detail (detail screen outside shell) ─────────────
          GoRoute(
            path: AppRoutes.tournamentDetail,
            name: 'tournamentDetail',
            builder: (ctx, state) {
              final tmntId = state.pathParameters['tmntId']!;
              return LeagueTournamentDetailsScreen(tournamentId: tmntId);
            },
          ),

          // ─── Cup Detail (detail screen outside shell) ────────────────────
          GoRoute(
            path: AppRoutes.cupDetail,
            name: 'cupDetail',
            builder: (ctx, state) {
              final cupId = state.pathParameters['cupId']!;
              return CupTournamentDetailsScreen(tournamentId: cupId);
            },
          ),

          // ─── Match Management (detail screen outside shell) ──────────────

          GoRoute(
            path: AppRoutes.matchManagement,
            name: 'matchManagement',
            builder: (ctx, state) {
              final matchId = state.pathParameters['matchId']!;
              final extra = state.extra as Map<String, dynamic>?;
              final match = extra?['match'] as TournamentMatchModel;
              final tournamentId = extra?['tournamentId'] as String;
              return MatchManagementScreen(
                matchId: matchId,
                match: match,
                tournamentId: tournamentId,
              );
            },
          ),

          // ─── Partner Bio screens (outside shell) ─────────────────────────
          GoRoute(
            path: AppRoutes.faBio,
            name: 'faBio',
            builder: (ctx, state) {
              final faId = state.pathParameters['faId']!;
              return FaBioScreen(faId: faId);
            },
          ),
          GoRoute(
            path: AppRoutes.confedBio,
            name: 'confedBio',
            builder: (ctx, state) => const Scaffold(
              body: Center(child: Text('Confederation Bio — Coming Soon')),
            ),
          ),
          GoRoute(
            path: AppRoutes.sponsorBio,
            name: 'sponsorBio',
            builder: (ctx, state) => const Scaffold(
              body: Center(child: Text('Sponsor Bio — Coming Soon')),
            ),
          ),
          GoRoute(
            path: AppRoutes.charityBio,
            name: 'charityBio',
            builder: (ctx, state) => const Scaffold(
              body: Center(child: Text('Charity Bio — Coming Soon')),
            ),
          ),

          // ─── One-Off Matches (outside shell) ─────────────────────────────
          GoRoute(
            path: AppRoutes.upcomingMatches,
            name: 'upcomingMatches',
            builder: (ctx, state) => const UpcomingMatchesScreen(),
          ),
          GoRoute(
            path: AppRoutes.recentMatches,
            name: 'recentMatches',
            builder: (ctx, state) => const RecentMatchesScreen(),
          ),

          // ─── Pickup Matches (outside shell) ──────────────────────────────
          GoRoute(
            path: AppRoutes.hostPickupMatch,
            name: 'hostPickupMatch',
            builder: (ctx, state) => const HostPickupMatchScreen(),
          ),
          GoRoute(
            path: AppRoutes.pickupMatchDetail,
            name: 'pickupMatchDetail',
            builder: (ctx, state) {
              final matchId = state.pathParameters['matchId']!;
              return PickupMatchDetailsScreen(matchId: matchId);
            },
          ),
          GoRoute(
            path: AppRoutes.pickupMatchRequests,
            name: 'pickupMatchRequests',
            builder: (ctx, state) {
              final matchId = state.pathParameters['matchId']!;
              return PickupMatchRequestsScreen(matchId: matchId);
            },
          ),

          // ─── Live Matches (player/fan list) ──────────────────────────────
          GoRoute(
            path: AppRoutes.playerLiveMatches,
            name: 'playerLiveMatches',
            builder: (ctx, state) => const PlayerLiveMatchListScreen(),
          ),

          // ─── Live Match Details (all roles, view-only) ────────────────────
          GoRoute(
            path: AppRoutes.liveMatchDetails,
            name: 'liveMatchDetails',
            builder: (ctx, state) {
              final matchId = state.pathParameters['matchId']!;
              final extra = state.extra as Map<String, dynamic>? ?? {};
              final tournamentId = extra['tournamentId'] as String? ?? '';
              return LiveMatchDetailsScreen(
                matchId: matchId,
                tournamentId: tournamentId,
              );
            },
          ),

          GoRoute(
            path: AppRoutes.privacySettings,
            name: 'privacySettings',
            builder: (ctx, state) => const PrivacySettingsScreen(),
          ),
          GoRoute(
            path: AppRoutes.lagecy_contact,
            name: 'lagecy_contact',
            builder: (ctx, state) {
              return LegacyContactScreen();
            },
          ),
        ],
      ),

      // ─── Referee tournament detail (full-screen, no shell nav) ───────────
      GoRoute(
        path: AppRoutes.refereeTournamentView,
        name: 'refereeTournamentView',
        builder: (ctx, state) => TournamentFeaturedScreen(
          tournamentId: state.pathParameters['tmntId']!,
          isReferee: true,
        ),
      ),

      // ─── Referee shell (separate from common shell) ───────────────────────
      ShellRoute(
        builder: (ctx, state, child) => RefereeHomeScreen(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.refereeTournament,
            name: 'refereeTournament',
            builder: (_, __) => const RefereeTournamentScreen(),
          ),
          GoRoute(
            path: AppRoutes.refereeRequests,
            name: 'refereeRequests',
            builder: (_, __) => Scaffold(
              body: Center(child: Text('refereeRequests - Coming Soon')),
            ),
            // const RefereeMyRequestsScreen(),
          ),
          GoRoute(
            path: AppRoutes.refereeMatches,
            name: 'refereeMatches',
            builder: (_, __) => Scaffold(
              body: Center(child: Text('refereeMatches - Coming Soon')),
            ),
            //  const RefereeMyMatchesScreen(),
          ),
          GoRoute(
            path: AppRoutes.refereeLive,
            name: 'refereeLive',
            builder: (_, __) => const RefereeLiveMatchesScreen(),
          ),
          GoRoute(
            path: AppRoutes.refereeBio,
            name: 'refereeBio',
            builder: (_, __) => const RefereeMyBioScreen(),
          ),
          GoRoute(
            path: AppRoutes.refereeActivities,
            name: 'refereeActivities',
            builder: (_, __) => const Scaffold(
              body: Center(child: Text('Referee Activities — Phase 9')),
            ),
          ),
          GoRoute(
            path: AppRoutes.refereeManageMatch,
            name: 'refereeManageMatch',
            builder: (ctx, state) {
              final matchId = state.pathParameters['matchId']!;
              return Scaffold(
                body: Center(child: Text('Manage Match $matchId — Phase 8')),
              );
            },
          ),
          GoRoute(
            path: AppRoutes.refereeLiveUpdate,
            name: 'refereeLiveUpdate',
            builder: (ctx, state) {
              final matchId = state.pathParameters['matchId']!;
              return Scaffold(
                body: Center(child: Text('Live Update $matchId — Phase 9')),
              );
            },
          ),
        ],
      ),

      // ─── Club Admin shell (separate from common + referee shells) ─────────
      ShellRoute(
        builder: (ctx, state, child) => ClubHomeScreen(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.clubBioAdmin,
            name: 'clubBioAdmin',
            builder: (_, __) => const ClubBioAdminScreen(),
          ),
          GoRoute(
            path: AppRoutes.clubPlayers,
            name: 'clubPlayers',
            builder: (_, __) => const ClubPlayersScreen(),
          ),
          GoRoute(
            path: AppRoutes.clubPlayerBio,
            name: 'clubPlayerBio',
            builder: (ctx, state) => ClubPlayerBioScreen(
              playerId: state.pathParameters['playerId']!,
            ),
          ),
          GoRoute(
            path: AppRoutes.clubGallery,
            name: 'clubGallery',
            builder: (_, __) => const ClubGalleryScreen(),
          ),
          GoRoute(
            path: AppRoutes.clubTrials,
            name: 'clubTrials',
            builder: (_, __) => const ClubTrialsScreen(),
          ),
        ],
      ),
      // ─── Settings screens (full-screen, no shell nav) ────────────────
      GoRoute(
        path: AppRoutes.changePassword,
        name: 'changePassword',
        builder: (ctx, state) => const ChangePasswordScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.error}')),
    ),
  );
});
