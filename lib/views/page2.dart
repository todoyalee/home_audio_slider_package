import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hope_audio_slider/Controllers/audioControllers.dart';
import 'package:hope_audio_slider/views/components/appbarAudio.dart';
import 'package:hope_audio_slider/views/components/playList.dart'; // Assuming you have the Playlist widget

class Page2 extends StatelessWidget {
  final AudioController audioController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(audioController: audioController),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'This is Page 2',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            // Obx(() {
            //   return audioController.isPlaying.value
            //       ? Expanded(
            //           child: Playlist(),
            //         )
            //       : Container();
            // }),
          ],
        ),
      ),
    );
  }
}
