// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   final String videoPath;

//   const VideoPlayerWidget({super.key, required this.videoPath});

//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();

//     _controller = VideoPlayerController.asset(widget.videoPath)
//       ..setLooping(true)
//       ..setVolume(0)
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _controller.value.isInitialized
//         ? FittedBox(
//             fit: BoxFit.cover,
//             child: SizedBox(
//               width: _controller.value.size.width,
//               height: _controller.value.size.height,
//               child: VideoPlayer(_controller),
//             ),
//           )
//         : const Center(child: CircularProgressIndicator());
//   }
// }
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath; // Loom MP4 url or Asset MP4

  const VideoPlayerWidget({super.key, required this.videoPath});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    final isNetwork = widget.videoPath.startsWith('http');

    _controller = isNetwork
        ? VideoPlayerController.networkUrl(Uri.parse(widget.videoPath))
        : VideoPlayerController.asset(widget.videoPath);

    _controller
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
