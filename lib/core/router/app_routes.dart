/// All named route paths in the app.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String loginLanding = '/auth';
  static const String login = '/auth/login';
  static const String clubLogin = '/auth/club-login';
  static const String signup = '/auth/signup';
  static const String otp = '/auth/otp';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String roleChoice = '/auth/role-choice';
  static const String ageSelection = '/auth/age-selection';
  static const String youthConsent = '/auth/youth-consent';
  static const String childConsent = '/auth/child-consent';
  static const String pinSetup = '/auth/pin-setup';
  static const String parentalSettings = '/auth/parental-settings';
  static const String socialAge = '/auth/social-age';
  static const String socialThankYou = '/auth/social-thank-you';
  static const String createProfile = '/auth/create-profile';

  static const String locationPicker = '/location-picker';

  static const String home = '/home';
  static const String teams = '/teams';
  static const String tournaments = '/tournaments';
  static const String tournamentslistScreen = '/tournamentslistScreen';
  static const String clubsPartners = '/clubs-partners';
  static const String players = '/players';
  static const String trials = '/trials';
  static const String academies = '/academies';
  static const String academyBio = '/academies/:academyId';
  static const String matches = '/matches';
  static const String notifications = '/notifications';
  static const String profile = '/profile';
  static const String myBio = '/my-bio';
  static const String mySkillRatings = '/my-bio/ratings';
  static const String skillDetail = '/skill-detail';
  static const String skillDetailViewAll = '/skill-detail/view-all';
  static const String myEndorsementList = '/my-bio/endorsements';
  static const String myActivities = '/my-bio/activities';
  static const String myPosts = '/my-bio/posts';
  static const String gallery = '/my-bio/gallery';
  static const String createPost = '/my-bio/create-post';
  static const String editProfile = '/my-bio/edit-profile';

  static const String matchDetail = '/matches/:matchId';
  static const String liveMatch = '/matches/:matchId/live';

  // Live Matches (player/fan + all roles view)
  static const String playerLiveMatches = '/live-matches';
  static const String liveMatchDetails = '/live-match/:matchId';
  static const String pickupMatches = '/pickup';
  static const String hostPickupMatch = '/pickup/host';
  static const String pickupMatchDetail = '/pickup/:matchId';
  static const String pickupMatchRequests = '/pickup/:matchId/requests';

  // One-Off Matches
  static const String upcomingMatches = '/one-off-matches/upcoming';
  static const String recentMatches = '/one-off-matches/recent';

  static const String search = '/search';
  static const String fullScreenVideo = '/video/full-screen';
  static const String teamBio = '/teams/:teamId';
  static const String teamPlayers = '/teams/:teamId/players';
  static const String playerBio = '/players/:userId';
  static const String coachAdminBio = '/members/:userId';
  static const String playerPeople = '/players/:userId/people';
  static const String playerLikes = '/players/:userId/likes';
  static const String playerStats = '/players/:userId/stats';
  static const String playerJoinedTeams = '/players/:userId/joined-teams';
  static const String playerPendingTeams = '/players/:userId/pending-teams';
  static const String playerReceivedTeams = '/player-invitations';
  static const String clubBio = '/clubs/:clubId';
  static const String tournamentDetail = '/tournaments/:tmntId';
  static const String cupDetail = '/cups/:cupId';
  static const String matchManagement = '/match-management/:matchId';

  // ─── Referee home shell tabs ───────────────────────────────────────────────
  static const String refereeHome = '/referee';
  static const String refereeTournament = '/referee/tournament';
  static const String refereeRequests = '/referee/requests';
  static const String refereeMatches = '/referee/matches';
  static const String refereeLive = '/referee/live';
  static const String refereeBio = '/referee/bio';

  // ─── Referee detail screens ────────────────────────────────────────────────
  static const String refereeTournamentView =
      '/referee/tournament/:tmntId/view';
  static const String refereeManageMatch = '/referee/match/:matchId/manage';
  static const String refereeLiveUpdate = '/referee/match/:matchId/live-update';
  static const String refereeActivities = '/referee/activities';

  static const String faBio = '/fa/:faId';
  static const String confedBio = '/confed/:confedId';
  static const String sponsorBio = '/sponsor/:sponId';
  static const String charityBio = '/charity/:charityId';

  // ─── Settings screens ─────────────────────────────────────────────────────
  static const String changePassword = '/settings/change-password';
  static const String privacySettings = '/settings/privacy';
  static const String lagecy_contact = '/settings/lagecy_contact';
  static const String survey = '/settings/survey';

  // ─── Club registration (public, no auth required) ─────────────────────────
  static const String registerClub = '/auth/club-register';

  // ─── Club bio sub-screens ──────────────────────────────────────────────────
  static const String clubTrialsBio = '/clubs/:clubId/trials';

  // ─── Club admin shell ──────────────────────────────────────────────────────
  static const String clubHome = '/club';
  static const String clubBioAdmin = '/club/bio';
  static const String clubPlayers = '/club/players';
  static const String clubPlayerBio = '/club/players/:playerId';
  static const String clubGallery = '/club/gallery';
  static const String clubTrials = '/club/trials';
}
