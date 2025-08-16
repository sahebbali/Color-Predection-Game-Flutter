import 'package:flutter/material.dart';

class BettingGamePage extends StatelessWidget {
  const BettingGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Betting Game")),
      body: Center(child: Text("Welcome to Betting Game")),
    );
  }
}
