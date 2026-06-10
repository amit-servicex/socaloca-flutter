/// Central string registry for all UI text in SocaLoca.
///
/// Usage in any widget (no BuildContext required):
///   Text(AppStrings.cancel)
///
/// Change language:
///   AppStrings.setLanguage('es');
///
/// Supported codes: 'en', 'es', 'pt', 'fr'
class AppStrings {
  AppStrings._();

  static String _lang = 'en';

  /// Called by [LocaleNotifier] whenever the user changes language.
  static void setLanguage(String code) {
    if (_translations.containsKey(code)) _lang = code;
  }

  static String get currentLanguage => _lang;

  /// Internal lookup — falls back to English if key missing in chosen locale.
  static String _t(String key) =>
      _translations[_lang]?[key] ?? _translations['en']![key] ?? key;

  /// Translate an English literal when migrating old hard-coded UI text.
  /// Prefer named getters for new code.
  static String literal(String value) {
    var key = _englishLiteralKeys[value];
    key ??= _englishLowerLiteralKeys[value.toLowerCase()];
    if (key == null) return value;
    final translated = _t(key);
    return value == value.toUpperCase() ? translated.toUpperCase() : translated;
  }

  static final Map<String, String> _englishLiteralKeys = {
    for (final entry in _translations['en']!.entries) entry.value: entry.key,
  };

  static final Map<String, String> _englishLowerLiteralKeys = {
    for (final entry in _translations['en']!.entries)
      entry.value.toLowerCase(): entry.key,
  };

  // ── Common ────────────────────────────────────────────────────────────────
  static String get appName => _t('appName');
  static String get cancel => _t('cancel');
  static String get submit => _t('submit');
  static String get yes => _t('yes');
  static String get no => _t('no');
  static String get search => _t('search');
  static String get searchEllipsis => _t('searchEllipsis');
  static String get noResultsFound => _t('noResultsFound');
  static String get playerCoachManagerReferee =>
      _t('playerCoachManagerReferee');
  static String get byCountry => _t('byCountry');
  static String get byType => _t('byType');
  static String get byChoice => _t('byChoice');
  static String get profileDetailsNotAvailable =>
      _t('profileDetailsNotAvailable');
  static String get endorsedByUpper => _t('endorsedByUpper');
  static String get followersUpper => _t('followersUpper');
  static String get locationPermission => _t('locationPermission');
  static String get locationPermissionDesc => _t('locationPermissionDesc');
  static String get learnMore => _t('learnMore');
  static String get back => _t('back');
  static String get save => _t('save');
  static String get delete => _t('delete');
  static String get deactivate => _t('deactivate');
  static String get report => _t('report');
  static String get follow => _t('follow');
  static String get following => _t('following');
  static String get followers => _t('followers');
  static String get viewAll => _t('viewAll');
  static String get comingSoon => _t('comingSoon');
  static String get somethingWentWrong => _t('somethingWentWrong');
  static String get error => _t('error');
  static String get na => _t('na');
  static String get gotIt => _t('gotIt');
  static String get upgrade => _t('upgrade');
  static String get helpdesk => _t('helpdesk');
  static String get mandatoryFields => _t('mandatoryFields');
  static String get goToHome => _t('goToHome');

  // ── Language selection ────────────────────────────────────────────────────
  static String get selectLanguage => _t('selectLanguage');
  static String get selectLanguageDesc => _t('selectLanguageDesc');
  static String get pleaseSelectLanguage => _t('pleaseSelectLanguage');
  static String get englishLanguage => _t('englishLanguage');
  static String get spanishLanguage => _t('spanishLanguage');
  static String get portugueseLanguage => _t('portugueseLanguage');
  static String get frenchLanguage => _t('frenchLanguage');
  static String get pleaseSelectRating => _t('pleaseSelectRating');
  static String get nextUpper => _t('nextUpper');
  static String get submitUpper => _t('submitUpper');
  static String get doneUpper => _t('doneUpper');
  static String get yourFeedbackMatters => _t('yourFeedbackMatters');
  static String get whatAreYourFavouriteFeatures =>
      _t('whatAreYourFavouriteFeatures');
  static String get doYouWantToOfferFeedback => _t('doYouWantToOfferFeedback');
  static String get thankYouTitle => _t('thankYouTitle');
  static String get weHighlyValueFeedback => _t('weHighlyValueFeedback');
  static String get thankYouFeedbackSupport => _t('thankYouFeedbackSupport');
  static String get feed => _t('feed');
  static String get pickUpMatch => _t('pickUpMatch');
  static String get firstNamePlain => _t('firstNamePlain');
  static String get lastNamePlain => _t('lastNamePlain');
  static String get usernameMinFiveHint => _t('usernameMinFiveHint');
  static String get nameNotAvailable => _t('nameNotAvailable');

  // ── Auth — general ────────────────────────────────────────────────────────
  static String get signIn => _t('signIn');
  static String get signUp => _t('signUp');
  static String get signUpUpper => _t('signUpUpper');
  static String get signOut => _t('signOut');
  static String get login => _t('login');
  static String get forgotPassword => _t('forgotPassword');
  static String get socialLoginNoPassword => _t('socialLoginNoPassword');

  // ── Auth — fields ─────────────────────────────────────────────────────────
  static String get email => _t('email');
  static String get emailPlain => _t('emailPlain');
  static String get enterYourEmail => _t('enterYourEmail');
  static String get password => _t('password');
  static String get enterYourPassword => _t('enterYourPassword');
  static String get newPassword => _t('newPassword');
  static String get enterYourNewPassword => _t('enterYourNewPassword');
  static String get confirmPassword => _t('confirmPassword');
  static String get currentPassword => _t('currentPassword');
  static String get enterYourCurrentPassword => _t('enterYourCurrentPassword');
  static String get changePassword => _t('changePassword');
  static String get resetPassword => _t('resetPassword');
  static String get sendOtp => _t('sendOtp');
  static String get sendResetLink => _t('sendResetLink');
  static String get resend => _t('resend');
  static String get haventReceivedCode => _t('haventReceivedCode');
  static String get otpLabel => _t('otpLabel');
  static String get socaLocaId => _t('socaLocaId');
  static String get mobile => _t('mobile');
  static String get enterSocaLocaId => _t('enterSocaLocaId');
  static String get enterMobileNumber => _t('enterMobileNumber');
  static String get mobileEmailSocaLocaIdRequired =>
      _t('mobileEmailSocaLocaIdRequired');
  static String get mobileOrEmailRequired => _t('mobileOrEmailRequired');
  static String get socaLocaIdRequired => _t('socaLocaIdRequired');
  static String get emailRequired => _t('emailRequired');
  static String get mobileNumberRequired => _t('mobileNumberRequired');
  static String get enterEmailRequired => _t('enterEmailRequired');
  static String get enterMobileNumberRequired =>
      _t('enterMobileNumberRequired');
  static String get enterSocaLocaIdRequired => _t('enterSocaLocaIdRequired');

  // ── Auth — validation ─────────────────────────────────────────────────────
  static String get pleaseEnterEmail => _t('pleaseEnterEmail');
  static String get pleaseEnterValidEmail => _t('pleaseEnterValidEmail');
  static String get pleaseEnterPassword => _t('pleaseEnterPassword');
  static String get minimumSixCharacters => _t('minimumSixCharacters');
  static String get pleaseConfirmPassword => _t('pleaseConfirmPassword');
  static String get passwordDoesNotMatch => _t('passwordDoesNotMatch');
  static String get passwordDoNotMatch => _t('passwordDoNotMatch');
  static String get invalidCurrentPassword => _t('invalidCurrentPassword');
  static String get pleaseEnterCurrentPassword =>
      _t('pleaseEnterCurrentPassword');
  static String get pleaseEnterNewPassword => _t('pleaseEnterNewPassword');
  static String get pleaseConfirmNewPassword => _t('pleaseConfirmNewPassword');
  static String get passwordChangedSuccessfully =>
      _t('passwordChangedSuccessfully');
  static String get pleaseEnterOtp => _t('pleaseEnterOtp');
  static String get verificationCodeSent => _t('verificationCodeSent');
  static String get passwordResetSuccess => _t('passwordResetSuccess');
  static String get strong => _t('strong');
  static String get weak => _t('weak');
  static String get pleaseEnterValidMobileNumber =>
      _t('pleaseEnterValidMobileNumber');
  static String get pleaseEnterValidSocaLocaId =>
      _t('pleaseEnterValidSocaLocaId');
  static String get pleaseEnterMobileOrEmail => _t('pleaseEnterMobileOrEmail');
  static String get pleaseEnterYourEmailMobileOrSocaLocaId =>
      _t('pleaseEnterYourEmailMobileOrSocaLocaId');
  static String get pleaseEnterValidEmailMobileOrSocaLocaId =>
      _t('pleaseEnterValidEmailMobileOrSocaLocaId');
  static String get pleaseEnterMobileNumberOrEmail =>
      _t('pleaseEnterMobileNumberOrEmail');
  static String get passwordAtLeastSixCharacters =>
      _t('passwordAtLeastSixCharacters');
  static String get minimumFiveCharacters => _t('minimumFiveCharacters');
  static String get unexpectedResponseTryAgain =>
      _t('unexpectedResponseTryAgain');
  static String get wrongPassword => _t('wrongPassword');
  static String get accountNotRegistered => _t('accountNotRegistered');
  static String get mobileNotRegistered => _t('mobileNotRegistered');
  static String get failedAcceptPolicyTryAgain =>
      _t('failedAcceptPolicyTryAgain');
  static String get googleSignInFailed => _t('googleSignInFailed');
  static String get facebookSignInFailed => _t('facebookSignInFailed');
  static String get verifyCode => _t('verifyCode');
  static String get enterVerificationCode => _t('enterVerificationCode');
  static String get verify => _t('verify');
  static String get resendCode => _t('resendCode');
  static String get addEmail => _t('addEmail');
  static String get emailAddressRequired => _t('emailAddressRequired');
  static String get addEmailOtpPrompt => _t('addEmailOtpPrompt');
  static String get selectCountry => _t('selectCountry');
  static String get forgottenPassword => _t('forgottenPassword');
  static String get logInUpper => _t('logInUpper');
  static String get orContinueWith => _t('orContinueWith');
  static String get continueLabel => _t('continueLabel');
  static String get tryAgain => _t('tryAgain');
  static String get professionalClubQuestion => _t('professionalClubQuestion');
  static String get loginSignupHere => _t('loginSignupHere');
  static String get findSocaLocaIdHint => _t('findSocaLocaIdHint');
  static String get socaLocaPrivacyNotice => _t('socaLocaPrivacyNotice');
  static String get resetUpper => _t('resetUpper');
  static String get resendUpper => _t('resendUpper');
  static String get proceedUpper => _t('proceedUpper');
  static String get saveAndContinueUpper => _t('saveAndContinueUpper');
  static String get parentalControls => _t('parentalControls');
  static String get setYourPin => _t('setYourPin');
  static String get forgetPin => _t('forgetPin');
  static String get settings => _t('settings');
  static String get modifyPin => _t('modifyPin');
  static String get pleaseProvideConsentToContinue =>
      _t('pleaseProvideConsentToContinue');
  static String get fetchingLocation => _t('fetchingLocation');
  static String get selectLocationUpper => _t('selectLocationUpper');
  static String get skip => _t('skip');
  static String get or => _t('or');
  static String fullDigitCode(int length) =>
      _t('pleaseEnterFullDigitCode').replaceFirst('{length}', '$length');
  static String verificationCodeSentTo(String type) =>
      _t('verificationCodeSentTo').replaceFirst('{type}', type);
  static String resendCodeIn(int seconds) =>
      _t('resendCodeIn').replaceFirst('{seconds}', '$seconds');
  static String resendUpperWithSeconds(int seconds) =>
      _t('resendUpperWithSeconds').replaceFirst('{seconds}', '$seconds');
  static String resetLinkSentTo(String email) =>
      _t('resetLinkSentTo').replaceFirst('{email}', email);
  static String errorMessage(Object error) =>
      _t('errorMessage').replaceFirst('{error}', '$error');
  static String errorPickingImage(Object error) =>
      _t('errorPickingImage').replaceFirst('{error}', '$error');
  static String googleSignInFailedWithCode(Object code) =>
      _t('googleSignInFailedWithCode').replaceFirst('{code}', '$code');

  // ── Profile ───────────────────────────────────────────────────────────────
  static String get firstName => _t('firstName');
  static String get lastName => _t('lastName');
  static String get profileName => _t('profileName');
  static String get enterYourName => _t('enterYourName');
  static String get dateOfBirth => _t('dateOfBirth');
  static String get country => _t('country');
  static String get gender => _t('gender');
  static String get male => _t('male');
  static String get female => _t('female');
  static String get nationality => _t('nationality');
  static String get playingPosition => _t('playingPosition');
  static String get preferredFoot => _t('preferredFoot');
  static String get right => _t('right');
  static String get left => _t('left');
  static String get height => _t('height');
  static String get heightCms => _t('heightCms');
  static String get editProfile => _t('editProfile');
  static String get createProfile => _t('createProfile');
  static String get uploadProfilePhoto => _t('uploadProfilePhoto');
  static String get takeAPhoto => _t('takeAPhoto');
  static String get chooseFromGallery => _t('chooseFromGallery');
  static String get selectImage => _t('selectImage');
  static String get myGallery => _t('myGallery');
  static String get pleaseEnterFirstName => _t('pleaseEnterFirstName');
  static String get pleaseEnterLastName => _t('pleaseEnterLastName');
  static String get pleaseEnterProfileName => _t('pleaseEnterProfileName');
  static String get pleaseEnterDateOfBirth => _t('pleaseEnterDateOfBirth');
  static String get pleaseSelectNationality => _t('pleaseSelectNationality');

  // ── Navigation tabs ───────────────────────────────────────────────────────
  static String get home => _t('home');
  static String get away => _t('away');
  static String get third => _t('third');
  static String get teams => _t('teams');
  static String get players => _t('players');
  static String get matches => _t('matches');
  static String get clubsAndPartners => _t('clubsAndPartners');

  // ── Notifications ─────────────────────────────────────────────────────────
  static String get notifications => _t('notifications');
  static String get noNotifications => _t('noNotifications');

  // ── Tournaments / Matches ─────────────────────────────────────────────────
  static String get tournaments => _t('tournaments');
  static String get club => _t('club');
  static String get clubs => _t('clubs');
  static String get partners => _t('partners');
  static String get academy => _t('academy');
  static String get match => _t('match');
  static String get recentMatches => _t('recentMatches');
  static String get upcomingMatches => _t('upcomingMatches');
  static String get noUpcomingMatches => _t('noUpcomingMatches');
  static String get noRecentMatches => _t('noRecentMatches');
  static String get errorLoadingUpcomingMatches =>
      _t('errorLoadingUpcomingMatches');
  static String get errorLoadingRecentMatches =>
      _t('errorLoadingRecentMatches');
  static String get todaysMatch => _t('todaysMatch');
  static String get playedMatches => _t('playedMatches');
  static String get noPlayedMatches => _t('noPlayedMatches');
  static String get todaysMatches => _t('todaysMatches');
  static String get hostMatch => _t('hostMatch');
  static String get manageRequests => _t('manageRequests');
  static String get selectTournamentRequired => _t('selectTournamentRequired');
  static String get myMatches => _t('myMatches');
  static String get myMatchesTournament => _t('myMatchesTournament');
  static String get noMatchesAreFound => _t('noMatchesAreFound');
  static String get manage => _t('manage');
  static String get downloadMatchReport => _t('downloadMatchReport');
  static String get liveMatches => _t('liveMatches');
  static String get liveMatchTournament => _t('liveMatchTournament');
  static String get noLiveMatchesAvailable => _t('noLiveMatchesAvailable');
  static String get startMatch => _t('startMatch');
  static String get abandonMatch => _t('abandonMatch');
  static String get saveAndPublish => _t('saveAndPublish');
  static String get matchStatus => _t('matchStatus');
  static String get goals => _t('goals');
  static String get cards => _t('cards');
  static String get substitution => _t('substitution');
  static String get ownGoal => _t('ownGoal');
  static String get penalty => _t('penalty');
  static String get penaltyMissed => _t('penaltyMissed');
  static String get minutesShort => _t('minutesShort');
  static String get selectScorer => _t('selectScorer');
  static String get selectAssist => _t('selectAssist');
  static String get selectPlayer => _t('selectPlayer');
  static String get firstCard => _t('firstCard');
  static String get secondCard => _t('secondCard');
  static String get redCardShort => _t('redCardShort');
  static String get playerIn => _t('playerIn');
  static String get playerOut => _t('playerOut');
  static String get selectInPlayer => _t('selectInPlayer');
  static String get selectOutPlayer => _t('selectOutPlayer');
  static String get ongoing => _t('ongoing');
  static String get upcoming => _t('upcoming');
  static String get closed => _t('closed');
  static String get myLeaguesCups => _t('myLeaguesCups');
  static String get today => _t('today');
  static String get noMatchForToday => _t('noMatchForToday');
  static String get pickup => _t('pickup');
  static String get oneOff => _t('oneOff');

  // ── Player / Club bio ─────────────────────────────────────────────────────
  static String get endorsements => _t('endorsements');
  static String get noEndorsementsYet => _t('noEndorsementsYet');
  static String get endorsedSuccessfully => _t('endorsedSuccessfully');
  static String get alreadyEndorsed => _t('alreadyEndorsed');
  static String get appearance => _t('appearance');
  static String get appearances => _t('appearances');
  static String get playerBio => _t('playerBio');
  static String get clubBio => _t('clubBio');
  static String get league => _t('league');
  static String get stadium => _t('stadium');
  static String get featuredPlayers => _t('featuredPlayers');
  static String get born => _t('born');
  static String get goalScored => _t('goalScored');
  static String get assists => _t('assists');
  static String get yellowCard => _t('yellowCard');
  static String get redCard => _t('redCard');
  static String get mvp => _t('mvp');
  static String get liked => _t('liked');
  static String get tapToLike => _t('tapToLike');
  static String get tapToFollow => _t('tapToFollow');
  static String get noPlayerJoinedYet => _t('noPlayerJoinedYet');

  // ── Teams ─────────────────────────────────────────────────────────────────
  static String get myTeams => _t('myTeams');
  static String get createTeam => _t('createTeam');
  static String get noTeamsFound => _t('noTeamsFound');
  static String get addPlayers => _t('addPlayers');

  // ── Clubs / Competitions ──────────────────────────────────────────────────
  static String get noClubsFound => _t('noClubsFound');
  static String get noTournamentsFound => _t('noTournamentsFound');
  static String get competitions => _t('competitions');
  static String get noCompetitionsFound => _t('noCompetitionsFound');
  static String get fas => _t('fas');
  static String get confederations => _t('confederations');
  static String get sponsors => _t('sponsors');
  static String get charitiesAndNgos => _t('charitiesAndNgos');

  // ── Posts / Gallery ───────────────────────────────────────────────────────
  static String get noPostsFound => _t('noPostsFound');
  static String get post => _t('post');
  static String get posts => _t('posts');
  static String get createPost => _t('createPost');
  static String get uploadImage => _t('uploadImage');
  static String get uploadVideo => _t('uploadVideo');
  static String get reportThisPost => _t('reportThisPost');
  static String get pleaseSelectACause => _t('pleaseSelectACause');
  static String get pleaseSelectAtLeastOneFilter =>
      _t('pleaseSelectAtLeastOneFilter');

  // ── Location ──────────────────────────────────────────────────────────────
  static String get location => _t('location');
  static String get selectLocation => _t('selectLocation');
  static String get ageGroup => _t('ageGroup');
  static String get game => _t('game');

  // ── Trial / Registration ──────────────────────────────────────────────────
  static String get register => _t('register');
  static String get registered => _t('registered');
  static String get liveTrialRegistration => _t('liveTrialRegistration');

  // ── Account ───────────────────────────────────────────────────────────────
  static String get deleteAccount => _t('deleteAccount');
  static String get deleteAccountConfirmation =>
      _t('deleteAccountConfirmation');
  static String get deactivateAccountConfirmation =>
      _t('deactivateAccountConfirmation');
  static String get downloadActivities => _t('downloadActivities');

  // ── Welcome ───────────────────────────────────────────────────────────────
  static String get welcomeBack => _t('welcomeBack');
  static String get weTrulyMissedYou => _t('weTrulyMissedYou');

  // ── Home feed / drawer ───────────────────────────────────────────────────
  static String get hello => _t('hello');
  static String get cheers => _t('cheers');
  static String get myBio => _t('myBio');
  static String get myPosts => _t('myPosts');
  static String get myRatings => _t('myRatings');
  static String get gallery => _t('gallery');
  static String get sharePostPrompt => _t('sharePostPrompt');
  static String get createPostUpper => _t('createPostUpper');
  static String get mostEndorsedPlayers => _t('mostEndorsedPlayers');
  static String get mostFollowedTeams => _t('mostFollowedTeams');
  static String get recentlyJoined => _t('recentlyJoined');
  static String get recentlyJoinedTeams => _t('recentlyJoinedTeams');
  static String get ongoingTournaments => _t('ongoingTournaments');
  static String get matchUpdates => _t('matchUpdates');
  static String get liveMatchUpdate => _t('liveMatchUpdate');
  static String get viewDetails => _t('viewDetails');
  static String get viewUpper => _t('viewUpper');
  static String get feedbackUpper => _t('feedbackUpper');
  static String get shareUpper => _t('shareUpper');
  static String get socaLocaUser => _t('socaLocaUser');
  static String get socaLocaIdLabel => _t('socaLocaIdLabel');
  static String get socaLocaIdCopied => _t('socaLocaIdCopied');
  static String get loadingProfilePleaseTryAgain =>
      _t('loadingProfilePleaseTryAgain');
  static String get skillDetail => _t('skillDetail');
  static String get people => _t('people');
  static String get likes => _t('likes');
  static String get cup => _t('cup');
  static String get fa => _t('fa');
  static String get fiveHours => _t('fiveHours');
  static String get aUser => _t('aUser');
  static String get checkHisBio => _t('checkHisBio');
  static String get checkTeamBio => _t('checkTeamBio');
  static String get checkTournamentDetails => _t('checkTournamentDetails');
  static String get jerseySize => _t('jerseySize');
  static String get teamFallback => _t('teamFallback');
  static String get tournamentFallback => _t('tournamentFallback');
  static String get unknownDate => _t('unknownDate');
  static String get tournamentDate => _t('tournamentDate');
  static String get tournamentVenue => _t('tournamentVenue');
  static String get totalNumberOfTeams => _t('totalNumberOfTeams');
  static String get numberOfPlayerPerTeam => _t('numberOfPlayerPerTeam');
  static String get noLimit => _t('noLimit');
  static String get am => _t('am');
  static String get pm => _t('pm');
  static String get trials => _t('trials');
  static String get updateProfile => _t('updateProfile');
  static String get changeLanguage => _t('changeLanguage');
  static String get helpDesk => _t('helpDesk');
  static String get privacySettings => _t('privacySettings');
  static String get helpUsToImprove => _t('helpUsToImprove');
  static String get dataPolicy => _t('dataPolicy');
  static String get termsAndConditions => _t('termsAndConditions');
  static String get signOutUpper => _t('signOutUpper');
  static String get academies => _t('academies');
  static String get menu => _t('menu');
  static String get retry => _t('retry');
  static String get ok => _t('ok');
  static String get block => _t('block');
  static String get blockUser => _t('blockUser');
  static String checkOutPostOnSocaLoca(String url) =>
      _t('checkOutPostOnSocaLoca').replaceFirst('{url}', url);
  static String userJoinedSocaLoca(String name) =>
      _t('userJoinedSocaLoca').replaceFirst('{name}', name);
  static String teamJoinedSocaLoca(String name) =>
      _t('teamJoinedSocaLoca').replaceFirst('{name}', name);
  static String tournamentIsLive(String name) =>
      _t('tournamentIsLive').replaceFirst('{name}', name);
  static String startedOn(String date) =>
      _t('startedOn').replaceFirst('{date}', date);
  static String monthShortName(int month) {
    const keys = [
      'monthJan',
      'monthFeb',
      'monthMar',
      'monthApr',
      'monthMay',
      'monthJun',
      'monthJul',
      'monthAug',
      'monthSep',
      'monthOct',
      'monthNov',
      'monthDec',
    ];
    if (month < 1 || month > keys.length) return '';
    return _t(keys[month - 1]);
  }

  static String get reportUser => _t('reportUser');
  static String get selectReason => _t('selectReason');
  static String get requestCancelled => _t('requestCancelled');
  static String get failedToSubmitEndorsement =>
      _t('failedToSubmitEndorsement');
  static String get requests => _t('requests');
  static String get noPendingRequests => _t('noPendingRequests');
  static String get noJoinedTeams => _t('noJoinedTeams');
  static String get pendingRequests => _t('pendingRequests');
  static String get teamInvitations => _t('teamInvitations');
  static String get noTeamInvitations => _t('noTeamInvitations');
  static String get accept => _t('accept');
  static String get decline => _t('decline');
  static String get joinedTeams => _t('joinedTeams');
  static String get noPostsYet => _t('noPostsYet');
  static String get noPosts => _t('noPosts');
  static String get noPlayers => _t('noPlayers');
  static String get matchNotFound => _t('matchNotFound');
  static String get tournamentNotFound => _t('tournamentNotFound');
  static String get requestSentSuccessfully => _t('requestSentSuccessfully');
  static String get matchHostedSuccessfully => _t('matchHostedSuccessfully');
  static String get pleaseTickCheckbox => _t('pleaseTickCheckbox');
  static String get verifiedSuccessfully => _t('verifiedSuccessfully');
  static String get pleaseSelectAtLeastOneRole =>
      _t('pleaseSelectAtLeastOneRole');
  static String get failedCreateProfile => _t('failedCreateProfile');
  static String get failedUpdateProfile => _t('failedUpdateProfile');
  static String get profileUpdatedSuccessfully =>
      _t('profileUpdatedSuccessfully');

  // ── Added from recent screens ──────────────────────────────────────────────
  static String get cannotHostMatch => _t('cannotHostMatch');
  static String get hostMatchRestriction => _t('hostMatchRestriction');
  static String get pickupMatchDescription => _t('pickupMatchDescription');
  static String get hostMatchUpper => _t('hostMatchUpper');
  static String get noUpcomingPickupMatches => _t('noUpcomingPickupMatches');
  static String get errorLoadingMatches => _t('errorLoadingMatches');
  static String get academiesDescription => _t('academiesDescription');
  static String get goUpper => _t('goUpper');
  static String get noAcademiesFound => _t('noAcademiesFound');
  static String get addTrainingSession => _t('addTrainingSession');
  static String get matchDetailsAdded => _t('matchDetailsAdded');
  static String addGameTypeMatch(String gameType) =>
      _t('addGameTypeMatch').replaceFirst('{gameType}', gameType);
  static String get goalsSavedRequired => _t('goalsSavedRequired');
  static String get goalsScoredRequired => _t('goalsScoredRequired');
  static String get egThree => _t('egThree');
  static String get egTwo => _t('egTwo');
  static String get goalsSaved => _t('goalsSaved');
  static String get egOne => _t('egOne');
  static String get egSixty => _t('egSixty');
  static String get egNinety => _t('egNinety');
  static String get teamName => _t('teamName');
  static String get opponentTeamName => _t('opponentTeamName');
  static String get describeHowYouPerformed => _t('describeHowYouPerformed');
  static String get videoLargerThanAvailableSpace =>
      _t('videoLargerThanAvailableSpace');
  static String get pleaseWriteSomething => _t('pleaseWriteSomething');
  static String get pleaseSelectAtLeastOnePhoto =>
      _t('pleaseSelectAtLeastOnePhoto');
  static String get pleaseSelectAVideo => _t('pleaseSelectAVideo');
  static String uploadingPhotoOf(int current, int total) =>
      _t('uploadingPhotoOf')
          .replaceFirst('{current}', '$current')
          .replaceFirst('{total}', '$total');
  static String get updatingPost => _t('updatingPost');
  static String get publishingPost => _t('publishingPost');
  static String get postUpdatedSuccessfully => _t('postUpdatedSuccessfully');
  static String get postPublishedSuccessfully =>
      _t('postPublishedSuccessfully');
  static String get writeSomething => _t('writeSomething');
  static String get tagPeopleUpper => _t('tagPeopleUpper');
  static String get postType => _t('postType');
  static String get choose => _t('choose');
  static String get notifyCoachesToEndorse => _t('notifyCoachesToEndorse');
  static String get invitePlayersUpper => _t('invitePlayersUpper');
  static String get updatePostUpper => _t('updatePostUpper');
  static String addPhotosCount(int current, int max) => _t('addPhotosCount')
      .replaceFirst('{current}', '$current')
      .replaceFirst('{max}', '$max');
  static String maxPhotosAllowed(int max) =>
      _t('maxPhotosAllowed').replaceFirst('{max}', '$max');
  static String get changeVideo => _t('changeVideo');
  static String get uploadVideos => _t('uploadVideos');
  static String get maxVideosAllowed => _t('maxVideosAllowed');
  static String get availableSpace => _t('availableSpace');
  static String get usedSpace => _t('usedSpace');
  static String get zeroMB => _t('zeroMB');
  static String get maxMB => _t('maxMB');
  static String get tagPlayers => _t('tagPlayers');
  static String get done => _t('done');
  static String get searchPlayersEllipsis => _t('searchPlayersEllipsis');

  // Fields that appear in older screens.
  static String get yourEmail => _t('yourEmail');
  static String get aboutMe => _t('aboutMe');
  static String get preferredJerseyNumber => _t('preferredJerseyNumber');
  static String get playingLevel => _t('playingLevel');
  static String get shirtJerseySize => _t('shirtJerseySize');
  static String get shoeSize => _t('shoeSize');
  static String get majorLeaguesYouFollow => _t('majorLeaguesYouFollow');
  static String get teamsYouFollow => _t('teamsYouFollow');
  static String get takePhotoUpper => _t('takePhotoUpper');
  static String get chooseGalleryUpper => _t('chooseGalleryUpper');
  static String get removePhoto => _t('removePhoto');
  static String get selectNationality => _t('selectNationality');
  static String get firstNameRequiredLower => _t('firstNameRequiredLower');
  static String get lastNameRequiredLower => _t('lastNameRequiredLower');
  static String get profileNameRequiredLower => _t('profileNameRequiredLower');
  static String get selectRoleRequired => _t('selectRoleRequired');
  static String get nationalityRequired => _t('nationalityRequired');
  static String get max300Characters => _t('max300Characters');
  static String get valueInCm => _t('valueInCm');
  static String get brandsYouLike => _t('brandsYouLike');
  static String get chooseYourAvatar => _t('chooseYourAvatar');
  static String get byClickingSubmitPolicy => _t('byClickingSubmitPolicy');
  static String get select => _t('select');
  static String get selectLocationFromMap => _t('selectLocationFromMap');
  static String get zeroToNinetyNine => _t('zeroToNinetyNine');
  static String get playerRole => _t('playerRole');
  static String get fan => _t('fan');
  static String get referee => _t('referee');
  static String get genderPlain => _t('genderPlain');
  static String get dateOfBirthRequired => _t('dateOfBirthRequired');
  static String get playingPositionPlain => _t('playingPositionPlain');
  static String get playingLevelRequired => _t('playingLevelRequired');

  // ── Auth — age/consent ───────────────────────────────────────────────────
  static String get iAmOver => _t('iAmOver');
  static String get iAm => _t('iAm');
  static String get sixteenYears => _t('sixteenYears');
  static String get thirteenToFifteenYears => _t('thirteenToFifteenYears');
  static String get sevenToTwelve => _t('sevenToTwelve');
  static String get years => _t('years');
  static String get yearsTitle => _t('yearsTitle');
  static String get old => _t('old');
  static String get parentGuardianRegisteringOnBehalf =>
      _t('parentGuardianRegisteringOnBehalf');
  static String get thankYouForJoining => _t('thankYouForJoining');
  static String get createProfileToGetStarted =>
      _t('createProfileToGetStarted');
  static String get createProfileUpper => _t('createProfileUpper');
  static String get childConsentIntro => _t('childConsentIntro');
  static String get fillFieldsAndTickCheckbox =>
      _t('fillFieldsAndTickCheckbox');
  static String get childGuardianConfirmation =>
      _t('childGuardianConfirmation');
  static String get childsNameRequired => _t('childsNameRequired');
  static String get parentGuardianNameRequired =>
      _t('parentGuardianNameRequired');
  static String get parentGuardianEmailRequired =>
      _t('parentGuardianEmailRequired');
  static String get minorConsentText => _t('minorConsentText');
  static String get pleaseEnterMinorName => _t('pleaseEnterMinorName');
  static String get pleaseEnterParentGuardianName =>
      _t('pleaseEnterParentGuardianName');
  static String get pleaseEnterParentEmail => _t('pleaseEnterParentEmail');
  static String get pleaseEnterValidParentEmail =>
      _t('pleaseEnterValidParentEmail');
  static String get youthConsentIntro => _t('youthConsentIntro');
  static String get youthGuardianConfirmation =>
      _t('youthGuardianConfirmation');
  static String get clubName => _t('clubName');
  static String get enterClubName => _t('enterClubName');
  static String get enterClubEmail => _t('enterClubEmail');
  static String get pleaseEnterClubName => _t('pleaseEnterClubName');
  static String get pleaseSelectCountry => _t('pleaseSelectCountry');
  static String get pleaseSelectConfederation =>
      _t('pleaseSelectConfederation');
  static String get pleaseSelectLeague => _t('pleaseSelectLeague');
  static String get pleaseEnterContactName => _t('pleaseEnterContactName');
  static String get pleaseEnterContactNumber => _t('pleaseEnterContactNumber');
  static String get emailAlreadyRegistered => _t('emailAlreadyRegistered');
  static String get joiningRequestThanks => _t('joiningRequestThanks');
  static String get redirectsToSocalocaFootball =>
      _t('redirectsToSocalocaFootball');
  static String get gotItUpper => _t('gotItUpper');
  static String get autoPopulatedFromCountry => _t('autoPopulatedFromCountry');
  static String get selectCountryFirst => _t('selectCountryFirst');
  static String get selectCountryRequired => _t('selectCountryRequired');
  static String get selectLeagueRequired => _t('selectLeagueRequired');
  static String get enterContactName => _t('enterContactName');
  static String get enterContactNumber => _t('enterContactNumber');
  static String get aPlayer => _t('aPlayer');
  static String get aCoach => _t('aCoach');
  static String get aManager => _t('aManager');
  static String get aReferee => _t('aReferee');
  static String get aFan => _t('aFan');
  static String get aProfessionalClub => _t('aProfessionalClub');
  static String get pleaseEnterAllFourDigits => _t('pleaseEnterAllFourDigits');
  static String get pinCannotBeSameDigits => _t('pinCannotBeSameDigits');
  static String get pinCannotBeSequential => _t('pinCannotBeSequential');
  static String get parentalPinInfo => _t('parentalPinInfo');
  static String get parentGuardianPhoneRequired =>
      _t('parentGuardianPhoneRequired');
  static String get pleaseEnterMobileNumber => _t('pleaseEnterMobileNumber');
  static String get youthConsentTitle => _t('youthConsentTitle');
  static String get likingAndFollowing => _t('likingAndFollowing');
  static String get uploadingPhotosVideos => _t('uploadingPhotosVideos');
  static String get parentalControlConsent => _t('parentalControlConsent');
  static String get registerAsClub => _t('registerAsClub');
  static String get emailOrSocaLocaId => _t('emailOrSocaLocaId');
  static String get emailOrSocaLocaIdRequired =>
      _t('emailOrSocaLocaIdRequired');
  static String get pleaseEnterEmailOrSocaLocaId =>
      _t('pleaseEnterEmailOrSocaLocaId');
  static String get pleaseEnterValidEmailOrSocaLocaId =>
      _t('pleaseEnterValidEmailOrSocaLocaId');
  static String get invalidCredentials => _t('invalidCredentials');

  // ── Teams ─────────────────────────────────────────────────────────────────
  static String get warning => _t('warning');
  static String get confirmEndMatch => _t('confirmEndMatch');
  static String get jerseysAssigned => _t('jerseysAssigned');
  static String get inviteSent => _t('inviteSent');
  static String get enterAtLeast3Chars => _t('enterAtLeast3Chars');
  static String get noPlayersFound => _t('noPlayersFound');
  static String get failedToLoadPlayers => _t('failedToLoadPlayers');
  static String get failedToLoadTeams => _t('failedToLoadTeams');
  static String get failedToLoadTeamBio => _t('failedToLoadTeamBio');
  static String get noTeamDataAvailable => _t('noTeamDataAvailable');
  static String get unknownTeam => _t('unknownTeam');
  static String get thisTeamIsArchived => _t('thisTeamIsArchived');
  static String get requestPendingUpper => _t('requestPendingUpper');
  static String get requestSent => _t('requestSent');
  static String get sendRequestUpper => _t('sendRequestUpper');
  static String get tryAdjustingYourFilters => _t('tryAdjustingYourFilters');
  static String get noMatchesPlayedYet => _t('noMatchesPlayedYet');
  static String get fullTime => _t('fullTime');
  static String get fullTimeTitle => _t('fullTimeTitle');
  static String get firstHalf => _t('firstHalf');
  static String get secondHalf => _t('secondHalf');
  static String get breakBeforeEt => _t('breakBeforeEt');
  static String get etFirstHalf => _t('etFirstHalf');
  static String get etHalfTime => _t('etHalfTime');
  static String get etSecondHalf => _t('etSecondHalf');
  static String get afterExtraTime => _t('afterExtraTime');
  static String get ratingLabel => _t('ratingLabel');
  static String get allTemasLabel => _t('allTemasLabel');
  static String get requiredField => _t('requiredField');
  static String get teamWork => _t('teamWork');
  static String get technical => _t('technical');
  static String get aggressiveness => _t('aggressiveness');
  static String get tactical => _t('tactical');
  static String get overallRating => _t('overallRating');
  static String get teamOne => _t('teamOne');
  static String get teamTwo => _t('teamTwo');
  static String get vsLower => _t('vsLower');
  static String get tournamentType => _t('tournamentType');
  static String get venue => _t('venue');
  static String get notes => _t('notes');
  static String get description => _t('description');
  static String get prizes => _t('prizes');
  static String get registrationFees => _t('registrationFees');
  static String get organizerDetails => _t('organizerDetails');
  static String get viewTournamentDetails => _t('viewTournamentDetails');
  static String get matchManagement => _t('matchManagement');
  static String get vs => _t('vs');
  static String get noPointsTableAvailable => _t('noPointsTableAvailable');
  static String get noDataAvailable => _t('noDataAvailable');
  static String get add => _t('add');
  static String get addCard => _t('addCard');
  static String get noCardsRecorded => _t('noCardsRecorded');
  static String get tapAddCards => _t('tapAddCards');
  static String get cardType => _t('cardType');
  static String get yellow => _t('yellow');
  static String get red => _t('red');
  static String get playerName => _t('playerName');
  static String get example45 => _t('example45');
  static String get example23 => _t('example23');
  static String get deleteCard => _t('deleteCard');
  static String get deleteGoal => _t('deleteGoal');
  static String get deleteCardConfirmation => _t('deleteCardConfirmation');
  static String get deleteGoalConfirmation => _t('deleteGoalConfirmation');
  static String get currentManOfMatch => _t('currentManOfMatch');
  static String get noMvpSelected => _t('noMvpSelected');
  static String get tapSelectMvp => _t('tapSelectMvp');
  static String get selectManOfMatch => _t('selectManOfMatch');
  static String get clearMvp => _t('clearMvp');
  static String get clearMvpConfirmation => _t('clearMvpConfirmation');
  static String get clear => _t('clear');
  static String get addGoal => _t('addGoal');
  static String get noGoalsRecorded => _t('noGoalsRecorded');
  static String get tapAddGoals => _t('tapAddGoals');
  static String get success => _t('success');
  static String get saveSquad => _t('saveSquad');
  static String get startingXi => _t('startingXi');
  static String get substitutes => _t('substitutes');
  static String get addStartingPlayer => _t('addStartingPlayer');
  static String get addSubstitute => _t('addSubstitute');
  static String get noKnockoutMatchesYet => _t('noKnockoutMatchesYet');
  static String get noGroupsAvailable => _t('noGroupsAvailable');
  static String get selectGroup => _t('selectGroup');
  static String get viewGroupStandings => _t('viewGroupStandings');
  static String get groupNotFound => _t('groupNotFound');
  static String get noMatchesInThisGroup => _t('noMatchesInThisGroup');
  static String get noEligibleTeams => _t('noEligibleTeams');
  static String get noEligibleTeamsTournament =>
      _t('noEligibleTeamsTournament');
  static String get noEligibleTeamsCup => _t('noEligibleTeamsCup');
  static String get selectTeam => _t('selectTeam');
  static String get tournamentStats => _t('tournamentStats');
  static String get noRoundsAvailable => _t('noRoundsAvailable');
  static String noStatRecordedYet(String label) =>
      _t('noStatRecordedYet').replaceFirst('{label}', label);
  static String get groupStandings => _t('groupStandings');
  static String get noStandingsAvailable => _t('noStandingsAvailable');
  static String get errorLoadingStandings => _t('errorLoadingStandings');
  static String get pointsHash => _t('pointsHash');
  static String get pointsPlayed => _t('pointsPlayed');
  static String get pointsWon => _t('pointsWon');
  static String get pointsDrawn => _t('pointsDrawn');
  static String get pointsLost => _t('pointsLost');
  static String get goalsFor => _t('goalsFor');
  static String get goalsAgainst => _t('goalsAgainst');
  static String get goalDifference => _t('goalDifference');
  static String get pointsShort => _t('pointsShort');
  static String get requestToJoin => _t('requestToJoin');
  static String get requestToJoinCup => _t('requestToJoinCup');
  static String get pendingInvitations => _t('pendingInvitations');
  static String get viewItinerary => _t('viewItinerary');
  static String get itinerary => _t('itinerary');
  static String get close => _t('close');
  static String get cupTournamentNotFound => _t('cupTournamentNotFound');
  static String get statsUpper => _t('statsUpper');
  static String get selectRound => _t('selectRound');
  static String get noGroupRoundAvailable => _t('noGroupRoundAvailable');
  static String get noKnockoutRoundAvailable => _t('noKnockoutRoundAvailable');
  static String get accessRestricted => _t('accessRestricted');
  static String get matchManageRestricted => _t('matchManageRestricted');
  static String get noMatches => _t('noMatches');
  static String get noMatchesAvailableForManagement =>
      _t('noMatchesAvailableForManagement');
  static String get manageMatch => _t('manageMatch');
  static String get tournamentsIntro => _t('tournamentsIntro');
  static String get selectManOfMatchHint => _t('selectManOfMatchHint');
  static String get scoreEntryHint => _t('scoreEntryHint');
  static String addStartingOrSubstitutePlayer(bool isStarting) =>
      _t('addStartingOrSubstitutePlayer').replaceFirst(
          '{type}', isStarting ? _t('starting') : _t('substitute'));
  static String errorLoadingTournament(Object error) =>
      _t('errorLoadingTournament').replaceFirst('{error}', '$error');
  static String errorLoadingStandingsWithError(Object error) =>
      _t('errorLoadingStandingsWithError').replaceFirst('{error}', '$error');
  static String errorLoadingStats(Object error) =>
      _t('errorLoadingStats').replaceFirst('{error}', '$error');
  static String errorLoadingBracket(Object error) =>
      _t('errorLoadingBracket').replaceFirst('{error}', '$error');
  static String errorLoadingMatchesWithError(Object error) =>
      _t('errorLoadingMatchesWithError').replaceFirst('{error}', '$error');
  static String errorLoadingDetails(Object error) =>
      _t('errorLoadingDetails').replaceFirst('{error}', '$error');
  static String errorLoadingCup(Object error) =>
      _t('errorLoadingCup').replaceFirst('{error}', '$error');
  static String get invitationSentAll => _t('invitationSentAll');
  static String get profileNameNotAvailable => _t('profileNameNotAvailable');
  static String get selectYear => _t('selectYear');
  static String get camera => _t('camera');
  static String get teamInfoUpdated => _t('teamInfoUpdated');
  // Tab labels
  static String get pom => _t('pom');
  static String get score => _t('score');
  static String get squad => _t('squad');
  static String get pointsTable => _t('pointsTable');
  static String get stats => _t('stats');
  static String get groupStage => _t('groupStage');
  static String get knockout => _t('knockout');
  static String get manOfMatch => _t('manOfMatch');
  static String get searchAndInvite => _t('searchAndInvite');
  static String get inviteByPhone => _t('inviteByPhone');
  static String get createPlayer => _t('createPlayer');
  static String get all => _t('all');
  static String get joined => _t('joined');
  static String get pending => _t('pending');
  static String get received => _t('received');
  static String get newRequests => _t('newRequests');
  static String get newPlayers => _t('newPlayers');
  static String get jerseyAssigned => _t('jerseyAssigned');
  // Form hints
  static String get phoneNumber => _t('phoneNumber');
  static String get jerseyNumberHint => _t('jerseyNumberHint');
  static String get enterTextHint => _t('enterTextHint');
  static String get mobileNumber => _t('mobileNumber');
  static String get countryCode => _t('countryCode');
  static String get countryIso => _t('countryIso');
  static String get otp => _t('otp');
  static String get searchHere => _t('searchHere');
  static String get passwordHint => _t('passwordHint');
  // Edit team screen
  static String get selectPhoto => _t('selectPhoto');
  static String get gameType => _t('gameType');
  static String get football => _t('football');
  static String get futsal => _t('futsal');
  static String get ageRange => _t('ageRange');
  static String get ageCategory => _t('ageCategory');
  static String get updateTeam => _t('updateTeam');
  // static String get teamName => _t('teamName');
  static String get shortNameHint => _t('shortNameHint');
  static String get cityAddress => _t('cityAddress');
  static String get selectAgeRange => _t('selectAgeRange');
  static String get selectAgeCategory => _t('selectAgeCategory');
  static String get teamNameRequired => _t('teamNameRequired');

  // Referee manage match
  static String get failedToLoadMatchDetails => _t('failedToLoadMatchDetails');
  static String get pleaseEnterScoreProperly => _t('pleaseEnterScoreProperly');
  static String get pleaseEnterExtraTimeDetails =>
      _t('pleaseEnterExtraTimeDetails');
  static String get pleaseEnterPenaltyDetails =>
      _t('pleaseEnterPenaltyDetails');
  static String get matchScoreSaved => _t('matchScoreSaved');
  static String get extraTime => _t('extraTime');
  static String get time => _t('time');
  static String get scorer => _t('scorer');
  static String get noOfCards => _t('noOfCards');
  static String get player => _t('player');
  static String get pleaseSelectPom => _t('pleaseSelectPom');
  static String get coach => _t('coach');
  static String get manager => _t('manager');
  static String get pleaseSelectPlayersFromBothTeams =>
      _t('pleaseSelectPlayersFromBothTeams');
  static String get minute => _t('minute');
  static String get pleaseEnterSubstituteDetails =>
      _t('pleaseEnterSubstituteDetails');
  static String get matchIncidents => _t('matchIncidents');
  static String get enterTextMax200 => _t('enterTextMax200');
  static String get matchCommissionerReport => _t('matchCommissionerReport');
  static String get enterTextMax300 => _t('enterTextMax300');
  static String get commissionerReportSaved => _t('commissionerReportSaved');
  static String get uploadMatchPhotos => _t('uploadMatchPhotos');
  static String get savePhotos => _t('savePhotos');
  static String get uploadMatchHighlights => _t('uploadMatchHighlights');
  static String get saveHighlights => _t('saveHighlights');
  static String get uploadMatchVideos => _t('uploadMatchVideos');
  static String get saveVideos => _t('saveVideos');
  static String get maxPhotosUpload => _t('maxPhotosUpload');
  static String get uploadingPhoto => _t('uploadingPhoto');
  static String get maxVideoSizeUpload => _t('maxVideoSizeUpload');
  static String get uploadingHighlight => _t('uploadingHighlight');
  static String get maxVideosUpload => _t('maxVideosUpload');
  static String get uploadingVideo => _t('uploadingVideo');
  static String get pleaseSelectMp4OrMov => _t('pleaseSelectMp4OrMov');
  static String get pleaseEnterGoalDetails => _t('pleaseEnterGoalDetails');
  static String get pleaseEnterCardDetails => _t('pleaseEnterCardDetails');
  static String get officialsProgressSaved => _t('officialsProgressSaved');
  static String get noMembersAvailable => _t('noMembersAvailable');
  static String get matchDetails => _t('matchDetails');
  static String get matchDate => _t('matchDate');
  static String get matchTime => _t('matchTime');
  static String get tbd => _t('tbd');
  static String get videoPublishedToFeed => _t('videoPublishedToFeed');
  static String get uploadComplete => _t('uploadComplete');
  static String get round => _t('round');

  // Academies
  static String get academyNotFound => _t('academyNotFound');
  static String get joiningRequestSent => _t('joiningRequestSent');
  static String get director => _t('director');
  static String get foundedYear => _t('foundedYear');
  static String get academyJoined => _t('academyJoined');
  static String get cancelRequest => _t('cancelRequest');
  static String get sendRequest => _t('sendRequest');
  static String get cat => _t('cat');
  static String get about => _t('about');
  static String get bio => _t('bio');
  static String get academyDirector => _t('academyDirector');
  static String get academyManager => _t('academyManager');
  static String get academyContactNumber => _t('academyContactNumber');
  static String get academyContactEmail => _t('academyContactEmail');
  static String get skillVideos => _t('skillVideos');
  static String get matchVideos => _t('matchVideos');
  static String get academyNews => _t('academyNews');
  static String get registrationSuccessful => _t('registrationSuccessful');
  static String get registrationFailed => _t('registrationFailed');
  static String get emailIsRequired => _t('emailIsRequired');
  static String get enterValidEmailAddress => _t('enterValidEmailAddress');
  static String get category => _t('category');

  // Live Match
  static String get substitutions => _t('substitutions');
  static String get penaltyShootout => _t('penaltyShootout');
  static String get lineUp => _t('lineUp');
  static String get goalkeepers => _t('goalkeepers');
  static String get defenders => _t('defenders');
  static String get midfielders => _t('midfielders');
  static String get attackers => _t('attackers');
  static String get ogShort => _t('ogShort');
  static String get penShort => _t('penShort');
  static String get assist => _t('assist');
  static String get missed => _t('missed');

  // My Bio
  static String get myStats => _t('myStats');
  static String get ratings => _t('ratings');
  static String get minimumFiveCharsRequired => _t('minimumFiveCharsRequired');
  // static String get minimumFiveCharacters => _t('minimumFiveCharacters');
  static String get pleaseSelectDateOfBirth => _t('pleaseSelectDateOfBirth');
  static String get dateOfBirthPlaceholder => _t('dateOfBirthPlaceholder');
  static String get editPost => _t('editPost');
  static String get deletePost => _t('deletePost');
  static String get deletePostConfirm => _t('deletePostConfirm');
  static String get postDeleted => _t('postDeleted');
  static String get couldNotDeletePost => _t('couldNotDeletePost');
  static String get unknown => _t('unknown');
  static String get failedToLoadRatings => _t('failedToLoadRatings');
  static String get overallScoreMultiline => _t('overallScoreMultiline');
  static String get skillAttributeRating => _t('skillAttributeRating');
  static String get ratingLegendDescription => _t('ratingLegendDescription');
  static String get physical => _t('physical');
  static String get mental => _t('mental');
  static String get goalkeeper => _t('goalkeeper');
  static String get userNotLoggedIn => _t('userNotLoggedIn');
  static String get profileNotFound => _t('profileNotFound');
  static String get myActivities => _t('myActivities');
  static String get myActivitiesDescription => _t('myActivitiesDescription');
  static String get cleanSheetRequiredLower => _t('cleanSheetRequiredLower');
  static String get goalsScoredRequiredLower => _t('goalsScoredRequiredLower');
  static String get cleanSheetsLower => _t('cleanSheetsLower');
  static String get goalsScoredLower => _t('goalsScoredLower');
  static String pleaseEnterMatchMetric(String metric) =>
      _t('pleaseEnterMatchMetric').replaceFirst('{metric}', metric);
  static String enterField(String field) =>
      _t('enterField').replaceFirst('{field}', field);
  static String get tagPlayersUpper => _t('tagPlayersUpper');
  static String get searchByNameMinTwoCharacters =>
      _t('searchByNameMinTwoCharacters');
  static String get endorsementsDescription => _t('endorsementsDescription');
  static String get reject => _t('reject');
  static String get publish => _t('publish');
  static String get doubleTapToCheer => _t('doubleTapToCheer');
  static String cheerCount(int count) =>
      _t('cheerCount').replaceFirst('{count}', '$count');
  static String get failedToUpdateProfileTryAgain =>
      _t('failedToUpdateProfileTryAgain');
  static String get updateUpper => _t('updateUpper');
  static String get savingEllipsis => _t('savingEllipsis');
  static String get trainingSession => _t('trainingSession');
  static String get gameTypeLabel => _t('gameTypeLabel');
  static String get matchDateLabel => _t('matchDateLabel');
  static String get selectDate => _t('selectDate');
  static String get playingPositionLabel => _t('playingPositionLabel');
  static String get positionTypeLabel => _t('positionTypeLabel');
  static String get numberOfAssistsLabel => _t('numberOfAssistsLabel');
  static String get minutesPlayedLabel => _t('minutesPlayedLabel');
  static String get teamsPlayedLabel => _t('teamsPlayedLabel');
  static String get teamA => _t('teamA');
  static String get teamB => _t('teamB');
  static String get teamALabel => _t('teamALabel');
  static String get teamBLabel => _t('teamBLabel');
  static String get rateYourPerformanceLabel => _t('rateYourPerformanceLabel');
  static String get howIPerformedLabel => _t('howIPerformedLabel');
  static String get trainingSessionDateLabel => _t('trainingSessionDateLabel');
  static String get trainingSessionTypeLabel => _t('trainingSessionTypeLabel');
  static String get trainingSessionMinutesLabel =>
      _t('trainingSessionMinutesLabel');
  static String get trainingNotesLabel => _t('trainingNotesLabel');
  static String get typeToSearchPlayers => _t('typeToSearchPlayers');
  static String get userFallback => _t('userFallback');
  static String get pleaseSelectMatchDate => _t('pleaseSelectMatchDate');
  static String get pleaseRateYourPerformance =>
      _t('pleaseRateYourPerformance');
  static String get pleaseEnterMinutesPlayed => _t('pleaseEnterMinutesPlayed');
  static String get matchActivityAdded => _t('matchActivityAdded');
  static String get failedToAddMatch => _t('failedToAddMatch');
  static String get pleaseSelectTrainingDate => _t('pleaseSelectTrainingDate');
  static String get pleaseEnterTrainingMinutes =>
      _t('pleaseEnterTrainingMinutes');
  static String get trainingSessionAdded => _t('trainingSessionAdded');
  static String get failedToAddTraining => _t('failedToAddTraining');
  static String get pleaseSelectPlayingPosition =>
      _t('pleaseSelectPlayingPosition');
  static String get pleaseSelectPositionType => _t('pleaseSelectPositionType');
  static String get selectMatchDate => _t('selectMatchDate');
  static String get selectPlayingPosition => _t('selectPlayingPosition');
  static String get selectPositionType => _t('selectPositionType');
  static String get myTeamNameLabel => _t('myTeamNameLabel');
  static String get enterYourTeamName => _t('enterYourTeamName');
  static String get opponentTeamNameLabel => _t('opponentTeamNameLabel');
  static String get enterOpponentTeamName => _t('enterOpponentTeamName');
  static String get pleaseSelectTrainingType => _t('pleaseSelectTrainingType');
  static String get trainingDateLabel => _t('trainingDateLabel');
  static String get selectTrainingDate => _t('selectTrainingDate');
  static String get trainingTypeLabel => _t('trainingTypeLabel');
  static String get selectTrainingType => _t('selectTrainingType');
  static String get trainingMinutesLabel => _t('trainingMinutesLabel');
  static String get enterTrainingMinutes => _t('enterTrainingMinutes');
  static String get notesOptionalLabel => _t('notesOptionalLabel');
  static String get describeTrainingSession => _t('describeTrainingSession');
  static String get videos => _t('videos');
  static String get photos => _t('photos');
  static String get skillVideo => _t('skillVideo');
  static String get skillVideoDescription => _t('skillVideoDescription');
  static String get footballMoments => _t('footballMoments');
  static String get footballMomentsDescription =>
      _t('footballMomentsDescription');
  static String get typeAtLeast2CharsToSearch =>
      _t('typeAtLeast2CharsToSearch');
  static String get uploadingEllipsis => _t('uploadingEllipsis');

  // ── Referee screens ──────────────────────────────────────────────────────
  static String get startSecondHalf => _t('startSecondHalf');
  static String get startExtraTime => _t('startExtraTime');
  static String get startPenalty => _t('startPenalty');
  static String get matchEndedSuccessfully => _t('matchEndedSuccessfully');
  static String get selectScorerFromOneTeam => _t('selectScorerFromOneTeam');
  static String get pleaseSelectScorer => _t('pleaseSelectScorer');
  static String get selectCardHolderFromOneTeam =>
      _t('selectCardHolderFromOneTeam');
  static String get pleaseSelectCardHolder => _t('pleaseSelectCardHolder');
  static String get pleaseSelectCardType => _t('pleaseSelectCardType');
  static String get pleaseSelectCardTime => _t('pleaseSelectCardTime');
  static String get selectSubstitutionFromOneTeam =>
      _t('selectSubstitutionFromOneTeam');
  static String get pleaseSelectPlayersForSubstitution =>
      _t('pleaseSelectPlayersForSubstitution');
  static String get pleaseSelectPlayerInForMyTeam =>
      _t('pleaseSelectPlayerInForMyTeam');
  static String get pleaseSelectPlayerInForOpponent =>
      _t('pleaseSelectPlayerInForOpponent');
  static String get pleaseSelectPlayerOutForMyTeam =>
      _t('pleaseSelectPlayerOutForMyTeam');
  static String get pleaseSelectPlayerOutForOpponent =>
      _t('pleaseSelectPlayerOutForOpponent');
  static String get playerInAndOutSame => _t('playerInAndOutSame');
  static String get pleaseEnterSubstitutionTime =>
      _t('pleaseEnterSubstitutionTime');
  static String get eventTimeTooLarge => _t('eventTimeTooLarge');
  static String get halfTime => _t('halfTime');
  static String get endSecondHalf => _t('endSecondHalf');
  static String get endExtraTime => _t('endExtraTime');
  static String get endMatch => _t('endMatch');
  static String get postponed => _t('postponed');
  static String get abandoned => _t('abandoned');
  static String get liveMatchUpdates => _t('liveMatchUpdates');
  static String get caution => _t('caution');
  static String get neverCloseAppDuringMatch => _t('neverCloseAppDuringMatch');
  static String get tapSaveAndPublishWhenSure =>
      _t('tapSaveAndPublishWhenSure');
  static String get matchEnd => _t('matchEnd');
  static String get goal => _t('goal');
  static String get myRequests => _t('myRequests');
  static String get myRequestsDescription => _t('myRequestsDescription');
  static String get noPendingMatchRequests => _t('noPendingMatchRequests');
  static String get requestAccepted => _t('requestAccepted');
  static String get requestDeclined => _t('requestDeclined');

  // ── Social Feed ──────────────────────────────────────────────────────────
  static String get reportPost => _t('reportPost');
  static String get blockPost => _t('blockPost');
  static String get pleaseSelectReason => _t('pleaseSelectReason');
  static String get blockUserDescription => _t('blockUserDescription');
  static String get reportSubmittedThankYou => _t('reportSubmittedThankYou');
  static String get failedToReportPost => _t('failedToReportPost');
  static String get postBlocked => _t('postBlocked');
  static String get failedToBlockPost => _t('failedToBlockPost');
  static String get userBlocked => _t('userBlocked');
  static String get failedToBlockUser => _t('failedToBlockUser');
  static String get failedToReportUser => _t('failedToReportUser');

  // ── Pickup Match ──────────────────────────────────────────────────────────
  static String get pleaseSelectStartTime => _t('pleaseSelectStartTime');
  static String get pleaseSelectEndTime => _t('pleaseSelectEndTime');
  static String get endTimeMustBeAfterStartTime =>
      _t('endTimeMustBeAfterStartTime');
  static String get pleaseSelectAgeGroup => _t('pleaseSelectAgeGroup');
  static String get pleaseSelectLocation => _t('pleaseSelectLocation');
  static String get userNotFound => _t('userNotFound');
  static String get failedToHostMatch => _t('failedToHostMatch');
  static String get startTimeRequired => _t('startTimeRequired');
  static String get endTimeRequired => _t('endTimeRequired');
  static String get venueNameRequired => _t('venueNameRequired');
  static String get venueNameIsRequired => _t('venueNameIsRequired');
  static String get venueNameMinLength => _t('venueNameMinLength');
  static String get selectLocationFromMapRequired =>
      _t('selectLocationFromMapRequired');
  static String get maxPlayersRequired => _t('maxPlayersRequired');
  static String get maxPlayersIsRequired => _t('maxPlayersIsRequired');
  static String get mustBePositiveNumber => _t('mustBePositiveNumber');
  static String get matchNoteHint => _t('matchNoteHint');
  static String get errorLoadingMatchDetails => _t('errorLoadingMatchDetails');
  static String get failedToSendRequest => _t('failedToSendRequest');
  static String get maxPlayers => _t('maxPlayers');
  static String get date => _t('date');
  static String get host => _t('host');
  static String get viewRequestsUpper => _t('viewRequestsUpper');
  static String get acceptedUpper => _t('acceptedUpper');
  static String get declinedUpper => _t('declinedUpper');
  static String get errorLoadingRequests => _t('errorLoadingRequests');
  static String get failedToUpdateRequest => _t('failedToUpdateRequest');
  static String get noRequestsYet => _t('noRequestsYet');
  static String get accepted => _t('accepted');
  static String get declined => _t('declined');

  // ── Settings ─────────────────────────────────────────────────────────────
  static String get newPasswordMinLength => _t('newPasswordMinLength');
  static String get newPasswordSameAsCurrent => _t('newPasswordSameAsCurrent');
  static String get passwordsDoNotMatch => _t('passwordsDoNotMatch');
  static String get userSessionNotFound => _t('userSessionNotFound');
  static String get failedToChangePassword => _t('failedToChangePassword');
  static String get somethingWentWrongTryAgain =>
      _t('somethingWentWrongTryAgain');
  static String get currentPasswordHint => _t('currentPasswordHint');
  static String get newPasswordHint => _t('newPasswordHint');
  static String get confirmPasswordHint => _t('confirmPasswordHint');
  static String get pleaseEnterName => _t('pleaseEnterName');
  static String get thisIsYourOwnEmail => _t('thisIsYourOwnEmail');
  static String get legacyContactDescription => _t('legacyContactDescription');
  static String get legacyContactInstruction => _t('legacyContactInstruction');
  static String get nameRequired => _t('nameRequired');
  static String get aboutSocaLoca => _t('aboutSocaLoca');
  static String get aboutSocaLocaText => _t('aboutSocaLocaText');
  static String get couldNotOpenLink => _t('couldNotOpenLink');
  static String get gdprComplianceText => _t('gdprComplianceText');
  static String get downloadActivityEmailInstructions =>
      _t('downloadActivityEmailInstructions');
  static String get pleaseEnterValidEmailAddress =>
      _t('pleaseEnterValidEmailAddress');
  static String get deactivateDeleteAccount => _t('deactivateDeleteAccount');
  static String get sorryToSeeYouLeave => _t('sorryToSeeYouLeave');
  static String get deleteOrDeactivateChoice => _t('deleteOrDeactivateChoice');
  static String get deletionDescription => _t('deletionDescription');
  static String get deactivationDescription => _t('deactivationDescription');
  static String get accountSubmittedForDeletion =>
      _t('accountSubmittedForDeletion');
  static String get accountDeactivated => _t('accountDeactivated');
  static String get noUpper => _t('noUpper');
  static String get yesUpper => _t('yesUpper');
  static String get legacyContact => _t('legacyContact');
  static String get manageAccount => _t('manageAccount');
  static String get deactivateDeleteAccountSubItem =>
      _t('deactivateDeleteAccountSubItem');
  static String get dataPrivacy => _t('dataPrivacy');

  // ── Club / partners screens ──────────────────────────────────────────────
  static String get clubsPartnerIntro => _t('clubsPartnerIntro');
  static String get footballAssociationsIntro =>
      _t('footballAssociationsIntro');
  static String get footballConfederationsIntro =>
      _t('footballConfederationsIntro');
  static String get sponsorsIntro => _t('sponsorsIntro');
  static String get charitiesNgosIntro => _t('charitiesNgosIntro');
  static String get errorLoadingClubs => _t('errorLoadingClubs');
  static String get noFasFound => _t('noFasFound');
  static String get noConfederationsFound => _t('noConfederationsFound');
  static String get noSponsorsFound => _t('noSponsorsFound');
  static String get noCharitiesNgosFound => _t('noCharitiesNgosFound');
  static String get confederation => _t('confederation');
  static String get confderations => _t('confderations');
  static String get clubNotFound => _t('clubNotFound');
  static String get faNotFound => _t('faNotFound');
  static String get sponsorNotFound => _t('sponsorNotFound');
  static String get charityNotFound => _t('charityNotFound');
  static String get couldNotLoadClubData => _t('couldNotLoadClubData');
  static String get nickname => _t('nickname');
  static String get formed => _t('formed');
  static String get formedIn => _t('formedIn');
  static String get city => _t('city');
  static String get fifaIdLabel => _t('fifaIdLabel');
  static String get liveTrial => _t('liveTrial');
  static String get registrationClosed => _t('registrationClosed');
  static String get newsAnnouncements => _t('newsAnnouncements');
  static String get viewAllPlayers => _t('viewAllPlayers');
  static String get clubTeams => _t('clubTeams');
  static String get clubSponsors => _t('clubSponsors');
  static String get homeAwayThirdKit => _t('homeAwayThirdKit');
  static String get otherCompetitions => _t('otherCompetitions');
  static String get men => _t('men');
  static String get women => _t('women');
  static String get kit => _t('kit');
  static String get playersTitle => _t('playersTitle');
  static String get galleryTitle => _t('galleryTitle');
  static String get liveTrials => _t('liveTrials');
  static String get noTrialsFound => _t('noTrialsFound');
  static String get pleaseSelectFilter => _t('pleaseSelectFilter');
  static String get toAgeGreaterThanFromAge => _t('toAgeGreaterThanFromAge');
  static String get from => _t('from');
  static String get to => _t('to');
  static String get searchUpper => _t('searchUpper');
  static String get liveNow => _t('liveNow');
  static String get live => _t('live');
  static String get liveUpper => _t('liveUpper');
  static String get regCloses => _t('regCloses');
  static String get trialStarts => _t('trialStarts');
  static String get age => _t('age');
  static String get cost => _t('cost');
  static String get trialVenue => _t('trialVenue');
  static String get trialDate => _t('trialDate');
  static String get registration => _t('registration');
  static String get brief => _t('brief');
  static String get registrationRestrictedLong =>
      _t('registrationRestrictedLong');
  static String get registrationRestrictedShort =>
      _t('registrationRestrictedShort');
  static String get trialRegistrationThanks => _t('trialRegistrationThanks');
  static String get registeredSuccessfully => _t('registeredSuccessfully');
  static String get registrationFailedTryAgain =>
      _t('registrationFailedTryAgain');
  static String get free => _t('free');
  static String get foundation => _t('foundation');
  static String get president => _t('president');
  static String get generalSecretary => _t('generalSecretary');
  static String get viewAllCompetitions => _t('viewAllCompetitions');
  static String get featuredTeams => _t('featuredTeams');
  static String get viewAllTeams => _t('viewAllTeams');
  static String get headquarters => _t('headquarters');
  static String get founded => _t('founded');
  static String get ceo => _t('ceo');
  static String get founders => _t('founders');
  static String get merchandise => _t('merchandise');
  static String get view => _t('view');
  static String get chairman => _t('chairman');
  static String get fundingPartners => _t('fundingPartners');
  static String get partner => _t('partner');
  static String get basicInfo => _t('basicInfo');
  static String get position => _t('position');
  static String get jersey => _t('jersey');
  static String get playerNotFound => _t('playerNotFound');
  static String get footballStats => _t('footballStats');
  static String get futsalStats => _t('futsalStats');
  static String get matchCountLabel => _t('matchCountLabel');
  static String followersCount(int count) =>
      _t(count == 1 ? 'followerCount' : 'followersCount')
          .replaceFirst('{count}', '$count');
  static String failedToUpdateFollowStatus(Object error) =>
      _t('failedToUpdateFollowStatus').replaceFirst('{error}', '$error');
  static String footballStatsYear(int year) =>
      _t('footballStatsYear').replaceFirst('{year}', '$year');
  static String futsalStatsYear(int year) =>
      _t('futsalStatsYear').replaceFirst('{year}', '$year');

  // ─────────────────────────────────────────────────────────────────────────
  // Translation tables — sourced from Android values/strings.xml
  // ─────────────────────────────────────────────────────────────────────────
  static const Map<String, Map<String, String>> _translations = {
    // ── English ─────────────────────────────────────────────────────────────
    'en': {
      'appName': 'SocaLoca',
      'cancel': 'Cancel',
      'submit': 'Submit',
      'yes': 'YES',
      'no': 'No',
      'search': 'Search',
      'searchEllipsis': 'Search...',
      'locationPermission': 'Location Permission',
      'noResultsFound': 'No results found',
      'playerCoachManagerReferee': 'Player/Coach/Manager/Referee',
      'byCountry': 'By Country',
      'byType': 'By Type',
      'byChoice': 'By Choice',
      'profileDetailsNotAvailable': 'Profile details not available yet',
      'endorsedByUpper': 'ENDORSED BY',
      'followersUpper': 'FOLLOWERS',
      'locationPermissionDesc':
          "SocaLoca asks for your location access to align you with your country's Football Association. SocaLoca also uses your location to find your tournament location. Your location data is only used to help you navigate through your football journey and is not saved for any other purposes.",
      'learnMore': 'Learn more',
      'searchHere': 'Search here',
      'mostPosts': 'Most Posts',
      'mostAppearances': 'Most Appearances',
      'mostGoals': 'Most Goals',
      'back': 'Back',
      'save': 'SAVE',
      'delete': 'Delete',
      'deactivate': 'Deactivate',
      'report': 'Report',
      'follow': 'Follow',
      'following': 'Following',
      'followers': 'Followers',
      'viewAll': 'View All',
      'comingSoon': 'Coming Soon',
      'somethingWentWrong': 'Something went wrong!',
      'error': 'Error',
      'na': 'N/A',
      'gotIt': 'Got It',
      'upgrade': 'UPGRADE',
      'helpdesk': 'Helpdesk',
      'mandatoryFields': '* mandatory fields',
      'goToHome': 'Go to Home',
      'selectLanguage': 'Select Language',
      'selectLanguageDesc':
          'SocaLoca is available in multiple languages. Please select one to continue.',
      'pleaseSelectLanguage': 'Please select a language',
      'englishLanguage': 'English',
      'spanishLanguage': 'Spanish',
      'portugueseLanguage': 'Portuguese',
      'frenchLanguage': 'French',
      'pleaseSelectRating': 'Please select a rating',
      'nextUpper': 'NEXT',
      'submitUpper': 'SUBMIT',
      'doneUpper': 'DONE',
      'yourFeedbackMatters': 'Your feedback matters!',
      'whatAreYourFavouriteFeatures': 'What are your favourite features?',
      'doYouWantToOfferFeedback': 'Do you want to offer us some feedback?',
      'thankYouTitle': 'Thank you!',
      'weHighlyValueFeedback': 'We highly value your feedback!',
      'thankYouFeedbackSupport':
          'Thank you for giving your feedback, we appreciate your support in helping us to improve the app.',
      'feed': 'Feed',
      'pickUpMatch': 'Pick-Up Match',
      'firstNamePlain': 'First name',
      'lastNamePlain': 'Last name',
      'usernameMinFiveHint': 'Username (min 5 chars)',
      'nameNotAvailable': 'Name not available',
      'signIn': 'SIGN IN',
      'signUp': 'Sign Up',
      'signUpUpper': 'SIGN UP',
      'signOut': 'Sign Out',
      'login': 'Login',
      'forgotPassword': 'Forgot Password?',
      'socialLoginNoPassword':
          'Hey there… You have used social login. No need of passwords.',
      'email': 'Email *',
      'emailPlain': 'Email',
      'enterYourEmail': 'Enter your email',
      'password': 'Password *',
      'enterYourPassword': 'Enter your password',
      'newPassword': 'New Password *',
      'enterYourNewPassword': 'Enter your new password',
      'confirmPassword': 'Confirm Password *',
      'currentPassword': 'Current Password *',
      'enterYourCurrentPassword': 'Enter your current password',
      'changePassword': 'Change Password',
      'resetPassword': 'RESET',
      'sendOtp': 'SEND OTP',
      'sendResetLink': 'SEND RESET LINK',
      'resend': 'RESEND',
      'haventReceivedCode': "Haven't received the code?  ",
      'otpLabel': 'OTP *',
      'socaLocaId': 'SocaLoca ID',
      'mobile': 'Mobile',
      'enterSocaLocaId': 'Enter SocaLoca ID',
      'enterMobileNumber': 'Enter Mobile Number',
      'mobileEmailSocaLocaIdRequired': 'Mobile number */Email */SocaLoca ID *',
      'mobileOrEmailRequired': 'mobile number or email *',
      'socaLocaIdRequired': 'SocaLoca ID *',
      'emailRequired': 'Email *',
      'mobileNumberRequired': 'Mobile Number *',
      'enterEmailRequired': 'enter your Email *',
      'enterMobileNumberRequired': 'enter your Mobile Number *',
      'enterSocaLocaIdRequired': 'enter your SOCALOCA ID *',
      'pleaseEnterEmail': 'Please enter email',
      'pleaseEnterValidEmail': 'Please enter valid email',
      'pleaseEnterPassword': 'Please enter a password',
      'minimumSixCharacters': 'Minimum 6 characters',
      'pleaseConfirmPassword': 'Please confirm password',
      'passwordDoesNotMatch': "Password doesn't match",
      'passwordDoNotMatch': "Passwords don't match",
      'invalidCurrentPassword': 'Invalid current password',
      'pleaseEnterCurrentPassword': 'Please enter current password',
      'pleaseEnterNewPassword': 'Please enter new password',
      'pleaseConfirmNewPassword': 'Please confirm new password',
      'passwordChangedSuccessfully': 'Password changed successfully',
      'pleaseEnterOtp': 'Please enter OTP',
      'verificationCodeSent': 'Verification code sent successfully',
      'passwordResetSuccess': 'Password reset successfully. Please Sign In.',
      'strong': 'Strong',
      'weak': 'Weak',
      'pleaseEnterValidMobileNumber': 'Please enter a valid mobile number',
      'pleaseEnterValidSocaLocaId': 'Please enter valid SOCALOCA ID',
      'pleaseEnterMobileOrEmail': 'Please enter mobile or email',
      'pleaseEnterYourEmailMobileOrSocaLocaId':
          'Please enter your email, mobile number or SocaLoca ID',
      'pleaseEnterValidEmailMobileOrSocaLocaId':
          'Please enter valid email, mobile number or SocaLoca ID',
      'pleaseEnterMobileNumberOrEmail': 'Please enter mobile or email',
      'passwordAtLeastSixCharacters': 'Password must be at least 6 characters',
      'minimumFiveCharacters': 'minimum 5 characters',
      'unexpectedResponseTryAgain': 'Unexpected response. Please try again.',
      'wrongPassword': 'Wrong password',
      'accountNotRegistered': 'Account not registered',
      'mobileNotRegistered': 'Mobile is not registered',
      'failedAcceptPolicyTryAgain':
          'Failed to accept policy. Please try again.',
      'googleSignInFailed': 'Google sign-in failed',
      'facebookSignInFailed': 'Facebook sign-in failed',
      'googleSignInFailedWithCode': 'Google sign-in failed ({code})',
      'verifyCode': 'Verify Code',
      'enterVerificationCode': 'Enter verification code',
      'verify': 'Verify',
      'resendCode': 'Resend Code',
      'addEmail': 'Add Email',
      'emailAddressRequired': 'Email address *',
      'addEmailOtpPrompt':
          'No contact info found for this SocaLoca ID. Please enter an email address to receive your OTP.',
      'selectCountry': 'Select Country',
      'forgottenPassword': 'Forgotten Password?',
      'logInUpper': 'LOG IN',
      'orContinueWith': 'or continue with',
      'continueLabel': 'Continue',
      'tryAgain': 'TRY AGAIN',
      'professionalClubQuestion': 'Are you a Professional Football Club?',
      'loginSignupHere': 'Login/Signup here',
      'findSocaLocaIdHint':
          'Find your new SocaLoca ID in the sliding hamburger menu',
      'socaLocaPrivacyNotice':
          '*SocaLoca only collects the data is necessary to provides its service and\nstores it in the anonymised way in our own self-hosted analytics system.',
      'resetUpper': 'RESET',
      'resendUpper': 'RESEND',
      'proceedUpper': 'PROCEED',
      'saveAndContinueUpper': 'SAVE AND CONTINUE',
      'parentalControls': 'Parental Controls',
      'setYourPin': 'Set Your PIN',
      'forgetPin': 'Forget pin?',
      'settings': 'Settings',
      'modifyPin': 'Modify pin',
      'pleaseProvideConsentToContinue': 'Please provide consent to continue',
      'fetchingLocation': 'Fetching location...',
      'selectLocationUpper': 'SELECT LOCATION',
      'skip': 'Skip',
      'or': 'or',
      'pleaseEnterFullDigitCode': 'Please enter the full {length}-digit code',
      'verificationCodeSentTo': 'We sent a 6-digit code to your {type}.',
      'resendCodeIn': 'Resend code in {seconds}s',
      'resendUpperWithSeconds': 'RESEND ({seconds}s)',
      'resetLinkSentTo': 'Reset link sent to {email}',
      'errorMessage': 'Error: {error}',
      'errorPickingImage': 'Error picking image: {error}',
      'firstName': 'First Name *',
      'lastName': 'Last Name *',
      'profileName': 'Profile Name *',
      'enterYourName': 'Enter your name',
      'dateOfBirth': 'Date Of Birth *',
      'country': 'Country',
      'gender': 'Gender *',
      'male': 'Male',
      'female': 'Female',
      'nationality': 'Nationality',
      'playingPosition': 'Playing Position *',
      'preferredFoot': 'Preferred Foot',
      'right': 'Right',
      'left': 'Left',
      'height': 'Height',
      'heightCms': 'Height (cms)',
      'editProfile': 'Edit Profile',
      'createProfile': 'Create Profile',
      'uploadProfilePhoto': 'Upload your profile photo',
      'takeAPhoto': 'Take a photo',
      'chooseFromGallery': 'Choose from gallery',
      'selectImage': 'Select Image',
      'myGallery': 'My Gallery',
      'pleaseEnterFirstName': 'Please enter first name',
      'pleaseEnterLastName': 'Please enter last name',
      'pleaseEnterProfileName': 'Please enter profile name',
      'pleaseEnterDateOfBirth': 'Please enter date of birth',
      'pleaseSelectNationality': 'Please select nationality',
      'home': 'Home',
      'away': 'Away',
      'third': 'Third',
      'teams': 'Teams',
      'players': 'Players',
      'match': 'Match',
      'matches': 'Matches',
      'clubsAndPartners': 'Clubs and Partners',
      'notifications': 'Notifications',
      'noNotifications': 'No notification for now',
      'tournaments': 'Tournaments',
      'club': 'Club',
      'clubs': 'Clubs',
      'partners': 'Partners',
      'academy': 'Academy',
      'recentMatches': 'Recent Matches',
      'upcomingMatches': 'Upcoming Matches',
      'noUpcomingMatches': 'No upcoming matches',
      'noRecentMatches': 'No recent matches',
      'errorLoadingUpcomingMatches': 'Error loading upcoming matches',
      'errorLoadingRecentMatches': 'Error loading recent matches',
      'todaysMatch': "Today's Match",
      'playedMatches': 'Played Matches',
      'noPlayedMatches': 'No played matches',
      'todaysMatches': "Today's Matches",
      'hostMatch': 'Host Match',
      'manageRequests': 'Manage Requests',
      'selectTournamentRequired': 'select tournament *',
      'myMatches': 'My Matches',
      'myMatchesTournament':
          'Find all the matches assigned to you by the Tournament Organisers. Update scores and records by tapping "Manage". Download Match Report once a match is updated.',
      'noMatchesAreFound': 'No matches are found!!!',
      'manage': 'Manage',
      'downloadMatchReport': 'Download Match Report',
      'liveMatches': 'Live Matches',
      'liveMatchTournament':
          'Find all the matches assigned to you by the Tournament Organiser here. Tap on "START MATCH" to publish "Live Scores".',
      'noLiveMatchesAvailable': 'No Live Matches Available!!!',
      'startMatch': 'Start Match',
      'abandonMatch': 'Abandon Match',
      'saveAndPublish': 'Save & Publish',
      'matchStatus': 'Match Status',
      'goals': 'Goals',
      'cards': 'Cards',
      'substitution': 'Substitution',
      'ownGoal': 'Own Goal',
      'penalty': 'Penalty',
      'penaltyMissed': 'Penalty Missed',
      'minutesShort': '(Mins.)',
      'selectScorer': 'Select Scorer',
      'selectAssist': 'Select Assist',
      'selectPlayer': 'Select Player',
      'firstCard': '1st',
      'secondCard': '2nd',
      'redCardShort': 'Red',
      'playerIn': 'Player In',
      'playerOut': 'Player Out',
      'selectInPlayer': 'Select In Player',
      'selectOutPlayer': 'Select Out Player',
      'ongoing': 'Ongoing',
      'upcoming': 'Upcoming',
      'closed': 'Closed',
      'myLeaguesCups': 'My Leagues/Cups',
      'today': 'Today',
      'noMatchForToday': 'No match for today',
      'pickup': 'Pick-Up',
      'oneOff': 'One-off',
      'endorsements': 'Endorsements',
      'noEndorsementsYet': 'No Endorsements yet',
      'endorsedSuccessfully': 'Endorsed successfully',
      'alreadyEndorsed': 'Already endorsed',
      'appearance': 'Appearance',
      'appearances': 'Appearances',
      'playerBio': 'Player Bio',
      'clubBio': 'Club Bio',
      'league': 'League',
      'stadium': 'Stadium',
      'featuredPlayers': 'Featured Players',
      'born': 'Born',
      'goalScored': 'Goal Scored',
      'assists': 'Assists',
      'yellowCard': 'Yellow Card',
      'redCard': 'Red Card',
      'mvp': 'MVP',
      'liked': 'Liked',
      'tapToLike': 'Tap to like',
      'tapToFollow': 'Tap to follow',
      'noPlayerJoinedYet': 'No player joined yet',
      'myTeams': 'My Teams',
      'createTeam': 'Create Team',
      'noTeamsFound': 'No teams found.',
      'addPlayers': 'Add Players',
      'noClubsFound': 'No clubs found.',
      'noTournamentsFound': 'No tournaments found.',
      'competitions': 'Competitions',
      'noCompetitionsFound': 'No competitions found.',
      'fas': 'FAs',
      'confederations': 'Confederations',
      'sponsors': 'Sponsors',
      'charitiesAndNgos': 'Charities & NGOs',
      'noPostsFound': 'No posts found.',
      'post': 'Post',
      'posts': 'Posts',
      'createPost': 'Create Post',
      'uploadImage': 'Upload Images',
      'uploadVideo': 'Upload Video',
      'reportThisPost': 'Report This Post',
      'pleaseSelectACause': 'Please select a cause',
      'pleaseSelectAtLeastOneFilter': 'Please select at least one filter',
      'location': 'Location',
      'selectLocation': 'Select Location',
      'ageGroup': 'Age Group',
      'game': 'Game',
      'register': 'Register',
      'registered': 'Registered',
      'liveTrialRegistration': 'Live Trial Registration',
      'deleteAccount': 'Deactivate/Delete Account',
      'deleteAccountConfirmation':
          'Are you sure you want to Delete your Account?',
      'deactivateAccountConfirmation':
          'Are you sure you want to Deactivate your Account?',
      'downloadActivities': 'Download Activities',
      'welcomeBack': 'Welcome back!!!',
      'weTrulyMissedYou': 'We truly missed you.',
      'hello': 'Hello,',
      'cheers': 'CHEERS',
      'myBio': 'My Bio',
      'myPosts': 'My Posts',
      'myRatings': 'My Ratings',
      'gallery': 'Gallery',
      'sharePostPrompt': 'Share a photo or video and write\nsomething.',
      'createPostUpper': 'CREATE A POST',
      'mostEndorsedPlayers': 'Most Endorsed Players',
      'mostFollowedTeams': 'Most Followed Teams',
      'recentlyJoined': 'Recently Joined',
      'recentlyJoinedTeams': 'Recently Joined Teams',
      'ongoingTournaments': 'Ongoing Tournaments',
      'matchUpdates': 'Match Updates',
      'liveMatchUpdate': 'Live Match Update',
      'viewDetails': 'VIEW DETAILS',
      'viewUpper': 'VIEW',
      'feedbackUpper': 'FEEDBACK',
      'shareUpper': 'SHARE',
      'socaLocaUser': 'SocaLoca User',
      'socaLocaIdLabel': 'SocaLoca ID: ',
      'socaLocaIdCopied': 'SocaLoca ID copied',
      'loadingProfilePleaseTryAgain': 'Loading profile, please try again',
      'skillDetail': 'Skill Detail',
      'people': 'People',
      'likes': 'Likes',
      'cup': 'Cup',
      'fa': 'FA',
      'fiveHours': '5 hrs',
      'aUser': 'A user',
      'checkHisBio': 'Check his bio',
      'checkTeamBio': 'Check team bio',
      'checkTournamentDetails': 'Check tournament details',
      'jerseySize': 'Jersey Size',
      'teamFallback': 'Team',
      'tournamentFallback': 'Tournament',
      'unknownDate': 'Unknown Date',
      'tournamentDate': 'Tournament Date',
      'tournamentVenue': 'Tournament Venue',
      'totalNumberOfTeams': 'Total Number of Teams',
      'numberOfPlayerPerTeam': 'Number of player per team',
      'noLimit': 'No limit',
      'am': 'AM',
      'pm': 'PM',
      'monthJan': 'Jan',
      'monthFeb': 'Feb',
      'monthMar': 'Mar',
      'monthApr': 'Apr',
      'monthMay': 'May',
      'monthJun': 'Jun',
      'monthJul': 'Jul',
      'monthAug': 'Aug',
      'monthSep': 'Sep',
      'monthOct': 'Oct',
      'monthNov': 'Nov',
      'monthDec': 'Dec',
      'checkOutPostOnSocaLoca': 'Check out this post on SocaLoca. {url}',
      'userJoinedSocaLoca': '{name} has joined SocaLoca!!! ',
      'teamJoinedSocaLoca': '{name} has joined SocaLoca!!!\n',
      'tournamentIsLive': '{name} is live!!! ',
      'startedOn': 'Started on {date}',
      'trials': 'Trials',
      'updateProfile': 'Update Profile',
      'changeLanguage': 'Change Language',
      'helpDesk': 'Help Desk',
      'privacySettings': 'Privacy Settings',
      'helpUsToImprove': 'Help Us To Improve',
      'dataPolicy': 'Data Policy',
      'termsAndConditions': 'Terms & Conditions',
      'signOutUpper': 'SIGN OUT',
      'academies': 'Academies',
      'menu': 'Menu',
      'retry': 'Retry',
      'ok': 'OK',
      'block': 'Block',
      'blockUser': 'Block User',
      'reportUser': 'Report User',
      'selectReason': 'Select a reason:',
      'requestCancelled': 'Request cancelled.',
      'failedToSubmitEndorsement': 'Failed to submit endorsement. Try again.',
      'requests': 'Requests',
      'noPendingRequests': 'No pending requests.',
      'noJoinedTeams': 'No joined teams.',
      'pendingRequests': 'Pending Requests',
      'teamInvitations': 'Team Invitations',
      'noTeamInvitations': 'No team invitations.',
      'accept': 'Accept',
      'decline': 'Decline',
      'joinedTeams': 'Joined Teams',
      'noPostsYet': 'No posts yet.',
      'noPosts': 'No Posts',
      'noPlayers': 'No Players',
      'matchNotFound': 'Match not found',
      'tournamentNotFound': 'Tournament not found',
      'requestSentSuccessfully': 'Request sent successfully!',
      'matchHostedSuccessfully': 'Match hosted successfully!',
      'pleaseTickCheckbox': 'Please tick the checkbox',
      'verifiedSuccessfully': 'Verified successfully!',
      'pleaseSelectAtLeastOneRole': 'Please select at least one role',
      'failedCreateProfile': 'Failed to create profile. Please try again.',
      'failedUpdateProfile': 'Failed to update profile. Please try again.',
      'profileUpdatedSuccessfully': 'Profile updated successfully',
      'yourEmail': 'Your Email',
      'aboutMe': 'About Me',
      'preferredJerseyNumber': 'Preferred Jersey Number',
      'playingLevel': 'Playing Level',
      'shirtJerseySize': 'Shirt/Jersey Size',
      'shoeSize': 'Shoe Size',
      'majorLeaguesYouFollow': 'Major leagues you follow',
      'teamsYouFollow': 'Teams you follow',
      'takePhotoUpper': 'TAKE A PHOTO',
      'chooseGalleryUpper': 'CHOOSE FROM GALLERY',
      'removePhoto': 'Remove Photo',
      'selectNationality': 'Select a country',
      'firstNameRequiredLower': 'first name *',
      'lastNameRequiredLower': 'last name *',
      'profileNameRequiredLower': 'profile name *',
      'selectRoleRequired': 'Select role *',
      'nationalityRequired': 'Nationality *',
      'max300Characters': 'max 300 characters',
      'valueInCm': 'value in cm',
      'brandsYouLike': 'Brands you like',
      'chooseYourAvatar': 'Choose your avatar',
      'byClickingSubmitPolicy':
          'By clicking Submit, you agree to our Terms & Conditions and Privacy Policy.',
      'select': 'Select',
      'selectLocationFromMap': 'Select location from map',
      'zeroToNinetyNine': '0 - 99',
      'playerRole': 'Player',
      'fan': 'Fan',
      'referee': 'Referee',
      'genderPlain': 'Gender',
      'dateOfBirthRequired': 'Date Of Birth *',
      'playingPositionPlain': 'Playing Position',
      'playingLevelRequired': 'Playing Level *',
      'iAmOver': 'I am over',
      'iAm': 'I am',
      'sixteenYears': '16 years',
      'thirteenToFifteenYears': '13-15 years',
      'sevenToTwelve': '7-12',
      'years': 'years',
      'yearsTitle': 'Years',
      'old': 'old',
      'parentGuardianRegisteringOnBehalf':
          'I am a parent/guardian\nregistering on behalf of a',
      'thankYouForJoining': 'Thank you for joining SocaLoca!',
      'createProfileToGetStarted': 'Please create your profile to get started.',
      'createProfileUpper': 'CREATE PROFILE',
      'childConsentIntro':
          'Accounts of children between the ages of 7 and 12 can only created and managed by a parent or guardian.',
      'fillFieldsAndTickCheckbox':
          'Please fill out the fields below and tick the checkbox.',
      'childGuardianConfirmation':
          'This is confirm that you are the legal guardian and will take full control and accountability of this account upon registering on behalf of a minor.',
      'childsNameRequired': 'Childs Name*',
      'parentGuardianNameRequired': 'Parent/Guardians Name*',
      'parentGuardianEmailRequired': 'Parent/Guardians Email*',
      'minorConsentText':
          'I consent that I am registering on behalf of a minor and will take full control of this SocaLoca account.',
      'pleaseEnterMinorName': 'Please enter minor name',
      'pleaseEnterParentGuardianName': 'Please enter parent/guardian name',
      'pleaseEnterParentEmail': 'Please enter a parent email',
      'pleaseEnterValidParentEmail': 'Please enter a valid parent email',
      'youthConsentIntro':
          'Accounts of children between the ages of 13 and 15 require parent or guardian consent.',
      'youthGuardianConfirmation':
          'This is confirm that you are the legal guardian and consent to this youth account registration.',
      'clubName': 'Club Name',
      'enterClubName': 'Enter club name',
      'enterClubEmail': 'Enter club email',
      'pleaseEnterClubName': 'Please enter club name',
      'pleaseSelectCountry': 'Please select country',
      'pleaseSelectConfederation': 'Please select confederation',
      'pleaseSelectLeague': 'Please select league',
      'pleaseEnterContactName': 'Please enter contact name',
      'pleaseEnterContactNumber': 'Please enter contact number',
      'emailAlreadyRegistered': 'Email already registered',
      'joiningRequestThanks':
          'Thanks for your joining request. We will validate and send you the instructions shortly.',
      'redirectsToSocalocaFootball': 'Redirects to socaloca.football',
      'gotItUpper': 'GOT IT',
      'autoPopulatedFromCountry': 'Auto-populated from country',
      'selectCountryFirst': 'Select country first',
      'selectCountryRequired': 'Select Country *',
      'selectLeagueRequired': 'Select League *',
      'enterContactName': 'Enter contact name',
      'enterContactNumber': 'Enter contact number',
      'aPlayer': 'A Player',
      'aCoach': 'A Coach',
      'aManager': 'A Manager',
      'aReferee': 'A Referee',
      'aFan': 'A Fan',
      'aProfessionalClub': 'A Professional Club',
      'pleaseEnterAllFourDigits': 'Please enter all 4 digits',
      'pinCannotBeSameDigits': 'PIN cannot be all same digits',
      'pinCannotBeSequential': 'PIN cannot be sequential numbers',
      'parentalPinInfo':
          '*Please note you can modify the pin from the "Parentals Control" in the hamburger menu, located at the top right of SOCALOCA app.',
      'parentGuardianPhoneRequired': 'Parent/Guardians Phone*',
      'pleaseEnterMobileNumber': 'Please enter a mobile number',
      'youthConsentTitle':
          "Accounts of users between the ages of 13 and 15 can only be created and managed with a parent or guardian's consent.",
      'likingAndFollowing': 'Liking and following',
      'uploadingPhotosVideos': 'Uploading photos & videos',
      'parentalControlConsent':
          'I consent that I am setting the parental controls on behalf of a child and will take full control of this SOCALOCA account',
      'registerAsClub': 'Register as a Club',
      'emailOrSocaLocaId': 'Email or SocaLoca ID',
      'emailOrSocaLocaIdRequired': 'Email */SocaLoca ID *',
      'pleaseEnterEmailOrSocaLocaId': 'Please enter email or SocaLoca ID',
      'pleaseEnterValidEmailOrSocaLocaId':
          'Please enter a valid email or SocaLoca ID',
      'invalidCredentials': 'Invalid credentials',
      'warning': 'Warning',
      'confirmEndMatch': 'Are you sure you want to end this match?',
      'jerseysAssigned': 'Jerseys assigned',
      'inviteSent': 'Invite sent',
      'enterAtLeast3Chars': 'Enter at least 3 characters to search',
      'noPlayersFound': 'No players found',
      'failedToLoadPlayers': 'Failed to load players',
      'failedToLoadTeams': 'Failed to load teams',
      'failedToLoadTeamBio': 'Failed to load team bio',
      'noTeamDataAvailable': 'No team data available',
      'unknownTeam': 'Unknown Team',
      'thisTeamIsArchived': 'This team is archived',
      'requestPendingUpper': 'REQUEST PENDING',
      'requestSent': 'Request sent',
      'sendRequestUpper': 'SEND REQUEST',
      'tryAdjustingYourFilters': 'Try adjusting your filters',
      'noMatchesPlayedYet': 'No matches played yet',
      'fullTime': 'Full time',
      'fullTimeTitle': 'Full Time',
      'firstHalf': 'First Half',
      'secondHalf': 'Second Half',
      'breakBeforeEt': 'Break Before ET',
      'etFirstHalf': 'ET First Half',
      'etHalfTime': 'ET Half Time',
      'etSecondHalf': 'ET Second Half',
      'afterExtraTime': 'After Extra Time',
      'ratingLabel': 'Rating  ',
      'allTemasLabel': '      All temas',
      'requiredField': 'Required',
      'teamWork': 'Team Work',
      'technical': 'Technical',
      'aggressiveness': 'Aggressiveness',
      'tactical': 'Tactical',
      'overallRating': 'Overall Rating',
      'teamOne': 'Team 1',
      'teamTwo': 'Team 2',
      'vsLower': 'vs',
      'tournamentType': 'Tournament Type',
      'venue': 'Venue',
      'notes': 'Notes',
      'description': 'Description',
      'prizes': 'Prizes',
      'registrationFees': 'Registration Fees',
      'organizerDetails': 'Organizer Details',
      'viewTournamentDetails': 'View Tournament Details ',
      'matchManagement': 'Match Management',
      'vs': 'VS',
      'noPointsTableAvailable': 'No points table available',
      'noDataAvailable': 'No data available',
      'add': 'Add',
      'addCard': 'Add Card',
      'noCardsRecorded': 'No Cards Recorded',
      'tapAddCards': 'Tap the button below to add cards',
      'cardType': 'Card Type',
      'yellow': 'Yellow',
      'red': 'Red',
      'playerName': 'Player Name',
      'example45': 'e.g., 45',
      'example23': 'e.g., 23',
      'deleteCard': 'Delete Card',
      'deleteGoal': 'Delete Goal',
      'deleteCardConfirmation': 'Are you sure you want to delete this card?',
      'deleteGoalConfirmation': 'Are you sure you want to delete this goal?',
      'currentManOfMatch': 'Current Man of the Match',
      'noMvpSelected': 'No MVP Selected',
      'tapSelectMvp': 'Tap the button below to select MVP',
      'selectManOfMatch': 'Select Man of the Match',
      'clearMvp': 'Clear MVP',
      'clearMvpConfirmation':
          'Are you sure you want to clear the Man of the Match?',
      'clear': 'Clear',
      'addGoal': 'Add Goal',
      'noGoalsRecorded': 'No Goals Recorded',
      'tapAddGoals': 'Tap the button below to add goals',
      'success': 'Success',
      'saveSquad': 'Save Squad',
      'startingXi': 'Starting XI',
      'substitutes': 'Substitutes',
      'addStartingPlayer': 'Add Starting Player',
      'addSubstitute': 'Add Substitute',
      'noKnockoutMatchesYet': 'No knockout matches yet',
      'noGroupsAvailable': 'No groups available',
      'selectGroup': 'Select Group',
      'viewGroupStandings': 'View Group Standings',
      'groupNotFound': 'Group not found',
      'noMatchesInThisGroup': 'No matches in this group',
      'noEligibleTeams': 'No Eligible Teams',
      'noEligibleTeamsTournament':
          "You don't have any teams eligible for this tournament.",
      'noEligibleTeamsCup': "You don't have any teams eligible for this cup.",
      'selectTeam': 'Select Team',
      'tournamentStats': 'Tournament Stats',
      'noRoundsAvailable': 'No rounds available',
      'noStatRecordedYet': 'No {label} recorded yet',
      'groupStandings': 'Group Standings',
      'noStandingsAvailable': 'No standings available',
      'errorLoadingStandings': 'Error loading standings',
      'pointsHash': '#',
      'pointsPlayed': 'P',
      'pointsWon': 'W',
      'pointsDrawn': 'D',
      'pointsLost': 'L',
      'goalsFor': 'GF',
      'goalsAgainst': 'GA',
      'goalDifference': 'GD',
      'pointsShort': 'Pts',
      'requestToJoin': 'Request to Join',
      'requestToJoinCup': 'Request to Join Cup',
      'pendingInvitations': 'Pending Invitations',
      'viewItinerary': 'View Itinerary',
      'itinerary': 'Itinerary',
      'close': 'Close',
      'cupTournamentNotFound': 'Cup tournament not found',
      'statsUpper': 'STATS',
      'selectRound': 'Select Round',
      'noGroupRoundAvailable': 'No group round available',
      'noKnockoutRoundAvailable': 'No knockout round available',
      'accessRestricted': 'Access Restricted',
      'matchManageRestricted':
          'Only admins, coaches, and referees\ncan manage matches',
      'noMatches': 'No Matches',
      'noMatchesAvailableForManagement': 'No matches available for management',
      'manageMatch': 'Manage Match',
      'tournamentsIntro':
          'See the listing of tournaments in your area and apply to join a competition if its right for your team. You can also view the progression of competitions in real time, see fixtures, points tables, stats and even match highlights.',
      'selectManOfMatchHint':
          'Select the Man of the Match from the participating players.',
      'scoreEntryHint':
          'Enter the final score for this match. The score will be submitted for approval.',
      'addStartingOrSubstitutePlayer': 'Add {type} Player',
      'starting': 'Starting',
      'substitute': 'Substitute',
      'errorLoadingTournament': 'Error loading tournament: {error}',
      'errorLoadingStandingsWithError': 'Error loading standings: {error}',
      'errorLoadingStats': 'Error loading stats: {error}',
      'errorLoadingBracket': 'Error loading bracket: {error}',
      'errorLoadingMatchesWithError': 'Error loading matches: {error}',
      'errorLoadingDetails': 'Error loading details: {error}',
      'errorLoadingCup': 'Error loading cup: {error}',
      'invitationSentAll': 'Invitation sent to all numbers',
      'profileNameNotAvailable': 'Profile name is not available',
      'selectYear': 'Select year',
      'camera': 'Camera',
      'teamInfoUpdated': 'Team info updated',
      'pom': 'POM',
      'score': 'Score',
      'squad': 'Squad',
      'pointsTable': 'Points Table',
      'stats': 'Stats',
      'groupStage': 'Group Stage',
      'knockout': 'Knockout',
      'manOfMatch': 'Man of Match',
      'searchAndInvite': 'Search & Invite',
      'inviteByPhone': 'Invite by Phone',
      'createPlayer': 'Create Player',
      'all': 'All',
      'joined': 'Joined',
      'pending': 'Pending',
      'received': 'Received',
      'newRequests': 'New Requests',
      'newPlayers': 'New Players',
      'jerseyAssigned': 'Jersey Assigned',
      'phoneNumber': 'Phone Number',
      'jerseyNumberHint': 'Jersey number or "coach"/"manager"',
      'enterTextHint': 'Enter text here (max 150 characters)',
      'mobileNumber': 'Mobile number',
      'countryCode': 'Country code',
      'countryIso': 'Country ISO',
      'otp': 'OTP',
      'passwordHint': 'Password',
      'selectPhoto': 'Select Photo',
      'gameType': 'Game Type',
      'football': 'Football',
      'futsal': 'Futsal',
      'ageRange': 'Age Range',
      'ageCategory': 'Age Category',
      'updateTeam': 'Update Team',
      'teamName': 'Team Name',
      'shortNameHint': 'Short Name (max 4 chars)',
      'cityAddress': 'City / Address',
      'selectAgeRange': 'Select age range',
      'selectAgeCategory': 'Select age category',
      'teamNameRequired': 'Team name is required',
      // Referee manage match
      'failedToLoadMatchDetails': 'Failed to load match details',
      'pleaseEnterScoreProperly': 'Please enter score properly',
      'pleaseEnterExtraTimeDetails': 'Please enter extra time details',
      'pleaseEnterPenaltyDetails': 'Please enter penalty shootout details',
      'matchScoreSaved': 'Match score saved',
      'extraTime': 'Extra Time',
      'time': 'Time',
      'scorer': 'Scorer',
      'noOfCards': 'No of cards',
      'player': 'Player',
      'pleaseSelectPom': 'Please select player of the match',
      'coach': 'Coach',
      'manager': 'Manager',
      'pleaseSelectPlayersFromBothTeams':
          'Please select players from both teams',
      'minute': 'Minute',
      'pleaseEnterSubstituteDetails': 'Please enter substitute details',
      'matchIncidents': 'Match Incidents',
      'enterTextMax200': 'Enter text here max 200 characters',
      'matchCommissionerReport': 'Match Commissioner Report',
      'enterTextMax300': 'Enter text here max 300 characters',
      'commissionerReportSaved':
          'Match Commissioner Report successfully saved!!!',
      'uploadMatchPhotos': 'Upload Match Photos',
      'savePhotos': 'Save Photos',
      'uploadMatchHighlights': 'Upload Match Highlights',
      'saveHighlights': 'Save Highlights',
      'uploadMatchVideos': 'Upload Match Videos',
      'saveVideos': 'Save Videos',
      'maxPhotosUpload': 'Maximum 5 photos can be uploaded',
      'uploadingPhoto': 'Uploading photo...',
      'maxVideoSizeUpload': 'Maximum 15MB video can be uploaded',
      'uploadingHighlight': 'Uploading highlight...',
      'maxVideosUpload': 'Maximum 2 videos can be uploaded',
      'uploadingVideo': 'Uploading video...',
      'pleaseSelectMp4OrMov': 'Please select either mp4 or mov file',
      'pleaseEnterGoalDetails': 'Please enter goal details',
      'pleaseEnterCardDetails': 'Please enter card details',
      'officialsProgressSaved': 'Club & Team Officials saved',
      'noMembersAvailable': 'No members available',
      'matchDetails': 'Match Details',
      'matchDate': 'Match Date',
      'matchTime': 'Match Time',
      'tbd': 'TBD',
      'videoPublishedToFeed': 'Video published to feed',
      'uploadComplete': 'Upload complete',
      'round': 'Round',
      // Academies
      'academyNotFound': 'Academy not found',
      'joiningRequestSent': 'Joining request sent',
      'director': 'Director',
      'foundedYear': 'Founded Year',
      'academyJoined': 'Academy Joined',
      'cancelRequest': 'Cancel Request',
      'sendRequest': 'Send Request',
      'cat': 'CAT',
      'about': 'About',
      'bio': 'Bio',
      'academyDirector': 'Academy Director',
      'academyManager': 'Academy Manager',
      'academyContactNumber': 'Academy Contact Number',
      'academyContactEmail': 'Academy Contact Email',
      'skillVideos': 'Skill Videos',
      'matchVideos': 'Match Videos',
      'academyNews': 'Academy News',
      'registrationSuccessful': 'Registration successful!',
      'registrationFailed': 'Registration failed. Please try again.',
      'emailIsRequired': 'Email is required',
      'enterValidEmailAddress': 'Enter a valid email address',
      'category': 'Category',
      // Live Match
      'substitutions': 'Substitutions',
      'penaltyShootout': 'Penalty Shootout',
      'lineUp': 'Line Up',
      'goalkeepers': 'Goalkeepers',
      'defenders': 'Defenders',
      'midfielders': 'Midfielders',
      'attackers': 'Attackers',
      'ogShort': 'OG',
      'penShort': 'Pen',
      'assist': 'Assist',
      'missed': 'Missed',
      // My Bio
      'myStats': 'My Stats',
      'ratings': 'Ratings',
      'minimumFiveCharsRequired': 'Minimum 5 characters required',
      // 'minimumFiveCharacters': 'minimum 5 characters',
      'pleaseSelectDateOfBirth': 'Please select date of birth',
      'dateOfBirthPlaceholder': 'date of birth *',
      'editPost': 'Edit Post',
      'deletePost': 'Delete Post',
      'deletePostConfirm': 'Are you sure you want to delete this post?',
      'postDeleted': 'Post deleted',
      'couldNotDeletePost': 'Could not delete post. Please try again.',
      'unknown': 'Unknown',
      'failedToLoadRatings': 'Failed to load ratings',
      'overallScoreMultiline': 'OVERALL\nSCORE',
      'skillAttributeRating': 'Skill & Attribute Rating',
      'ratingLegendDescription':
          '1 - Basic  |  2 - Average  |  3 - Good  |  4 - Very Good  |  5 - Outstanding',
      'physical': 'Physical',
      'mental': 'Mental',
      'goalkeeper': 'Goalkeeper',
      'userNotLoggedIn': 'User not logged in',
      'profileNotFound': 'Profile not found',
      'myActivities': 'My Activities',
      'myActivitiesDescription':
          'Keep a record of your own statistics Update your Match Stats & Training Sessions to enhance your profile',
      'cleanSheetRequiredLower': 'clean sheet *',
      'goalsScoredRequiredLower': 'goals scored *',
      'cleanSheetsLower': 'clean sheets',
      'goalsScoredLower': 'goals scored',
      'pleaseEnterMatchMetric': 'Please enter {metric}.',
      'enterField': 'Enter {field}',
      'tagPlayersUpper': 'TAG PLAYERS',
      'searchByNameMinTwoCharacters': 'Search by name (min 2 characters)…',
      'endorsementsDescription':
          'View your Endorsements received by other Players &amp; Coaches Choose to either Publish or Reject the Endorsements received by you.',
      'reject': 'Reject',
      'publish': 'Publish',
      'doubleTapToCheer': 'Double Tap to Cheer',
      'cheerCount': '{count} cheer',
      'failedToUpdateProfileTryAgain':
          'Failed to update profile. Please try again.',
      'updateUpper': 'UPDATE',
      'savingEllipsis': 'Saving…',
      'trainingSession': 'Training Session',
      'gameTypeLabel': 'game type *',
      'matchDateLabel': 'Match Date *',
      'selectDate': 'Select date',
      'playingPositionLabel': 'Playing Position *',
      'positionTypeLabel': 'position type *',
      'numberOfAssistsLabel': 'number of assists *',
      'minutesPlayedLabel': 'minutes played *',
      'teamsPlayedLabel': 'teams played *',
      'teamA': 'team A',
      'teamB': 'team B',
      'teamALabel': 'Team A',
      'teamBLabel': 'Team B',
      'rateYourPerformanceLabel': 'rate your performance *',
      'howIPerformedLabel': 'how I performed *',
      'trainingSessionDateLabel': 'training session date *',
      'trainingSessionTypeLabel': 'training session type *',
      'trainingSessionMinutesLabel': 'training session minutes *',
      'trainingNotesLabel': 'training notes *',
      'typeToSearchPlayers': 'Type to search players',
      'userFallback': 'User',
      'pleaseSelectMatchDate': 'Please select a match date.',
      'pleaseRateYourPerformance': 'Please rate your performance.',
      'pleaseEnterMinutesPlayed': 'Please enter minutes played.',
      'matchActivityAdded': 'Match activity added!',
      'failedToAddMatch': 'Failed to add match. Please try again.',
      'pleaseSelectTrainingDate': 'Please select a training date.',
      'pleaseEnterTrainingMinutes': 'Please enter training minutes.',
      'trainingSessionAdded': 'Training session added!',
      'failedToAddTraining': 'Failed to add training. Please try again.',
      'pleaseSelectPlayingPosition': 'Please select a playing position',
      'pleaseSelectPositionType': 'Please select a position type',
      'selectMatchDate': 'Select match date',
      'selectPlayingPosition': 'Select playing position',
      'selectPositionType': 'Select position type',
      'myTeamNameLabel': 'My Team Name *',
      'enterYourTeamName': 'Enter your team name',
      'opponentTeamNameLabel': 'Opponent Team Name *',
      'enterOpponentTeamName': 'Enter opponent team name',
      'pleaseSelectTrainingType': 'Please select a training type',
      'trainingDateLabel': 'Training Date *',
      'selectTrainingDate': 'Select training date',
      'trainingTypeLabel': 'Training Type *',
      'selectTrainingType': 'Select training type',
      'trainingMinutesLabel': 'Training Minutes *',
      'enterTrainingMinutes': 'Enter training minutes',
      'notesOptionalLabel': 'Notes (optional)',
      'describeTrainingSession': 'Describe your training session...',
      'videos': 'Videos',
      'photos': 'Photos',
      'skillVideo': 'Skill Video',
      'skillVideoDescription':
          '(Share videos of you displaying your football skills in matches or in training to be endorsed or rated by SocaLoca users, including coaches and scouts.)',
      'footballMoments': 'Football Moments',
      'footballMomentsDescription':
          '(Share video of your football moments or any other football related content that is beneficial to the SocaLoca user base)',
      'typeAtLeast2CharsToSearch': 'Type at least 2 characters to search',
      'uploadingEllipsis': 'Uploading...',
      // Referee screens
      'startSecondHalf': 'Start Second Half',
      'startExtraTime': 'Start Extra Time',
      'startPenalty': 'Start Penalty',
      'matchEndedSuccessfully': 'Match ended successfully',
      'selectScorerFromOneTeam': 'Select scorer from only ONE team',
      'pleaseSelectScorer': 'Please select a scorer',
      'selectCardHolderFromOneTeam': 'Select card holder from only ONE team',
      'pleaseSelectCardHolder': 'Please select a card holder',
      'pleaseSelectCardType': 'Please select card type (1st / 2nd / Red)',
      'pleaseSelectCardTime': 'Please select card time',
      'selectSubstitutionFromOneTeam': 'Select substitution from only ONE team',
      'pleaseSelectPlayersForSubstitution':
          'Please select players for substitution',
      'pleaseSelectPlayerInForMyTeam': 'Please select player IN for My Team',
      'pleaseSelectPlayerInForOpponent':
          'Please select player IN for Opponent Team',
      'pleaseSelectPlayerOutForMyTeam': 'Please select player OUT for My Team',
      'pleaseSelectPlayerOutForOpponent':
          'Please select player OUT for Opponent Team',
      'playerInAndOutSame': 'Player IN and Player OUT cannot be the same',
      'pleaseEnterSubstitutionTime': 'Please enter substitution time',
      'eventTimeTooLarge': 'Event time cannot be greater than match time',
      'halfTime': 'Half Time',
      'endSecondHalf': 'End Second Half',
      'endExtraTime': 'End Extra Time',
      'endMatch': 'End Match',
      'postponed': 'Postponed',
      'abandoned': 'Abandoned',
      'liveMatchUpdates': 'Live Match Updates',
      'caution': 'Caution',
      'neverCloseAppDuringMatch': 'Never close the app while the match is live',
      'tapSaveAndPublishWhenSure':
          'Tap "SAVE & PUBLISH" only when you are sure',
      'matchEnd': 'Match End',
      'goal': 'Goal',
      'myRequests': 'My Requests',
      'myRequestsDescription':
          'Find all the matches here assigned to you by the Tournament Organisers. You can accept or decline as per your preference. All accepted matches will be under "My Matches"',
      'noPendingMatchRequests': 'No pending match requests',
      'requestAccepted': 'Request accepted',
      'requestDeclined': 'Request declined',
      // Social Feed
      'reportPost': 'Report Post',
      'blockPost': 'Block Post',
      'pleaseSelectReason': 'Please select a reason',
      'blockUserDescription':
          'You will no longer receive any post or view any comment from the user '
              'you are blocking. People you block can no longer tag you, start a '
              'conversation with you, add you in his/her network or see things you '
              'post in the SocaLoca feed. If you follow each other, blocking will '
              'automatically unfollow that user.',
      'reportSubmittedThankYou': 'Report submitted. Thank you.',
      'failedToReportPost': 'Failed to report post.',
      'postBlocked': 'Post blocked.',
      'failedToBlockPost': 'Failed to block post.',
      'userBlocked': 'User blocked.',
      'failedToBlockUser': 'Failed to block user.',
      'failedToReportUser': 'Failed to report user.',
      // Pickup Match
      'pleaseSelectStartTime': 'Please select start time',
      'pleaseSelectEndTime': 'Please select end time',
      'endTimeMustBeAfterStartTime': 'End time must be after start time',
      'pleaseSelectAgeGroup': 'Please select age group',
      'pleaseSelectLocation': 'Please select location',
      'userNotFound': 'User not found',
      'failedToHostMatch': 'Failed to host match. Please try again.',
      'startTimeRequired': 'Start Time *',
      'endTimeRequired': 'End Time *',
      'venueNameRequired': 'Venue name *',
      'venueNameIsRequired': 'Venue name is required',
      'venueNameMinLength': 'Venue name must be at least 3 characters',
      'selectLocationFromMapRequired': 'Select location from map *',
      'maxPlayersRequired': 'Max players *',
      'maxPlayersIsRequired': 'Max players is required',
      'mustBePositiveNumber': 'Must be a positive number',
      'matchNoteHint': 'Match Note',
      'errorLoadingMatchDetails': 'Error loading match details',
      'failedToSendRequest': 'Failed to send request. Please try again.',
      'maxPlayers': 'Max Players',
      'date': 'Date',
      'host': 'Host',
      'viewRequestsUpper': 'VIEW REQUESTS',
      'acceptedUpper': 'ACCEPTED',
      'declinedUpper': 'DECLINED',
      'errorLoadingRequests': 'Error loading requests',
      'failedToUpdateRequest': 'Failed to update request. Please try again.',
      'noRequestsYet': 'No requests yet',
      'accepted': 'Accepted',
      'declined': 'Declined',
      // Settings
      'newPasswordMinLength': 'New password must be at least 6 characters',
      'newPasswordSameAsCurrent': 'New password cannot be the same as current',
      'passwordsDoNotMatch': 'Passwords do not match',
      'userSessionNotFound': 'User session not found. Please log in again.',
      'failedToChangePassword': 'Failed to change password. Please try again.',
      'somethingWentWrongTryAgain': 'Something went wrong. Please try again.',
      'currentPasswordHint': 'Current Password *',
      'newPasswordHint': 'New Password *',
      'confirmPasswordHint': 'Confirm Password *',
      'pleaseEnterName': 'Please enter name',
      'thisIsYourOwnEmail': 'This is your own email, try another',
      'legacyContactDescription':
          'Your Legacy Contact the person that you may nominate to inherit '
              'your account should any unseen circumstances fall upon you and '
              'you are unable to access your account.',
      'legacyContactInstruction':
          'Nominate your legacy contact by providing their full name and '
              'email address.',
      'nameRequired': 'Name *',
      'aboutSocaLoca': 'About SocaLoca',
      'aboutSocaLocaText':
          'SocaLoca is the world\'s first global football social media platform '
              'dedicated to connecting players, clubs, coaches, referees, and fans. '
              'Our mission is to make football accessible to everyone, everywhere — '
              'from grassroots to professional. We provide tools for match management, '
              'player development, club administration, and community building within '
              'the beautiful game.',
      'couldNotOpenLink': 'Could not open link',
      'gdprComplianceText':
          'SocaLoca is in compliance with GDPR practices to protect you the user!',
      'downloadActivityEmailInstructions':
          'To request for your data, please fill in your email address here '
              'and we shall get back to you on how to pass the data to you.',
      'pleaseEnterValidEmailAddress': 'Please enter a valid email address',
      'deactivateDeleteAccount': 'Deactivate/Delete Account',
      'sorryToSeeYouLeave': 'We are sorry that you want to leave.',
      'deleteOrDeactivateChoice':
          'You may choose to either delete or deactivate your account.',
      'deletionDescription':
          'Deletion will remove your account from the SocaLoca systems and '
              'you will not be able to use the account again.',
      'deactivationDescription':
          'Deactivation will make your account inactive. Should you want to '
              'reactivate your account, you just need to login to SocaLoca and '
              'your account will be restored.',
      'accountSubmittedForDeletion': 'Account submitted for deletion',
      'accountDeactivated': 'Account deactivated',
      'noUpper': 'NO',
      'yesUpper': 'YES',
      'legacyContact': 'Legacy Contact',
      'manageAccount': 'Manage Account',
      'deactivateDeleteAccountSubItem': 'Deactivate / Delete Account',
      'dataPrivacy': 'Data Privacy',
      // Club / partners screens
      'clubsPartnerIntro':
          'These are the Professional Football Clubs that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Professional Football Club, you can request to become a SOCALOCA partner and gain access to a wide range of features, including an individualized hub with your logo and branding, in-app uploads of game highlights, training sessions, and interviews, the ability to advertise upcoming trials through your club’s dedicated hub, showcase your club teams and top players, engage fans with news, announcements, and recent results, display sponsors, and much more.',
      'footballAssociationsIntro':
          "These are the Football Associations that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Football Association, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to organize tournaments and leagues using SOCALOCA's tournament module, upload game highlights, training sessions, or interviews directly within the app, engage fans with the latest news and announcements, showcase sponsors, and access a data-driven overview of your Football Association's stakeholders through SOCALOCA Analytics, plus much more.",
      'footballConfederationsIntro':
          "These are the Football Confederations that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Confederation, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to organize tournaments and leagues using SOCALOCA's tournament module, upload game highlights, training sessions, or interviews directly within the app, engage fans with the latest news and announcements, showcase sponsors, and access a data-driven overview of your Football Confederation's stakeholders through SOCALOCA Analytics, plus much more.",
      'sponsorsIntro':
          'These are the Sponsors that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Sponsor, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to showcase merchandise and services, promote your company through news and announcements, expand your reach, send push notifications to segmented audiences, measure your CSR impact, and much more.',
      'charitiesNgosIntro':
          'These are the Charities, NGOs, and Social Enterprises that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Charity, NGO, or Social Enterprise, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to showcase your projects and initiatives, reach a wider audience, upload videos and photos, engage with followers, measure the impact of your CSR activities, and positively influence the SOCALOCA community.',
      'errorLoadingClubs': 'Error loading clubs',
      'noFasFound': 'No FAs found',
      'noConfederationsFound': 'No confederations found',
      'noSponsorsFound': 'No sponsors found',
      'noCharitiesNgosFound': 'No charities & NGOs found',
      'confederation': 'Confederation',
      'confderations': 'Confderations',
      'clubNotFound': 'Club not found',
      'faNotFound': 'FA not found',
      'sponsorNotFound': 'Sponsor not found',
      'charityNotFound': 'Charity not found',
      'couldNotLoadClubData': 'Could not load club data. ',
      'nickname': 'Nickname',
      'formed': 'Formed',
      'formedIn': 'Formed In',
      'city': 'City',
      'fifaIdLabel': 'FIFA ID: ',
      'liveTrial': 'LIVE TRIAL',
      'registrationClosed': 'REGISTRATION CLOSED',
      'newsAnnouncements': 'News & Announcements',
      'viewAllPlayers': 'View All Players',
      'clubTeams': 'Club Teams',
      'clubSponsors': 'Club Sponsors',
      'homeAwayThirdKit': 'Home Kit | Away Kit | Third Kit',
      'otherCompetitions': 'Other Competitions',
      'men': 'Men',
      'women': 'Women',
      'kit': 'Kit',
      'playersTitle': 'Players',
      'galleryTitle': 'Gallery',
      'liveTrials': 'Live Trials',
      'noTrialsFound': 'No Trials Found',
      'pleaseSelectFilter': 'Please select a filter',
      'toAgeGreaterThanFromAge': 'To age must be greater than from age',
      'from': 'From',
      'to': 'To',
      'searchUpper': 'SEARCH',
      'liveNow': 'LIVE NOW',
      'live': 'LIVE',
      'liveUpper': 'LIVE',
      'regCloses': 'Reg. Closes',
      'trialStarts': 'Trial Starts',
      'age': 'Age',
      'cost': 'Cost',
      'trialVenue': 'Trial Venue',
      'trialDate': 'Trial Date',
      'registration': 'Registration',
      'brief': 'Brief',
      'registrationRestrictedLong':
          'Registration restricted. Your profile does not match the trial criteria. SocaLoca will notify you of future Live trials!',
      'registrationRestrictedShort':
          'Registration restricted. Your profile does not match the trial criteria.',
      'trialRegistrationThanks':
          'Thank you for participating in live trial. Please check your mail for instructions.',
      'registeredSuccessfully': 'Registered successfully!',
      'registrationFailedTryAgain': 'Registration failed. Try again.',
      'free': 'Free',
      'foundation': 'Foundation',
      'president': 'President',
      'generalSecretary': 'General Secretary',
      'viewAllCompetitions': 'view all competitions',
      'featuredTeams': 'Featured Teams',
      'viewAllTeams': 'view all teams',
      'headquarters': 'Headquarters',
      'founded': 'Founded',
      'ceo': 'CEO',
      'founders': 'Founders',
      'merchandise': 'Merchandise',
      'view': 'View',
      'chairman': 'Chairman',
      'fundingPartners': 'Funding Partners',
      'partner': 'Partner',
      'basicInfo': 'Basic Info',
      'position': 'Position',
      'jersey': 'Jersey',
      'playerNotFound': 'Player not found',
      'footballStats': 'Football Stats',
      'futsalStats': 'Futsal Stats',
      'matchCountLabel': 'Matches',
      'followerCount': '{count} Follower',
      'followersCount': '{count} Followers',
      'failedToUpdateFollowStatus': 'Failed to update follow status: {error}',
      'footballStatsYear': 'Football Stats ({year})',
      'futsalStatsYear': 'Futsal Stats ({year})',
      'cannotHostMatch': 'Cannot Host Match',
      'hostMatchRestriction':
          'Only Players, Coaches, Admins, and Referees can host pickup matches.',
      'pickupMatchDescription':
          "Can't get 2 full teams to make a match? Fret not. Pick-Up matches allows you to organise an informal kick-about at a specified place and time. Shout out to all nearby that you are organising a pick-up match and get your game on!",
      'hostMatchUpper': 'HOST MATCH',
      'noUpcomingPickupMatches': 'No upcoming pickup matches',
      'errorLoadingMatches': 'Error loading matches',
      'academiesDescription':
          'SocaLoca is the home for football academies of any scale, age category, playing level, or location. SocaLoca provides an innovative and intuitive platform designed around the modern needs of a football academy.',
      'goUpper': 'GO',
      'noAcademiesFound': 'No academies found.',
      'addTrainingSession': 'Add Training Session',
      'matchDetailsAdded': 'Match details added',
      'addGameTypeMatch': 'Add {gameType} Match',
      'goalsSavedRequired': 'Goals Saved *',
      'goalsScoredRequired': 'Goals Scored *',
      'egThree': 'e.g. 3',
      'egTwo': 'e.g. 2',
      'goalsSaved': 'Goals saved',
      'egOne': 'e.g. 1',
      'egSixty': 'e.g. 60',
      'egNinety': 'e.g. 90',
      // 'teamName': 'Team name',
      'opponentTeamName': 'Opponent team name',
      'describeHowYouPerformed': 'Describe how you performed...',
      'videoLargerThanAvailableSpace': 'Video larger than available space',
      'pleaseWriteSomething': 'Please write something',
      'pleaseSelectAtLeastOnePhoto': 'Please select at least one photo',
      'pleaseSelectAVideo': 'Please select a video',
      'uploadingPhotoOf': 'Uploading photo {current} of {total}...',
      'updatingPost': 'Updating post...',
      'publishingPost': 'Publishing post...',
      'postUpdatedSuccessfully': 'Post updated successfully!',
      'postPublishedSuccessfully': 'Post published successfully!',
      'writeSomething': 'Write something',
      'tagPeopleUpper': 'TAG PEOPLE',
      'postType': 'Post Type',
      'choose': 'Choose',
      'notifyCoachesToEndorse':
          'Notify all coaches/managers/scounts to endorse video',
      'invitePlayersUpper': 'INVITE PLAYERS',
      'updatePostUpper': 'UPDATE POST',
      'addPhotosCount': 'Add Photos ({current}/{max})',
      'maxPhotosAllowed': '(max {max} photos allowed)',
      'changeVideo': 'Change Video',
      'uploadVideos': 'Upload Videos',
      'maxVideosAllowed': '(max 10 videos allowed)',
      'availableSpace': 'Available Space : ',
      'usedSpace': 'Used Space : ',
      'zeroMB': '0MB',
      'maxMB': '1024MB',
      'tagPlayers': 'Tag Players',
      'done': 'Done',
      'searchPlayersEllipsis': 'Search players...',
    },

    // ── Spanish ─────────────────────────────────────────────────────────────
    'es': {
      'appName': 'SocaLoca',
      'cancel': 'Cancelar',
      'submit': 'Enviar',
      'yes': 'SÍ',
      'no': 'No',
      'search': 'Buscar',
      'searchEllipsis': 'Buscar...',
      'locationPermission': 'Permiso de ubicación',
      'locationPermissionDesc':
          'SocaLoca solicita acceso a tu ubicación para conectarte con la Asociación de Fútbol de tu país. SocaLoca también usa tu ubicación para encontrar la ubicación de tu torneo. Tus datos de ubicación solo se usan para ayudarte a navegar por tu recorrido futbolístico y no se guardan para ningún otro propósito.',
      'learnMore': 'Más información',
      'searchHere': 'Buscar aquí',
      'playerCoachManagerReferee': 'Jugador/Entrenador/Manager/Árbitro',
      'byCountry': 'Por país',
      'byType': 'Por tipo',
      'byChoice': 'Por elección',
      'mostPosts': 'Más publicaciones',
      'mostAppearances': 'Más apariciones',
      'mostGoals': 'Más goles',
      'endorsedByUpper': 'RESPALDADO POR',
      'followersUpper': 'SEGUIDORES',
      'noResultsFound': 'No se han encontrado resultados',
      'profileDetailsNotAvailable': 'Detalles del perfil aún no disponibles',
      'back': 'Atrás',
      'save': 'GUARDAR',
      'delete': 'Eliminar',
      'deactivate': 'Desactivar',
      'report': 'Reportar',
      'follow': 'Seguir',
      'following': 'Siguiendo',
      'followers': 'Seguidores',
      'viewAll': 'Ver Todo',
      'comingSoon': 'Próximamente',
      'somethingWentWrong': '¡Algo salió mal!',
      'na': 'N/D',
      'gotIt': 'Entendido',
      'upgrade': 'MEJORAR',
      'helpdesk': 'Ayuda',
      'mandatoryFields': '* campos obligatorios',
      'goToHome': 'Ir a inicio',
      'selectLanguage': 'Seleccionar idioma',
      'selectLanguageDesc':
          'SocaLoca está disponible en varios idiomas. Por favor selecciona uno para continuar.',
      'pleaseSelectLanguage': 'Por favor selecciona un idioma',
      'signIn': 'INICIAR SESIÓN',
      'signUp': 'REGISTRARSE',
      'signOut': 'Cerrar sesión',
      'login': 'Iniciar sesión',
      'forgotPassword': '¿Olvidaste tu contraseña?',
      'socialLoginNoPassword':
          'Hola ... Has utilizado el inicio de sesión con redes sociales. Sin necesidad de contraseñas.',
      'email': 'Correo electrónico *',
      'emailPlain': 'Correo electrónico',
      'enterYourEmail': 'Introduce tu correo electrónico',
      'password': 'Contraseña *',
      'enterYourPassword': 'Introduce tu contraseña',
      'newPassword': 'Nueva contraseña *',
      'enterYourNewPassword': 'Introduce tu nueva contraseña',
      'confirmPassword': 'Confirmar contraseña *',
      'currentPassword': 'Contraseña actual *',
      'enterYourCurrentPassword': 'Introduce tu contraseña actual',
      'changePassword': 'Cambiar contraseña',
      'resetPassword': 'RESTABLECER',
      'sendOtp': 'ENVIAR OTP',
      'sendResetLink': 'ENVIAR ENLACE DE RESTABLECIMIENTO',
      'resend': 'REENVIAR',
      'haventReceivedCode': '¿No recibiste el código?  ',
      'otpLabel': 'OTP *',
      'socaLocaId': 'ID de SocaLoca',
      'mobile': 'Móvil',
      'enterSocaLocaId': 'Introduce tu ID de SocaLoca',
      'enterMobileNumber': 'Introduce el número de móvil',
      'pleaseEnterEmail': 'Ingresa tu correo electrónico',
      'pleaseEnterValidEmail': 'Ingresa un correo electrónico válido',
      'pleaseEnterPassword': 'Por favor ingresa una contraseña',
      'minimumSixCharacters': 'Mínimo 6 caracteres',
      'pleaseConfirmPassword': 'Por favor confirma la contraseña',
      'passwordDoesNotMatch': 'Las contraseñas no coinciden',
      'passwordDoNotMatch': 'Las contraseñas no coinciden',
      'invalidCurrentPassword': 'Contraseña actual inválida',
      'pleaseEnterCurrentPassword': 'Por favor ingresa la contraseña actual',
      'pleaseEnterNewPassword': 'Por favor ingresa la nueva contraseña',
      'pleaseConfirmNewPassword': 'Por favor confirma la nueva contraseña',
      'passwordChangedSuccessfully': 'Contraseña cambiada correctamente',
      'pleaseEnterOtp': 'Por favor ingresa el OTP',
      'verificationCodeSent': 'Código de verificación enviado correctamente',
      'passwordResetSuccess':
          'Contraseña restablecida correctamente. Por favor inicia sesión.',
      'strong': 'Fuerte',
      'weak': 'Débil',
      'firstName': 'Nombre *',
      'lastName': 'Apellido *',
      'profileName': 'Nombre de perfil *',
      'enterYourName': 'Introduce tu nombre',
      'dateOfBirth': 'Fecha de nacimiento *',
      'country': 'País',
      'gender': 'Género *',
      'male': 'Masculino',
      'female': 'Femenino',
      'nationality': 'Nacionalidad',
      'playingPosition': 'Posición de juego *',
      'preferredFoot': 'Pie preferido',
      'right': 'Derecho',
      'left': 'Izquierdo',
      'height': 'Altura',
      'heightCms': 'Altura (cms)',
      'editProfile': 'Editar perfil',
      'createProfile': 'Crear perfil',
      'uploadProfilePhoto': 'Sube tu foto de perfil',
      'takeAPhoto': 'Tomar una foto',
      'chooseFromGallery': 'Elegir de la galería',
      'selectImage': 'Seleccionar imagen',
      'myGallery': 'Mi galería',
      'pleaseEnterFirstName': 'Por favor ingresa el nombre',
      'pleaseEnterLastName': 'Por favor ingresa el apellido',
      'pleaseEnterProfileName': 'Por favor ingresa el nombre de perfil',
      'pleaseEnterDateOfBirth': 'Por favor ingresa la fecha de nacimiento',
      'pleaseSelectNationality': 'Por favor selecciona la nacionalidad',
      'home': 'Inicio',
      'teams': 'Equipos',
      'players': 'Jugadores',
      'match': 'Partido',
      'matches': 'Partidos',
      'clubsAndPartners': 'Clubes y socios',
      'notifications': 'Notificaciones',
      'noNotifications': 'No hay notificaciones por ahora',
      'tournaments': 'Torneos',
      'clubs': 'Clubes',
      'partners': 'Socios',
      'academy': 'Academia',
      'recentMatches': 'Partidos recientes',
      'upcomingMatches': 'Próximos partidos',
      'noUpcomingMatches': 'Sin próximos partidos',
      'playedMatches': 'Partidos jugados',
      'noPlayedMatches': 'Sin partidos jugados',
      'todaysMatches': 'Partidos de hoy',
      'hostMatch': 'Organizar partido',
      'manageRequests': 'Gestionar solicitudes',
      'selectTournamentRequired': 'seleccionar torneo *',
      'myMatches': 'My Matches',
      'myMatchesTournament':
          'Find all the matches assigned to you by the Tournament Organisers. Update scores and records by tapping "Manage". Download Match Report once a match is updated.',
      'noMatchesAreFound': 'No se encontraron partidos!!!',
      'manage': 'Gestionar',
      'downloadMatchReport': 'Descargar informe del partido',
      'liveMatches': 'Live Matches',
      'liveMatchTournament':
          'Find all the matches assigned to you by the Tournament Organiser here. Tap on "START MATCH" to publish "Live Scores".',
      'noLiveMatchesAvailable': 'No hay partidos en vivo disponibles!!!',
      'startMatch': 'Iniciar partido',
      'abandonMatch': 'Abandonar partido',
      'saveAndPublish': 'Guardar y publicar',
      'matchStatus': 'Estado del partido',
      'goals': 'Goles',
      'cards': 'Tarjetas',
      'substitution': 'Sustitución',
      'ownGoal': 'Gol en propia puerta',
      'penalty': 'Penalti',
      'penaltyMissed': 'Penalti fallado',
      'minutesShort': '(Min.)',
      'selectScorer': 'Seleccionar goleador',
      'selectAssist': 'Seleccionar asistencia',
      'selectPlayer': 'Seleccionar jugador',
      'firstCard': '1ra',
      'secondCard': '2da',
      'redCardShort': 'Roja',
      'playerIn': 'Jugador entra',
      'playerOut': 'Jugador sale',
      'selectInPlayer': 'Seleccionar jugador entrante',
      'selectOutPlayer': 'Seleccionar jugador saliente',
      'ongoing': 'En curso',
      'upcoming': 'Próximos',
      'closed': 'Cerrados',
      'myLeaguesCups': 'Mis ligas/copas',
      'today': 'Hoy',
      'noMatchForToday': 'No hay partidos hoy',
      'pickup': 'Pick-Up',
      'oneOff': 'Único',
      'endorsements': 'Avales',
      'noEndorsementsYet': 'Aún sin avales',
      'endorsedSuccessfully': 'Avalado correctamente',
      'alreadyEndorsed': 'Ya avalado',
      'appearance': 'Aparición',
      'appearances': 'Apariciones',
      'playerBio': 'Biografía del jugador',
      'clubBio': 'Biografía del club',
      'league': 'Liga',
      'stadium': 'Estadio',
      'featuredPlayers': 'Jugadores destacados',
      'born': 'Nacido',
      'goalScored': 'Goles marcados',
      'assists': 'Asistencias',
      'yellowCard': 'Tarjeta amarilla',
      'redCard': 'Tarjeta roja',
      'mvp': 'MVP',
      'liked': 'Me gusta',
      'tapToLike': 'Toca para dar me gusta',
      'tapToFollow': 'Toca para seguir',
      'noPlayerJoinedYet': 'Aún no se ha unido ningún jugador',
      'myTeams': 'Mis equipos',
      'createTeam': 'Crear equipo',
      'noTeamsFound': 'No se encontraron equipos.',
      'addPlayers': 'Añadir jugadores',
      'noClubsFound': 'No se encontraron clubes.',
      'noTournamentsFound': 'No se encontraron torneos.',
      'competitions': 'Competencias',
      'noCompetitionsFound': 'No se encontraron competencias.',
      'fas': 'FAs',
      'confederations': 'Confederaciones',
      'sponsors': 'Patrocinadores',
      'charitiesAndNgos': 'Organizaciones benéficas y ONGs',
      'noPostsFound': 'No se encontraron publicaciones.',
      'post': 'Publicación',
      'posts': 'Publicaciones',
      'createPost': 'Crear publicación',
      'uploadImage': 'Subir imágenes',
      'uploadVideo': 'Subir video',
      'reportThisPost': 'Reportar esta publicación',
      'pleaseSelectACause': 'Por favor selecciona una razón',
      'pleaseSelectAtLeastOneFilter': 'Por favor selecciona al menos un filtro',
      'location': 'Ubicación',
      'selectLocation': 'Seleccionar ubicación',
      'ageGroup': 'Grupo de edad',
      'game': 'Juego',
      'register': 'Registrarse',
      'registered': 'Registrado',
      'liveTrialRegistration': 'Registro de prueba en vivo',
      'deleteAccount': 'Desactivar/Eliminar cuenta',
      'deleteAccountConfirmation':
          '¿Estás segura de que quieres eliminar tu cuenta?',
      'deactivateAccountConfirmation':
          '¿Estás segura de que quieres desactivar tu cuenta?',
      'downloadActivities': 'Descargar actividades',
      'welcomeBack': '¡Bienvenido de nuevo!!!',
      'weTrulyMissedYou': 'Te hemos echado de menos.',
      'hello': 'Hola,',
      'cheers': 'ÁNIMOS',
      'myBio': 'Mi biografía',
      'myPosts': 'Mis publicaciones',
      'myRatings': 'Mis valoraciones',
      'gallery': 'Galería',
      'sharePostPrompt': 'Comparte una foto o video y escribe\nalgo.',
      'createPostUpper': 'CREAR PUBLICACIÓN',
      'mostEndorsedPlayers': 'Jugadores más avalados',
      'mostFollowedTeams': 'Equipos más seguidos',
      'recentlyJoinedTeams': 'Equipos recién unidos',
      'ongoingTournaments': 'Torneos en curso',
      'matchUpdates': 'Actualizaciones de partidos',
      'viewDetails': 'VER DETALLES',
      'trials': 'Pruebas',
      'updateProfile': 'Actualizar perfil',
      'changeLanguage': 'Cambiar idioma',
      'helpDesk': 'Mesa de ayuda',
      'privacySettings': 'Configuración de privacidad',
      'helpUsToImprove': 'Ayúdanos a mejorar',
      'dataPolicy': 'Política de datos',
      'termsAndConditions': 'Términos y condiciones',
      'signOutUpper': 'CERRAR SESIÓN',
      'academies': 'Academias',
      'menu': 'Menú',
      'retry': 'Reintentar',
      'ok': 'OK',
      'block': 'Bloquear',
      'blockUser': 'Bloquear usuario',
      'reportUser': 'Reportar usuario',
      'selectReason': 'Selecciona una razón:',
      'requestCancelled': 'Solicitud cancelada.',
      'failedToSubmitEndorsement':
          'No se pudo enviar el aval. Inténtalo de nuevo.',
      'requests': 'Solicitudes',
      'noPendingRequests': 'No hay solicitudes pendientes.',
      'pendingRequests': 'Solicitudes pendientes',
      'teamInvitations': 'Invitaciones de equipo',
      'noTeamInvitations': 'No hay invitaciones de equipo.',
      'accept': 'Aceptar',
      'decline': 'Rechazar',
      'joinedTeams': 'Equipos unidos',
      'noPostsYet': 'Aún no hay publicaciones.',
      'noPosts': 'Sin publicaciones',
      'noPlayers': 'Sin jugadores',
      'matchNotFound': 'Partido no encontrado',
      'tournamentNotFound': 'Torneo no encontrado',
      'requestSentSuccessfully': '¡Solicitud enviada correctamente!',
      'matchHostedSuccessfully': '¡Partido organizado correctamente!',
      'pleaseTickCheckbox': 'Por favor marca la casilla',
      'verifiedSuccessfully': '¡Verificado correctamente!',
      'pleaseSelectAtLeastOneRole': 'Por favor selecciona al menos un rol',
      'failedCreateProfile': 'No se pudo crear el perfil. Inténtalo de nuevo.',
      'failedUpdateProfile':
          'No se pudo actualizar el perfil. Inténtalo de nuevo.',
      'profileUpdatedSuccessfully': 'Perfil actualizado correctamente',
      'yourEmail': 'Tu correo electrónico',
      'aboutMe': 'Sobre mí',
      'preferredJerseyNumber': 'Número de camiseta preferido',
      'playingLevel': 'Nivel de juego',
      'shirtJerseySize': 'Talla de camiseta',
      'shoeSize': 'Talla de calzado',
      'majorLeaguesYouFollow': 'Ligas principales que sigues',
      'teamsYouFollow': 'Equipos que sigues',
      'takePhotoUpper': 'TOMAR UNA FOTO',
      'chooseGalleryUpper': 'ELEGIR DE LA GALERÍA',
      'warning': 'Advertencia',
      'confirmEndMatch': '¿Estás seguro de que quieres terminar este partido?',
      'jerseysAssigned': 'Camisetas asignadas',
      'inviteSent': 'Invitación enviada',
      'enterAtLeast3Chars': 'Ingresa al menos 3 caracteres para buscar',
      'noPlayersFound': 'No se encontraron jugadores',
      'invitationSentAll': 'Invitación enviada a todos los números',
      'profileNameNotAvailable': 'El nombre de perfil no está disponible',
      'selectYear': 'Seleccionar año',
      'camera': 'Cámara',
      'teamInfoUpdated': 'Información del equipo actualizada',
      'pom': 'POM',
      'score': 'Marcador',
      'squad': 'Plantilla',
      'pointsTable': 'Tabla de Puntos',
      'stats': 'Estadísticas',
      'groupStage': 'Fase de Grupos',
      'knockout': 'Eliminatoria',
      'manOfMatch': 'Jugador del Partido',
      'searchAndInvite': 'Buscar e Invitar',
      'inviteByPhone': 'Invitar por Teléfono',
      'createPlayer': 'Crear Jugador',
      'all': 'Todos',
      'joined': 'Unido',
      'pending': 'Pendiente',
      'received': 'Recibido',
      'newRequests': 'Nuevas Solicitudes',
      'newPlayers': 'Nuevos Jugadores',
      'jerseyAssigned': 'Camiseta Asignada',
      'phoneNumber': 'Número de Teléfono',
      'jerseyNumberHint': 'Número de camiseta o "entrenador"/"manager"',
      'enterTextHint': 'Ingresa texto aquí (máx. 150 caracteres)',
      'mobileNumber': 'Número de móvil',
      'countryCode': 'Código de país',
      'countryIso': 'ISO del país',
      'otp': 'OTP',
      'passwordHint': 'Contraseña',
      'selectPhoto': 'Seleccionar Foto',
      'gameType': 'Tipo de Juego',
      'football': 'Fútbol',
      'futsal': 'Futsal',
      'ageRange': 'Rango de Edad',
      'ageCategory': 'Categoría de Edad',
      'updateTeam': 'Actualizar Equipo',
      'teamName': 'Nombre del Equipo',
      'shortNameHint': 'Nombre Corto (máx. 4 chars)',
      'cityAddress': 'Ciudad / Dirección',
      'selectAgeRange': 'Seleccionar rango de edad',
      'selectAgeCategory': 'Seleccionar categoría de edad',
      'teamNameRequired': 'El nombre del equipo es obligatorio',
      // Referee manage match
      'failedToLoadMatchDetails': 'Error al cargar los detalles del partido',
      'pleaseEnterScoreProperly': 'Por favor ingresa el marcador correctamente',
      'pleaseEnterExtraTimeDetails':
          'Por favor ingresa los detalles del tiempo extra',
      'pleaseEnterPenaltyDetails':
          'Por favor ingresa los detalles de los penaltis',
      'matchScoreSaved': 'Marcador del partido guardado',
      'extraTime': 'Tiempo Extra',
      'time': 'Tiempo',
      'scorer': 'Goleador',
      'noOfCards': 'Número de tarjetas',
      'player': 'Jugador',
      'pleaseSelectPom': 'Por favor selecciona al jugador del partido',
      'coach': 'Entrenador',
      'manager': 'Manager',
      'pleaseSelectPlayersFromBothTeams':
          'Por favor selecciona jugadores de ambos equipos',
      'minute': 'Minuto',
      'pleaseEnterSubstituteDetails':
          'Por favor ingresa los detalles del sustituto',
      'matchIncidents': 'Incidentes del Partido',
      'enterTextMax200': 'Ingresa texto aquí (máx. 200 caracteres)',
      'matchCommissionerReport': 'Informe del Comisionado',
      'enterTextMax300': 'Ingresa texto aquí (máx. 300 caracteres)',
      'commissionerReportSaved':
          '¡Informe del Comisionado guardado correctamente!!!',
      'uploadMatchPhotos': 'Subir Fotos del Partido',
      'savePhotos': 'Guardar Fotos',
      'uploadMatchHighlights': 'Subir Momentos Destacados',
      'saveHighlights': 'Guardar Momentos',
      'uploadMatchVideos': 'Subir Videos del Partido',
      'saveVideos': 'Guardar Videos',
      'maxPhotosUpload': 'Se pueden subir máximo 5 fotos',
      'uploadingPhoto': 'Subiendo foto...',
      'maxVideoSizeUpload': 'Se puede subir un video de máximo 15MB',
      'uploadingHighlight': 'Subiendo momento destacado...',
      'maxVideosUpload': 'Se pueden subir máximo 2 videos',
      'uploadingVideo': 'Subiendo video...',
      'pleaseSelectMp4OrMov': 'Por favor selecciona un archivo mp4 o mov',
      'pleaseEnterGoalDetails': 'Por favor ingresa los detalles del gol',
      'pleaseEnterCardDetails': 'Por favor ingresa los detalles de la tarjeta',
      'officialsProgressSaved': 'Oficiales del club y equipo guardados',
      'noMembersAvailable': 'No hay miembros disponibles',
      'matchDetails': 'Detalles del Partido',
      'matchDate': 'Fecha del Partido',
      'matchTime': 'Hora del Partido',
      'tbd': 'Por Definir',
      'videoPublishedToFeed': 'Video publicado en el feed',
      'uploadComplete': 'Carga completa',
      'round': 'Ronda',
      // Academies
      'academyNotFound': 'Academia no encontrada',
      'joiningRequestSent': 'Solicitud de ingreso enviada',
      'director': 'Director',
      'foundedYear': 'Año de fundación',
      'academyJoined': 'Academia unida',
      'cancelRequest': 'Cancelar solicitud',
      'sendRequest': 'Enviar solicitud',
      'cat': 'CAT',
      'about': 'Acerca de',
      'bio': 'Bio',
      'academyDirector': 'Director de la academia',
      'academyManager': 'Manager de la academia',
      'academyContactNumber': 'Número de contacto de la academia',
      'academyContactEmail': 'Correo de contacto de la academia',
      'skillVideos': 'Videos de habilidades',
      'matchVideos': 'Videos del partido',
      'academyNews': 'Noticias de la academia',
      'registrationSuccessful': '¡Registro exitoso!',
      'registrationFailed': 'Registro fallido. Por favor inténtalo de nuevo.',
      'emailIsRequired': 'El correo electrónico es obligatorio',
      'enterValidEmailAddress':
          'Ingresa una dirección de correo electrónico válida',
      'category': 'Categoría',
      // Live Match
      'substitutions': 'Sustituciones',
      'penaltyShootout': 'Penales',
      'lineUp': 'Alineación',
      'goalkeepers': 'Porteros',
      'defenders': 'Defensas',
      'midfielders': 'Centrocampistas',
      'attackers': 'Delanteros',
      'ogShort': 'AG',
      'penShort': 'Pen',
      'assist': 'Asistencia',
      'missed': 'Fallado',
      'vs': 'vs',
      // My Bio
      'myStats': 'Mis Estadísticas',
      'ratings': 'Calificaciones',
      'minimumFiveCharsRequired': 'Mínimo 5 caracteres requeridos',
      'minimumFiveCharacters': 'mínimo 5 caracteres',
      'pleaseSelectDateOfBirth': 'Por favor selecciona la fecha de nacimiento',
      'dateOfBirthPlaceholder': 'fecha de nacimiento *',
      'editPost': 'Editar publicación',
      'deletePost': 'Eliminar publicación',
      'deletePostConfirm':
          '¿Estás seguro de que quieres eliminar esta publicación?',
      'postDeleted': 'Publicación eliminada',
      'couldNotDeletePost':
          'No se pudo eliminar la publicación. Inténtalo de nuevo.',
      'unknown': 'Desconocido',
      'failedToLoadRatings': 'Error al cargar calificaciones',
      'overallScoreMultiline': 'PUNTUACIÓN\nGENERAL',
      'skillAttributeRating': 'Calificación de habilidades y atributos',
      'ratingLegendDescription':
          '1 - Básico  |  2 - Promedio  |  3 - Bueno  |  4 - Muy bueno  |  5 - Excelente',
      'technical': 'Técnico',
      'physical': 'Físico',
      'mental': 'Mental',
      'goalkeeper': 'Portero',
      'userNotLoggedIn': 'Usuario no conectado',
      'profileNotFound': 'Perfil no encontrado',
      'myActivities': 'Mis actividades',
      'myActivitiesDescription':
          'Mantén un registro de tus propias estadísticas. Actualiza tus estadísticas de partidos y sesiones de entrenamiento para mejorar tu perfil',
      'cleanSheetRequiredLower': 'portería a cero *',
      'goalsScoredRequiredLower': 'goles marcados *',
      'cleanSheetsLower': 'porterías a cero',
      'goalsScoredLower': 'goles marcados',
      'pleaseEnterMatchMetric': 'Por favor ingresa {metric}.',
      'enterField': 'Ingresa {field}',
      'tagPlayersUpper': 'ETIQUETAR JUGADORES',
      'searchByNameMinTwoCharacters': 'Buscar por nombre (mín. 2 caracteres)…',
      'endorsementsDescription':
          'Ve los respaldos recibidos de otros jugadores y entrenadores. Elige publicar o rechazar los respaldos recibidos.',
      'reject': 'Rechazar',
      'publish': 'Publicar',
      'doubleTapToCheer': 'Toca dos veces para animar',
      'cheerCount': '{count} ánimo',
      'failedToUpdateProfileTryAgain':
          'No se pudo actualizar el perfil. Inténtalo de nuevo.',
      'updateUpper': 'ACTUALIZAR',
      'savingEllipsis': 'Guardando…',
      'trainingSession': 'Sesión de entrenamiento',
      'gameTypeLabel': 'tipo de juego *',
      'matchDateLabel': 'Fecha del Partido *',
      'selectDate': 'Seleccionar fecha',
      'playingPositionLabel': 'Posición de juego *',
      'positionTypeLabel': 'tipo de posición *',
      'numberOfAssistsLabel': 'número de asistencias *',
      'minutesPlayedLabel': 'minutos jugados *',
      'teamsPlayedLabel': 'equipos jugados *',
      'teamA': 'equipo A',
      'teamB': 'equipo B',
      'rateYourPerformanceLabel': 'califica tu rendimiento *',
      'howIPerformedLabel': 'cómo rendí *',
      'trainingSessionDateLabel': 'fecha de sesión de entrenamiento *',
      'trainingSessionTypeLabel': 'tipo de sesión de entrenamiento *',
      'trainingSessionMinutesLabel': 'minutos de sesión de entrenamiento *',
      'trainingNotesLabel': 'notas de entrenamiento *',
      'typeToSearchPlayers': 'Escribe para buscar jugadores',
      'userFallback': 'Usuario',
      'pleaseSelectMatchDate': 'Por favor selecciona una fecha de partido.',
      'pleaseRateYourPerformance': 'Por favor califica tu rendimiento.',
      'pleaseEnterMinutesPlayed': 'Por favor ingresa los minutos jugados.',
      'matchActivityAdded': '¡Actividad de partido añadida!',
      'failedToAddMatch': 'Error al añadir el partido. Inténtalo de nuevo.',
      'pleaseSelectTrainingDate':
          'Por favor selecciona una fecha de entrenamiento.',
      'pleaseEnterTrainingMinutes':
          'Por favor ingresa los minutos de entrenamiento.',
      'trainingSessionAdded': '¡Sesión de entrenamiento añadida!',
      'failedToAddTraining':
          'Error al añadir entrenamiento. Inténtalo de nuevo.',
      'pleaseSelectPlayingPosition':
          'Por favor selecciona una posición de juego',
      'pleaseSelectPositionType': 'Por favor selecciona un tipo de posición',
      'selectMatchDate': 'Seleccionar fecha del partido',
      'selectPlayingPosition': 'Seleccionar posición de juego',
      'selectPositionType': 'Seleccionar tipo de posición',
      'myTeamNameLabel': 'Nombre de mi equipo *',
      'enterYourTeamName': 'Ingresa el nombre de tu equipo',
      'opponentTeamNameLabel': 'Nombre del equipo contrario *',
      'enterOpponentTeamName': 'Ingresa el nombre del equipo contrario',
      'pleaseSelectTrainingType':
          'Por favor selecciona un tipo de entrenamiento',
      'trainingDateLabel': 'Fecha de entrenamiento *',
      'selectTrainingDate': 'Seleccionar fecha de entrenamiento',
      'trainingTypeLabel': 'Tipo de entrenamiento *',
      'selectTrainingType': 'Seleccionar tipo de entrenamiento',
      'trainingMinutesLabel': 'Minutos de entrenamiento *',
      'enterTrainingMinutes': 'Ingresa los minutos de entrenamiento',
      'notesOptionalLabel': 'Notas (opcional)',
      'describeTrainingSession': 'Describe tu sesión de entrenamiento...',
      'videos': 'Videos',
      'photos': 'Fotos',
      'skillVideo': 'Video de Habilidad',
      'skillVideoDescription':
          '(Comparte videos de tus habilidades de fútbol en partidos o entrenamientos para ser endosado o calificado por usuarios de SocaLoca, incluyendo entrenadores y scouts.)',
      'footballMoments': 'Momentos de Fútbol',
      'footballMomentsDescription':
          '(Comparte videos de tus momentos de fútbol o cualquier otro contenido relacionado con el fútbol que sea beneficioso para la comunidad de SocaLoca)',
      'typeAtLeast2CharsToSearch': 'Escribe al menos 2 caracteres para buscar',
      'uploadingEllipsis': 'Cargando...',
      // Referee screens
      'startSecondHalf': 'Iniciar segundo tiempo',
      'startExtraTime': 'Iniciar tiempo extra',
      'startPenalty': 'Iniciar penaltis',
      'matchEndedSuccessfully': 'Partido finalizado correctamente',
      'selectScorerFromOneTeam': 'Selecciona al goleador de UN solo equipo',
      'pleaseSelectScorer': 'Por favor selecciona un goleador',
      'selectCardHolderFromOneTeam':
          'Selecciona al jugador amonestado de UN solo equipo',
      'pleaseSelectCardHolder': 'Por favor selecciona al jugador amonestado',
      'pleaseSelectCardType':
          'Por favor selecciona el tipo de tarjeta (1ª / 2ª / Roja)',
      'pleaseSelectCardTime': 'Por favor selecciona el minuto de la tarjeta',
      'selectSubstitutionFromOneTeam':
          'Selecciona la sustitución de UN solo equipo',
      'pleaseSelectPlayersForSubstitution':
          'Por favor selecciona los jugadores para la sustitución',
      'pleaseSelectPlayerInForMyTeam':
          'Por favor selecciona el jugador que entra de Mi Equipo',
      'pleaseSelectPlayerInForOpponent':
          'Por favor selecciona el jugador que entra del Equipo Rival',
      'pleaseSelectPlayerOutForMyTeam':
          'Por favor selecciona el jugador que sale de Mi Equipo',
      'pleaseSelectPlayerOutForOpponent':
          'Por favor selecciona el jugador que sale del Equipo Rival',
      'playerInAndOutSame':
          'El jugador que entra y el que sale no pueden ser el mismo',
      'pleaseEnterSubstitutionTime':
          'Por favor introduce el minuto de la sustitución',
      'eventTimeTooLarge':
          'El tiempo del evento no puede ser mayor que el tiempo del partido',
      'halfTime': 'Medio tiempo',
      'endSecondHalf': 'Finalizar segundo tiempo',
      'endExtraTime': 'Finalizar tiempo extra',
      'endMatch': 'Finalizar partido',
      'postponed': 'Aplazado',
      'abandoned': 'Abandonado',
      'liveMatchUpdates': 'Actualizaciones en vivo',
      'caution': 'Precaución',
      'neverCloseAppDuringMatch':
          'Nunca cierres la app mientras el partido está en vivo',
      'tapSaveAndPublishWhenSure':
          'Toca "GUARDAR Y PUBLICAR" solo cuando estés seguro',
      'matchEnd': 'Fin del partido',
      'goal': 'Gol',
      'myRequests': 'Mis solicitudes',
      'myRequestsDescription':
          'Encuentra todos los partidos asignados a ti por los Organizadores del Torneo. Puedes aceptar o rechazar según tu preferencia. Todos los partidos aceptados estarán en "Mis Partidos"',
      'noPendingMatchRequests': 'No hay solicitudes de partidos pendientes',
      'requestAccepted': 'Solicitud aceptada',
      'requestDeclined': 'Solicitud rechazada',
      // Social Feed
      'reportPost': 'Reportar publicación',
      'blockPost': 'Bloquear publicación',
      'pleaseSelectReason': 'Por favor selecciona una razón',
      'blockUserDescription':
          'Ya no recibirás ninguna publicación ni podrás ver ningún comentario '
              'del usuario que estás bloqueando. Las personas que bloquees ya no '
              'podrán etiquetarte, iniciar una conversación contigo, agregarte a su '
              'red ni ver las cosas que publiques en el feed de SocaLoca. Si se '
              'siguen mutuamente, el bloqueo los dejará de seguir automáticamente.',
      'reportSubmittedThankYou': 'Reporte enviado. Gracias.',
      'failedToReportPost': 'Error al reportar la publicación.',
      'postBlocked': 'Publicación bloqueada.',
      'failedToBlockPost': 'Error al bloquear la publicación.',
      'userBlocked': 'Usuario bloqueado.',
      'failedToBlockUser': 'Error al bloquear el usuario.',
      'failedToReportUser': 'Error al reportar el usuario.',
      // Pickup Match
      'pleaseSelectStartTime': 'Por favor seleccione la hora de inicio',
      'pleaseSelectEndTime': 'Por favor seleccione la hora de fin',
      'endTimeMustBeAfterStartTime':
          'La hora de fin debe ser después de la hora de inicio',
      'pleaseSelectAgeGroup': 'Por favor seleccione el grupo de edad',
      'pleaseSelectLocation': 'Por favor seleccione la ubicación',
      'userNotFound': 'Usuario no encontrado',
      'failedToHostMatch':
          'Error al organizar el partido. Por favor intente de nuevo.',
      'startTimeRequired': 'Hora de inicio *',
      'endTimeRequired': 'Hora de fin *',
      'venueNameRequired': 'Nombre del lugar *',
      'venueNameIsRequired': 'El nombre del lugar es obligatorio',
      'venueNameMinLength':
          'El nombre del lugar debe tener al menos 3 caracteres',
      'selectLocationFromMapRequired': 'Seleccionar ubicación del mapa *',
      'maxPlayersRequired': 'Máximo de jugadores *',
      'maxPlayersIsRequired': 'El máximo de jugadores es obligatorio',
      'mustBePositiveNumber': 'Debe ser un número positivo',
      'matchNoteHint': 'Nota del partido',
      'errorLoadingMatchDetails': 'Error al cargar los detalles del partido',
      'failedToSendRequest':
          'Error al enviar la solicitud. Por favor intente de nuevo.',
      'maxPlayers': 'Máximo de jugadores',
      'date': 'Fecha',
      'host': 'Anfitrión',
      'viewRequestsUpper': 'VER SOLICITUDES',
      'acceptedUpper': 'ACEPTADO',
      'declinedUpper': 'RECHAZADO',
      'errorLoadingRequests': 'Error al cargar las solicitudes',
      'failedToUpdateRequest':
          'Error al actualizar la solicitud. Por favor intente de nuevo.',
      'noRequestsYet': 'Aún no hay solicitudes',
      'accepted': 'Aceptado',
      'declined': 'Rechazado',
      // Settings
      'newPasswordMinLength':
          'La nueva contraseña debe tener al menos 6 caracteres',
      'newPasswordSameAsCurrent':
          'La nueva contraseña no puede ser igual a la actual',
      'passwordsDoNotMatch': 'Las contraseñas no coinciden',
      'userSessionNotFound':
          'Sesión de usuario no encontrada. Por favor inicie sesión nuevamente.',
      'failedToChangePassword':
          'Error al cambiar la contraseña. Por favor intente de nuevo.',
      'somethingWentWrongTryAgain':
          'Algo salió mal. Por favor intente de nuevo.',
      'currentPasswordHint': 'Contraseña actual *',
      'newPasswordHint': 'Nueva contraseña *',
      'confirmPasswordHint': 'Confirmar contraseña *',
      'pleaseEnterName': 'Por favor ingrese su nombre',
      'thisIsYourOwnEmail': 'Este es su propio correo, intente con otro',
      'legacyContactDescription':
          'Su Contacto Heredado es la persona que puede nominar para heredar '
              'su cuenta en caso de que circunstancias imprevistas ocurran y no '
              'pueda acceder a su cuenta.',
      'legacyContactInstruction':
          'Nomine a su contacto heredado proporcionando su nombre completo '
              'y dirección de correo electrónico.',
      'nameRequired': 'Nombre *',
      'aboutSocaLoca': 'Acerca de SocaLoca',
      'aboutSocaLocaText': 'SocaLoca es la primera plataforma global de redes sociales de fútbol '
          'del mundo, dedicada a conectar jugadores, clubes, entrenadores, árbitros '
          'y aficionados. Nuestra misión es hacer el fútbol accesible para todos, '
          'en todas partes — desde la base hasta el nivel profesional. Proporcionamos '
          'herramientas para la gestión de partidos, el desarrollo de jugadores, la '
          'administración de clubes y la construcción de comunidades dentro del '
          'hermoso juego.',
      'couldNotOpenLink': 'No se pudo abrir el enlace',
      'gdprComplianceText':
          '¡SocaLoca cumple con las prácticas RGPD para protegerle a usted el usuario!',
      'downloadActivityEmailInstructions':
          'Para solicitar sus datos, por favor complete su dirección de correo '
              'electrónico aquí y nos pondremos en contacto para indicarle cómo '
              'entregar los datos.',
      'pleaseEnterValidEmailAddress':
          'Por favor ingrese una dirección de correo electrónico válida',
      'deactivateDeleteAccount': 'Desactivar/Eliminar Cuenta',
      'sorryToSeeYouLeave': 'Lamentamos que quiera marcharse.',
      'deleteOrDeactivateChoice':
          'Puede elegir eliminar o desactivar su cuenta.',
      'deletionDescription':
          'La eliminación eliminará su cuenta de los sistemas de SocaLoca y '
              'no podrá usar la cuenta nuevamente.',
      'deactivationDescription':
          'La desactivación hará que su cuenta quede inactiva. Si desea '
              'reactivarla, solo necesita iniciar sesión en SocaLoca y su cuenta '
              'será restaurada.',
      'accountSubmittedForDeletion': 'Cuenta enviada para eliminación',
      'accountDeactivated': 'Cuenta desactivada',
      'noUpper': 'NO',
      'yesUpper': 'SÍ',
      'legacyContact': 'Contacto Heredado',
      'manageAccount': 'Gestionar Cuenta',
      'deactivateDeleteAccountSubItem': 'Desactivar / Eliminar Cuenta',
      'dataPrivacy': 'Privacidad de Datos',
      'error': 'Error', // TODO: translate
      'englishLanguage': 'English', // TODO: translate
      'spanishLanguage': 'Spanish', // TODO: translate
      'portugueseLanguage': 'Portuguese', // TODO: translate
      'frenchLanguage': 'French', // TODO: translate
      'pleaseSelectRating': 'Please select a rating', // TODO: translate
      'nextUpper': 'NEXT', // TODO: translate
      'submitUpper': 'SUBMIT', // TODO: translate
      'doneUpper': 'DONE', // TODO: translate
      'yourFeedbackMatters': 'Your feedback matters!', // TODO: translate
      'whatAreYourFavouriteFeatures':
          'What are your favourite features?', // TODO: translate
      'doYouWantToOfferFeedback':
          'Do you want to offer us some feedback?', // TODO: translate
      'thankYouTitle': 'Thank you!', // TODO: translate
      'weHighlyValueFeedback':
          'We highly value your feedback!', // TODO: translate
      'thankYouFeedbackSupport':
          'Thank you for giving your feedback, we appreciate your support in helping us to improve the app.', // TODO: translate
      'feed': 'Feed', // TODO: translate
      'pickUpMatch': 'Pick-Up Match', // TODO: translate
      'firstNamePlain': 'First name', // TODO: translate
      'lastNamePlain': 'Last name', // TODO: translate
      'usernameMinFiveHint': 'Username (min 5 chars)', // TODO: translate
      'nameNotAvailable': 'Name not available', // TODO: translate
      'signUpUpper': 'SIGN UP', // TODO: translate
      'mobileEmailSocaLocaIdRequired':
          'Mobile number */Email */SocaLoca ID *', // TODO: translate
      'mobileOrEmailRequired': 'mobile number or email *', // TODO: translate
      'socaLocaIdRequired': 'SocaLoca ID *', // TODO: translate
      'emailRequired': 'Email *', // TODO: translate
      'mobileNumberRequired': 'Mobile Number *', // TODO: translate
      'enterEmailRequired': 'enter your Email *', // TODO: translate
      'enterMobileNumberRequired':
          'enter your Mobile Number *', // TODO: translate
      'enterSocaLocaIdRequired': 'enter your SOCALOCA ID *', // TODO: translate
      'pleaseEnterValidMobileNumber':
          'Please enter a valid mobile number', // TODO: translate
      'pleaseEnterValidSocaLocaId':
          'Please enter valid SOCALOCA ID', // TODO: translate
      'pleaseEnterMobileOrEmail':
          'Please enter mobile or email', // TODO: translate
      'pleaseEnterYourEmailMobileOrSocaLocaId':
          'Please enter your email, mobile number or SocaLoca ID', // TODO: translate
      'pleaseEnterValidEmailMobileOrSocaLocaId':
          'Please enter valid email, mobile number or SocaLoca ID', // TODO: translate
      'pleaseEnterMobileNumberOrEmail':
          'Please enter mobile or email', // TODO: translate
      'passwordAtLeastSixCharacters':
          'Password must be at least 6 characters', // TODO: translate
      'unexpectedResponseTryAgain':
          'Unexpected response. Please try again.', // TODO: translate
      'wrongPassword': 'Wrong password', // TODO: translate
      'accountNotRegistered': 'Account not registered', // TODO: translate
      'mobileNotRegistered': 'Mobile is not registered', // TODO: translate
      'failedAcceptPolicyTryAgain':
          'Failed to accept policy. Please try again.', // TODO: translate
      'googleSignInFailed': 'Google sign-in failed', // TODO: translate
      'facebookSignInFailed': 'Facebook sign-in failed', // TODO: translate
      'googleSignInFailedWithCode':
          'Google sign-in failed ({code})', // TODO: translate
      'verifyCode': 'Verify Code', // TODO: translate
      'enterVerificationCode': 'Enter verification code', // TODO: translate
      'verify': 'Verify', // TODO: translate
      'resendCode': 'Resend Code', // TODO: translate
      'addEmail': 'Add Email', // TODO: translate
      'emailAddressRequired': 'Email address *', // TODO: translate
      'addEmailOtpPrompt':
          'No contact info found for this SocaLoca ID. Please enter an email address to receive your OTP.', // TODO: translate
      'selectCountry': 'Select Country', // TODO: translate
      'forgottenPassword': 'Forgotten Password?', // TODO: translate
      'logInUpper': 'LOG IN', // TODO: translate
      'orContinueWith': 'or continue with', // TODO: translate
      'continueLabel': 'Continue', // TODO: translate
      'tryAgain': 'TRY AGAIN', // TODO: translate
      'professionalClubQuestion':
          'Are you a Professional Football Club?', // TODO: translate
      'loginSignupHere': 'Login/Signup here', // TODO: translate
      'findSocaLocaIdHint':
          'Find your new SocaLoca ID in the sliding hamburger menu', // TODO: translate
      'socaLocaPrivacyNotice':
          '*SocaLoca only collects the data is necessary to provides its service and\nstores it in the anonymised way in our own self-hosted analytics system.', // TODO: translate
      'resetUpper': 'RESET', // TODO: translate
      'resendUpper': 'RESEND', // TODO: translate
      'proceedUpper': 'PROCEED', // TODO: translate
      'saveAndContinueUpper': 'SAVE AND CONTINUE', // TODO: translate
      'parentalControls': 'Parental Controls', // TODO: translate
      'setYourPin': 'Set Your PIN', // TODO: translate
      'forgetPin': 'Forget pin?', // TODO: translate
      'settings': 'Settings', // TODO: translate
      'modifyPin': 'Modify pin', // TODO: translate
      'pleaseProvideConsentToContinue':
          'Please provide consent to continue', // TODO: translate
      'fetchingLocation': 'Fetching location...', // TODO: translate
      'selectLocationUpper': 'SELECT LOCATION', // TODO: translate
      'skip': 'Skip', // TODO: translate
      'or': 'or', // TODO: translate
      'pleaseEnterFullDigitCode':
          'Please enter the full {length}-digit code', // TODO: translate
      'verificationCodeSentTo':
          'We sent a 6-digit code to your {type}.', // TODO: translate
      'resendCodeIn': 'Resend code in {seconds}s', // TODO: translate
      'resendUpperWithSeconds': 'RESEND ({seconds}s)', // TODO: translate
      'resetLinkSentTo': 'Reset link sent to {email}', // TODO: translate
      'errorMessage': 'Error: {error}', // TODO: translate
      'errorPickingImage': 'Error picking image: {error}', // TODO: translate
      'away': 'Away', // TODO: translate
      'third': 'Third', // TODO: translate
      'club': 'Club', // TODO: translate
      'noRecentMatches': 'No recent matches', // TODO: translate
      'errorLoadingUpcomingMatches':
          'Error loading upcoming matches', // TODO: translate
      'errorLoadingRecentMatches':
          'Error loading recent matches', // TODO: translate
      'todaysMatch': "Today's Match", // TODO: translate
      'recentlyJoined': 'Recently Joined', // TODO: translate
      'liveMatchUpdate': 'Live Match Update', // TODO: translate
      'viewUpper': 'VIEW', // TODO: translate
      'feedbackUpper': 'FEEDBACK', // TODO: translate
      'shareUpper': 'SHARE', // TODO: translate
      'socaLocaUser': 'SocaLoca User', // TODO: translate
      'socaLocaIdLabel': 'SocaLoca ID: ', // TODO: translate
      'socaLocaIdCopied': 'SocaLoca ID copied', // TODO: translate
      'loadingProfilePleaseTryAgain':
          'Loading profile, please try again', // TODO: translate
      'skillDetail': 'Skill Detail', // TODO: translate
      'people': 'People', // TODO: translate
      'likes': 'Likes', // TODO: translate
      'cup': 'Cup', // TODO: translate
      'fa': 'FA', // TODO: translate
      'fiveHours': '5 hrs', // TODO: translate
      'aUser': 'A user', // TODO: translate
      'checkHisBio': 'Check his bio', // TODO: translate
      'checkTeamBio': 'Check team bio', // TODO: translate
      'checkTournamentDetails': 'Check tournament details', // TODO: translate
      'jerseySize': 'Jersey Size', // TODO: translate
      'teamFallback': 'Team', // TODO: translate
      'tournamentFallback': 'Tournament', // TODO: translate
      'unknownDate': 'Unknown Date', // TODO: translate
      'tournamentDate': 'Tournament Date', // TODO: translate
      'tournamentVenue': 'Tournament Venue', // TODO: translate
      'totalNumberOfTeams': 'Total Number of Teams', // TODO: translate
      'numberOfPlayerPerTeam': 'Number of player per team', // TODO: translate
      'noLimit': 'No limit', // TODO: translate
      'am': 'AM', // TODO: translate
      'pm': 'PM', // TODO: translate
      'monthJan': 'Jan', // TODO: translate
      'monthFeb': 'Feb', // TODO: translate
      'monthMar': 'Mar', // TODO: translate
      'monthApr': 'Apr', // TODO: translate
      'monthMay': 'May', // TODO: translate
      'monthJun': 'Jun', // TODO: translate
      'monthJul': 'Jul', // TODO: translate
      'monthAug': 'Aug', // TODO: translate
      'monthSep': 'Sep', // TODO: translate
      'monthOct': 'Oct', // TODO: translate
      'monthNov': 'Nov', // TODO: translate
      'monthDec': 'Dec', // TODO: translate
      'checkOutPostOnSocaLoca':
          'Check out this post on SocaLoca. {url}', // TODO: translate
      'userJoinedSocaLoca': '{name} has joined SocaLoca!!! ', // TODO: translate
      'teamJoinedSocaLoca':
          '{name} has joined SocaLoca!!!\n', // TODO: translate
      'tournamentIsLive': '{name} is live!!! ', // TODO: translate
      'startedOn': 'Started on {date}', // TODO: translate
      'noJoinedTeams': 'No joined teams.', // TODO: translate
      'removePhoto': 'Remove Photo', // TODO: translate
      'selectNationality': 'Select a country', // TODO: translate
      'firstNameRequiredLower': 'first name *', // TODO: translate
      'lastNameRequiredLower': 'last name *', // TODO: translate
      'profileNameRequiredLower': 'profile name *', // TODO: translate
      'selectRoleRequired': 'Select role *', // TODO: translate
      'nationalityRequired': 'Nationality *', // TODO: translate
      'max300Characters': 'max 300 characters', // TODO: translate
      'valueInCm': 'value in cm', // TODO: translate
      'brandsYouLike': 'Brands you like', // TODO: translate
      'chooseYourAvatar': 'Choose your avatar', // TODO: translate
      'byClickingSubmitPolicy':
          'By clicking Submit, you agree to our Terms & Conditions and Privacy Policy.', // TODO: translate
      'select': 'Select', // TODO: translate
      'selectLocationFromMap': 'Select location from map', // TODO: translate
      'zeroToNinetyNine': '0 - 99', // TODO: translate
      'playerRole': 'Player', // TODO: translate
      'fan': 'Fan', // TODO: translate
      'referee': 'Referee', // TODO: translate
      'genderPlain': 'Gender', // TODO: translate
      'dateOfBirthRequired': 'Date Of Birth *', // TODO: translate
      'playingPositionPlain': 'Playing Position', // TODO: translate
      'playingLevelRequired': 'Playing Level *', // TODO: translate
      'iAmOver': 'I am over', // TODO: translate
      'iAm': 'I am', // TODO: translate
      'sixteenYears': '16 years', // TODO: translate
      'thirteenToFifteenYears': '13-15 years', // TODO: translate
      'sevenToTwelve': '7-12', // TODO: translate
      'years': 'years', // TODO: translate
      'yearsTitle': 'Years', // TODO: translate
      'old': 'old', // TODO: translate
      'parentGuardianRegisteringOnBehalf':
          'I am a parent/guardian\nregistering on behalf of a', // TODO: translate
      'thankYouForJoining':
          'Thank you for joining SocaLoca!', // TODO: translate
      'createProfileToGetStarted':
          'Please create your profile to get started.', // TODO: translate
      'createProfileUpper': 'CREATE PROFILE', // TODO: translate
      'childConsentIntro':
          'Accounts of children between the ages of 7 and 12 can only created and managed by a parent or guardian.', // TODO: translate
      'fillFieldsAndTickCheckbox':
          'Please fill out the fields below and tick the checkbox.', // TODO: translate
      'childGuardianConfirmation':
          'This is confirm that you are the legal guardian and will take full control and accountability of this account upon registering on behalf of a minor.', // TODO: translate
      'childsNameRequired': 'Childs Name*', // TODO: translate
      'parentGuardianNameRequired': 'Parent/Guardians Name*', // TODO: translate
      'parentGuardianEmailRequired':
          'Parent/Guardians Email*', // TODO: translate
      'minorConsentText':
          'I consent that I am registering on behalf of a minor and will take full control of this SocaLoca account.', // TODO: translate
      'pleaseEnterMinorName': 'Please enter minor name', // TODO: translate
      'pleaseEnterParentGuardianName':
          'Please enter parent/guardian name', // TODO: translate
      'pleaseEnterParentEmail':
          'Please enter a parent email', // TODO: translate
      'pleaseEnterValidParentEmail':
          'Please enter a valid parent email', // TODO: translate
      'youthConsentIntro':
          'Accounts of children between the ages of 13 and 15 require parent or guardian consent.', // TODO: translate
      'youthGuardianConfirmation':
          'This is confirm that you are the legal guardian and consent to this youth account registration.', // TODO: translate
      'clubName': 'Club Name', // TODO: translate
      'enterClubName': 'Enter club name', // TODO: translate
      'enterClubEmail': 'Enter club email', // TODO: translate
      'pleaseEnterClubName': 'Please enter club name', // TODO: translate
      'pleaseSelectCountry': 'Please select country', // TODO: translate
      'pleaseSelectConfederation':
          'Please select confederation', // TODO: translate
      'pleaseSelectLeague': 'Please select league', // TODO: translate
      'pleaseEnterContactName': 'Please enter contact name', // TODO: translate
      'pleaseEnterContactNumber':
          'Please enter contact number', // TODO: translate
      'emailAlreadyRegistered': 'Email already registered', // TODO: translate
      'joiningRequestThanks':
          'Thanks for your joining request. We will validate and send you the instructions shortly.', // TODO: translate
      'redirectsToSocalocaFootball':
          'Redirects to socaloca.football', // TODO: translate
      'gotItUpper': 'GOT IT', // TODO: translate
      'autoPopulatedFromCountry':
          'Auto-populated from country', // TODO: translate
      'selectCountryFirst': 'Select country first', // TODO: translate
      'selectCountryRequired': 'Select Country *', // TODO: translate
      'selectLeagueRequired': 'Select League *', // TODO: translate
      'enterContactName': 'Enter contact name', // TODO: translate
      'enterContactNumber': 'Enter contact number', // TODO: translate
      'aPlayer': 'A Player', // TODO: translate
      'aCoach': 'A Coach', // TODO: translate
      'aManager': 'A Manager', // TODO: translate
      'aReferee': 'A Referee', // TODO: translate
      'aFan': 'A Fan', // TODO: translate
      'aProfessionalClub': 'A Professional Club', // TODO: translate
      'pleaseEnterAllFourDigits':
          'Please enter all 4 digits', // TODO: translate
      'pinCannotBeSameDigits':
          'PIN cannot be all same digits', // TODO: translate
      'pinCannotBeSequential':
          'PIN cannot be sequential numbers', // TODO: translate
      'parentalPinInfo':
          '*Please note you can modify the pin from the "Parentals Control" in the hamburger menu, located at the top right of SOCALOCA app.', // TODO: translate
      'parentGuardianPhoneRequired':
          'Parent/Guardians Phone*', // TODO: translate
      'pleaseEnterMobileNumber':
          'Please enter a mobile number', // TODO: translate
      'youthConsentTitle':
          "Accounts of users between the ages of 13 and 15 can only be created and managed with a parent or guardian's consent.", // TODO: translate
      'likingAndFollowing': 'Liking and following', // TODO: translate
      'uploadingPhotosVideos': 'Uploading photos & videos', // TODO: translate
      'parentalControlConsent':
          'I consent that I am setting the parental controls on behalf of a child and will take full control of this SOCALOCA account', // TODO: translate
      'registerAsClub': 'Register as a Club', // TODO: translate
      'emailOrSocaLocaId': 'Email or SocaLoca ID', // TODO: translate
      'emailOrSocaLocaIdRequired': 'Email */SocaLoca ID *', // TODO: translate
      'pleaseEnterEmailOrSocaLocaId':
          'Please enter email or SocaLoca ID', // TODO: translate
      'pleaseEnterValidEmailOrSocaLocaId':
          'Please enter a valid email or SocaLoca ID', // TODO: translate
      'invalidCredentials': 'Invalid credentials', // TODO: translate
      'failedToLoadPlayers': 'Failed to load players', // TODO: translate
      'failedToLoadTeams': 'Failed to load teams', // TODO: translate
      'failedToLoadTeamBio': 'Failed to load team bio', // TODO: translate
      'noTeamDataAvailable': 'No team data available', // TODO: translate
      'unknownTeam': 'Unknown Team', // TODO: translate
      'thisTeamIsArchived': 'This team is archived', // TODO: translate
      'requestPendingUpper': 'REQUEST PENDING', // TODO: translate
      'requestSent': 'Request sent', // TODO: translate
      'sendRequestUpper': 'SEND REQUEST', // TODO: translate
      'tryAdjustingYourFilters':
          'Try adjusting your filters', // TODO: translate
      'noMatchesPlayedYet': 'No matches played yet', // TODO: translate
      'fullTime': 'Full time', // TODO: translate
      'fullTimeTitle': 'Full Time', // TODO: translate
      'firstHalf': 'First Half', // TODO: translate
      'secondHalf': 'Second Half', // TODO: translate
      'breakBeforeEt': 'Break Before ET', // TODO: translate
      'etFirstHalf': 'ET First Half', // TODO: translate
      'etHalfTime': 'ET Half Time', // TODO: translate
      'etSecondHalf': 'ET Second Half', // TODO: translate
      'afterExtraTime': 'After Extra Time', // TODO: translate
      'ratingLabel': 'Rating  ', // TODO: translate
      'allTemasLabel': '      All temas', // TODO: translate
      'requiredField': 'Required', // TODO: translate
      'teamWork': 'Team Work', // TODO: translate
      'aggressiveness': 'Aggressiveness', // TODO: translate
      'tactical': 'Tactical', // TODO: translate
      'overallRating': 'Overall Rating', // TODO: translate
      'teamOne': 'Team 1', // TODO: translate
      'teamTwo': 'Team 2', // TODO: translate
      'vsLower': 'vs', // TODO: translate
      'tournamentType': 'Tournament Type', // TODO: translate
      'venue': 'Venue', // TODO: translate
      'notes': 'Notes', // TODO: translate
      'description': 'Description', // TODO: translate
      'prizes': 'Prizes', // TODO: translate
      'registrationFees': 'Registration Fees', // TODO: translate
      'organizerDetails': 'Organizer Details', // TODO: translate
      'viewTournamentDetails': 'View Tournament Details ', // TODO: translate
      'matchManagement': 'Match Management', // TODO: translate
      'noPointsTableAvailable': 'No points table available', // TODO: translate
      'noDataAvailable': 'No data available', // TODO: translate
      'add': 'Add', // TODO: translate
      'addCard': 'Add Card', // TODO: translate
      'noCardsRecorded': 'No Cards Recorded', // TODO: translate
      'tapAddCards': 'Tap the button below to add cards', // TODO: translate
      'cardType': 'Card Type', // TODO: translate
      'yellow': 'Yellow', // TODO: translate
      'red': 'Red', // TODO: translate
      'playerName': 'Player Name', // TODO: translate
      'example45': 'e.g., 45', // TODO: translate
      'example23': 'e.g., 23', // TODO: translate
      'deleteCard': 'Delete Card', // TODO: translate
      'deleteGoal': 'Delete Goal', // TODO: translate
      'deleteCardConfirmation':
          'Are you sure you want to delete this card?', // TODO: translate
      'deleteGoalConfirmation':
          'Are you sure you want to delete this goal?', // TODO: translate
      'currentManOfMatch': 'Current Man of the Match', // TODO: translate
      'noMvpSelected': 'No MVP Selected', // TODO: translate
      'tapSelectMvp': 'Tap the button below to select MVP', // TODO: translate
      'selectManOfMatch': 'Select Man of the Match', // TODO: translate
      'clearMvp': 'Clear MVP', // TODO: translate
      'clearMvpConfirmation':
          'Are you sure you want to clear the Man of the Match?', // TODO: translate
      'clear': 'Clear', // TODO: translate
      'addGoal': 'Add Goal', // TODO: translate
      'noGoalsRecorded': 'No Goals Recorded', // TODO: translate
      'tapAddGoals': 'Tap the button below to add goals', // TODO: translate
      'success': 'Success', // TODO: translate
      'saveSquad': 'Save Squad', // TODO: translate
      'startingXi': 'Starting XI', // TODO: translate
      'substitutes': 'Substitutes', // TODO: translate
      'addStartingPlayer': 'Add Starting Player', // TODO: translate
      'addSubstitute': 'Add Substitute', // TODO: translate
      'noKnockoutMatchesYet': 'No knockout matches yet', // TODO: translate
      'noGroupsAvailable': 'No groups available', // TODO: translate
      'selectGroup': 'Select Group', // TODO: translate
      'viewGroupStandings': 'View Group Standings', // TODO: translate
      'groupNotFound': 'Group not found', // TODO: translate
      'noMatchesInThisGroup': 'No matches in this group', // TODO: translate
      'noEligibleTeams': 'No Eligible Teams', // TODO: translate
      'noEligibleTeamsTournament':
          "You don't have any teams eligible for this tournament.", // TODO: translate
      'noEligibleTeamsCup':
          "You don't have any teams eligible for this cup.", // TODO: translate
      'selectTeam': 'Select Team', // TODO: translate
      'tournamentStats': 'Tournament Stats', // TODO: translate
      'noRoundsAvailable': 'No rounds available', // TODO: translate
      'noStatRecordedYet': 'No {label} recorded yet', // TODO: translate
      'groupStandings': 'Group Standings', // TODO: translate
      'noStandingsAvailable': 'No standings available', // TODO: translate
      'errorLoadingStandings': 'Error loading standings', // TODO: translate
      'pointsHash': '#', // TODO: translate
      'pointsPlayed': 'P', // TODO: translate
      'pointsWon': 'W', // TODO: translate
      'pointsDrawn': 'D', // TODO: translate
      'pointsLost': 'L', // TODO: translate
      'goalsFor': 'GF', // TODO: translate
      'goalsAgainst': 'GA', // TODO: translate
      'goalDifference': 'GD', // TODO: translate
      'pointsShort': 'Pts', // TODO: translate
      'requestToJoin': 'Request to Join', // TODO: translate
      'requestToJoinCup': 'Request to Join Cup', // TODO: translate
      'pendingInvitations': 'Pending Invitations', // TODO: translate
      'viewItinerary': 'View Itinerary', // TODO: translate
      'itinerary': 'Itinerary', // TODO: translate
      'close': 'Close', // TODO: translate
      'cupTournamentNotFound': 'Cup tournament not found', // TODO: translate
      'statsUpper': 'STATS', // TODO: translate
      'selectRound': 'Select Round', // TODO: translate
      'noGroupRoundAvailable': 'No group round available', // TODO: translate
      'noKnockoutRoundAvailable':
          'No knockout round available', // TODO: translate
      'accessRestricted': 'Access Restricted', // TODO: translate
      'matchManageRestricted':
          'Only admins, coaches, and referees\ncan manage matches', // TODO: translate
      'noMatches': 'No Matches', // TODO: translate
      'noMatchesAvailableForManagement':
          'No matches available for management', // TODO: translate
      'manageMatch': 'Manage Match', // TODO: translate
      'tournamentsIntro':
          'See the listing of tournaments in your area and apply to join a competition if its right for your team. You can also view the progression of competitions in real time, see fixtures, points tables, stats and even match highlights.', // TODO: translate
      'selectManOfMatchHint':
          'Select the Man of the Match from the participating players.', // TODO: translate
      'scoreEntryHint':
          'Enter the final score for this match. The score will be submitted for approval.', // TODO: translate
      'addStartingOrSubstitutePlayer': 'Add {type} Player', // TODO: translate
      'starting': 'Starting', // TODO: translate
      'substitute': 'Substitute', // TODO: translate
      'errorLoadingTournament':
          'Error loading tournament: {error}', // TODO: translate
      'errorLoadingStandingsWithError':
          'Error loading standings: {error}', // TODO: translate
      'errorLoadingStats': 'Error loading stats: {error}', // TODO: translate
      'errorLoadingBracket':
          'Error loading bracket: {error}', // TODO: translate
      'errorLoadingMatchesWithError':
          'Error loading matches: {error}', // TODO: translate
      'errorLoadingDetails':
          'Error loading details: {error}', // TODO: translate
      'errorLoadingCup': 'Error loading cup: {error}', // TODO: translate
      'teamALabel': 'Team A', // TODO: translate
      'teamBLabel': 'Team B', // TODO: translate
      'clubsPartnerIntro':
          'These are the Professional Football Clubs that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Professional Football Club, you can request to become a SOCALOCA partner and gain access to a wide range of features, including an individualized hub with your logo and branding, in-app uploads of game highlights, training sessions, and interviews, the ability to advertise upcoming trials through your club’s dedicated hub, showcase your club teams and top players, engage fans with news, announcements, and recent results, display sponsors, and much more.', // TODO: translate
      'footballAssociationsIntro':
          "These are the Football Associations that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Football Association, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to organize tournaments and leagues using SOCALOCA's tournament module, upload game highlights, training sessions, or interviews directly within the app, engage fans with the latest news and announcements, showcase sponsors, and access a data-driven overview of your Football Association's stakeholders through SOCALOCA Analytics, plus much more.", // TODO: translate
      'footballConfederationsIntro':
          "These are the Football Confederations that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Confederation, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to organize tournaments and leagues using SOCALOCA's tournament module, upload game highlights, training sessions, or interviews directly within the app, engage fans with the latest news and announcements, showcase sponsors, and access a data-driven overview of your Football Confederation's stakeholders through SOCALOCA Analytics, plus much more.", // TODO: translate
      'sponsorsIntro':
          'These are the Sponsors that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Sponsor, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to showcase merchandise and services, promote your company through news and announcements, expand your reach, send push notifications to segmented audiences, measure your CSR impact, and much more.', // TODO: translate
      'charitiesNgosIntro':
          'These are the Charities, NGOs, and Social Enterprises that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Charity, NGO, or Social Enterprise, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to showcase your projects and initiatives, reach a wider audience, upload videos and photos, engage with followers, measure the impact of your CSR activities, and positively influence the SOCALOCA community.', // TODO: translate
      'errorLoadingClubs': 'Error loading clubs', // TODO: translate
      'noFasFound': 'No FAs found', // TODO: translate
      'noConfederationsFound': 'No confederations found', // TODO: translate
      'noSponsorsFound': 'No sponsors found', // TODO: translate
      'noCharitiesNgosFound': 'No charities & NGOs found', // TODO: translate
      'confederation': 'Confederation', // TODO: translate
      'confderations': 'Confderations', // TODO: translate
      'clubNotFound': 'Club not found', // TODO: translate
      'faNotFound': 'FA not found', // TODO: translate
      'sponsorNotFound': 'Sponsor not found', // TODO: translate
      'charityNotFound': 'Charity not found', // TODO: translate
      'couldNotLoadClubData': 'Could not load club data. ', // TODO: translate
      'nickname': 'Nickname', // TODO: translate
      'formed': 'Formed', // TODO: translate
      'formedIn': 'Formed In', // TODO: translate
      'city': 'City', // TODO: translate
      'fifaIdLabel': 'FIFA ID: ', // TODO: translate
      'liveTrial': 'LIVE TRIAL', // TODO: translate
      'registrationClosed': 'REGISTRATION CLOSED', // TODO: translate
      'newsAnnouncements': 'News & Announcements', // TODO: translate
      'viewAllPlayers': 'View All Players', // TODO: translate
      'clubTeams': 'Club Teams', // TODO: translate
      'clubSponsors': 'Club Sponsors', // TODO: translate
      'homeAwayThirdKit': 'Home Kit | Away Kit | Third Kit', // TODO: translate
      'otherCompetitions': 'Other Competitions', // TODO: translate
      'men': 'Men', // TODO: translate
      'women': 'Women', // TODO: translate
      'kit': 'Kit', // TODO: translate
      'playersTitle': 'Players', // TODO: translate
      'galleryTitle': 'Gallery', // TODO: translate
      'liveTrials': 'Live Trials', // TODO: translate
      'noTrialsFound': 'No Trials Found', // TODO: translate
      'pleaseSelectFilter': 'Please select a filter', // TODO: translate
      'toAgeGreaterThanFromAge':
          'To age must be greater than from age', // TODO: translate
      'from': 'From', // TODO: translate
      'to': 'To', // TODO: translate
      'searchUpper': 'SEARCH', // TODO: translate
      'liveNow': 'LIVE NOW', // TODO: translate
      'live': 'LIVE', // TODO: translate
      'liveUpper': 'LIVE', // TODO: translate
      'regCloses': 'Reg. Closes', // TODO: translate
      'trialStarts': 'Trial Starts', // TODO: translate
      'age': 'Age', // TODO: translate
      'cost': 'Cost', // TODO: translate
      'trialVenue': 'Trial Venue', // TODO: translate
      'trialDate': 'Trial Date', // TODO: translate
      'registration': 'Registration', // TODO: translate
      'brief': 'Brief', // TODO: translate
      'registrationRestrictedLong':
          'Registration restricted. Your profile does not match the trial criteria. SocaLoca will notify you of future Live trials!', // TODO: translate
      'registrationRestrictedShort':
          'Registration restricted. Your profile does not match the trial criteria.', // TODO: translate
      'trialRegistrationThanks':
          'Thank you for participating in live trial. Please check your mail for instructions.', // TODO: translate
      'registeredSuccessfully': 'Registered successfully!', // TODO: translate
      'registrationFailedTryAgain':
          'Registration failed. Try again.', // TODO: translate
      'free': 'Free', // TODO: translate
      'foundation': 'Foundation', // TODO: translate
      'president': 'President', // TODO: translate
      'generalSecretary': 'General Secretary', // TODO: translate
      'viewAllCompetitions': 'view all competitions', // TODO: translate
      'featuredTeams': 'Featured Teams', // TODO: translate
      'viewAllTeams': 'view all teams', // TODO: translate
      'headquarters': 'Headquarters', // TODO: translate
      'founded': 'Founded', // TODO: translate
      'ceo': 'CEO', // TODO: translate
      'founders': 'Founders', // TODO: translate
      'merchandise': 'Merchandise', // TODO: translate
      'view': 'View', // TODO: translate
      'chairman': 'Chairman', // TODO: translate
      'fundingPartners': 'Funding Partners', // TODO: translate
      'partner': 'Partner', // TODO: translate
      'basicInfo': 'Basic Info', // TODO: translate
      'position': 'Position', // TODO: translate
      'jersey': 'Jersey', // TODO: translate
      'playerNotFound': 'Player not found', // TODO: translate
      'footballStats': 'Football Stats', // TODO: translate
      'futsalStats': 'Futsal Stats', // TODO: translate
      'matchCountLabel': 'Matches', // TODO: translate
      'followerCount': '{count} Follower', // TODO: translate
      'followersCount': '{count} Followers', // TODO: translate
      'failedToUpdateFollowStatus':
          'Failed to update follow status: {error}', // TODO: translate
      'footballStatsYear': 'Football Stats ({year})', // TODO: translate
      'futsalStatsYear': 'Futsal Stats ({year})', // TODO: translate
      'cannotHostMatch': 'Cannot Host Match', // TODO: translate
      'hostMatchRestriction':
          'Only Players, Coaches, Admins, and Referees can host pickup matches.', // TODO: translate
      'pickupMatchDescription':
          "Can't get 2 full teams to make a match? Fret not. Pick-Up matches allows you to organise an informal kick-about at a specified place and time. Shout out to all nearby that you are organising a pick-up match and get your game on!", // TODO: translate
      'hostMatchUpper': 'HOST MATCH', // TODO: translate
      'noUpcomingPickupMatches':
          'No upcoming pickup matches', // TODO: translate
      'errorLoadingMatches': 'Error loading matches', // TODO: translate
      'academiesDescription':
          'SocaLoca is the home for football academies of any scale, age category, playing level, or location. SocaLoca provides an innovative and intuitive platform designed around the modern needs of a football academy.', // TODO: translate
      'goUpper': 'GO', // TODO: translate
      'noAcademiesFound': 'No academies found.', // TODO: translate
      'addTrainingSession': 'Add Training Session', // TODO: translate
      'matchDetailsAdded': 'Match details added', // TODO: translate
      'addGameTypeMatch': 'Add {gameType} Match', // TODO: translate
      'goalsSavedRequired': 'Goals Saved *', // TODO: translate
      'goalsScoredRequired': 'Goals Scored *', // TODO: translate
      'egThree': 'e.g. 3', // TODO: translate
      'egTwo': 'e.g. 2', // TODO: translate
      'goalsSaved': 'Goals saved', // TODO: translate
      'egOne': 'e.g. 1', // TODO: translate
      'egSixty': 'e.g. 60', // TODO: translate
      'egNinety': 'e.g. 90', // TODO: translate
      'opponentTeamName': 'Opponent team name', // TODO: translate
      'describeHowYouPerformed':
          'Describe how you performed...', // TODO: translate
      'videoLargerThanAvailableSpace':
          'Video larger than available space', // TODO: translate
      'pleaseWriteSomething': 'Please write something', // TODO: translate
      'pleaseSelectAtLeastOnePhoto':
          'Please select at least one photo', // TODO: translate
      'pleaseSelectAVideo': 'Please select a video', // TODO: translate
      'uploadingPhotoOf':
          'Uploading photo {current} of {total}...', // TODO: translate
      'updatingPost': 'Updating post...', // TODO: translate
      'publishingPost': 'Publishing post...', // TODO: translate
      'postUpdatedSuccessfully':
          'Post updated successfully!', // TODO: translate
      'postPublishedSuccessfully':
          'Post published successfully!', // TODO: translate
      'writeSomething': 'Write something', // TODO: translate
      'tagPeopleUpper': 'TAG PEOPLE', // TODO: translate
      'postType': 'Post Type', // TODO: translate
      'choose': 'Choose', // TODO: translate
      'notifyCoachesToEndorse':
          'Notify all coaches/managers/scounts to endorse video', // TODO: translate
      'invitePlayersUpper': 'INVITE PLAYERS', // TODO: translate
      'updatePostUpper': 'UPDATE POST', // TODO: translate
      'addPhotosCount': 'Add Photos ({current}/{max})', // TODO: translate
      'maxPhotosAllowed': '(max {max} photos allowed)', // TODO: translate
      'changeVideo': 'Change Video', // TODO: translate
      'uploadVideos': 'Upload Videos', // TODO: translate
      'maxVideosAllowed': '(max 10 videos allowed)', // TODO: translate
      'availableSpace': 'Available Space : ', // TODO: translate
      'usedSpace': 'Used Space : ', // TODO: translate
      'zeroMB': '0MB', // TODO: translate
      'maxMB': '1024MB', // TODO: translate
      'tagPlayers': 'Tag Players', // TODO: translate
      'done': 'Done', // TODO: translate
      'searchPlayersEllipsis': 'Search players...', // TODO: translate
    },

    // ── Portuguese ──────────────────────────────────────────────────────────
    'pt': {
      'appName': 'SocaLoca',
      'cancel': 'Cancelar',
      'submit': 'Enviar',
      'yes': 'SIM',
      'no': 'Não',
      'search': 'Pesquisar',
      'searchEllipsis': 'Pesquisar...',
      'locationPermission': 'Permissão de localização',
      'locationPermissionDesc':
          'A SocaLoca solicita acesso à sua localização para conectá-lo à Associação de Futebol do seu país. A SocaLoca também usa sua localização para encontrar o local do seu torneio. Seus dados de localização são usados apenas para ajudar você a navegar pela sua jornada no futebol e não são salvos para nenhum outro propósito.',
      'learnMore': 'Saiba mais',
      'searchHere': 'Pesquisar aqui',
      'playerCoachManagerReferee': 'Jogador/Treinador/Gestor/Árbitro',
      'byCountry': 'Por país',
      'byType': 'Por tipo',
      'byChoice': 'Por escolha',
      'mostPosts': 'Mais publicações',
      'mostAppearances': 'Mais presenças',
      'mostGoals': 'Mais gols',
      'endorsedByUpper': 'ENDOSSADO POR',
      'followersUpper': 'SEGUIDORES',
      'noResultsFound': 'Nenhum resultado encontrado',
      'profileDetailsNotAvailable': 'Detalhes do perfil ainda não disponíveis',
      'back': 'Voltar',
      'save': 'SALVAR',
      'delete': 'Deletar',
      'deactivate': 'Desativar',
      'report': 'Denunciar',
      'follow': 'Seguir',
      'following': 'Seguindo',
      'followers': 'Seguidores',
      'viewAll': 'Ver Tudo',
      'comingSoon': 'Em Breve',
      'somethingWentWrong': 'Algo deu errado!',
      'na': 'N/D',
      'gotIt': 'Entendi',
      'upgrade': 'ATUALIZAR',
      'helpdesk': 'Suporte',
      'mandatoryFields': '* campos obrigatórios',
      'goToHome': 'Ir Para Principal',
      'selectLanguage': 'Selecionar idioma',
      'selectLanguageDesc':
          'SocaLoca está disponível em vários idiomas. Por favor selecione um para continuar.',
      'pleaseSelectLanguage': 'Por favor selecione um idioma',
      'signIn': 'ENTRAR',
      'signUp': 'CADASTRAR',
      'signOut': 'Sair',
      'login': 'Entrar',
      'forgotPassword': 'Esqueceu a senha?',
      'socialLoginNoPassword':
          'Ei... Você usou o login social. Não precisa de senha.',
      'email': 'Email *',
      'emailPlain': 'Email',
      'enterYourEmail': 'Preencha seu email',
      'password': 'Senha *',
      'enterYourPassword': 'Digite sua senha',
      'newPassword': 'Nova Senha *',
      'enterYourNewPassword': 'Digite sua nova senha',
      'confirmPassword': 'Confirmar Senha *',
      'currentPassword': 'Senha Atual *',
      'enterYourCurrentPassword': 'Digite sua senha atual',
      'changePassword': 'Alterar Senha',
      'resetPassword': 'REDEFINIR',
      'sendOtp': 'ENVIAR OTP',
      'sendResetLink': 'ENVIAR LINK DE REDEFINIÇÃO',
      'resend': 'REENVIAR',
      'haventReceivedCode': 'Não recebeu o código?  ',
      'otpLabel': 'OTP *',
      'socaLocaId': 'ID SocaLoca',
      'mobile': 'Celular',
      'enterSocaLocaId': 'Digite seu ID SocaLoca',
      'enterMobileNumber': 'Digite o número de celular',
      'pleaseEnterEmail': 'Por favor preencha seu email',
      'pleaseEnterValidEmail': 'Por favor valide seu email',
      'pleaseEnterPassword': 'Por favor insira uma senha',
      'minimumSixCharacters': 'Mínimo 6 caracteres',
      'pleaseConfirmPassword': 'Por favor confirme a senha',
      'passwordDoesNotMatch': 'As senhas não coincidem',
      'passwordDoNotMatch': 'As senhas não coincidem',
      'invalidCurrentPassword': 'Senha atual inválida',
      'pleaseEnterCurrentPassword': 'Por favor insira a senha atual',
      'pleaseEnterNewPassword': 'Por favor insira a nova senha',
      'pleaseConfirmNewPassword': 'Por favor confirme a nova senha',
      'passwordChangedSuccessfully': 'Senha alterada com sucesso',
      'pleaseEnterOtp': 'Por favor insira o OTP',
      'verificationCodeSent': 'Código de verificação enviado com sucesso',
      'passwordResetSuccess':
          'Senha redefinida com sucesso. Por favor faça login.',
      'strong': 'Forte',
      'weak': 'Fraca',
      'firstName': 'Primeiro Nome *',
      'lastName': 'Sobrenome *',
      'profileName': 'Nome do Perfil *',
      'enterYourName': 'Digite seu nome',
      'dateOfBirth': 'Data de Nascimento *',
      'country': 'País',
      'gender': 'Gênero *',
      'male': 'Masculino',
      'female': 'Feminino',
      'nationality': 'Nacionalidade',
      'playingPosition': 'Posição *',
      'preferredFoot': 'Pé Preferido',
      'right': 'Direito',
      'left': 'Esquerdo',
      'height': 'Altura',
      'heightCms': 'Altura (cms)',
      'editProfile': 'Editar Perfil',
      'createProfile': 'Criar Perfil',
      'uploadProfilePhoto': 'Envie sua foto de perfil',
      'takeAPhoto': 'Tirar uma foto',
      'chooseFromGallery': 'Escolher da galeria',
      'selectImage': 'Selecionar imagem',
      'myGallery': 'Minha Galeria',
      'pleaseEnterFirstName': 'Por favor insira o primeiro nome',
      'pleaseEnterLastName': 'Por favor insira o sobrenome',
      'pleaseEnterProfileName': 'Por favor insira o nome do perfil',
      'pleaseEnterDateOfBirth': 'Por favor insira a data de nascimento',
      'pleaseSelectNationality': 'Por favor selecione a nacionalidade',
      'home': 'Principal',
      'teams': 'Equipes',
      'players': 'Jogadores',
      'match': 'Partida',
      'matches': 'Partidas',
      'clubsAndPartners': 'Clubes e Parceiros',
      'notifications': 'Notificações',
      'noNotifications': 'Nenhuma notificação por enquanto',
      'tournaments': 'Torneios',
      'clubs': 'Clubes',
      'partners': 'Parceiros',
      'academy': 'Academia',
      'recentMatches': 'Partidas Recentes',
      'upcomingMatches': 'Próximas Partidas',
      'noUpcomingMatches': 'Sem próximas partidas',
      'playedMatches': 'Partidas Jogadas',
      'noPlayedMatches': 'Sem partidas jogadas',
      'todaysMatches': 'Partidas de Hoje',
      'hostMatch': 'Organizar Partida',
      'manageRequests': 'Gerenciar Solicitações',
      'selectTournamentRequired': 'selecionar torneio *',
      'myMatches': 'My Matches',
      'myMatchesTournament':
          'Find all the matches assigned to you by the Tournament Organisers. Update scores and records by tapping "Manage". Download Match Report once a match is updated.',
      'noMatchesAreFound': 'Nenhuma partida encontrada!!!',
      'manage': 'Gerenciar',
      'downloadMatchReport': 'Baixar relatório da partida',
      'liveMatches': 'Live Matches',
      'liveMatchTournament':
          'Find all the matches assigned to you by the Tournament Organiser here. Tap on "START MATCH" to publish "Live Scores".',
      'noLiveMatchesAvailable': 'Nenhuma partida ao vivo disponível!!!',
      'startMatch': 'Iniciar partida',
      'abandonMatch': 'Abandonar partida',
      'saveAndPublish': 'Salvar e publicar',
      'matchStatus': 'Status da partida',
      'goals': 'Gols',
      'cards': 'Cartões',
      'substitution': 'Substituição',
      'ownGoal': 'Gol contra',
      'penalty': 'Pênalti',
      'penaltyMissed': 'Pênalti perdido',
      'minutesShort': '(Min.)',
      'selectScorer': 'Selecionar artilheiro',
      'selectAssist': 'Selecionar assistência',
      'selectPlayer': 'Selecionar jogador',
      'firstCard': '1o',
      'secondCard': '2o',
      'redCardShort': 'Verm.',
      'playerIn': 'Jogador entra',
      'playerOut': 'Jogador sai',
      'selectInPlayer': 'Selecionar jogador que entra',
      'selectOutPlayer': 'Selecionar jogador que sai',
      'ongoing': 'Em andamento',
      'upcoming': 'Próximos',
      'closed': 'Encerrados',
      'myLeaguesCups': 'Minhas ligas/copas',
      'today': 'Hoje',
      'noMatchForToday': 'Sem partidas hoje',
      'pickup': 'Pick-Up',
      'oneOff': 'Único',
      'endorsements': 'Recomendações',
      'noEndorsementsYet': 'Sem recomendações ainda',
      'endorsedSuccessfully': 'Recomendado com sucesso',
      'alreadyEndorsed': 'Já recomendado',
      'appearance': 'Presença',
      'appearances': 'Presenças',
      'playerBio': 'Biografia do Jogador',
      'clubBio': 'Biografia do Clube',
      'league': 'Liga',
      'stadium': 'Estádio',
      'featuredPlayers': 'Jogadores em Destaque',
      'born': 'Nascido',
      'goalScored': 'Gols Marcados',
      'assists': 'Assistências',
      'yellowCard': 'Cartão Amarelo',
      'redCard': 'Cartão Vermelho',
      'mvp': 'MVP',
      'liked': 'Curtiu',
      'tapToLike': 'Toque para curtir',
      'tapToFollow': 'Toque para seguir',
      'noPlayerJoinedYet': 'Nenhum jogador entrou ainda',
      'myTeams': 'Minhas Equipes',
      'createTeam': 'Criar Equipe',
      'noTeamsFound': 'Nenhuma equipe encontrada.',
      'addPlayers': 'Adicionar Jogadores',
      'noClubsFound': 'Nenhum clube encontrado.',
      'noTournamentsFound': 'Nenhum torneio encontrado.',
      'competitions': 'Competições',
      'noCompetitionsFound': 'Nenhuma competição encontrada.',
      'fas': 'FAs',
      'confederations': 'Confederações',
      'sponsors': 'Patrocinadores',
      'charitiesAndNgos': 'Instituições de Caridade e ONGs',
      'noPostsFound': 'Nenhuma publicação encontrada.',
      'post': 'Publicação',
      'posts': 'Publicações',
      'createPost': 'Criar Publicação',
      'uploadImage': 'Enviar Imagens',
      'uploadVideo': 'Enviar Vídeo',
      'reportThisPost': 'Denunciar esta publicação',
      'pleaseSelectACause': 'Por favor selecione um motivo',
      'pleaseSelectAtLeastOneFilter':
          'Por favor selecione pelo menos um filtro',
      'location': 'Localização',
      'selectLocation': 'Selecionar Localização',
      'ageGroup': 'Faixa Etária',
      'game': 'Jogo',
      'register': 'Registrar',
      'registered': 'Registrado',
      'liveTrialRegistration': 'Registro de Teste ao Vivo',
      'deleteAccount': 'Desativar/Deletar Conta',
      'deleteAccountConfirmation':
          'Tem certeza de que deseja excluir sua conta?',
      'deactivateAccountConfirmation':
          'Tem certeza de que deseja desativar sua conta?',
      'downloadActivities': 'Baixar Atividades',
      'welcomeBack': 'Bem-vindo de volta!!!',
      'weTrulyMissedYou': 'Sentimos sua falta.',
      'hello': 'Olá,',
      'cheers': 'APLAUSOS',
      'myBio': 'Minha bio',
      'myPosts': 'Minhas publicações',
      'myRatings': 'Minhas avaliações',
      'gallery': 'Galeria',
      'sharePostPrompt': 'Compartilhe uma foto ou vídeo e escreva\nalgo.',
      'createPostUpper': 'CRIAR PUBLICAÇÃO',
      'mostEndorsedPlayers': 'Jogadores mais recomendados',
      'mostFollowedTeams': 'Equipes mais seguidas',
      'recentlyJoinedTeams': 'Equipes recém-chegadas',
      'ongoingTournaments': 'Torneios em andamento',
      'matchUpdates': 'Atualizações de partidas',
      'viewDetails': 'VER DETALHES',
      'trials': 'Testes',
      'updateProfile': 'Atualizar perfil',
      'changeLanguage': 'Alterar idioma',
      'helpDesk': 'Central de ajuda',
      'privacySettings': 'Configurações de privacidade',
      'helpUsToImprove': 'Ajude-nos a melhorar',
      'dataPolicy': 'Política de dados',
      'termsAndConditions': 'Termos e condições',
      'signOutUpper': 'SAIR',
      'academies': 'Academias',
      'menu': 'Menu',
      'retry': 'Tentar novamente',
      'ok': 'OK',
      'block': 'Bloquear',
      'blockUser': 'Bloquear usuário',
      'reportUser': 'Denunciar usuário',
      'selectReason': 'Selecione um motivo:',
      'requestCancelled': 'Solicitação cancelada.',
      'failedToSubmitEndorsement':
          'Falha ao enviar recomendação. Tente novamente.',
      'requests': 'Solicitações',
      'noPendingRequests': 'Nenhuma solicitação pendente.',
      'pendingRequests': 'Solicitações pendentes',
      'teamInvitations': 'Convites de equipe',
      'noTeamInvitations': 'Nenhum convite de equipe.',
      'accept': 'Aceitar',
      'decline': 'Recusar',
      'joinedTeams': 'Equipes vinculadas',
      'noPostsYet': 'Ainda não há publicações.',
      'noPosts': 'Sem publicações',
      'noPlayers': 'Sem jogadores',
      'matchNotFound': 'Partida não encontrada',
      'tournamentNotFound': 'Torneio não encontrado',
      'requestSentSuccessfully': 'Solicitação enviada com sucesso!',
      'matchHostedSuccessfully': 'Partida criada com sucesso!',
      'pleaseTickCheckbox': 'Por favor marque a caixa',
      'verifiedSuccessfully': 'Verificado com sucesso!',
      'pleaseSelectAtLeastOneRole': 'Por favor selecione pelo menos uma função',
      'failedCreateProfile': 'Falha ao criar perfil. Tente novamente.',
      'failedUpdateProfile': 'Falha ao atualizar perfil. Tente novamente.',
      'profileUpdatedSuccessfully': 'Perfil atualizado com sucesso',
      'yourEmail': 'Seu email',
      'aboutMe': 'Sobre mim',
      'preferredJerseyNumber': 'Número preferido da camisa',
      'playingLevel': 'Nível de jogo',
      'shirtJerseySize': 'Tamanho da camisa',
      'shoeSize': 'Tamanho do calçado',
      'majorLeaguesYouFollow': 'Principais ligas que você segue',
      'teamsYouFollow': 'Equipes que você segue',
      'takePhotoUpper': 'TIRAR UMA FOTO',
      'chooseGalleryUpper': 'ESCOLHER DA GALERIA',
      'warning': 'Aviso',
      'confirmEndMatch': 'Tem certeza de que deseja encerrar esta partida?',
      'jerseysAssigned': 'Camisas atribuídas',
      'inviteSent': 'Convite enviado',
      'enterAtLeast3Chars': 'Digite pelo menos 3 caracteres para pesquisar',
      'noPlayersFound': 'Nenhum jogador encontrado',
      'invitationSentAll': 'Convite enviado para todos os números',
      'profileNameNotAvailable': 'Nome de perfil não está disponível',
      'selectYear': 'Selecionar ano',
      'camera': 'Câmera',
      'teamInfoUpdated': 'Informações da equipe atualizadas',
      'pom': 'POM',
      'score': 'Placar',
      'squad': 'Elenco',
      'pointsTable': 'Tabela de Pontos',
      'stats': 'Estatísticas',
      'groupStage': 'Fase de Grupos',
      'knockout': 'Eliminatória',
      'manOfMatch': 'Homem da Partida',
      'searchAndInvite': 'Buscar e Convidar',
      'inviteByPhone': 'Convidar por Telefone',
      'createPlayer': 'Criar Jogador',
      'all': 'Todos',
      'joined': 'Ingressado',
      'pending': 'Pendente',
      'received': 'Recebido',
      'newRequests': 'Novas Solicitações',
      'newPlayers': 'Novos Jogadores',
      'jerseyAssigned': 'Camisa Atribuída',
      'phoneNumber': 'Número de Telefone',
      'jerseyNumberHint': 'Número da camisa ou "treinador"/"gerente"',
      'enterTextHint': 'Digite o texto aqui (máx. 150 caracteres)',
      'mobileNumber': 'Número de celular',
      'countryCode': 'Código do país',
      'countryIso': 'ISO do país',
      'otp': 'OTP',
      'passwordHint': 'Senha',
      'selectPhoto': 'Selecionar Foto',
      'gameType': 'Tipo de Jogo',
      'football': 'Futebol',
      'futsal': 'Futsal',
      'ageRange': 'Faixa Etária',
      'ageCategory': 'Categoria de Idade',
      'updateTeam': 'Atualizar Equipe',
      'teamName': 'Nome do Equipe',
      'shortNameHint': 'Nome Curto (máx. 4 caracteres)',
      'cityAddress': 'Cidade / Endereço',
      'selectAgeRange': 'Selecionar faixa etária',
      'selectAgeCategory': 'Selecionar categoria de idade',
      'teamNameRequired': 'O nome da equipe é obrigatório',
      // Referee manage match
      'failedToLoadMatchDetails': 'Falha ao carregar os detalhes da partida',
      'pleaseEnterScoreProperly': 'Por favor insira o placar corretamente',
      'pleaseEnterExtraTimeDetails':
          'Por favor insira os detalhes do tempo extra',
      'pleaseEnterPenaltyDetails':
          'Por favor insira os detalhes da disputa de pênaltis',
      'matchScoreSaved': 'Placar da partida salvo',
      'extraTime': 'Tempo Extra',
      'time': 'Tempo',
      'scorer': 'Artilheiro',
      'noOfCards': 'Número de cartões',
      'player': 'Jogador',
      'pleaseSelectPom': 'Por favor selecione o jogador da partida',
      'coach': 'Treinador',
      'manager': 'Gerente',
      'pleaseSelectPlayersFromBothTeams':
          'Por favor selecione jogadores de ambas as equipes',
      'minute': 'Minuto',
      'pleaseEnterSubstituteDetails':
          'Por favor insira os detalhes do substituto',
      'matchIncidents': 'Incidentes da Partida',
      'enterTextMax200': 'Digite o texto aqui (máx. 200 caracteres)',
      'matchCommissionerReport': 'Relatório do Comissário',
      'enterTextMax300': 'Digite o texto aqui (máx. 300 caracteres)',
      'commissionerReportSaved': 'Relatório do Comissário salvo com sucesso!!!',
      'uploadMatchPhotos': 'Enviar Fotos da Partida',
      'savePhotos': 'Salvar Fotos',
      'uploadMatchHighlights': 'Enviar Momentos da Partida',
      'saveHighlights': 'Salvar Momentos',
      'uploadMatchVideos': 'Enviar Vídeos da Partida',
      'saveVideos': 'Salvar Vídeos',
      'maxPhotosUpload': 'Máximo de 5 fotos podem ser enviadas',
      'uploadingPhoto': 'Enviando foto...',
      'maxVideoSizeUpload': 'Máximo de 15MB de vídeo pode ser enviado',
      'uploadingHighlight': 'Enviando momento...',
      'maxVideosUpload': 'Máximo de 2 vídeos podem ser enviados',
      'uploadingVideo': 'Enviando vídeo...',
      'pleaseSelectMp4OrMov': 'Por favor selecione um arquivo mp4 ou mov',
      'pleaseEnterGoalDetails': 'Por favor insira os detalhes do gol',
      'pleaseEnterCardDetails': 'Por favor insira os detalhes do cartão',
      'officialsProgressSaved': 'Oficiais do clube e equipe salvos',
      'noMembersAvailable': 'Nenhum membro disponível',
      'matchDetails': 'Detalhes da Partida',
      'matchDate': 'Data da Partida',
      'matchTime': 'Hora da Partida',
      'tbd': 'A definir',
      'videoPublishedToFeed': 'Vídeo publicado no feed',
      'uploadComplete': 'Upload completo',
      'round': 'Rodada',
      // Academies
      'academyNotFound': 'Academia não encontrada',
      'joiningRequestSent': 'Solicitação de adesão enviada',
      'director': 'Diretor',
      'foundedYear': 'Ano de fundação',
      'academyJoined': 'Academia ingressada',
      'cancelRequest': 'Cancelar solicitação',
      'sendRequest': 'Enviar solicitação',
      'cat': 'CAT',
      'about': 'Sobre',
      'bio': 'Bio',
      'academyDirector': 'Diretor da academia',
      'academyManager': 'Gerente da academia',
      'academyContactNumber': 'Número de contato da academia',
      'academyContactEmail': 'Email de contato da academia',
      'skillVideos': 'Vídeos de habilidades',
      'matchVideos': 'Vídeos da partida',
      'academyNews': 'Notícias da academia',
      'registrationSuccessful': 'Registro bem-sucedido!',
      'registrationFailed': 'Falha no registro. Por favor tente novamente.',
      'emailIsRequired': 'O email é obrigatório',
      'enterValidEmailAddress': 'Digite um endereço de email válido',
      'category': 'Categoria',
      // Live Match
      'substitutions': 'Substituições',
      'penaltyShootout': 'Pênaltis',
      'lineUp': 'Escalação',
      'goalkeepers': 'Goleiros',
      'defenders': 'Defensores',
      'midfielders': 'Meio-campistas',
      'attackers': 'Atacantes',
      'ogShort': 'AG',
      'penShort': 'Pen',
      'assist': 'Assistência',
      'missed': 'Errado',
      'vs': 'vs',
      // My Bio
      'myStats': 'Minhas Estatísticas',
      'ratings': 'Avaliações',
      'minimumFiveCharsRequired': 'Mínimo de 5 caracteres necessário',
      'minimumFiveCharacters': 'mínimo de 5 caracteres',
      'pleaseSelectDateOfBirth': 'Por favor selecione a data de nascimento',
      'dateOfBirthPlaceholder': 'data de nascimento *',
      'editPost': 'Editar publicação',
      'deletePost': 'Excluir publicação',
      'deletePostConfirm': 'Tem certeza de que deseja excluir esta publicação?',
      'postDeleted': 'Publicação excluída',
      'couldNotDeletePost':
          'Não foi possível excluir a publicação. Tente novamente.',
      'unknown': 'Desconhecido',
      'failedToLoadRatings': 'Falha ao carregar avaliações',
      'overallScoreMultiline': 'PONTUAÇÃO\nGERAL',
      'skillAttributeRating': 'Avaliação de habilidades e atributos',
      'ratingLegendDescription':
          '1 - Básico  |  2 - Médio  |  3 - Bom  |  4 - Muito bom  |  5 - Excelente',
      'technical': 'Técnico',
      'physical': 'Físico',
      'mental': 'Mental',
      'goalkeeper': 'Goleiro',
      'userNotLoggedIn': 'Usuário não conectado',
      'profileNotFound': 'Perfil não encontrado',
      'myActivities': 'Minhas atividades',
      'myActivitiesDescription':
          'Mantenha um registro das suas próprias estatísticas. Atualize suas estatísticas de partidas e sessões de treino para melhorar seu perfil',
      'cleanSheetRequiredLower': 'jogo sem sofrer gols *',
      'goalsScoredRequiredLower': 'gols marcados *',
      'cleanSheetsLower': 'jogos sem sofrer gols',
      'goalsScoredLower': 'gols marcados',
      'pleaseEnterMatchMetric': 'Por favor insira {metric}.',
      'enterField': 'Insira {field}',
      'tagPlayersUpper': 'MARCAR JOGADORES',
      'searchByNameMinTwoCharacters': 'Buscar por nome (mín. 2 caracteres)…',
      'endorsementsDescription':
          'Veja seus endossos recebidos por outros jogadores e treinadores. Escolha publicar ou rejeitar os endossos recebidos.',
      'reject': 'Rejeitar',
      'publish': 'Publicar',
      'doubleTapToCheer': 'Toque duas vezes para torcer',
      'cheerCount': '{count} torcida',
      'failedToUpdateProfileTryAgain':
          'Falha ao atualizar o perfil. Tente novamente.',
      'updateUpper': 'ATUALIZAR',
      'savingEllipsis': 'Salvando…',
      'trainingSession': 'Sessão de treino',
      'gameTypeLabel': 'tipo de jogo *',
      'matchDateLabel': 'Data da Partida *',
      'selectDate': 'Selecionar data',
      'playingPositionLabel': 'Posição de jogo *',
      'positionTypeLabel': 'tipo de posição *',
      'numberOfAssistsLabel': 'número de assistências *',
      'minutesPlayedLabel': 'minutos jogados *',
      'teamsPlayedLabel': 'equipes jogadas *',
      'teamA': 'time A',
      'teamB': 'time B',
      'rateYourPerformanceLabel': 'avalie seu desempenho *',
      'howIPerformedLabel': 'como me saí *',
      'trainingSessionDateLabel': 'data da sessão de treino *',
      'trainingSessionTypeLabel': 'tipo de sessão de treino *',
      'trainingSessionMinutesLabel': 'minutos de sessão de treino *',
      'trainingNotesLabel': 'notas de treino *',
      'typeToSearchPlayers': 'Digite para buscar jogadores',
      'userFallback': 'Usuário',
      'pleaseSelectMatchDate': 'Por favor selecione uma data de partida.',
      'pleaseRateYourPerformance': 'Por favor avalie seu desempenho.',
      'pleaseEnterMinutesPlayed': 'Por favor insira os minutos jogados.',
      'matchActivityAdded': 'Atividade de partida adicionada!',
      'failedToAddMatch': 'Falha ao adicionar partida. Tente novamente.',
      'pleaseSelectTrainingDate': 'Por favor selecione uma data de treino.',
      'pleaseEnterTrainingMinutes': 'Por favor insira os minutos de treino.',
      'trainingSessionAdded': 'Sessão de treino adicionada!',
      'failedToAddTraining': 'Falha ao adicionar treino. Tente novamente.',
      'pleaseSelectPlayingPosition': 'Por favor selecione uma posição de jogo',
      'pleaseSelectPositionType': 'Por favor selecione um tipo de posição',
      'selectMatchDate': 'Selecionar data da partida',
      'selectPlayingPosition': 'Selecionar posição de jogo',
      'selectPositionType': 'Selecionar tipo de posição',
      'myTeamNameLabel': 'Nome do meu time *',
      'enterYourTeamName': 'Digite o nome do seu time',
      'opponentTeamNameLabel': 'Nome do time adversário *',
      'enterOpponentTeamName': 'Digite o nome do time adversário',
      'pleaseSelectTrainingType': 'Por favor selecione um tipo de treino',
      'trainingDateLabel': 'Data de treino *',
      'selectTrainingDate': 'Selecionar data de treino',
      'trainingTypeLabel': 'Tipo de treino *',
      'selectTrainingType': 'Selecionar tipo de treino',
      'trainingMinutesLabel': 'Minutos de treino *',
      'enterTrainingMinutes': 'Digite os minutos de treino',
      'notesOptionalLabel': 'Notas (opcional)',
      'describeTrainingSession': 'Descreva sua sessão de treino...',
      'videos': 'Vídeos',
      'photos': 'Fotos',
      'skillVideo': 'Vídeo de Habilidade',
      'skillVideoDescription':
          '(Compartilhe vídeos de suas habilidades de futebol em partidas ou treinos para ser avaliado ou qualificado pelos usuários do SocaLoca, incluindo técnicos e scouts.)',
      'footballMoments': 'Momentos de Futebol',
      'footballMomentsDescription':
          '(Compartilhe vídeos de seus momentos de futebol ou qualquer outro conteúdo relacionado ao futebol que seja benéfico para a comunidade do SocaLoca)',
      'typeAtLeast2CharsToSearch':
          'Digite pelo menos 2 caracteres para pesquisar',
      'uploadingEllipsis': 'Enviando...',
      // Referee screens
      'startSecondHalf': 'Iniciar segundo tempo',
      'startExtraTime': 'Iniciar prorrogação',
      'startPenalty': 'Iniciar pênaltis',
      'matchEndedSuccessfully': 'Partida encerrada com sucesso',
      'selectScorerFromOneTeam': 'Selecione o marcador de apenas UM time',
      'pleaseSelectScorer': 'Por favor, selecione um marcador',
      'selectCardHolderFromOneTeam':
          'Selecione o jogador cartão de apenas UM time',
      'pleaseSelectCardHolder': 'Por favor, selecione o jogador cartão',
      'pleaseSelectCardType':
          'Por favor, selecione o tipo de cartão (1º / 2º / Vermelho)',
      'pleaseSelectCardTime': 'Por favor, selecione o minuto do cartão',
      'selectSubstitutionFromOneTeam':
          'Selecione a substituição de apenas UM time',
      'pleaseSelectPlayersForSubstitution':
          'Por favor, selecione os jogadores para a substituição',
      'pleaseSelectPlayerInForMyTeam':
          'Por favor, selecione o jogador que entra pelo Meu Time',
      'pleaseSelectPlayerInForOpponent':
          'Por favor, selecione o jogador que entra pelo Time Adversário',
      'pleaseSelectPlayerOutForMyTeam':
          'Por favor, selecione o jogador que sai pelo Meu Time',
      'pleaseSelectPlayerOutForOpponent':
          'Por favor, selecione o jogador que sai pelo Time Adversário',
      'playerInAndOutSame':
          'O jogador que entra e o que sai não podem ser o mesmo',
      'pleaseEnterSubstitutionTime':
          'Por favor, insira o minuto da substituição',
      'eventTimeTooLarge':
          'O tempo do evento não pode ser maior que o tempo da partida',
      'halfTime': 'Intervalo',
      'endSecondHalf': 'Encerrar segundo tempo',
      'endExtraTime': 'Encerrar prorrogação',
      'endMatch': 'Encerrar partida',
      'postponed': 'Adiado',
      'abandoned': 'Abandonado',
      'liveMatchUpdates': 'Atualizações ao vivo',
      'caution': 'Atenção',
      'neverCloseAppDuringMatch':
          'Nunca feche o aplicativo enquanto a partida estiver ao vivo',
      'tapSaveAndPublishWhenSure':
          'Toque em "SALVAR E PUBLICAR" somente quando tiver certeza',
      'matchEnd': 'Fim da partida',
      'goal': 'Gol',
      'myRequests': 'Minhas solicitações',
      'myRequestsDescription':
          'Encontre todas as partidas atribuídas a você pelos Organizadores do Torneio. Você pode aceitar ou recusar conforme sua preferência. Todas as partidas aceitas estarão em "Minhas Partidas"',
      'noPendingMatchRequests': 'Nenhuma solicitação de partida pendente',
      'requestAccepted': 'Solicitação aceita',
      'requestDeclined': 'Solicitação recusada',
      // Social Feed
      'reportPost': 'Denunciar publicação',
      'blockPost': 'Bloquear publicação',
      'pleaseSelectReason': 'Por favor, selecione um motivo',
      'blockUserDescription':
          'Você não receberá mais nenhuma publicação nem verá nenhum comentário '
              'do usuário que está bloqueando. As pessoas bloqueadas não poderão '
              'mais marcar você, iniciar uma conversa, adicioná-lo à rede ou ver o '
              'que você publica no feed do SocaLoca. Se vocês se seguirem '
              'mutuamente, o bloqueio desfará o seguimento automaticamente.',
      'reportSubmittedThankYou': 'Denúncia enviada. Obrigado.',
      'failedToReportPost': 'Falha ao denunciar a publicação.',
      'postBlocked': 'Publicação bloqueada.',
      'failedToBlockPost': 'Falha ao bloquear a publicação.',
      'userBlocked': 'Usuário bloqueado.',
      'failedToBlockUser': 'Falha ao bloquear o usuário.',
      'failedToReportUser': 'Falha ao denunciar o usuário.',
      // Pickup Match
      'pleaseSelectStartTime': 'Por favor selecione o horário de início',
      'pleaseSelectEndTime': 'Por favor selecione o horário de término',
      'endTimeMustBeAfterStartTime':
          'O horário de término deve ser após o horário de início',
      'pleaseSelectAgeGroup': 'Por favor selecione o grupo de idade',
      'pleaseSelectLocation': 'Por favor selecione a localização',
      'userNotFound': 'Usuário não encontrado',
      'failedToHostMatch':
          'Falha ao organizar o jogo. Por favor tente novamente.',
      'startTimeRequired': 'Horário de início *',
      'endTimeRequired': 'Horário de término *',
      'venueNameRequired': 'Nome do local *',
      'venueNameIsRequired': 'O nome do local é obrigatório',
      'venueNameMinLength': 'O nome do local deve ter pelo menos 3 caracteres',
      'selectLocationFromMapRequired': 'Selecionar localização no mapa *',
      'maxPlayersRequired': 'Máximo de jogadores *',
      'maxPlayersIsRequired': 'O máximo de jogadores é obrigatório',
      'mustBePositiveNumber': 'Deve ser um número positivo',
      'matchNoteHint': 'Nota do jogo',
      'errorLoadingMatchDetails': 'Erro ao carregar os detalhes do jogo',
      'failedToSendRequest':
          'Falha ao enviar a solicitação. Por favor tente novamente.',
      'maxPlayers': 'Máximo de jogadores',
      'date': 'Data',
      'host': 'Anfitrião',
      'viewRequestsUpper': 'VER SOLICITAÇÕES',
      'acceptedUpper': 'ACEITO',
      'declinedUpper': 'RECUSADO',
      'errorLoadingRequests': 'Erro ao carregar as solicitações',
      'failedToUpdateRequest':
          'Falha ao atualizar a solicitação. Por favor tente novamente.',
      'noRequestsYet': 'Ainda não há solicitações',
      'accepted': 'Aceito',
      'declined': 'Recusado',
      // Settings
      'newPasswordMinLength': 'A nova senha deve ter pelo menos 6 caracteres',
      'newPasswordSameAsCurrent': 'A nova senha não pode ser igual à atual',
      'passwordsDoNotMatch': 'As senhas não coincidem',
      'userSessionNotFound':
          'Sessão de usuário não encontrada. Por favor faça login novamente.',
      'failedToChangePassword':
          'Falha ao alterar a senha. Por favor tente novamente.',
      'somethingWentWrongTryAgain':
          'Algo deu errado. Por favor tente novamente.',
      'currentPasswordHint': 'Senha atual *',
      'newPasswordHint': 'Nova senha *',
      'confirmPasswordHint': 'Confirmar senha *',
      'pleaseEnterName': 'Por favor insira o nome',
      'thisIsYourOwnEmail': 'Este é o seu próprio e-mail, tente outro',
      'legacyContactDescription':
          'Seu Contato Legado é a pessoa que você pode nomear para herdar '
              'sua conta caso circunstâncias imprevistas ocorram e você não '
              'consiga acessar sua conta.',
      'legacyContactInstruction':
          'Nomeie seu contato legado fornecendo o nome completo e o endereço '
              'de e-mail.',
      'nameRequired': 'Nome *',
      'aboutSocaLoca': 'Sobre o SocaLoca',
      'aboutSocaLocaText': 'SocaLoca é a primeira plataforma global de mídia social de futebol '
          'do mundo, dedicada a conectar jogadores, clubes, treinadores, árbitros '
          'e fãs. Nossa missão é tornar o futebol acessível a todos, em todos os '
          'lugares — do nível de base ao profissional. Fornecemos ferramentas para '
          'gestão de partidas, desenvolvimento de jogadores, administração de clubes '
          'e construção de comunidades dentro do belo jogo.',
      'couldNotOpenLink': 'Não foi possível abrir o link',
      'gdprComplianceText':
          'O SocaLoca está em conformidade com as práticas LGPD/RGPD para '
              'proteger você, o usuário!',
      'downloadActivityEmailInstructions':
          'Para solicitar seus dados, por favor preencha seu endereço de '
              'e-mail aqui e entraremos em contato sobre como enviar os dados.',
      'pleaseEnterValidEmailAddress':
          'Por favor insira um endereço de e-mail válido',
      'deactivateDeleteAccount': 'Desativar/Excluir Conta',
      'sorryToSeeYouLeave': 'Lamentamos que queira nos deixar.',
      'deleteOrDeactivateChoice':
          'Você pode escolher excluir ou desativar sua conta.',
      'deletionDescription':
          'A exclusão removerá sua conta dos sistemas do SocaLoca e você '
              'não poderá usá-la novamente.',
      'deactivationDescription':
          'A desativação tornará sua conta inativa. Se quiser reativá-la, '
              'basta fazer login no SocaLoca e sua conta será restaurada.',
      'accountSubmittedForDeletion': 'Conta enviada para exclusão',
      'accountDeactivated': 'Conta desativada',
      'noUpper': 'NÃO',
      'yesUpper': 'SIM',
      'legacyContact': 'Contato Legado',
      'manageAccount': 'Gerenciar Conta',
      'deactivateDeleteAccountSubItem': 'Desativar / Excluir Conta',
      'dataPrivacy': 'Privacidade de Dados',
      'error': 'Error', // TODO: translate
      'englishLanguage': 'English', // TODO: translate
      'spanishLanguage': 'Spanish', // TODO: translate
      'portugueseLanguage': 'Portuguese', // TODO: translate
      'frenchLanguage': 'French', // TODO: translate
      'pleaseSelectRating': 'Please select a rating', // TODO: translate
      'nextUpper': 'NEXT', // TODO: translate
      'submitUpper': 'SUBMIT', // TODO: translate
      'doneUpper': 'DONE', // TODO: translate
      'yourFeedbackMatters': 'Your feedback matters!', // TODO: translate
      'whatAreYourFavouriteFeatures':
          'What are your favourite features?', // TODO: translate
      'doYouWantToOfferFeedback':
          'Do you want to offer us some feedback?', // TODO: translate
      'thankYouTitle': 'Thank you!', // TODO: translate
      'weHighlyValueFeedback':
          'We highly value your feedback!', // TODO: translate
      'thankYouFeedbackSupport':
          'Thank you for giving your feedback, we appreciate your support in helping us to improve the app.', // TODO: translate
      'feed': 'Feed', // TODO: translate
      'pickUpMatch': 'Pick-Up Match', // TODO: translate
      'firstNamePlain': 'First name', // TODO: translate
      'lastNamePlain': 'Last name', // TODO: translate
      'usernameMinFiveHint': 'Username (min 5 chars)', // TODO: translate
      'nameNotAvailable': 'Name not available', // TODO: translate
      'signUpUpper': 'SIGN UP', // TODO: translate
      'mobileEmailSocaLocaIdRequired':
          'Mobile number */Email */SocaLoca ID *', // TODO: translate
      'mobileOrEmailRequired': 'mobile number or email *', // TODO: translate
      'socaLocaIdRequired': 'SocaLoca ID *', // TODO: translate
      'emailRequired': 'Email *', // TODO: translate
      'mobileNumberRequired': 'Mobile Number *', // TODO: translate
      'enterEmailRequired': 'enter your Email *', // TODO: translate
      'enterMobileNumberRequired':
          'enter your Mobile Number *', // TODO: translate
      'enterSocaLocaIdRequired': 'enter your SOCALOCA ID *', // TODO: translate
      'pleaseEnterValidMobileNumber':
          'Please enter a valid mobile number', // TODO: translate
      'pleaseEnterValidSocaLocaId':
          'Please enter valid SOCALOCA ID', // TODO: translate
      'pleaseEnterMobileOrEmail':
          'Please enter mobile or email', // TODO: translate
      'pleaseEnterYourEmailMobileOrSocaLocaId':
          'Please enter your email, mobile number or SocaLoca ID', // TODO: translate
      'pleaseEnterValidEmailMobileOrSocaLocaId':
          'Please enter valid email, mobile number or SocaLoca ID', // TODO: translate
      'pleaseEnterMobileNumberOrEmail':
          'Please enter mobile or email', // TODO: translate
      'passwordAtLeastSixCharacters':
          'Password must be at least 6 characters', // TODO: translate
      'unexpectedResponseTryAgain':
          'Unexpected response. Please try again.', // TODO: translate
      'wrongPassword': 'Wrong password', // TODO: translate
      'accountNotRegistered': 'Account not registered', // TODO: translate
      'mobileNotRegistered': 'Mobile is not registered', // TODO: translate
      'failedAcceptPolicyTryAgain':
          'Failed to accept policy. Please try again.', // TODO: translate
      'googleSignInFailed': 'Google sign-in failed', // TODO: translate
      'facebookSignInFailed': 'Facebook sign-in failed', // TODO: translate
      'googleSignInFailedWithCode':
          'Google sign-in failed ({code})', // TODO: translate
      'verifyCode': 'Verify Code', // TODO: translate
      'enterVerificationCode': 'Enter verification code', // TODO: translate
      'verify': 'Verify', // TODO: translate
      'resendCode': 'Resend Code', // TODO: translate
      'addEmail': 'Add Email', // TODO: translate
      'emailAddressRequired': 'Email address *', // TODO: translate
      'addEmailOtpPrompt':
          'No contact info found for this SocaLoca ID. Please enter an email address to receive your OTP.', // TODO: translate
      'selectCountry': 'Select Country', // TODO: translate
      'forgottenPassword': 'Forgotten Password?', // TODO: translate
      'logInUpper': 'LOG IN', // TODO: translate
      'orContinueWith': 'or continue with', // TODO: translate
      'continueLabel': 'Continue', // TODO: translate
      'tryAgain': 'TRY AGAIN', // TODO: translate
      'professionalClubQuestion':
          'Are you a Professional Football Club?', // TODO: translate
      'loginSignupHere': 'Login/Signup here', // TODO: translate
      'findSocaLocaIdHint':
          'Find your new SocaLoca ID in the sliding hamburger menu', // TODO: translate
      'socaLocaPrivacyNotice':
          '*SocaLoca only collects the data is necessary to provides its service and\nstores it in the anonymised way in our own self-hosted analytics system.', // TODO: translate
      'resetUpper': 'RESET', // TODO: translate
      'resendUpper': 'RESEND', // TODO: translate
      'proceedUpper': 'PROCEED', // TODO: translate
      'saveAndContinueUpper': 'SAVE AND CONTINUE', // TODO: translate
      'parentalControls': 'Parental Controls', // TODO: translate
      'setYourPin': 'Set Your PIN', // TODO: translate
      'forgetPin': 'Forget pin?', // TODO: translate
      'settings': 'Settings', // TODO: translate
      'modifyPin': 'Modify pin', // TODO: translate
      'pleaseProvideConsentToContinue':
          'Please provide consent to continue', // TODO: translate
      'fetchingLocation': 'Fetching location...', // TODO: translate
      'selectLocationUpper': 'SELECT LOCATION', // TODO: translate
      'skip': 'Skip', // TODO: translate
      'or': 'or', // TODO: translate
      'pleaseEnterFullDigitCode':
          'Please enter the full {length}-digit code', // TODO: translate
      'verificationCodeSentTo':
          'We sent a 6-digit code to your {type}.', // TODO: translate
      'resendCodeIn': 'Resend code in {seconds}s', // TODO: translate
      'resendUpperWithSeconds': 'RESEND ({seconds}s)', // TODO: translate
      'resetLinkSentTo': 'Reset link sent to {email}', // TODO: translate
      'errorMessage': 'Error: {error}', // TODO: translate
      'errorPickingImage': 'Error picking image: {error}', // TODO: translate
      'away': 'Away', // TODO: translate
      'third': 'Third', // TODO: translate
      'club': 'Club', // TODO: translate
      'noRecentMatches': 'No recent matches', // TODO: translate
      'errorLoadingUpcomingMatches':
          'Error loading upcoming matches', // TODO: translate
      'errorLoadingRecentMatches':
          'Error loading recent matches', // TODO: translate
      'todaysMatch': "Today's Match", // TODO: translate
      'recentlyJoined': 'Recently Joined', // TODO: translate
      'liveMatchUpdate': 'Live Match Update', // TODO: translate
      'viewUpper': 'VIEW', // TODO: translate
      'feedbackUpper': 'FEEDBACK', // TODO: translate
      'shareUpper': 'SHARE', // TODO: translate
      'socaLocaUser': 'SocaLoca User', // TODO: translate
      'socaLocaIdLabel': 'SocaLoca ID: ', // TODO: translate
      'socaLocaIdCopied': 'SocaLoca ID copied', // TODO: translate
      'loadingProfilePleaseTryAgain':
          'Loading profile, please try again', // TODO: translate
      'skillDetail': 'Skill Detail', // TODO: translate
      'people': 'People', // TODO: translate
      'likes': 'Likes', // TODO: translate
      'cup': 'Cup', // TODO: translate
      'fa': 'FA', // TODO: translate
      'fiveHours': '5 hrs', // TODO: translate
      'aUser': 'A user', // TODO: translate
      'checkHisBio': 'Check his bio', // TODO: translate
      'checkTeamBio': 'Check team bio', // TODO: translate
      'checkTournamentDetails': 'Check tournament details', // TODO: translate
      'jerseySize': 'Jersey Size', // TODO: translate
      'teamFallback': 'Team', // TODO: translate
      'tournamentFallback': 'Tournament', // TODO: translate
      'unknownDate': 'Unknown Date', // TODO: translate
      'tournamentDate': 'Tournament Date', // TODO: translate
      'tournamentVenue': 'Tournament Venue', // TODO: translate
      'totalNumberOfTeams': 'Total Number of Teams', // TODO: translate
      'numberOfPlayerPerTeam': 'Number of player per team', // TODO: translate
      'noLimit': 'No limit', // TODO: translate
      'am': 'AM', // TODO: translate
      'pm': 'PM', // TODO: translate
      'monthJan': 'Jan', // TODO: translate
      'monthFeb': 'Feb', // TODO: translate
      'monthMar': 'Mar', // TODO: translate
      'monthApr': 'Apr', // TODO: translate
      'monthMay': 'May', // TODO: translate
      'monthJun': 'Jun', // TODO: translate
      'monthJul': 'Jul', // TODO: translate
      'monthAug': 'Aug', // TODO: translate
      'monthSep': 'Sep', // TODO: translate
      'monthOct': 'Oct', // TODO: translate
      'monthNov': 'Nov', // TODO: translate
      'monthDec': 'Dec', // TODO: translate
      'checkOutPostOnSocaLoca':
          'Check out this post on SocaLoca. {url}', // TODO: translate
      'userJoinedSocaLoca': '{name} has joined SocaLoca!!! ', // TODO: translate
      'teamJoinedSocaLoca':
          '{name} has joined SocaLoca!!!\n', // TODO: translate
      'tournamentIsLive': '{name} is live!!! ', // TODO: translate
      'startedOn': 'Started on {date}', // TODO: translate
      'noJoinedTeams': 'No joined teams.', // TODO: translate
      'removePhoto': 'Remove Photo', // TODO: translate
      'selectNationality': 'Select a country', // TODO: translate
      'firstNameRequiredLower': 'first name *', // TODO: translate
      'lastNameRequiredLower': 'last name *', // TODO: translate
      'profileNameRequiredLower': 'profile name *', // TODO: translate
      'selectRoleRequired': 'Select role *', // TODO: translate
      'nationalityRequired': 'Nationality *', // TODO: translate
      'max300Characters': 'max 300 characters', // TODO: translate
      'valueInCm': 'value in cm', // TODO: translate
      'brandsYouLike': 'Brands you like', // TODO: translate
      'chooseYourAvatar': 'Choose your avatar', // TODO: translate
      'byClickingSubmitPolicy':
          'By clicking Submit, you agree to our Terms & Conditions and Privacy Policy.', // TODO: translate
      'select': 'Select', // TODO: translate
      'selectLocationFromMap': 'Select location from map', // TODO: translate
      'zeroToNinetyNine': '0 - 99', // TODO: translate
      'playerRole': 'Player', // TODO: translate
      'fan': 'Fan', // TODO: translate
      'referee': 'Referee', // TODO: translate
      'genderPlain': 'Gender', // TODO: translate
      'dateOfBirthRequired': 'Date Of Birth *', // TODO: translate
      'playingPositionPlain': 'Playing Position', // TODO: translate
      'playingLevelRequired': 'Playing Level *', // TODO: translate
      'iAmOver': 'I am over', // TODO: translate
      'iAm': 'I am', // TODO: translate
      'sixteenYears': '16 years', // TODO: translate
      'thirteenToFifteenYears': '13-15 years', // TODO: translate
      'sevenToTwelve': '7-12', // TODO: translate
      'years': 'years', // TODO: translate
      'yearsTitle': 'Years', // TODO: translate
      'old': 'old', // TODO: translate
      'parentGuardianRegisteringOnBehalf':
          'I am a parent/guardian\nregistering on behalf of a', // TODO: translate
      'thankYouForJoining':
          'Thank you for joining SocaLoca!', // TODO: translate
      'createProfileToGetStarted':
          'Please create your profile to get started.', // TODO: translate
      'createProfileUpper': 'CREATE PROFILE', // TODO: translate
      'childConsentIntro':
          'Accounts of children between the ages of 7 and 12 can only created and managed by a parent or guardian.', // TODO: translate
      'fillFieldsAndTickCheckbox':
          'Please fill out the fields below and tick the checkbox.', // TODO: translate
      'childGuardianConfirmation':
          'This is confirm that you are the legal guardian and will take full control and accountability of this account upon registering on behalf of a minor.', // TODO: translate
      'childsNameRequired': 'Childs Name*', // TODO: translate
      'parentGuardianNameRequired': 'Parent/Guardians Name*', // TODO: translate
      'parentGuardianEmailRequired':
          'Parent/Guardians Email*', // TODO: translate
      'minorConsentText':
          'I consent that I am registering on behalf of a minor and will take full control of this SocaLoca account.', // TODO: translate
      'pleaseEnterMinorName': 'Please enter minor name', // TODO: translate
      'pleaseEnterParentGuardianName':
          'Please enter parent/guardian name', // TODO: translate
      'pleaseEnterParentEmail':
          'Please enter a parent email', // TODO: translate
      'pleaseEnterValidParentEmail':
          'Please enter a valid parent email', // TODO: translate
      'youthConsentIntro':
          'Accounts of children between the ages of 13 and 15 require parent or guardian consent.', // TODO: translate
      'youthGuardianConfirmation':
          'This is confirm that you are the legal guardian and consent to this youth account registration.', // TODO: translate
      'clubName': 'Club Name', // TODO: translate
      'enterClubName': 'Enter club name', // TODO: translate
      'enterClubEmail': 'Enter club email', // TODO: translate
      'pleaseEnterClubName': 'Please enter club name', // TODO: translate
      'pleaseSelectCountry': 'Please select country', // TODO: translate
      'pleaseSelectConfederation':
          'Please select confederation', // TODO: translate
      'pleaseSelectLeague': 'Please select league', // TODO: translate
      'pleaseEnterContactName': 'Please enter contact name', // TODO: translate
      'pleaseEnterContactNumber':
          'Please enter contact number', // TODO: translate
      'emailAlreadyRegistered': 'Email already registered', // TODO: translate
      'joiningRequestThanks':
          'Thanks for your joining request. We will validate and send you the instructions shortly.', // TODO: translate
      'redirectsToSocalocaFootball':
          'Redirects to socaloca.football', // TODO: translate
      'gotItUpper': 'GOT IT', // TODO: translate
      'autoPopulatedFromCountry':
          'Auto-populated from country', // TODO: translate
      'selectCountryFirst': 'Select country first', // TODO: translate
      'selectCountryRequired': 'Select Country *', // TODO: translate
      'selectLeagueRequired': 'Select League *', // TODO: translate
      'enterContactName': 'Enter contact name', // TODO: translate
      'enterContactNumber': 'Enter contact number', // TODO: translate
      'aPlayer': 'A Player', // TODO: translate
      'aCoach': 'A Coach', // TODO: translate
      'aManager': 'A Manager', // TODO: translate
      'aReferee': 'A Referee', // TODO: translate
      'aFan': 'A Fan', // TODO: translate
      'aProfessionalClub': 'A Professional Club', // TODO: translate
      'pleaseEnterAllFourDigits':
          'Please enter all 4 digits', // TODO: translate
      'pinCannotBeSameDigits':
          'PIN cannot be all same digits', // TODO: translate
      'pinCannotBeSequential':
          'PIN cannot be sequential numbers', // TODO: translate
      'parentalPinInfo':
          '*Please note you can modify the pin from the "Parentals Control" in the hamburger menu, located at the top right of SOCALOCA app.', // TODO: translate
      'parentGuardianPhoneRequired':
          'Parent/Guardians Phone*', // TODO: translate
      'pleaseEnterMobileNumber':
          'Please enter a mobile number', // TODO: translate
      'youthConsentTitle':
          "Accounts of users between the ages of 13 and 15 can only be created and managed with a parent or guardian's consent.", // TODO: translate
      'likingAndFollowing': 'Liking and following', // TODO: translate
      'uploadingPhotosVideos': 'Uploading photos & videos', // TODO: translate
      'parentalControlConsent':
          'I consent that I am setting the parental controls on behalf of a child and will take full control of this SOCALOCA account', // TODO: translate
      'registerAsClub': 'Register as a Club', // TODO: translate
      'emailOrSocaLocaId': 'Email or SocaLoca ID', // TODO: translate
      'emailOrSocaLocaIdRequired': 'Email */SocaLoca ID *', // TODO: translate
      'pleaseEnterEmailOrSocaLocaId':
          'Please enter email or SocaLoca ID', // TODO: translate
      'pleaseEnterValidEmailOrSocaLocaId':
          'Please enter a valid email or SocaLoca ID', // TODO: translate
      'invalidCredentials': 'Invalid credentials', // TODO: translate
      'failedToLoadPlayers': 'Failed to load players', // TODO: translate
      'failedToLoadTeams': 'Failed to load teams', // TODO: translate
      'failedToLoadTeamBio': 'Failed to load team bio', // TODO: translate
      'noTeamDataAvailable': 'No team data available', // TODO: translate
      'unknownTeam': 'Unknown Team', // TODO: translate
      'thisTeamIsArchived': 'This team is archived', // TODO: translate
      'requestPendingUpper': 'REQUEST PENDING', // TODO: translate
      'requestSent': 'Request sent', // TODO: translate
      'sendRequestUpper': 'SEND REQUEST', // TODO: translate
      'tryAdjustingYourFilters':
          'Try adjusting your filters', // TODO: translate
      'noMatchesPlayedYet': 'No matches played yet', // TODO: translate
      'fullTime': 'Full time', // TODO: translate
      'fullTimeTitle': 'Full Time', // TODO: translate
      'firstHalf': 'First Half', // TODO: translate
      'secondHalf': 'Second Half', // TODO: translate
      'breakBeforeEt': 'Break Before ET', // TODO: translate
      'etFirstHalf': 'ET First Half', // TODO: translate
      'etHalfTime': 'ET Half Time', // TODO: translate
      'etSecondHalf': 'ET Second Half', // TODO: translate
      'afterExtraTime': 'After Extra Time', // TODO: translate
      'ratingLabel': 'Rating  ', // TODO: translate
      'allTemasLabel': '      All temas', // TODO: translate
      'requiredField': 'Required', // TODO: translate
      'teamWork': 'Team Work', // TODO: translate
      'aggressiveness': 'Aggressiveness', // TODO: translate
      'tactical': 'Tactical', // TODO: translate
      'overallRating': 'Overall Rating', // TODO: translate
      'teamOne': 'Team 1', // TODO: translate
      'teamTwo': 'Team 2', // TODO: translate
      'vsLower': 'vs', // TODO: translate
      'tournamentType': 'Tournament Type', // TODO: translate
      'venue': 'Venue', // TODO: translate
      'notes': 'Notes', // TODO: translate
      'description': 'Description', // TODO: translate
      'prizes': 'Prizes', // TODO: translate
      'registrationFees': 'Registration Fees', // TODO: translate
      'organizerDetails': 'Organizer Details', // TODO: translate
      'viewTournamentDetails': 'View Tournament Details ', // TODO: translate
      'matchManagement': 'Match Management', // TODO: translate
      'noPointsTableAvailable': 'No points table available', // TODO: translate
      'noDataAvailable': 'No data available', // TODO: translate
      'add': 'Add', // TODO: translate
      'addCard': 'Add Card', // TODO: translate
      'noCardsRecorded': 'No Cards Recorded', // TODO: translate
      'tapAddCards': 'Tap the button below to add cards', // TODO: translate
      'cardType': 'Card Type', // TODO: translate
      'yellow': 'Yellow', // TODO: translate
      'red': 'Red', // TODO: translate
      'playerName': 'Player Name', // TODO: translate
      'example45': 'e.g., 45', // TODO: translate
      'example23': 'e.g., 23', // TODO: translate
      'deleteCard': 'Delete Card', // TODO: translate
      'deleteGoal': 'Delete Goal', // TODO: translate
      'deleteCardConfirmation':
          'Are you sure you want to delete this card?', // TODO: translate
      'deleteGoalConfirmation':
          'Are you sure you want to delete this goal?', // TODO: translate
      'currentManOfMatch': 'Current Man of the Match', // TODO: translate
      'noMvpSelected': 'No MVP Selected', // TODO: translate
      'tapSelectMvp': 'Tap the button below to select MVP', // TODO: translate
      'selectManOfMatch': 'Select Man of the Match', // TODO: translate
      'clearMvp': 'Clear MVP', // TODO: translate
      'clearMvpConfirmation':
          'Are you sure you want to clear the Man of the Match?', // TODO: translate
      'clear': 'Clear', // TODO: translate
      'addGoal': 'Add Goal', // TODO: translate
      'noGoalsRecorded': 'No Goals Recorded', // TODO: translate
      'tapAddGoals': 'Tap the button below to add goals', // TODO: translate
      'success': 'Success', // TODO: translate
      'saveSquad': 'Save Squad', // TODO: translate
      'startingXi': 'Starting XI', // TODO: translate
      'substitutes': 'Substitutes', // TODO: translate
      'addStartingPlayer': 'Add Starting Player', // TODO: translate
      'addSubstitute': 'Add Substitute', // TODO: translate
      'noKnockoutMatchesYet': 'No knockout matches yet', // TODO: translate
      'noGroupsAvailable': 'No groups available', // TODO: translate
      'selectGroup': 'Select Group', // TODO: translate
      'viewGroupStandings': 'View Group Standings', // TODO: translate
      'groupNotFound': 'Group not found', // TODO: translate
      'noMatchesInThisGroup': 'No matches in this group', // TODO: translate
      'noEligibleTeams': 'No Eligible Teams', // TODO: translate
      'noEligibleTeamsTournament':
          "You don't have any teams eligible for this tournament.", // TODO: translate
      'noEligibleTeamsCup':
          "You don't have any teams eligible for this cup.", // TODO: translate
      'selectTeam': 'Select Team', // TODO: translate
      'tournamentStats': 'Tournament Stats', // TODO: translate
      'noRoundsAvailable': 'No rounds available', // TODO: translate
      'noStatRecordedYet': 'No {label} recorded yet', // TODO: translate
      'groupStandings': 'Group Standings', // TODO: translate
      'noStandingsAvailable': 'No standings available', // TODO: translate
      'errorLoadingStandings': 'Error loading standings', // TODO: translate
      'pointsHash': '#', // TODO: translate
      'pointsPlayed': 'P', // TODO: translate
      'pointsWon': 'W', // TODO: translate
      'pointsDrawn': 'D', // TODO: translate
      'pointsLost': 'L', // TODO: translate
      'goalsFor': 'GF', // TODO: translate
      'goalsAgainst': 'GA', // TODO: translate
      'goalDifference': 'GD', // TODO: translate
      'pointsShort': 'Pts', // TODO: translate
      'requestToJoin': 'Request to Join', // TODO: translate
      'requestToJoinCup': 'Request to Join Cup', // TODO: translate
      'pendingInvitations': 'Pending Invitations', // TODO: translate
      'viewItinerary': 'View Itinerary', // TODO: translate
      'itinerary': 'Itinerary', // TODO: translate
      'close': 'Close', // TODO: translate
      'cupTournamentNotFound': 'Cup tournament not found', // TODO: translate
      'statsUpper': 'STATS', // TODO: translate
      'selectRound': 'Select Round', // TODO: translate
      'noGroupRoundAvailable': 'No group round available', // TODO: translate
      'noKnockoutRoundAvailable':
          'No knockout round available', // TODO: translate
      'accessRestricted': 'Access Restricted', // TODO: translate
      'matchManageRestricted':
          'Only admins, coaches, and referees\ncan manage matches', // TODO: translate
      'noMatches': 'No Matches', // TODO: translate
      'noMatchesAvailableForManagement':
          'No matches available for management', // TODO: translate
      'manageMatch': 'Manage Match', // TODO: translate
      'tournamentsIntro':
          'See the listing of tournaments in your area and apply to join a competition if its right for your team. You can also view the progression of competitions in real time, see fixtures, points tables, stats and even match highlights.', // TODO: translate
      'selectManOfMatchHint':
          'Select the Man of the Match from the participating players.', // TODO: translate
      'scoreEntryHint':
          'Enter the final score for this match. The score will be submitted for approval.', // TODO: translate
      'addStartingOrSubstitutePlayer': 'Add {type} Player', // TODO: translate
      'starting': 'Starting', // TODO: translate
      'substitute': 'Substitute', // TODO: translate
      'errorLoadingTournament':
          'Error loading tournament: {error}', // TODO: translate
      'errorLoadingStandingsWithError':
          'Error loading standings: {error}', // TODO: translate
      'errorLoadingStats': 'Error loading stats: {error}', // TODO: translate
      'errorLoadingBracket':
          'Error loading bracket: {error}', // TODO: translate
      'errorLoadingMatchesWithError':
          'Error loading matches: {error}', // TODO: translate
      'errorLoadingDetails':
          'Error loading details: {error}', // TODO: translate
      'errorLoadingCup': 'Error loading cup: {error}', // TODO: translate
      'teamALabel': 'Team A', // TODO: translate
      'teamBLabel': 'Team B', // TODO: translate
      'clubsPartnerIntro':
          'These are the Professional Football Clubs that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Professional Football Club, you can request to become a SOCALOCA partner and gain access to a wide range of features, including an individualized hub with your logo and branding, in-app uploads of game highlights, training sessions, and interviews, the ability to advertise upcoming trials through your club’s dedicated hub, showcase your club teams and top players, engage fans with news, announcements, and recent results, display sponsors, and much more.', // TODO: translate
      'footballAssociationsIntro':
          "These are the Football Associations that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Football Association, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to organize tournaments and leagues using SOCALOCA's tournament module, upload game highlights, training sessions, or interviews directly within the app, engage fans with the latest news and announcements, showcase sponsors, and access a data-driven overview of your Football Association's stakeholders through SOCALOCA Analytics, plus much more.", // TODO: translate
      'footballConfederationsIntro':
          "These are the Football Confederations that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Confederation, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to organize tournaments and leagues using SOCALOCA's tournament module, upload game highlights, training sessions, or interviews directly within the app, engage fans with the latest news and announcements, showcase sponsors, and access a data-driven overview of your Football Confederation's stakeholders through SOCALOCA Analytics, plus much more.", // TODO: translate
      'sponsorsIntro':
          'These are the Sponsors that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Sponsor, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to showcase merchandise and services, promote your company through news and announcements, expand your reach, send push notifications to segmented audiences, measure your CSR impact, and much more.', // TODO: translate
      'charitiesNgosIntro':
          'These are the Charities, NGOs, and Social Enterprises that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Charity, NGO, or Social Enterprise, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to showcase your projects and initiatives, reach a wider audience, upload videos and photos, engage with followers, measure the impact of your CSR activities, and positively influence the SOCALOCA community.', // TODO: translate
      'errorLoadingClubs': 'Error loading clubs', // TODO: translate
      'noFasFound': 'No FAs found', // TODO: translate
      'noConfederationsFound': 'No confederations found', // TODO: translate
      'noSponsorsFound': 'No sponsors found', // TODO: translate
      'noCharitiesNgosFound': 'No charities & NGOs found', // TODO: translate
      'confederation': 'Confederation', // TODO: translate
      'confderations': 'Confderations', // TODO: translate
      'clubNotFound': 'Club not found', // TODO: translate
      'faNotFound': 'FA not found', // TODO: translate
      'sponsorNotFound': 'Sponsor not found', // TODO: translate
      'charityNotFound': 'Charity not found', // TODO: translate
      'couldNotLoadClubData': 'Could not load club data. ', // TODO: translate
      'nickname': 'Nickname', // TODO: translate
      'formed': 'Formed', // TODO: translate
      'formedIn': 'Formed In', // TODO: translate
      'city': 'City', // TODO: translate
      'fifaIdLabel': 'FIFA ID: ', // TODO: translate
      'liveTrial': 'LIVE TRIAL', // TODO: translate
      'registrationClosed': 'REGISTRATION CLOSED', // TODO: translate
      'newsAnnouncements': 'News & Announcements', // TODO: translate
      'viewAllPlayers': 'View All Players', // TODO: translate
      'clubTeams': 'Club Teams', // TODO: translate
      'clubSponsors': 'Club Sponsors', // TODO: translate
      'homeAwayThirdKit': 'Home Kit | Away Kit | Third Kit', // TODO: translate
      'otherCompetitions': 'Other Competitions', // TODO: translate
      'men': 'Men', // TODO: translate
      'women': 'Women', // TODO: translate
      'kit': 'Kit', // TODO: translate
      'playersTitle': 'Players', // TODO: translate
      'galleryTitle': 'Gallery', // TODO: translate
      'liveTrials': 'Live Trials', // TODO: translate
      'noTrialsFound': 'No Trials Found', // TODO: translate
      'pleaseSelectFilter': 'Please select a filter', // TODO: translate
      'toAgeGreaterThanFromAge':
          'To age must be greater than from age', // TODO: translate
      'from': 'From', // TODO: translate
      'to': 'To', // TODO: translate
      'searchUpper': 'SEARCH', // TODO: translate
      'liveNow': 'LIVE NOW', // TODO: translate
      'live': 'LIVE', // TODO: translate
      'liveUpper': 'LIVE', // TODO: translate
      'regCloses': 'Reg. Closes', // TODO: translate
      'trialStarts': 'Trial Starts', // TODO: translate
      'age': 'Age', // TODO: translate
      'cost': 'Cost', // TODO: translate
      'trialVenue': 'Trial Venue', // TODO: translate
      'trialDate': 'Trial Date', // TODO: translate
      'registration': 'Registration', // TODO: translate
      'brief': 'Brief', // TODO: translate
      'registrationRestrictedLong':
          'Registration restricted. Your profile does not match the trial criteria. SocaLoca will notify you of future Live trials!', // TODO: translate
      'registrationRestrictedShort':
          'Registration restricted. Your profile does not match the trial criteria.', // TODO: translate
      'trialRegistrationThanks':
          'Thank you for participating in live trial. Please check your mail for instructions.', // TODO: translate
      'registeredSuccessfully': 'Registered successfully!', // TODO: translate
      'registrationFailedTryAgain':
          'Registration failed. Try again.', // TODO: translate
      'free': 'Free', // TODO: translate
      'foundation': 'Foundation', // TODO: translate
      'president': 'President', // TODO: translate
      'generalSecretary': 'General Secretary', // TODO: translate
      'viewAllCompetitions': 'view all competitions', // TODO: translate
      'featuredTeams': 'Featured Teams', // TODO: translate
      'viewAllTeams': 'view all teams', // TODO: translate
      'headquarters': 'Headquarters', // TODO: translate
      'founded': 'Founded', // TODO: translate
      'ceo': 'CEO', // TODO: translate
      'founders': 'Founders', // TODO: translate
      'merchandise': 'Merchandise', // TODO: translate
      'view': 'View', // TODO: translate
      'chairman': 'Chairman', // TODO: translate
      'fundingPartners': 'Funding Partners', // TODO: translate
      'partner': 'Partner', // TODO: translate
      'basicInfo': 'Basic Info', // TODO: translate
      'position': 'Position', // TODO: translate
      'jersey': 'Jersey', // TODO: translate
      'playerNotFound': 'Player not found', // TODO: translate
      'footballStats': 'Football Stats', // TODO: translate
      'futsalStats': 'Futsal Stats', // TODO: translate
      'matchCountLabel': 'Matches', // TODO: translate
      'followerCount': '{count} Follower', // TODO: translate
      'followersCount': '{count} Followers', // TODO: translate
      'failedToUpdateFollowStatus':
          'Failed to update follow status: {error}', // TODO: translate
      'footballStatsYear': 'Football Stats ({year})', // TODO: translate
      'futsalStatsYear': 'Futsal Stats ({year})', // TODO: translate
      'cannotHostMatch': 'Cannot Host Match', // TODO: translate
      'hostMatchRestriction':
          'Only Players, Coaches, Admins, and Referees can host pickup matches.', // TODO: translate
      'pickupMatchDescription':
          "Can't get 2 full teams to make a match? Fret not. Pick-Up matches allows you to organise an informal kick-about at a specified place and time. Shout out to all nearby that you are organising a pick-up match and get your game on!", // TODO: translate
      'hostMatchUpper': 'HOST MATCH', // TODO: translate
      'noUpcomingPickupMatches':
          'No upcoming pickup matches', // TODO: translate
      'errorLoadingMatches': 'Error loading matches', // TODO: translate
      'academiesDescription':
          'SocaLoca is the home for football academies of any scale, age category, playing level, or location. SocaLoca provides an innovative and intuitive platform designed around the modern needs of a football academy.', // TODO: translate
      'goUpper': 'GO', // TODO: translate
      'noAcademiesFound': 'No academies found.', // TODO: translate
      'addTrainingSession': 'Add Training Session', // TODO: translate
      'matchDetailsAdded': 'Match details added', // TODO: translate
      'addGameTypeMatch': 'Add {gameType} Match', // TODO: translate
      'goalsSavedRequired': 'Goals Saved *', // TODO: translate
      'goalsScoredRequired': 'Goals Scored *', // TODO: translate
      'egThree': 'e.g. 3', // TODO: translate
      'egTwo': 'e.g. 2', // TODO: translate
      'goalsSaved': 'Goals saved', // TODO: translate
      'egOne': 'e.g. 1', // TODO: translate
      'egSixty': 'e.g. 60', // TODO: translate
      'egNinety': 'e.g. 90', // TODO: translate
      'opponentTeamName': 'Opponent team name', // TODO: translate
      'describeHowYouPerformed':
          'Describe how you performed...', // TODO: translate
      'videoLargerThanAvailableSpace':
          'Video larger than available space', // TODO: translate
      'pleaseWriteSomething': 'Please write something', // TODO: translate
      'pleaseSelectAtLeastOnePhoto':
          'Please select at least one photo', // TODO: translate
      'pleaseSelectAVideo': 'Please select a video', // TODO: translate
      'uploadingPhotoOf':
          'Uploading photo {current} of {total}...', // TODO: translate
      'updatingPost': 'Updating post...', // TODO: translate
      'publishingPost': 'Publishing post...', // TODO: translate
      'postUpdatedSuccessfully':
          'Post updated successfully!', // TODO: translate
      'postPublishedSuccessfully':
          'Post published successfully!', // TODO: translate
      'writeSomething': 'Write something', // TODO: translate
      'tagPeopleUpper': 'TAG PEOPLE', // TODO: translate
      'postType': 'Post Type', // TODO: translate
      'choose': 'Choose', // TODO: translate
      'notifyCoachesToEndorse':
          'Notify all coaches/managers/scounts to endorse video', // TODO: translate
      'invitePlayersUpper': 'INVITE PLAYERS', // TODO: translate
      'updatePostUpper': 'UPDATE POST', // TODO: translate
      'addPhotosCount': 'Add Photos ({current}/{max})', // TODO: translate
      'maxPhotosAllowed': '(max {max} photos allowed)', // TODO: translate
      'changeVideo': 'Change Video', // TODO: translate
      'uploadVideos': 'Upload Videos', // TODO: translate
      'maxVideosAllowed': '(max 10 videos allowed)', // TODO: translate
      'availableSpace': 'Available Space : ', // TODO: translate
      'usedSpace': 'Used Space : ', // TODO: translate
      'zeroMB': '0MB', // TODO: translate
      'maxMB': '1024MB', // TODO: translate
      'tagPlayers': 'Tag Players', // TODO: translate
      'done': 'Done', // TODO: translate
      'searchPlayersEllipsis': 'Search players...', // TODO: translate
    },

    // ── French ──────────────────────────────────────────────────────────────
    'fr': {
      'appName': 'SocaLoca',
      'cancel': 'Annuler',
      'submit': 'Envoyer',
      'yes': 'OUI',
      'no': 'Non',
      'search': 'Chercher',
      'searchEllipsis': 'Rechercher...',
      'locationPermission': 'Autorisation de localisation',
      'locationPermissionDesc':
          "SocaLoca demande l'accès à votre localisation pour vous associer à la fédération de football de votre pays. SocaLoca utilise également votre localisation pour trouver le lieu de votre tournoi. Vos données de localisation sont uniquement utilisées pour vous aider à naviguer dans votre parcours footballistique et ne sont pas enregistrées à d'autres fins.",
      'learnMore': 'En savoir plus',
      'searchHere': 'Chercher ici',
      'playerCoachManagerReferee': 'Joueur/Entraîneur/Manager/Arbitre',
      'byCountry': 'Par pays',
      'byType': 'Par type',
      'byChoice': 'Par choix',
      'mostPosts': 'Le plus de publications',
      'mostAppearances': "Le plus d'apparitions",
      'mostGoals': 'Le plus de buts',
      'endorsedByUpper': 'APPROUVÉ PAR',
      'followersUpper': 'ABONNÉS',
      'noResultsFound': 'Aucun résultat trouvé',
      'profileDetailsNotAvailable': 'Détails du profil pas encore disponibles',
      'back': 'Retour',
      'save': 'ENREGISTRER',
      'delete': 'Supprimer',
      'deactivate': 'Désactiver',
      'report': 'Signaler',
      'follow': 'Suivre',
      'following': 'Abonné',
      'followers': 'Abonnés',
      'viewAll': 'Voir tout',
      'comingSoon': 'Prochainement',
      'somethingWentWrong': "Quelque chose s'est mal passé !",
      'na': 'N/A',
      'gotIt': 'Compris',
      'upgrade': 'AMÉLIORER',
      'helpdesk': 'Assistance',
      'mandatoryFields': '* champs obligatoires',
      'goToHome': "Revenir à l'accueil",
      'selectLanguage': 'Choisir la langue',
      'selectLanguageDesc':
          'SocaLoca est disponible en plusieurs langues. Veuillez en sélectionner une pour continuer.',
      'pleaseSelectLanguage': 'Veuillez sélectionner une langue',
      'signIn': 'SE CONNECTER',
      'signUp': "S'INSCRIRE",
      'signOut': 'Se déconnecter',
      'login': 'Connexion',
      'forgotPassword': 'Mot de passe oublié ?',
      'socialLoginNoPassword':
          'Bonjour… Vous êtes connecté par un réseau social. Pas besoin de mot de passe.',
      'email': 'Mail *',
      'emailPlain': 'Mail',
      'enterYourEmail': 'Saisissez votre adresse mail',
      'password': 'Mot de passe *',
      'enterYourPassword': 'Saisissez votre mot de passe',
      'newPassword': 'Nouveau mot de passe *',
      'enterYourNewPassword': 'Saisissez votre nouveau mot de passe',
      'confirmPassword': 'Confirmer le mot de passe *',
      'currentPassword': 'Mot de passe actuel *',
      'enterYourCurrentPassword': 'Saisissez votre mot de passe actuel',
      'changePassword': 'Changer le mot de passe',
      'resetPassword': 'RÉINITIALISER',
      'sendOtp': 'ENVOYER OTP',
      'sendResetLink': 'ENVOYER LE LIEN DE RÉINITIALISATION',
      'resend': 'RENVOYER',
      'haventReceivedCode': "Vous n'avez pas reçu le code ?  ",
      'otpLabel': 'OTP *',
      'socaLocaId': 'ID SocaLoca',
      'mobile': 'Mobile',
      'enterSocaLocaId': 'Entrez votre ID SocaLoca',
      'enterMobileNumber': 'Entrez le numéro de mobile',
      'pleaseEnterEmail': 'Saisissez votre adresse mail',
      'pleaseEnterValidEmail': 'Veuillez saisir une adresse mail valable',
      'pleaseEnterPassword': 'Veuillez saisir un mot de passe',
      'minimumSixCharacters': 'Minimum 6 caractères',
      'pleaseConfirmPassword': 'Veuillez confirmer le mot de passe',
      'passwordDoesNotMatch': 'Les mots de passe ne correspondent pas',
      'passwordDoNotMatch': 'Les mots de passe ne correspondent pas',
      'invalidCurrentPassword': 'Mot de passe actuel invalide',
      'pleaseEnterCurrentPassword': 'Veuillez saisir le mot de passe actuel',
      'pleaseEnterNewPassword': 'Veuillez saisir le nouveau mot de passe',
      'pleaseConfirmNewPassword': 'Veuillez confirmer le nouveau mot de passe',
      'passwordChangedSuccessfully': 'Mot de passe modifié avec succès',
      'pleaseEnterOtp': 'Veuillez saisir le OTP',
      'verificationCodeSent': 'Code de vérification envoyé avec succès',
      'passwordResetSuccess':
          'Mot de passe réinitialisé avec succès. Veuillez vous connecter.',
      'strong': 'Fort',
      'weak': 'Faible',
      'firstName': 'Prénom *',
      'lastName': 'Nom de famille *',
      'profileName': 'Nom du profil/Surnom *',
      'enterYourName': 'Entrez votre nom',
      'dateOfBirth': 'Date de naissance *',
      'country': 'Pays',
      'gender': 'Sexe *',
      'male': 'Homme',
      'female': 'Femme',
      'nationality': 'Nationalité',
      'playingPosition': 'Poste *',
      'preferredFoot': 'Pied préféré',
      'right': 'Droit',
      'left': 'Gauche',
      'height': 'Taille',
      'heightCms': 'Taille (cms)',
      'editProfile': 'Modifier le profil',
      'createProfile': 'Créer un profil',
      'uploadProfilePhoto': 'Téléchargez votre photo de profil',
      'takeAPhoto': 'Prendre une photo',
      'chooseFromGallery': 'Choisir dans la galerie',
      'selectImage': 'Sélectionner une image',
      'myGallery': 'Ma galerie',
      'pleaseEnterFirstName': 'Veuillez saisir le prénom',
      'pleaseEnterLastName': 'Veuillez saisir le nom de famille',
      'pleaseEnterProfileName': 'Veuillez saisir le nom du profil',
      'pleaseEnterDateOfBirth': 'Veuillez saisir la date de naissance',
      'pleaseSelectNationality': 'Veuillez sélectionner la nationalité',
      'home': 'Accueil',
      'teams': 'Équipes',
      'players': 'Joueurs',
      'match': 'Match',
      'matches': 'Matchs',
      'clubsAndPartners': 'Clubs et partenaires',
      'notifications': 'Notifications',
      'noNotifications': 'Aucune notification pour le moment',
      'tournaments': 'Tournois',
      'clubs': 'Clubs',
      'partners': 'Partenaires',
      'academy': 'Académie',
      'recentMatches': 'Matchs récents',
      'upcomingMatches': 'Prochains matchs',
      'noUpcomingMatches': 'Aucun match à venir',
      'playedMatches': 'Matchs joués',
      'noPlayedMatches': 'Aucun match joué',
      'todaysMatches': "Matchs d'aujourd'hui",
      'hostMatch': 'Organiser un match',
      'manageRequests': 'Gérer les demandes',
      'selectTournamentRequired': 'sélectionner un tournoi *',
      'myMatches': 'My Matches',
      'myMatchesTournament':
          'Find all the matches assigned to you by the Tournament Organisers. Update scores and records by tapping "Manage". Download Match Report once a match is updated.',
      'noMatchesAreFound': 'Aucun match trouvé!!!',
      'manage': 'Gérer',
      'downloadMatchReport': 'Télécharger le rapport du match',
      'liveMatches': 'Live Matches',
      'liveMatchTournament':
          'Find all the matches assigned to you by the Tournament Organiser here. Tap on "START MATCH" to publish "Live Scores".',
      'noLiveMatchesAvailable': 'Aucun match en direct disponible!!!',
      'startMatch': 'Démarrer le match',
      'abandonMatch': 'Abandonner le match',
      'saveAndPublish': 'Enregistrer et publier',
      'matchStatus': 'Statut du match',
      'goals': 'Buts',
      'cards': 'Cartons',
      'substitution': 'Remplacement',
      'ownGoal': 'But contre son camp',
      'penalty': 'Penalty',
      'penaltyMissed': 'Penalty manqué',
      'minutesShort': '(Min.)',
      'selectScorer': 'Sélectionner buteur',
      'selectAssist': 'Sélectionner passeur',
      'selectPlayer': 'Sélectionner joueur',
      'firstCard': '1er',
      'secondCard': '2e',
      'redCardShort': 'Rouge',
      'playerIn': 'Joueur entrant',
      'playerOut': 'Joueur sortant',
      'selectInPlayer': 'Sélectionner entrant',
      'selectOutPlayer': 'Sélectionner sortant',
      'ongoing': 'En cours',
      'upcoming': 'À venir',
      'closed': 'Terminés',
      'myLeaguesCups': 'Mes ligues/coupes',
      'today': "Aujourd'hui",
      'noMatchForToday': "Aucun match aujourd'hui",
      'pickup': 'Pick-Up',
      'oneOff': 'Ponctuel',
      'endorsements': 'Recommandations',
      'noEndorsementsYet': "Aucune recommandation pour l'instant",
      'endorsedSuccessfully': 'Recommandé avec succès',
      'alreadyEndorsed': 'Déjà recommandé',
      'appearance': 'Apparition',
      'appearances': 'Apparitions',
      'playerBio': 'Biographie du joueur',
      'clubBio': 'Biographie du club',
      'league': 'Ligue',
      'stadium': 'Stade',
      'featuredPlayers': 'Joueurs en vedette',
      'born': 'Né',
      'goalScored': 'Buts marqués',
      'assists': 'Passes décisives',
      'yellowCard': 'Carton jaune',
      'redCard': 'Carton rouge',
      'mvp': 'MVP',
      'liked': 'Aimé',
      'tapToLike': 'Appuyez pour aimer',
      'tapToFollow': 'Appuyez pour suivre',
      'noPlayerJoinedYet': "Aucun joueur n'a encore rejoint",
      'myTeams': 'Mes équipes',
      'createTeam': 'Créer une équipe',
      'noTeamsFound': 'Aucune équipe trouvée.',
      'addPlayers': 'Ajouter des joueurs',
      'noClubsFound': 'Aucun club trouvé.',
      'noTournamentsFound': 'Aucun tournoi trouvé.',
      'competitions': 'Compétitions',
      'noCompetitionsFound': 'Aucune compétition trouvée.',
      'fas': 'FAs',
      'confederations': 'Confédérations',
      'sponsors': 'Sponsors',
      'charitiesAndNgos': 'Associations caritatives et ONG',
      'noPostsFound': 'Aucune publication trouvée.',
      'post': 'Publication',
      'posts': 'Publications',
      'createPost': 'Créer une publication',
      'uploadImage': 'Télécharger des images',
      'uploadVideo': 'Télécharger une vidéo',
      'reportThisPost': 'Signaler cette publication',
      'pleaseSelectACause': 'Veuillez sélectionner une raison',
      'pleaseSelectAtLeastOneFilter':
          'Veuillez sélectionner au moins un filtre',
      'location': 'Localisation',
      'selectLocation': 'Sélectionnez le lieu',
      'ageGroup': "Groupe d'âge",
      'game': 'Jeu',
      'register': "S'inscrire",
      'registered': 'Inscrit',
      'liveTrialRegistration': "Inscription à l'essai en direct",
      'deleteAccount': 'Désactiver/Supprimer le compte',
      'deleteAccountConfirmation':
          'Voulez-vous vraiment supprimer votre compte ?',
      'deactivateAccountConfirmation':
          'Voulez-vous vraiment désactiver votre compte ?',
      'downloadActivities': 'Télécharger vos données',
      'welcomeBack': 'Bienvenue de retour !!!',
      'weTrulyMissedYou': 'Vous nous avez manqué.',
      'hello': 'Bonjour,',
      'cheers': 'ACCLAMATIONS',
      'myBio': 'Ma bio',
      'myPosts': 'Mes publications',
      'myRatings': 'Mes notes',
      'gallery': 'Galerie',
      'sharePostPrompt':
          'Partagez une photo ou une vidéo et écrivez\nquelque chose.',
      'createPostUpper': 'CRÉER UNE PUBLICATION',
      'mostEndorsedPlayers': 'Joueurs les plus recommandés',
      'mostFollowedTeams': 'Équipes les plus suivies',
      'recentlyJoinedTeams': 'Équipes récemment inscrites',
      'ongoingTournaments': 'Tournois en cours',
      'matchUpdates': 'Mises à jour des matchs',
      'viewDetails': 'VOIR LES DÉTAILS',
      'trials': 'Essais',
      'updateProfile': 'Mettre à jour le profil',
      'changeLanguage': 'Changer de langue',
      'helpDesk': "Centre d'aide",
      'privacySettings': 'Paramètres de confidentialité',
      'helpUsToImprove': 'Aidez-nous à nous améliorer',
      'dataPolicy': 'Politique de données',
      'termsAndConditions': 'Conditions générales',
      'signOutUpper': 'SE DÉCONNECTER',
      'academies': 'Académies',
      'menu': 'Menu',
      'retry': 'Réessayer',
      'ok': 'OK',
      'block': 'Bloquer',
      'blockUser': "Bloquer l'utilisateur",
      'reportUser': "Signaler l'utilisateur",
      'selectReason': 'Sélectionnez une raison :',
      'requestCancelled': 'Demande annulée.',
      'failedToSubmitEndorsement':
          "Échec de l'envoi de la recommandation. Réessayez.",
      'requests': 'Demandes',
      'noPendingRequests': 'Aucune demande en attente.',
      'pendingRequests': 'Demandes en attente',
      'teamInvitations': "Invitations d'équipe",
      'noTeamInvitations': "Aucune invitation d'équipe.",
      'accept': 'Accepter',
      'decline': 'Refuser',
      'joinedTeams': 'Équipes rejointes',
      'noPostsYet': 'Aucune publication pour le moment.',
      'noPosts': 'Aucune publication',
      'noPlayers': 'Aucun joueur',
      'matchNotFound': 'Match introuvable',
      'tournamentNotFound': 'Tournoi introuvable',
      'requestSentSuccessfully': 'Demande envoyée avec succès !',
      'matchHostedSuccessfully': 'Match créé avec succès !',
      'pleaseTickCheckbox': 'Veuillez cocher la case',
      'verifiedSuccessfully': 'Vérifié avec succès !',
      'pleaseSelectAtLeastOneRole': 'Veuillez sélectionner au moins un rôle',
      'failedCreateProfile':
          'Impossible de créer le profil. Veuillez réessayer.',
      'failedUpdateProfile':
          'Impossible de mettre à jour le profil. Veuillez réessayer.',
      'profileUpdatedSuccessfully': 'Profil mis à jour avec succès',
      'yourEmail': 'Votre email',
      'aboutMe': 'À propos de moi',
      'preferredJerseyNumber': 'Numéro de maillot préféré',
      'playingLevel': 'Niveau de jeu',
      'shirtJerseySize': 'Taille du maillot',
      'shoeSize': 'Pointure',
      'majorLeaguesYouFollow': 'Ligues principales que vous suivez',
      'teamsYouFollow': 'Équipes que vous suivez',
      'takePhotoUpper': 'PRENDRE UNE PHOTO',
      'chooseGalleryUpper': 'CHOISIR DANS LA GALERIE',
      'warning': 'Avertissement',
      'confirmEndMatch': 'Voulez-vous vraiment terminer ce match ?',
      'jerseysAssigned': 'Maillots attribués',
      'inviteSent': 'Invitation envoyée',
      'enterAtLeast3Chars': 'Saisissez au moins 3 caractères pour rechercher',
      'noPlayersFound': 'Aucun joueur trouvé',
      'invitationSentAll': 'Invitation envoyée à tous les numéros',
      'profileNameNotAvailable': "Le nom de profil n'est pas disponible",
      'selectYear': 'Sélectionner une année',
      'camera': 'Caméra',
      'teamInfoUpdated': "Informations de l'équipe mises à jour",
      'pom': 'POM',
      'score': 'Score',
      'squad': 'Effectif',
      'pointsTable': 'Tableau des Points',
      'stats': 'Stats',
      'groupStage': 'Phase de Groupes',
      'knockout': 'Élimination directe',
      'manOfMatch': 'Homme du Match',
      'searchAndInvite': 'Rechercher et Inviter',
      'inviteByPhone': 'Inviter par Téléphone',
      'createPlayer': 'Créer un Joueur',
      'all': 'Tous',
      'joined': 'Rejoint',
      'pending': 'En attente',
      'received': 'Reçu',
      'newRequests': 'Nouvelles Demandes',
      'newPlayers': 'Nouveaux Joueurs',
      'jerseyAssigned': 'Maillot Attribué',
      'phoneNumber': 'Numéro de Téléphone',
      'jerseyNumberHint': 'Numéro de maillot ou "entraîneur"/"manager"',
      'enterTextHint': 'Saisissez du texte ici (max. 150 caractères)',
      'mobileNumber': 'Numéro de mobile',
      'countryCode': 'Code du pays',
      'countryIso': 'ISO du pays',
      'otp': 'OTP',
      'passwordHint': 'Mot de passe',
      'selectPhoto': 'Sélectionner une photo',
      'gameType': 'Type de Jeu',
      'football': 'Football',
      'futsal': 'Futsal',
      'ageRange': "Tranche d'Âge",
      'ageCategory': "Catégorie d'Âge",
      'updateTeam': "Mettre à Jour l'Équipe",
      'teamName': "Nom de l'Équipe",
      'shortNameHint': 'Nom Court (max. 4 caract.)',
      'cityAddress': 'Ville / Adresse',
      'selectAgeRange': "Sélectionner la tranche d'âge",
      'selectAgeCategory': "Sélectionner la catégorie d'âge",
      'teamNameRequired': "Le nom de l'équipe est requis",
      // Referee manage match
      'failedToLoadMatchDetails': 'Impossible de charger les détails du match',
      'pleaseEnterScoreProperly': 'Veuillez saisir le score correctement',
      'pleaseEnterExtraTimeDetails':
          'Veuillez saisir les détails des prolongations',
      'pleaseEnterPenaltyDetails':
          'Veuillez saisir les détails des tirs au but',
      'matchScoreSaved': 'Score du match enregistré',
      'extraTime': 'Prolongations',
      'time': 'Temps',
      'scorer': 'Buteur',
      'noOfCards': 'Nombre de cartons',
      'player': 'Joueur',
      'pleaseSelectPom': 'Veuillez sélectionner le joueur du match',
      'coach': 'Entraîneur',
      'manager': 'Manager',
      'pleaseSelectPlayersFromBothTeams':
          'Veuillez sélectionner des joueurs des deux équipes',
      'minute': 'Minute',
      'pleaseEnterSubstituteDetails':
          'Veuillez saisir les détails du remplaçant',
      'matchIncidents': 'Incidents du Match',
      'enterTextMax200': 'Saisissez du texte ici (max. 200 caractères)',
      'matchCommissionerReport': 'Rapport du Commissaire',
      'enterTextMax300': 'Saisissez du texte ici (max. 300 caractères)',
      'commissionerReportSaved':
          'Rapport du Commissaire enregistré avec succès !!!',
      'uploadMatchPhotos': 'Télécharger des Photos du Match',
      'savePhotos': 'Enregistrer les Photos',
      'uploadMatchHighlights': 'Télécharger les Moments Forts',
      'saveHighlights': 'Enregistrer les Moments',
      'uploadMatchVideos': 'Télécharger des Vidéos du Match',
      'saveVideos': 'Enregistrer les Vidéos',
      'maxPhotosUpload': 'Maximum 5 photos peuvent être téléchargées',
      'uploadingPhoto': 'Téléchargement de la photo...',
      'maxVideoSizeUpload': 'Vidéo de maximum 15 Mo peut être téléchargée',
      'uploadingHighlight': 'Téléchargement du moment fort...',
      'maxVideosUpload': 'Maximum 2 vidéos peuvent être téléchargées',
      'uploadingVideo': 'Téléchargement de la vidéo...',
      'pleaseSelectMp4OrMov': 'Veuillez sélectionner un fichier mp4 ou mov',
      'pleaseEnterGoalDetails': 'Veuillez saisir les détails du but',
      'pleaseEnterCardDetails': 'Veuillez saisir les détails du carton',
      'officialsProgressSaved': "Officiels du club et de l'équipe enregistrés",
      'noMembersAvailable': 'Aucun membre disponible',
      'matchDetails': 'Détails du Match',
      'matchDate': 'Date du Match',
      'matchTime': 'Heure du Match',
      'tbd': 'À définir',
      'videoPublishedToFeed': 'Vidéo publiée dans le fil',
      'uploadComplete': 'Téléchargement terminé',
      'round': 'Tour',
      // Academies
      'academyNotFound': 'Académie introuvable',
      'joiningRequestSent': "Demande d'adhésion envoyée",
      'director': 'Directeur',
      'foundedYear': 'Année de fondation',
      'academyJoined': 'Académie rejointe',
      'cancelRequest': 'Annuler la demande',
      'sendRequest': 'Envoyer la demande',
      'cat': 'CAT',
      'about': 'À propos',
      'bio': 'Bio',
      'academyDirector': "Directeur de l'académie",
      'academyManager': "Manager de l'académie",
      'academyContactNumber': "Numéro de contact de l'académie",
      'academyContactEmail': "Email de contact de l'académie",
      'skillVideos': 'Vidéos de compétences',
      'matchVideos': 'Vidéos du match',
      'academyNews': "Actualités de l'académie",
      'registrationSuccessful': 'Inscription réussie !',
      'registrationFailed': "Échec de l'inscription. Veuillez réessayer.",
      'emailIsRequired': "L'email est requis",
      'enterValidEmailAddress': 'Saisissez une adresse email valide',
      'category': 'Catégorie',
      // Live Match
      'substitutions': 'Remplacements',
      'penaltyShootout': 'Tirs au but',
      'lineUp': 'Composition',
      'goalkeepers': 'Gardiens',
      'defenders': 'Défenseurs',
      'midfielders': 'Milieux',
      'attackers': 'Attaquants',
      'ogShort': 'CSC',
      'penShort': 'Pen',
      'assist': 'Passe décisive',
      'missed': 'Raté',
      'vs': 'vs',
      // My Bio
      'myStats': 'Mes Statistiques',
      'ratings': 'Notes',
      'minimumFiveCharsRequired': '5 caractères minimum requis',
      'minimumFiveCharacters': '5 caractères minimum',
      'pleaseSelectDateOfBirth': 'Veuillez sélectionner la date de naissance',
      'dateOfBirthPlaceholder': 'date de naissance *',
      'editPost': 'Modifier la publication',
      'deletePost': 'Supprimer la publication',
      'deletePostConfirm':
          'Êtes-vous sûr de vouloir supprimer cette publication ?',
      'postDeleted': 'Publication supprimée',
      'couldNotDeletePost':
          'Impossible de supprimer la publication. Veuillez réessayer.',
      'unknown': 'Inconnu',
      'failedToLoadRatings': 'Échec du chargement des notes',
      'overallScoreMultiline': 'SCORE\nGLOBAL',
      'skillAttributeRating': 'Note des compétences et attributs',
      'ratingLegendDescription':
          '1 - Basique  |  2 - Moyen  |  3 - Bon  |  4 - Très bon  |  5 - Excellent',
      'technical': 'Technique',
      'physical': 'Physique',
      'mental': 'Mental',
      'goalkeeper': 'Gardien',
      'userNotLoggedIn': 'Utilisateur non connecté',
      'profileNotFound': 'Profil introuvable',
      'myActivities': 'Mes activités',
      'myActivitiesDescription':
          'Gardez une trace de vos propres statistiques. Mettez à jour vos statistiques de match et vos séances d’entraînement pour améliorer votre profil',
      'cleanSheetRequiredLower': 'match sans encaisser de but *',
      'goalsScoredRequiredLower': 'buts marqués *',
      'cleanSheetsLower': 'matchs sans encaisser de but',
      'goalsScoredLower': 'buts marqués',
      'pleaseEnterMatchMetric': 'Veuillez saisir {metric}.',
      'enterField': 'Saisissez {field}',
      'tagPlayersUpper': 'TAGUER DES JOUEURS',
      'searchByNameMinTwoCharacters': 'Rechercher par nom (min. 2 caractères)…',
      'endorsementsDescription':
          'Consultez les recommandations reçues d’autres joueurs et entraîneurs. Choisissez de publier ou de rejeter les recommandations reçues.',
      'reject': 'Rejeter',
      'publish': 'Publier',
      'doubleTapToCheer': 'Touchez deux fois pour encourager',
      'cheerCount': '{count} encouragement',
      'failedToUpdateProfileTryAgain':
          'Échec de la mise à jour du profil. Veuillez réessayer.',
      'updateUpper': 'METTRE À JOUR',
      'savingEllipsis': 'Enregistrement…',
      'trainingSession': "Session d'entraînement",
      'gameTypeLabel': 'type de jeu *',
      'matchDateLabel': 'Date du Match *',
      'selectDate': 'Sélectionner une date',
      'playingPositionLabel': 'Poste *',
      'positionTypeLabel': 'type de position *',
      'numberOfAssistsLabel': 'nombre de passes décisives *',
      'minutesPlayedLabel': 'minutes jouées *',
      'teamsPlayedLabel': 'équipes jouées *',
      'teamA': 'équipe A',
      'teamB': 'équipe B',
      'rateYourPerformanceLabel': 'évaluez votre performance *',
      'howIPerformedLabel': "comment j'ai performé *",
      'trainingSessionDateLabel': "date de la session d'entraînement *",
      'trainingSessionTypeLabel': "type de session d'entraînement *",
      'trainingSessionMinutesLabel': "minutes de session d'entraînement *",
      'trainingNotesLabel': "notes d'entraînement *",
      'typeToSearchPlayers': 'Tapez pour rechercher des joueurs',
      'userFallback': 'Utilisateur',
      'pleaseSelectMatchDate': 'Veuillez sélectionner une date de match.',
      'pleaseRateYourPerformance': 'Veuillez évaluer votre performance.',
      'pleaseEnterMinutesPlayed': 'Veuillez entrer les minutes jouées.',
      'matchActivityAdded': 'Activité de match ajoutée !',
      'failedToAddMatch': 'Échec de l\'ajout du match. Veuillez réessayer.',
      'pleaseSelectTrainingDate':
          "Veuillez sélectionner une date d'entraînement.",
      'pleaseEnterTrainingMinutes':
          "Veuillez entrer les minutes d'entraînement.",
      'trainingSessionAdded': "Session d'entraînement ajoutée !",
      'failedToAddTraining':
          "Échec de l'ajout de l'entraînement. Veuillez réessayer.",
      'pleaseSelectPlayingPosition':
          'Veuillez sélectionner une position de jeu',
      'pleaseSelectPositionType': 'Veuillez sélectionner un type de position',
      'selectMatchDate': 'Sélectionner la date du match',
      'selectPlayingPosition': 'Sélectionner la position de jeu',
      'selectPositionType': 'Sélectionner le type de position',
      'myTeamNameLabel': 'Nom de mon équipe *',
      'enterYourTeamName': 'Entrez le nom de votre équipe',
      'opponentTeamNameLabel': "Nom de l'équipe adverse *",
      'enterOpponentTeamName': "Entrez le nom de l'équipe adverse",
      'pleaseSelectTrainingType':
          "Veuillez sélectionner un type d'entraînement",
      'trainingDateLabel': "Date d'entraînement *",
      'selectTrainingDate': "Sélectionner la date d'entraînement",
      'trainingTypeLabel': "Type d'entraînement *",
      'selectTrainingType': "Sélectionner le type d'entraînement",
      'trainingMinutesLabel': "Minutes d'entraînement *",
      'enterTrainingMinutes': "Entrez les minutes d'entraînement",
      'notesOptionalLabel': 'Notes (facultatif)',
      'describeTrainingSession': "Décrivez votre session d'entraînement...",
      'videos': 'Vidéos',
      'photos': 'Photos',
      'skillVideo': 'Vidéo de Compétence',
      'skillVideoDescription':
          '(Partagez des vidéos de vous affichant vos compétences en football lors de matchs ou à l\'entraînement pour être approuvé ou évalué par les utilisateurs de SocaLoca, y compris les entraîneurs et les scouts.)',
      'footballMoments': 'Moments de Football',
      'footballMomentsDescription':
          '(Partagez des vidéos de vos moments de football ou tout autre contenu lié au football qui est bénéfique pour la communauté SocaLoca)',
      'typeAtLeast2CharsToSearch':
          'Tapez au moins 2 caractères pour rechercher',
      'uploadingEllipsis': 'Téléchargement...',
      // Referee screens
      'startSecondHalf': 'Démarrer la deuxième mi-temps',
      'startExtraTime': 'Démarrer les prolongations',
      'startPenalty': 'Démarrer les tirs au but',
      'matchEndedSuccessfully': 'Match terminé avec succès',
      'selectScorerFromOneTeam': 'Sélectionnez le buteur d\'une seule équipe',
      'pleaseSelectScorer': 'Veuillez sélectionner un buteur',
      'selectCardHolderFromOneTeam':
          'Sélectionnez le joueur sanctionné d\'une seule équipe',
      'pleaseSelectCardHolder': 'Veuillez sélectionner le joueur sanctionné',
      'pleaseSelectCardType':
          'Veuillez sélectionner le type de carton (1er / 2ème / Rouge)',
      'pleaseSelectCardTime': 'Veuillez sélectionner le moment du carton',
      'selectSubstitutionFromOneTeam':
          'Sélectionnez la substitution d\'une seule équipe',
      'pleaseSelectPlayersForSubstitution':
          'Veuillez sélectionner les joueurs pour la substitution',
      'pleaseSelectPlayerInForMyTeam':
          'Veuillez sélectionner le joueur entrant de Mon Équipe',
      'pleaseSelectPlayerInForOpponent':
          'Veuillez sélectionner le joueur entrant de l\'Équipe Adverse',
      'pleaseSelectPlayerOutForMyTeam':
          'Veuillez sélectionner le joueur sortant de Mon Équipe',
      'pleaseSelectPlayerOutForOpponent':
          'Veuillez sélectionner le joueur sortant de l\'Équipe Adverse',
      'playerInAndOutSame':
          'Le joueur entrant et le joueur sortant ne peuvent pas être le même',
      'pleaseEnterSubstitutionTime':
          'Veuillez saisir le temps de la substitution',
      'eventTimeTooLarge':
          'Le temps de l\'événement ne peut pas être supérieur au temps du match',
      'halfTime': 'Mi-temps',
      'endSecondHalf': 'Terminer la deuxième mi-temps',
      'endExtraTime': 'Terminer les prolongations',
      'endMatch': 'Terminer le match',
      'postponed': 'Reporté',
      'abandoned': 'Abandonné',
      'liveMatchUpdates': 'Mises à jour en direct',
      'caution': 'Attention',
      'neverCloseAppDuringMatch':
          'Ne fermez jamais l\'application pendant que le match est en direct',
      'tapSaveAndPublishWhenSure':
          'Appuyez sur "ENREGISTRER ET PUBLIER" uniquement lorsque vous êtes sûr',
      'matchEnd': 'Fin du match',
      'goal': 'But',
      'myRequests': 'Mes demandes',
      'myRequestsDescription':
          'Retrouvez tous les matchs qui vous sont attribués par les Organisateurs de Tournoi. Vous pouvez accepter ou refuser selon vos préférences. Tous les matchs acceptés seront sous "Mes Matchs"',
      'noPendingMatchRequests': 'Aucune demande de match en attente',
      'requestAccepted': 'Demande acceptée',
      'requestDeclined': 'Demande refusée',
      // Social Feed
      'reportPost': 'Signaler la publication',
      'blockPost': 'Bloquer la publication',
      'pleaseSelectReason': 'Veuillez sélectionner une raison',
      'blockUserDescription':
          'Vous ne recevrez plus aucune publication et ne pourrez plus voir les '
              'commentaires de l\'utilisateur que vous bloquez. Les personnes '
              'bloquées ne pourront plus vous identifier, démarrer une conversation, '
              'vous ajouter à leur réseau ou voir ce que vous publiez dans le fil '
              'SocaLoca. Si vous vous suivez mutuellement, le blocage annulera '
              'automatiquement l\'abonnement.',
      'reportSubmittedThankYou': 'Signalement envoyé. Merci.',
      'failedToReportPost': 'Échec du signalement de la publication.',
      'postBlocked': 'Publication bloquée.',
      'failedToBlockPost': 'Échec du blocage de la publication.',
      'userBlocked': 'Utilisateur bloqué.',
      'failedToBlockUser': 'Échec du blocage de l\'utilisateur.',
      'failedToReportUser': 'Échec du signalement de l\'utilisateur.',
      // Pickup Match
      'pleaseSelectStartTime': 'Veuillez sélectionner l\'heure de début',
      'pleaseSelectEndTime': 'Veuillez sélectionner l\'heure de fin',
      'endTimeMustBeAfterStartTime':
          'L\'heure de fin doit être après l\'heure de début',
      'pleaseSelectAgeGroup': 'Veuillez sélectionner le groupe d\'âge',
      'pleaseSelectLocation': 'Veuillez sélectionner la localisation',
      'userNotFound': 'Utilisateur introuvable',
      'failedToHostMatch':
          'Échec de l\'organisation du match. Veuillez réessayer.',
      'startTimeRequired': 'Heure de début *',
      'endTimeRequired': 'Heure de fin *',
      'venueNameRequired': 'Nom du lieu *',
      'venueNameIsRequired': 'Le nom du lieu est obligatoire',
      'venueNameMinLength':
          'Le nom du lieu doit comporter au moins 3 caractères',
      'selectLocationFromMapRequired':
          'Sélectionner la localisation sur la carte *',
      'maxPlayersRequired': 'Nombre maximum de joueurs *',
      'maxPlayersIsRequired': 'Le nombre maximum de joueurs est obligatoire',
      'mustBePositiveNumber': 'Doit être un nombre positif',
      'matchNoteHint': 'Note du match',
      'errorLoadingMatchDetails':
          'Erreur lors du chargement des détails du match',
      'failedToSendRequest':
          'Échec de l\'envoi de la demande. Veuillez réessayer.',
      'maxPlayers': 'Nombre maximum de joueurs',
      'date': 'Date',
      'host': 'Hôte',
      'viewRequestsUpper': 'VOIR LES DEMANDES',
      'acceptedUpper': 'ACCEPTÉ',
      'declinedUpper': 'REFUSÉ',
      'errorLoadingRequests': 'Erreur lors du chargement des demandes',
      'failedToUpdateRequest':
          'Échec de la mise à jour de la demande. Veuillez réessayer.',
      'noRequestsYet': 'Pas encore de demandes',
      'accepted': 'Accepté',
      'declined': 'Refusé',
      // Settings
      'newPasswordMinLength':
          'Le nouveau mot de passe doit comporter au moins 6 caractères',
      'newPasswordSameAsCurrent':
          'Le nouveau mot de passe ne peut pas être identique à l\'actuel',
      'passwordsDoNotMatch': 'Les mots de passe ne correspondent pas',
      'userSessionNotFound':
          'Session utilisateur introuvable. Veuillez vous reconnecter.',
      'failedToChangePassword':
          'Échec de la modification du mot de passe. Veuillez réessayer.',
      'somethingWentWrongTryAgain':
          'Quelque chose a mal tourné. Veuillez réessayer.',
      'currentPasswordHint': 'Mot de passe actuel *',
      'newPasswordHint': 'Nouveau mot de passe *',
      'confirmPasswordHint': 'Confirmer le mot de passe *',
      'pleaseEnterName': 'Veuillez entrer votre nom',
      'thisIsYourOwnEmail': 'C\'est votre propre e-mail, essayez-en un autre',
      'legacyContactDescription':
          'Votre Contact Légué est la personne que vous pouvez désigner pour '
              'hériter de votre compte si des circonstances imprévues vous '
              'empêchent d\'y accéder.',
      'legacyContactInstruction':
          'Désignez votre contact légué en fournissant son nom complet et '
              'son adresse e-mail.',
      'nameRequired': 'Nom *',
      'aboutSocaLoca': 'À propos de SocaLoca',
      'aboutSocaLocaText': 'SocaLoca est la première plateforme mondiale de médias sociaux de '
          'football, dédiée à connecter les joueurs, les clubs, les entraîneurs, '
          'les arbitres et les fans. Notre mission est de rendre le football '
          'accessible à tous, partout — des clubs amateurs au niveau professionnel. '
          'Nous fournissons des outils pour la gestion des matchs, le développement '
          'des joueurs, l\'administration des clubs et la construction de communautés '
          'autour du beau jeu.',
      'couldNotOpenLink': 'Impossible d\'ouvrir le lien',
      'gdprComplianceText':
          'SocaLoca est en conformité avec les pratiques RGPD pour vous '
              'protéger, vous l\'utilisateur !',
      'downloadActivityEmailInstructions':
          'Pour demander vos données, veuillez saisir votre adresse e-mail '
              'ici et nous vous contacterons pour vous expliquer comment vous '
              'les transmettre.',
      'pleaseEnterValidEmailAddress':
          'Veuillez entrer une adresse e-mail valide',
      'deactivateDeleteAccount': 'Désactiver/Supprimer le Compte',
      'sorryToSeeYouLeave': 'Nous sommes désolés que vous souhaitiez partir.',
      'deleteOrDeactivateChoice':
          'Vous pouvez choisir de supprimer ou de désactiver votre compte.',
      'deletionDescription':
          'La suppression supprimera votre compte des systèmes SocaLoca et '
              'vous ne pourrez plus l\'utiliser.',
      'deactivationDescription':
          'La désactivation rendra votre compte inactif. Pour le réactiver, '
              'il vous suffit de vous connecter à SocaLoca et votre compte sera '
              'restauré.',
      'accountSubmittedForDeletion': 'Compte soumis pour suppression',
      'accountDeactivated': 'Compte désactivé',
      'noUpper': 'NON',
      'yesUpper': 'OUI',
      'legacyContact': 'Contact Légué',
      'manageAccount': 'Gérer le Compte',
      'deactivateDeleteAccountSubItem': 'Désactiver / Supprimer le Compte',
      'dataPrivacy': 'Confidentialité des Données',
      'error': 'Error', // TODO: translate
      'englishLanguage': 'English', // TODO: translate
      'spanishLanguage': 'Spanish', // TODO: translate
      'portugueseLanguage': 'Portuguese', // TODO: translate
      'frenchLanguage': 'French', // TODO: translate
      'pleaseSelectRating': 'Please select a rating', // TODO: translate
      'nextUpper': 'NEXT', // TODO: translate
      'submitUpper': 'SUBMIT', // TODO: translate
      'doneUpper': 'DONE', // TODO: translate
      'yourFeedbackMatters': 'Your feedback matters!', // TODO: translate
      'whatAreYourFavouriteFeatures':
          'What are your favourite features?', // TODO: translate
      'doYouWantToOfferFeedback':
          'Do you want to offer us some feedback?', // TODO: translate
      'thankYouTitle': 'Thank you!', // TODO: translate
      'weHighlyValueFeedback':
          'We highly value your feedback!', // TODO: translate
      'thankYouFeedbackSupport':
          'Thank you for giving your feedback, we appreciate your support in helping us to improve the app.', // TODO: translate
      'feed': 'Feed', // TODO: translate
      'pickUpMatch': 'Pick-Up Match', // TODO: translate
      'firstNamePlain': 'First name', // TODO: translate
      'lastNamePlain': 'Last name', // TODO: translate
      'usernameMinFiveHint': 'Username (min 5 chars)', // TODO: translate
      'nameNotAvailable': 'Name not available', // TODO: translate
      'signUpUpper': 'SIGN UP', // TODO: translate
      'mobileEmailSocaLocaIdRequired':
          'Mobile number */Email */SocaLoca ID *', // TODO: translate
      'mobileOrEmailRequired': 'mobile number or email *', // TODO: translate
      'socaLocaIdRequired': 'SocaLoca ID *', // TODO: translate
      'emailRequired': 'Email *', // TODO: translate
      'mobileNumberRequired': 'Mobile Number *', // TODO: translate
      'enterEmailRequired': 'enter your Email *', // TODO: translate
      'enterMobileNumberRequired':
          'enter your Mobile Number *', // TODO: translate
      'enterSocaLocaIdRequired': 'enter your SOCALOCA ID *', // TODO: translate
      'pleaseEnterValidMobileNumber':
          'Please enter a valid mobile number', // TODO: translate
      'pleaseEnterValidSocaLocaId':
          'Please enter valid SOCALOCA ID', // TODO: translate
      'pleaseEnterMobileOrEmail':
          'Please enter mobile or email', // TODO: translate
      'pleaseEnterYourEmailMobileOrSocaLocaId':
          'Please enter your email, mobile number or SocaLoca ID', // TODO: translate
      'pleaseEnterValidEmailMobileOrSocaLocaId':
          'Please enter valid email, mobile number or SocaLoca ID', // TODO: translate
      'pleaseEnterMobileNumberOrEmail':
          'Please enter mobile or email', // TODO: translate
      'passwordAtLeastSixCharacters':
          'Password must be at least 6 characters', // TODO: translate
      'unexpectedResponseTryAgain':
          'Unexpected response. Please try again.', // TODO: translate
      'wrongPassword': 'Wrong password', // TODO: translate
      'accountNotRegistered': 'Account not registered', // TODO: translate
      'mobileNotRegistered': 'Mobile is not registered', // TODO: translate
      'failedAcceptPolicyTryAgain':
          'Failed to accept policy. Please try again.', // TODO: translate
      'googleSignInFailed': 'Google sign-in failed', // TODO: translate
      'facebookSignInFailed': 'Facebook sign-in failed', // TODO: translate
      'googleSignInFailedWithCode':
          'Google sign-in failed ({code})', // TODO: translate
      'verifyCode': 'Verify Code', // TODO: translate
      'enterVerificationCode': 'Enter verification code', // TODO: translate
      'verify': 'Verify', // TODO: translate
      'resendCode': 'Resend Code', // TODO: translate
      'addEmail': 'Add Email', // TODO: translate
      'emailAddressRequired': 'Email address *', // TODO: translate
      'addEmailOtpPrompt':
          'No contact info found for this SocaLoca ID. Please enter an email address to receive your OTP.', // TODO: translate
      'selectCountry': 'Select Country', // TODO: translate
      'forgottenPassword': 'Forgotten Password?', // TODO: translate
      'logInUpper': 'LOG IN', // TODO: translate
      'orContinueWith': 'or continue with', // TODO: translate
      'continueLabel': 'Continue', // TODO: translate
      'tryAgain': 'TRY AGAIN', // TODO: translate
      'professionalClubQuestion':
          'Are you a Professional Football Club?', // TODO: translate
      'loginSignupHere': 'Login/Signup here', // TODO: translate
      'findSocaLocaIdHint':
          'Find your new SocaLoca ID in the sliding hamburger menu', // TODO: translate
      'socaLocaPrivacyNotice':
          '*SocaLoca only collects the data is necessary to provides its service and\nstores it in the anonymised way in our own self-hosted analytics system.', // TODO: translate
      'resetUpper': 'RESET', // TODO: translate
      'resendUpper': 'RESEND', // TODO: translate
      'proceedUpper': 'PROCEED', // TODO: translate
      'saveAndContinueUpper': 'SAVE AND CONTINUE', // TODO: translate
      'parentalControls': 'Parental Controls', // TODO: translate
      'setYourPin': 'Set Your PIN', // TODO: translate
      'forgetPin': 'Forget pin?', // TODO: translate
      'settings': 'Settings', // TODO: translate
      'modifyPin': 'Modify pin', // TODO: translate
      'pleaseProvideConsentToContinue':
          'Please provide consent to continue', // TODO: translate
      'fetchingLocation': 'Fetching location...', // TODO: translate
      'selectLocationUpper': 'SELECT LOCATION', // TODO: translate
      'skip': 'Skip', // TODO: translate
      'or': 'or', // TODO: translate
      'pleaseEnterFullDigitCode':
          'Please enter the full {length}-digit code', // TODO: translate
      'verificationCodeSentTo':
          'We sent a 6-digit code to your {type}.', // TODO: translate
      'resendCodeIn': 'Resend code in {seconds}s', // TODO: translate
      'resendUpperWithSeconds': 'RESEND ({seconds}s)', // TODO: translate
      'resetLinkSentTo': 'Reset link sent to {email}', // TODO: translate
      'errorMessage': 'Error: {error}', // TODO: translate
      'errorPickingImage': 'Error picking image: {error}', // TODO: translate
      'away': 'Away', // TODO: translate
      'third': 'Third', // TODO: translate
      'club': 'Club', // TODO: translate
      'noRecentMatches': 'No recent matches', // TODO: translate
      'errorLoadingUpcomingMatches':
          'Error loading upcoming matches', // TODO: translate
      'errorLoadingRecentMatches':
          'Error loading recent matches', // TODO: translate
      'todaysMatch': "Today's Match", // TODO: translate
      'recentlyJoined': 'Recently Joined', // TODO: translate
      'liveMatchUpdate': 'Live Match Update', // TODO: translate
      'viewUpper': 'VIEW', // TODO: translate
      'feedbackUpper': 'FEEDBACK', // TODO: translate
      'shareUpper': 'SHARE', // TODO: translate
      'socaLocaUser': 'SocaLoca User', // TODO: translate
      'socaLocaIdLabel': 'SocaLoca ID: ', // TODO: translate
      'socaLocaIdCopied': 'SocaLoca ID copied', // TODO: translate
      'loadingProfilePleaseTryAgain':
          'Loading profile, please try again', // TODO: translate
      'skillDetail': 'Skill Detail', // TODO: translate
      'people': 'People', // TODO: translate
      'likes': 'Likes', // TODO: translate
      'cup': 'Cup', // TODO: translate
      'fa': 'FA', // TODO: translate
      'fiveHours': '5 hrs', // TODO: translate
      'aUser': 'A user', // TODO: translate
      'checkHisBio': 'Check his bio', // TODO: translate
      'checkTeamBio': 'Check team bio', // TODO: translate
      'checkTournamentDetails': 'Check tournament details', // TODO: translate
      'jerseySize': 'Jersey Size', // TODO: translate
      'teamFallback': 'Team', // TODO: translate
      'tournamentFallback': 'Tournament', // TODO: translate
      'unknownDate': 'Unknown Date', // TODO: translate
      'tournamentDate': 'Tournament Date', // TODO: translate
      'tournamentVenue': 'Tournament Venue', // TODO: translate
      'totalNumberOfTeams': 'Total Number of Teams', // TODO: translate
      'numberOfPlayerPerTeam': 'Number of player per team', // TODO: translate
      'noLimit': 'No limit', // TODO: translate
      'am': 'AM', // TODO: translate
      'pm': 'PM', // TODO: translate
      'monthJan': 'Jan', // TODO: translate
      'monthFeb': 'Feb', // TODO: translate
      'monthMar': 'Mar', // TODO: translate
      'monthApr': 'Apr', // TODO: translate
      'monthMay': 'May', // TODO: translate
      'monthJun': 'Jun', // TODO: translate
      'monthJul': 'Jul', // TODO: translate
      'monthAug': 'Aug', // TODO: translate
      'monthSep': 'Sep', // TODO: translate
      'monthOct': 'Oct', // TODO: translate
      'monthNov': 'Nov', // TODO: translate
      'monthDec': 'Dec', // TODO: translate
      'checkOutPostOnSocaLoca':
          'Check out this post on SocaLoca. {url}', // TODO: translate
      'userJoinedSocaLoca': '{name} has joined SocaLoca!!! ', // TODO: translate
      'teamJoinedSocaLoca':
          '{name} has joined SocaLoca!!!\n', // TODO: translate
      'tournamentIsLive': '{name} is live!!! ', // TODO: translate
      'startedOn': 'Started on {date}', // TODO: translate
      'noJoinedTeams': 'No joined teams.', // TODO: translate
      'removePhoto': 'Remove Photo', // TODO: translate
      'selectNationality': 'Select a country', // TODO: translate
      'firstNameRequiredLower': 'first name *', // TODO: translate
      'lastNameRequiredLower': 'last name *', // TODO: translate
      'profileNameRequiredLower': 'profile name *', // TODO: translate
      'selectRoleRequired': 'Select role *', // TODO: translate
      'nationalityRequired': 'Nationality *', // TODO: translate
      'max300Characters': 'max 300 characters', // TODO: translate
      'valueInCm': 'value in cm', // TODO: translate
      'brandsYouLike': 'Brands you like', // TODO: translate
      'chooseYourAvatar': 'Choose your avatar', // TODO: translate
      'byClickingSubmitPolicy':
          'By clicking Submit, you agree to our Terms & Conditions and Privacy Policy.', // TODO: translate
      'select': 'Select', // TODO: translate
      'selectLocationFromMap': 'Select location from map', // TODO: translate
      'zeroToNinetyNine': '0 - 99', // TODO: translate
      'playerRole': 'Player', // TODO: translate
      'fan': 'Fan', // TODO: translate
      'referee': 'Referee', // TODO: translate
      'genderPlain': 'Gender', // TODO: translate
      'dateOfBirthRequired': 'Date Of Birth *', // TODO: translate
      'playingPositionPlain': 'Playing Position', // TODO: translate
      'playingLevelRequired': 'Playing Level *', // TODO: translate
      'iAmOver': 'I am over', // TODO: translate
      'iAm': 'I am', // TODO: translate
      'sixteenYears': '16 years', // TODO: translate
      'thirteenToFifteenYears': '13-15 years', // TODO: translate
      'sevenToTwelve': '7-12', // TODO: translate
      'years': 'years', // TODO: translate
      'yearsTitle': 'Years', // TODO: translate
      'old': 'old', // TODO: translate
      'parentGuardianRegisteringOnBehalf':
          'I am a parent/guardian\nregistering on behalf of a', // TODO: translate
      'thankYouForJoining':
          'Thank you for joining SocaLoca!', // TODO: translate
      'createProfileToGetStarted':
          'Please create your profile to get started.', // TODO: translate
      'createProfileUpper': 'CREATE PROFILE', // TODO: translate
      'childConsentIntro':
          'Accounts of children between the ages of 7 and 12 can only created and managed by a parent or guardian.', // TODO: translate
      'fillFieldsAndTickCheckbox':
          'Please fill out the fields below and tick the checkbox.', // TODO: translate
      'childGuardianConfirmation':
          'This is confirm that you are the legal guardian and will take full control and accountability of this account upon registering on behalf of a minor.', // TODO: translate
      'childsNameRequired': 'Childs Name*', // TODO: translate
      'parentGuardianNameRequired': 'Parent/Guardians Name*', // TODO: translate
      'parentGuardianEmailRequired':
          'Parent/Guardians Email*', // TODO: translate
      'minorConsentText':
          'I consent that I am registering on behalf of a minor and will take full control of this SocaLoca account.', // TODO: translate
      'pleaseEnterMinorName': 'Please enter minor name', // TODO: translate
      'pleaseEnterParentGuardianName':
          'Please enter parent/guardian name', // TODO: translate
      'pleaseEnterParentEmail':
          'Please enter a parent email', // TODO: translate
      'pleaseEnterValidParentEmail':
          'Please enter a valid parent email', // TODO: translate
      'youthConsentIntro':
          'Accounts of children between the ages of 13 and 15 require parent or guardian consent.', // TODO: translate
      'youthGuardianConfirmation':
          'This is confirm that you are the legal guardian and consent to this youth account registration.', // TODO: translate
      'clubName': 'Club Name', // TODO: translate
      'enterClubName': 'Enter club name', // TODO: translate
      'enterClubEmail': 'Enter club email', // TODO: translate
      'pleaseEnterClubName': 'Please enter club name', // TODO: translate
      'pleaseSelectCountry': 'Please select country', // TODO: translate
      'pleaseSelectConfederation':
          'Please select confederation', // TODO: translate
      'pleaseSelectLeague': 'Please select league', // TODO: translate
      'pleaseEnterContactName': 'Please enter contact name', // TODO: translate
      'pleaseEnterContactNumber':
          'Please enter contact number', // TODO: translate
      'emailAlreadyRegistered': 'Email already registered', // TODO: translate
      'joiningRequestThanks':
          'Thanks for your joining request. We will validate and send you the instructions shortly.', // TODO: translate
      'redirectsToSocalocaFootball':
          'Redirects to socaloca.football', // TODO: translate
      'gotItUpper': 'GOT IT', // TODO: translate
      'autoPopulatedFromCountry':
          'Auto-populated from country', // TODO: translate
      'selectCountryFirst': 'Select country first', // TODO: translate
      'selectCountryRequired': 'Select Country *', // TODO: translate
      'selectLeagueRequired': 'Select League *', // TODO: translate
      'enterContactName': 'Enter contact name', // TODO: translate
      'enterContactNumber': 'Enter contact number', // TODO: translate
      'aPlayer': 'A Player', // TODO: translate
      'aCoach': 'A Coach', // TODO: translate
      'aManager': 'A Manager', // TODO: translate
      'aReferee': 'A Referee', // TODO: translate
      'aFan': 'A Fan', // TODO: translate
      'aProfessionalClub': 'A Professional Club', // TODO: translate
      'pleaseEnterAllFourDigits':
          'Please enter all 4 digits', // TODO: translate
      'pinCannotBeSameDigits':
          'PIN cannot be all same digits', // TODO: translate
      'pinCannotBeSequential':
          'PIN cannot be sequential numbers', // TODO: translate
      'parentalPinInfo':
          '*Please note you can modify the pin from the "Parentals Control" in the hamburger menu, located at the top right of SOCALOCA app.', // TODO: translate
      'parentGuardianPhoneRequired':
          'Parent/Guardians Phone*', // TODO: translate
      'pleaseEnterMobileNumber':
          'Please enter a mobile number', // TODO: translate
      'youthConsentTitle':
          "Accounts of users between the ages of 13 and 15 can only be created and managed with a parent or guardian's consent.", // TODO: translate
      'likingAndFollowing': 'Liking and following', // TODO: translate
      'uploadingPhotosVideos': 'Uploading photos & videos', // TODO: translate
      'parentalControlConsent':
          'I consent that I am setting the parental controls on behalf of a child and will take full control of this SOCALOCA account', // TODO: translate
      'registerAsClub': 'Register as a Club', // TODO: translate
      'emailOrSocaLocaId': 'Email or SocaLoca ID', // TODO: translate
      'emailOrSocaLocaIdRequired': 'Email */SocaLoca ID *', // TODO: translate
      'pleaseEnterEmailOrSocaLocaId':
          'Please enter email or SocaLoca ID', // TODO: translate
      'pleaseEnterValidEmailOrSocaLocaId':
          'Please enter a valid email or SocaLoca ID', // TODO: translate
      'invalidCredentials': 'Invalid credentials', // TODO: translate
      'failedToLoadPlayers': 'Failed to load players', // TODO: translate
      'failedToLoadTeams': 'Failed to load teams', // TODO: translate
      'failedToLoadTeamBio': 'Failed to load team bio', // TODO: translate
      'noTeamDataAvailable': 'No team data available', // TODO: translate
      'unknownTeam': 'Unknown Team', // TODO: translate
      'thisTeamIsArchived': 'This team is archived', // TODO: translate
      'requestPendingUpper': 'REQUEST PENDING', // TODO: translate
      'requestSent': 'Request sent', // TODO: translate
      'sendRequestUpper': 'SEND REQUEST', // TODO: translate
      'tryAdjustingYourFilters':
          'Try adjusting your filters', // TODO: translate
      'noMatchesPlayedYet': 'No matches played yet', // TODO: translate
      'fullTime': 'Full time', // TODO: translate
      'fullTimeTitle': 'Full Time', // TODO: translate
      'firstHalf': 'First Half', // TODO: translate
      'secondHalf': 'Second Half', // TODO: translate
      'breakBeforeEt': 'Break Before ET', // TODO: translate
      'etFirstHalf': 'ET First Half', // TODO: translate
      'etHalfTime': 'ET Half Time', // TODO: translate
      'etSecondHalf': 'ET Second Half', // TODO: translate
      'afterExtraTime': 'After Extra Time', // TODO: translate
      'ratingLabel': 'Rating  ', // TODO: translate
      'allTemasLabel': '      All temas', // TODO: translate
      'requiredField': 'Required', // TODO: translate
      'teamWork': 'Team Work', // TODO: translate
      'aggressiveness': 'Aggressiveness', // TODO: translate
      'tactical': 'Tactical', // TODO: translate
      'overallRating': 'Overall Rating', // TODO: translate
      'teamOne': 'Team 1', // TODO: translate
      'teamTwo': 'Team 2', // TODO: translate
      'vsLower': 'vs', // TODO: translate
      'tournamentType': 'Tournament Type', // TODO: translate
      'venue': 'Venue', // TODO: translate
      'notes': 'Notes', // TODO: translate
      'description': 'Description', // TODO: translate
      'prizes': 'Prizes', // TODO: translate
      'registrationFees': 'Registration Fees', // TODO: translate
      'organizerDetails': 'Organizer Details', // TODO: translate
      'viewTournamentDetails': 'View Tournament Details ', // TODO: translate
      'matchManagement': 'Match Management', // TODO: translate
      'noPointsTableAvailable': 'No points table available', // TODO: translate
      'noDataAvailable': 'No data available', // TODO: translate
      'add': 'Add', // TODO: translate
      'addCard': 'Add Card', // TODO: translate
      'noCardsRecorded': 'No Cards Recorded', // TODO: translate
      'tapAddCards': 'Tap the button below to add cards', // TODO: translate
      'cardType': 'Card Type', // TODO: translate
      'yellow': 'Yellow', // TODO: translate
      'red': 'Red', // TODO: translate
      'playerName': 'Player Name', // TODO: translate
      'example45': 'e.g., 45', // TODO: translate
      'example23': 'e.g., 23', // TODO: translate
      'deleteCard': 'Delete Card', // TODO: translate
      'deleteGoal': 'Delete Goal', // TODO: translate
      'deleteCardConfirmation':
          'Are you sure you want to delete this card?', // TODO: translate
      'deleteGoalConfirmation':
          'Are you sure you want to delete this goal?', // TODO: translate
      'currentManOfMatch': 'Current Man of the Match', // TODO: translate
      'noMvpSelected': 'No MVP Selected', // TODO: translate
      'tapSelectMvp': 'Tap the button below to select MVP', // TODO: translate
      'selectManOfMatch': 'Select Man of the Match', // TODO: translate
      'clearMvp': 'Clear MVP', // TODO: translate
      'clearMvpConfirmation':
          'Are you sure you want to clear the Man of the Match?', // TODO: translate
      'clear': 'Clear', // TODO: translate
      'addGoal': 'Add Goal', // TODO: translate
      'noGoalsRecorded': 'No Goals Recorded', // TODO: translate
      'tapAddGoals': 'Tap the button below to add goals', // TODO: translate
      'success': 'Success', // TODO: translate
      'saveSquad': 'Save Squad', // TODO: translate
      'startingXi': 'Starting XI', // TODO: translate
      'substitutes': 'Substitutes', // TODO: translate
      'addStartingPlayer': 'Add Starting Player', // TODO: translate
      'addSubstitute': 'Add Substitute', // TODO: translate
      'noKnockoutMatchesYet': 'No knockout matches yet', // TODO: translate
      'noGroupsAvailable': 'No groups available', // TODO: translate
      'selectGroup': 'Select Group', // TODO: translate
      'viewGroupStandings': 'View Group Standings', // TODO: translate
      'groupNotFound': 'Group not found', // TODO: translate
      'noMatchesInThisGroup': 'No matches in this group', // TODO: translate
      'noEligibleTeams': 'No Eligible Teams', // TODO: translate
      'noEligibleTeamsTournament':
          "You don't have any teams eligible for this tournament.", // TODO: translate
      'noEligibleTeamsCup':
          "You don't have any teams eligible for this cup.", // TODO: translate
      'selectTeam': 'Select Team', // TODO: translate
      'tournamentStats': 'Tournament Stats', // TODO: translate
      'noRoundsAvailable': 'No rounds available', // TODO: translate
      'noStatRecordedYet': 'No {label} recorded yet', // TODO: translate
      'groupStandings': 'Group Standings', // TODO: translate
      'noStandingsAvailable': 'No standings available', // TODO: translate
      'errorLoadingStandings': 'Error loading standings', // TODO: translate
      'pointsHash': '#', // TODO: translate
      'pointsPlayed': 'P', // TODO: translate
      'pointsWon': 'W', // TODO: translate
      'pointsDrawn': 'D', // TODO: translate
      'pointsLost': 'L', // TODO: translate
      'goalsFor': 'GF', // TODO: translate
      'goalsAgainst': 'GA', // TODO: translate
      'goalDifference': 'GD', // TODO: translate
      'pointsShort': 'Pts', // TODO: translate
      'requestToJoin': 'Request to Join', // TODO: translate
      'requestToJoinCup': 'Request to Join Cup', // TODO: translate
      'pendingInvitations': 'Pending Invitations', // TODO: translate
      'viewItinerary': 'View Itinerary', // TODO: translate
      'itinerary': 'Itinerary', // TODO: translate
      'close': 'Close', // TODO: translate
      'cupTournamentNotFound': 'Cup tournament not found', // TODO: translate
      'statsUpper': 'STATS', // TODO: translate
      'selectRound': 'Select Round', // TODO: translate
      'noGroupRoundAvailable': 'No group round available', // TODO: translate
      'noKnockoutRoundAvailable':
          'No knockout round available', // TODO: translate
      'accessRestricted': 'Access Restricted', // TODO: translate
      'matchManageRestricted':
          'Only admins, coaches, and referees\ncan manage matches', // TODO: translate
      'noMatches': 'No Matches', // TODO: translate
      'noMatchesAvailableForManagement':
          'No matches available for management', // TODO: translate
      'manageMatch': 'Manage Match', // TODO: translate
      'tournamentsIntro':
          'See the listing of tournaments in your area and apply to join a competition if its right for your team. You can also view the progression of competitions in real time, see fixtures, points tables, stats and even match highlights.', // TODO: translate
      'selectManOfMatchHint':
          'Select the Man of the Match from the participating players.', // TODO: translate
      'scoreEntryHint':
          'Enter the final score for this match. The score will be submitted for approval.', // TODO: translate
      'addStartingOrSubstitutePlayer': 'Add {type} Player', // TODO: translate
      'starting': 'Starting', // TODO: translate
      'substitute': 'Substitute', // TODO: translate
      'errorLoadingTournament':
          'Error loading tournament: {error}', // TODO: translate
      'errorLoadingStandingsWithError':
          'Error loading standings: {error}', // TODO: translate
      'errorLoadingStats': 'Error loading stats: {error}', // TODO: translate
      'errorLoadingBracket':
          'Error loading bracket: {error}', // TODO: translate
      'errorLoadingMatchesWithError':
          'Error loading matches: {error}', // TODO: translate
      'errorLoadingDetails':
          'Error loading details: {error}', // TODO: translate
      'errorLoadingCup': 'Error loading cup: {error}', // TODO: translate
      'teamALabel': 'Team A', // TODO: translate
      'teamBLabel': 'Team B', // TODO: translate
      'clubsPartnerIntro':
          'These are the Professional Football Clubs that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Professional Football Club, you can request to become a SOCALOCA partner and gain access to a wide range of features, including an individualized hub with your logo and branding, in-app uploads of game highlights, training sessions, and interviews, the ability to advertise upcoming trials through your club’s dedicated hub, showcase your club teams and top players, engage fans with news, announcements, and recent results, display sponsors, and much more.', // TODO: translate
      'footballAssociationsIntro':
          "These are the Football Associations that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Football Association, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to organize tournaments and leagues using SOCALOCA's tournament module, upload game highlights, training sessions, or interviews directly within the app, engage fans with the latest news and announcements, showcase sponsors, and access a data-driven overview of your Football Association's stakeholders through SOCALOCA Analytics, plus much more.", // TODO: translate
      'footballConfederationsIntro':
          "These are the Football Confederations that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Confederation, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to organize tournaments and leagues using SOCALOCA's tournament module, upload game highlights, training sessions, or interviews directly within the app, engage fans with the latest news and announcements, showcase sponsors, and access a data-driven overview of your Football Confederation's stakeholders through SOCALOCA Analytics, plus much more.", // TODO: translate
      'sponsorsIntro':
          'These are the Sponsors that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Sponsor, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to showcase merchandise and services, promote your company through news and announcements, expand your reach, send push notifications to segmented audiences, measure your CSR impact, and much more.', // TODO: translate
      'charitiesNgosIntro':
          'These are the Charities, NGOs, and Social Enterprises that have partnered with SOCALOCA to provide content and services to our users.\n\nIf you are a Charity, NGO, or Social Enterprise, you can request to become a SOCALOCA partner and gain access to an individualized hub featuring your logo, branding, and a wide range of features. These include the ability to showcase your projects and initiatives, reach a wider audience, upload videos and photos, engage with followers, measure the impact of your CSR activities, and positively influence the SOCALOCA community.', // TODO: translate
      'errorLoadingClubs': 'Error loading clubs', // TODO: translate
      'noFasFound': 'No FAs found', // TODO: translate
      'noConfederationsFound': 'No confederations found', // TODO: translate
      'noSponsorsFound': 'No sponsors found', // TODO: translate
      'noCharitiesNgosFound': 'No charities & NGOs found', // TODO: translate
      'confederation': 'Confederation', // TODO: translate
      'confderations': 'Confderations', // TODO: translate
      'clubNotFound': 'Club not found', // TODO: translate
      'faNotFound': 'FA not found', // TODO: translate
      'sponsorNotFound': 'Sponsor not found', // TODO: translate
      'charityNotFound': 'Charity not found', // TODO: translate
      'couldNotLoadClubData': 'Could not load club data. ', // TODO: translate
      'nickname': 'Nickname', // TODO: translate
      'formed': 'Formed', // TODO: translate
      'formedIn': 'Formed In', // TODO: translate
      'city': 'City', // TODO: translate
      'fifaIdLabel': 'FIFA ID: ', // TODO: translate
      'liveTrial': 'LIVE TRIAL', // TODO: translate
      'registrationClosed': 'REGISTRATION CLOSED', // TODO: translate
      'newsAnnouncements': 'News & Announcements', // TODO: translate
      'viewAllPlayers': 'View All Players', // TODO: translate
      'clubTeams': 'Club Teams', // TODO: translate
      'clubSponsors': 'Club Sponsors', // TODO: translate
      'homeAwayThirdKit': 'Home Kit | Away Kit | Third Kit', // TODO: translate
      'otherCompetitions': 'Other Competitions', // TODO: translate
      'men': 'Men', // TODO: translate
      'women': 'Women', // TODO: translate
      'kit': 'Kit', // TODO: translate
      'playersTitle': 'Players', // TODO: translate
      'galleryTitle': 'Gallery', // TODO: translate
      'liveTrials': 'Live Trials', // TODO: translate
      'noTrialsFound': 'No Trials Found', // TODO: translate
      'pleaseSelectFilter': 'Please select a filter', // TODO: translate
      'toAgeGreaterThanFromAge':
          'To age must be greater than from age', // TODO: translate
      'from': 'From', // TODO: translate
      'to': 'To', // TODO: translate
      'searchUpper': 'SEARCH', // TODO: translate
      'liveNow': 'LIVE NOW', // TODO: translate
      'live': 'LIVE', // TODO: translate
      'liveUpper': 'LIVE', // TODO: translate
      'regCloses': 'Reg. Closes', // TODO: translate
      'trialStarts': 'Trial Starts', // TODO: translate
      'age': 'Age', // TODO: translate
      'cost': 'Cost', // TODO: translate
      'trialVenue': 'Trial Venue', // TODO: translate
      'trialDate': 'Trial Date', // TODO: translate
      'registration': 'Registration', // TODO: translate
      'brief': 'Brief', // TODO: translate
      'registrationRestrictedLong':
          'Registration restricted. Your profile does not match the trial criteria. SocaLoca will notify you of future Live trials!', // TODO: translate
      'registrationRestrictedShort':
          'Registration restricted. Your profile does not match the trial criteria.', // TODO: translate
      'trialRegistrationThanks':
          'Thank you for participating in live trial. Please check your mail for instructions.', // TODO: translate
      'registeredSuccessfully': 'Registered successfully!', // TODO: translate
      'registrationFailedTryAgain':
          'Registration failed. Try again.', // TODO: translate
      'free': 'Free', // TODO: translate
      'foundation': 'Foundation', // TODO: translate
      'president': 'President', // TODO: translate
      'generalSecretary': 'General Secretary', // TODO: translate
      'viewAllCompetitions': 'view all competitions', // TODO: translate
      'featuredTeams': 'Featured Teams', // TODO: translate
      'viewAllTeams': 'view all teams', // TODO: translate
      'headquarters': 'Headquarters', // TODO: translate
      'founded': 'Founded', // TODO: translate
      'ceo': 'CEO', // TODO: translate
      'founders': 'Founders', // TODO: translate
      'merchandise': 'Merchandise', // TODO: translate
      'view': 'View', // TODO: translate
      'chairman': 'Chairman', // TODO: translate
      'fundingPartners': 'Funding Partners', // TODO: translate
      'partner': 'Partner', // TODO: translate
      'basicInfo': 'Basic Info', // TODO: translate
      'position': 'Position', // TODO: translate
      'jersey': 'Jersey', // TODO: translate
      'playerNotFound': 'Player not found', // TODO: translate
      'footballStats': 'Football Stats', // TODO: translate
      'futsalStats': 'Futsal Stats', // TODO: translate
      'matchCountLabel': 'Matches', // TODO: translate
      'followerCount': '{count} Follower', // TODO: translate
      'followersCount': '{count} Followers', // TODO: translate
      'failedToUpdateFollowStatus':
          'Failed to update follow status: {error}', // TODO: translate
      'footballStatsYear': 'Football Stats ({year})', // TODO: translate
      'futsalStatsYear': 'Futsal Stats ({year})', // TODO: translate
      'cannotHostMatch': 'Cannot Host Match', // TODO: translate
      'hostMatchRestriction':
          'Only Players, Coaches, Admins, and Referees can host pickup matches.', // TODO: translate
      'pickupMatchDescription':
          "Can't get 2 full teams to make a match? Fret not. Pick-Up matches allows you to organise an informal kick-about at a specified place and time. Shout out to all nearby that you are organising a pick-up match and get your game on!", // TODO: translate
      'hostMatchUpper': 'HOST MATCH', // TODO: translate
      'noUpcomingPickupMatches':
          'No upcoming pickup matches', // TODO: translate
      'errorLoadingMatches': 'Error loading matches', // TODO: translate
      'academiesDescription':
          'SocaLoca is the home for football academies of any scale, age category, playing level, or location. SocaLoca provides an innovative and intuitive platform designed around the modern needs of a football academy.', // TODO: translate
      'goUpper': 'GO', // TODO: translate
      'noAcademiesFound': 'No academies found.', // TODO: translate
      'addTrainingSession': 'Add Training Session', // TODO: translate
      'matchDetailsAdded': 'Match details added', // TODO: translate
      'addGameTypeMatch': 'Add {gameType} Match', // TODO: translate
      'goalsSavedRequired': 'Goals Saved *', // TODO: translate
      'goalsScoredRequired': 'Goals Scored *', // TODO: translate
      'egThree': 'e.g. 3', // TODO: translate
      'egTwo': 'e.g. 2', // TODO: translate
      'goalsSaved': 'Goals saved', // TODO: translate
      'egOne': 'e.g. 1', // TODO: translate
      'egSixty': 'e.g. 60', // TODO: translate
      'egNinety': 'e.g. 90', // TODO: translate
      'opponentTeamName': 'Opponent team name', // TODO: translate
      'describeHowYouPerformed':
          'Describe how you performed...', // TODO: translate
      'videoLargerThanAvailableSpace':
          'Video larger than available space', // TODO: translate
      'pleaseWriteSomething': 'Please write something', // TODO: translate
      'pleaseSelectAtLeastOnePhoto':
          'Please select at least one photo', // TODO: translate
      'pleaseSelectAVideo': 'Please select a video', // TODO: translate
      'uploadingPhotoOf':
          'Uploading photo {current} of {total}...', // TODO: translate
      'updatingPost': 'Updating post...', // TODO: translate
      'publishingPost': 'Publishing post...', // TODO: translate
      'postUpdatedSuccessfully':
          'Post updated successfully!', // TODO: translate
      'postPublishedSuccessfully':
          'Post published successfully!', // TODO: translate
      'writeSomething': 'Write something', // TODO: translate
      'tagPeopleUpper': 'TAG PEOPLE', // TODO: translate
      'postType': 'Post Type', // TODO: translate
      'choose': 'Choose', // TODO: translate
      'notifyCoachesToEndorse':
          'Notify all coaches/managers/scounts to endorse video', // TODO: translate
      'invitePlayersUpper': 'INVITE PLAYERS', // TODO: translate
      'updatePostUpper': 'UPDATE POST', // TODO: translate
      'addPhotosCount': 'Add Photos ({current}/{max})', // TODO: translate
      'maxPhotosAllowed': '(max {max} photos allowed)', // TODO: translate
      'changeVideo': 'Change Video', // TODO: translate
      'uploadVideos': 'Upload Videos', // TODO: translate
      'maxVideosAllowed': '(max 10 videos allowed)', // TODO: translate
      'availableSpace': 'Available Space : ', // TODO: translate
      'usedSpace': 'Used Space : ', // TODO: translate
      'zeroMB': '0MB', // TODO: translate
      'maxMB': '1024MB', // TODO: translate
      'tagPlayers': 'Tag Players', // TODO: translate
      'done': 'Done', // TODO: translate
      'searchPlayersEllipsis': 'Search players...', // TODO: translate
    },
  };
}

extension AppStringTranslation on String {
  String get tr => AppStrings.literal(this);
}
