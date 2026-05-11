import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
import '../../features/home/screens/main_shell_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/teams/screens/teams_screen_new.dart';
import '../../features/teams/screens/team_bio_screen.dart';
import '../../features/teams/screens/team_players_screen.dart';
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
      final isAuthRoute = state.matchedLocation.startsWith('/auth');
      if (state.matchedLocation == AppRoutes.onboarding) {
        return AppRoutes.onboarding;
      }
      if (state.matchedLocation == AppRoutes.roleChoice) {
        return AppRoutes.roleChoice;
      }
      if (state.matchedLocation == AppRoutes.createProfile) {
        return AppRoutes.createProfile;
      }
      if (!isLoggedIn && !isAuthRoute) {
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
            builder: (ctx, state) => const ClubsPartnersLandingScreen(),
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
              body: Center(child: Text('AcademiesScreen - Coming Soon')),
            ),

            // const AcademiesScreen(),
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
        ],
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
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.error}')),
    ),
  );
});
