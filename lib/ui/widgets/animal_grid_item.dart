import 'package:bixinhos/models/animal.dart';
import 'package:bixinhos/services/audio_service.dart';
import 'package:bixinhos/ui/widgets/info_bottom_sheet.dart';
import 'package:flutter/material.dart';

class AnimalGridItem extends StatelessWidget {
  final Animal animal;
  final AudioService audioService = AudioService();

  AnimalGridItem({Key? key, required this.animal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    animal.imagem,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  child: Align(
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: 0.5,
                      child: IconButton(
                        iconSize: 86,
                        icon: const Icon(
                          Icons.play_circle_outline_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => InfoBottomSheet(
                              animal: animal,
                              audioService: audioService,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          left: 4,
          right: 4,
          height: 40,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    animal.nome,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
