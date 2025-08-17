import 'dart:math';
import 'package:get/get.dart';

class NumberLeagueController extends GetxController {
  var selectedNumber = 1.obs;
  var randomNumber = 0.obs;
  var resultMessage = "".obs;

  void playGame() {
    randomNumber.value = Random().nextInt(10) + 1; // random 1-10
    if (selectedNumber.value == randomNumber.value) {
      resultMessage.value = "🎉 You Win!";
    } else {
      resultMessage.value =
          "❌ You Lose! Winning number was ${randomNumber.value}";
    }
  }

  void setNumber(int number) {
    selectedNumber.value = number;
  }
}
