/// All production-live API endpoint names.
/// Source of truth: Socaloca-legacy/app/src/main/java/com/football/socaloca/libs/APINames.java
/// Dead endpoints removed per DEAD_CODE_AUDIT.md — do NOT add getAcademyPosts,
/// getClubPosts, getCharityPosts, getConfedPosts, getFAPosts, getSponPosts,
/// signIn, signUp, getFeedNetwork, or createProfile back here.
class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://organise.socaloca.football:9757/';
  static const String imageBaseUrl =
      'https://soca-loca.s3-us-west-2.amazonaws.com/dev/';

  static const String mapsApiKey = 'AIzaSyA94sWctn9Zp4j32EJTCafz3KGoxThx6jI';

  /// List of default avatar filenames that are local assets, not remote images
  static const List<String> defaultAvatars = [
    'boy_blue_1.png',
    'boy_blue_2.png',
    'boy_blue_3.png',
    'boy_blue_4.png',
    'boy_red_1.png',
    'boy_red_2.png',
    'boy_red_3.png',
    'boy_red_4.png',
    'girl_blue_1.png',
    'girl_blue_2.png',
    'girl_blue_3.png',
    'girl_blue_4.png',
    'girl_red_1.png',
    'girl_red_2.png',
    'girl_red_3.png',
    'girl_red_4.png',
  ];

  /// Build full image URL from relative path
  /// If the path already contains http/https, return as-is
  /// If the path is a default avatar, return null (will use placeholder)
  static String getImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return '';

    // Check if it's a default avatar (local asset)
    if (defaultAvatars.contains(imagePath)) {
      return ''; // Return empty string to trigger placeholder
    }

    // If already a full URL, return as-is
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath;
    }

    // Prepend base URL for relative paths
    return imageBaseUrl + imagePath;
  }

  // ─── Auth ────────────────────────────────────────────────────────────────
  static const String modSignIn = 'modSignIn';
  static const String modSignUp = 'modSignUp';
  static const String clubLogin = 'clubLogin';
  static const String socialLogin = 'socialLogin';
  static const String verifyOtp = 'verifyOtp';

  /// Forgot password — user path (NewLoginFragment flow)
  static const String forgetAllPass = 'forgetAllPass';

  /// Forgot password — club path (LoginClubFragment flow)
  static const String forgetPass = 'forgetPass';

  /// Reset password — user path
  static const String resetAllPass = 'resetAllPass';

  /// Reset password — club path
  static const String resetPass = 'resetPass';

  static const String changePassword = 'changePassword';
  static const String updateFcm = 'updateFcm';
  static const String accUserPolicy = 'accUserPolicy';
  static const String preRegister = 'preRegister';
  static const String createUserProfile = 'createUserProfile';

  // ─── User / Profile ──────────────────────────────────────────────────────
  static const String getUserProfile = 'getUserProfile';
  static const String getPlayerBio = 'getPlayerBio';
  static const String editCommonProfile = 'editCommonProfile';
  static const String editFanProfile = 'editFanProfile';
  static const String getAdminBio = 'getAdminBio';
  static const String getRefBio = 'getRefBio';
  static const String getPlayerStats = 'getPlayerStats';
  static const String getPlayerSkills = 'getPlayerSkills';
  static const String getPlayerSkillSet = 'getPlayerSkillSet';
  static const String getMySkillSet = 'getMySkillSet';
  static const String getSkillVdos = 'getSkillVdos';
  static const String getPlayerTmnts = 'getPlayerTmnts';
  static const String getPlayerTeams = 'getPlayerTeams';
  static const String getPlayerAcaVdos = 'getPlayerAcaVdos';
  static const String getMostEndorsed = 'getMostEndorsed';
  static const String getFanPlayers = 'getFanPlayers';
  static const String delAccount = 'delAccount';
  static const String getMaxmind = 'getMaxmind';
  static const String getUserRegion = 'clubRegionByCountry';
  static const String saveUserRegion = 'svUsrRegion';

  // ─── Social ───────────────────────────────────────────────────────────────
  static const String followUser = 'followUser';
  static const String likeUser = 'likeUser';
  static const String getFollowers = 'getFollowers';
  static const String getFollowings = 'getFollowings';
  static const String reportUser = 'reportUser';
  static const String blockUser = 'blockUser';
  static const String getUserBlocked = 'getUserBlocked';
  static const String getUserPosts = 'getUserPosts';
  static const String getLikes = 'getLikes';

  // ─── Teams ────────────────────────────────────────────────────────────────
  static const String createTeam = 'createTeam';
  static const String editTeam = 'editTeam';
  static const String deleteTeam = 'deleteTeam';
  static const String archiveTeam = 'archiveTeam';
  static const String followTeam = 'followTeam';
  static const String getMyTeams = 'getMyTeams';
  static const String getAllTeams = 'getAllTeams';
  static const String getTeams = 'getTeams';
  static const String getTeamBio = 'getTeamBio';
  static const String fetchTeamBio = 'fetchTeamBio';
  static const String getTeamRecentMatches = 'getTeamRecentMatches';
  static const String getTeamPlayersByLimit = 'getTeamPlayersByLimit';
  static const String getTeamAllPlayers = 'getTeamAllPlayers';
  static const String getTeamAllMembers = 'getTeamAllMembers';
  static const String getAssignTeamPlayers = 'getAssignTeamPlayers';
  static const String assignTeamPlayers = 'assignTeamPlayers';
  static const String assignTeamAdmin = 'assignTeamAdmin';
  static const String removeTeamAdmin = 'removeTeamAdmin';
  static const String editTeamPlayerJersey = 'editTeamPlayerJersey';
  static const String removeTeamPlayer = 'removeTeamPlayer';
  static const String getTeamJoinRequests = 'getTeamJoinRequests';
  static const String respondTeamJoinRequest = 'respondTeamJoinRequest';
  static const String requestTeamJoin = 'requestTeamJoin';
  static const String cancelTeamJoinRequest = 'cancelTeamJoinRequest';
  static const String inviteTeamPlayer = 'inviteTeamPlayer';
  static const String checkTeamInvite = 'checkTeamInvite';
  static const String playerJoinedTeams = 'playerJoinedTeams';
  static const String playerPendingTeams = 'playerPendingTeams';
  static const String teamPlayerInvites = 'teamPlayerInvites';
  static const String respondTeamPlayer = 'respondTeamPlayer';
  static const String getPlayerAdminTeams = 'getPlayerAdminTeams';
  static const String promCoachManager = 'promCoachManager';
  static const String remCoachManager = 'remCoachManager';
  static const String mgrTeamPlayerDtl = 'mgrTeamPlayerDtl';
  static const String mgrSaveTeamPlayers = 'mgrSaveTeamPlayers';

  // ─── Matches ──────────────────────────────────────────────────────────────
  /// Played / historical match detail — used by PlayedMatchDetails etc.
  static const String getMatchDetails = 'getMatchDetails';

  /// Live & upcoming match detail — used by MatchDetailsFragment
  static const String getMatchData = 'getMatchData';

  static const String hostMatch = 'hostMatch';
  static const String getTeamsHostMatch = 'getTeamsHostMatch';
  static const String adminAcceptedMatches = 'adminAcceptedMatches';
  static const String adminReceivedMatches = 'adminReceivedMatches';
  static const String adminSentMatches = 'adminSentMatches';
  static const String acceptDeclineMatchRequest = 'acceptDeclineMatchRequest';
  static const String cancelSentMatchRequest = 'cancelSentMatchRequest';
  static const String sendMatchScore = 'sendMatchScore';
  static const String acceptMatchScore = 'acceptMatchScore';
  static const String saveMatchPhotos = 'saveMatchPhotos';
  static const String saveMatchVideos = 'saveMatchVideos';
  static const String saveMatchRating = 'saveMatchRating';
  static const String saveMatchMvp = 'saveMatchMvp';
  static const String saveMatchGoalDetails = 'saveMatchGoalDetails';
  static const String saveMatchCardDetails = 'saveMatchCardDetails';
  static const String updateMatchPlayers = 'updateMatchPlayers';
  static const String getCommonTodaysMatches = 'getCommonTodaysMatches';
  static const String getCommonUpcomingMatches = 'getCommonUpcomingMatches';
  static const String getCommonPlayedMatches = 'getCommonPlayedMatches';
  static const String mediaBaseUrl = 'mediaBaseUrl';

  // One-Off Matches (Fan view)
  static const String getFanTodaysMatches = 'getFanTodaysMatches';
  static const String getFanUpcomingMatches = 'getFanUpcomingMatches';
  static const String getFanPlayedMatches = 'getFanPlayedMatches';
  static const String addMatchActivity = 'addMatchActivity';
  static const String getMatchActivity = 'getMatchActivity';
  static const String matchUpdates = 'matchUpdates';
  static const String mtchSquadAlert = 'mtchSquadAlert';
  static const String mtchTeamGetSquad = 'mtchTeamGetSquad';
  static const String mtchTeamSetSquad = 'mtchTeamSetSquad';
  static const String mtchGetPlayingSquad = 'mtchGetPlayingSquad';
  static const String mtchSetPlayingSquad = 'mtchSetPlayingSquad';
  static const String createOneoffTempTeam = 'createOneoffTempTeam';
  static const String resetMatch = 'resetMatch';

  // ─── Pick-Up Matches ──────────────────────────────────────────────────────
  static const String getPickUpMatches = 'getPickUpMatches';
  static const String hostPickupMatch = 'hostPickupMatch';
  static const String reqPickupMatch = 'reqPickupMatch';
  static const String acceptDeclinePickupRequest = 'acceptDeclinePickupRequest';
  static const String pickUpMatchDetails = 'pickUpMatchDetails';
  static const String pickupMatchReqList = 'pickupMatchReqList';

  // ─── Referee ──────────────────────────────────────────────────────────────
  static const String getRefMatchList = 'getRefMatchList';
  static const String getRefLiveList = 'getRefLiveList';
  static const String getLiveMatchList = 'getLiveMatchList';
  static const String getRefTmntsDrop = 'getRefTmntsDrop';
  static const String getRefMatchReqs = 'getRefMatchReqs';
  static const String respondRefMatch = 'respondRefMatch';
  static const String getRefTmntMtchDtl = 'getRefTmntMtchDtl';
  static const String getRefLiveMtchData = 'getRefLiveMtchData';
  static const String saveRefLiveMtchData = 'saveRefLiveMtchData';
  static const String clearRefLiveMtchData = 'clearRefLiveMtchData';
  static const String prefillLiveMatch = 'prefillLiveMatch';
  static const String saveRefMatchScore = 'saveRefMatchScore';
  static const String saveMatchOfcl = 'saveMatchOfcl';
  static const String refSaveMatchGoals = 'refSaveMatchGoals';
  static const String saveRefMtchExtScore = 'saveRefMtchExtScore';
  static const String saveRefMtchExtGoals = 'saveRefMtchExtGoals';
  static const String saveRefMtchPenaltyScore = 'saveRefMtchPenaltyScore';
  static const String saveRefMtchPenaltyGoals = 'saveRefMtchPenaltyGoals';
  static const String saveRefMatchMvp = 'saveRefMatchMvp';
  static const String saveRefMtchCards = 'saveRefMtchCards';
  static const String saveRefMtchSquad = 'saveRefMtchSquad';
  static const String saveRefMatchSubs = 'saveRefMatchSubs';
  static const String saveRefMatchMgmt = 'saveRefMatchMgmt';
  static const String saveRefMtchPhotos = 'saveRefMtchPhotos';
  static const String saveRefMtchVideos = 'saveRefMtchVideos';
  static const String saveRefMtchBigVideo = 'saveRefMtchBigVideo';
  static const String pubRefMtchBigVideo = 'pubRefMtchBigVideo';
  static const String refMatchCleanSheet = 'refMatchCleanSheet';
  static const String getRefCompStats = 'getRefCompStats';
  static const String addRefMatchActivity = 'addRefMatchActivity';
  static const String getRefMtchActivity = 'getRefMtchActivity';
  static const String getRefMtchActList = 'getRefMtchActList';
  static const String getLiveMtchCountries = 'getLiveMtchCountries';
  static const String getRefTmnts = 'getRefTmnts';
  static const String getRefTmntsReqDrop = 'getRefTmntsReqDrop';
  static const String saveRefMatchIncident = 'saveRefMatchIncident';
  static const String getRefBioRef = 'getRefBio';
  static const String getRefMtchActListRef = 'getRefMtchActList';

  // ─── Tournaments ──────────────────────────────────────────────────────────
  static const String getTmnts = 'getTmnts';
  static const String getTmntDetails = 'getTmntDetails';
  static const String followTournament = 'followTournament';
  static const String checkReqForTmnt = 'checkReqForTmnt';
  static const String getMyTeamsForTmnt = 'getMyTeamsForTmnt';
  static const String requestTmnt = 'requestTmnt';
  static const String acceptTmntRequest = 'acceptTmntRequest';
  static const String withdrawTeam = 'withdrawTeam';
  static const String leagueUpcomingMatches = 'leagueUpcomingMatches';
  static const String leaguePlayedMatches = 'leaguePlayedMatches';
  static const String leaguePointTable = 'leaguePointTable';
  static const String leagueStatGoals = 'leagueStatGoals';
  static const String leagueStatAssists = 'leagueStatAssists';
  static const String leagueStatCards = 'leagueStatCards';
  static const String leagueStatMom = 'leagueStatMom';
  static const String getCoachAdminTmnts = 'getCoachAdminTmnts';
  static const String getCoachAdminTmntList = 'getCoachAdminTmntList';
  static const String getMyTmntTeams = 'getMyTmntTeams';
  static const String getMyTmntTeamMtchs = 'getMyTmntTeamMtchs';
  static const String getVisTmnts = 'getVisTmnts';
  static const String getFeedLiveTmnts = 'getFeedLiveTmnts';
  static const String tmntTeamGetSquad = 'tmntTeamGetSquad';
  static const String tmntTeamSetSquad = 'tmntTeamSetSquad';
  static const String getMyTmntJoinedTeams = 'getMyTmntJoinedTeams';
  static const String getMyTmnts = 'getMyTmnts';
  static const String getTmntMatches = 'getTmntMatches';
  static const String getTmntPointsTable = 'getTmntPointsTable';

  // ─── Cups ─────────────────────────────────────────────────────────────────
  static const String getCupDetails = 'getCupDetails';
  static const String getCupReadyDetail = 'getCupReadyDetail';
  static const String checkReqForCup = 'checkReqForCup';
  static const String getMyTeamsForCup = 'getMyTeamsForCup';
  static const String requestCup = 'requestCup';
  static const String acceptCupRequest = 'acceptCupRequest';
  static const String getCupGroupMatches = 'getCupGroupMatches';
  static const String getCupLeagueTable = 'getCupLeagueTable';
  static const String getCupKnockMatches = 'getCupKnockMatches';
  static const String cupLeagueStatGoals = 'cupLeagueStatGoals';
  static const String cupLeagueStatAssists = 'cupLeagueStatAssists';
  static const String cupLeagueStatCards = 'cupLeagueStatCards';
  static const String cupLeagueStatMom = 'cupLeagueStatMom';
  static const String cupMatchStatGoals = 'cupMatchStatGoals';
  static const String cupMatchStatAssists = 'cupMatchStatAssists';
  static const String cupMatchStatCards = 'cupMatchStatCards';
  static const String cupMatchStatMom = 'cupMatchStatMom';

  // ─── Match Management ─────────────────────────────────────────────────────
  // static const String sendMatchScore = 'sendMatchScore';
  // static const String acceptMatchScore = 'acceptMatchScore';
  // static const String saveMatchGoalDetails = 'saveMatchGoalDetails';
  // static const String saveMatchCardDetails = 'saveMatchCardDetails';
  // static const String saveMatchMvp = 'saveMatchMvp';
  // static const String updateMatchPlayers = 'updateMatchPlayers';
  // static const String saveMatchPhotos = 'saveMatchPhotos';
  // static const String saveMatchVideos = 'saveMatchVideos';
  // static const String saveMatchRating = 'saveMatchRating';
  // static const String getMatchDetails = 'getMatchDetails';
  static const String getMatchPhotos = 'getMatchPhotos';
  static const String getMatchVideos = 'getMatchVideos';

  // ─── Tournament Invitations ───────────────────────────────────────────────
  static const String getWithdrawTmntTeams = 'getWithdrawTmntTeams';
  static const String getTmntInvitations = 'getTmntInvitations';
  static const String respondTmntInvitation = 'respondTmntInvitation';

  // ─── Social Feed ──────────────────────────────────────────────────────────
  static const String getFeed = 'getFeed';
  static const String getFeedTeams = 'getFeedTeams';
  static const String getFeedTeamList = 'getFeedTeamList';
  static const String getFeedNewTeams = 'getFeedNewTeams';
  static const String getFeedRecUsers = 'getFeedRecUsers';
  static const String createUserPost = 'createUserPost';
  static const String editUserPost = 'editUserPost';
  static const String deletePost = 'deletePost';
  static const String likePost = 'likePost';
  static const String reportPost = 'reportPost';
  static const String blockPost = 'blockPost';
  static const String getPostShow = 'getPostShow';
  static const String likeOrgPost = 'likeOrgPost';
  static const String reportOrgPost = 'reportOrgPost';
  static const String likeSocaPost = 'likeSocaPost';
  static const String getFeedComments = 'getFeedComments';
  static const String getCommentReplies = 'getCommentReplies';
  static const String saveFeedComment = 'saveFeedComment';
  static const String likeFeedComment = 'likeFeedComment';
  static const String tagUserSearch = 'tagUserSearch';
  static const String tagAcademySearch = 'tagAcademySearch';
  static const String translate = 'translate';
  static const String getNewsShow = 'getNewsShow';

  // ─── Club ─────────────────────────────────────────────────────────────────
  static const String getClubBio = 'getClubBio';
  static const String getClubs = 'getClubs';
  static const String followClub = 'followClub';
  static const String getClubPlayerList = 'getClubPlayerList';
  static const String getClubPlayerDetails = 'getClubPlayerDetails';
  static const String getClubPostList = 'getClubPostList'; // NOT getClubPosts
  static const String likeClubPost = 'likeClubPost';
  static const String reportClubPost = 'reportClubPost';
  static const String clubRegister = 'clubRegister';
  static const String upgradeClubPlan = 'upgradeClubPlan';
  static const String trialRegister = 'trialRegister';
  static const String clubTrialList = 'clubTrialList';
  static const String allClubTrials = 'allClubTrials';
  static const String clubRegionByCountry = 'clubRegionByCountry';

  // ─── Academy ──────────────────────────────────────────────────────────────
  static const String getAcademyBio = 'getAcademyBio';
  static const String getAcademyList = 'getAcademyList';
  static const String followAcademy = 'followAcademy';
  static const String joinAcademy = 'joinAcademy';
  static const String getAcademyPostList =
      'getAcademyPostList'; // NOT getAcademyPosts
  static const String likeAcademyPost = 'likeAcademyPost';
  static const String reportAcademyPost = 'reportAcademyPost';
  static const String academyTrialList = 'academyTrialList';
  static const String acaTrialRegister = 'acaTrialRegister';
  static const String allAcademyTrials = 'allAcademyTrials';
  static const String getUserAcademy = 'getUserAcademy';
  static const String getAcaVdoPostShow = 'getAcaVdoPostShow';
  static const String likeAcademyVdoPost = 'likeAcademyVdoPost';
  static const String reportAcademyVdoPost = 'reportAcademyVdoPost';
  static const String likeAcademyNews = 'likeAcademyNews';
  static const String reportAcademyNews = 'reportAcademyNews';

  // ─── FA / Confederation ───────────────────────────────────────────────────
  static const String getFABio = 'getFABio';
  static const String getFAList = 'getFAList';
  static const String followFA = 'followFA';
  static const String getFAPostList = 'getFAPostList'; // NOT getFAPosts
  static const String likeFAPost = 'likeFAPost';
  static const String reportFAPost = 'reportFAPost';
  static const String getFACompsList = 'getFACompsList';
  static const String faTrialList = 'faTrialList';
  static const String faTrialRegister = 'faTrialRegister';
  static const String getFATeamList = 'getFATeamList';
  static const String getConfedBio = 'getConfedBio';
  static const String getConfedList = 'getConfedList';
  static const String followConfed = 'followConfed';
  static const String getConfedFAsList = 'getConfedFAsList';
  static const String getConfedCompsList = 'getConfedCompsList';
  static const String getConfedPostList =
      'getConfedPostList'; // NOT getConfedPosts

  // ─── Sponsor / Charity ────────────────────────────────────────────────────
  static const String getSponBio = 'getSponBio';
  static const String getSponList = 'getSponList';
  static const String followSpon = 'followSpon';
  static const String getSponPostList = 'getSponPostList'; // NOT getSponPosts
  static const String getSponMerchantList = 'getSponMerchantList';
  static const String getCharityBio = 'getCharityBio';
  static const String getCharityList = 'getCharityList';
  static const String followCharity = 'followCharity';
  static const String getCharityPostList =
      'getCharityPostList'; // NOT getCharityPosts

  // ─── Endorsements ─────────────────────────────────────────────────────────
  static const String endorsePlayer = 'endorsePlayer';
  static const String endorseUser = 'endorseUser';
  static const String repondEndorse = 'repondEndorse';
  static const String getEndorses = 'getEndorses';
  static const String getEndorsesSummary = 'getEndorsesSummary';
  static const String getEndorseRoleUsers = 'getEndorseRoleUsers';

  // ─── Notifications ────────────────────────────────────────────────────────
  static const String getNotifications = 'getNotifications';
  static const String getNotificationCount = 'getNotificationCount';

  // ─── Search ───────────────────────────────────────────────────────────────
  static const String searchProfileName = 'searchProfileName';
  static const String advSearch = 'advSearch';
  static const String searchMembers = 'searchMembers';
  static const String searchTeams = 'searchTeams';
  static const String searchMatches = 'searchMatches';
  static const String searchPlayerForTeam = 'searchPlayerForTeam';

  // ─── Media ────────────────────────────────────────────────────────────────
  static const String uploadImage = 'uploadImage';
  static const String uploadVdo = 'uploadVdo';
  static const String uploadBulk = 'uploadBulk';
  static const String getVdoSpace = 'getVdoSpace';

  // ─── Parental Control ─────────────────────────────────────────────────────
  static const String parentLogin = 'parentLogin';
  static const String parentSetPerm = 'parentSetPerm';
  static const String parentForget = 'parentForget';
  static const String parentChangePin = 'parentChangePin';

  // ─── Settings / Account ───────────────────────────────────────────────────
  static const String getLegacyContact = 'getLegacyContact';
  static const String saveLegacyContact = 'saveLegacyContact';
  static const String saveNps = 'saveNps';
  static const String submitSurvey = 'submitSurvey';
  static const String addShareHit = 'addShareHit';
  static const String checkAppUpdate = 'checkAppUpdate/android';
  static const String chkUpdt = 'chkUpdt';
  static const String createPKey = 'createPKey';
  static const String downloadActivities = 'downloadActivities';
  static const String sendAppInvite = 'sendAppInvite';
  static const String referCodeList = 'referCodeList';

  // ─── Fan-specific ─────────────────────────────────────────────────────────
  static const String getFanLanding = 'getFanLanding';
  // static const String getFanPlayers = 'getFanPlayers';
  static const String getLikeBoard = 'getLikeBoard';

  // ─── Activity / Training ──────────────────────────────────────────────────
  static const String addTrainingActivity = 'addTrainActivity';
  static const String getTrainActivity = 'getTrainActivity';
  static const String getMiniActivity = 'getMiniActivity';

  // ─── Player Transfer ──────────────────────────────────────────────────────
  static const String reqPlayerTransfer = 'reqPlayerTransfer';
  static const String verifyPlayerTransfer = 'verifyPlayerTransfer';

  // ─── Misc ─────────────────────────────────────────────────────────────────
  static const String likeUserJoin = 'likeUserJoin';
  static const String likeTeamJoin = 'likeTeamJoin';
  static const String getLikeList = 'getLikes';
  static const String addShareHitConst = 'addShareHit';
}
