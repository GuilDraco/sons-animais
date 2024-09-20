import 'package:bixinhos/models/animal.dart';
import 'package:flutter/material.dart';
import 'package:bixinhos/services/animal_services.dart';
import 'package:bixinhos/services/menu_services.dart';
import 'package:bixinhos/ui/widgets/animal_grid_item.dart';
import 'package:bixinhos/ui/widgets/menu_item.dart';
import 'package:bixinhos/ui/pages/vamos_colorir_game.dart';
import 'package:bixinhos/ui/pages/memory_game.dart';
import 'animal_guessing_game_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MenuServices menuServices = MenuServices();
  Animal? _randomAnimal;

  @override
  void initState() {
    super.initState();
    _fetchRandomAnimal();
  }

  Future<void> _fetchRandomAnimal() async {
    _randomAnimal = await AnimalService.getRandomAnimal();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Animal>>(
          future: AnimalService.getAnimals(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildGridView(snapshot.data!);
            } else if (snapshot.hasError) {
              return const Text('Erro ao carregar os imagens dos animais');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      drawer: _buildDrawer(),
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

  Widget _buildDrawer() {
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
          for (int i = 0; i < menuServices.options.length; i++)
            MenuItemWidget(
              icon: menuServices.icons[i],
              title: menuServices.options[i],
              subtitle: menuServices.subtitle[i],
              onTap: () => _handleMenuTap(i),
            ),
          const SizedBox(height: 200),
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: const Text(
              "Desenvolvido por Guilherme Alves",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  void _handleMenuTap(int index) {
    switch (index) {
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AnimalGuessingGame()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MemoryGame()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => VamosColorirGame()));
        break;
    }
  }
}
