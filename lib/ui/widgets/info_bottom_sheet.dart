import 'package:bixinhos/services/audio_service.dart';
import 'package:flutter/material.dart';

import '../../models/animal.dart';

class InfoBottomSheet extends StatefulWidget {
  final Animal animal;
  final AudioService audioService;

  const InfoBottomSheet({Key? key, required this.animal, required this.audioService}) : super(key: key);

  @override
  State<InfoBottomSheet> createState() => _InfoBottomSheetState();
}

class _InfoBottomSheetState extends State<InfoBottomSheet> with ChangeNotifier {
  bool musicPlayng = true;

  @override
  void dispose() {
    super.dispose();
    widget.audioService.stop();
  }

  @override
  void initState() {
    super.initState();
    //widget.audioService.play(AssetSource(widget.animal.audio));
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<IconData> iconNotifier =
    ValueNotifier(Icons.play_circle_outline_outlined);

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Stack(
            children: [
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
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 150,
                child: ClipRRect(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent
                        ],
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
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  iconSize: 56,
                  icon: ValueListenableBuilder<IconData>(
                      valueListenable: iconNotifier,
                      builder: (context, value, child) =>
                          Icon(
                              musicPlayng
                                  ? Icons.pause_circle_outline_outlined
                                  : Icons.play_circle_outline_outlined,
                              color: Colors.white)),
                  onPressed: () async {
                    tocarPararMusica();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> tocarPararMusica() async {
    if (musicPlayng) {
      await widget.audioService.stop();
      musicPlayng = false;
    } else {
      await widget.audioService.playAnimalSound(widget.animal.audio);
      musicPlayng = true;
    }
    setState(() {});
  }

}
