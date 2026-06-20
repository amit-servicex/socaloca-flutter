import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/core/router/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/services/location_service.dart';
import '../../../shared/widgets/searchable_dropdown.dart';
import '../../club/data/confed_data.dart';
import '../../club/data/repositories/club_repository.dart';

/// Mirrors Android RegisterClubFragment.
/// New club organisation sign-up form.
/// POST clubRegister → on success shows confirmation dialog.
class RegisterClubScreen extends ConsumerStatefulWidget {
  const RegisterClubScreen({super.key});

  @override
  ConsumerState<RegisterClubScreen> createState() => _RegisterClubScreenState();
}

class _RegisterClubScreenState extends ConsumerState<RegisterClubScreen> {
  final _clubNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _contactNameCtrl = TextEditingController();
  final _contactNumberCtrl = TextEditingController();

  String _country = '';
  String _confedName = '';
  String _leagueName = '';
  List<String> _leagues = [];

  String _contactCode = '+1';
  String _contactIso = 'US';

  bool _isLoading = false;

  // Errors
  String? _clubNameError;
  String? _emailError;
  String? _countryError;
  String? _confedError;
  String? _leagueError;
  String? _contactNameError;
  String? _contactNumberError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _detectCountry());
  }

  Future<void> _detectCountry() async {
    final country = await LocationService.detectCountry(context);
    if (!mounted || country == null) return;
    setState(() {
      _contactCode = country.phoneCode;
      _contactIso = country.iso;
    });
  }

  @override
  void dispose() {
    _clubNameCtrl.dispose();
    _emailCtrl.dispose();
    _contactNameCtrl.dispose();
    _contactNumberCtrl.dispose();
    super.dispose();
  }

  void _clearErrors() {
    setState(() {
      _clubNameError = null;
      _emailError = null;
      _countryError = null;
      _confedError = null;
      _leagueError = null;
      _contactNameError = null;
      _contactNumberError = null;
    });
  }

  void _onCountryChanged(String country) {
    final info = ConfedData.getByCountry(country);
    setState(() {
      _country = country;
      _confedName = info?.confed ?? '';
      _leagues = info?.leagues ?? [];
      _leagueName = _leagues.isNotEmpty ? _leagues.first : '';
    });
    _clearErrors();
  }

  bool _validate() {
    _clearErrors();
    bool ok = true;
    final clubName = _clubNameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final contactName = _contactNameCtrl.text.trim();
    final contactNumber = _contactNumberCtrl.text.trim();

    if (clubName.isEmpty) {
      setState(() => _clubNameError = AppStrings.pleaseEnterClubName);
      ok = false;
    }
    if (email.isEmpty) {
      setState(() => _emailError = AppStrings.pleaseEnterEmail);
      ok = false;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      setState(() => _emailError = AppStrings.pleaseEnterValidEmail);
      ok = false;
    }
    if (_country.isEmpty) {
      setState(() => _countryError = AppStrings.pleaseSelectCountry);
      ok = false;
    }
    if (_confedName.isEmpty) {
      setState(() => _confedError = AppStrings.pleaseSelectConfederation);
      ok = false;
    }
    if (_leagueName.isEmpty) {
      setState(() => _leagueError = AppStrings.pleaseSelectLeague);
      ok = false;
    }
    if (contactName.isEmpty) {
      setState(() => _contactNameError = AppStrings.pleaseEnterContactName);
      ok = false;
    }
    if (contactNumber.isEmpty) {
      setState(() => _contactNumberError = AppStrings.pleaseEnterContactNumber);
      ok = false;
    } else if (contactNumber.length < 7) {
      setState(
          () => _contactNumberError = AppStrings.pleaseEnterValidMobileNumber);
      ok = false;
    }
    return ok;
  }

  Future<void> _submit() async {
    if (!_validate()) return;
    setState(() => _isLoading = true);

    final repo = ref.read(clubRepositoryProvider);
    final result = await repo.clubRegister(
      clubName: _clubNameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      country: _country,
      confed: _confedName,
      league: _leagueName,
      contactCode: _contactCode,
      contactNumber: _contactNumberCtrl.text.trim(),
      contactName: _contactNameCtrl.text.trim(),
      contactIso: _contactIso,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    final status = result['status'];
    if (status == 1) {
      final isDuplicate = result['isDuplicate'] == true;
      if (isDuplicate) {
        setState(() => _emailError = AppStrings.emailAlreadyRegistered);
      } else {
        _showSuccessDialog();
      }
    }
  }

  void _showSuccessDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            const Icon(Icons.check_circle, color: Colors.green, size: 56),
            const SizedBox(height: 16),
            Text(
              AppStrings.joiningRequestThanks,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.redirectsToSocalocaFootball,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                foregroundColor: AppColors.socaYellow,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              onPressed: () async {
                Navigator.of(ctx).pop();
                context.go(AppRoutes.roleChoice);
                final uri = Uri.parse('https://socaloca.football');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              child: Text(
                AppStrings.gotItUpper,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickContactCode() async {
    // Simple phone code picker — show bottom sheet with common codes
    final codes = <Map<String, String>>[
      {'code': '+1', 'iso': 'US', 'name': 'United States'},
      {'code': '+44', 'iso': 'GB', 'name': 'United Kingdom'},
      {'code': '+91', 'iso': 'IN', 'name': 'India'},
      {'code': '+61', 'iso': 'AU', 'name': 'Australia'},
      {'code': '+49', 'iso': 'DE', 'name': 'Germany'},
      {'code': '+33', 'iso': 'FR', 'name': 'France'},
      {'code': '+34', 'iso': 'ES', 'name': 'Spain'},
      {'code': '+55', 'iso': 'BR', 'name': 'Brazil'},
      {'code': '+234', 'iso': 'NG', 'name': 'Nigeria'},
      {'code': '+27', 'iso': 'ZA', 'name': 'South Africa'},
      {'code': '+971', 'iso': 'AE', 'name': 'UAE'},
      {'code': '+966', 'iso': 'SA', 'name': 'Saudi Arabia'},
      {'code': '+62', 'iso': 'ID', 'name': 'Indonesia'},
      {'code': '+81', 'iso': 'JP', 'name': 'Japan'},
      {'code': '+82', 'iso': 'KR', 'name': 'South Korea'},
    ];

    final picked = await showModalBottomSheet<Map<String, String>>(
      context: context,
      builder: (ctx) => ListView.builder(
        itemCount: codes.length,
        itemBuilder: (_, i) => ListTile(
          leading: Text(codes[i]['code']!,
              style: const TextStyle(
                  fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
          title: Text(codes[i]['name']!,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 14)),
          onTap: () => Navigator.pop(ctx, codes[i]),
        ),
      ),
    );

    if (picked != null && mounted) {
      setState(() {
        _contactCode = picked['code']!;
        _contactIso = picked['iso']!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final countries = ConfedData.countries;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0.5,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () => context.pop(),
      //   ),
      //   title: const Text(
      //     'Register as Club',
      //     style: TextStyle(
      //       fontFamily: 'Poppins',
      //       fontWeight: FontWeight.w700,
      //       fontSize: 18,
      //       color: Colors.black,
      //     ),
      //   ),
      // ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * .18),

              Center(
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/socaloca_logo.svg',
                    width: 180,
                    // height: 150,
                    // fit: BoxFit.contain,
                  ),
                ),
              ),

              SizedBox(height: height * .11),

              // Club Name
              // _fieldLabel('Club Name *'),
              _textField(
                controller: _clubNameCtrl,
                hint: AppStrings.enterClubName,
                error: _clubNameError,
                textCapitalization: TextCapitalization.words,
                onChanged: (_) => _clearErrors(),
              ),

              // Email
              // _fieldLabel('Email *'),
              _textField(
                controller: _emailCtrl,
                hint: AppStrings.enterClubEmail,
                error: _emailError,
                keyboardType: TextInputType.emailAddress,
                onChanged: (_) => _clearErrors(),
              ),

              // Country
              // _fieldLabel('Country *'),
              _dropdownField(
                value: _country.isEmpty ? null : _country,
                hint: AppStrings.selectCountryRequired,
                items: countries,
                error: _countryError,
                onChanged: _onCountryChanged,
              ),

              // Confederation (read-only)
              // _fieldLabel('Confederation'),
              _readOnlyField(
                value: _confedName.isEmpty
                    ? AppStrings.autoPopulatedFromCountry
                    : _confedName,
                error: _confedError,
              ),

              // League
              // _fieldLabel('League *'),
              _leagues.isEmpty
                  ? _readOnlyField(
                      value: AppStrings.selectCountryFirst,
                      error: _leagueError,
                    )
                  : _dropdownField(
                      value: _leagueName.isEmpty ? null : _leagueName,
                      hint: AppStrings.selectLeagueRequired,
                      items: _leagues,
                      error: _leagueError,
                      onChanged: (v) {
                        setState(() => _leagueName = v);
                        _clearErrors();
                      },
                    ),

              // Contact Name
              // _fieldLabel('Contact Name *'),
              _textField(
                controller: _contactNameCtrl,
                hint: AppStrings.enterContactName,
                error: _contactNameError,
                textCapitalization: TextCapitalization.words,
                onChanged: (_) => _clearErrors(),
              ),

              // Contact Number with phone code
              // _fieldLabel('Contact Number *'),
              _textField(
                prefix: GestureDetector(
                  onTap: _pickContactCode,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                    // margin: const EdgeInsets.only(right: 8),
                    child: Row(
                      spacing: 8,
                      children: [
                        Text(_contactCode,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.black87)),
                        Image.asset(
                          'assets/images/dropdown.png',
                          width: 12,
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                controller: _contactNumberCtrl,
                hint: AppStrings.enterContactNumber,
                error: _contactNumberError,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                onChanged: (_) => _clearErrors(),
              ),

              const SizedBox(height: 8),

              // Submit button
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                width: double.infinity,
                height: 75,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.socaBlack,
                    foregroundColor: AppColors.socaYellow,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    elevation: 0,
                  ),
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          AppStrings.submit,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
      );

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    String? error,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    int? maxLength,
    ValueChanged<String>? onChanged,
    Widget? prefix,
  }) =>
      Container(
        margin: const EdgeInsets.only(left: 24, right: 24),
        padding: const EdgeInsets.only(bottom: 16),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          maxLength: maxLength,
          onChanged: onChanged,
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
          decoration: InputDecoration(
              prefixIcon: prefix != null
                  ? Container(
                      width: 70,
                      padding: const EdgeInsets.only(right: 8),
                      child: prefix,
                    )
                  : null,
              fillColor: AppColors.socaGrey,
              // prefix: prefix,
              hintText: hint,
              hintStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: AppColors.socaBlack),
              errorText: error,
              counterText: '',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: InputBorder.none,
              // OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(6),
              //   borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
              // ),
              enabledBorder: InputBorder.none,
              // OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(6),
              //   borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
              // ),
              focusedBorder: InputBorder.none,

              //  OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(6),
              //   borderSide: const BorderSide(color: Colors.black, width: 1.5),
              // ),
              errorBorder: InputBorder.none
              //  OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(6),
              //   borderSide: const BorderSide(color: Colors.red),
              // ),
              ),
        ),
      );

  Widget _dropdownField({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String> onChanged,
    String? error,
  }) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: AppColors.socaGrey,
              child: SearchableDropdownField(
                hint: hint,
                value: value,
                items: items,
                onChanged: onChanged,
                error: error,
              ),
            ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 14, bottom: 4),
                child: Text(error,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.red)),
              )
            else
              const SizedBox(height: 16),
          ],
        ),
      );

  Widget _readOnlyField({required String value, String? error}) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: AppColors.socaGrey,
                border: Border.all(
                    color:
                        error != null ? Colors.red : const Color(0xFFDDDDDD)),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                value,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: value.contains('Auto') ||
                            value.contains('Select') ||
                            value.contains('Loading')
                        ? Colors.grey
                        : Colors.black87),
              ),
            ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 14, bottom: 4),
                child: Text(error,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.red)),
              )
            else
              const SizedBox(height: 16),
          ],
        ),
      );
}
