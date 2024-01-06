// ignore: file_names
// ignore_for_file: prefer_final_fields

import 'dart:io';
import 'package:chewie_audio/chewie_audio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';

class Music_page extends StatefulWidget {
  @override
  _Music_pageState createState() => _Music_pageState();
}

class _Music_pageState extends State<Music_page> {
  AudioPlayer _audioPlayer = AudioPlayer();
  ChewieAudioController? _chewieAudioController;
  String? _pickedAudioPath;

  @override
  void initState() {
    super.initState();
    _chewieAudioController = ChewieAudioController(
      autoPlay: false,
      looping: false,
      allowMuting: true,
      showControls: true,
      showControlsOnInitialize: false,
      videoPlayerController: VideoPlayerController.asset(""),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _chewieAudioController?.dispose();
    super.dispose();
  }

  Future<void> _pickAudio() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null) {
      setState(() {
        _pickedAudioPath = result.files.single.path!;
        _initializeChewie();
      });
    }
  }

  void _initializeChewie() {
    _chewieAudioController?.dispose();
    _chewieAudioController = ChewieAudioController(
      videoPlayerController:
          VideoPlayerController.file(File(_pickedAudioPath!)),
      autoPlay: false,
      looping: false,
      allowMuting: true,
      playbackSpeeds: [0.5, 1.0, 1.5, 2.0],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
      ),
      body: Center(
        child: _pickedAudioPath == null
            ? const Text('No audio selected.')
            : ChewieAudio(controller: _chewieAudioController!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickAudio,
        tooltip: 'Pick Audio',
        child: const Icon(Icons.music_note),
      ),
    );
  }
}
