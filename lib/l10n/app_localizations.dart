import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('pt')
  ];

  /// App name
  ///
  /// In en, this message translates to:
  /// **'SocaLoca'**
  String get appName;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Submit button
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Yes confirmation
  ///
  /// In en, this message translates to:
  /// **'YES'**
  String get yes;

  /// No confirmation
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Search placeholder/label
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Back navigation
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Save button
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get save;

  /// Delete action
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Deactivate action
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get deactivate;

  /// Report action
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// Follow button
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get follow;

  /// Following state
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get following;

  /// Followers count label
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get followers;

  /// View all link
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// Coming soon placeholder
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get somethingWentWrong;

  /// Language selection bottom sheet header
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// Language selection description
  ///
  /// In en, this message translates to:
  /// **'SocaLoca is available in multiple languages. Please select one to continue.'**
  String get selectLanguageDesc;

  /// Language selection validation error
  ///
  /// In en, this message translates to:
  /// **'Please select a language'**
  String get pleaseSelectLanguage;

  /// Sign in button
  ///
  /// In en, this message translates to:
  /// **'SIGN IN'**
  String get signIn;

  /// Sign up button
  ///
  /// In en, this message translates to:
  /// **'SIGN UP'**
  String get signUp;

  /// Sign out menu item
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// Login label
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email *'**
  String get email;

  /// Email label without asterisk
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailPlain;

  /// Email field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password *'**
  String get password;

  /// Password field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// New password field label
  ///
  /// In en, this message translates to:
  /// **'New Password *'**
  String get newPassword;

  /// New password field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get enterYourNewPassword;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password *'**
  String get confirmPassword;

  /// Current password field label
  ///
  /// In en, this message translates to:
  /// **'Current Password *'**
  String get currentPassword;

  /// Current password field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your current password'**
  String get enterYourCurrentPassword;

  /// Change password screen title
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// Forgot password link
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Reset password button
  ///
  /// In en, this message translates to:
  /// **'RESET'**
  String get resetPassword;

  /// Send OTP button on forgot password screen
  ///
  /// In en, this message translates to:
  /// **'SEND OTP'**
  String get sendOtp;

  /// Resend OTP link
  ///
  /// In en, this message translates to:
  /// **'RESEND'**
  String get resend;

  /// Resend prompt prefix
  ///
  /// In en, this message translates to:
  /// **'Haven\'t received the code?  '**
  String get haventReceivedCode;

  /// OTP field label
  ///
  /// In en, this message translates to:
  /// **'OTP *'**
  String get otpLabel;

  /// Email validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter email'**
  String get pleaseEnterEmail;

  /// Email format validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter valid email'**
  String get pleaseEnterValidEmail;

  /// Password empty validation
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get pleaseEnterPassword;

  /// Password length validation
  ///
  /// In en, this message translates to:
  /// **'Minimum 6 characters'**
  String get minimumSixCharacters;

  /// Confirm password empty validation
  ///
  /// In en, this message translates to:
  /// **'Please confirm password'**
  String get pleaseConfirmPassword;

  /// Password mismatch validation
  ///
  /// In en, this message translates to:
  /// **'Password doesn\'t match'**
  String get passwordDoesNotMatch;

  /// Password change success toast
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChangedSuccessfully;

  /// Passwords do not match error
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwordDoNotMatch;

  /// Wrong current password error
  ///
  /// In en, this message translates to:
  /// **'Invalid current password'**
  String get invalidCurrentPassword;

  /// Current password validation
  ///
  /// In en, this message translates to:
  /// **'Please enter current password'**
  String get pleaseEnterCurrentPassword;

  /// New password validation
  ///
  /// In en, this message translates to:
  /// **'Please enter new password'**
  String get pleaseEnterNewPassword;

  /// Confirm new password validation
  ///
  /// In en, this message translates to:
  /// **'Please confirm new password'**
  String get pleaseConfirmNewPassword;

  /// First name field label
  ///
  /// In en, this message translates to:
  /// **'First Name *'**
  String get firstName;

  /// Last name field label
  ///
  /// In en, this message translates to:
  /// **'Last Name *'**
  String get lastName;

  /// Profile name field label
  ///
  /// In en, this message translates to:
  /// **'Profile Name *'**
  String get profileName;

  /// Name field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// Date of birth field label
  ///
  /// In en, this message translates to:
  /// **'Date Of Birth *'**
  String get dateOfBirth;

  /// Country field label
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// Gender field label
  ///
  /// In en, this message translates to:
  /// **'Gender *'**
  String get gender;

  /// Male gender option
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// Female gender option
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// Nationality field label
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get nationality;

  /// Playing position field label
  ///
  /// In en, this message translates to:
  /// **'Playing Position *'**
  String get playingPosition;

  /// Preferred foot field label
  ///
  /// In en, this message translates to:
  /// **'Preferred Foot'**
  String get preferredFoot;

  /// Right foot option
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get right;

  /// Left foot option
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get left;

  /// Height field label
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// Height in cms field label
  ///
  /// In en, this message translates to:
  /// **'Height (cms)'**
  String get heightCms;

  /// Edit profile menu item / screen title
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// Create profile screen title
  ///
  /// In en, this message translates to:
  /// **'Create Profile'**
  String get createProfile;

  /// Upload profile photo prompt
  ///
  /// In en, this message translates to:
  /// **'Upload your profile photo'**
  String get uploadProfilePhoto;

  /// Camera option in image picker
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takeAPhoto;

  /// Gallery option in image picker
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// Select image dialog title
  ///
  /// In en, this message translates to:
  /// **'Select Image'**
  String get selectImage;

  /// Home tab label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Teams tab/section label
  ///
  /// In en, this message translates to:
  /// **'Teams'**
  String get teams;

  /// Players tab/section label
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get players;

  /// Matches tab/section label
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get matches;

  /// Clubs and partners section label
  ///
  /// In en, this message translates to:
  /// **'Clubs and Partners'**
  String get clubsAndPartners;

  /// Notifications screen title
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Empty notifications message
  ///
  /// In en, this message translates to:
  /// **'No notification for now'**
  String get noNotifications;

  /// Tournaments section label
  ///
  /// In en, this message translates to:
  /// **'Tournaments'**
  String get tournaments;

  /// Clubs section label
  ///
  /// In en, this message translates to:
  /// **'Clubs'**
  String get clubs;

  /// Partners section label
  ///
  /// In en, this message translates to:
  /// **'Partners'**
  String get partners;

  /// Academy section label
  ///
  /// In en, this message translates to:
  /// **'Academy'**
  String get academy;

  /// Recent matches section label
  ///
  /// In en, this message translates to:
  /// **'Recent Matches'**
  String get recentMatches;

  /// Upcoming matches section label
  ///
  /// In en, this message translates to:
  /// **'Upcoming Matches'**
  String get upcomingMatches;

  /// Empty upcoming matches message
  ///
  /// In en, this message translates to:
  /// **'No upcoming matches'**
  String get noUpcomingMatches;

  /// Played matches section label
  ///
  /// In en, this message translates to:
  /// **'Played Matches'**
  String get playedMatches;

  /// Empty played matches message
  ///
  /// In en, this message translates to:
  /// **'No played matches'**
  String get noPlayedMatches;

  /// Today's matches section label
  ///
  /// In en, this message translates to:
  /// **'Today\'s Matches'**
  String get todaysMatches;

  /// Host match button
  ///
  /// In en, this message translates to:
  /// **'Host Match'**
  String get hostMatch;

  /// Manage requests label
  ///
  /// In en, this message translates to:
  /// **'Manage Requests'**
  String get manageRequests;

  /// Ongoing match status
  ///
  /// In en, this message translates to:
  /// **'Ongoing'**
  String get ongoing;

  /// Today label
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Endorsements section label
  ///
  /// In en, this message translates to:
  /// **'Endorsements'**
  String get endorsements;

  /// Empty endorsements message
  ///
  /// In en, this message translates to:
  /// **'No Endorsements yet'**
  String get noEndorsementsYet;

  /// Endorse success toast
  ///
  /// In en, this message translates to:
  /// **'Endorsed successfully'**
  String get endorsedSuccessfully;

  /// Already endorsed message
  ///
  /// In en, this message translates to:
  /// **'Already endorsed'**
  String get alreadyEndorsed;

  /// Player bio section label
  ///
  /// In en, this message translates to:
  /// **'Player Bio'**
  String get playerBio;

  /// Club bio section label
  ///
  /// In en, this message translates to:
  /// **'Club Bio'**
  String get clubBio;

  /// League label
  ///
  /// In en, this message translates to:
  /// **'League'**
  String get league;

  /// Stadium label
  ///
  /// In en, this message translates to:
  /// **'Stadium'**
  String get stadium;

  /// Featured players section label
  ///
  /// In en, this message translates to:
  /// **'Featured Players'**
  String get featuredPlayers;

  /// My teams section label
  ///
  /// In en, this message translates to:
  /// **'My Teams'**
  String get myTeams;

  /// Create team button
  ///
  /// In en, this message translates to:
  /// **'Create Team'**
  String get createTeam;

  /// Empty teams message
  ///
  /// In en, this message translates to:
  /// **'No teams found.'**
  String get noTeamsFound;

  /// Empty clubs message
  ///
  /// In en, this message translates to:
  /// **'No clubs found.'**
  String get noClubsFound;

  /// Empty tournaments message
  ///
  /// In en, this message translates to:
  /// **'No tournaments found.'**
  String get noTournamentsFound;

  /// Empty posts message
  ///
  /// In en, this message translates to:
  /// **'No posts found.'**
  String get noPostsFound;

  /// Posts section label
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get posts;

  /// Location field label
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// Location picker title
  ///
  /// In en, this message translates to:
  /// **'Select Location'**
  String get selectLocation;

  /// Age group filter label
  ///
  /// In en, this message translates to:
  /// **'Age Group'**
  String get ageGroup;

  /// Game type filter label
  ///
  /// In en, this message translates to:
  /// **'Game'**
  String get game;

  /// Competitions section label
  ///
  /// In en, this message translates to:
  /// **'Competitions'**
  String get competitions;

  /// Empty competitions message
  ///
  /// In en, this message translates to:
  /// **'No competitions found.'**
  String get noCompetitionsFound;

  /// Register button
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Registered status
  ///
  /// In en, this message translates to:
  /// **'Registered'**
  String get registered;

  /// Live trial registration label
  ///
  /// In en, this message translates to:
  /// **'Live Trial Registration'**
  String get liveTrialRegistration;

  /// Confirmation button
  ///
  /// In en, this message translates to:
  /// **'Got It'**
  String get gotIt;

  /// Upgrade button
  ///
  /// In en, this message translates to:
  /// **'UPGRADE'**
  String get upgrade;

  /// Helpdesk menu item
  ///
  /// In en, this message translates to:
  /// **'Helpdesk'**
  String get helpdesk;

  /// Delete account option
  ///
  /// In en, this message translates to:
  /// **'Deactivate/Delete Account'**
  String get deleteAccount;

  /// Delete account confirmation
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to Delete your Account?'**
  String get deleteAccountConfirmation;

  /// Deactivate account confirmation
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to Deactivate your Account?'**
  String get deactivateAccountConfirmation;

  /// Download activities option
  ///
  /// In en, this message translates to:
  /// **'Download Activities'**
  String get downloadActivities;

  /// First name validation
  ///
  /// In en, this message translates to:
  /// **'Please enter first name'**
  String get pleaseEnterFirstName;

  /// Last name validation
  ///
  /// In en, this message translates to:
  /// **'Please enter last name'**
  String get pleaseEnterLastName;

  /// Profile name validation
  ///
  /// In en, this message translates to:
  /// **'Please enter profile name'**
  String get pleaseEnterProfileName;

  /// DOB validation
  ///
  /// In en, this message translates to:
  /// **'Please enter date of birth'**
  String get pleaseEnterDateOfBirth;

  /// Nationality validation
  ///
  /// In en, this message translates to:
  /// **'Please select nationality'**
  String get pleaseSelectNationality;

  /// Filter validation
  ///
  /// In en, this message translates to:
  /// **'Please select at least one filter'**
  String get pleaseSelectAtLeastOneFilter;

  /// Report post dialog title
  ///
  /// In en, this message translates to:
  /// **'Report This Post'**
  String get reportThisPost;

  /// Report cause validation
  ///
  /// In en, this message translates to:
  /// **'Please select a cause'**
  String get pleaseSelectACause;

  /// Social login password change warning
  ///
  /// In en, this message translates to:
  /// **'Hey there… You have used social login. No need of passwords.'**
  String get socialLoginNoPassword;

  /// Welcome back message
  ///
  /// In en, this message translates to:
  /// **'Welcome back!!!'**
  String get welcomeBack;

  /// Welcome back sub-message
  ///
  /// In en, this message translates to:
  /// **'We truly missed you.'**
  String get weTrulyMissedYou;

  /// Add players button
  ///
  /// In en, this message translates to:
  /// **'Add Players'**
  String get addPlayers;

  /// Empty players message
  ///
  /// In en, this message translates to:
  /// **'No player joined yet'**
  String get noPlayerJoinedYet;

  /// Mandatory fields note
  ///
  /// In en, this message translates to:
  /// **'* mandatory fields'**
  String get mandatory_fields;

  /// Strong password indicator
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get strong;

  /// Weak password indicator
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get weak;

  /// Go to home button
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get goToHome;

  /// Not available placeholder
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get na;

  /// Born label on player bio
  ///
  /// In en, this message translates to:
  /// **'Born'**
  String get born;

  /// Goals scored stat label
  ///
  /// In en, this message translates to:
  /// **'Goal Scored'**
  String get goalScored;

  /// Assists stat label
  ///
  /// In en, this message translates to:
  /// **'Assists'**
  String get assists;

  /// Yellow card stat label
  ///
  /// In en, this message translates to:
  /// **'Yellow Card'**
  String get yellowCard;

  /// Red card stat label
  ///
  /// In en, this message translates to:
  /// **'Red Card'**
  String get redCard;

  /// MVP stat label
  ///
  /// In en, this message translates to:
  /// **'MVP'**
  String get mvp;

  /// Liked state label
  ///
  /// In en, this message translates to:
  /// **'Liked'**
  String get liked;

  /// Like action hint
  ///
  /// In en, this message translates to:
  /// **'Tap to like'**
  String get tapToLike;

  /// Follow action hint
  ///
  /// In en, this message translates to:
  /// **'Tap to follow'**
  String get tapToFollow;

  /// Create post button
  ///
  /// In en, this message translates to:
  /// **'Create Post'**
  String get createPost;

  /// Upload images label
  ///
  /// In en, this message translates to:
  /// **'Upload Images'**
  String get uploadImage;

  /// Upload video label
  ///
  /// In en, this message translates to:
  /// **'Upload Video'**
  String get uploadVideo;

  /// OTP sent success toast
  ///
  /// In en, this message translates to:
  /// **'Verification code sent successfully'**
  String get verificationCodeSent;

  /// Password reset success toast
  ///
  /// In en, this message translates to:
  /// **'Password reset successfully. Please Sign In.'**
  String get passwordResetSuccess;

  /// OTP field validation
  ///
  /// In en, this message translates to:
  /// **'Please enter OTP'**
  String get pleaseEnterOtp;

  /// SocaLoca ID sign-in type label
  ///
  /// In en, this message translates to:
  /// **'SocaLoca ID'**
  String get socaLocaId;

  /// Mobile sign-in type label
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// SocaLoca ID field hint
  ///
  /// In en, this message translates to:
  /// **'Enter SocaLoca ID'**
  String get enterSocaLocaId;

  /// Mobile field hint
  ///
  /// In en, this message translates to:
  /// **'Enter Mobile Number'**
  String get enterMobileNumber;

  /// Send reset link button for club path
  ///
  /// In en, this message translates to:
  /// **'SEND RESET LINK'**
  String get sendResetLink;

  /// My gallery menu item
  ///
  /// In en, this message translates to:
  /// **'My Gallery'**
  String get myGallery;

  /// Football Associations label
  ///
  /// In en, this message translates to:
  /// **'FAs'**
  String get fas;

  /// Confederations section label
  ///
  /// In en, this message translates to:
  /// **'Confederations'**
  String get confederations;

  /// Sponsors section label
  ///
  /// In en, this message translates to:
  /// **'Sponsors'**
  String get sponsors;

  /// Charities and NGOs section label
  ///
  /// In en, this message translates to:
  /// **'Charities & NGOs'**
  String get charitiesAndNgos;

  /// Pick-up match type
  ///
  /// In en, this message translates to:
  /// **'Pick-Up'**
  String get pickup;

  /// One-off match type
  ///
  /// In en, this message translates to:
  /// **'One-off'**
  String get oneOff;

  /// Empty today matches message
  ///
  /// In en, this message translates to:
  /// **'No match for today'**
  String get noMatchForToday;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
