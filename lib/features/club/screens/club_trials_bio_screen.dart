import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/core/storage/storage_service.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/club_trial_model.dart';
import '../data/repositories/club_repository.dart';

/// Mirrors Android ClubRegisterFragment.
/// Shows trials for a specific club (scoped by clubId).
/// Navigated to from the club bio screen's "REGISTER" button.
class ClubTrialsBioScreen extends ConsumerStatefulWidget {
  final String clubId;

  const ClubTrialsBioScreen({super.key, required this.clubId});

  @override
  ConsumerState<ClubTrialsBioScreen> createState() =>
      _ClubTrialsBioScreenState();
}

class _ClubTrialsBioScreenState extends ConsumerState<ClubTrialsBioScreen> {
  final _scroll = ScrollController();
  final _trials = <ClubTrialModel>[];
  bool _loading = false;
  bool _hasMore = true;
  int _start = 0;

  static const _limit = 10;

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
    final raw = await repo.clubTrialList(
      clubId: widget.clubId,
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

  void _replaceTrial(ClubTrialModel updated) {
    final index = _trials
        .indexWhere((t) => t.effectiveTrialId == updated.effectiveTrialId);
    if (index < 0) return;
    setState(() => _trials[index] = updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.liveTrials,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: _trials.isEmpty && _loading
          ? const AppLoader()
          : _trials.isEmpty
              ? Center(
                  child: Text(
                    AppStrings.noTrialsFound,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.black54,
                    ),
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
                        onRegistered: _replaceTrial,
                      );
                    },
                  ),
                ),
    );
  }
}

class _TrialCard extends ConsumerStatefulWidget {
  const _TrialCard({required this.trial, required this.onRegistered});

  final ClubTrialModel trial;
  final ValueChanged<ClubTrialModel> onRegistered;

  @override
  ConsumerState<_TrialCard> createState() => _TrialCardState();
}

class _TrialCardState extends ConsumerState<_TrialCard> {
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
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
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
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => _fallbackLogo(),
                      )
                    : _fallbackLogo(),
              ),
            ],
          ),
          if (isLive) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  AppStrings.live,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 6),
          Text(
            trial.trialName ?? '',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          if ((trial.gender ?? '').isNotEmpty)
            _InfoRow(
                label: AppStrings.genderPlain,
                value: _titleCase(trial.gender!)),
          if (trial.ageFrom > 0 && trial.ageTo > 0)
            _InfoRow(
                label: AppStrings.age,
                value:
                    '${trial.ageFrom} - ${trial.ageTo} ${AppStrings.yearsTitle}'),
          if ((trial.registerDateFrom ?? '').isNotEmpty &&
              (trial.registerDateTo ?? '').isNotEmpty)
            _InfoRow(
                label: AppStrings.registration,
                value: '${trial.registerDateFrom} - ${trial.registerDateTo}'),
          if ((trial.trialDateFrom ?? '').isNotEmpty &&
              (trial.trialDateTo ?? '').isNotEmpty)
            _InfoRow(
                label: AppStrings.trialDate,
                value: '${trial.trialDateFrom} - ${trial.trialDateTo}'),
          if ((trial.trialVenue ?? '').isNotEmpty ||
              (trial.location ?? '').isNotEmpty)
            _InfoRow(
              label: AppStrings.location,
              value: trial.trialVenue ?? trial.location ?? '',
              valueStyle: (trial.lat != 0 && trial.lng != 0)
                  ? const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Color(0xFF2368B4),
                      decoration: TextDecoration.underline,
                    )
                  : null,
              onTap: (trial.lat != 0 && trial.lng != 0) ? _openMap : null,
            ),
          _InfoRow(label: AppStrings.cost, value: _costText()),
          if ((trial.brief ?? '').isNotEmpty)
            _InfoRow(label: AppStrings.brief, value: trial.brief!),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: _buildStatusButton(
                expired: expired,
                registered: registered,
                canRegister: canRegister),
          ),
        ],
      ),
    );
  }

  Widget _fallbackLogo() => Container(
        width: 50,
        height: 50,
        color: AppColors.socaGrey,
        child: const Icon(Icons.shield, color: Colors.black54, size: 24),
      );

  Widget _buildStatusButton({
    required bool expired,
    required bool registered,
    required bool canRegister,
  }) {
    final label = expired
        ? AppStrings.registrationClosed
        : registered
            ? AppStrings.registered.toUpperCase()
            : AppStrings.register.toUpperCase();
    return SizedBox(
      height: 36,
      width: 220,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.socaBlack,
          foregroundColor: AppColors.socaYellow,
          disabledBackgroundColor: AppColors.socaBlack,
          disabledForegroundColor: AppColors.socaYellow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          elevation: 0,
        ),
        onPressed: canRegister ? _tryRegister : null,
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Future<void> _tryRegister() async {
    if (!_isEligible()) {
      _showSnack(AppStrings.registrationRestrictedShort);
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
    final explicit = int.tryParse(user['age']?.toString() ?? '');
    if (explicit != null && explicit > 0) return explicit;
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
    final emailCtrl =
        TextEditingController(text: user['email']?.toString() ?? '');
    ClubTrialModel? updatedTrial;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dCtx) {
        String? emailError;
        bool done = false;
        bool submitting = false;

        return StatefulBuilder(
          builder: (dCtx, setDState) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: done
                ? null
                : Text(AppStrings.register,
                    style: const TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.w800)),
            content: done
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 52),
                      const SizedBox(height: 12),
                      Text(
                        AppStrings.trialRegistrationThanks,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Poppins', fontSize: 13),
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name.isEmpty ? AppStrings.player : name,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 14)),
                      const SizedBox(height: 12),
                      TextField(
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (_) => setDState(() => emailError = null),
                        decoration: InputDecoration(
                          labelText: AppStrings.emailPlain,
                          errorText: emailError,
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                        ),
                      ),
                    ],
                  ),
            actions: done
                ? [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.socaBlack,
                          foregroundColor: AppColors.socaYellow,
                        ),
                        onPressed: () => Navigator.pop(dCtx),
                        child: Text(AppStrings.gotItUpper,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ]
                : [
                    TextButton(
                      onPressed: submitting ? null : () => Navigator.pop(dCtx),
                      child: Text(AppStrings.cancel),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.socaBlack,
                        foregroundColor: AppColors.socaYellow,
                      ),
                      onPressed: submitting
                          ? null
                          : () async {
                              final email = emailCtrl.text.trim();
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                                  .hasMatch(email)) {
                                setDState(() => emailError =
                                    AppStrings.enterValidEmailAddress);
                                return;
                              }
                              setDState(() => submitting = true);
                              final repo = ref.read(clubRepositoryProvider);
                              final ok = await repo.trialRegisterByTrialId(
                                trialId: trial.effectiveTrialId,
                                email: email,
                                clubId: trial.providerId,
                                clubName: trial.displayName,
                                clubEmail: trial.displayEmail,
                                myName: name,
                              );
                              if (ok) {
                                updatedTrial = trial.copyWith(
                                  trialStatus: (trial.trialStatus ??
                                          const ClubTrialStatusModel())
                                      .copyWith(
                                          canRegister: false, registered: true),
                                );
                                setDState(() {
                                  done = true;
                                  submitting = false;
                                });
                              } else {
                                setDState(() => submitting = false);
                                if (dCtx.mounted) Navigator.pop(dCtx);
                                _showSnack(AppStrings.registrationFailed);
                              }
                            },
                      child: submitting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : Text(AppStrings.register.toUpperCase(),
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w800)),
                    ),
                  ],
          ),
        );
      },
    );
    emailCtrl.dispose();
    if (updatedTrial != null) {
      widget.onRegistered(updatedTrial!);
    }
  }

  Future<void> _openMap() async {
    final lat = trial.lat;
    final lng = trial.lng;
    final venue = Uri.encodeComponent(trial.trialVenue ?? trial.location ?? '');
    final uri =
        Uri.parse('http://maps.google.com/maps?q=loc:$lat,$lng ($venue)');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  String _costText() {
    if (trial.cost <= 0) return AppStrings.free;
    final currency = trial.currency ?? '';
    final symbol = currency == 'USD'
        ? '\$'
        : currency == 'EUR'
            ? '€'
            : '£';
    return '$symbol${trial.cost}';
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
            fontSize: 13,
            color: Colors.black,
            height: 1.25,
          ),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: Colors.black,
                height: 1.25,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
            child: Text(':',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    height: 1.25)),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: onTap == null ? text : InkWell(onTap: onTap, child: text),
          ),
        ],
      ),
    );
  }
}
