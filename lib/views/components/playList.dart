import 'package:flutter/material.dart';
import 'package:hope_audio_slider/Controllers/audioControllers.dart';
import 'package:get/get.dart';

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  final AudioController audioController = Get.find();

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {

    // });
    audioController.isDialogOpen.value = true;
  }

  @override
  void dispose() {
    audioController.isDialogOpen.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        audioController.isDialogOpen.value = false;
        return true;
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.55,
        minChildSize: 0.55,
        maxChildSize: 0.56,
        builder: (context, scrollController) {
          return Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Obx(() => SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          audioController.currentMediaItem.value?.title ??
                              "Audio Player",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow),
                        ),
                        const SizedBox(height: 10),
                        Obx(() {
                          final position = audioController.position.value;
                          final duration = audioController.duration.value;

                          return Text(
                            "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')} / "
                            "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
                          );
                        }),
                        Obx(() {
                          return Slider(
                            value: audioController.position.value.inSeconds
                                .toDouble(),
                            min: 0.0,
                            max: 65.0.toDouble(),
                            onChanged: (value) {
                              audioController.audioPlayer
                                  .seek(Duration(seconds: value.toInt()));
                            },
                          );
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.skip_previous),
                              onPressed: audioController.playPrevious,
                            ),
                            IconButton(
                              icon: Icon(
                                audioController.isPlaying.value
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                              onPressed: audioController.togglePlayPause,
                            ),
                            IconButton(
                              icon: const Icon(Icons.skip_next),
                              onPressed: audioController.playNext,
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: audioController.tracks.length,
                          itemBuilder: (context, index) {
                            String trackTitle =
                                audioController.tracks[index].title ??
                                    "Track ${index + 1}";

                            bool isPlaying =
                                audioController.currentMediaItem.value?.title ==
                                    trackTitle;

                            return ListTile(
                              leading: Icon(
                                Icons.music_note,
                                color: isPlaying ? Colors.yellow : Colors.white,
                              ),
                              title: Text(
                                trackTitle,
                                style: TextStyle(
                                  color:
                                      isPlaying ? Colors.yellow : Colors.white,
                                  fontWeight: isPlaying
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              tileColor: isPlaying
                                  ? Colors.black.withOpacity(0.7)
                                  : Colors.transparent,
                              onTap: () {
                                audioController.playTrack(index);
                              },
                            );
                          },
                        )
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}
