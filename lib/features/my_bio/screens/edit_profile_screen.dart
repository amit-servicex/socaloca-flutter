import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/router/app_routes.dart';
import '../../../shared/widgets/socaloca_text_field.dart';
import '../../auth/providers/auth_provider.dart';
import '../../player_bio/data/models/player_bio_model.dart';
import '../../player_bio/providers/player_bio_provider.dart';
import 'package:go_router/go_router.dart';

/// Edit Profile screen — pre-populates fields from the existing PlayerBioModel
/// and calls editCommonProfile on save.
class EditProfileScreen extends ConsumerStatefulWidget {
  final PlayerBioModel playerBio;

  const EditProfileScreen({super.key, required this.playerBio});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
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

  bool _isPlayer = false;
  bool _isCoach = false;
  bool _isManager = false;
  bool _isFan = false;
  bool _isReferee = false;

  String _gender = 'male';

  DateTime? _selectedDob;
  String? _birthDate;

  String? _selectedAvatar;
  String _existingImageUrl = '';

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

  String _selectedCountry = 'India';
  String _playPosition = 'Defender';
  String _playPositionType = 'Center Back(CB)';
  String _playLevel = 'Amateur';
  String _preferredFoot = 'right';
  String _nationality = '';
  String _nationalityIso = '';
  String _jerseySize = '';
  String _shoeUnit = 'Euro Sizes';
  String _shoeSize = '39';
  String _leagueFollow = 'Premier League';
  String _teamFollow = 'Arsenal';
  final List<String> _selectedBrands = [];

  String _placeName = '';
  double _placeLat = 0.0;
  double _placeLong = 0.0;

  File? _profileImage;
  final ImagePicker _imagePicker = ImagePicker();

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
    _prefillFromBio(widget.playerBio);
  }

  void _prefillFromBio(PlayerBioModel bio) {
    _firstNameController.text = bio.firstName ?? '';
    _lastNameController.text = bio.lastName ?? '';
    _profileNameController.text = bio.profileName ?? '';
    _aboutMeController.text = bio.aboutMe ?? '';
    _jerseyNumberController.text = bio.preferredJersey ?? '';
    _heightController.text =
        bio.height != null && bio.height != 0 ? bio.height.toString() : '';

    _isPlayer = bio.isPlayer ?? false;
    _isCoach = bio.isCoach ?? false;
    _isManager = bio.isAdmin ?? false;
    _isFan = bio.isFan ?? false;

    _gender = bio.gender?.toLowerCase() == 'female' ? 'female' : 'male';

    // DOB: API may return "dd/MM/yyyy" or "yyyy-MM-dd"
    final rawDob = bio.dob ?? '';
    if (rawDob.isNotEmpty) {
      _birthDate = rawDob;
      _selectedDob = _parseDob(rawDob);
    }

    _existingImageUrl = bio.imageUrl ?? '';

    _selectedCountry = bio.country?.isNotEmpty == true ? bio.country! : 'India';
    _nationality = bio.nationality ?? '';
    _nationalityIso = bio.nationalityIso ?? '';

    final pos = bio.playPosition ?? '';
    if (pos.isNotEmpty && _playPositions.contains(pos)) {
      _playPosition = pos;
    }
    final posType = bio.playPositionType ?? '';
    if (posType.isNotEmpty &&
        (_positionTypes[_playPosition]?.contains(posType) == true)) {
      _playPositionType = posType;
    }

    final level = bio.playLevel ?? '';
    if (level.isNotEmpty && _playingLevels.contains(level)) {
      _playLevel = level;
    }

    final foot = bio.preferredFoot ?? '';
    if (foot == 'left' || foot == 'right') _preferredFoot = foot;

    final js = bio.jerseySize ?? '';
    if (_jerseySizes.contains(js)) _jerseySize = js;

    final su = bio.shoeSizeUnit ?? '';
    if (_shoeUnits.contains(su)) _shoeUnit = su;
    final ss = bio.shoeSize ?? '';
    if (ss.isNotEmpty) _shoeSize = ss;
  }

  DateTime? _parseDob(String dob) {
    try {
      // dd/MM/yyyy
      if (dob.contains('/')) {
        final parts = dob.split('/');
        if (parts.length == 3) {
          return DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        }
      }
      // yyyy-MM-dd
      if (dob.contains('-')) {
        final parts = dob.split('-');
        if (parts.length == 3) {
          return DateTime(
            int.parse(parts[0]),
            int.parse(parts[1]),
            int.parse(parts[2]),
          );
        }
      }
    } catch (_) {}
    return null;
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
  bool get _showLeaguesTeams =>
      (_isPlayer || _isCoach || _isManager || _isFan) && !_isReferee;

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
    final initial = _selectedDob ?? DateTime(now.year - 18, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: now,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.socaYellow,
            onPrimary: AppColors.socaBlack,
            surface: Colors.white,
            onSurface: AppColors.socaBlack,
          ),
        ),
        child: child!,
      ),
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

    if (_firstNameController.text.trim().isEmpty) {
      setState(() => _firstNameError = 'Please enter first name');
      isValid = false;
    }
    if (_lastNameController.text.trim().isEmpty) {
      setState(() => _lastNameError = 'Please enter last name');
      isValid = false;
    }
    if (_profileNameController.text.trim().isEmpty) {
      setState(() => _profileNameError = 'Please enter profile name');
      isValid = false;
    } else if (_profileNameController.text.trim().length < 5) {
      setState(() => _profileNameError = 'Minimum 5 characters required');
      isValid = false;
    }
    if (_birthDate == null) {
      setState(() => _dobError = 'Please select date of birth');
      isValid = false;
    }
    if (!_isPlayer && !_isCoach && !_isManager && !_isFan && !_isReferee) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one role')),
      );
      isValid = false;
    }
    return isValid;
  }

  Future<void> _showImageSourceDialog() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.socaPageBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Photo',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.socaBlack,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading:
                    const Icon(Icons.camera_alt, color: AppColors.socaBlack),
                title: const Text('Camera',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.socaBlack)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.photo_library, color: AppColors.socaBlack),
                title: const Text('Gallery',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.socaBlack)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              if (_profileImage != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Remove Photo',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _profileImage = null);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final file = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (file != null) {
        setState(() => _profileImage = File(file.path));
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
      {'name': 'Bangladesh', 'iso': 'BD'},
      {'name': 'Belgium', 'iso': 'BE'},
      {'name': 'Brazil', 'iso': 'BR'},
      {'name': 'Canada', 'iso': 'CA'},
      {'name': 'Chile', 'iso': 'CL'},
      {'name': 'China', 'iso': 'CN'},
      {'name': 'Colombia', 'iso': 'CO'},
      {'name': 'Denmark', 'iso': 'DK'},
      {'name': 'Egypt', 'iso': 'EG'},
      {'name': 'England', 'iso': 'GB'},
      {'name': 'Finland', 'iso': 'FI'},
      {'name': 'France', 'iso': 'FR'},
      {'name': 'Germany', 'iso': 'DE'},
      {'name': 'Greece', 'iso': 'GR'},
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        builder: (_, scrollController) => Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Select Nationality',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.socaBlack,
                ),
              ),
            ),
            const Divider(height: 1),
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
                        ? const Icon(Icons.check, color: AppColors.socaBlack)
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
      ),
    );
  }

  Future<void> _handleSave() async {
    if (!_validateForm()) return;

    setState(() => _isLoading = true);
    try {
      final userId = StorageService.userId ?? widget.playerBio.userId ?? '';
      final imageUrl = _profileImage != null
          ? _profileImage!.path
          : _selectedAvatar != null
              ? _selectedAvatar!
              : _existingImageUrl;

      final result = await ref.read(authRepositoryProvider).editCommonProfile(
            userId: userId,
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            profileName: _profileNameController.text.trim(),
            isPlayer: _isPlayer,
            isCoach: _isCoach,
            isAdmin: _isManager,
            isFan: _isFan,
            dob: _birthDate!,
            country: _selectedCountry,
            gender: _gender,
            aboutMe: _aboutMeController.text.trim(),
            imageUrl: imageUrl,
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
        // Refresh bio data
        ref.read(playerBioProvider(userId).notifier).load();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
        context.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to update profile. Please try again.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildGreyTextField({
    required TextEditingController controller,
    String? hintText,
    bool enabled = true,
    int maxLines = 1,
    int? maxLength,
    ValueChanged<String>? onChanged,
    Widget? suffixWidget,
    bool isBold = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1), // Light grey
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: onChanged,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: AppColors.socaBlack,
          fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          counterText: '',
          suffixIcon: suffixWidget,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userMobile = StorageService.currentUser?['mobile']?.toString() ??
        StorageService.currentUser?['phone']?.toString() ??
        '+918820172930';

    return Scaffold(
        backgroundColor: AppColors.socaPageBg,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: _buildProfileImagePreview()),
                const SizedBox(height: 20),

                _buildGreyTextField(
                  controller: TextEditingController(text: userMobile),
                  enabled: false,
                  isBold: true,
                ),
                const SizedBox(height: 15),

                // First Name
                _buildGreyTextField(
                  controller: _firstNameController,
                  hintText: 'first name *',
                  onChanged: (_) => setState(() => _firstNameError = null),
                ),
                if (_firstNameError != null)
                  SocaLocaFieldError(errorText: _firstNameError!),
                const SizedBox(height: 15),

                // Last Name
                _buildGreyTextField(
                  controller: _lastNameController,
                  hintText: 'last name *',
                  onChanged: (_) => setState(() => _lastNameError = null),
                ),
                if (_lastNameError != null)
                  SocaLocaFieldError(errorText: _lastNameError!),
                const SizedBox(height: 15),

                // Profile Name
                _buildGreyTextField(
                  controller: _profileNameController,
                  hintText: 'profile name *',
                  onChanged: (_) => setState(() => _profileNameError = null),
                  suffixWidget: _profileNameController.text.trim().length >= 5
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                ),
                const Text(
                  'minimum 5 characters',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: AppColors.socaBlack),
                ),
                if (_profileNameError != null)
                  SocaLocaFieldError(errorText: _profileNameError!),
                const SizedBox(height: 15),

                // About Me
                _buildGreyTextField(
                  controller: _aboutMeController,
                  hintText: 'developer',
                  maxLines: 4,
                  maxLength: 300,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: const Text(
                    'max 300 characters',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: AppColors.socaBlack),
                  ),
                ),

                const SizedBox(height: 15),

                // Select Role
                const Text(
                  'Select role *',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: AppColors.socaBlack,
                  ),
                ),
                const SizedBox(height: 7),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildRoleChip('Player', _isPlayer),
                      const SizedBox(width: 10),
                      _buildRoleChip('Coach', _isCoach),
                      const SizedBox(width: 10),
                      _buildRoleChip('Manager', _isManager),
                      const SizedBox(width: 10),
                      _buildRoleChip('Fan', _isFan),
                      const SizedBox(width: 10),
                      _buildRoleChip('Referee', _isReferee),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // DOB
                GestureDetector(
                  onTap: _selectDate,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: AppColors.socaGrey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _birthDate ?? 'date of birth *',
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: AppColors.socaBlack),
                        ),
                        const Icon(Icons.calendar_today,
                            color: AppColors.socaBlack, size: 20),
                      ],
                    ),
                  ),
                ),
                if (_dobError != null)
                  SocaLocaFieldError(errorText: _dobError!),

                const SizedBox(height: 15),

                // Country (display only)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.socaGrey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    _selectedCountry,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Gender
                Row(
                  children: [
                    const Text(
                      'Gender',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaBlack),
                    ),
                    const SizedBox(width: 10),
                    Radio<String>(
                      value: 'male',
                      groupValue: _gender,
                      activeColor: AppColors.socaBlack,
                      onChanged: (val) => setState(() => _gender = val!),
                    ),
                    const Text('Male',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: AppColors.socaBlack)),
                    const SizedBox(width: 7),
                    Radio<String>(
                      value: 'female',
                      groupValue: _gender,
                      activeColor: AppColors.socaBlack,
                      onChanged: (val) => setState(() => _gender = val!),
                    ),
                    const Text('Female',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: AppColors.socaBlack)),
                  ],
                ),

                const SizedBox(height: 10),

                // Player/Coach/Manager specific fields
                if (_showPlayerFields || _showCoachManagerFields)
                  _buildPlayerCoachFields(),

                // Brands
                if (_showBrands) _buildBrandsSection(),

                // Leagues and Teams for Fan
                if (_showLeaguesTeams) _buildLeaguesTeamsSection(),

                // Profile photo section
                _buildPhotoSection(),

                const SizedBox(height: 30),

                const Text(
                  '* mandatory fields',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: AppColors.socaBlack),
                ),

                const SizedBox(height: 12),

                // Save Button
                InkWell(
                  onTap: _isLoading ? null : _handleSave,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.socaBlack,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: AppColors.socaYellow)
                          : const Text(
                              'SAVE CHANGES',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: AppColors.socaYellow,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ));
  }

  Widget _buildRoleChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => _onRoleToggle(label, !isSelected),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_showPlayerFields) ...[
            const Text('Nationality *',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack)),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _showNationalityPicker,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                decoration: BoxDecoration(
                    color: AppColors.socaGrey,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _nationality.isEmpty ? 'Select' : _nationality,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.socaBlack),
                    ),
                    const Icon(Icons.arrow_drop_down,
                        color: AppColors.socaBlack),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],

          // Location
          GestureDetector(
            onTap: _openLocationPicker,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              decoration: BoxDecoration(
                  color: AppColors.socaGrey,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.socaBlack),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _placeName.isEmpty
                          ? 'Select location from map'
                          : _placeName,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaBlack),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          if (_showPlayerFields) ...[
            const Text('Playing Position',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack)),
            const SizedBox(height: 10),
            _buildDropdown(
              value: _playPosition,
              items: _playPositions,
              onChanged: (val) => setState(() {
                _playPosition = val!;
                _playPositionType = _positionTypes[val]!.first;
              }),
            ),
            const SizedBox(height: 10),
            _buildDropdown(
              value: _playPositionType,
              items: _positionTypes[_playPosition]!,
              onChanged: (val) => setState(() => _playPositionType = val!),
            ),
            const SizedBox(height: 15),
          ],

          if (_showJerseyNumber) ...[
            const Text('Preferred Jersey Number',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack)),
            const SizedBox(height: 10),
            SocaLocaTextField(
              controller: _jerseyNumberController,
              hintText: '0 - 99',
              keyboardType: TextInputType.number,
              maxLength: 2,
            ),
            const SizedBox(height: 15),
          ],

          if (_showPlayerFields) ...[
            const Text('Playing Level *',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack)),
            const SizedBox(height: 10),
            _buildDropdown(
              value: _playLevel,
              items: _playingLevels,
              onChanged: (val) => setState(() => _playLevel = val!),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Preferred Foot',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.socaBlack)),
                const SizedBox(width: 10),
                Radio<String>(
                  value: 'right',
                  groupValue: _preferredFoot,
                  activeColor: AppColors.socaBlack,
                  onChanged: (val) => setState(() => _preferredFoot = val!),
                ),
                const Text('Right',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.socaBlack)),
                const SizedBox(width: 7),
                Radio<String>(
                  value: 'left',
                  groupValue: _preferredFoot,
                  activeColor: AppColors.socaBlack,
                  onChanged: (val) => setState(() => _preferredFoot = val!),
                ),
                const Text('Left',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.socaBlack)),
              ],
            ),
            const SizedBox(height: 15),
            const Text('Height',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack)),
            const SizedBox(height: 10),
            SocaLocaTextField(
              controller: _heightController,
              hintText: 'value in cm',
              keyboardType: TextInputType.number,
              maxLength: 3,
            ),
            const SizedBox(height: 15),
          ],

          if (_showJerseySize) ...[
            const Text('Shirt/Jersey Size',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack)),
            const SizedBox(height: 10),
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
                      margin: const EdgeInsets.only(right: 10),
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
            const SizedBox(height: 15),
          ],

          if (_showShoeSize) ...[
            const Text('Shoe Size',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildDropdown(
                    value: _shoeUnit,
                    items: _shoeUnits,
                    onChanged: (val) => setState(() {
                      _shoeUnit = val!;
                      _shoeSize = _shoeSizes[val]!.first;
                    }),
                  ),
                ),
                const SizedBox(width: 10),
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

  Widget _buildBrandsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Brands you like',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.socaBlack),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _brands.map((brand) {
                  final isSelected = _selectedBrands.contains(brand);
                  return GestureDetector(
                    onTap: () => setState(() {
                      isSelected
                          ? _selectedBrands.remove(brand)
                          : _selectedBrands.add(brand);
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
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
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Major leagues you follow',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.socaBlack)),
              const SizedBox(height: 10),
              _buildDropdown(
                value: _leagueFollow,
                items: const [
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
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Teams you follow',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.socaBlack)),
              const SizedBox(height: 10),
              _buildDropdown(
                value: _teamFollow,
                items: const [
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

  Widget _buildPhotoSection() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Upload your profile photo',
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 16, color: AppColors.socaBlack),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _pickImage(ImageSource.camera),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.socaBlack, width: 1.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text('TAKE A PHOTO',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: AppColors.socaBlack)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InkWell(
                onTap: () => _pickImage(ImageSource.gallery),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.socaBlack,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text('CHOOSE FROM GALLERY',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: AppColors.socaYellow)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileImagePreview() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.socaBlack, width: 3),
      ),
      child: ClipOval(
        child: _profileImage != null
            ? Image.file(_profileImage!, fit: BoxFit.cover)
            : _selectedAvatar != null
                ? Image.asset('assets/images/$_selectedAvatar',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const CircleAvatar(
                          backgroundColor: AppColors.socaGrey,
                          child: Icon(Icons.person,
                              size: 60, color: AppColors.socaBlack),
                        ))
                : _existingImageUrl.isNotEmpty
                    ? Image.network(
                        _existingImageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const CircleAvatar(
                          backgroundColor: AppColors.socaGrey,
                          child: Icon(Icons.person,
                              size: 60, color: AppColors.socaBlack),
                        ),
                      )
                    : const CircleAvatar(
                        backgroundColor: AppColors.socaGrey,
                        child: Icon(Icons.person,
                            size: 60, color: AppColors.socaBlack),
                      ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: AppColors.socaGrey, borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          isExpanded: true,
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppColors.socaBlack)),
                  ))
              .toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.socaBlack),
        ),
      ),
    );
  }
}
