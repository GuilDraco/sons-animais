import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animais',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Animais'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Animal> animais = [
    Animal('Cachorro', 'assets/images/cachorrinho.jpg', 'assets/audio/cachorro.mp3', 'O cachorro é um animal doméstico popular, conhecido por sua lealdade e inteligência.'),
    Animal('Gata', 'assets/images/gatinha.jpg', 'assets/audio/gato.mp3', 'A gata é um animal doméstico independente e brincalhão, conhecido por sua agilidade e graça.'),
    Animal('Vaca', 'assets/images/vaquinha.jpg', 'assets/audio/vaca.mp3', 'A vaca é um animal de fazenda importante, conhecida por sua produção de leite e carne.'),
    Animal('Ovelha', 'assets/images/ovelha.jpg', 'audio/ovelha.mp3', 'A ovelha é um animal de fazenda dócil e sociável, conhecida por sua lã macia.'),
    Animal('Aranha', 'assets/images/aranha.jpg', 'assets/audio/ovelha.mp3', 'A aranha é um aracnídeo com oito patas, muitas vezes temido por sua teia e veneno.'),
    Animal('Cabrito', 'assets/images/cabrito.jpg', 'assets/audio/ovelha.mp3', 'O cabrito é um animal de fazenda jovem e brincalhão, conhecido por sua energia e vitalidade.'),
    Animal('Cavalo', 'assets/images/cavalo.jpg', 'assets/audio/ovelha.mp3', 'O cavalo é um animal de grande porte, conhecido por sua força e velocidade.'),
    Animal('Galinha', 'assets/images/galinha.jpg', 'assets/audio/ovelha.mp3', 'A galinha é uma ave doméstica popular, conhecida por sua produção de ovos.'),
    Animal('Galo', 'assets/images/galo.jpg', 'assets/audio/ovelha.mp3', 'O galo é uma ave doméstica conhecida por seu canto matinal e por proteger as galinhas.'),
    Animal('Grilo', 'assets/images/grilo.jpg', 'assets/audio/ovelha.mp3', 'O grilo é um inseto conhecido por seu canto estridente e por seus saltos acrobáticos.'),
    Animal('Hipopotamo', 'assets/images/hipopotamo.jpg', 'assets/audio/ovelha.mp3', 'O hipopótamo é um animal semi-aquático de grande porte, conhecido por sua natureza territorial e agressiva.'),
    Animal('Macaco', 'assets/images/macaquinho.jpg', 'assets/audio/ovelha.mp3', 'O macaco é um primata conhecido por sua inteligência e habilidades acrobáticas.'),
    Animal('Porco', 'assets/images/porquinho.jpg', 'assets/audio/ovelha.mp3', 'O porco é um animal de fazenda conhecido por sua inteligência e sociabilidade.'),
    Animal('Urso', 'assets/images/ursinho.jpg', 'assets/audio/ovelha.mp3', 'O urso é um animal selvagem de grande porte, conhecido por sua força e hibernação.'),
    Animal('Zebra', 'assets/images/zebra.jpg', 'assets/audio/ovelha.mp3', 'A zebra é um animal selvagem herbívoro, conhecido por suas listras pretas e brancas.'),
  ];

  final AudioPlayer audioPlayer = AudioPlayer();
  bool musicPlayng = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(animais.length, (index) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          /*await audioPlayer.stop();
                          await audioPlayer.play(
                            AssetSource(animais[index].audio),
                          );*/
                        },
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
                                top: 2,
                                right: 2,
                                child: IconButton(
                                  iconSize: 38,
                                  icon: Icon(Icons.play_circle_outline_outlined, color: Colors.white,),
                                  onPressed: () async {
                                    //await audioPlayer.stop(); // Stop any previously playing sound
                                    await audioPlayer.play(AssetSource(animais[index].audio));
                                    musicPlayng = true;
                                    showAnimalInfo(context, animais[index]);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ... rest of your card content
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAnimalInfo(BuildContext context, Animal animal) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                  // Image covering the entire BottomSheet with rounded corners
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Image.asset(
                      animal.imagem,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  // Padding for the text, positioned below the expanded image
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
                            animal.info,
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

                  // Pause button positioned at the top right
                  Positioned(
                    top: 5,
                    right: 5,
                    child: IconButton(
                      iconSize: 56,
                      icon: Icon(
                        musicPlayng ? Icons.pause_circle_outline_outlined : Icons.play_circle_outline_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        if (musicPlayng) {
                          await audioPlayer.pause();
                          musicPlayng = false;
                        } else {
                          await audioPlayer.resume();
                          musicPlayng = true;
                        }
                        setState(() {}); // Update the icon
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class Animal {
  final String nome;
  final String imagem;
  final String audio;
  final String info;

  Animal(this.nome, this.imagem, this.audio, this.info);
}

