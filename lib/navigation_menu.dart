import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';
import 'navigation_controller.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = HkHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          backgroundColor: darkMode ? HkColors.dark : HkColors.light,
          indicatorColor: darkMode 
              ? HkColors.light.withOpacity(0.1) 
              : HkColors.dark.withOpacity(0.1),
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home),
              selectedIcon: Icon(Iconsax.home_15),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.game),
              selectedIcon: Icon(Iconsax.game5),
              label: 'Game',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.chart),
              selectedIcon: Icon(Iconsax.chart_2),
              label: 'Stats',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.user),
              selectedIcon: Icon(Iconsax.profile_circle5),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}