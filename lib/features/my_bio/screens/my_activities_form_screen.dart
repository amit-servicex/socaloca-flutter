import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart' show SharePlus, ShareParams;

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/searchable_dropdown.dart';
import '../../player_bio/providers/player_bio_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

// ── Position data ─────────────────────────────────────────────────────────────

final _positions = ['Goalkeeper', 'Defender', 'Midfield', 'Attack'];

final _positionTypes = {
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

final _gameTypes = ['Football', 'Futsal'];
final _trainTypes = ['Individual', 'One-To-One', 'Group'];

/// My Activities form screen — mirrors Android CommonMyActivitiesFragment.
/// Single screen with radio toggle between My Matches and Training Session.
class MyActivitiesFormScreen extends ConsumerStatefulWidget {
  final String userId;
  final String initialTab; // 'match' or 'training'
  final String? initialGameType;

  MyActivitiesFormScreen({
    super.key,
    required this.userId,
    this.initialTab = 'match',
    this.initialGameType,
  });

  @override
  ConsumerState<MyActivitiesFormScreen> createState() =>
      _MyActivitiesFormScreenState();
}

class _MyActivitiesFormScreenState
    extends ConsumerState<MyActivitiesFormScreen> {
  late String _activeTab; // 'match' or 'training'

  // ── Match form state ──────────────────────────────────────────────────────
  String _gameType = 'Football';
  DateTime? _matchDate;
  String _position = 'Goalkeeper';
  String _positionType = 'Goalkeeper (GK)';
  final _goalsCtrl = TextEditingController();
  final _assistsCtrl = TextEditingController();
  final _minutesCtrl = TextEditingController();
  final _teamACtrl = TextEditingController();
  final _teamBCtrl = TextEditingController();
  int _rating = 0;
  final _notesCtrl = TextEditingController();

  // ── Training form state ───────────────────────────────────────────────────
  DateTime? _trainDate;
  String _trainType = 'Individual';
  final _trainMinutesCtrl = TextEditingController();
  final _trainNotesCtrl = TextEditingController();

  // ── Tagged players (shared by both forms) ────────────────────────────────
  // Each item: {userId, firstName, lastName, imageUrl}
  final List<Map<String, dynamic>> _taggedUsers = [];

  bool _isSubmitting = false;

  bool get _isGoalkeeper => _position == 'Goalkeeper';

  @override
  void initState() {
    super.initState();
    _activeTab = widget.initialTab;
    _gameType = widget.initialGameType ?? 'Football';
  }

  @override
  void dispose() {
    _goalsCtrl.dispose();
    _assistsCtrl.dispose();
    _minutesCtrl.dispose();
    _teamACtrl.dispose();
    _teamBCtrl.dispose();
    _notesCtrl.dispose();
    _trainMinutesCtrl.dispose();
    _trainNotesCtrl.dispose();
    super.dispose();
  }

  // ── Reset ─────────────────────────────────────────────────────────────────

  void _resetMatch() {
    setState(() {
      _gameType = widget.initialGameType ?? 'Football';
      _matchDate = null;
      _position = 'Goalkeeper';
      _positionType = 'Goalkeeper (GK)';
      _rating = 0;
      _taggedUsers.clear();
    });
    _goalsCtrl.clear();
    _assistsCtrl.clear();
    _minutesCtrl.clear();
    _teamACtrl.clear();
    _teamBCtrl.clear();
    _notesCtrl.clear();
  }

  void _resetTraining() {
    setState(() {
      _trainDate = null;
      _trainType = 'Individual';
      _taggedUsers.clear();
    });
    _trainMinutesCtrl.clear();
    _trainNotesCtrl.clear();
  }

  // ── Tag Players ───────────────────────────────────────────────────────────

  void _openTagPlayers() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _TagPlayersSheet(
        userId: widget.userId,
        alreadyTagged: List.from(_taggedUsers),
        onDone: (selected) {
          setState(() {
            _taggedUsers
              ..clear()
              ..addAll(selected);
          });
        },
      ),
    );
  }

  void _removeTag(int index) {
    setState(() => _taggedUsers.removeAt(index));
  }

  // ── Invite Players ────────────────────────────────────────────────────────

  void _invitePlayers() {
    final user = StorageService.currentUser;
    final name =
        '${user?['firstName'] ?? ''} ${user?['lastName'] ?? ''}'.trim();
    SharePlus.instance.share(ShareParams(
      text: '$name is inviting you to join Socaloca! '
          'Download: https://tinyurl.com/yxrtynk4 '
          'or AppStore: https://tinyurl.com/y6yqlovr',
    ));
  }

  void _reset() {
    if (_activeTab == 'match') {
      _resetMatch();
    } else {
      _resetTraining();
    }
  }

  // ── Date pickers ──────────────────────────────────────────────────────────

  Future<void> _pickMatchDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _matchDate ?? now,
      firstDate: DateTime(now.year - 3),
      lastDate: now,
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.socaBlack,
            onPrimary: AppColors.socaYellow,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _matchDate = picked);
  }

  Future<void> _pickTrainDate() async {
    final now = DateTime.now();
    final threeMonthsAgo = DateTime(now.year, now.month - 3, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: _trainDate ?? now,
      firstDate: threeMonthsAgo,
      lastDate: now,
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.socaBlack,
            onPrimary: AppColors.socaYellow,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _trainDate = picked);
  }

  // ── Submit ────────────────────────────────────────────────────────────────

  Future<void> _submitMatch() async {
    if (_matchDate == null) {
      _showError(AppStrings.pleaseSelectMatchDate);
      return;
    }
    if (_rating == 0) {
      _showError(AppStrings.pleaseRateYourPerformance);
      return;
    }
    if (_goalsCtrl.text.trim().isEmpty) {
      _showError(AppStrings.pleaseEnterMatchMetric(_isGoalkeeper
          ? AppStrings.cleanSheetsLower
          : AppStrings.goalsScoredLower));
      return;
    }
    if (_minutesCtrl.text.trim().isEmpty) {
      _showError(AppStrings.pleaseEnterMinutesPlayed);
      return;
    }

    setState(() => _isSubmitting = true);

    final goalsVal = int.tryParse(_goalsCtrl.text.trim()) ?? 0;

    try {
      final success = await ref
          .read(playerBioProvider(widget.userId).notifier)
          .addMatchActivity(
            gameType: _gameType,
            matchDate: DateFormat('yyyy-MM-dd').format(_matchDate!),
            matchMonth: _matchDate!.month,
            matchYear: _matchDate!.year,
            matchMonthStr: DateFormat('dd-MMM-yyyy').format(_matchDate!),
            goals: _isGoalkeeper ? 0 : goalsVal,
            goalSaved: _isGoalkeeper ? goalsVal : 0,
            assists: int.tryParse(_assistsCtrl.text.trim()) ?? 0,
            playPosition: _position,
            playPositionType: _positionType,
            minutes: int.tryParse(_minutesCtrl.text.trim()) ?? 0,
            myTeamName: _teamACtrl.text.trim(),
            opponentTeamName: _teamBCtrl.text.trim(),
            rating: _rating,
            notes: _notesCtrl.text.trim(),
            tagged: _taggedUsers
                .asMap()
                .entries
                .map((e) => {'seq': e.key + 1, 'userId': e.value['userId']})
                .toList(),
          );
      if (mounted) {
        if (success) {
          _showSuccess(AppStrings.matchActivityAdded);
          _resetMatch();
        } else {
          _showError(AppStrings.failedToAddMatch);
        }
      }
    } catch (e) {
      if (mounted) _showError(e.toString());
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _submitTraining() async {
    if (_trainDate == null) {
      _showError(AppStrings.pleaseSelectTrainingDate);
      return;
    }
    if (_trainMinutesCtrl.text.trim().isEmpty) {
      _showError(AppStrings.pleaseEnterTrainingMinutes);
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final success = await ref
          .read(playerBioProvider(widget.userId).notifier)
          .addTrainingActivity(
            trainType: _trainType.toLowerCase().replaceAll('-to-', '-to-'),
            trainDate: DateFormat('yyyy-MM-dd').format(_trainDate!),
            trainMonth: _trainDate!.month,
            trainYear: _trainDate!.year,
            trainMonthStr: DateFormat('dd-MMM-yyyy').format(_trainDate!),
            minutes: int.tryParse(_trainMinutesCtrl.text.trim()) ?? 0,
            notes: _trainNotesCtrl.text.trim(),
            tagged: _taggedUsers
                .asMap()
                .entries
                .map((e) => {'seq': e.key + 1, 'userId': e.value['userId']})
                .toList(),
          );
      if (mounted) {
        if (success) {
          _showSuccess(AppStrings.trainingSessionAdded);
          _resetTraining();
        } else {
          _showError(AppStrings.failedToAddTraining);
        }
      }
    } catch (e) {
      if (mounted) _showError(e.toString());
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _showSuccess(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.green,
    ));
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      // appBar: AppBar(
      //   backgroundColor: AppColors.socaPageBg,
      //   elevation: 0,
      //   leadingWidth: 100,
      //   leading: Row(
      //     children: [
      //       SizedBox(width: 8),
      //       GestureDetector(
      //         onTap: () => Navigator.pop(context),
      //         child: Icon(Icons.arrow_back_ios_new,
      //             color: AppColors.socaBlack, size: 20),
      //       ),
      //       SizedBox(width: 8),
      //       Text(
      //         'My Bio',
      //         style: TextStyle(
      //           fontFamily: 'Poppins',
      //           fontSize: 16,
      //           fontWeight: FontWeight.w600,
      //           color: AppColors.socaBlack,
      //         ),
      //       ),
      //     ],
      //   ),
      //   title: Image.asset(
      //     'assets/images/logo.png',
      //     height: 35,
      //     errorBuilder: (_, __, ___) =>
      //         Icon(Icons.sports_soccer, color: AppColors.socaBlack),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       icon:
      //           Icon(Icons.search, color: AppColors.socaBlack, size: 24),
      //       onPressed: () {},
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.notifications_none,
      //           color: AppColors.socaBlack, size: 24),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 16),
              _buildRadioToggle(),
              SizedBox(height: 20),
              if (_activeTab == 'match') _buildMatchForm(),
              if (_activeTab == 'training') _buildTrainingForm(),
              SizedBox(height: 20),
              _buildTagSection(),
              SizedBox(height: 24),
              _buildSubmitButton(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header card ───────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.socaBlack,
          ),
          child: Text(
            AppStrings.myActivities,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.socaYellow,
            ),
          ),
        ),
        SizedBox(height: 12),
        Text(
          AppStrings.myActivitiesDescription,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.socaBlack,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // ── Radio toggle ──────────────────────────────────────────────────────────

  Widget _buildRadioToggle() {
    return Row(
      children: [
        _RadioOption(
          label: AppStrings.myMatches,
          selected: _activeTab == 'match',
          onTap: () => setState(() => _activeTab = 'match'),
        ),
        SizedBox(width: 24),
        _RadioOption(
          label: AppStrings.trainingSession,
          selected: _activeTab == 'training',
          onTap: () => setState(() => _activeTab = 'training'),
        ),
      ],
    );
  }

  // ── Match form ────────────────────────────────────────────────────────────

  Widget _buildMatchForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Game Type
        _FormLabel(AppStrings.gameTypeLabel),
        SizedBox(height: 6),
        _DropdownField<String>(
          value: _gameType,
          items: _gameTypes,
          onChanged: (v) => setState(() => _gameType = v!),
        ),
        SizedBox(height: 14),

        // Match Date
        _FormLabel(AppStrings.matchDateLabel),
        SizedBox(height: 6),
        _DateField(
          date: _matchDate,
          hint: AppStrings.selectDate,
          onTap: _pickMatchDate,
        ),
        SizedBox(height: 14),

        // Playing Position
        _FormLabel(AppStrings.playingPositionLabel),
        SizedBox(height: 6),
        _DropdownField<String>(
          value: _position,
          items: _positions,
          onChanged: (v) {
            setState(() {
              _position = v!;
              _positionType = _positionTypes[_position]!.first;
            });
          },
        ),
        SizedBox(height: 14),

        // Position Type
        _FormLabel(AppStrings.positionTypeLabel),
        SizedBox(height: 6),
        _DropdownField<String>(
          value: _positionType,
          items: _positionTypes[_position]!,
          onChanged: (v) => setState(() => _positionType = v!),
        ),
        SizedBox(height: 14),

        // Goals / Clean Sheet
        _FormLabel(_isGoalkeeper
            ? AppStrings.cleanSheetRequiredLower
            : AppStrings.goalsScoredRequiredLower),
        SizedBox(height: 6),
        _NumberInput(controller: _goalsCtrl),
        SizedBox(height: 14),

        // Assists
        _FormLabel(AppStrings.numberOfAssistsLabel),
        SizedBox(height: 6),
        _NumberInput(controller: _assistsCtrl),
        SizedBox(height: 14),

        // Minutes
        _FormLabel(AppStrings.minutesPlayedLabel),
        SizedBox(height: 6),
        _NumberInput(controller: _minutesCtrl),
        SizedBox(height: 14),

        // Teams
        _FormLabel(AppStrings.teamsPlayedLabel),
        SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: _TextInput(
                controller: _teamACtrl,
                hint: AppStrings.teamA,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                AppStrings.vs,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.socaBlack,
                ),
              ),
            ),
            Expanded(
              child: _TextInput(
                controller: _teamBCtrl,
                hint: AppStrings.teamB,
              ),
            ),
          ],
        ),
        SizedBox(height: 14),

        // Rating
        _FormLabel(AppStrings.rateYourPerformanceLabel),
        SizedBox(height: 10),
        _RatingSelector(
          selected: _rating,
          onSelect: (v) => setState(() => _rating = v),
        ),
        SizedBox(height: 14),

        // Notes
        _FormLabel(AppStrings.howIPerformedLabel),
        SizedBox(height: 6),
        _NotesInput(
          controller: _notesCtrl,
          maxLength: 150,
        ),
      ],
    );
  }

  // ── Training form ─────────────────────────────────────────────────────────

  Widget _buildTrainingForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Training Date
        _FormLabel(AppStrings.trainingSessionDateLabel),
        SizedBox(height: 6),
        _DateField(
          date: _trainDate,
          hint: AppStrings.selectDate,
          onTap: _pickTrainDate,
        ),
        SizedBox(height: 14),

        // Training Type
        _FormLabel(AppStrings.trainingSessionTypeLabel),
        SizedBox(height: 6),
        _DropdownField<String>(
          value: _trainType,
          items: _trainTypes,
          onChanged: (v) => setState(() => _trainType = v!),
        ),
        SizedBox(height: 14),

        // Minutes
        _FormLabel(AppStrings.trainingSessionMinutesLabel),
        SizedBox(height: 6),
        _NumberInput(controller: _trainMinutesCtrl),
        SizedBox(height: 14),

        // Notes
        _FormLabel(AppStrings.trainingNotesLabel),
        SizedBox(height: 6),
        _NotesInput(
          controller: _trainNotesCtrl,
          maxLength: 150,
        ),
      ],
    );
  }

  // ── Tag section (TAG PLAYERS / INVITE PLAYERS + chips) ───────────────────

  Widget _buildTagSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Button row
        Row(
          children: [
            // TAG PLAYERS — outlined black border, white bg
            Expanded(
              child: OutlinedButton(
                onPressed: _openTagPlayers,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.socaBlack,
                  side: BorderSide(color: AppColors.socaBlack),
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  AppStrings.tagPlayersUpper,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                AppStrings.or,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: AppColors.socaBlack,
                ),
              ),
            ),
            // INVITE PLAYERS — filled black, yellow text
            Expanded(
              child: ElevatedButton(
                onPressed: _invitePlayers,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaBlack,
                  foregroundColor: AppColors.socaYellow,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  AppStrings.invitePlayersUpper,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),

        // Tagged user chips
        if (_taggedUsers.isNotEmpty) ...[
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _taggedUsers.asMap().entries.map((entry) {
              final idx = entry.key;
              final user = entry.value;
              final name =
                  '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}'.trim();
              return _TagChip(
                name: name,
                imageUrl: user['imageUrl'] as String?,
                onRemove: () => _removeTag(idx),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  // ── Submit button ─────────────────────────────────────────────────────────

  Widget _buildSubmitButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _isSubmitting
                    ? null
                    : (_activeTab == 'match' ? _submitMatch : _submitTraining),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaBlack,
                  foregroundColor: AppColors.socaYellow,
                  disabledBackgroundColor: AppColors.socaGrey,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: _isSubmitting
                    ? AppLoader(size: 24, centered: false)
                    : Text(
                        AppStrings.add.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _reset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaBlack,
                  foregroundColor: AppColors.socaYellow,
                  disabledBackgroundColor: AppColors.socaGrey,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  AppStrings.resetUpper,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          AppStrings.mandatoryFields,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10,
            color: AppColors.socaBlack,
          ),
        ),
      ],
    );
  }
}

// ── Reusable form widgets ─────────────────────────────────────────────────────

class _RadioOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  _RadioOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.socaBlack : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: AppColors.socaBlack,
              ),
            ),
          ],
        ),
      );
}

class _FormLabel extends StatelessWidget {
  final String text;
  _FormLabel(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.socaBlack,
        ),
      );
}

class _DropdownField<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  _DropdownField({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final strItems = items.map((e) => e.toString()).toList();
    final strValue = value.toString();
    return SearchableDropdownButton(
      hint: strValue,
      border: Border.all(color: AppColors.socaBlack),
      fillColor: Colors.transparent,
      value: strValue,
      height: 50,
      radious: 0,
      items: strItems,
      onChanged: (v) {
        if (v == null) return;
        final idx = strItems.indexOf(v);
        if (idx >= 0) onChanged(items[idx]);
      },
      fontSize: 13,
    );
  }
}

class _DateField extends StatelessWidget {
  final DateTime? date;
  final String hint;
  final VoidCallback onTap;

  _DateField({
    required this.date,
    required this.hint,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: AppColors.socaBlack),
            borderRadius: BorderRadius.zero,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  date != null ? DateFormat('dd-MM-yyyy').format(date!) : hint,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: date != null
                        ? AppColors.socaBlack
                        : Colors.grey.shade400,
                  ),
                ),
              ),
              Image.asset(
                "assets/icons/ic_calendar_old.png",
                width: 32,
                height: 32,
              )
            ],
          ),
        ),
      );
}

class _NumberInput extends StatelessWidget {
  final TextEditingController controller;

  _NumberInput({required this.controller});

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.socaBlack),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.socaBlack),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.socaBlack),
          ),
        ),
      );
}

class _TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  _TextInput({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              fontFamily: 'Poppins', fontSize: 13, color: Colors.grey.shade400),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.socaBlack),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.socaBlack),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.socaBlack),
          ),
        ),
      );
}

class _NotesInput extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;

  _NotesInput({required this.controller, required this.maxLength});

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        maxLines: 5,
        maxLength: maxLength,
        style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.all(14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.socaBlack),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.socaBlack),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.socaBlack),
          ),
          counterStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10,
            color: AppColors.socaBlack,
          ),
        ),
      );
}

class _RatingSelector extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;

  _RatingSelector({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(10, (i) {
          final val = i + 1;
          final isSelected = selected == val;
          return GestureDetector(
            onTap: () => onSelect(val),
            child: Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        isSelected ? AppColors.socaBlack : Colors.transparent,
                    border: Border.all(
                      color: AppColors.socaBlack,
                      width: 2.5,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: Icon(Icons.check,
                              size: 14, color: AppColors.socaYellow),
                        )
                      : null,
                ),
                SizedBox(height: 4),
                Text(
                  '$val',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: AppColors.socaBlack,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        }),
      );
}

// ── Tagged user chip ──────────────────────────────────────────────────────────

class _TagChip extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final VoidCallback onRemove;

  _TagChip({
    required this.name,
    this.imageUrl,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.socaGrey,
              backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
                  ? NetworkImage(imageUrl!)
                  : null,
              child: (imageUrl == null || imageUrl!.isEmpty)
                  ? Icon(Icons.person, size: 12, color: Colors.grey)
                  : null,
            ),
            SizedBox(width: 6),
            Text(
              name.isEmpty ? AppStrings.userFallback : name,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                color: AppColors.socaBlack,
              ),
            ),
            SizedBox(width: 4),
            GestureDetector(
              onTap: onRemove,
              child: Icon(Icons.close, size: 14, color: AppColors.socaGrey),
            ),
          ],
        ),
      );
}

// ── Tag Players search bottom sheet ──────────────────────────────────────────

class _TagPlayersSheet extends ConsumerStatefulWidget {
  final String userId;
  final List<Map<String, dynamic>> alreadyTagged;
  final ValueChanged<List<Map<String, dynamic>>> onDone;

  _TagPlayersSheet({
    required this.userId,
    required this.alreadyTagged,
    required this.onDone,
  });

  @override
  ConsumerState<_TagPlayersSheet> createState() => _TagPlayersSheetState();
}

class _TagPlayersSheetState extends ConsumerState<_TagPlayersSheet> {
  final _searchCtrl = TextEditingController();
  final List<Map<String, dynamic>> _results = [];
  final List<Map<String, dynamic>> _selected = [];
  bool _isLoading = false;
  int _start = 0;
  static int _limit = 25;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    // Pre-populate already tagged
    _selected.addAll(widget.alreadyTagged);
    _searchCtrl.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchCtrl.removeListener(_onSearchChanged);
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_searchCtrl.text.trim().length >= 2) {
      _start = 0;
      _hasMore = true;
      _results.clear();
      _search();
    } else if (_searchCtrl.text.trim().isEmpty) {
      setState(() => _results.clear());
    }
  }

  Future<void> _search() async {
    if (_isLoading || !_hasMore) return;
    setState(() => _isLoading = true);
    try {
      final response = await ApiClient.instance.post(
        ApiConstants.tagUserSearch,
        body: {
          'userId': StorageService.userId ?? '',
          'searchText': _searchCtrl.text.trim(),
          'start': _start,
          'limit': _limit,
        },
      );
      final raw = response['response']?['result'] as List? ?? [];
      final users = raw.cast<Map<String, dynamic>>();
      setState(() {
        _results.addAll(users);
        _start += users.length;
        if (users.length < _limit) _hasMore = false;
      });
    } catch (_) {}
    if (mounted) setState(() => _isLoading = false);
  }

  bool _isSelected(String userId) =>
      _selected.any((u) => u['userId'] == userId);

  void _toggle(Map<String, dynamic> user) {
    final uid = user['userId'] as String? ?? '';
    setState(() {
      if (_isSelected(uid)) {
        _selected.removeWhere((u) => u['userId'] == uid);
      } else {
        _selected.add({
          'userId': uid,
          'firstName': user['firstName'] ?? '',
          'lastName': user['lastName'] ?? '',
          'imageUrl': user['imageUrl'] ?? '',
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (ctx, scrollCtrl) => Column(
        children: [
          // Handle
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.socaGrey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.tagPlayers,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onDone(List.from(_selected));
                    Navigator.pop(ctx);
                  },
                  child: Text(
                    AppStrings.done,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaYellow,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchCtrl,
              autofocus: true,
              style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
              decoration: InputDecoration(
                hintText: AppStrings.searchByNameMinTwoCharacters,
                hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.grey.shade400),
                prefixIcon: Icon(Icons.search, size: 20),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Divider(height: 1),

          // Results list
          Expanded(
            child: _results.isEmpty && !_isLoading
                ? Center(
                    child: Text(
                      _searchCtrl.text.length < 2
                          ? AppStrings.typeToSearchPlayers
                          : AppStrings.noPlayersFound,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: AppColors.socaGrey,
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: scrollCtrl,
                    itemCount: _results.length + (_isLoading ? 1 : 0),
                    itemBuilder: (_, i) {
                      if (i == _results.length) {
                        return Padding(
                          padding: EdgeInsets.all(16),
                          child: AppLoader(),
                        );
                      }
                      final user = _results[i];
                      final uid = user['userId'] as String? ?? '';
                      final name =
                          '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}'
                              .trim();
                      final imageUrl = user['imageUrl'] as String?;
                      final sel = _isSelected(uid);
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage:
                              (imageUrl != null && imageUrl.isNotEmpty)
                                  ? NetworkImage(imageUrl)
                                  : null,
                          child: (imageUrl == null || imageUrl.isEmpty)
                              ? Icon(Icons.person, color: Colors.grey)
                              : null,
                        ),
                        title: Text(
                          name.isEmpty ? AppStrings.unknown : name,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: user['playPosition'] != null
                            ? Text(
                                user['playPosition'].toString(),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11,
                                  color: AppColors.socaGrey,
                                ),
                              )
                            : null,
                        trailing: sel
                            ? Icon(Icons.check_circle,
                                color: AppColors.socaBlack)
                            : Icon(Icons.radio_button_unchecked,
                                color: Colors.grey.shade400),
                        onTap: () => _toggle(user),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
