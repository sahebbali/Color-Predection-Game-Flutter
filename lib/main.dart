import 'package:color_predection_game/my_app.dart';
import 'package:color_predection_game/screens/game/controllers/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(GameController());
  runApp(const MyApp());
}
