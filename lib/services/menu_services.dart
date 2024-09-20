import 'package:flutter/material.dart';

class MenuServices {
  List<String> options = ["Avalie o App", "Que animal sou eu?", "Jogo da memória", "Vamos desenhar?"];

  List<String> subtitle = [
    "Nos ajude avaliando nosso App.",
    "Jogo adivinhe de quem é o som",
    "Se divirta nesse jogo da memória",
    "Brincar de desenho"
  ];

  List<Icon> icons = [
    const Icon(Icons.star, color: Colors.blue),
    const Icon(Icons.question_answer, color: Colors.blue),
    const Icon(Icons.lightbulb, color: Colors.blue),
    const Icon(Icons.lightbulb, color: Colors.blue),
  ];
}
