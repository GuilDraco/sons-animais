import 'package:bixinhos/models/animal.dart';
import 'package:bixinhos/services/audio_service.dart';
import 'package:flutter/material.dart';

class InfoBottomSheet extends StatefulWidget {
  final Animal animal;
  final AudioService audioService;

  const InfoBottomSheet({Key? key, required this.animal, required this.audioService}) : super(key: key);

  @override
  State<InfoBottomSheet> createState() => _InfoBottomSheetState();
}

class _InfoBottomSheetState extends State<InfoBottomSheet> {
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _playSound();
  }

  Future<void> _playSound() async {
    await widget.audioService.playAnimalSound(widget.animal.audio);
  }

  @override
  void dispose() {
    widget.audioService.stop(); // Parando o áudio ao fechar o modal
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          // Imagem do animal
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.asset(
              widget.animal.imagem,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Informações do animal
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 150,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.animal.info,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // Botão de tocar/parar música
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              iconSize: 56,
              icon: Icon(isPlaying
                  ? Icons.pause_circle_outline_outlined
                  : Icons.play_circle_outline_outlined),
              color: Colors.white,
              onPressed: () {
                _togglePlayPause();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _togglePlayPause() async {
    if (isPlaying) {
      await widget.audioService.audioPlayer.pause();
    } else {
      await widget.audioService.audioPlayer.resume();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }
}
