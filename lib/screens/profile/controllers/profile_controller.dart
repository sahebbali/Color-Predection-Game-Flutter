import 'package:color_predection_game/screens/profile/pages/commision/screens/commision_screen.dart';
import 'package:color_predection_game/screens/wallet/pages/deposit_screen.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Define your variables and methods here

  void recharge() {
    print("Recharge tapped");
    Get.to(() => DepositScreen());
  }

  void view_commission() {
    print("View Commission tapped");
    Get.to(() => CommissionScreen());
    // Logic for viewing commission
  }

  void view_interest() {
    print("View Interest tapped");
    // Logic for viewing interest
  }
}
