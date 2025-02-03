import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayerScreen extends StatefulWidget {
  final String url;

  const YoutubeVideoPlayerScreen({super.key, required this.url});

  @override
  State<YoutubeVideoPlayerScreen> createState() => _YoutubeVideoPlayerScreenState();
}

class _YoutubeVideoPlayerScreenState extends State<YoutubeVideoPlayerScreen> {
  YoutubePlayerController? _youtubePlayerController;
  String? videoId;

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _youtubePlayerController!.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _youtubePlayerController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    videoId = YoutubePlayer.convertUrlToId(widget.url);
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        showLiveFullscreenButton: true,
        enableCaption: true,
        forceHD: true,
        hideThumbnail: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubePlayerController!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: ProgressBarColors(playedColor: Colors.amber, handleColor: Colors.amberAccent),
        ),
        builder: (p0, p1) {
          return Scaffold(
            appBar: AppBar(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.white,
              leading: const BackButton(
                color: Colors.black, // <-- SEE HERE
              ),
            ),
            body: p1,
          );
        });
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.white,
    //     shadowColor: Colors.transparent,
    //     leading: const BackButton(
    //       color: Colors.black, // <-- SEE HERE
    //     ),
    //   ),
    //   body: Center(
    //     child: YoutubePlayer(controller: _youtubePlayerController!),
    //   ),
    // );
  }
}
