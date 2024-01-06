// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class pick_video extends StatefulWidget {
  @override
  _pick_videoState createState() => _pick_videoState();
}

class _pick_videoState extends State<pick_video> {
  File? _pickedVideo;
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
        ''); // Empty path to initialize, will be updated later
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      autoPlay: false,
      looping: false,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    final pickedFile =
        await ImagePicker().getVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedVideo = File(pickedFile.path);
        _videoPlayerController = VideoPlayerController.file(_pickedVideo!);
        _chewieController = ChewieController(
            draggableProgressBar: true,
            videoPlayerController: _videoPlayerController,
            aspectRatio: _videoPlayerController.value.aspectRatio,
            autoPlay: true,
            looping: false,
            cupertinoProgressColors: ChewieProgressColors(
                bufferedColor: Colors.blue, backgroundColor: Colors.white),
            allowFullScreen: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Video Picker'),
      ),
      body: Center(
        child: _pickedVideo == null
            ? const Text('No video selected.')
            : Chewie(
                controller: _chewieController,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickVideo,
        tooltip: 'Pick Video',
        child: const Icon(Icons.video_library),
      ),
    );
  }
}
