import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';

class Audioplayer extends StatefulWidget {
  const Audioplayer({super.key});

  @override
  State<Audioplayer> createState() => _AudioplayerState();
}

class _AudioplayerState extends State<Audioplayer> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer()..setAsset("assets/hardwork.mp3");
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.abc))],
      ),
    );
  }
}
