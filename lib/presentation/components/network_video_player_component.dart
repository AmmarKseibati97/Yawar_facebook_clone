import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class NetworkVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final double width;
  final double height;

  const NetworkVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.width,
    required this.height,
  });

  @override
  // ignore: library_private_types_in_public_api
  _NetworkVideoPlayerState createState() => _NetworkVideoPlayerState();
}

class _NetworkVideoPlayerState extends State<NetworkVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  double opacity = 1;
  String getPosition() {
    durationOfVideo = Duration(
        milliseconds: _controller.value.position.inMilliseconds.round());
    return [durationOfVideo?.inMinutes, durationOfVideo?.inSeconds]
        .map((seg) => seg?.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  String getDuration() {
    durationOfVideo = Duration(
        milliseconds: _controller.value.duration.inMilliseconds.round());
    return [durationOfVideo?.inMinutes, durationOfVideo?.inSeconds]
        .map((seg) => seg?.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  Duration? durationOfVideo;
  String duration = '';
  String position = '';
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _initializeVideoPlayerFuture = _controller.initialize().then((value) {
      durationOfVideo = Duration(
          milliseconds: _controller.value.duration.inMilliseconds.round());
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              width: widget.width,
              height: widget.height,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (opacity == 0) {
                          opacity = 1;
                        } else {
                          opacity = 0;
                        }
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: widget.width,
                          height: widget.height.h,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                        Positioned(
                            bottom: 10.h,
                            left: 10.w,
                            right: 10.w,
                            child: AnimatedOpacity(
                              opacity: opacity,
                              duration: const Duration(milliseconds: 1400),
                              child: Column(
                                children: [
                                  VideoProgressIndicator(_controller,
                                      colors: VideoProgressColors(
                                          bufferedColor:
                                              Colors.white.withOpacity(0.6),
                                          backgroundColor:
                                              Colors.white.withOpacity(0.6),
                                          playedColor: const Color.fromARGB(
                                              255, 230, 28, 13)),
                                      allowScrubbing: true),
                                  SizedBox(
                                    height: 40.h,
                                    width: 1.sw,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            getPosition(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            getDuration(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ]),
                                  )
                                ],
                              ),
                            )),
                        Align(
                          child: Container(
                            alignment: Alignment.center,
                            child: AnimatedOpacity(
                              opacity: opacity,
                              duration: const Duration(milliseconds: 500),
                              child: IconButton(
                                  iconSize: 60.sp,
                                  color: Colors.white,
                                  onPressed: () {
                                    _controller.value.isPlaying
                                        ? {_controller.pause(), opacity = 1}
                                        : {_controller.play(), opacity = 0};
                                    setState(() {});
                                  },
                                  icon: Icon(_controller.value.isPlaying
                                      ? Icons.pause
                                      : _controller.value.position.inSeconds ==
                                              _controller
                                                  .value.duration.inSeconds
                                          ? Icons.refresh
                                          : Icons.play_arrow)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
