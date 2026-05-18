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

  // ── Auth — general ────────────────────────────────────────────────────────
  static String get signIn => _t('signIn');
  static String get signUp => _t('signUp');
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
  static String get teams => _t('teams');
  static String get players => _t('players');
  static String get matches => _t('matches');
  static String get clubsAndPartners => _t('clubsAndPartners');

  // ── Notifications ─────────────────────────────────────────────────────────
  static String get notifications => _t('notifications');
  static String get noNotifications => _t('noNotifications');

  // ── Tournaments / Matches ─────────────────────────────────────────────────
  static String get tournaments => _t('tournaments');
  static String get clubs => _t('clubs');
  static String get partners => _t('partners');
  static String get academy => _t('academy');
  static String get recentMatches => _t('recentMatches');
  static String get upcomingMatches => _t('upcomingMatches');
  static String get noUpcomingMatches => _t('noUpcomingMatches');
  static String get playedMatches => _t('playedMatches');
  static String get noPlayedMatches => _t('noPlayedMatches');
  static String get todaysMatches => _t('todaysMatches');
  static String get hostMatch => _t('hostMatch');
  static String get manageRequests => _t('manageRequests');
  static String get ongoing => _t('ongoing');
  static String get today => _t('today');
  static String get noMatchForToday => _t('noMatchForToday');
  static String get pickup => _t('pickup');
  static String get oneOff => _t('oneOff');

  // ── Player / Club bio ─────────────────────────────────────────────────────
  static String get endorsements => _t('endorsements');
  static String get noEndorsementsYet => _t('noEndorsementsYet');
  static String get endorsedSuccessfully => _t('endorsedSuccessfully');
  static String get alreadyEndorsed => _t('alreadyEndorsed');
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
  static String get recentlyJoinedTeams => _t('recentlyJoinedTeams');
  static String get ongoingTournaments => _t('ongoingTournaments');
  static String get matchUpdates => _t('matchUpdates');
  static String get viewDetails => _t('viewDetails');
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
  static String get reportUser => _t('reportUser');
  static String get selectReason => _t('selectReason');
  static String get requestCancelled => _t('requestCancelled');
  static String get failedToSubmitEndorsement =>
      _t('failedToSubmitEndorsement');
  static String get noPendingRequests => _t('noPendingRequests');
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
      'signIn': 'SIGN IN',
      'signUp': 'SIGN UP',
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
      'teams': 'Teams',
      'players': 'Players',
      'matches': 'Matches',
      'clubsAndPartners': 'Clubs and Partners',
      'notifications': 'Notifications',
      'noNotifications': 'No notification for now',
      'tournaments': 'Tournaments',
      'clubs': 'Clubs',
      'partners': 'Partners',
      'academy': 'Academy',
      'recentMatches': 'Recent Matches',
      'upcomingMatches': 'Upcoming Matches',
      'noUpcomingMatches': 'No upcoming matches',
      'playedMatches': 'Played Matches',
      'noPlayedMatches': 'No played matches',
      'todaysMatches': "Today's Matches",
      'hostMatch': 'Host Match',
      'manageRequests': 'Manage Requests',
      'ongoing': 'Ongoing',
      'today': 'Today',
      'noMatchForToday': 'No match for today',
      'pickup': 'Pick-Up',
      'oneOff': 'One-off',
      'endorsements': 'Endorsements',
      'noEndorsementsYet': 'No Endorsements yet',
      'endorsedSuccessfully': 'Endorsed successfully',
      'alreadyEndorsed': 'Already endorsed',
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
      'recentlyJoinedTeams': 'Recently Joined Teams',
      'ongoingTournaments': 'Ongoing Tournaments',
      'matchUpdates': 'Match Updates',
      'viewDetails': 'VIEW DETAILS',
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
      'noPendingRequests': 'No pending requests.',
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
    },

    // ── Spanish ─────────────────────────────────────────────────────────────
    'es': {
      'appName': 'SocaLoca',
      'cancel': 'Cancelar',
      'submit': 'Enviar',
      'yes': 'SÍ',
      'no': 'No',
      'search': 'Buscar',
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
      'ongoing': 'En curso',
      'today': 'Hoy',
      'noMatchForToday': 'No hay partidos hoy',
      'pickup': 'Pick-Up',
      'oneOff': 'Único',
      'endorsements': 'Avales',
      'noEndorsementsYet': 'Aún sin avales',
      'endorsedSuccessfully': 'Avalado correctamente',
      'alreadyEndorsed': 'Ya avalado',
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
    },

    // ── Portuguese ──────────────────────────────────────────────────────────
    'pt': {
      'appName': 'SocaLoca',
      'cancel': 'Cancelar',
      'submit': 'Enviar',
      'yes': 'SIM',
      'no': 'Não',
      'search': 'Pesquisar',
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
      'ongoing': 'Em andamento',
      'today': 'Hoje',
      'noMatchForToday': 'Sem partidas hoje',
      'pickup': 'Pick-Up',
      'oneOff': 'Único',
      'endorsements': 'Recomendações',
      'noEndorsementsYet': 'Sem recomendações ainda',
      'endorsedSuccessfully': 'Recomendado com sucesso',
      'alreadyEndorsed': 'Já recomendado',
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
    },

    // ── French ──────────────────────────────────────────────────────────────
    'fr': {
      'appName': 'SocaLoca',
      'cancel': 'Annuler',
      'submit': 'Envoyer',
      'yes': 'OUI',
      'no': 'Non',
      'search': 'Chercher',
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
      'ongoing': 'En cours',
      'today': "Aujourd'hui",
      'noMatchForToday': "Aucun match aujourd'hui",
      'pickup': 'Pick-Up',
      'oneOff': 'Ponctuel',
      'endorsements': 'Recommandations',
      'noEndorsementsYet': "Aucune recommandation pour l'instant",
      'endorsedSuccessfully': 'Recommandé avec succès',
      'alreadyEndorsed': 'Déjà recommandé',
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
    },
  };
}

extension AppStringTranslation on String {
  String get tr => AppStrings.literal(this);
}
