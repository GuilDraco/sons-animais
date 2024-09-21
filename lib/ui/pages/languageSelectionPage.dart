import 'package:bixinhos/utils/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecione o Idioma"),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Português (Brasil)"),
            onTap: () {
              Provider.of<LanguageProvider>(context, listen: false).setLocale(const Locale('pt', 'BR'));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("English"),
            onTap: () {
              Provider.of<LanguageProvider>(context, listen: false).setLocale(const Locale('en', 'US'));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
