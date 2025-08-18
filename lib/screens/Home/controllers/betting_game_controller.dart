import 'dart:math';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/bet_model.dart'; // Import the Bet model

class BettingGameController extends GetxController {
  final bets = <Bet>[].obs;
  int _nextBetId = 1;

  @override
  void onInit() {
    super.onInit();
    // Load dummy data when the controller is initialized
    _loadDummyData();
  }

  void _loadDummyData() {
    // Create a few Bet objects with pre-filled data
    final bet1 = Bet(id: _nextBetId++);
    bet1.betAmount.value = 50.0;
    bet1.selectedTeam.value = 'Team A';
    bet1.resultMessage.value = 'You Win! You bet on Team A.';

    final bet2 = Bet(id: _nextBetId++);
    bet2.betAmount.value = 100.0;
    bet2.selectedTeam.value = 'Team B';
    bet2.resultMessage.value = 'You Lose! The winning team was Team A.';

    final bet3 = Bet(id: _nextBetId++);
    // This one is left empty for the user to fill out

    // Add the dummy bets to the list
    bets.addAll([bet1, bet2, bet3]);
  }

  void addBet() {
    bets.add(Bet(id: _nextBetId++));
  }

  void setBetAmount(int index, String amount) {
    if (double.tryParse(amount) != null) {
      bets[index].betAmount.value = double.parse(amount);
    }
  }

  void selectTeam(int index, String team) {
    bets[index].selectedTeam.value = team;
  }

  void placeBet(int index) {
    final bet = bets[index];
    if (bet.betAmount.value <= 0) {
      bet.resultMessage.value = "Please enter a valid bet amount.";
      return;
    }

    if (bet.selectedTeam.value.isEmpty) {
      bet.resultMessage.value = "Please select a team.";
      return;
    }

    final winningTeam = Random().nextBool() ? "Team A" : "Team B";

    if (bet.selectedTeam.value == winningTeam) {
      bet.resultMessage.value = "You Win! You bet on $winningTeam.";
    } else {
      bet.resultMessage.value = "You Lose! The winning team was $winningTeam.";
    }
  }
}
