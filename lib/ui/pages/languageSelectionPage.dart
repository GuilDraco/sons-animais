import 'package:bixinhos/utils/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TermsPage.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecione o Idioma"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: ListTile(
                title: const Text("Português (Brasil)"),
                onTap: () {
                  Provider.of<LanguageProvider>(context, listen: false)
                      .setLocale(const Locale('pt', 'BR'));
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              child: ListTile(
                title: const Text("English"),
                onTap: () {
                  Provider.of<LanguageProvider>(context, listen: false)
                      .setLocale(const Locale('en', 'US'));
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.policy),
              title: const Text("Termos do Aplicativo"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TermsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
