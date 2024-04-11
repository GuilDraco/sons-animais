import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../models/animal.dart';
import '../../services/animal_services.dart';
import '../widgets/info_bottom_sheet.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: FutureBuilder<List<Animal>>(
          future: AnimalService.getAnimals(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Animal> animais = snapshot.data!;
              return _buildGridView(animais);
            } else if (snapshot.hasError) {
              return const Text('Erro ao carregar os imagens dos animais');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _buildGridView(List<Animal> animais) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(animais.length, (index) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () async {},
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                // Add the info button to the top right corner
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        animais[index].imagem,
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
                            onPressed: () async {
                              await audioPlayer.play(
                                  AssetSource(animais[index].audio));
                              setState(() {
                                  showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) =>
                                      InfoBottomSheet(
                                        animal: animais[index],
                                        audioPlayer: audioPlayer,
                                      ),
                                  );
                                }
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
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        animais[index].nome,
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
      }),
    );
  }
}