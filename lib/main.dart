import 'package:bixinhos/ui/pages/my_home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyAnimalSoundApp());
}

class MyAnimalSoundApp extends StatelessWidget {
  const MyAnimalSoundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animais',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Sons animais divertidos'),
    );
  }
}
