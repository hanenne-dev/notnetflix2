import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:notnetflix/utils/constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyVideoPlayer extends StatefulWidget {
  final String movieId;
  const MyVideoPlayer({super.key, required this.movieId});

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  YoutubePlayerController? controller;
  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
      initialVideoId: widget.movieId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        hideThumbnail: true,
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controller == null
        ? Center(
            child: SpinKitFadingCircle(
              color: kPrimaryColor,
              size: 20,
            ),
          )
        : YoutubePlayer(
            controller: controller!,
            progressColors: ProgressBarColors(
              handleColor: kPrimaryColor,
              playedColor: kPrimaryColor,
            ),
            onEnded: (YoutubeMetaData meta) {
              controller!.play();
              controller!.pause();
            },
          );
  }
}
