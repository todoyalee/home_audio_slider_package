import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hope_audio_slider/Controllers/audioControllers.dart';
import 'package:hope_audio_slider/views/components/appbarAudio.dart';
import 'package:hope_audio_slider/views/components/playList.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final AudioController audioController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(audioController: audioController),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  //audioController.isDialogOpen.value = true;
                  onPressed: _showAudioControlDialog,

                  //() {
                  //audioController.isDialogOpen.value = true;

                  color: Theme.of(context).colorScheme.primary,
                  child: const Text(
                    "Open Audio Controls",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Obx(() {
          //   return audioController.isPlaying.value ? Playlist() : Container();
          // }),
        ],
      ),
    );
  }

  void _showAudioControlDialog() {
    audioController.isDialogOpen.value = true;

    Get.dialog(Playlist());
  }
}
