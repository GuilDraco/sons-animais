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
  String _feedback = '';
  bool _isLoading = true;
  List<Animal> animalsForRound = [];

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
    super.dispose();
    audioPlayer.stop();
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
    audioPlayer.stop();
    setState(() {
      _selectedAnimal = selectedAnimal;
      if (_selectedAnimal == _correctAnimal) {
        _feedback = 'Parabéns! Você acertou!';
      } else {
        _feedback = 'Errado! O animal era ${_correctAnimal!.nome}.';
      }
    });

    // Esperar 4 segundos antes de reiniciar o jogo
    Future.delayed(const Duration(seconds: 4), () async {
      setState(() {
        _isLoading = true;
      });
      await _startGame();
      setState(() {
        _isLoading = false;
        _feedback = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo do Som'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                if (!_isLoading) ...[
                  const Text(
                    'De quem é o som?',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
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
                  Text(
                    _feedback,
                    style: const TextStyle(fontSize: 18),
                  ),
                ]
              ],
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
