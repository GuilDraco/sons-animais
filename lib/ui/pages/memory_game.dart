import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:bixinhos/utils/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/animal.dart';
import '../../services/animal_services.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({Key? key}) : super(key: key);

  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  final AudioPlayer successPlayer = AudioPlayer();
  final AudioPlayer errorPlayer = AudioPlayer();
  List<Animal> _animals = [];
  List<Animal> _shuffledAnimals = [];
  List<bool> _revealedCards = [];
  List<int> _selectedCards = [];
  bool _isLoading = true;
  int _pairsFound = 0;
  int _numPairs = 2; // Começa com 2 pares
  bool _showSuccessImage = false;

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
    successPlayer.dispose();
    errorPlayer.dispose();
    super.dispose();
  }

  Future<void> _fetchAnimals() async {
    final langCode = Provider.of<LanguageProvider>(context, listen: false).locale.languageCode;
    final animals = await AnimalService.getAnimals(langCode);
    setState(() {
      _animals = animals;
    });
  }

  void _startGame() {
    _shuffledAnimals = _animals.toList()..shuffle();
    _shuffledAnimals = (_shuffledAnimals.take(_numPairs).toList()..addAll(_shuffledAnimals.take(_numPairs).toList()))..shuffle();
    _revealedCards = List.filled(_shuffledAnimals.length, false);
    _selectedCards = [];
    _pairsFound = 0;
  }

  void _onCardTap(int index) {
    successPlayer.stop();
    errorPlayer.stop();
    if (_revealedCards[index] || _selectedCards.length == 2) return;

    setState(() {
      _revealedCards[index] = true;
      _selectedCards.add(index);
    });

    if (_selectedCards.length == 2) {
      if (_shuffledAnimals[_selectedCards[0]] == _shuffledAnimals[_selectedCards[1]]) {
        successPlayer.play(AssetSource('audio/memoria/card_correct.mp3'));
        setState(() {
          _pairsFound++;
          _selectedCards = [];
        });

        // Verificar se todos os pares foram encontrados
        if (_pairsFound == _numPairs) {
          setState(() {
            _showSuccessImage = true;
          });

          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              _showSuccessImage = false;
              if (_numPairs < 4) {
                _numPairs++; // Aumenta o número de pares até o máximo de 8 pares
              }
              _startGame();
            });
          });
        }
      } else {
        errorPlayer.play(AssetSource('audio/memoria/card_error.mp3'));
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _revealedCards[_selectedCards[0]] = false;
            _revealedCards[_selectedCards[1]] = false;
            _selectedCards = [];
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<LanguageProvider>(
          builder: (context, languageProvider, _) {
            String title = languageProvider.locale.languageCode == 'en'
                ? 'Memory game'
                : 'Jogo da memória';
            return Text(title);
          },
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double imageSize = min(constraints.maxWidth, constraints.maxHeight) * 0.5;
          const double minImageSize = 500.0; // Tamanho mínimo da imagem
          const double maxImageSize = 1000.0; // Tamanho máximo da imagem
          final double finalImageSize = imageSize.clamp(minImageSize, maxImageSize);

          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: _shuffledAnimals.length,
                itemBuilder: (context, index) {
                  final animal = _shuffledAnimals[index];
                  return GestureDetector(
                    onTap: () => _onCardTap(index),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: [
                            // Imagem do animal
                            _revealedCards[index]
                                ? Image.asset(animal.imagem, fit: BoxFit.cover)
                                : Image.asset('assets/images/memoria/logo_verso_carta.jpg', fit: BoxFit.cover),
                            // Gradiente e texto na parte inferior do cartão
                            if (_revealedCards[index])
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  child: Container(
                                    height: 40, // altura fixa para o gradiente e texto
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
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Text(
                                          animal.nome,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              if (_showSuccessImage)
                Center(
                  child: Image.asset(
                    'assets/images/respostas/logo_acerto.png',
                    width: finalImageSize,
                    height: finalImageSize,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
