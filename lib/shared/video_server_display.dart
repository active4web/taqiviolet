import 'dart:developer';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

class VideoServerDisplay extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  VideoServerDisplay({
    @required this.videoPlayerController,
    Key key,
  }) : super(key: key);

  @override
  State<VideoServerDisplay> createState() => _VideoServerDisplayState();
}

class _VideoServerDisplayState extends State<VideoServerDisplay> {
  CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    log('%' * 40);
    log('inside init state');
    log('%' * 40);
    super.initState();
    widget.videoPlayerController
      ..initialize().then((value) {
        setState(() {});
      });
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: widget.videoPlayerController,
      customVideoPlayerSettings: CustomVideoPlayerSettings(
        showFullscreenButton: false,
        playbackSpeedButtonAvailable: false,
        settingsButtonAvailable: false,
        placeholderWidget: Container(
          color: Colors.black45,
        ),
        
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomVideoPlayer(
      customVideoPlayerController: _customVideoPlayerController,
    );
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    _customVideoPlayerController.dispose();
    super.dispose();
  }
}
