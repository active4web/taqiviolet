import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoServerDisplay extends StatefulWidget {
  final String? videoUrl;
  const VideoServerDisplay({ required this.videoUrl});

  @override
  State<VideoServerDisplay> createState() => _VideoServerDisplayState();
}

class _VideoServerDisplayState extends State<VideoServerDisplay> {
   VideoPlayerController? _controller;
   Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      "${widget.videoUrl}",
    );

    _initializeVideoPlayerFuture = _controller?.initialize();

    _controller?.play();
    _controller?.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller?.dispose();
    _controller?.pause();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          return AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            // Use the VideoPlayer widget to display the video.
            child: InkWell(
              onTap: () {
                // Wrap the play or pause in a call to `setState`. This ensures the
                // correct icon is shown.
                setState(() {
                  // If the video is playing, pause it.
                  if (_controller!.value.isPlaying) {
                    _controller!.pause();
                  } else {
                    // If the video is paused, play it.
                    _controller!.play();
                  }
                });
              },
              child: VideoPlayer(_controller!),
            ),
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
