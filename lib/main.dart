import 'package:bixinhos/ui/pages/my_home_page.dart';
import 'package:bixinhos/utils/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyAnimalSoundApp());
}

class MyAnimalSoundApp extends StatelessWidget {
  const MyAnimalSoundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()..loadLocale()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: languageProvider.locale,
            title: 'Animais',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const MyHomePage(title: 'Sons animais divertidos'),
          );
        },
      ),
    );
  }
}
