import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playAnimalSound(String audioPath) async {
    await audioPlayer.play(AssetSource(audioPath));
  }

  Future<void> stop() async {
    await audioPlayer.stop();
  }
}
