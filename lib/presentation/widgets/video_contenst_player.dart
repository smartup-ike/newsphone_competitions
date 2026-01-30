import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ContestVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool isFullScreen;
  // 1. Add this field to receive the controller
  final VideoPlayerController? controller;

  const ContestVideoPlayer({
    super.key,
    required this.videoUrl,
    this.isFullScreen = false,
    this.controller, // Add this
  });

  @override
  State<ContestVideoPlayer> createState() => _ContestVideoPlayerState();
}

class _ContestVideoPlayerState extends State<ContestVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _hasEnded = false;

  @override
  void initState() {
    super.initState();

    // 2. Use the passed controller if it exists, otherwise init new one
    if (widget.controller != null) {
      _controller = widget.controller!;
      _isInitialized = _controller.value.isInitialized;
    } else {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
        ..initialize().then((_) {
          if (mounted) setState(() => _isInitialized = true);
        });
    }

    _controller.addListener(_videoListener);
  }

  // Extracted listener logic to keep it clean
  void _videoListener() {
    if (!_isInitialized) return;

    if (_controller.value.position >= _controller.value.duration) {
      if (!_hasEnded) {
        setState(() {
          _hasEnded = true;
          _controller.seekTo(Duration.zero);
          _controller.pause();
        });
      }
    } else {
      if (_hasEnded) setState(() => _hasEnded = false);
    }
    if (mounted) setState(() {});
  }

  void _handleTap() {
    if (_hasEnded) {
      _playVideo();
    } else {
      setState(() {
        _controller.value.isPlaying ? _controller.pause() : _controller.play();
      });
    }
  }

  void _playVideo() {
    _controller.play();
    setState(() => _hasEnded = false);
  }

  void _enterFullScreen() {
    // Note: We don't pause here if you want it to keep playing while transitioning
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) => Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: ContestVideoPlayer(
                videoUrl: widget.videoUrl,
                isFullScreen: true,
                controller: _controller, // 3. Pass the current controller here!
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    // 4. IMPORTANT: Only dispose if it's the main player.
    // If we dispose in fullscreen, the small player will break when we go back.
    if (!widget.isFullScreen) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }

    final bool showCenterUI = !_controller.value.isPlaying || _hasEnded;

    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            if (showCenterUI) ...[
              Container(color: Colors.black.withOpacity(0.2)),
              IgnorePointer(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _hasEnded ? Icons.replay : Icons.play_arrow_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            if (!widget.isFullScreen && !_hasEnded)
              Positioned(
                bottom: 10,
                right: 10,
                child: GestureDetector(
                  onTap: _enterFullScreen,
                  child: const Icon(Icons.fullscreen, color: Colors.white, size: 28),
                ),
              ),
          ],
        ),
      ),
    );
  }
}