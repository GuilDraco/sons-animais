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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              setState(() {
                points.clear(); // Limpa a tela
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
                      ..color = selectedColor
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
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: strokeWidth == width ? Colors.green : Colors.white, // Círculo verde quando selecionado
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: strokeWidth == width ? Colors.green : Colors.black,
          ),
        ),
        child: Icon(
          Icons.create, // Ícone de caneta
          size: 20,
          color: strokeWidth == width ? Colors.white : Colors.black, // Ícone verde quando selecionado
        ),
      ),
    );
  }

  Widget _buildColorPicker(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color; // Define a cor selecionada
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
            width: 3,
            color: selectedColor == color ? Colors.black : Colors.transparent,
          ),
        ),
      ),
    );
  }
}
