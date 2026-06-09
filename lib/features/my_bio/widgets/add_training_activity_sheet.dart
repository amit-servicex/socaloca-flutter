import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/searchable_dropdown.dart';
import '../../player_bio/providers/player_bio_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Bottom sheet for adding a training session activity.
/// Mirrors Android's CommonMyActivitiesFragment training tab.
class AddTrainingActivitySheet extends ConsumerStatefulWidget {
  final String userId;

  AddTrainingActivitySheet({super.key, required this.userId});

  @override
  ConsumerState<AddTrainingActivitySheet> createState() =>
      _AddTrainingActivitySheetState();
}

class _AddTrainingActivitySheetState
    extends ConsumerState<AddTrainingActivitySheet> {
  final _formKey = GlobalKey<FormState>();
  final _minutesCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  DateTime? _selectedDate;
  String? _trainType;
  bool _isSubmitting = false;

  static final _trainTypes = ['Individual', 'One-To-One', 'Group'];
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
    _minutesCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

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

  String _formatDisplay(DateTime d) => '${d.day.toString().padLeft(2, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.year}';

  String _formatApi(DateTime d) => '${d.day.toString().padLeft(2, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.year}';

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null) {
      _showError(AppStrings.pleaseSelectTrainingDate);
      return;
    }
    if (_trainType == null) {
      _showError(AppStrings.pleaseSelectTrainingType);
      return;
    }

    setState(() => _isSubmitting = true);

    final minutes = int.tryParse(_minutesCtrl.text.trim()) ?? 0;
    final d = _selectedDate!;
    final monthStr = _monthNames[d.month - 1];

    final success = await ref
        .read(playerBioProvider(widget.userId).notifier)
        .addTrainingActivity(
          trainType: _trainType!,
          trainDate: _formatApi(d),
          trainMonth: d.month,
          trainYear: d.year,
          trainMonthStr: monthStr,
          minutes: minutes,
          notes: _notesCtrl.text.trim(),
        );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.trainingSessionAdded)),
      );
      Navigator.of(context).pop(true);
    } else {
      _showError(AppStrings.failedToAddTraining);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.65,
        minChildSize: 0.4,
        maxChildSize: 0.9,
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
                    AppStrings.addTrainingSession,
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
                      // Training Date
                      _label(AppStrings.trainingDateLabel),
                      _DatePicker(
                        date: _selectedDate,
                        placeholder: AppStrings.selectTrainingDate,
                        onTap: _pickDate,
                        formatter: _formatDisplay,
                      ),
                      SizedBox(height: 16),

                      // Training Type
                      _label(AppStrings.trainingTypeLabel),
                      _DropdownField(
                        value: _trainType,
                        hint: AppStrings.selectTrainingType,
                        items: _trainTypes,
                        onChanged: (v) => setState(() => _trainType = v),
                      ),
                      SizedBox(height: 16),

                      // Minutes
                      _label(AppStrings.trainingMinutesLabel),
                      TextFormField(
                        controller: _minutesCtrl,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: _inputDecoration(AppStrings.egSixty),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? AppStrings.enterTrainingMinutes
                            : null,
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                      ),
                      SizedBox(height: 16),

                      // Notes
                      _label(AppStrings.notesOptionalLabel),
                      TextFormField(
                        controller: _notesCtrl,
                        maxLines: 3,
                        decoration: _inputDecoration(
                            AppStrings.describeTrainingSession),
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                      ),
                      SizedBox(height: 24),

                      // Submit
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

  Widget _label(String text) => Padding(
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

  InputDecoration _inputDecoration(String hint) => InputDecoration(
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
      );
}

class _DatePicker extends StatelessWidget {
  final DateTime? date;
  final String placeholder;
  final VoidCallback onTap;
  final String Function(DateTime) formatter;

  _DatePicker({
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

class _DropdownField extends StatelessWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final void Function(String?) onChanged;

  _DropdownField({
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => SearchableDropdownButton(
        hint: hint,
        value: value,
        items: items,
        onChanged: onChanged,
        fontSize: 13,
      );
}
