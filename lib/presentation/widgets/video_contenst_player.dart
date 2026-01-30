import 'package:flutter/material.dart';
import 'package:newsphone_competitions/core/themes/newsphone_theme.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class ContestVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool isFullScreen;
  final VideoPlayerController? controller;

  const ContestVideoPlayer({
    super.key,
    required this.videoUrl,
    this.isFullScreen = false,
    this.controller,
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

  // Helper to format Duration to MM:SS
  String _formatDuration(Duration duration) {
    String minutes = duration.inMinutes.toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
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
    showDialog(
      context: context,
      useSafeArea: false,
      builder:
          (context) => Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                Center(
                  child: ContestVideoPlayer(
                    videoUrl: widget.videoUrl,
                    isFullScreen: true,
                    controller: _controller,
                  ),
                ),
                // Close Button
                Positioned(
                  top: 40,
                  right: 20,
                  child: IconButton(
                    icon: CircleAvatar(
                      backgroundColor: NewsphoneTheme.neutralBlack.withValues(
                        alpha: 0.5,
                      ),
                      child: Icon(
                        Icons.close,
                        color: NewsphoneTheme.neutralWhite,
                      ),
                    ),
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
    if (!widget.isFullScreen) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[350]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Icon(Icons.videocam, size: 50, color: Colors.white),
          ),
        ),
      );
    }

    final bool showCenterUI = !_controller.value.isPlaying || _hasEnded;

    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        color: NewsphoneTheme.neutralBlack,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Video
            SizedBox.expand(
              child: FittedBox(
                fit: widget.isFullScreen ? BoxFit.contain : BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),

            // Play/Replay Button Overlay
            if (showCenterUI) ...[
              Container(
                color: NewsphoneTheme.neutralBlack.withValues(alpha: 0.2),
              ),
              IgnorePointer(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: NewsphoneTheme.neutralBlack.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _hasEnded ? Icons.replay : Icons.play_arrow_rounded,
                    size: 50,
                    color: NewsphoneTheme.neutralWhite,
                  ),
                ),
              ),
            ],

            // FULL SCREEN UI: Progress Bar and Timer
            if (widget.isFullScreen)
              Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Time Labels
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(_controller.value.position),
                          style: const TextStyle(
                            color: NewsphoneTheme.neutralWhite,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          _formatDuration(_controller.value.duration),
                          style: const TextStyle(
                            color: NewsphoneTheme.neutralWhite,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // The Seek Bar
                    VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      colors: VideoProgressColors(
                        playedColor: NewsphoneTheme.primary,
                        bufferedColor: NewsphoneTheme.neutralWhite.withValues(
                          alpha: 0.1,
                        ),
                        backgroundColor: NewsphoneTheme.neutralWhite.withValues(
                          alpha: 0.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Full Screen Button (Main Card view only)
            if (!widget.isFullScreen && !_hasEnded)
              Positioned(
                bottom: 10,
                right: 10,
                child: GestureDetector(
                  onTap: _enterFullScreen,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: NewsphoneTheme.neutralBlack.withValues(
                      alpha: 0.5,
                    ),
                    child: Icon(
                      Icons.fullscreen,
                      color: NewsphoneTheme.neutralWhite,
                      size: 22,
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
