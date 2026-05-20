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

  AddMatchActivitySheet({
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
          colorScheme: ColorScheme.light(
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
      _showError('Please select a match date');
      return;
    }
    if (_position == null) {
      _showError('Please select a playing position');
      return;
    }
    if (_positionType == null) {
      _showError('Please select a position type');
      return;
    }
    if (_rating == 0) {
      _showError('Please rate your performance');
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
        SnackBar(content: Text('Match details added'.tr)),
      );
      Navigator.of(context).pop(true);
    } else {
      _showError('Failed to add match. Please try again.');
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
              margin: EdgeInsets.symmetric(vertical: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.socaGrey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // ── Title ────────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add ${widget.gameType} Match',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Divider(height: 1),
            // ── Form ─────────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                controller: scrollCtrl,
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Match Date
                      _SectionLabel('Match Date *'),
                      _DateField(
                        date: _selectedDate,
                        placeholder: 'Select match date',
                        onTap: _pickDate,
                        formatter: _formatDateDisplay,
                      ),
                      SizedBox(height: 16),

                      // Playing Position
                      _SectionLabel('Playing Position *'),
                      _Dropdown<String>(
                        value: _position,
                        hint: 'Select playing position',
                        items: _positions,
                        itemLabel: (v) => v,
                        onChanged: (v) => setState(() {
                          final _position = v;
                          final _positionType = null;
                        }),
                      ),
                      SizedBox(height: 16),

                      // Position Type
                      if (_position != null) ...[
                        _SectionLabel('Position Type *'),
                        _Dropdown<String>(
                          value: _positionType,
                          hint: 'Select position type',
                          items: positionTypes,
                          itemLabel: (v) => v,
                          onChanged: (v) => setState(() => _positionType = v),
                        ),
                        SizedBox(height: 16),
                      ],

                      // Goals / Goal Saved
                      _SectionLabel(
                          _isGoalkeeper ? 'Goals Saved *' : 'Goals Scored *'),
                      _NumberField(
                        controller: _goalsCtrl,
                        hint: _isGoalkeeper ? 'e.g. 3' : 'e.g. 2',
                        label: _isGoalkeeper ? 'Goals saved' : 'Goals scored',
                      ),
                      SizedBox(height: 16),

                      // Assists
                      _SectionLabel('Number of Assists *'),
                      _NumberField(
                        controller: _assistsCtrl,
                        hint: 'e.g. 1',
                        label: 'Assists',
                      ),
                      SizedBox(height: 16),

                      // Minutes Played
                      _SectionLabel('Minutes Played *'),
                      _NumberField(
                        controller: _minutesCtrl,
                        hint: 'e.g. 90',
                        label: 'Minutes played',
                      ),
                      SizedBox(height: 16),

                      // My Team Name
                      _SectionLabel('My Team Name *'),
                      _TextField(
                        controller: _myTeamCtrl,
                        hint: 'Enter your team name',
                        label: 'Team name',
                      ),
                      SizedBox(height: 16),

                      // Opponent Team Name
                      _SectionLabel('Opponent Team Name *'),
                      _TextField(
                        controller: _opponentCtrl,
                        hint: 'Enter opponent team name',
                        label: 'Opponent team name',
                      ),
                      SizedBox(height: 16),

                      // Rate Performance 1–10
                      _SectionLabel('Rate Your Performance (1–10) *'),
                      SizedBox(height: 8),
                      _RatingRow(
                        value: _rating,
                        onChanged: (v) => setState(() => _rating = v),
                      ),
                      SizedBox(height: 16),

                      // Notes
                      _SectionLabel('How I Performed (optional)'),
                      _NotesField(controller: _notesCtrl),
                      SizedBox(height: 24),

                      // Submit button
                      AppLoader(size: 24, centered: false),
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
  _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: 6),
        child: Text(
          text,
          style: TextStyle(
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

  _DateField({
    required this.date,
    required this.placeholder,
    required this.onTap,
    required this.formatter,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
              Icon(Icons.calendar_today_outlined,
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

  _Dropdown({
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

  _NumberField({
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
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        validator: (v) =>
            (v == null || v.trim().isEmpty) ? 'Enter $label' : null,
        style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
      );
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;

  _TextField({
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
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        validator: (v) =>
            (v == null || v.trim().isEmpty) ? 'Enter $label' : null,
        style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
      );
}

class _NotesField extends StatelessWidget {
  final TextEditingController controller;

  _NotesField({required this.controller});

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: 'Describe how you performed...'.tr,
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            color: Colors.grey.shade400,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
      );
}

class _RatingRow extends StatelessWidget {
  final int value;
  final void Function(int) onChanged;

  _RatingRow({required this.value, required this.onChanged});

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
