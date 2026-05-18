import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/core/storage/storage_service.dart';
import 'package:socaloca/features/search/utils/countries_list.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/club_trial_model.dart';
import '../data/repositories/club_repository.dart';
import 'club_home_screen.dart';

enum _TrialSource { clubs, academies }

class TrialsLandingScreen extends StatelessWidget {
  const TrialsLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              indicatorColor: AppColors.socaYellow,
              labelColor: AppColors.socaBlack,
              unselectedLabelColor: Colors.black54,
              labelStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
              tabs: [
                Tab(text: 'Clubs'.tr),
                Tab(text: 'Academies'.tr),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                _TrialsList(source: _TrialSource.clubs),
                _TrialsList(source: _TrialSource.academies),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Club admin shell entry. Platform-wide clubs trials use the same Android UI.
class ClubTrialsScreen extends StatelessWidget {
  const ClubTrialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ClubTrialsTitleWrapper(
      child: _TrialsList(source: _TrialSource.clubs),
    );
  }
}

class _ClubTrialsTitleWrapper extends ConsumerWidget {
  const _ClubTrialsTitleWrapper({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(clubAppBarTitleProvider.notifier).state = 'Trials';
    });
    return child;
  }
}

class _TrialsList extends ConsumerStatefulWidget {
  const _TrialsList({required this.source});

  final _TrialSource source;

  @override
  ConsumerState<_TrialsList> createState() => _TrialsListState();
}

class _TrialsListState extends ConsumerState<_TrialsList> {
  final _scroll = ScrollController();
  final _trials = <ClubTrialModel>[];
  bool _loading = false;
  bool _hasMore = true;
  int _start = 0;
  String _country = '';
  String _fromAge = '';
  String _toAge = '';
  String? _searchError;

  static const _limit = 10;

  static final _ages = [
    '',
    ...List.generate(44, (index) => (index + 7).toString()),
  ];

  @override
  void initState() {
    super.initState();
    _load();
    _scroll.addListener(() {
      if (_scroll.position.pixels >= _scroll.position.maxScrollExtent * 0.8 &&
          !_loading &&
          _hasMore) {
        _start += _limit;
        _load();
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    if (_loading || !_hasMore) return;
    setState(() => _loading = true);

    final repo = ref.read(clubRepositoryProvider);
    final userId = StorageService.userId ?? '';
    final raw = widget.source == _TrialSource.clubs
        ? await repo.allClubTrials(
            userId: userId,
            country: _country,
            fromAge: _fromAge,
            toAge: _toAge,
            start: _start,
            limit: _limit,
          )
        : await repo.allAcademyTrials(
            userId: userId,
            country: _country,
            fromAge: _fromAge,
            toAge: _toAge,
            start: _start,
            limit: _limit,
          );

    final parsed = raw.map(ClubTrialModel.fromJson).toList();
    if (!mounted) return;
    setState(() {
      _trials.addAll(parsed);
      _hasMore = parsed.length >= _limit;
      _loading = false;
    });
  }

  void _search() {
    if (_country.isEmpty && _fromAge.isEmpty && _toAge.isEmpty) {
      setState(() => _searchError = 'Please select a filter'.tr);
      return;
    }
    final from = int.tryParse(_fromAge);
    final to = int.tryParse(_toAge);
    if (from != null && to != null && to <= from) {
      setState(() => _searchError = 'To age must be greater than from age'.tr);
      return;
    }
    setState(() {
      _searchError = null;
      _trials.clear();
      _start = 0;
      _hasMore = true;
    });
    _load();
  }

  void _reset() {
    setState(() {
      _country = '';
      _fromAge = '';
      _toAge = '';
      _searchError = null;
      _trials.clear();
      _start = 0;
      _hasMore = true;
    });
    _load();
  }

  void _replaceTrial(ClubTrialModel trial) {
    final index = _trials.indexWhere((item) =>
        item.effectiveTrialId == trial.effectiveTrialId &&
        item.providerId == trial.providerId);
    if (index < 0) return;
    setState(() => _trials[index] = trial);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TrialFilters(
          country: _country,
          fromAge: _fromAge,
          toAge: _toAge,
          ages: _ages,
          error: _searchError,
          onCountryChanged: (value) => setState(() => _country = value),
          onFromAgeChanged: (value) => setState(() => _fromAge = value ?? ''),
          onToAgeChanged: (value) => setState(() => _toAge = value ?? ''),
          onSearch: _search,
          onReset: _reset,
        ),
        Expanded(
          child: _trials.isEmpty && _loading
              ? const AppLoader()
              : _trials.isEmpty
                  ? Center(
                      child: Text(
                        'No Trials Found'.tr,
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        setState(() {
                          _trials.clear();
                          _start = 0;
                          _hasMore = true;
                        });
                        await _load();
                      },
                      child: ListView.builder(
                        controller: _scroll,
                        padding: const EdgeInsets.all(12),
                        itemCount: _trials.length + (_loading ? 1 : 0),
                        itemBuilder: (_, index) {
                          if (index >= _trials.length) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: AppLoader(),
                            );
                          }
                          return _TrialCard(
                            trial: _trials[index],
                            source: widget.source,
                            onRegistered: _replaceTrial,
                          );
                        },
                      ),
                    ),
        ),
      ],
    );
  }
}

class _TrialFilters extends StatelessWidget {
  const _TrialFilters({
    required this.country,
    required this.fromAge,
    required this.toAge,
    required this.ages,
    required this.onCountryChanged,
    required this.onFromAgeChanged,
    required this.onToAgeChanged,
    required this.onSearch,
    required this.onReset,
    this.error,
  });

  final String country;
  final String fromAge;
  final String toAge;
  final List<String> ages;
  final String? error;
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String?> onFromAgeChanged;
  final ValueChanged<String?> onToAgeChanged;
  final VoidCallback onSearch;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final countries = ['', ...CountriesList.countries];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: country.isEmpty ? '' : country,
            isExpanded: true,
            items: countries
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item.isEmpty ? 'Select Country'.tr : item,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontFamily: 'Poppins'),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) => onCountryChanged(value ?? ''),
            decoration: _inputDecoration('Country'.tr),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: fromAge.isEmpty ? '' : fromAge,
                  isExpanded: true,
                  items: ages
                      .map(
                        (age) => DropdownMenuItem(
                          value: age,
                          child: Text(
                            age.isEmpty ? 'From Age'.tr : age,
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: onFromAgeChanged,
                  decoration: _inputDecoration('From Age'.tr),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: toAge.isEmpty ? '' : toAge,
                  isExpanded: true,
                  items: ages
                      .map(
                        (age) => DropdownMenuItem(
                          value: age,
                          child: Text(
                            age.isEmpty ? 'To Age'.tr : age,
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: onToAgeChanged,
                  decoration: _inputDecoration('To Age'.tr),
                ),
              ),
            ],
          ),
          if (error != null) ...[
            const SizedBox(height: 6),
            Text(
              error!,
              style: const TextStyle(
                color: Colors.red,
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _ActionButton(label: 'SEARCH'.tr, onPressed: onSearch),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionButton(label: 'RESET'.tr, onPressed: onReset),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.socaBlack,
          foregroundColor: AppColors.socaYellow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _TrialCard extends ConsumerStatefulWidget {
  const _TrialCard({
    required this.trial,
    required this.source,
    required this.onRegistered,
  });

  final ClubTrialModel trial;
  final _TrialSource source;
  final ValueChanged<ClubTrialModel> onRegistered;

  @override
  ConsumerState<_TrialCard> createState() => _TrialCardState();
}

class _TrialCardState extends ConsumerState<_TrialCard> {
  bool _submitting = false;

  ClubTrialModel get trial => widget.trial;

  @override
  Widget build(BuildContext context) {
    final status = trial.trialStatus;
    final isLive = status?.live == true;
    final expired = status?.expire == true;
    final registered = status?.registered == true;
    final canRegister = status?.canRegister == true && !registered && !expired;
    final imageUrl = ApiConstants.getImageUrl(trial.displayImage);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  trial.displayName,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                    fontSize: 21,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 27,
                backgroundColor: Colors.white,
                child: imageUrl.isNotEmpty
                    ? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          width: 54,
                          height: 54,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => _fallbackLogo(),
                        ),
                      )
                    : _fallbackLogo(),
              ),
            ],
          ),
          if (isLive) ...[
            const SizedBox(height: 2),
            Text(
              'LIVE NOW'.tr,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                fontSize: 13,
                color: Colors.red,
              ),
            ),
          ],
          const SizedBox(height: 6),
          Text(
            trial.trialName ?? '',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          _InfoRow(label: 'Reg. Closes', value: trial.registerDateTo ?? ''),
          _InfoRow(label: 'Trial Starts', value: trial.trialDateFrom ?? ''),
          _InfoRow(label: 'Gender', value: _titleCase(trial.gender ?? '')),
          _InfoRow(
            label: 'Age',
            value: trial.ageFrom > 0 && trial.ageTo > 0
                ? '${trial.ageFrom} - ${trial.ageTo}'
                : '',
          ),
          _InfoRow(label: 'Cost', value: _costText(trial)),
          _InfoRow(label: 'Location', value: trial.location ?? ''),
          if ((trial.trialVenue ?? '').isNotEmpty)
            _InfoRow(
              label: 'Trial Venue',
              value: trial.trialVenue!,
              valueStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Color(0xFF2368B4),
                decoration: TextDecoration.underline,
              ),
              onTap: _openMap,
            ),
          if ((trial.brief ?? '').isNotEmpty)
            _InfoRow(label: 'Brief', value: trial.brief!),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: _statusButton(
              expired: expired,
              registered: registered,
              canRegister: canRegister,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fallbackLogo() {
    return const Icon(Icons.shield, color: Colors.black, size: 26);
  }

  Widget _statusButton({
    required bool expired,
    required bool registered,
    required bool canRegister,
  }) {
    final label = expired
        ? 'EXPIRED'.tr
        : registered
            ? 'REGISTERED'.tr
            : 'REGISTER'.tr;
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.socaBlack,
          foregroundColor: AppColors.socaYellow,
          disabledBackgroundColor: AppColors.socaBlack,
          disabledForegroundColor: AppColors.socaYellow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
        onPressed: canRegister && !_submitting ? _tryRegister : null,
        child: _submitting
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
      ),
    );
  }

  Future<void> _tryRegister() async {
    if (!_isEligible()) {
      _showMessage(
        'Registration restricted. Your profile does not match the trial criteria. SocaLoca will notify you of future Live trials!'
            .tr,
      );
      return;
    }
    await _showRegisterDialog();
  }

  bool _isEligible() {
    final user = StorageService.currentUser ?? {};
    final userGender = user['gender']?.toString().toLowerCase() ?? '';
    final trialGender = trial.gender?.toLowerCase() ?? '';
    if (trialGender.isNotEmpty &&
        trialGender != 'both' &&
        userGender.isNotEmpty &&
        trialGender != userGender) {
      return false;
    }

    final age = _userAge(user);
    if (age == 0 || trial.ageFrom == 0 || trial.ageTo == 0) return true;
    return age >= trial.ageFrom && age <= trial.ageTo;
  }

  int _userAge(Map<String, dynamic> user) {
    final explicitAge = int.tryParse(user['age']?.toString() ?? '');
    if (explicitAge != null && explicitAge > 0) return explicitAge;
    final birthYear = int.tryParse(user['yearOfBirth']?.toString() ?? '') ??
        _birthYearFromDob(user['dob']?.toString()) ??
        _birthYearFromDob(user['dateOfBirth']?.toString());
    if (birthYear == null || birthYear <= 0) return 0;
    return DateTime.now().year - birthYear;
  }

  int? _birthYearFromDob(String? dob) {
    if (dob == null || dob.isEmpty) return null;
    final parts = dob.contains('-') ? dob.split('-') : dob.split('/');
    if (parts.length == 3) return int.tryParse(parts.last);
    return null;
  }

  Future<void> _showRegisterDialog() async {
    final user = StorageService.currentUser ?? {};
    final name = '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}'.trim();
    final emailController = TextEditingController(
      text: user['email']?.toString() ?? '',
    );
    String? emailError;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              title: Text(
                'REGISTER'.tr,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.isEmpty ? 'Player'.tr : name,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email'.tr,
                      errorText: emailError,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text('Cancel'.tr),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.socaBlack,
                    foregroundColor: AppColors.socaYellow,
                  ),
                  onPressed: () async {
                    final email = emailController.text.trim();
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
                      setDialogState(() {
                        emailError = 'Enter a valid email'.tr;
                      });
                      return;
                    }
                    Navigator.pop(dialogContext);
                    await _register(email, name);
                  },
                  child: Text('SUBMIT'.tr),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _register(String email, String name) async {
    setState(() => _submitting = true);
    final repo = ref.read(clubRepositoryProvider);
    final ok = widget.source == _TrialSource.clubs
        ? await repo.trialRegisterByTrialId(
            trialId: trial.effectiveTrialId,
            email: email,
            clubId: trial.providerId,
            clubName: trial.displayName,
            clubEmail: trial.displayEmail,
            myName: name,
          )
        : await repo.academyTrialRegisterByTrialId(
            trialId: trial.effectiveTrialId,
            email: email,
            academyId: trial.providerId,
            academyName: trial.displayName,
            academyEmail: trial.displayEmail,
            myName: name,
          );

    if (!mounted) return;
    setState(() => _submitting = false);
    if (ok) {
      widget.onRegistered(
        trial.copyWith(
          trialStatus: (trial.trialStatus ?? const ClubTrialStatusModel())
              .copyWith(canRegister: false, registered: true),
        ),
      );
    }
    _showMessage(ok
        ? 'Registered successfully!'.tr
        : 'Registration failed. Try again.'.tr);
  }

  Future<void> _openMap() async {
    final lat = trial.lat;
    final lng = trial.lng;
    final query = Uri.encodeComponent(trial.trialVenue ?? trial.location ?? '');
    final uri = lat != 0 && lng != 0
        ? Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng')
        : Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  String _costText(ClubTrialModel trial) {
    if (trial.cost <= 0) return 'Free'.tr;
    final currency = trial.currency?.isNotEmpty == true ? trial.currency! : '';
    return '$currency ${trial.cost}'.trim();
  }

  String _titleCase(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.valueStyle,
    this.onTap,
  });

  final String label;
  final String value;
  final TextStyle? valueStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) return const SizedBox.shrink();
    final text = Text(
      value,
      style: valueStyle ??
          const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.black,
          ),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 108,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: onTap == null ? text : InkWell(onTap: onTap, child: text),
          ),
        ],
      ),
    );
  }
}
