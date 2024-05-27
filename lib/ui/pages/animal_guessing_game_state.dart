import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../models/animal.dart';
import '../../services/animal_services.dart';

class AnimalGuessingGame extends StatefulWidget {
  const AnimalGuessingGame({super.key});

  @override
  _AnimalGuessingGameState createState() => _AnimalGuessingGameState();
}

class _AnimalGuessingGameState extends State<AnimalGuessingGame> {
  final AudioPlayer audioPlayer = AudioPlayer();
  List<Animal> _animals = [];
  Animal? _correctAnimal;
  Animal? _selectedAnimal;
  String? _feedbackImage;
  bool _isLoading = true;
  bool isFeedbackVisible = false;
  List<Animal> animalsForRound = [];
  final AudioPlayer feedbackPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _fetchAnimals().then((_) {
      setState(() {
        _startGame();
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.stop();
    feedbackPlayer.stop();
    super.dispose();
  }

  Future<void> _fetchAnimals() async {
    final animals = await AnimalService.getAnimals();
    setState(() {
      _animals = animals;
    });
  }

  Future<void> _startGame() async {
    final shuffledAnimals = _animals.toList()..shuffle();
    animalsForRound = shuffledAnimals.take(4).toList();

    setState(() {
      _selectedAnimal = null;
      _correctAnimal = animalsForRound[Random().nextInt(animalsForRound.length)];
    });

    await audioPlayer.play(AssetSource(_correctAnimal!.audio));
  }

  void _checkAnswer(Animal selectedAnimal) {
    if (isFeedbackVisible) return; // Bloqueia cliques adicionais

    audioPlayer.stop();
    setState(() {
      isFeedbackVisible = true; // Mostra que o feedback está visível
      _selectedAnimal = selectedAnimal;
      if (_selectedAnimal == _correctAnimal) {
        _feedbackImage = 'assets/images/respostas/logo_acerto.png';
        feedbackPlayer.play(AssetSource('audio/respostas/success_fanfare.mp3'));
      } else {
        _feedbackImage = 'assets/images/respostas/logo_error_2.png';
        feedbackPlayer.play(AssetSource('audio/respostas/failure_fanfare.mp3'));
      }
    });

    // Esperar 3 segundos antes de reiniciar o jogo
    Future.delayed(const Duration(seconds: 3), () async {
      setState(() {
        _isLoading = true;
        isFeedbackVisible = false; // Permite interação novamente
      });
      await _startGame();
      setState(() {
        _isLoading = false;
        _feedbackImage = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('De quem é o som?'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double imageSize = min(constraints.maxWidth, constraints.maxHeight) * 0.9;
          const double minImageSize = 500.0; // Tamanho mínimo da imagem
          const double maxImageSize = 1000.0; // Tamanho máximo da imagem
          final double finalImageSize = imageSize.clamp(minImageSize, maxImageSize);

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    if (!_isLoading) ...[
                      const SizedBox(height: 24),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: List.generate(4, (index) {
                          final animal = animalsForRound[index];
                          return Builder(
                            builder: (context) => GestureDetector(
                              onTap: () => _checkAnswer(animal),
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
                                    Opacity(
                                      opacity: _selectedAnimal == animal ? 0.5 : 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: _selectedAnimal == animal
                                              ? Colors.blue.withOpacity(0.3)
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              if (_feedbackImage != null)
                Center(
                  child: Image.asset(
                    _feedbackImage!,
                    width: finalImageSize,
                    height: finalImageSize,
                  ),
                ),
              if (isFeedbackVisible)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
