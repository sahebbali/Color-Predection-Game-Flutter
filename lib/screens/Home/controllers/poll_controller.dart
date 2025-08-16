import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PollController extends GetxController {
  // List of polls
  var polls = <Map<String, dynamic>>[
    {
      "question": "Which color do you like most?",
      "options": ["Red", "Blue", "Green", "Yellow"],
      "selected": -1
    },
    {
      "question": "What's your favorite sport?",
      "options": ["Soccer", "Basketball", "Cricket", "Tennis"],
      "selected": -1
    },
    {
      "question": "Which season do you prefer?",
      "options": ["Summer", "Winter", "Spring", "Autumn"],
      "selected": -1
    },
  ].obs;

  void selectOption(int pollIndex, int optionIndex) {
    polls[pollIndex]["selected"] = optionIndex;
    polls.refresh(); // notify GetX to update UI
  }

  void submitPoll(int pollIndex) {
    int selected = polls[pollIndex]["selected"];
    if (selected == -1) {
      Get.snackbar("Error", "Please select an option",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      String option = polls[pollIndex]["options"][selected];
      Get.snackbar("Success", "You voted for $option",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100);
      polls[pollIndex]["selected"] = -1; // reset selection
      polls.refresh();
    }
  }
}
