import 'package:color_predection_game/screens/Home/screen/home_screen.dart';
import 'package:color_predection_game/screens/game/screen/game_screen.dart';
import 'package:color_predection_game/screens/profile/screen/profile_screen.dart';
import 'package:color_predection_game/screens/status/screen/status_screen.dart';
import 'package:color_predection_game/screens/wallet/screens/wallet_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  final RxInt selectedIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),
    const GameScreen(),
    const StatsScreen(),
    const WalletScreen(),
    const ProfileScreen(),
  ];
}
