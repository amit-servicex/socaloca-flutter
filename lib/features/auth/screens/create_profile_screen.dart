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

  // All leagues and their team lists — sourced from CreateProfileFragment.java
  static const Map<String, List<String>> _leagueTeams = {
    'Premier League': [
      'Arsenal',
      'Aston Villa',
      'Bournemouth',
      'Brighton & Hove Albion',
      'Burnley',
      'Chelsea',
      'Crystal Palace',
      'Everton',
      'Leicester City',
      'Liverpool',
      'Manchester City',
      'Manchester United',
      'Newcastle United',
      'Norwich City',
      'Sheffield United',
      'Southampton',
      'Tottenham Hotspur',
      'Watford',
      'West Ham United',
      'Wolverhampton Wanderers',
    ],
    'La Liga': [
      'Real Madrid',
      'Barcelona',
      'Atlético Madrid',
      'Athletic Bilbao',
      'Valencia',
      'Real Sociedad',
      'Deportivo La Coruña',
      'Sevilla',
      'Real Betis',
    ],
    'Bundesliga': [
      'FC Augsburg',
      'Bayer Leverkusen',
      'Bayern Munich',
      'Borussia Dortmund',
      'Borussia Mönchengladbach',
      'Eintracht Frankfurt',
      'Fortuna Düsseldorf',
      'SC Freiburg',
      'Hertha BSC',
      'TSG 1899 Hoffenheim',
      'FC Köln',
      'RB Leipzig',
      'FSV Mainz 05',
      'SC Paderborn 07',
      'Schalke 04',
      'Union Berlin',
      'Werder Bremen',
      'VfL Wolfsburg',
    ],
    'Serie A': [
      'Atalanta',
      'Bologna',
      'Brescia',
      'Cagliari',
      'Fiorentina',
      'Genoa',
      'Hellas Verona',
      'Internazionale',
      'Juventus',
      'Lazio',
      'Lecce',
      'Milan',
      'Napoli',
      'Parma',
      'Roma',
      'Sampdoria',
      'Sassuolo',
      'SPAL',
      'Torino',
      'Udinese',
    ],
    'Ligue 1': [
      'Amiens',
      'Angers',
      'Bordeaux',
      'Brest',
      'Dijon',
      'Lille',
      'Lyon',
      'Marseille',
      'Metz',
      'Monaco',
      'Montpellier',
      'Nantes',
      'Nice',
      'Nîmes',
      'Paris Saint-Germain',
      'Reims',
      'Rennes',
      'Saint-Étienne',
      'Strasbourg',
      'Toulouse',
    ],
    'Brasileirão': [
      'Palmeiras',
      'Santos',
      'Corinthians',
      'São Paulo',
      'Flamengo',
      'Cruzeiro',
      'Vasco',
      'Fluminense',
      'Internacional',
      'Botafogo',
      'Grêmio',
      'Bahia',
      'Atlético Mineiro',
      'Guarani',
      'Atlético Paranaense',
      'Coritiba',
      'Sport',
      'Fortaleza',
      'São Caetano',
      'Náutico',
      'Bangu',
      'Bragantino',
      'Vitória',
      'Portuguesa',
    ],
    'Superliga Argentina': [
      'Aldosivi',
      'Argentinos Juniors',
      'Arsenal',
      'Atlético Tucumán',
      'Banfield',
      'Boca Juniors',
      'Central Córdoba (SdE)',
      'Colón',
      'Defensa y Justicia',
      'Estudiantes (LP)',
      'Gimnasia y Esgrima (LP)',
      'Godoy Cruz',
      'Huracán',
      'Independiente',
      'Lanús',
      "Newell's Old Boys",
      'Patronato',
      'River Plate',
      'Rosario Central',
      'San Lorenzo',
      'Talleres (C)',
      'Unión',
      'Vélez Sarsfield',
    ],
    'Dutch Eredivisie': [
      'Ajax',
      'AZ',
      'ADO Den Haag',
      'FC Emmen',
      'Feyenoord',
      'Fortuna Sittard',
      'FC Groningen',
      'SC Heerenveen',
      'Heracles Almelo',
      'PSV',
      'Sparta Rotterdam',
      'Twente',
      'FC Utrecht',
      'Vitesse',
      'VVV-Venlo',
      'RKC Waalwijk',
      'Willem II',
      'PEC Zwolle',
    ],
    'Primeira Liga': [
      'Belenenses SAD',
      'Benfica',
      'Boavista',
      'Braga',
      'Desportivo das Aves',
      'Famalicão',
      'Gil Vicente',
      'Marítimo',
      'Moreirense',
      'Paços de Ferreira',
      'Portimonense',
      'Porto',
      'Rio Ave',
      'Santa Clara',
      'Sporting CP',
      'Tondela',
      'Vitória de Guimarães',
      'Vitória de Setúbal',
    ],
    'Major League Soccer': [
      'Atlanta United FC',
      'Chicago Fire FC',
      'FC Cincinnati',
      'Columbus Crew SC',
      'D.C. United',
      'Inter Miami CF',
      'Montreal Impact',
      'New England Revolution',
      'New York City FC',
      'New York Red Bulls',
      'Orlando City SC',
      'Philadelphia Union',
      'Toronto FC',
      'Colorado Rapids',
      'FC Dallas',
      'Houston Dynamo',
      'LA Galaxy',
      'Los Angeles FC',
      'Minnesota United FC',
      'Nashville SC',
      'Portland Timbers',
      'Real Salt Lake',
      'San Jose Earthquakes',
      'Seattle Sounders FC',
      'Sporting Kansas City',
      'Vancouver Whitecaps FC',
    ],
    'FA Womens Super League': [
      'Arsenal Women',
      'Aston Villa Women',
      'Birmingham City Women',
      'Brighton & Hove Albion Women',
      'Chelsea Women',
      'Everton Women',
      'Leicester City Women',
      'Manchester City Women',
      'Manchester United Women',
      'Reading Women',
      'Tottenham Hotspur Women',
      'West Ham United Women',
    ],
    'France D1 Arkema Women': [
      'Bordeaux Womens',
      'Dijon Womens',
      'FC Fleury 91 Womens',
      'EA Guingamp Womens',
      'Issy FF Womens',
      'Lyon Womens',
      'Montpellier Womens',
      'Paris FC Womens',
      'PSG Womens',
      'Reims Womens',
      'Soyaux Womens',
      'Saint Etienne Womens',
    ],
    'Spanish Primera Iberdrola Women': [
      'Athletic Bilbao Womens',
      'Atletico Madrid Womens',
      'Barcelona Womens',
      'Alaves Womens',
      'Eibar Womens',
      'Granadilla Tenerife Womens',
      'Levante Womens',
      'Madrid CFF Womens',
      'Rayo Vallecano Womens',
      'Real Betis Womens',
      'Real Madrid Womens',
      'Real Sociedad Womens',
      'Sevilla Womens',
      'Sporting Huelva Womens',
      'Valencia Womens',
      'Villarreal Womens',
    ],
    'Italy Serie A Women': [
      'Milan Women',
      'Internazionale Women',
      'Juventus Women',
      'Roma Women',
      'Sampdoria Women',
      'Sassuolo Women',
      'Fiorentina Women',
      'Lazio Women',
      'Empoli Women',
      'Napoli Women',
      'Pomigliano Women',
      'Hellas Verona Women',
    ],
    'Portugal Liga BPI Women': [
      'Albergaria Women',
      'Condeixa Women',
      'Famalicao Women',
      'Gil Vicente Women',
      'Braga Women',
      'Valadares Women',
      'Varzim Women',
      'Vilaverdense Women',
      'Amora Women',
      'Atletico CP Women',
      'Estoril Women',
      'Maritimo Women',
      'Ouriense Women',
      'Benfica Women',
      'Sporting Women',
      'Torreense Women',
    ],
    'Sweden OBOS Damallsvenskan Women': [
      'Rosengard Women',
      'Hacken Women',
      'Eskilstuna Women',
      'Hammarby Women',
      'Kristianstads Women',
      'Linkoping Women',
      'Vittsjo Women',
      'Djurgarden Women',
      'KIF Orebro Women',
      'AIK Women',
      'Pitea Women',
      'Vaxjo Women',
    ],
  };

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
  bool get _showFanLocation => _isFan || _isReferee;
  bool get _showLeaguesTeams => _isFan || _isPlayer || _isCoach || _isManager;

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
        SnackBar(content: Text(AppStrings.pleaseSelectAtLeastOneRole)),
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
                AppStrings.selectPhoto,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.socaBlack,
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                // leading: Icon(Icons.camera_alt, color: AppColors.socaBlack),
                title: Text(
                  AppStrings.takePhotoUpper,
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
                // leading: Icon(Icons.photo_library, color: AppColors.socaBlack),
                title: Text(
                  AppStrings.chooseGalleryUpper,
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
                    AppStrings.removePhoto,
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
          SnackBar(content: Text(AppStrings.errorPickingImage(e))),
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
          SnackBar(content: Text(AppStrings.errorPickingImage(e))),
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
                  AppStrings.selectNationality,
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
            imageFile: _profileImage,
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
        if (_isReferee) {
          context.go(AppRoutes.tournaments);
          return;
        }
        context.go(AppRoutes.home);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppStrings.failedCreateProfile)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppStrings.errorMessage(e))),
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
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            // padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              color: AppColors.socaPageBg,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * .18),

                  // Logo
                  Center(
                    child: SvgPicture.asset(
                      'assets/icons/socaloca_logo.svg',
                      width: 160,
                      // height: 60,
                    ),
                  ),

                  SizedBox(height: height * .06),

                  // Title
                  Text(
                    AppStrings.createProfile,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: AppColors.socaBlack,
                    ),
                  ),

                  SizedBox(height: height * .05),

                  // First Name
                  CreateProfileTextField(
                    controller: _firstNameController,
                    hintText: AppStrings.firstNameRequiredLower,
                    onChanged: (_) => setState(() => _firstNameError = null),
                  ),
                  if (_firstNameError != null)
                    SocaLocaFieldError(errorText: _firstNameError!),

                  SizedBox(height: 15),

                  // Last Name
                  CreateProfileTextField(
                    controller: _lastNameController,
                    hintText: AppStrings.lastNameRequiredLower,
                    onChanged: (_) => setState(() => _lastNameError = null),
                  ),
                  if (_lastNameError != null)
                    SocaLocaFieldError(errorText: _lastNameError!),

                  SizedBox(height: 15),

                  // Profile Name
                  CreateProfileTextField(
                    controller: _profileNameController,
                    hintText: AppStrings.profileNameRequiredLower,
                    onChanged: (value) {
                      setState(() {
                        _profileNameError = null;
                        _profileNameValid = value.trim().length >= 5;
                      });
                    },
                    suffixWidget: _profileNameController.text.trim().length >= 5
                        ? Image.asset("assets/icons/ic_tick_green.png",
                            color: AppColors.socaBlack, width: 28, height: 28)
                        : null,
                  ),
                  Text(
                    AppStrings.minimumFiveCharacters,
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
                        hintText: AppStrings.aboutMe,
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppStrings.max300Characters,
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
                    AppStrings.selectRoleRequired,
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
                        _buildRoleChip(
                            'Player', AppStrings.playerRole, _isPlayer),
                        SizedBox(width: 10),
                        _buildRoleChip('Coach', AppStrings.coach, _isCoach),
                        SizedBox(width: 10),
                        _buildRoleChip(
                            'Manager', AppStrings.manager, _isManager),
                        SizedBox(width: 10),
                        _buildRoleChip('Fan', AppStrings.fan, _isFan),
                        SizedBox(width: 10),
                        _buildRoleChip(
                            'Referee', AppStrings.referee, _isReferee),
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
                            _birthDate ?? AppStrings.dateOfBirthRequired,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: _birthDate == null
                                  ? AppColors.socaBlack
                                  : AppColors.socaBlack,
                            ),
                          ),
                          Image.asset("assets/icons/ic_calendar.png",
                              width: 28, height: 28)
                        ],
                      ),
                    ),
                  ),
                  if (_dobError != null)
                    SocaLocaFieldError(errorText: _dobError!),

                  SizedBox(height: 15),

                  // Country
                  Container(
                    width: double.infinity,
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
                        AppStrings.genderPlain,
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
                              AppStrings.male,
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
                              AppStrings.female,
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
                  if (!_isFan) ...[
                    _buildAvatarSection(),
                  ],
                  SizedBox(height: 30),

                  // Mandatory fields note
                  Text(
                    AppStrings.mandatoryFields,
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
                      height: 65,
                      decoration: BoxDecoration(
                        color: AppColors.socaBlack,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          AppStrings.submit,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: AppColors.socaYellow,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Privacy / Terms text
                  Text(
                    AppStrings.byClickingSubmitPolicy,
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
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.4),
              child: const AppLoader(),
            ),
        ],
      ),
    );
  }

  Widget _buildRoleChip(String value, String label, bool isSelected) {
    return GestureDetector(
      onTap: () => _onRoleToggle(value, !isSelected),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.socaBlack : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.socaBlack),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: isSelected ? AppColors.socaYellow : AppColors.socaBlack,
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerCoachFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nationality (Player only)
        if (_showPlayerFields) ...[
          Text(
            AppStrings.nationalityRequired,
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
                    _nationality.isEmpty ? AppStrings.select : _nationality,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  // Image.asset("assets/icons/ic_arrow_drop_down.png",
                  //     width: 28, height: 28),
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
                Image.asset("assets/icons/ic_location.png",
                    width: 28, height: 28),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _placeName.isEmpty
                        ? AppStrings.selectLocationFromMap
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
            AppStrings.playingPositionPlain,
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
            AppStrings.preferredJerseyNumber,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: AppColors.socaBlack,
            ),
          ),
          SizedBox(height: 10),
          CreateProfileTextField(
            controller: _jerseyNumberController,
            hintText: AppStrings.zeroToNinetyNine,
            keyboardType: TextInputType.number,
            maxLength: 2,
          ),
          SizedBox(height: 15),
        ],

        // Playing Level (Player only)
        if (_showPlayerFields) ...[
          Text(
            AppStrings.playingLevelRequired,
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
                AppStrings.preferredFoot,
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
                      AppStrings.right,
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
                      AppStrings.left,
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
            AppStrings.height,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: AppColors.socaBlack,
            ),
          ),
          SizedBox(height: 10),
          CreateProfileTextField(
            controller: _heightController,
            hintText: AppStrings.valueInCm,
            keyboardType: TextInputType.number,
            maxLength: 3,
          ),
          SizedBox(height: 15),
        ],

        // Jersey Size
        if (_showJerseySize) ...[
          Text(
            AppStrings.shirtJerseySize,
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
                      color:
                          isSelected ? AppColors.socaBlack : Colors.transparent,
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
            AppStrings.shoeSize,
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
                Image.asset("assets/icons/ic_location.png",
                    width: 28, height: 28),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _placeName.isEmpty
                        ? AppStrings.selectLocationFromMap
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.brandsYouLike,
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
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? AppColors.socaBlack : Colors.transparent,
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
      ],
    );
  }

  Widget _buildLeaguesTeamsSection() {
    return Column(
      children: [
        SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.majorLeaguesYouFollow,
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
              items: _leagueTeams.keys.toList(),
              onChanged: (val) {
                if (val == null) return;
                final teams = _leagueTeams[val]!;
                setState(() {
                  _leagueFollow = val;
                  _teamFollow = teams.first;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.teamsYouFollow,
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
              items: _leagueTeams[_leagueFollow] ??
                  _leagueTeams['Premier League']!,
              onChanged: (val) => setState(() => _teamFollow = val!),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAvatarSection() {
    return Column(children: [
      SizedBox(height: 15),
      Center(child: _buildProfileImagePreview()),
      SizedBox(height: 20),
      if (_isAdult) _buildPhotoUploadSection() else _buildAvatarGridSection(),
    ]);
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
              color: AppColors.socaBlack,
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
    return Column(
      children: [
        Text(
          AppStrings.uploadProfilePhoto,
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.socaBlack),
                ),
                child: Row(
                  children: [
                    Text(
                      AppStrings.takePhotoUpper,
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.socaBlack,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    // Icon(Icons.photo_library,
                    //     color: AppColors.socaYellow, size: 18),
                    // SizedBox(width: 5),
                    Text(
                      AppStrings.chooseGalleryUpper,
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
            AppStrings.chooseYourAvatar,
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
