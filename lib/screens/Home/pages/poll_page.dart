import 'package:flutter/material.dart';

class PollPage extends StatelessWidget {
  const PollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Poll Game")),
      body: Center(child: Text("Welcome to Poll Game")),
    );
  }
}
