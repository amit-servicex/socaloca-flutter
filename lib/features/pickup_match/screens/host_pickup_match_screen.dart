import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../data/repositories/pickup_match_repository.dart';

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
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        title: const Text(
          'Host Pickup Match',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.socaBlack,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.socaBlack),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Country (read-only)
            _buildLabel('Country'),
            Container(
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
            _buildLabel('Venue Name *'),
            TextFormField(
              controller: _venueController,
              decoration: _inputDecoration('Enter venue name'),
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
            _buildLabel('Location *'),
            GestureDetector(
              onTap: _pickLocation,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.socaGrey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: AppColors.socaBlack),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _locationController.text.isEmpty
                            ? 'Select location from map'
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

            // Match Date
            _buildLabel('Match Date *'),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'Select date'
                          : _formatDate(_selectedDate!),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: _selectedDate == null
                            ? Colors.grey.shade600
                            : AppColors.socaBlack,
                      ),
                    ),
                    const Icon(Icons.calendar_today, size: 20),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Start and End Time
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Start Time *'),
                      GestureDetector(
                        onTap: _pickStartTime,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _startTime == null
                                    ? 'Start'
                                    : _formatTime(_startTime!),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: _startTime == null
                                      ? Colors.grey.shade600
                                      : AppColors.socaBlack,
                                ),
                              ),
                              const Icon(Icons.access_time, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('End Time *'),
                      GestureDetector(
                        onTap: _pickEndTime,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _endTime == null
                                    ? 'End'
                                    : _formatTime(_endTime!),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: _endTime == null
                                      ? Colors.grey.shade600
                                      : AppColors.socaBlack,
                                ),
                              ),
                              const Icon(Icons.access_time, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Game Type
            _buildLabel('Game Type'),
            Row(
              children: [
                Expanded(
                  child: _buildRadioOption(
                    'Football',
                    _selectedGameType == 'Football',
                    () => setState(() => _selectedGameType = 'Football'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildRadioOption(
                    'Futsal',
                    _selectedGameType == 'Futsal',
                    () => setState(() => _selectedGameType = 'Futsal'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Age Group
            _buildLabel('Age Group *'),
            DropdownButtonFormField<String>(
              value: _selectedAgeGroup,
              decoration: _inputDecoration('Select age group'),
              items: _ageGroups.map((age) {
                return DropdownMenuItem(value: age, child: Text(age));
              }).toList(),
              onChanged: (value) => setState(() => _selectedAgeGroup = value),
              validator: (value) {
                if (value == null) return 'Age group is required';
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Gender
            _buildLabel('Gender'),
            Row(
              children: [
                Expanded(
                  child: _buildRadioOption(
                    'Male',
                    _selectedGender == 'Male',
                    () => setState(() => _selectedGender = 'Male'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildRadioOption(
                    'Female',
                    _selectedGender == 'Female',
                    () => setState(() => _selectedGender = 'Female'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildRadioOption(
                    'Mixed',
                    _selectedGender == 'Mixed',
                    () => setState(() => _selectedGender = 'Mixed'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Max Players
            _buildLabel('Max Players *'),
            TextFormField(
              controller: _maxPlayersController,
              decoration: _inputDecoration('Enter max players'),
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
            _buildLabel('Match Note (Optional)'),
            TextFormField(
              controller: _noteController,
              decoration: _inputDecoration('Add any additional notes'),
              maxLines: 3,
              maxLength: 200,
            ),

            const SizedBox(height: 24),

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
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation(AppColors.socaYellow),
                      ),
                    )
                  : const Text(
                      'HOST MATCH',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.socaYellow,
                      ),
                    ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        color: Colors.grey.shade600,
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.socaYellow, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  Widget _buildRadioOption(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.socaBlack : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? AppColors.socaBlack : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: selected ? AppColors.socaYellow : AppColors.socaBlack,
            ),
          ),
        ),
      ),
    );
  }
}
