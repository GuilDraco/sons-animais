import 'package:bixinhos/utils/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bixinhos/models/animal.dart';
import 'package:bixinhos/services/animal_services.dart';
import 'package:bixinhos/services/menu_services.dart';
import 'package:bixinhos/ui/widgets/animal_grid_item.dart';
import 'package:bixinhos/ui/widgets/menu_item.dart';
import 'package:bixinhos/ui/pages/vamos_colorir_game.dart';
import 'package:bixinhos/ui/pages/memory_game.dart';
import 'animal_guessing_game_state.dart';
import 'languageSelectionPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MenuServices menuServices = MenuServices();
  Animal? _randomAnimal;

  @override
  void initState() {
    super.initState();
    _fetchRandomAnimal();
  }

  Future<void> _fetchRandomAnimal() async {
    final langCode = Provider.of<LanguageProvider>(context, listen: false).locale.languageCode;
    _randomAnimal = await AnimalService.getRandomAnimal(langCode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final langCode = Provider.of<LanguageProvider>(context).locale.languageCode;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Consumer<LanguageProvider>(
          builder: (context, languageProvider, _) {
            String title = languageProvider.locale.languageCode == 'en'
                ? 'Fun Animal Sound'
                : 'Sons de animais divertidos';
            return Text(title);
          },
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Animal>>(
          future: AnimalService.getAnimals(langCode),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildGridView(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(langCode == 'en'
                  ? 'Error loading cute animals'
                  : 'Erro ao carregar animais fofos',);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      drawer: _buildDrawer(langCode),
    );
  }

  Widget _buildGridView(List<Animal> animais) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(animais.length, (index) {
        return AnimalGridItem(animal: animais[index]);
      }),
    );
  }

  Widget _buildDrawer(String langCode) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(_randomAnimal?.imagem ?? ''),
                fit: BoxFit.cover,
              ),
            ),
            child: null,
          ),
          for (int i = 0; i < menuServices.getOptions(langCode).length; i++)
            MenuItemWidget(
              icon: menuServices.icons[i],
              title: menuServices.getOptions(langCode)[i],
              subtitle: menuServices.getSubtitles(langCode)[i],
              onTap: () => _handleMenuTap(i),
            ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              langCode == 'en'
              ? 'Developed by Guilherme Alves'
                  : 'Desenvolvido por Guilherme Alves',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  void _handleMenuTap(int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AnimalGuessingGame()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MemoryGame()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const VamosColorirGame()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguageSelectionPage()));
        break;
    }
  }
}
