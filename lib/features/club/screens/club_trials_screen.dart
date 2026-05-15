import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/club_trial_model.dart';
import '../data/repositories/club_repository.dart';
import 'club_home_screen.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Club Trials — Screen 5 of the Club shell.
class ClubTrialsScreen extends ConsumerStatefulWidget {
  const ClubTrialsScreen({super.key});
  @override
  ConsumerState<ClubTrialsScreen> createState() => _ClubTrialsScreenState();
}

class _ClubTrialsScreenState extends ConsumerState<ClubTrialsScreen> {
  final _scroll = ScrollController();
  final _trials = <ClubTrialModel>[];
  bool _loading = false;
  bool _hasMore = true;
  int _start = 0;
  static const _limit = 10;

  String _country = '';
  String _fromAge = '';
  String _toAge = '';

  static const _ages = [
    '', '14', '15', '16', '17', '18',
    '19', '20', '21', '22', '23', '24', '25',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(clubAppBarTitleProvider.notifier).state = 'Trials';
    });
    _load();
    _scroll.addListener(() {
      if (_scroll.position.pixels >= _scroll.position.maxScrollExtent * 0.8 &&
          !_loading && _hasMore) {
        _start += _limit;
        _load();
      }
    });
  }

  Future<void> _load() async {
    if (_loading) return;
    setState(() => _loading = true);
    final raw = await ref.read(clubRepositoryProvider).allClubTrials(
        countryName: _country,
        fromAge: _fromAge,
        toAge: _toAge,
        start: _start,
        limit: _limit);
    final parsed = raw.map((e) => ClubTrialModel.fromJson(e)).toList();
    setState(() {
      _trials.addAll(parsed);
      _hasMore = parsed.length >= _limit;
      _loading = false;
    });
  }

  void _search() {
    setState(() {
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
      _trials.clear();
      _start = 0;
      _hasMore = true;
    });
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Filters ───────────────────────────────────────────────────────
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Country',
                  hintStyle: const TextStyle(fontFamily: 'Poppins'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                ),
                onChanged: (v) => _country = v,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _fromAge.isEmpty ? null : _fromAge,
                      hint: const Text('From Age',
                          style: TextStyle(fontFamily: 'Poppins')),
                      items: _ages
                          .map((a) => DropdownMenuItem(
                              value: a,
                              child: Text(a.isEmpty ? 'Any' : a,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins'))))
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _fromAge = v ?? ''),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _toAge.isEmpty ? null : _toAge,
                      hint: const Text('To Age',
                          style: TextStyle(fontFamily: 'Poppins')),
                      items: _ages
                          .map((a) => DropdownMenuItem(
                              value: a,
                              child: Text(a.isEmpty ? 'Any' : a,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins'))))
                          .toList(),
                      onChanged: (v) => setState(() => _toAge = v ?? ''),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.socaBlack,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: _search,
                      child: const Text('SEARCH',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.socaBlack),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: _reset,
                      child: const Text('RESET',
                          style: TextStyle(
                              color: AppColors.socaBlack,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ── List ──────────────────────────────────────────────────────────
        Expanded(
          child: _trials.isEmpty && _loading
              ? const AppLoader()
              : _trials.isEmpty
                  ? const Center(
                      child: Text('No Trials Found',
                          style: TextStyle(fontFamily: 'Poppins')))
                  : RefreshIndicator(
                      onRefresh: () async => _search(),
                      child: ListView.builder(
                        controller: _scroll,
                        padding: const EdgeInsets.all(12),
                        itemCount:
                            _trials.length + (_loading ? 1 : 0),
                        itemBuilder: (_, i) {
                          if (i >= _trials.length) {
                            return const AppLoader();
                          }
                          return _TrialCard(trial: _trials[i]);
                        },
                      ),
                    ),
        ),
      ],
    );
  }
}

class _TrialCard extends ConsumerWidget {
  const _TrialCard({required this.trial});
  final ClubTrialModel trial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUrl = ApiConstants.getImageUrl(trial.imageUrl);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Club logo
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.socaGrey,
                child: imageUrl.isNotEmpty
                    ? ClipOval(
                        child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            width: 52,
                            height: 52,
                            fit: BoxFit.cover))
                    : const Icon(Icons.shield, color: AppColors.socaBlack),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  trial.clubName ?? '',
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (trial.location != null)
            _Row(icon: Icons.location_on, text: trial.location!),
          if (trial.ageGroup != null)
            _Row(icon: Icons.people, text: 'Age: ${trial.ageGroup}'),
          if (trial.startDate != null)
            _Row(icon: Icons.calendar_today, text: trial.startDate!),
          if (trial.description != null && trial.description!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(trial.description!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: AppColors.socaBlack.withOpacity(0.65))),
            ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaBlack,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () => _showRegisterDialog(context, ref),
              child: const Text('REGISTER',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  void _showRegisterDialog(BuildContext context, WidgetRef ref) {
    final emailCtrl = TextEditingController();
    String? error;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Register for Trial',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Email:',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 13)),
              const SizedBox(height: 6),
              TextField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'your@email.com',
                  errorText: error,
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaBlack),
              onPressed: () async {
                final email = emailCtrl.text.trim();
                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                if (email.isEmpty || !emailRegex.hasMatch(email)) {
                  setDialogState(() => error = 'Enter a valid email');
                  return;
                }
                Navigator.pop(ctx);
                final ok = await ref
                    .read(clubRepositoryProvider)
                    .trialRegisterByTrialId(
                        trialId: trial.trialId ?? '', email: email);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(ok
                        ? 'Registered successfully!'
                        : 'Registration failed. Try again.'),
                  ));
                }
              },
              child: const Text('SUBMIT',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            Icon(icon, size: 14, color: AppColors.socaBlack.withOpacity(0.5)),
            const SizedBox(width: 6),
            Expanded(
              child: Text(text,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: AppColors.socaBlack.withOpacity(0.7))),
            ),
          ],
        ),
      );
}
