import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../data/repositories/pickup_match_repository.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';
import '../../../shared/widgets/searchable_dropdown.dart';

/// Host Pickup Match Screen - Form to create a new pickup match
/// Mirrors Android PickUpHostMatchFragment
class HostPickupMatchScreen extends ConsumerStatefulWidget {
  HostPickupMatchScreen({super.key});

  @override
  ConsumerState<HostPickupMatchScreen> createState() =>
      _HostPickupMatchScreenState();
}

class _HostPickupMatchScreenState extends ConsumerState<HostPickupMatchScreen> {
  final _formKey = GlobalKey<FormState>();
  final _venueController = TextEditingController();
  final _locationController = TextEditingController();
  final _maxPlayersController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _selectedAgeGroup;
  String _selectedGender = 'Mixed';
  String _selectedGameType = 'Football';
  double _locationLat = 0.0;
  double _locationLng = 0.0;
  bool _isSubmitting = false;

  final List<String> _ageGroups = [
    '<10',
    '<12',
    '<15',
    '<18',
    '<20',
    '21-30',
    '31-40',
    '>40'
  ];

  @override
  void dispose() {
    _venueController.dispose();
    _locationController.dispose();
    _maxPlayersController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.socaYellow,
              onPrimary: AppColors.socaBlack,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.socaYellow,
              onPrimary: AppColors.socaBlack,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _startTime = picked);
    }
  }

  Future<void> _pickEndTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.socaYellow,
              onPrimary: AppColors.socaBlack,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _endTime = picked);
    }
  }

  void _pickLocation() {
    // Open location picker screen
    context.push<Map<String, dynamic>>(AppRoutes.locationPicker).then((result) {
      if (result != null && mounted) {
        setState(() {
          _locationController.text = result['placeName'] as String? ?? '';
          _locationLat = (result['placeLat'] as num?)?.toDouble() ?? 0.0;
          _locationLng = (result['placeLong'] as num?)?.toDouble() ?? 0.0;
        });
      }
    });
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  int _timeToGmt(DateTime date, TimeOfDay time) {
    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    return dateTime.millisecondsSinceEpoch;
  }

  bool _validateTimes() {
    if (_startTime == null || _endTime == null) return true;

    final startMinutes = _startTime!.hour * 60 + _startTime!.minute;
    final endMinutes = _endTime!.hour * 60 + _endTime!.minute;

    return endMinutes > startMinutes;
  }

  Future<void> _hostMatch() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedDate == null) {
      _showError(AppStrings.pleaseSelectMatchDate);
      return;
    }

    if (_startTime == null) {
      _showError(AppStrings.pleaseSelectStartTime);
      return;
    }

    if (_endTime == null) {
      _showError(AppStrings.pleaseSelectEndTime);
      return;
    }

    if (!_validateTimes()) {
      _showError(AppStrings.endTimeMustBeAfterStartTime);
      return;
    }

    if (_selectedAgeGroup == null) {
      _showError(AppStrings.pleaseSelectAgeGroup);
      return;
    }

    if (_locationController.text.isEmpty) {
      _showError(AppStrings.pleaseSelectLocation);
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final user = ref.read(currentUserProvider);
      if (user == null) {
        _showError(AppStrings.userNotFound);
        return;
      }

      final matchData = {
        'country': user.country ?? '',
        'venueName': _venueController.text.trim(),
        'locationName': _locationController.text.trim(),
        'locationLat': _locationLat,
        'locationLng': _locationLng,
        'matchDate': _formatDate(_selectedDate!),
        'startTime': _formatTime(_startTime!),
        'endTime': _formatTime(_endTime!),
        'startTimeGmt': _timeToGmt(_selectedDate!, _startTime!),
        'endTimeGmt': _timeToGmt(_selectedDate!, _endTime!),
        'avgAge': _selectedAgeGroup!,
        'gender': _selectedGender,
        'maxPlayer': int.parse(_maxPlayersController.text),
        'matchNote': _noteController.text.trim(),
        'gameType': _selectedGameType,
      };

      final success = await ref
          .read(pickupMatchRepositoryProvider)
          .hostPickupMatch(userId: user.id, matchData: matchData);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Match hosted successfully!'.tr),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true); // Return true to refresh list
      } else if (mounted) {
        _showError(AppStrings.failedToHostMatch);
      }
    } catch (e) {
      _showError('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final country = user?.country ?? 'Unknown';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            Center(
              child: Text(
                "Host a Pick-Up Match".tr,
                style: TextStyle(
                  color: AppColors.socaBlack,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 24),

            // Average Age
            Text(
              'Average Age *'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: AppColors.socaBlack,
              ),
            ),
            SizedBox(height: 8),
            SearchableDropdownButton(
              hint: 'Select'.tr,
              value: _selectedAgeGroup,
              items: _ageGroups,
              onChanged: (value) => setState(() => _selectedAgeGroup = value),
              fontSize: 14,
              backgroundColor: Colors.grey.shade200,
            ),

            SizedBox(height: 16),

            // Gender
            Row(
              children: [
                Text(
                  'Gender *'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: AppColors.socaBlack,
                  ),
                ),
                SizedBox(width: 8),
                _buildGenderRadio('Male'),
                SizedBox(width: 4),
                _buildGenderRadio('Female'),
                SizedBox(width: 4),
                _buildGenderRadio('Mixed'),
              ],
            ),

            SizedBox(height: 16),

            // Match Date
            _buildGreyBox(
              text: _selectedDate == null
                  ? AppStrings.matchDateLabel
                  : _formatDate(_selectedDate!),
              icon: Image.asset(
                'assets/icons/ic_calendar.png',
                width: 24,
                height: 24,
              ),
              onTap: _pickDate,
            ),

            SizedBox(height: 16),

            // Start and End Time
            Row(
              children: [
                Expanded(
                  child: _buildGreyBox(
                    text: _startTime == null
                        ? AppStrings.startTimeRequired
                        : _formatTime(_startTime!),
                    icon: Image.asset(
                      'assets/icons/ic_clock.png',
                      width: 24,
                      height: 24,
                    ),
                    onTap: _pickStartTime,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildGreyBox(
                    text: _endTime == null
                        ? AppStrings.endTimeRequired
                        : _formatTime(_endTime!),
                    icon: Image.asset(
                      'assets/icons/ic_clock.png',
                      width: 24,
                      height: 24,
                    ),
                    onTap: _pickEndTime,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Country (read-only)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                country,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: AppColors.socaBlack,
                ),
              ),
            ),

            SizedBox(height: 16),

            // Venue Name
            TextFormField(
              controller: _venueController,
              decoration: _inputDecoration(AppStrings.venueNameRequired),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppStrings.venueNameIsRequired;
                }
                if (value.trim().length < 3) {
                  return AppStrings.venueNameMinLength;
                }
                return null;
              },
            ),

            SizedBox(height: 16),

            // Location
            GestureDetector(
              onTap: _pickLocation,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/ic_location.png",
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _locationController.text.isEmpty
                            ? AppStrings.selectLocationFromMapRequired
                            : _locationController.text,
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
            if (_locationController.text.isEmpty)
              Padding(
                padding: EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  'Location is required'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
              ),

            SizedBox(height: 16),

            // Max Players
            TextFormField(
              controller: _maxPlayersController,
              decoration: _inputDecoration(AppStrings.maxPlayersRequired),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppStrings.maxPlayersIsRequired;
                }
                final num = int.tryParse(value);
                if (num == null || num <= 0) {
                  return AppStrings.mustBePositiveNumber;
                }
                return null;
              },
            ),

            SizedBox(height: 16),

            // Match Note
            TextFormField(
              controller: _noteController,
              decoration: _inputDecoration(AppStrings.matchNoteHint),
              maxLines: 5,
            ),

            SizedBox(height: 24),

            Text(
              '* mandatory fields'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: AppColors.socaBlack,
              ),
            ),
            SizedBox(height: 12),

            // Host Button
            ElevatedButton(
              onPressed: _isSubmitting ? null : _hostMatch,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isSubmitting
                  ? AppLoader(size: 24, centered: false)
                  : Text(
                      'HOST MATCH'.tr,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.socaYellow,
                      ),
                    ),
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildGreyBox(
      {required String text,
      required Image icon,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
            ),
            // Icon(icon, size: 20, color: Colors.black87),
            icon
          ],
        ),
      ),
    );
  }

  Widget _buildGenderRadio(String label) {
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = label),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: label,
            groupValue: _selectedGender,
            onChanged: (v) => setState(() => _selectedGender = v!),
            activeColor: Colors.black,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Text(label,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: AppColors.socaBlack)),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        color: AppColors.socaBlack,
      ),
      filled: true,
      fillColor: Colors.grey.shade200,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}
