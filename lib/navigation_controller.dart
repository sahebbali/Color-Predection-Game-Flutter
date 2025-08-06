import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();
  
  final RxInt selectedIndex = 0.obs;
  
  final List<Widget> screens = [
    const HomeScreen(),
    const GameScreen(),
    const StatsScreen(),
    const ProfileScreen(),
  ];
}