import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart' show SharePlus, ShareParams;

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';

// ── Post category constants (from Android Params.java) ────────────────────────
const _kSkillVideo = 'skill';
const _kFootballMoments = 'moment';
const _kPostTypeImage = 'image';
const _kPostTypeVideo = 'video';

/// Create Post screen — mirrors Android CreatePostFragment.
/// Video mode: space bar → write+tag → post type → choose category → notify → media
/// Image mode: write+tag → post type → media
class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _imagePicker = ImagePicker();

  // Default: Videos first (mirror Android)
  String _postType = _kPostTypeVideo;
  String _postCat = _kSkillVideo;
  bool _notifyFollowers = true; // Default checked (mirror Android)

  final List<XFile> _selectedImages = [];
  XFile? _selectedVideo;

  final List<Map<String, dynamic>> _taggedUsers = [];

  bool _isUploading = false;
  double _uploadProgress = 0;
  String _uploadStatus = '';

  // Space info (from getVdoSpace API)
  double _availableMB = 0;
  double _usedMB = 0;
  double _maxMB = 1024;
  bool _spaceLoaded = false;

  static const int _maxImages = 10;

  @override
  void initState() {
    super.initState();
    _loadVdoSpace();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  // ── Space API ─────────────────────────────────────────────────────────────

  Future<void> _loadVdoSpace() async {
    try {
      final userId = StorageService.userId ?? '';
      final resp = await ApiClient.instance.post(
        ApiConstants.getVdoSpace,
        body: {'userId': userId},
      );
      final raw = resp['response'];
      if ((raw?['status'] as num?)?.toInt() == 1) {
        final used = (raw['sizeTaken'] as num?)?.toDouble() ?? 0;
        final max = (raw['max'] as num?)?.toDouble() ?? 0;
        final available = (raw['available'] as num?)?.toDouble() ?? 0;
        setState(() {
          _usedMB = used / (1024 * 1024);
          _maxMB = max / (1024 * 1024);
          _availableMB = available / (1024 * 1024);
          _spaceLoaded = true;
        });
      }
    } catch (_) {}
  }

  // ── Media picking ─────────────────────────────────────────────────────────

  Future<void> _pickImages(ImageSource source) async {
    if (source == ImageSource.camera) {
      final file = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (file != null && _selectedImages.length < _maxImages) {
        setState(() => _selectedImages.add(file));
      }
    } else {
      final files = await _imagePicker.pickMultiImage(
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (files.isNotEmpty) {
        setState(() {
          final remaining = _maxImages - _selectedImages.length;
          _selectedImages.addAll(files.take(remaining));
        });
      }
    }
  }

  Future<void> _pickVideo() async {
    final file = await _imagePicker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(minutes: 10),
    );
    if (file != null) {
      // Check file size against available space
      final size = File(file.path).lengthSync();
      final fileMB = size / (1024 * 1024);
      if (_spaceLoaded && fileMB > _availableMB) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Video larger than available space')),
          );
        }
        return;
      }
      setState(() => _selectedVideo = file);
    }
  }

  void _removeImage(int index) =>
      setState(() => _selectedImages.removeAt(index));

  // ── Tag players ───────────────────────────────────────────────────────────

  void _openTagPlayers() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _TagPlayersSheet(
        userId: StorageService.userId ?? '',
        selected: _taggedUsers,
        onDone: (updated) => setState(() {
          _taggedUsers
            ..clear()
            ..addAll(updated);
        }),
      ),
    );
  }

  void _invitePlayers() {
    SharePlus.instance.share(ShareParams(
      text: 'Join me on Socaloca! '
          'Download: https://tinyurl.com/yxrtynk4 '
          'or AppStore: https://tinyurl.com/y6yqlovr',
    ));
  }

  void _removeTag(String userId) =>
      setState(() => _taggedUsers.removeWhere((u) => u['userId'] == userId));

  // ── Upload & submit ───────────────────────────────────────────────────────

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write something')),
      );
      return;
    }
    if (_postType == _kPostTypeImage && _selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one photo')),
      );
      return;
    }
    if (_postType == _kPostTypeVideo && _selectedVideo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a video')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
      _uploadProgress = 0;
      _uploadStatus = 'Uploading...';
    });

    try {
      final userId = StorageService.userId ?? '';
      final List<Map<String, dynamic>> sources = [];
      double totalSize = 0;

      if (_postType == _kPostTypeImage) {
        for (int i = 0; i < _selectedImages.length; i++) {
          final img = _selectedImages[i];
          setState(() {
            _uploadStatus =
                'Uploading photo ${i + 1} of ${_selectedImages.length}...';
            _uploadProgress = i / _selectedImages.length;
          });

          final size = File(img.path).lengthSync().toDouble();
          final formData = FormData.fromMap({
            'image': await MultipartFile.fromFile(img.path, filename: img.name),
          });
          final resp = await ApiClient.instance
              .uploadFile(ApiConstants.uploadImage, formData: formData);
          final imageUrl = resp['response']?['image'] as String? ?? '';
          if (imageUrl.isEmpty)
            throw Exception('Failed to upload photo ${i + 1}');
          sources.add({'seq': i + 1, 'imageUrl': imageUrl, 'size': size});
          totalSize += size;
        }
      } else {
        setState(() => _uploadStatus = 'Uploading video...');
        final size = File(_selectedVideo!.path).lengthSync().toDouble();
        final formData = FormData.fromMap({
          'video': await MultipartFile.fromFile(_selectedVideo!.path,
              filename: _selectedVideo!.name),
        });
        final resp = await ApiClient.instance
            .uploadFile(ApiConstants.uploadVdo, formData: formData);
        final videoUrl = resp['response']?['videoUrl'] as String? ?? '';
        final thumbnail = resp['response']?['thumbnail'] as String? ?? '';
        if (videoUrl.isEmpty) throw Exception('Failed to upload video');
        sources.add({
          'seq': 1,
          'videoUrl': videoUrl,
          'thumbnail': thumbnail,
          'thumbSet': thumbnail.isNotEmpty,
          'videoId': resp['response']?['videoId'] ?? '',
          'size': size,
        });
        totalSize = size;
      }

      final tagged = _taggedUsers
          .asMap()
          .entries
          .map((e) =>
              {'tagId': e.value['userId'], 'tagType': 'user', 'seq': e.key + 1})
          .toList();

      setState(() => _uploadStatus = 'Publishing post...');

      final body = <String, dynamic>{
        'userId': userId,
        'title': title,
        'postType': _postType,
        'size': totalSize,
        'sources': sources,
        'tagged': tagged,
      };
      if (_postType == _kPostTypeVideo) {
        body['postCat'] = _postCat;
        if (_postCat == _kSkillVideo) {
          body['postNotify'] = _notifyFollowers;
        }
      }

      final result = await ApiClient.instance
          .post(ApiConstants.createUserPost, body: body);
      if (!mounted) return;

      final status = (result['response']?['status'] as num?)?.toInt() ?? 0;
      if (status == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post published successfully!')),
        );
        context.pop();
      } else {
        throw Exception(
            result['response']?['message'] ?? 'Failed to create post');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
          _uploadProgress = 0;
          _uploadStatus = '';
        });
      }
    }
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: SafeArea(
        child: _isUploading ? _buildUploadProgress() : _buildForm(),
      ),
    );
  }

  Widget _buildUploadProgress() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.socaYellow),
            const SizedBox(height: 24),
            Text(
              _uploadStatus,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: AppColors.socaBlack),
              textAlign: TextAlign.center,
            ),
            if (_uploadProgress > 0) ...[
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: _uploadProgress,
                backgroundColor: Colors.grey.shade300,
                color: AppColors.socaYellow,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    final isVideo = _postType == _kPostTypeVideo;
    final showNotify = isVideo && _postCat == _kSkillVideo;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 1. Space bar (video mode only) ────────────────────────────────
          if (isVideo) ...[
            _SpaceBar(
              availableMB: _availableMB,
              usedMB: _usedMB,
              maxMB: _maxMB,
              loaded: _spaceLoaded,
            ),
            const SizedBox(height: 16),
          ],

          // ── 2. Write something + TAG PEOPLE (same row) ────────────────────
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    maxLength: 200,
                    maxLines: 1,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.socaBlack),
                    decoration: const InputDecoration(
                      hintText: 'Write something',
                      hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaGrey),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      counterText: '',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _openTagPlayers,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.socaBlack,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'TAG PEOPLE',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.socaYellow,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tagged chips
          if (_taggedUsers.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: _taggedUsers.map((u) {
                final name =
                    '${u['firstName'] ?? ''} ${u['lastName'] ?? ''}'.trim();
                final imageUrl = u['imageUrl'] as String? ?? '';
                return Chip(
                  avatar: CircleAvatar(
                    radius: 12,
                    backgroundColor: AppColors.socaGrey,
                    backgroundImage:
                        imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                    child: imageUrl.isEmpty
                        ? Text(
                            name.isNotEmpty ? name[0].toUpperCase() : '?',
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                color: AppColors.socaBlack),
                          )
                        : null,
                  ),
                  label: Text(
                    name.isNotEmpty ? name : u['userId'].toString(),
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: AppColors.socaBlack),
                  ),
                  deleteIcon: const Icon(Icons.close,
                      size: 14, color: AppColors.socaBlack),
                  onDeleted: () => _removeTag(u['userId'].toString()),
                  backgroundColor: AppColors.socaGrey,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                );
              }).toList(),
            ),
          ],

          const SizedBox(height: 16),

          // ── 3. Post Type — Videos first, Photos second ─────────────────────
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                const Text(
                  'Post Type',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.socaBlack,
                  ),
                ),
                const SizedBox(width: 20),
                _RadioOption(
                  value: _kPostTypeVideo,
                  groupValue: _postType,
                  label: 'Videos',
                  onChanged: (v) => setState(() {
                    _postType = v!;
                    _selectedImages.clear();
                  }),
                ),
                const SizedBox(width: 20),
                _RadioOption(
                  value: _kPostTypeImage,
                  groupValue: _postType,
                  label: 'Photos',
                  onChanged: (v) => setState(() {
                    _postType = v!;
                    _selectedVideo = null;
                  }),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── 4. Choose section (video only) ────────────────────────────────
          if (isVideo) ...[
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _CategoryOption(
                    value: _kSkillVideo,
                    groupValue: _postCat,
                    title: 'Skill Video',
                    description:
                        '(Share videos of you displaying your football skills in matches or in training to be endorsed or rated by SocaLoca users, including coaches and scouts.)',
                    onChanged: (v) => setState(() => _postCat = v!),
                  ),
                  const SizedBox(height: 12),
                  _CategoryOption(
                    value: _kFootballMoments,
                    groupValue: _postCat,
                    title: 'Football Moments',
                    description:
                        '(Share video of your football moments or any other football related content that is beneficial to the SocaLoca user base)',
                    onChanged: (v) => setState(() => _postCat = v!),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // ── 5. Notify checkbox (video + skill video only) ──────────────────
          if (showNotify) ...[
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: GestureDetector(
                onTap: () =>
                    setState(() => _notifyFollowers = !_notifyFollowers),
                child: Row(
                  children: [
                    Checkbox(
                      value: _notifyFollowers,
                      onChanged: (v) => setState(() => _notifyFollowers = v!),
                      activeColor: AppColors.socaBlack,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    const Expanded(
                      child: Text(
                        'Notify all coaches/managers/scounts to endorse video',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // ── 6. Media section ───────────────────────────────────────────────
          if (isVideo) _buildVideoSection() else _buildImageSection(),

          const SizedBox(height: 24),

          // ── 7. Invite players ──────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _invitePlayers,
                  icon: const Icon(Icons.share,
                      size: 16, color: AppColors.socaBlack),
                  label: const Text(
                    'INVITE PLAYERS',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.socaBlack),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── 8. CREATE POST button ──────────────────────────────────────────
          GestureDetector(
            onTap: _submit,
            child: Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'CREATE POST',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.socaYellow,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ── Image section ──────────────────────────────────────────────────────────

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_selectedImages.isNotEmpty) ...[
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: _selectedImages.length,
            itemBuilder: (_, i) => Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.file(File(_selectedImages[i].path),
                      fit: BoxFit.cover),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _removeImage(i),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.black54, shape: BoxShape.circle),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(Icons.close,
                          color: Colors.white, size: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (_selectedImages.length < _maxImages) ...[
          Text(
            'Add Photos (${_selectedImages.length}/$_maxImages)',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.socaBlack,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _MediaBtn(
                  icon: Icons.camera_alt_outlined,
                  label: 'Camera',
                  onTap: () => _pickImages(ImageSource.camera)),
              const SizedBox(width: 8),
              _MediaBtn(
                  icon: Icons.photo_library_outlined,
                  label: 'Gallery',
                  onTap: () => _pickImages(ImageSource.gallery)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '(max $_maxImages photos allowed)',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                color: Colors.grey.shade600),
          ),
        ],
      ],
    );
  }

  // ── Video section ──────────────────────────────────────────────────────────

  Widget _buildVideoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_selectedVideo != null) ...[
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.socaBlack,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.play_circle_fill,
                    color: AppColors.socaYellow, size: 60),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedVideo = null),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.black54, shape: BoxShape.circle),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(Icons.close,
                          color: Colors.white, size: 18),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Text(
                    _selectedVideo!.name,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: Colors.white70),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
        _MediaBtn(
          icon: Icons.videocam_outlined,
          label: _selectedVideo == null ? 'Upload Videos' : 'Change Video',
          onTap: _pickVideo,
          fullWidth: true,
        ),
        const SizedBox(height: 4),
        Text(
          '(max 10 videos allowed)',
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}

// ── Space Bar ─────────────────────────────────────────────────────────────────

class _SpaceBar extends StatelessWidget {
  final double availableMB;
  final double usedMB;
  final double maxMB;
  final bool loaded;

  const _SpaceBar({
    required this.availableMB,
    required this.usedMB,
    required this.maxMB,
    required this.loaded,
  });

  @override
  Widget build(BuildContext context) {
    final fraction = (maxMB > 0 ? (usedMB / maxMB) : 0.0).clamp(0.0, 1.0);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Available Space : ',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: AppColors.socaBlack),
              ),
              Text(
                loaded ? '${availableMB.toStringAsFixed(2)} MB' : '—',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaBlack,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              const Text(
                'Used Space : ',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: AppColors.socaBlack),
              ),
              Text(
                loaded ? '${usedMB.toStringAsFixed(2)} MB' : '—',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaBlack,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fraction,
              backgroundColor: Colors.grey.shade300,
              color: AppColors.socaYellow,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 4),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0MB',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: AppColors.socaBlack)),
              Text('1024MB',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: AppColors.socaBlack)),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Category option (radio + title + description) ─────────────────────────────

class _CategoryOption extends StatelessWidget {
  final String value;
  final String groupValue;
  final String title;
  final String description;
  final ValueChanged<String?> onChanged;

  const _CategoryOption({
    required this.value,
    required this.groupValue,
    required this.title,
    required this.description,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: AppColors.socaBlack,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Radio option (inline, for Post Type row) ──────────────────────────────────

class _RadioOption extends StatelessWidget {
  final String value;
  final String groupValue;
  final String label;
  final ValueChanged<String?> onChanged;

  const _RadioOption({
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onChanged(value),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(
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

// ── Media button ──────────────────────────────────────────────────────────────

class _MediaBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool fullWidth;

  const _MediaBtn({
    required this.icon,
    required this.label,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final btn = GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.socaBlack.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.socaBlack, size: 20),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.socaBlack,
                )),
          ],
        ),
      ),
    );
    return fullWidth
        ? SizedBox(width: double.infinity, child: btn)
        : Expanded(child: btn);
  }
}

// ── Tag Players bottom sheet ───────────────────────────────────────────────────

class _TagPlayersSheet extends StatefulWidget {
  final String userId;
  final List<Map<String, dynamic>> selected;
  final ValueChanged<List<Map<String, dynamic>>> onDone;

  const _TagPlayersSheet({
    required this.userId,
    required this.selected,
    required this.onDone,
  });

  @override
  State<_TagPlayersSheet> createState() => _TagPlayersSheetState();
}

class _TagPlayersSheetState extends State<_TagPlayersSheet> {
  final _searchController = TextEditingController();
  final List<Map<String, dynamic>> _results = [];
  late List<Map<String, dynamic>> _selected;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.selected);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _search(String query) async {
    if (query.length < 2) {
      setState(() => _results.clear());
      return;
    }
    setState(() => _isSearching = true);
    try {
      final resp = await ApiClient.instance.post(
        ApiConstants.tagUserSearch,
        body: {
          'userId': widget.userId,
          'searchText': query,
          'start': 0,
          'limit': 25,
        },
      );
      final raw = resp['response']?['result'] as List? ?? [];
      setState(() {
        _results
          ..clear()
          ..addAll(raw.cast<Map<String, dynamic>>());
      });
    } catch (_) {}
    if (mounted) setState(() => _isSearching = false);
  }

  void _toggle(Map<String, dynamic> user) {
    final id = user['userId']?.toString() ?? '';
    setState(() {
      if (_selected.any((u) => u['userId'] == id)) {
        _selected.removeWhere((u) => u['userId'] == id);
      } else {
        _selected.add(user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      builder: (ctx, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tag Players',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onDone(_selected);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                onChanged: _search,
                decoration: InputDecoration(
                  hintText: 'Search players...',
                  hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: AppColors.socaGrey),
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.socaGrey),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack),
              ),
            ),
            const SizedBox(height: 8),
            if (_isSearching)
              const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(color: AppColors.socaYellow),
              )
            else
              Expanded(
                child: _results.isEmpty
                    ? Center(
                        child: Text(
                          _searchController.text.length < 2
                              ? 'Type at least 2 characters to search'
                              : 'No players found',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: AppColors.socaGrey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: _results.length,
                        itemBuilder: (_, i) {
                          final user = _results[i];
                          final id = user['userId']?.toString() ?? '';
                          final name =
                              '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}'
                                  .trim();
                          final imageUrl = user['imageUrl'] as String? ?? '';
                          final sel = _selected.any((u) => u['userId'] == id);
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: imageUrl.isNotEmpty
                                  ? NetworkImage(imageUrl)
                                  : null,
                              child: imageUrl.isEmpty
                                  ? Text(
                                      name.isNotEmpty
                                          ? name[0].toUpperCase()
                                          : '?',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: AppColors.socaBlack,
                                      ),
                                    )
                                  : null,
                            ),
                            title: Text(
                              name.isNotEmpty ? name : id,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: user['playPosition'] != null
                                ? Text(
                                    user['playPosition'].toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 11,
                                      color: AppColors.socaGrey,
                                    ),
                                  )
                                : null,
                            trailing: sel
                                ? const Icon(Icons.check_circle,
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
      ),
    );
  }
}
