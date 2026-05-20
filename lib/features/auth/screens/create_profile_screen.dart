import 'dart:io';
import 'package:socaloca/core/constants/app_strings.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/widgets/socaloca_text_field.dart';
import '../providers/auth_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';
import '../../../shared/widgets/searchable_dropdown.dart';

/// CreateProfileFragment equivalent - Complete profile creation form
/// Shows after successful signup for verified users without profile
class CreateProfileScreen extends ConsumerStatefulWidget {
  CreateProfileScreen({super.key});

  @override
  ConsumerState<CreateProfileScreen> createState() =>
      _CreateProfileScreenState();
}

class _CreateProfileScreenState extends ConsumerState<CreateProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _profileNameController = TextEditingController();
  final _aboutMeController = TextEditingController();
  final _jerseyNumberController = TextEditingController();
  final _heightController = TextEditingController();

  bool _isLoading = false;
  String? _firstNameError;
  String? _lastNameError;
  String? _profileNameError;
  String? _dobError;

  // Role selection
  bool _isPlayer = false;
  bool _isCoach = false;
  bool _isManager = false;
  bool _isFan = false;
  bool _isReferee = false;

  // Gender
  String _gender = 'male';

  // DOB
  DateTime? _selectedDob;
  String? _birthDate;

  // Avatar
  String? _selectedAvatar;
  final List<String> _avatars = [
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

  // Country
  String _selectedCountry = 'India';

  // Player specific fields
  String _playPosition = 'Defender';
  String _playPositionType = 'Center Back(CB)';
  String _playLevel = 'Amateur';
  String _preferredFoot = 'right';
  String _nationality = '';
  String _nationalityIso = '';

  // Jersey size
  String _jerseySize = '';

  // Shoe size
  String _shoeUnit = 'Euro Sizes';
  String _shoeSize = '39';

  // Fan specific
  String _leagueFollow = 'Premier League';
  String _teamFollow = 'Arsenal';
  final List<String> _selectedBrands = [];

  // Location
  String _placeName = '';
  double _placeLat = 0.0;
  double _placeLong = 0.0;

  // Profile image
  File? _profileImage;
  final ImagePicker _imagePicker = ImagePicker();

  // Profile name validation
  bool _profileNameValid = false;

  bool get _isAdult {
    final ag = ref.read(signupTempProvider).ageGroup;
    return ag == 'adult' || ag.isEmpty;
  }

  // Dropdown options
  final List<String> _playPositions = [
    'Defender',
    'Midfielder',
    'Forward',
    'Goalkeeper'
  ];
  final Map<String, List<String>> _positionTypes = {
    'Defender': [
      'Center Back(CB)',
      'Left Back(LB)',
      'Right Back(RB)',
      'Sweeper(SW)'
    ],
    'Midfielder': [
      'Central Midfielder(CM)',
      'Defensive Midfielder(DM)',
      'Attacking Midfielder(AM)',
      'Left Midfielder(LM)',
      'Right Midfielder(RM)'
    ],
    'Forward': [
      'Striker(ST)',
      'Center Forward(CF)',
      'Left Winger(LW)',
      'Right Winger(RW)'
    ],
    'Goalkeeper': ['Goalkeeper(GK)']
  };
  final List<String> _playingLevels = [
    'Amateur',
    'Semi-Professional',
    'Professional',
    'Youth Academy',
    'College/University'
  ];
  final List<String> _shoeUnits = ['Euro Sizes', 'UK Sizes', 'US Sizes'];
  final Map<String, List<String>> _shoeSizes = {
    'Euro Sizes': List.generate(20, (i) => '${35 + i}'),
    'UK Sizes': List.generate(15, (i) => '${3 + i}'),
    'US Sizes': List.generate(15, (i) => '${4 + i}'),
  };
  final List<String> _jerseySizes = ['S', 'M', 'L', 'XL', 'XXL'];
  final List<String> _brands = [
    'Lotto',
    'Kappa',
    'Adidas',
    'Nike',
    'Puma',
    'Umbro',
    'Diadora',
    'Under Armor'
  ];

  @override
  void initState() {
    super.initState();
    _autoDetectCountry();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _profileNameController.dispose();
    _aboutMeController.dispose();
    _jerseyNumberController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _autoDetectCountry() {
    try {
      // Timezone offset is more reliable than locale for detecting physical
      // location — locale reflects the device's *language* setting, not where
      // the user actually is. IST (UTC+5:30) is unique, so we can map it
      // directly; fall back to locale only for ambiguous offsets.
      final tzOffset = DateTime.now().timeZoneOffset;
      final String countryCode;
      if (tzOffset == Duration(hours: 5, minutes: 30)) {
        countryCode = 'IN'; // IST — India
      } else if (tzOffset == Duration(hours: 0)) {
        countryCode = 'GB';
      } else if (tzOffset == Duration(hours: -5)) {
        countryCode = 'US';
      } else if (tzOffset == Duration(hours: 1)) {
        countryCode = 'DE';
      } else if (tzOffset == Duration(hours: 2)) {
        countryCode = 'EG';
      } else if (tzOffset == Duration(hours: 5)) {
        countryCode = 'PK';
      } else if (tzOffset == Duration(hours: 8)) {
        countryCode = 'CN';
      } else if (tzOffset == Duration(hours: 9)) {
        countryCode = 'JP';
      } else if (tzOffset == Duration(hours: 10)) {
        countryCode = 'AU';
      } else if (tzOffset == Duration(hours: -3)) {
        countryCode = 'BR';
      } else if (tzOffset == Duration(hours: -6)) {
        countryCode = 'MX';
      } else {
        // Ambiguous offset — fall back to locale country code
        final locale = WidgetsBinding.instance.platformDispatcher.locale;
        countryCode = locale.countryCode?.toUpperCase() ?? 'IN';
      }
      final countryName = _getCountryNameForCode(countryCode);
      setState(() {
        _selectedCountry = countryName;
        _nationality = countryName;
        _nationalityIso = countryCode;
      });
    } catch (e) {
      setState(() {
        _selectedCountry = 'India';
        _nationality = 'India';
        _nationalityIso = 'IN';
      });
    }
  }

  String _getCountryNameForCode(String countryCode) {
    final map = {
      'US': 'USA',
      'GB': 'England',
      'IN': 'India',
      'AU': 'Australia',
      'DE': 'Germany',
      'FR': 'France',
      'IT': 'Italy',
      'ES': 'Spain',
      'BR': 'Brazil',
      'MX': 'Mexico',
      'AR': 'Argentina',
    };
    return map[countryCode] ?? 'India';
  }

  // Role-based visibility logic from Android
  bool get _showPlayerFields => _isPlayer && !_isFan && !_isReferee;
  bool get _showCoachManagerFields =>
      (_isCoach || _isManager) && !_isFan && !_isReferee;
  bool get _showJerseyNumber =>
      (_isPlayer || _isCoach || _isManager) && !_isReferee;
  bool get _showJerseySize =>
      (_isPlayer || _isCoach || _isManager) && !_isReferee;
  bool get _showShoeSize =>
      (_isPlayer || _isCoach || _isManager) && !_isReferee;
  bool get _showBrands =>
      (_isPlayer || _isCoach || _isManager || _isFan) && !_isReferee;
  bool get _showFanLocation => _isFan;
  bool get _showLeaguesTeams => _isFan;

  void _onRoleToggle(String role, bool value) {
    setState(() {
      switch (role) {
        case 'Player':
          _isPlayer = value;
          if (value) {
            _isFan = false;
            _isReferee = false;
          }
          break;
        case 'Coach':
          _isCoach = value;
          if (value) {
            _isFan = false;
            _isReferee = false;
          }
          break;
        case 'Manager':
          _isManager = value;
          if (value) {
            _isFan = false;
            _isReferee = false;
          }
          break;
        case 'Fan':
          _isFan = value;
          if (value) {
            _isPlayer = false;
            _isCoach = false;
            _isManager = false;
            _isReferee = false;
          }
          break;
        case 'Referee':
          _isReferee = value;
          if (value) {
            _isPlayer = false;
            _isCoach = false;
            _isManager = false;
            _isFan = false;
          }
          break;
      }
    });
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final initialDate = DateTime(now.year - 18, now.month, now.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.socaYellow,
              onPrimary: AppColors.socaBlack,
              surface: Colors.white,
              onSurface: AppColors.socaBlack,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDob = picked;
        _birthDate =
            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
        _dobError = null;
      });
    }
  }

  bool _validateForm() {
    bool isValid = true;

    setState(() {
      _firstNameError = null;
      _lastNameError = null;
      _profileNameError = null;
      _dobError = null;
    });

    log('=== VALIDATE FORM ===');
    log('firstName: "${_firstNameController.text.trim()}"');
    log('lastName:  "${_lastNameController.text.trim()}"');
    log('profileName: "${_profileNameController.text.trim()}" (len=${_profileNameController.text.trim().length})');
    log('birthDate: $_birthDate');
    log('roles — player=$_isPlayer coach=$_isCoach manager=$_isManager fan=$_isFan referee=$_isReferee');

    if (_firstNameController.text.trim().isEmpty) {
      log('FAIL: firstName is empty');
      setState(() => _firstNameError = 'Please enter first name');
      isValid = false;
    }

    if (_lastNameController.text.trim().isEmpty) {
      log('FAIL: lastName is empty');
      setState(() => _lastNameError = 'Please enter last name');
      isValid = false;
    }

    if (_profileNameController.text.trim().isEmpty) {
      log('FAIL: profileName is empty');
      setState(() => _profileNameError = 'Please enter profile name');
      isValid = false;
    } else if (_profileNameController.text.trim().length < 5) {
      log('FAIL: profileName too short (${_profileNameController.text.trim().length} chars, need 5)');
      setState(() => _profileNameError = 'Minimum 5 characters required');
      isValid = false;
    }

    if (_birthDate == null) {
      log('FAIL: birthDate not selected');
      setState(() => _dobError = 'Please select date of birth');
      isValid = false;
    }

    if (!_isPlayer && !_isCoach && !_isManager && !_isFan && !_isReferee) {
      log('FAIL: no role selected');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select at least one role'.tr)),
      );
      isValid = false;
    }

    log('=== RESULT: isValid=$isValid ===');
    return isValid;
  }

  // Image picker methods
  Future<void> _showImageSourceDialog() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.socaPageBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Photo'.tr,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.socaBlack,
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.camera_alt, color: AppColors.socaBlack),
                title: Text(
                  'Camera'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: AppColors.socaBlack,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: AppColors.socaBlack),
                title: Text(
                  'Gallery'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: AppColors.socaBlack,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
              if (_profileImage != null || _selectedAvatar != null)
                ListTile(
                  leading: Icon(Icons.delete, color: Colors.red),
                  title: Text(
                    'Remove Photo'.tr,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _profileImage = null;
                      _selectedAvatar = null;
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _profileImage = File(image.path);
          _selectedAvatar = null; // Clear avatar selection
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _profileImage = File(image.path);
          _selectedAvatar = null; // Clear avatar selection
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  Future<void> _openLocationPicker() async {
    final result =
        await context.push<Map<String, dynamic>>(AppRoutes.locationPicker);
    if (result != null && mounted) {
      setState(() {
        _placeName = result['placeName'] as String? ?? '';
        _placeLat = (result['placeLat'] as num?)?.toDouble() ?? 0.0;
        _placeLong = (result['placeLong'] as num?)?.toDouble() ?? 0.0;
      });
    }
  }

  Future<void> _showNationalityPicker() async {
    final countries = <Map<String, String>>[
      {'name': 'Afghanistan', 'iso': 'AF'},
      {'name': 'Argentina', 'iso': 'AR'},
      {'name': 'Australia', 'iso': 'AU'},
      {'name': 'Austria', 'iso': 'AT'},
      {'name': 'Bangladesh', 'iso': 'BD'},
      {'name': 'Belgium', 'iso': 'BE'},
      {'name': 'Brazil', 'iso': 'BR'},
      {'name': 'Canada', 'iso': 'CA'},
      {'name': 'Chile', 'iso': 'CL'},
      {'name': 'China', 'iso': 'CN'},
      {'name': 'Colombia', 'iso': 'CO'},
      {'name': 'Czech Republic', 'iso': 'CZ'},
      {'name': 'Denmark', 'iso': 'DK'},
      {'name': 'Egypt', 'iso': 'EG'},
      {'name': 'England', 'iso': 'GB'},
      {'name': 'Finland', 'iso': 'FI'},
      {'name': 'France', 'iso': 'FR'},
      {'name': 'Germany', 'iso': 'DE'},
      {'name': 'Greece', 'iso': 'GR'},
      {'name': 'Hungary', 'iso': 'HU'},
      {'name': 'India', 'iso': 'IN'},
      {'name': 'Indonesia', 'iso': 'ID'},
      {'name': 'Ireland', 'iso': 'IE'},
      {'name': 'Italy', 'iso': 'IT'},
      {'name': 'Japan', 'iso': 'JP'},
      {'name': 'Kenya', 'iso': 'KE'},
      {'name': 'Korea Republic', 'iso': 'KR'},
      {'name': 'Malaysia', 'iso': 'MY'},
      {'name': 'Mexico', 'iso': 'MX'},
      {'name': 'Netherlands', 'iso': 'NL'},
      {'name': 'New Zealand', 'iso': 'NZ'},
      {'name': 'Nigeria', 'iso': 'NG'},
      {'name': 'Norway', 'iso': 'NO'},
      {'name': 'Pakistan', 'iso': 'PK'},
      {'name': 'Peru', 'iso': 'PE'},
      {'name': 'Philippines', 'iso': 'PH'},
      {'name': 'Poland', 'iso': 'PL'},
      {'name': 'Portugal', 'iso': 'PT'},
      {'name': 'Russia', 'iso': 'RU'},
      {'name': 'Saudi Arabia', 'iso': 'SA'},
      {'name': 'Singapore', 'iso': 'SG'},
      {'name': 'South Africa', 'iso': 'ZA'},
      {'name': 'Spain', 'iso': 'ES'},
      {'name': 'Sweden', 'iso': 'SE'},
      {'name': 'Switzerland', 'iso': 'CH'},
      {'name': 'Thailand', 'iso': 'TH'},
      {'name': 'Türkiye', 'iso': 'TR'},
      {'name': 'Ukraine', 'iso': 'UA'},
      {'name': 'United Arab Emirates', 'iso': 'AE'},
      {'name': 'USA', 'iso': 'US'},
      {'name': 'Vietnam', 'iso': 'VN'},
    ];

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (_, scrollController) => Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Select Nationality'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),
              Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: countries.length,
                  itemBuilder: (_, i) {
                    final c = countries[i];
                    final isSelected = _nationalityIso == c['iso'];
                    return ListTile(
                      title: Text(
                        c['name']!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: AppColors.socaBlack,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w400,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(Icons.check, color: AppColors.socaBlack)
                          : null,
                      onTap: () {
                        setState(() {
                          _nationality = c['name']!;
                          _nationalityIso = c['iso']!;
                        });
                        Navigator.of(ctx).pop();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleSubmit() async {
    if (!_validateForm()) {
      log("the validatio failed ");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Get current user from auth state
      final currentUser = ref.read(currentUserProvider);
      if (currentUser == null) {
        throw Exception('User not found');
      }

      final result = await ref.read(authRepositoryProvider).createUserProfile(
            userId: currentUser.id,
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            profileName: _profileNameController.text.trim(),
            isPlayer: _isPlayer,
            isCoach: _isCoach,
            isAdmin: _isManager,
            isFan: _isFan,
            isReferee: _isReferee,
            dob: _birthDate!,
            country: _selectedCountry,
            gender: _gender,
            aboutMe: _aboutMeController.text.trim(),
            imageUrl: _selectedAvatar ?? '',
            playPosition: _showPlayerFields ? _playPosition : '',
            playPositionType: _showPlayerFields ? _playPositionType : '',
            playLevel: _showPlayerFields ? _playLevel : '',
            preferredFoot: _showPlayerFields ? _preferredFoot : '',
            preferredJersey:
                _showJerseyNumber ? _jerseyNumberController.text.trim() : '',
            height:
                _showPlayerFields && _heightController.text.trim().isNotEmpty
                    ? int.tryParse(_heightController.text.trim()) ?? 0
                    : 0,
            jerseySize: _showJerseySize ? _jerseySize : '',
            shoeSize: _showShoeSize ? _shoeSize : '',
            shoeSizeUnit: _showShoeSize ? _shoeUnit : '',
            nationality: _showPlayerFields ? _nationality : '',
            nationalityIso: _showPlayerFields ? _nationalityIso : '',
            leagueFollow: _showLeaguesTeams ? _leagueFollow : '',
            teamFollow: _showLeaguesTeams ? _teamFollow : '',
            brands: _showBrands ? _selectedBrands : [],
            userLoc: _placeName,
            userLat: _placeLat,
            userLng: _placeLong,
          );

      if (!mounted) return;

      if (result) {
        context.go(AppRoutes.home);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to create profile. Please try again.'.tr)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),

            // Logo
            Center(
              child: SvgPicture.asset(
                'assets/icons/socaloca_logo.svg',
                width: 160,
                height: 60,
              ),
            ),

            SizedBox(height: 20),

            // Title
            Text(
              'Create Profile'.tr,
              style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: AppColors.socaBlack,
              ),
            ),

            SizedBox(height: 20),

            // First Name
            SocaLocaTextField(
              controller: _firstNameController,
              hintText: 'first name *'.tr,
              onChanged: (_) => setState(() => _firstNameError = null),
            ),
            if (_firstNameError != null)
              SocaLocaFieldError(errorText: _firstNameError!),

            SizedBox(height: 15),

            // Last Name
            SocaLocaTextField(
              controller: _lastNameController,
              hintText: 'last name *'.tr,
              onChanged: (_) => setState(() => _lastNameError = null),
            ),
            if (_lastNameError != null)
              SocaLocaFieldError(errorText: _lastNameError!),

            SizedBox(height: 15),

            // Profile Name
            SocaLocaTextField(
              controller: _profileNameController,
              hintText: 'profile name *'.tr,
              onChanged: (value) {
                setState(() {
                  _profileNameError = null;
                  // Show check icon if 5+ characters
                  _profileNameValid = value.trim().length >= 5;
                });
              },
              suffixWidget: _profileNameController.text.trim().length >= 5
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : null,
            ),
            Text(
              'minimum 5 characters'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: AppColors.socaBlack,
              ),
            ),
            if (_profileNameError != null)
              SocaLocaFieldError(errorText: _profileNameError!),

            SizedBox(height: 15),

            // About Me
            Container(
              decoration: BoxDecoration(
                color: AppColors.socaGrey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: _aboutMeController,
                maxLines: 3,
                maxLength: 300,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: AppColors.socaBlack,
                ),
                decoration: InputDecoration(
                  hintText: 'About Me'.tr,
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'max 300 characters'.tr,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: AppColors.socaBlack,
                ),
              ),
            ),

            SizedBox(height: 15),

            // Select Role
            Text(
              'Select role *'.tr,
              style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: AppColors.socaBlack,
              ),
            ),

            SizedBox(height: 7),

            // Role chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildRoleChip('Player', _isPlayer),
                  SizedBox(width: 10),
                  _buildRoleChip('Coach', _isCoach),
                  SizedBox(width: 10),
                  _buildRoleChip('Manager', _isManager),
                  SizedBox(width: 10),
                  _buildRoleChip('Fan', _isFan),
                  SizedBox(width: 10),
                  _buildRoleChip('Referee', _isReferee),
                ],
              ),
            ),

            SizedBox(height: 15),

            // DOB
            GestureDetector(
              onTap: _selectDate,
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColors.socaGrey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _birthDate ?? 'date of birth *',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: _birthDate == null
                            ? AppColors.socaBlack
                            : AppColors.socaBlack,
                      ),
                    ),
                    Icon(Icons.calendar_today,
                        color: AppColors.socaBlack, size: 20),
                  ],
                ),
              ),
            ),
            if (_dobError != null) SocaLocaFieldError(errorText: _dobError!),

            SizedBox(height: 15),

            // Country
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.socaGrey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                _selectedCountry,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.socaBlack,
                ),
              ),
            ),

            SizedBox(height: 10),

            // Gender
            Row(
              children: [
                Text(
                  'Gender'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
                SizedBox(width: 7),
                RadioGroup<String>(
                  groupValue: _gender,
                  onChanged: (val) => setState(() => _gender = val!),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: 'male',
                        activeColor: AppColors.socaBlack,
                      ),
                      Text(
                        'Male'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                      ),
                      SizedBox(width: 7),
                      Radio<String>(
                        value: 'female',
                        activeColor: AppColors.socaBlack,
                      ),
                      Text(
                        'Female'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            // Player/Coach/Manager specific fields
            if (_showPlayerFields || _showCoachManagerFields)
              _buildPlayerCoachFields(),

            // Fan specific fields
            if (_showFanLocation) _buildFanLocationField(),

            // Brands section
            if (_showBrands) _buildBrandsSection(),

            // Leagues and Teams for Fan
            if (_showLeaguesTeams) _buildLeaguesTeamsSection(),

            // Avatar section
            _buildAvatarSection(),

            SizedBox(height: 30),

            // Mandatory fields note
            Text(
              '* mandatory fields'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: AppColors.socaBlack,
              ),
            ),

            SizedBox(height: 12),

            // Submit Button
            InkWell(
              onTap: _isLoading ? null : _handleSubmit,
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.socaBlack,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: AppLoader(),
              ),
            ),

            SizedBox(height: 16),

            // Privacy / Terms text
            Text(
              'By clicking Submit, you agree to our Terms & Conditions and Privacy Policy.'
                  .tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: AppColors.socaBlack,
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => _onRoleToggle(label, !isSelected),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.socaBlack : Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.socaBlack),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: isSelected ? AppColors.socaYellow : AppColors.socaBlack,
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerCoachFields() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nationality (Player only)
          if (_showPlayerFields) ...[
            Text(
              'Nationality *'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _showNationalityPicker,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.socaGrey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _nationality.isEmpty ? 'Select' : _nationality,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, color: AppColors.socaBlack),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],

          // Location (Player/Coach/Manager)
          GestureDetector(
            onTap: _openLocationPicker,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.socaGrey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.socaBlack),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _placeName.isEmpty
                          ? 'Select location from map'
                          : _placeName,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 15),

          // Playing Position (Player only)
          if (_showPlayerFields) ...[
            Text(
              'Playing Position'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
            ),
            SizedBox(height: 10),
            _buildDropdown(
              value: _playPosition,
              items: _playPositions,
              onChanged: (val) {
                setState(() {
                  _playPosition = val!;
                  _playPositionType = _positionTypes[val]!.first;
                });
              },
            ),
            SizedBox(height: 10),
            _buildDropdown(
              value: _playPositionType,
              items: _positionTypes[_playPosition]!,
              onChanged: (val) => setState(() => _playPositionType = val!),
            ),
            SizedBox(height: 15),
          ],

          // Jersey Number
          if (_showJerseyNumber) ...[
            Text(
              'Preferred Jersey Number'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
            ),
            SizedBox(height: 10),
            SocaLocaTextField(
              controller: _jerseyNumberController,
              hintText: '0 - 99'.tr,
              keyboardType: TextInputType.number,
              maxLength: 2,
            ),
            SizedBox(height: 15),
          ],

          // Playing Level (Player only)
          if (_showPlayerFields) ...[
            Text(
              'Playing Level *'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
            ),
            SizedBox(height: 10),
            _buildDropdown(
              value: _playLevel,
              items: _playingLevels,
              onChanged: (val) => setState(() => _playLevel = val!),
            ),
            SizedBox(height: 10),

            // Preferred Foot
            Row(
              children: [
                Text(
                  'Preferred Foot'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
                SizedBox(width: 7),
                RadioGroup<String>(
                  groupValue: _preferredFoot,
                  onChanged: (val) => setState(() => _preferredFoot = val!),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: 'right',
                        activeColor: AppColors.socaBlack,
                      ),
                      Text(
                        'Right'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                      ),
                      SizedBox(width: 7),
                      Radio<String>(
                        value: 'left',
                        activeColor: AppColors.socaBlack,
                      ),
                      Text(
                        'Left'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            // Height
            Text(
              'Height'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
            ),
            SizedBox(height: 10),
            SocaLocaTextField(
              controller: _heightController,
              hintText: 'value in cm'.tr,
              keyboardType: TextInputType.number,
              maxLength: 3,
            ),
            SizedBox(height: 15),
          ],

          // Jersey Size
          if (_showJerseySize) ...[
            Text(
              'Shirt/Jersey Size'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _jerseySizes.map((size) {
                  final isSelected = _jerseySize == size;
                  return GestureDetector(
                    onTap: () => setState(() => _jerseySize = size),
                    child: Container(
                      width: 60,
                      height: 60,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.socaBlack : Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.socaBlack),
                      ),
                      child: Center(
                        child: Text(
                          size,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: isSelected
                                ? AppColors.socaYellow
                                : AppColors.socaBlack,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 15),
          ],

          // Shoe Size
          if (_showShoeSize) ...[
            Text(
              'Shoe Size'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildDropdown(
                    value: _shoeUnit,
                    items: _shoeUnits,
                    onChanged: (val) {
                      setState(() {
                        _shoeUnit = val!;
                        _shoeSize = _shoeSizes[val]!.first;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _buildDropdown(
                    value: _shoeSize,
                    items: _shoeSizes[_shoeUnit]!,
                    onChanged: (val) => setState(() => _shoeSize = val!),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFanLocationField() {
    return Column(
      children: [
        SizedBox(height: 15),
        GestureDetector(
          onTap: _openLocationPicker,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.socaGrey,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: AppColors.socaBlack),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _placeName.isEmpty
                        ? 'Select location from map'
                        : _placeName,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBrandsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Brands you like'.tr,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.socaBlack,
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _brands.map((brand) {
                  final isSelected = _selectedBrands.contains(brand);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedBrands.remove(brand);
                        } else {
                          _selectedBrands.add(brand);
                        }
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.socaBlack : Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.socaBlack),
                      ),
                      child: Text(
                        brand,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: isSelected
                              ? AppColors.socaYellow
                              : AppColors.socaBlack,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLeaguesTeamsSection() {
    return Column(
      children: [
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Major leagues you follow'.tr,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.socaBlack,
                ),
              ),
              SizedBox(height: 10),
              _buildDropdown(
                value: _leagueFollow,
                items: [
                  'Premier League',
                  'La Liga',
                  'Serie A',
                  'Bundesliga',
                  'Ligue 1'
                ],
                onChanged: (val) => setState(() => _leagueFollow = val!),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Teams you follow'.tr,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.socaBlack,
                ),
              ),
              SizedBox(height: 10),
              _buildDropdown(
                value: _teamFollow,
                items: [
                  'Arsenal',
                  'Chelsea',
                  'Liverpool',
                  'Manchester United',
                  'Manchester City'
                ],
                onChanged: (val) => setState(() => _teamFollow = val!),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarSection() {
    return Column(
      children: [
        SizedBox(height: 15),
        Center(child: _buildProfileImagePreview()),
        SizedBox(height: 20),
        if (_isAdult) _buildPhotoUploadSection() else _buildAvatarGridSection(),
      ],
    );
  }

  Widget _buildProfileImagePreview() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.socaYellow,
              width: (_profileImage != null || _selectedAvatar != null) ? 3 : 0,
            ),
          ),
          child: ClipOval(
            child: _profileImage != null
                ? Image.file(_profileImage!, fit: BoxFit.cover)
                : _selectedAvatar != null
                    ? Image.asset(
                        'assets/images/$_selectedAvatar',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => CircleAvatar(
                          backgroundColor:
                              AppColors.socaYellow.withValues(alpha: 0.2),
                          child: Text(
                            _selectedAvatar![0].toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 64,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor:
                            AppColors.socaYellow.withValues(alpha: 0.15),
                        child: Icon(Icons.person,
                            size: 80, color: AppColors.socaBlack),
                      ),
          ),
        ),
        if (_profileImage != null || _selectedAvatar != null)
          Positioned(
            bottom: 4,
            right: 4,
            child: GestureDetector(
              onTap: _showImageSourceDialog,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.socaBlack,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.edit, color: AppColors.socaYellow, size: 18),
              ),
            ),
          ),
      ],
    );
  }

  // Adult mode: camera + gallery upload only
  Widget _buildPhotoUploadSection() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Text(
            'Upload your profile photo'.tr,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: AppColors.socaBlack,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: _pickImageFromCamera,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.socaBlack),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt,
                          color: AppColors.socaBlack, size: 18),
                      SizedBox(width: 5),
                      Text(
                        'CAMERA'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: _pickImageFromGallery,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.socaBlack,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.photo_library,
                          color: AppColors.socaYellow, size: 18),
                      SizedBox(width: 5),
                      Text(
                        'GALLERY'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.socaYellow,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Youth/Child mode: avatar grid only, no photo upload
  Widget _buildAvatarGridSection() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Text(
            'Choose your avatar'.tr,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.socaBlack,
            ),
          ),
          SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _avatars.length,
            itemBuilder: (context, index) {
              final avatar = _avatars[index];
              final isSelected =
                  _selectedAvatar == avatar && _profileImage == null;
              return GestureDetector(
                onTap: () => setState(() {
                  _selectedAvatar = avatar;
                  _profileImage = null;
                }),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.socaYellow
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/$avatar',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => CircleAvatar(
                        backgroundColor:
                            AppColors.socaYellow.withValues(alpha: 0.2),
                        child: Text(
                          avatar[0].toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return SearchableDropdownButton(
      hint: value,
      value: value,
      items: items,
      onChanged: onChanged,
      fontSize: 14,
    );
  }
}
