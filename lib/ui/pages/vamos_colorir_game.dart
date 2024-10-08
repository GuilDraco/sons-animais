import 'package:bixinhos/ui/pages/pintura_toque.dart';
import 'package:flutter/material.dart';

class VamosColorirGame extends StatefulWidget {
  const VamosColorirGame({super.key});

  @override
  _VamosColorirGameState createState() => _VamosColorirGameState();
}

class _VamosColorirGameState extends State<VamosColorirGame> {
  List<MapEntry<Offset?, Paint>> points = [];
  Color selectedColor = Colors.black;
  double strokeWidth = 5.0; // Espessura do traço padrão
  bool isEraserActive = false; // Borracha ativada ou não

  // Mapeamento das espessuras para os ícones correspondentes
  final Map<double, String> strokeWidthIcons = {
    2.0: 'assets/images/icons/finePen.png',  // Ícone para traço fino
    5.0: 'assets/images/icons/thinPen.png',  // Ícone para traço médio-fino
    8.0: 'assets/images/icons/mediumPen.png', // Ícone para traço médio
    12.0: 'assets/images/icons/boldPen.png',  // Ícone para traço grosso
    16.0: 'assets/images/icons/heavyPen.png', // Ícone para traço mais grosso
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/images/icons/delete.png', // Caminho para a imagem de delete
              width: 24, // Largura da imagem
              height: 24, // Altura da imagem
            ),
            onPressed: () {
              setState(() {
                points.clear(); // Limpa a tela
              });
            },
          ),
          IconButton(
            icon: Image.asset(
              isEraserActive
                  ? 'assets/images/icons/eraser_p.png' // Ícone de borracha ativa
                  : 'assets/images/icons/eraser.png', // Ícone de borracha inativa
              width: 24, // Largura da imagem
              height: 24, // Altura da imagem
            ),
            onPressed: () {
              setState(() {
                isEraserActive = !isEraserActive; // Alterna o estado da borracha
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                points.add(
                  MapEntry(
                    details.localPosition,
                    Paint()
                      ..color = isEraserActive ? Colors.white : selectedColor
                      ..strokeCap = StrokeCap.round
                      ..strokeWidth = strokeWidth,
                  ),
                );
              });
            },
            onPanEnd: (details) {
              points.add(MapEntry(null, Paint())); // Adiciona uma pausa entre os traços
            },
            child: CustomPaint(
              painter: PinturaToque(points),
              child: Container(),
            ),
          ),
          Positioned(
            left: 16,
            top: 100,
            child: Column(
              children: [
                _buildStrokeWidthSelector(2.0),
                const SizedBox(height: 10),
                _buildStrokeWidthSelector(5.0),
                const SizedBox(height: 10),
                _buildStrokeWidthSelector(8.0),
                const SizedBox(height: 10),
                _buildStrokeWidthSelector(12.0),
                const SizedBox(height: 10),
                _buildStrokeWidthSelector(16.0),
              ],
            ),
          ),
          // Paleta de cores na parte inferior
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              color: Colors.grey[200],
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildColorPicker(Colors.red),
                    _buildColorPicker(Colors.blue),
                    _buildColorPicker(Colors.green),
                    _buildColorPicker(Colors.yellow),
                    _buildColorPicker(Colors.black),
                    _buildColorPicker(Colors.purple),
                    _buildColorPicker(Colors.orange),
                    _buildColorPicker(Colors.pink),
                    _buildColorPicker(Colors.brown),
                    _buildColorPicker(Colors.teal),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStrokeWidthSelector(double width) {
    return GestureDetector(
      onTap: () {
        setState(() {
          strokeWidth = width; // Define a espessura do traço
          isEraserActive = false; // Sai do modo borracha ao escolher a espessura
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: !isEraserActive && strokeWidth == width ? Colors.green : Colors.white, // Destaca o traço se for selecionado e não estiver no modo borracha
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: !isEraserActive && strokeWidth == width ? Colors.green : Colors.black,
          ),
        ),
        child: Center(
          // Alinha a imagem no centro
          child: FittedBox(
            // Ajusta o tamanho da imagem dentro do container
            child: Image.asset(
              strokeWidthIcons[width]!, // Usa o ícone correspondente à espessura
              width: 28, // Tamanho desejado da imagem
              height: 28,
              color: !isEraserActive && strokeWidth == width ? Colors.white : Colors.black, // Cor da imagem quando selecionada
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorPicker(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color; // Define a cor selecionada
          isEraserActive = false; // Sai do modo borracha ao escolher uma cor
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: selectedColor == color ? Colors.black : Colors.transparent,
          ),
        ),
      ),
    );
  }
}
