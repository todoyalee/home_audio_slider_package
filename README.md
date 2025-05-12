# 🎵 hope_audio_slider

A sleek, customizable audio slider widget built with Flutter. Designed for seamless integration with the [`just_audio`](https://pub.dev/packages/just_audio) ecosystem and `GetX`, this package gives you full control over your audio playback UI — with **live stream updates**, **background playback support**, and **snappy design**.

---

## 🚀 Features

✅ Plug-and-play audio slider  
✅ Built on top of `just_audio` and `just_audio_background`  
✅ Works with `Stream<Duration>` from `just_audio.positionStream`  
✅ GetX-friendly — reactive and clean  
✅ Fully customizable  
✅ Smooth seek and scrubbing interactions  
✅ Works in the background with notifications

---

## Dependecies:

just_audio: ^0.9.36
just_audio_background: ^0.0.1
get: ^4.6.6

## 📦 Installation

Add this to your `pubspec.yaml`:

dependencies:
hope_audio_slider:
git:
url: https://github.com/todoyalee/edusm_audio2

## Usage

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:hope_audio_slider/hope_audio_slider.dart';

class MyAudioPlayer extends StatelessWidget {
final AudioPlayer player = AudioPlayer();

MyAudioPlayer() {
player.setUrl('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text('Hope Audio Slider')),
body: Center(
child: HopeAudioSlider(
audioPlayer: player,
activeTrackColor: Colors.blueAccent,
thumbColor: Colors.white,
onSeek: (position) {
player.seek(position);
},
),
),
);
}
}

For more advanced examples, see the /example folder.

## Contributing

Pull requests are welcome. If you find a bug or have a feature request, feel free to open an issue.
