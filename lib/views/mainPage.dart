import 'package:flutter/material.dart';
import 'package:hope_audio_slider/Controllers/audioControllers.dart';
import 'package:get/get.dart';
import 'package:hope_audio_slider/views/page1.dart';
import 'package:hope_audio_slider/views/page2.dart';
import 'package:hope_audio_slider/views/components/appbarAudio.dart';
import 'package:hope_audio_slider/views/components/playList.dart';
import 'package:hope_audio_slider/Routes/app_routes.dart';

class MainPage extends StatelessWidget {
  final AudioController audioController = Get.put(AudioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(audioController: audioController),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Get.to(() => Page1()),
              child: const Text(
                'Go to Page 1',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Get.to(() => Page2()),
              child: const Text(
                'Go to Page 2',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ),
            // Obx(() {
            //   return audioController.isPlaying.value
            //       ? Expanded(child: Playlist())
            //       : Container();
            // }),
          ],
        ),
      ),
    );
  }
}
