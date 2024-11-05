import 'package:flutter/material.dart';

class MenuServices {
  Map<String, List<String>> options = {
    'pt': ["Que animal sou eu?", "Jogo da memória", "Vamos desenhar?", "Linguagem"],
    'en': ["Which animal am I?", "Memory Game", "Let's Draw?", "Language"],
  };

  Map<String, List<String>> subtitle = {
    'pt': [
      // "Nos ajude avaliando nosso App.",
      "Jogo adivinhe de quem é o som",
      "Se divirta nesse jogo da memória",
      "Brincar de desenho",
      ""
    ],
    'en': [
      // "Help us by rating our App.",
      "Guess which animal makes the sound",
      "Have fun in this memory game",
      "Have fun drawing",
      ""
    ],
  };

  List<Icon> icons = [
    //const Icon(Icons.star, color: Colors.blue),
    const Icon(Icons.question_answer, color: Colors.blue),
    const Icon(Icons.lightbulb, color: Colors.blue),
    const Icon(Icons.format_paint, color: Colors.blue),
    const Icon(Icons.language, color: Colors.blue),
  ];

  List<String> getOptions(String langCode) {
    return options[langCode] ?? options['pt']!;
  }

  List<String> getSubtitles(String langCode) {
    return subtitle[langCode] ?? subtitle['pt']!;
  }
}
