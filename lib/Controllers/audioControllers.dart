import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioController extends GetxController {
  //final AudioPlayer  audioSeek = AudioPlyer();
  final AudioPlayer audioPlayer = AudioPlayer();
  final RxBool isPlaying = false.obs;
  final RxList<MediaItem> playlist = <MediaItem>[].obs;
  final Rx<Duration> position = Duration.zero.obs;
  final Rx<Duration> duration = Duration.zero.obs;
  var isDialogOpen = false.obs;
  final Rxn<MediaItem> currentMediaItem = Rxn<MediaItem>();
  final RxBool isPlayedEnough = false.obs;

  final _playList = ConcatenatingAudioSource(children: [
    /*
     var audioSource = _playList.children[index];
    var mediaItem = audioSource as MediaItem;

*/

    AudioSource.uri(
      Uri.parse(
          'https://dev.edums.tn/uploads/syllabus/183b4709-b81f-4d1f-970f-b801ccc2e91f.weba'),
      tag: MediaItem(
        id: '0',
        title: 'Anglais Skill Talk',
        artist: 'Prof. Slim',
        artUri: Uri.parse('https://via.placeholder.com/300'),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          'https://dev.edums.tn/uploads/syllabus/183b4709-b81f-4d1f-970f-b801ccc2e91f.weba'),
      tag: MediaItem(
        id: '1',
        title: 'Ted Talk Science',
        artist: 'Prof. Alaa',
        artUri: Uri.parse('https://via.placeholder.com/300'),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          'https://dev.edums.tn/uploads/syllabus/183b4709-b81f-4d1f-970f-b801ccc2e91f.weba'),
      tag: MediaItem(
        id: '2',
        title: 'Arabe Study',
        artist: 'Prof. Mr. Mohamed',
        artUri: Uri.parse('https://via.placeholder.com/300'),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          'https://dev.edums.tn/uploads/syllabus/183b4709-b81f-4d1f-970f-b801ccc2e91f.weba'),
      tag: MediaItem(
        id: '3',
        title: 'Philo Study',
        artist: 'Prof. Anis',
        artUri: Uri.parse('https://via.placeholder.com/300'),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          'https://dev.edums.tn/uploads/syllabus/183b4709-b81f-4d1f-970f-b801ccc2e91f.weba'),
      tag: MediaItem(
        id: '4',
        title: 'Math Saving',
        artist: 'Prof. Dali',
        artUri: Uri.parse('https://via.placeholder.com/300'),
      ),
    ),
  ]);
  // Getter to expose the tracks
  List<MediaItem> get tracks => _playList.children
      .whereType<UriAudioSource>()
      .map((audioSource) => audioSource.tag as MediaItem)
      .toList();
  @override
  void onInit() {
    super.onInit();
    _initializePlayer();
  }

  void _initializePlayer() async {
    await audioPlayer.setAudioSource(_playList);
    audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });
    audioPlayer.positionStream.listen((pos) {
      position.value = pos;
      if (pos.inSeconds > 0.2) {
        isPlayedEnough.value = true;
      }
    });

    audioPlayer.positionStream.listen((pos) {
      position.value = pos;
    });

    audioPlayer.durationStream.listen((dur) {
      duration.value = dur ?? Duration.zero;
    });

    audioPlayer.sequenceStateStream.listen((sequenceState) {
      if (sequenceState?.currentSource?.tag is MediaItem) {
        currentMediaItem.value = sequenceState?.currentSource?.tag as MediaItem;
      }
    });
  }

  void playTrack(int index) async {
    // Ensure the index is valid

    if (index < 0 || index >= _playList.children.length) {
      print("Invalid track index: $index");
      return;
    }

    var audioSource = _playList.children[index];

    try {
      await audioPlayer.seek(Duration.zero, index: index);
      await audioPlayer.play();

      if (audioSource is ProgressiveAudioSource) {
        currentMediaItem.value = MediaItem(
          id: currentMediaItem.value!.id,
          album: currentMediaItem.value!.album ?? "Unknown Album",
          title: currentMediaItem.value!.title ?? "Unknown Title",
          artist: currentMediaItem.value!.artist ?? "Unknown Artist",
        );
      }
    } catch (e) {
      print("Error playing track: $e");
    }
  }

  void togglePlayPause() {
    if (isPlaying.value) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
  }

  void playNext() async {
    try {
      await audioPlayer.seekToNext();
    } catch (e) {
      print("No next audio source: $e");
    }
  }

  void playPrevious() async {
    try {
      await audioPlayer.seekToPrevious();
    } catch (e) {
      print("No previous audio source: $e");
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
