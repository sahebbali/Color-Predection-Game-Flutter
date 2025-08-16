import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PollController extends GetxController {
  // Sample poll question
  var question = "Which color do you like most?".obs;

  // Options
  var options = ["Red", "Blue", "Green", "Yellow"].obs;

  // Selected index
  var selectedIndex = (-1).obs;

  // Submit action
  void selectOption(int index) {
    selectedIndex.value = index;
  }

  void submitPoll() {
    if (selectedIndex.value == -1) {
      Get.snackbar("Error", "Please select an option",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Success", "You voted for ${options[selectedIndex.value]}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100);
      selectedIndex.value = -1; // reset
    }
  }
}
