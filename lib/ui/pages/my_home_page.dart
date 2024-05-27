import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../models/animal.dart';
import '../../services/animal_services.dart';
import '../widgets/info_bottom_sheet.dart';
import 'animal_guessing_game_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  List<String> options = ["Avalie o App", "Que animal sou eu?", "Adivinhe qual é?"];

  List<String> subtitle = ["Nos ajude avaliando nosso App.",
    "Jogo adivinhe de quem é o som", "Jogo adivinhe o animal correto"];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Icon> icons = [
    const Icon(Icons.star, color: Colors.blue),
    const Icon(Icons.question_answer, color: Colors.blue),
    const Icon(Icons.lightbulb, color: Colors.blue),
  ];

  Animal? _randomAnimal;

  @override
  void initState() {
    super.initState();
    _fetchAnimals();
  }

  Future<void> _fetchAnimals() async {
    final animals = await AnimalService.getAnimals();
    if (mounted) {
      setState(() {
        _randomAnimal = animals.isNotEmpty ? animals[Random().nextInt(animals.length)] : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      appBar: AppBar(
        title: Text(widget.title,), // Set the app bar title
        leading: IconButton(
          icon: const Icon(Icons.menu), // Sandwich menu icon
          onPressed: () => _scaffoldKey.currentState!.openDrawer(), // Open the drawer
        ),
      ),
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
      drawer: Drawer(
        //backgroundColor: Colors.blue,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(_randomAnimal?.imagem ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
              child: null,
            ),
            for(int i = 0; i < options.length; i++)
              ListTile(
                textColor: Colors.blue,
                leading: icons[i],
                subtitle: Text(subtitle[i]),
                title: Text(options[i],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                onTap: (){
                  if (i == 1) { // Check if it's the "Adivinhe qual é?" option (index 1)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnimalGuessingGame()),
                    );
                  }
                },
              ),
            const SizedBox(height:200),
            Container(
              alignment: Alignment.bottomLeft, // Center the text horizontally
              padding: const EdgeInsets.symmetric(horizontal: 24), // Add some padding
              child: const Text(
                "Desenvolvido por Guilherme Alves",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
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