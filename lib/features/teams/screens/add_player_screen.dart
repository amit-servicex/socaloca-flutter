import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socaloca/features/teams/widgets/team_header_widget.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/services/location_service.dart';
import '../../../shared/widgets/socaloca_text_field.dart';
import '../data/models/team_bio_model.dart';
import '../data/repositories/team_manage_repository.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

// ── Position data (matches Android AddPlayersFragment spinners) ───────────────

// Same country list as NewLoginScreen._getCountryList()
const _countryList = [
  {'name': 'Afghanistan', 'code': '+93'},
  {'name': 'Albania', 'code': '+355'},
  {'name': 'Algeria', 'code': '+213'},
  {'name': 'Argentina', 'code': '+54'},
  {'name': 'Australia', 'code': '+61'},
  {'name': 'Austria', 'code': '+43'},
  {'name': 'Bangladesh', 'code': '+880'},
  {'name': 'Belgium', 'code': '+32'},
  {'name': 'Brazil', 'code': '+55'},
  {'name': 'Canada', 'code': '+1'},
  {'name': 'Chile', 'code': '+56'},
  {'name': 'China', 'code': '+86'},
  {'name': 'Colombia', 'code': '+57'},
  {'name': 'Denmark', 'code': '+45'},
  {'name': 'Egypt', 'code': '+20'},
  {'name': 'England', 'code': '+44'},
  {'name': 'Finland', 'code': '+358'},
  {'name': 'France', 'code': '+33'},
  {'name': 'Germany', 'code': '+49'},
  {'name': 'Greece', 'code': '+30'},
  {'name': 'India', 'code': '+91'},
  {'name': 'Indonesia', 'code': '+62'},
  {'name': 'Republic of Ireland', 'code': '+353'},
  {'name': 'Italy', 'code': '+39'},
  {'name': 'Japan', 'code': '+81'},
  {'name': 'Kenya', 'code': '+254'},
  {'name': 'Korea Republic', 'code': '+82'},
  {'name': 'Malaysia', 'code': '+60'},
  {'name': 'Mexico', 'code': '+52'},
  {'name': 'Netherlands', 'code': '+31'},
  {'name': 'New Zealand', 'code': '+64'},
  {'name': 'Nigeria', 'code': '+234'},
  {'name': 'Norway', 'code': '+47'},
  {'name': 'Pakistan', 'code': '+92'},
  {'name': 'Peru', 'code': '+51'},
  {'name': 'Philippines', 'code': '+63'},
  {'name': 'Poland', 'code': '+48'},
  {'name': 'Portugal', 'code': '+351'},
  {'name': 'Russia', 'code': '+7'},
  {'name': 'Saudi Arabia', 'code': '+966'},
  {'name': 'Singapore', 'code': '+65'},
  {'name': 'South Africa', 'code': '+27'},
  {'name': 'Spain', 'code': '+34'},
  {'name': 'Sweden', 'code': '+46'},
  {'name': 'Switzerland', 'code': '+41'},
  {'name': 'Thailand', 'code': '+66'},
  {'name': 'Türkiye', 'code': '+90'},
  {'name': 'Ukraine', 'code': '+380'},
  {'name': 'United Arab Emirates', 'code': '+971'},
  {'name': 'USA', 'code': '+1'},
  {'name': 'Vietnam', 'code': '+84'},
];

const _positions = ['Goalkeeper', 'Defender', 'Midfield', 'Attack'];

const _subPositions = {
  'Goalkeeper': ['Goalkeeper (GK)'],
  'Defender': ['Centre Back (CB)', 'Right Back (RB)', 'Left Back (LB)'],
  'Midfield': [
    'Defensive Midfield (DM)',
    'Center Midfield (CM)',
    'Attacking Midfield (AM)',
    'Right Wing (RW)',
    'Left Wing (LW)',
  ],
  'Attack': [
    'Center Forward (CF)',
    'Striker (ST)',
    'Second Striker (SS)',
    'False 9 (F9)',
  ],
};

// ── Screen ────────────────────────────────────────────────────────────────────

class AddPlayerScreen extends StatelessWidget {
  final String teamId;
  final TeamDetailsModel teamDetails;

  const AddPlayerScreen({
    super.key,
    required this.teamId,
    required this.teamDetails,
  });

  @override
  Widget build(BuildContext context) {
    final repo = TeamManageRepository(teamId: teamId);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.socaPageBg,
        body: Column(
          children: [
            ColoredBox(
              color: Colors.white,
              child: TabBar(
                isScrollable: true,
                labelColor: AppColors.socaBlack,
                unselectedLabelColor: AppColors.socaBlack,
                indicatorColor: AppColors.socaBlack,
                indicatorWeight: 3,
                labelStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                tabs: [
                  Tab(text: AppStrings.searchAndInvite.toUpperCase()),
                  Tab(text: AppStrings.inviteByPhone.toUpperCase()),
                  Tab(text: AppStrings.createPlayer.toUpperCase()),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _SearchInviteTab(repo: repo, teamDetails: teamDetails),
                  _InviteByPhoneTab(repo: repo, teamDetails: teamDetails),
                  _CreatePlayerTab(repo: repo, teamDetails: teamDetails),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Tab 0: Search & Invite ────────────────────────────────────────────────────

class _SearchInviteTab extends StatefulWidget {
  final TeamManageRepository repo;
  final TeamDetailsModel teamDetails;
  const _SearchInviteTab({required this.repo, required this.teamDetails});

  @override
  State<_SearchInviteTab> createState() => _SearchInviteTabState();
}

class _SearchInviteTabState extends State<_SearchInviteTab>
    with AutomaticKeepAliveClientMixin {
  final _searchCtrl = TextEditingController();
  Timer? _debounce;

  List<PlayerSearchResult> _results = [];
  bool _loading = false;
  bool _hasSearched = false;
  final _inviting = <String>{}; // playerIds currently being invited
  final _invited = <String>{}; // playerIds already invited this session

  int _start = 0;
  static const _limit = 10;
  bool _hasMore = true;
  final _scrollCtrl = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(_onSearchChanged);
    _scrollCtrl.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    final term = _searchCtrl.text.trim();
    if (term.length < 3) {
      setState(() {
        _results = [];
        _hasSearched = false;
      });
      return;
    }
    _debounce =
        Timer(const Duration(milliseconds: 500), () => _search(reset: true));
  }

  void _onScroll() {
    if (_scrollCtrl.position.pixels >=
            _scrollCtrl.position.maxScrollExtent - 100 &&
        !_loading &&
        _hasMore) {
      _search(reset: false);
    }
  }

  Future<void> _search({required bool reset}) async {
    if (_loading) return;
    if (reset) {
      _start = 0;
      _hasMore = true;
    }
    setState(() => _loading = true);
    try {
      final page = await widget.repo.searchPlayersForTeam(
        searchTerm: _searchCtrl.text.trim(),
        start: _start,
        limit: _limit,
      );
      if (mounted) {
        setState(() {
          _hasSearched = true;
          if (reset) {
            _results = page;
          } else {
            _results.addAll(page);
          }
          _start += page.length;
          _hasMore = page.length >= _limit;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _invite(PlayerSearchResult player) async {
    final pid = player.userId ?? '';
    if (pid.isEmpty || _inviting.contains(pid) || _invited.contains(pid)) {
      return;
    }
    setState(() => _inviting.add(pid));
    try {
      await widget.repo.invitePlayer(
        playerId: pid,
        teamName: widget.teamDetails.teamName ?? '',
        teamImageUrl: widget.teamDetails.teamImage ?? '',
      );
      if (mounted) {
        setState(() {
          _inviting.remove(pid);
          _invited.add(pid);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(AppStrings.inviteSent, style: const TextStyle(fontFamily: 'Poppins')),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _inviting.remove(pid));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(e.toString(), style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        TeamHeader(teamDetails: widget.teamDetails),
        // Search bar
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(12),
          child: CreateProfileTextField(
            controller: _searchCtrl,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _search(reset: true),
            hintText: AppStrings.searchHere,
            suffixWidget: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/icons/ic_search.png",
                    width: 24, height: 24),
                if (_searchCtrl.text.isNotEmpty)
                  IconButton(
                    icon: Image.asset(
                      "assets/icons/ic_clear_red.png",
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {
                      _searchCtrl.clear();
                      setState(() {
                        _results = [];
                        _hasSearched = false;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
        // Results
        Expanded(
          child: !_hasSearched && !_loading
              ? Center(
                  child: Text(AppStrings.enterAtLeast3Chars,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Colors.grey)),
                )
              : _results.isEmpty && !_loading
                  ? Center(
                      child: Text(AppStrings.noPlayersFound,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              color: Colors.grey)),
                    )
                  : ListView.separated(
                      controller: _scrollCtrl,
                      padding: const EdgeInsets.all(12),
                      itemCount: _results.length + (_loading ? 1 : 0),
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (_, i) {
                        if (i == _results.length) {
                          return const Center(
                              child: Padding(
                            padding: EdgeInsets.all(12),
                            child: AppLoader(),
                          ));
                        }
                        final p = _results[i];
                        final pid = p.userId ?? '';
                        final alreadyInvited =
                            p.invited || _invited.contains(pid);
                        final isInviting = _inviting.contains(pid);
                        return Card(
                          elevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: Row(
                              children: [
                                _SmallAvatar(imageUrl: p.imageUrl),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        p.name ?? 'Unknown',
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: AppColors.socaBlack,
                                        ),
                                      ),
                                      if (p.country?.isNotEmpty ?? false)
                                        Text(
                                          p.country!,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 11,
                                            color: Colors.grey,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                if (isInviting)
                                  const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.socaBlack),
                                  )
                                else if (alreadyInvited)
                                  const Icon(Icons.check_circle,
                                      color: Colors.green, size: 22)
                                else
                                  ElevatedButton(
                                    onPressed: () => _invite(p),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.socaBlack,
                                      foregroundColor: AppColors.socaYellow,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      minimumSize: const Size(70, 30),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: const Text(
                                      'INVITE',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 11),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }
}

// ── Tab 1: Invite by Phone ────────────────────────────────────────────────────

class _InviteByPhoneTab extends StatefulWidget {
  final TeamManageRepository repo;
  final TeamDetailsModel teamDetails;
  const _InviteByPhoneTab({required this.repo, required this.teamDetails});

  @override
  State<_InviteByPhoneTab> createState() => _InviteByPhoneTabState();
}

class _InviteByPhoneTabState extends State<_InviteByPhoneTab>
    with AutomaticKeepAliveClientMixin {
  final _phoneCtrl = TextEditingController();
  final List<Map<String, String>> _numbers = []; // {countryCode, mobile}
  bool _isSending = false;

  // Mirrors NewLoginFragment: auto-detected via GPS, default +91 / India
  String _countryCode = '+91';
  String _countryName = 'India';

  String get _ownPhone {
    final user = StorageService.currentUser ?? {};
    return user['mobile'] as String? ?? user['phone'] as String? ?? '';
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _detectCountry());
  }

  Future<void> _detectCountry() async {
    final country = await LocationService.detectCountry(context);
    if (!mounted || country == null) return;
    setState(() {
      _countryCode = country.phoneCode;
      _countryName = country.name;
    });
  }

  Future<void> _showCountryPicker() async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Select Country',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.socaBlack,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: _countryList.length,
                  itemBuilder: (_, i) {
                    final c = _countryList[i];
                    return ListTile(
                      title: Text(c['name']!,
                          style: const TextStyle(
                              fontFamily: 'Poppins', fontSize: 14)),
                      trailing: Text(c['code']!,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      onTap: () {
                        setState(() {
                          _countryCode = c['code']!;
                          _countryName = c['name']!;
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
      ),
    );
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _addNumber() {
    final phone = _phoneCtrl.text.trim();
    if (phone.isEmpty) {
      _showError('Please enter a phone number');
      return;
    }
    if (phone.length < 7) {
      _showError('Please enter valid mobile number');
      return;
    }
    if (phone == _ownPhone) {
      _showError('Cannot invite your own number');
      return;
    }
    if (_numbers.any((n) => n['mobile'] == phone)) {
      _showError('Already added');
      return;
    }
    setState(() {
      _numbers.add({'countryCode': _countryCode, 'mobile': phone});
      _phoneCtrl.clear();
    });
  }

  void _removeNumber(int index) {
    setState(() => _numbers.removeAt(index));
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: const TextStyle(fontFamily: 'Poppins')),
      backgroundColor: Colors.red,
    ));
  }

  Future<void> _send() async {
    if (_numbers.isEmpty) {
      _showError('Add at least one phone number');
      return;
    }
    setState(() => _isSending = true);
    try {
      await widget.repo.inviteByPhone(
        numbers: _numbers,
        teamName: widget.teamDetails.teamName ?? '',
        teamImageUrl: widget.teamDetails.teamImage ?? '',
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.invitationSentAll,
              style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.green,
        ),
      );
      setState(() => _numbers.clear());
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(e.toString(), style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ));
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      // padding: const EdgeInsets.all(16),
      children: [
        TeamHeader(teamDetails: widget.teamDetails),
        const SizedBox(height: 16),
        // Country code + phone input row

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Colors.white,
          child: Column(
            children: [
              Text(
                'Invite players',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.socaBlack,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  // GestureDetector(
                  //   onTap: _showCountryPicker,
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 10, vertical: 14),
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       border: Border.all(color: AppColors.socaBlack),
                  //       borderRadius: const BorderRadius.only(
                  //         topLeft: Radius.circular(6),
                  //         bottomLeft: Radius.circular(6),
                  //       ),
                  //     ),
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Text(
                  //           _countryCode,
                  //           style: const TextStyle(
                  //             fontFamily: 'Poppins',
                  //             fontWeight: FontWeight.w700,
                  //             fontSize: 14,
                  //             color: AppColors.socaBlack,
                  //           ),
                  //         ),
                  //         const SizedBox(width: 4),
                  //         const VerticalDivider(
                  //           color: AppColors.socaBlack,
                  //           thickness: 1,
                  //           width: 1,
                  //         ),
                  //         const SizedBox(width: 4),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: CreateProfileTextField(
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      hintText: AppStrings.phoneNumber,
                      suffixWidget: InkWell(
                        onTap: () => _addNumber,
                        child: Image.asset("assets/icons/ic_add.png",
                            width: 50, height: 50),
                      ),
                      prefixWidget: InkWell(
                        onTap: () => _showCountryPicker,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 16),
                            Text(
                              _countryCode,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColors.socaBlack,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: const VerticalDivider(
                                color: AppColors.socaBlack,
                                thickness: 1,
                                width: 1,
                              ),
                            ),
                            const SizedBox(width: 4),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(width: 8),
                  // GestureDetector(
                  //   onTap: _addNumber,
                  //   child: Container(
                  //     width: 45,
                  //     height: 45,
                  //     decoration: const BoxDecoration(
                  //       color: AppColors.socaBlack,
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: const Icon(Icons.add,
                  //         color: AppColors.socaYellow, size: 22),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.7),
              // Added numbers list
              if (_numbers.isNotEmpty) ...[
                ..._numbers.asMap().entries.map((entry) {
                  final i = entry.key;
                  final n = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            '${n['countryCode']} ${n['mobile']}',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _removeNumber(i),
                          child: const Icon(Icons.close,
                              size: 18, color: Colors.red),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 16),
              ],
              // Send button
              SizedBox(
                height: 65,
                child: ElevatedButton(
                  onPressed: _isSending ? null : _send,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.socaBlack,
                    disabledBackgroundColor: AppColors.socaBlack,
                    foregroundColor: AppColors.socaYellow,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: _isSending
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: AppColors.socaYellow),
                        )
                      : const Text(
                          'INVITE ALL',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

// ── Tab 2: Create Player ──────────────────────────────────────────────────────

class _CreatePlayerTab extends StatefulWidget {
  final TeamManageRepository repo;
  final TeamDetailsModel teamDetails;
  const _CreatePlayerTab({required this.repo, required this.teamDetails});

  @override
  State<_CreatePlayerTab> createState() => _CreatePlayerTabState();
}

class _CreatePlayerTabState extends State<_CreatePlayerTab>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _profileNameCtrl = TextEditingController();
  Timer? _profileDebounce;

  bool? _profileAvailable; // null = unchecked, true/false
  bool _checkingProfile = false;

  String _gender = 'male';
  int? _yearOfBirth;
  String _position = _positions.first;
  String? _subPosition;
  bool _isSaving = false;

  String get _country {
    final user = StorageService.currentUser ?? {};
    return user['country'] as String? ?? '';
  }

  // Year options: current year - 5 down to current year - 80
  List<int> get _years {
    final now = DateTime.now().year;
    return List.generate(75, (i) => now - 5 - i);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _profileDebounce?.cancel();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _profileNameCtrl.dispose();
    super.dispose();
  }

  void _onProfileNameChanged(String value) {
    _profileDebounce?.cancel();
    setState(() => _profileAvailable = null);
    if (value.trim().length < 5) return;
    _profileDebounce = Timer(const Duration(milliseconds: 600), () async {
      if (!mounted) return;
      setState(() => _checkingProfile = true);
      try {
        final available = await widget.repo.checkProfileName(value.trim());
        if (mounted) {
          setState(() {
            _profileAvailable = available;
            _checkingProfile = false;
          });
        }
      } catch (_) {
        if (mounted) setState(() => _checkingProfile = false);
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_profileAvailable != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.profileNameNotAvailable,
              style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    setState(() => _isSaving = true);
    try {
      final playerDetails = await widget.repo.createPlayer(
        firstName: _firstNameCtrl.text.trim(),
        lastName: _lastNameCtrl.text.trim(),
        profileName: _profileNameCtrl.text.trim(),
        yearOfBirth: _yearOfBirth!,
        gender: _gender,
        country: _country,
        playPosition: _position,
        playPositionType: _subPosition ?? (_subPositions[_position]!.first),
      );
      if (!mounted) return;
      final name =
          '${playerDetails['firstName'] ?? ''} ${playerDetails['lastName'] ?? ''}'
              .trim();
      _showSuccessDialog(name.isNotEmpty ? name : 'Player');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(e.toString(), style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showSuccessDialog(String playerName) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Text(
          '$playerName has been created!',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: AppColors.socaBlack,
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          // Assign Jersey — go back to Manage Team (triggers refresh via .then)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.socaBlack,
              foregroundColor: AppColors.socaYellow,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop(true); // pop AddPlayerScreen
            },
            child: const Text(
              'Assign Jersey',
              style:
                  TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
            ),
          ),
          // Add Another — reset form
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.socaBlack,
              side: const BorderSide(color: AppColors.socaBlack),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              _resetForm();
            },
            child: const Text(
              'Add Another',
              style:
                  TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _firstNameCtrl.clear();
    _lastNameCtrl.clear();
    _profileNameCtrl.clear();
    setState(() {
      _gender = 'male';
      _yearOfBirth = null;
      _position = _positions.first;
      _subPosition = null;
      _profileAvailable = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final subs = _subPositions[_position] ?? [];
    // Reset sub-position when position changes
    if (_subPosition != null && !subs.contains(_subPosition)) {
      _subPosition = null;
    }

    return Form(
      key: _formKey,
      child: ListView(
        // padding: const EdgeInsets.all(16),
        children: [
          TeamHeader(teamDetails: widget.teamDetails),
          const SizedBox(height: 16),
          // First Name
          // _label('First Name *'),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textField(
                  controller: _firstNameCtrl,
                  hint: 'First name',
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 14),

                // Last Name
                // _label('Last Name *'),
                const SizedBox(height: 6),
                _textField(
                  controller: _lastNameCtrl,
                  hint: 'Last name',
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 14),

                // Profile Name
                // _label('Profile Name * (min 5 chars)'),
                const SizedBox(height: 6),
                _textField(
                  controller: _profileNameCtrl,
                  onChanged: _onProfileNameChanged,
                  hint: 'Username (min 5 chars)',
                  suffixWidget: _checkingProfile
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: AppColors.socaBlack),
                        )
                      : _profileAvailable == true
                          ? const Icon(Icons.check_circle,
                              color: Colors.green, size: 20)
                          : _profileAvailable == false
                              ? const Icon(Icons.cancel,
                                  color: Colors.red, size: 20)
                              : null,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Required';
                    if (v.trim().length < 5) return 'Minimum 5 characters';
                    if (_profileAvailable == false) return 'Name not available';
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // Year of Birth
                // _label('Year of Birth *'),
                const SizedBox(height: 6),
                DropdownButtonFormField<int>(
                  icon: Image.asset("assets/images/dropdown.png",
                      width: 0, height: 0),
                  iconSize: 18,
                  initialValue: _yearOfBirth,
                  hint: Text(AppStrings.selectYear,
                      style: const TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                  items: _years
                      .map((y) => DropdownMenuItem(
                          value: y,
                          child: Text('$y',
                              style: const TextStyle(
                                  fontFamily: 'Poppins', fontSize: 14))))
                      .toList(),
                  onChanged: (v) => setState(() => _yearOfBirth = v),
                  validator: (v) => v == null ? 'Required' : null,
                  decoration: _dropdownDecoration(),
                ),
                const SizedBox(height: 14),

                // Gender
                const SizedBox(height: 6),
                Row(
                  children: [
                    _label('Gender'),
                    _GenderRadioTile(
                      label: 'Male',
                      value: 'male',
                      groupValue: _gender,
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => _gender = value);
                      },
                    ),
                    const SizedBox(width: 8),
                    // const SizedBox(width: 12),
                    _GenderRadioTile(
                      label: 'Female',
                      value: 'female',
                      groupValue: _gender,
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => _gender = value);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Country (read-only)
                // _label('Country'),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    _country.isNotEmpty ? _country : '—',
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 14),

                // Play Position
                _label('Playing  Position *'),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  icon: Image.asset("assets/images/dropdown.png",
                      width: 0, height: 0),
                  iconSize: 18,
                  initialValue: _position,
                  items: _positions
                      .map((p) => DropdownMenuItem(
                          value: p,
                          child: Text(p,
                              style: const TextStyle(
                                  fontFamily: 'Poppins', fontSize: 14))))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      setState(() {
                        _position = v;
                        _subPosition = null;
                      });
                    }
                  },
                  decoration: _dropdownDecoration(),
                ),
                const SizedBox(height: 14),

                // Sub-position
                // _label('Position Type *'),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  icon: Image.asset("assets/images/dropdown.png",
                      width: 0, height: 0),
                  iconSize: 18,
                  key: ValueKey(_position),
                  initialValue: _subPosition ?? subs.first,
                  items: subs
                      .map((s) => DropdownMenuItem(
                          value: s,
                          child: Text(s,
                              style: const TextStyle(
                                  fontFamily: 'Poppins', fontSize: 13))))
                      .toList(),
                  onChanged: (v) => setState(() => _subPosition = v),
                  validator: (v) => v == null ? 'Required' : null,
                  decoration: _dropdownDecoration(),
                ),
                const SizedBox(height: 28),

                // Submit
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socaBlack,
                      disabledBackgroundColor: AppColors.socaBlack,
                      foregroundColor: AppColors.socaYellow,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: AppColors.socaYellow),
                          )
                        : const Text(
                            'ADD',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _label(String text) => Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.socaBlack,
        ),
      );

  Widget _textField({
    required TextEditingController controller,
    String? hint,
    ValueChanged<String>? onChanged,
    Widget? suffixWidget,
    String? Function(String?)? validator,
  }) {
    return FormField<String>(
      initialValue: controller.text,
      validator: (_) => validator?.call(controller.text),
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CreateProfileTextField(
            controller: controller,
            hintText: hint,
            suffixWidget: suffixWidget,
            onChanged: (value) {
              field.didChange(value);
              onChanged?.call(value);
            },
          ),
          if (field.hasError)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 4),
              child: Text(
                field.errorText!,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }

  InputDecoration _dropdownDecoration() => InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
      );
}

// ── Shared helper ─────────────────────────────────────────────────────────────

class _GenderRadioTile extends StatelessWidget {
  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const _GenderRadioTile({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;

    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(6),
      child: Row(
        children: [
          Radio<String>(
            // innerRadius: 10.0,
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: AppColors.socaBlack,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: AppColors.socaBlack,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallAvatar extends StatelessWidget {
  final String? imageUrl;
  const _SmallAvatar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final url = (imageUrl != null && imageUrl!.isNotEmpty)
        ? '${ApiConstants.imageBaseUrl}$imageUrl'
        : '';
    return ClipOval(
      child: Container(
        width: 38,
        height: 38,
        color: Colors.grey.shade200,
        child: url.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    const Icon(Icons.person, color: Colors.grey, size: 20),
              )
            : const Icon(Icons.person, color: Colors.grey, size: 20),
      ),
    );
  }
}
