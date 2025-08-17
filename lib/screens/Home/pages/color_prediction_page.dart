import 'package:color_predection_game/screens/game/screen/game_screen.dart';
import 'package:flutter/material.dart';

class ColorPredictionPage extends StatelessWidget {
  const ColorPredictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Color Prediction")),
      body: const GameScreen(),
    );
  }
}
