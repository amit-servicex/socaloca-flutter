import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/core/theme/app_colors.dart';
import 'package:video_player/video_player.dart';

// ── Full Screen Video ─────────────────────────────────────────────────────────

class FullScreenVideoScreen extends StatefulWidget {
  final String videoUrl;
  final String? thumbnail;

  const FullScreenVideoScreen({
    super.key,
    required this.videoUrl,
    this.thumbnail,
  });

  @override
  State<FullScreenVideoScreen> createState() => _FullScreenVideoScreenState();
}

class _FullScreenVideoScreenState extends State<FullScreenVideoScreen> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );
    try {
      await _videoController.initialize();
      if (!mounted) return;
      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        // placeholder: widget.thumbnail != null
        //     ? Image.network(widget.thumbnail!, fit: BoxFit.contain)
        //     : null,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.socaYellow,
          handleColor: AppColors.socaYellow,
          backgroundColor: Colors.white24,
          bufferedColor: Colors.white38,
        ),
      );
      setState(() {});
    } catch (_) {
      if (mounted) setState(() => _hasError = true);
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaBlack,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: _hasError
                  ? const Icon(Icons.error_outline,
                      color: Colors.white, size: 64)
                  : _chewieController != null
                      ? Chewie(controller: _chewieController!)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.thumbnail != null)
                              Opacity(
                                opacity: 0.5,
                                child: Image.network(
                                  widget.thumbnail!,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                ),
                              ),
                            const SizedBox(height: 16),
                            const CircularProgressIndicator(
                              color: AppColors.socaYellow,
                            ),
                          ],
                        ),
            ),

            // Back button
            Positioned(
              top: 16,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white, size: 22),
                    const SizedBox(width: 6),
                    Text(
                      AppStrings.back,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Full Screen Image ─────────────────────────────────────────────────────────

class FullScreenImageScreen extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaBlack,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.error, color: Colors.white, size: 64),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              left: 20,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/images/logo_transparent.png',
                  color: AppColors.socaBlack,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.sports_soccer,
                    color: AppColors.socaBlack,
                    size: 32,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white, size: 22),
                    const SizedBox(width: 6),
                    Text(
                      AppStrings.back,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
