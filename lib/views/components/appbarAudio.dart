import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hope_audio_slider/Controllers/audioControllers.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AudioController audioController;

  const CustomAppBar({super.key, required this.audioController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final mediaItem = audioController.currentMediaItem.value;
      final isAudioLoaded = mediaItem != null;
      final isPlaying = audioController.isPlaying.value;

      //final bool defaultt = false;

      return AppBar(
        leading: audioController.isPlaying.value &&
                !audioController.isDialogOpen.value
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : SizedBox.shrink(),
        title: Column(
          children: [
            Text(
              audioController.isPlaying.value &&
                      audioController.isDialogOpen.value == false
                  ? (mediaItem?.title ?? "Unknown Title")
                  : "",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              audioController.isPlaying.value &&
                      audioController.isDialogOpen.value == false
                  ? mediaItem?.artist ?? ""
                  : "",
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
          ],
        ),
        actions: [
          if (audioController.isDialogOpen.value == false &&
              audioController.isPlaying.value) ...[
            Slider(
              value: audioController.position.value.inSeconds.toDouble(),
              min: 0.0,
              max: 65.0,
              onChanged: (value) {
                audioController.audioPlayer
                    .seek(Duration(seconds: value.toInt()));
              },
            ),
            IconButton(
              icon: const Icon(Icons.skip_previous),
              onPressed: audioController.playPrevious,
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: audioController.playNext,
            ),
            IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () => {
                      print(
                          "Cancel clicked, stopping audio and removing pause icon"),
                      audioController.audioPlayer.stop(),
                      audioController.isPlayedEnough.value = false,
                      audioController.isPlaying.value = false,
                      audioController.isDialogOpen.value =
                          false, // Close dialog
                    }),
          ],
          if (!audioController.isDialogOpen.value &&
              audioController.isPlayedEnough.value) ...[
            // Only show the play/pause button if the dialog is not open
            if (!audioController.isDialogOpen.value)
              IconButton(
                icon: Icon(
                  audioController.isPlaying.value &&
                          audioController.isPlayedEnough.value
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                onPressed: audioController.togglePlayPause,
              ),
          ]
        ],
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
