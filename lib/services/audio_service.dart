import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer audioPlayer = AudioPlayer();

  void setAudioCompleteListener(Function onComplete) {
    audioPlayer.onPlayerComplete.listen((event) {
      onComplete();
    });
  }

  Future<void> playAnimalSound(String audioPath) async {
    await audioPlayer.play(AssetSource(audioPath));
  }

  Future<void> stop() async {
    await audioPlayer.stop();
  }
}
