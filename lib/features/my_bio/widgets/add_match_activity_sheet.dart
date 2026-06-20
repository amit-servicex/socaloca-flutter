import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/searchable_dropdown.dart';
import '../../player_bio/providers/player_bio_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Bottom sheet for adding a match activity (Football or Futsal).
/// Mirrors Android's CommonMyActivitiesFragment match tab.
class AddMatchActivitySheet extends ConsumerStatefulWidget {
  final String userId;
  final String gameType; // 'Football' or 'Futsal'

  const AddMatchActivitySheet({
    super.key,
    required this.userId,
    required this.gameType,
  });

  @override
  ConsumerState<AddMatchActivitySheet> createState() =>
      _AddMatchActivitySheetState();
}

class _AddMatchActivitySheetState extends ConsumerState<AddMatchActivitySheet> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _goalsCtrl = TextEditingController();
  final _assistsCtrl = TextEditingController();
  final _minutesCtrl = TextEditingController();
  final _myTeamCtrl = TextEditingController();
  final _opponentCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  DateTime? _selectedDate;
  String? _position; // Goalkeeper / Defender / Midfield / Attack
  String? _positionType;
  int _rating = 0;
  bool _isSubmitting = false;

  static final _positions = ['Goalkeeper', 'Defender', 'Midfield', 'Attack'];
  static final _positionTypes = {
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

  static final _monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  void dispose() {
    _goalsCtrl.dispose();
    _assistsCtrl.dispose();
    _minutesCtrl.dispose();
    _myTeamCtrl.dispose();
    _opponentCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  bool get _isGoalkeeper => _position == 'Goalkeeper';

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.socaBlack,
            onPrimary: AppColors.socaYellow,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  String _formatDateDisplay(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.year}';

  String _formatDateApi(DateTime d) => '${d.day.toString().padLeft(2, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.year}';

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null) {
      _showError(AppStrings.pleaseSelectMatchDate);
      return;
    }
    if (_position == null) {
      _showError(AppStrings.pleaseSelectPlayingPosition);
      return;
    }
    if (_positionType == null) {
      _showError(AppStrings.pleaseSelectPositionType);
      return;
    }
    if (_rating == 0) {
      _showError(AppStrings.pleaseRateYourPerformance);
      return;
    }

    setState(() => _isSubmitting = true);

    final goals = int.tryParse(_goalsCtrl.text.trim()) ?? 0;
    final assists = int.tryParse(_assistsCtrl.text.trim()) ?? 0;
    final minutes = int.tryParse(_minutesCtrl.text.trim()) ?? 0;
    final d = _selectedDate!;
    final monthStr = _monthNames[d.month - 1];

    final success = await ref
        .read(playerBioProvider(widget.userId).notifier)
        .addMatchActivity(
          gameType: widget.gameType,
          matchDate: _formatDateApi(d),
          matchMonth: d.month,
          matchYear: d.year,
          matchMonthStr: monthStr,
          goals: _isGoalkeeper ? 0 : goals,
          goalSaved: _isGoalkeeper ? goals : 0,
          assists: assists,
          playPosition: _position!,
          playPositionType: _positionType!,
          minutes: minutes,
          myTeamName: _myTeamCtrl.text.trim(),
          opponentTeamName: _opponentCtrl.text.trim(),
          rating: _rating,
          notes: _notesCtrl.text.trim(),
        );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.matchDetailsAdded)),
      );
      Navigator.of(context).pop(true);
    } else {
      _showError(AppStrings.failedToAddMatch);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    final positionTypes =
        _position != null ? (_positionTypes[_position!] ?? []) : <String>[];

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.92,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, scrollCtrl) => Column(
          children: [
            // ── Handle ──────────────────────────────────────────────────
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.socaGrey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // ── Title ────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.addGameTypeMatch(widget.gameType),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // ── Form ─────────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                controller: scrollCtrl,
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Match Date
                      _SectionLabel(AppStrings.matchDateLabel),
                      _DateField(
                        date: _selectedDate,
                        placeholder: AppStrings.selectMatchDate,
                        onTap: _pickDate,
                        formatter: _formatDateDisplay,
                      ),
                      const SizedBox(height: 16),

                      // Playing Position
                      _SectionLabel(AppStrings.playingPositionLabel),
                      _Dropdown<String>(
                        value: _position,
                        hint: AppStrings.selectPlayingPosition,
                        items: _positions,
                        itemLabel: (v) => v,
                        onChanged: (v) => setState(() {
                          final position = v;
                          const positionType = null;
                        }),
                      ),
                      const SizedBox(height: 16),

                      // Position Type
                      if (_position != null) ...[
                        _SectionLabel(AppStrings.positionTypeLabel),
                        _Dropdown<String>(
                          value: _positionType,
                          hint: AppStrings.selectPositionType,
                          items: positionTypes,
                          itemLabel: (v) => v,
                          onChanged: (v) => setState(() => _positionType = v),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Goals / Goal Saved
                      _SectionLabel(_isGoalkeeper
                          ? AppStrings.goalsSavedRequired
                          : AppStrings.goalsScoredRequired),
                      _NumberField(
                        controller: _goalsCtrl,
                        hint: _isGoalkeeper
                            ? AppStrings.egThree
                            : AppStrings.egTwo,
                        label: _isGoalkeeper
                            ? AppStrings.goalsSaved
                            : AppStrings.goalScored,
                      ),
                      const SizedBox(height: 16),

                      // Assists
                      _SectionLabel(AppStrings.numberOfAssistsLabel),
                      _NumberField(
                        controller: _assistsCtrl,
                        hint: AppStrings.egOne,
                        label: AppStrings.assists,
                      ),
                      const SizedBox(height: 16),

                      // Minutes Played
                      _SectionLabel(AppStrings.minutesPlayedLabel),
                      _NumberField(
                        controller: _minutesCtrl,
                        hint: AppStrings.egNinety,
                        label: AppStrings.minutesPlayedLabel,
                      ),
                      const SizedBox(height: 16),

                      // My Team Name
                      _SectionLabel(AppStrings.myTeamNameLabel),
                      _TextField(
                        controller: _myTeamCtrl,
                        hint: AppStrings.enterYourTeamName,
                        label: AppStrings.teamName,
                      ),
                      const SizedBox(height: 16),

                      // Opponent Team Name
                      _SectionLabel(AppStrings.opponentTeamNameLabel),
                      _TextField(
                        controller: _opponentCtrl,
                        hint: AppStrings.enterOpponentTeamName,
                        label: AppStrings.opponentTeamName,
                      ),
                      const SizedBox(height: 16),

                      // Rate Performance 1–10
                      _SectionLabel(AppStrings.rateYourPerformanceLabel),
                      const SizedBox(height: 8),
                      _RatingRow(
                        value: _rating,
                        onChanged: (v) => setState(() => _rating = v),
                      ),
                      const SizedBox(height: 16),

                      // Notes
                      _SectionLabel(AppStrings.howIPerformedLabel),
                      _NotesField(controller: _notesCtrl),
                      const SizedBox(height: 24),

                      // Submit button
                      const AppLoader(size: 24, centered: false),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Shared small helper widgets ──────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.socaBlack,
          ),
        ),
      );
}

class _DateField extends StatelessWidget {
  final DateTime? date;
  final String placeholder;
  final VoidCallback onTap;
  final String Function(DateTime) formatter;

  const _DateField({
    required this.date,
    required this.placeholder,
    required this.onTap,
    required this.formatter,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  date != null ? formatter(date!) : placeholder,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: date != null
                        ? AppColors.socaBlack
                        : Colors.grey.shade400,
                  ),
                ),
              ),
              const Icon(Icons.calendar_today_outlined,
                  size: 18, color: AppColors.socaGrey),
            ],
          ),
        ),
      );
}

class _Dropdown<T> extends StatelessWidget {
  final T? value;
  final String hint;
  final List<T> items;
  final String Function(T) itemLabel;
  final void Function(T?) onChanged;

  const _Dropdown({
    required this.value,
    required this.hint,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final labels = items.map(itemLabel).toList();
    final strValue = value != null ? itemLabel(value as T) : null;
    return SearchableDropdownButton(
      hint: hint,
      value: strValue,
      items: labels,
      onChanged: (v) {
        if (v == null) return;
        final idx = labels.indexOf(v);
        if (idx >= 0) onChanged(items[idx]);
      },
      fontSize: 13,
    );
  }
}

class _NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;

  const _NumberField({
    required this.controller,
    required this.hint,
    required this.label,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            color: Colors.grey.shade400,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        validator: (v) => (v == null || v.trim().isEmpty)
            ? AppStrings.enterField(label)
            : null,
        style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
      );
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;

  const _TextField({
    required this.controller,
    required this.hint,
    required this.label,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            color: Colors.grey.shade400,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        validator: (v) => (v == null || v.trim().isEmpty)
            ? AppStrings.enterField(label)
            : null,
        style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
      );
}

class _NotesField extends StatelessWidget {
  final TextEditingController controller;

  const _NotesField({required this.controller});

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: AppStrings.describeHowYouPerformed,
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            color: Colors.grey.shade400,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
      );
}

class _RatingRow extends StatelessWidget {
  final int value;
  final void Function(int) onChanged;

  const _RatingRow({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(10, (i) {
          final n = i + 1;
          final selected = value == n;
          return GestureDetector(
            onTap: () => onChanged(n),
            child: Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColors.socaBlack : Colors.transparent,
                border: Border.all(
                  color: selected ? AppColors.socaBlack : Colors.grey.shade400,
                  width: 1.5,
                ),
              ),
              child: Text(
                '$n',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected ? AppColors.socaYellow : AppColors.socaBlack,
                ),
              ),
            ),
          );
        }),
      );
}
