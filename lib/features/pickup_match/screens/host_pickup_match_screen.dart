import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../data/repositories/pickup_match_repository.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Host Pickup Match Screen - Form to create a new pickup match
/// Mirrors Android PickUpHostMatchFragment
class HostPickupMatchScreen extends ConsumerStatefulWidget {
  const HostPickupMatchScreen({super.key});

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
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
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
            colorScheme: const ColorScheme.light(
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
            colorScheme: const ColorScheme.light(
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
      _showError('Please select a match date');
      return;
    }

    if (_startTime == null) {
      _showError('Please select start time');
      return;
    }

    if (_endTime == null) {
      _showError('Please select end time');
      return;
    }

    if (!_validateTimes()) {
      _showError('End time must be after start time');
      return;
    }

    if (_selectedAgeGroup == null) {
      _showError('Please select age group');
      return;
    }

    if (_locationController.text.isEmpty) {
      _showError('Please select location');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final user = ref.read(currentUserProvider);
      if (user == null) {
        _showError('User not found');
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
          const SnackBar(
            content: Text('Match hosted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true); // Return true to refresh list
      } else if (mounted) {
        _showError('Failed to host match. Please try again.');
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            const Center(
              child: Text(
                "Host a Pick-Up Match",
                style: TextStyle(
                  color: AppColors.socaBlack,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Average Age
            const Text(
              'Average Age *',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: AppColors.socaBlack,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedAgeGroup,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Select',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaBlack),
                    ),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Image.asset("assets/images/dropdown.png",
                        width: 12, height: 12),
                  ),
                  items: _ageGroups.map((age) {
                    return DropdownMenuItem(
                      value: age,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(age,
                            style: const TextStyle(
                                fontFamily: 'Poppins', fontSize: 14)),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() => _selectedAgeGroup = value),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Gender
            Row(
              children: [
                const Text(
                  'Gender *',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: AppColors.socaBlack,
                  ),
                ),
                const SizedBox(width: 8),
                _buildGenderRadio('Male'),
                const SizedBox(width: 4),
                _buildGenderRadio('Female'),
                const SizedBox(width: 4),
                _buildGenderRadio('Mixed'),
              ],
            ),

            const SizedBox(height: 16),

            // Match Date
            _buildGreyBox(
              text: _selectedDate == null
                  ? 'Match date *'
                  : _formatDate(_selectedDate!),
              icon: Image.asset(
                'assets/icons/ic_calendar.png',
                width: 24,
                height: 24,
              ),
              onTap: _pickDate,
            ),

            const SizedBox(height: 16),

            // Start and End Time
            Row(
              children: [
                Expanded(
                  child: _buildGreyBox(
                    text: _startTime == null
                        ? 'Start Time *'
                        : _formatTime(_startTime!),
                    icon: Image.asset(
                      'assets/icons/ic_clock.png',
                      width: 24,
                      height: 24,
                    ),
                    onTap: _pickStartTime,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildGreyBox(
                    text: _endTime == null
                        ? 'End Time *'
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

            const SizedBox(height: 16),

            // Country (read-only)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                country,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: AppColors.socaBlack,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Venue Name
            TextFormField(
              controller: _venueController,
              decoration: _inputDecoration('Venue name *'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Venue name is required';
                }
                if (value.trim().length < 3) {
                  return 'Venue name must be at least 3 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Location
            GestureDetector(
              onTap: _pickLocation,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _locationController.text.isEmpty
                            ? 'Select location from map *'
                            : _locationController.text,
                        style: const TextStyle(
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
              const Padding(
                padding: EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  'Location is required',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // Max Players
            TextFormField(
              controller: _maxPlayersController,
              decoration: _inputDecoration('Max players *'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Max players is required';
                }
                final num = int.tryParse(value);
                if (num == null || num <= 0) {
                  return 'Must be a positive number';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Match Note
            TextFormField(
              controller: _noteController,
              decoration: _inputDecoration('Match Note'),
              maxLines: 5,
            ),

            const SizedBox(height: 24),

            const Text(
              '* mandatory fields',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: AppColors.socaBlack,
              ),
            ),
            const SizedBox(height: 12),

            // Host Button
            ElevatedButton(
              onPressed: _isSubmitting ? null : _hostMatch,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isSubmitting
                  ? const AppLoader(size: 24, centered: false)
                  : const Text(
                      'HOST MATCH',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.socaYellow,
                      ),
                    ),
            ),

            const SizedBox(height: 32),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
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
              style: const TextStyle(
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
      hintStyle: const TextStyle(
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
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}
