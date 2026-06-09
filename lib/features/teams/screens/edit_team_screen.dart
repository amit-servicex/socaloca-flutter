import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socaloca/core/constants/api_constants.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/socaloca_text_field.dart';
import '../data/models/team_bio_model.dart';
import '../data/repositories/team_manage_repository.dart';

/// Age-group options (Android: avgAgeSpinner)
const _ageGroups = ['<13', '<15', '<18', '<20', '21-30', '31-40', '>40'];

/// Age-category options (Android: avgAgeCategorySpinner)
const _ageCategories = [
  'U-7',
  'U-8',
  'U-9',
  'U-10',
  'U-11',
  'U-12',
  'U-13',
  'U-14',
  'U-15',
  'U-16',
  'U-17',
  'U-18',
  'U-19',
  'U-20',
  'U-21',
  'U-22',
  'U-23',
  'Senior',
  'Veteran',
];

class EditTeamScreen extends StatefulWidget {
  final String teamId;
  final TeamDetailsModel teamDetails;

  const EditTeamScreen({
    super.key,
    required this.teamId,
    required this.teamDetails,
  });

  @override
  State<EditTeamScreen> createState() => _EditTeamScreenState();
}

class _EditTeamScreenState extends State<EditTeamScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _shortNameCtrl;
  late final TextEditingController _cityCtrl;

  String? _ageGroup;
  String? _ageCat;
  String _gameType = 'Football';
  bool _isSaving = false;

  File? _teamImageFile;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final d = widget.teamDetails;
    _nameCtrl = TextEditingController(text: d.teamName ?? '');
    _shortNameCtrl = TextEditingController(text: d.teamShortName ?? '');
    _cityCtrl = TextEditingController(text: d.city ?? '');

    // Pre-select spinner values only if they match a known option
    _ageGroup = _ageGroups.contains(d.ageGroup) ? d.ageGroup : null;
    _ageCat = _ageCategories.contains(d.ageCategory) ? d.ageCategory : null;
    _gameType = (d.gameType?.toLowerCase() == 'futsal') ? 'Futsal' : 'Football';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _shortNameCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final file = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (file != null) {
        setState(() => _teamImageFile = File(file.path));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppStrings.errorPickingImage(e))),
        );
      }
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.selectPhoto,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.socaBlack,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading:
                    const Icon(Icons.camera_alt, color: AppColors.socaBlack),
                title: Text(AppStrings.camera,
                    style:
                        const TextStyle(fontFamily: 'Poppins', fontSize: 16)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.photo_library, color: AppColors.socaBlack),
                title: Text(AppStrings.gallery,
                    style:
                        const TextStyle(fontFamily: 'Poppins', fontSize: 16)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    try {
      await TeamManageRepository(teamId: widget.teamId).editTeam(
        teamName: _nameCtrl.text.trim(),
        teamShortName: _shortNameCtrl.text.trim(),
        city: _cityCtrl.text.trim(),
        ageGroup: _ageGroup ?? '',
        ageCat: _ageCat ?? '',
        gameType: _gameType,
        imageUrl: widget.teamDetails.teamImage ?? '',
        imageFile: _teamImageFile,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.teamInfoUpdated,
              style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop(true); // true = updated
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(e.toString(), style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: AppColors.socaBlack,
      //   foregroundColor: AppColors.socaYellow,
      //   elevation: 0,
      //   title: const Text(
      //     'Edit Team',
      //     style: TextStyle(
      //       fontFamily: 'Poppins',
      //       fontWeight: FontWeight.w700,
      //       fontSize: 18,
      //     ),
      //   ),
      //   actions: [
      //     if (_isSaving)
      //       const Padding(
      //         padding: EdgeInsets.all(14),
      //         child: SizedBox(
      //           width: 20,
      //           height: 20,
      //           child: CircularProgressIndicator(
      //               strokeWidth: 2, color: AppColors.socaYellow),
      //         ),
      //       )
      //     else
      //       TextButton(
      //         onPressed: _save,
      //         child: const Text(
      //           'SAVE',
      //           style: TextStyle(
      //             fontFamily: 'Poppins',
      //             fontWeight: FontWeight.w700,
      //             color: AppColors.socaYellow,
      //           ),
      //         ),
      //       ),
      //   ],
      // ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(
              height: 50,
            ),
            // Image Preview
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.socaBlack, width: 2),
                    ),
                    child: ClipOval(
                      child: _teamImageFile != null
                          ? Image.file(_teamImageFile!, fit: BoxFit.cover)
                          : (widget.teamDetails.teamImage?.isNotEmpty == true)
                              ? Image.network(
                                  ApiConstants.getImageUrl(
                                      widget.teamDetails.teamImage)!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const CircleAvatar(
                                    backgroundColor: AppColors.socaGrey,
                                    child: Icon(Icons.image,
                                        size: 50, color: AppColors.socaBlack),
                                  ),
                                )
                              : const CircleAvatar(
                                  backgroundColor: AppColors.socaGrey,
                                  child: Icon(Icons.image,
                                      size: 50, color: AppColors.socaBlack),
                                ),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 8,
                    child: GestureDetector(
                      onTap: _showImageSourceDialog,
                      child: Image.asset(
                        "assets/icons/ic_edit.png",
                        width: 28,
                        height: 28,
                        color: AppColors.playedGray,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Game Type
            Row(
              children: [
                Text(
                  AppStrings.gameType,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
                const SizedBox(width: 10),
                Radio<String>(
                  value: 'Football',
                  groupValue: _gameType,
                  activeColor: AppColors.socaBlack,
                  onChanged: (v) => setState(() => _gameType = v!),
                ),
                Text(
                  AppStrings.football,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
                Radio<String>(
                  value: 'Futsal',
                  groupValue: _gameType,
                  activeColor: AppColors.socaBlack,
                  onChanged: (v) => setState(() => _gameType = v!),
                ),
                Text(
                  AppStrings.futsal,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Age Range
            Text(
              AppStrings.ageRange,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
            ),
            const SizedBox(height: 6),
            _buildDropdown<String>(
              value: _ageGroup,
              hint: AppStrings.selectAgeRange,
              items: _ageGroups,
              onChanged: (v) => setState(() => _ageGroup = v),
            ),
            const SizedBox(height: 16),

            // Age Category
            Text(
              '${AppStrings.ageCategory} *',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
            ),
            const SizedBox(height: 6),
            _buildDropdown<String>(
              value: _ageCat,
              hint: AppStrings.selectAgeCategory,
              items: _ageCategories,
              onChanged: (v) => setState(() => _ageCat = v),
            ),
            const SizedBox(height: 16),

            // Gender
            if (widget.teamDetails.gender?.isNotEmpty ?? false) ...[
              Row(
                children: [
                  Text(
                    AppStrings.gender,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.teamDetails.gender!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],

            // Team Name
            _buildTextField(
              controller: _nameCtrl,
              hint: AppStrings.teamName,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? AppStrings.teamNameRequired
                  : null,
            ),
            const SizedBox(height: 16),

            // Short Name
            _buildTextField(
              controller: _shortNameCtrl,
              hint: AppStrings.shortNameHint,
              maxLength: 4,
            ),
            const SizedBox(height: 16),

            // Country
            if (widget.teamDetails.country?.isNotEmpty ?? false) ...[
              CreateProfileTextField(
                controller:
                    TextEditingController(text: widget.teamDetails.country),
                enabled: false,
              ),
              const SizedBox(height: 16),
            ],

            // City
            _buildTextField(
              controller: _cityCtrl,
              hint: AppStrings.cityAddress,
            ),
            const SizedBox(height: 32),

            Text(
              AppStrings.mandatoryFields,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: AppColors.socaBlack,
              ),
            ),
            const SizedBox(height: 12),

            // Save button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaBlack,
                  disabledBackgroundColor: AppColors.socaBlack,
                  foregroundColor: AppColors.socaYellow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  elevation: 0,
                ),
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: AppColors.socaYellow),
                      )
                    : Text(
                        AppStrings.updateTeam.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? hint,
    int? maxLength,
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
            maxLength: maxLength,
            onChanged: field.didChange,
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

  Widget _buildDropdown<T>({
    required T? value,
    required String hint,
    required List<T> items,
    required void Function(T?) onChanged,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.socaGrey,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          hint: Text(hint,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack,
              )),
          icon: Image.asset(
            "assets/images/dropdown.png",
            width: 14,
            height: 14,
          ),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(item.toString(),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  )),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
