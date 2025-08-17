import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/betting_game_controller.dart';

class BettingGamePage extends StatelessWidget {
  const BettingGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BettingGameController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Betting Game"),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.bets.length,
          itemBuilder: (context, index) {
            final bet = controller.bets[index];
            // Create a TextEditingController to show the initial value
            final textEditingController = TextEditingController(
              text: bet.betAmount.value > 0
                  ? bet.betAmount.value.toStringAsFixed(0)
                  : '',
            );

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bet ${bet.id}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    // Bet Amount Field
                    TextField(
                      controller: textEditingController, // Use the controller
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter Bet Amount",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) =>
                          controller.setBetAmount(index, value),
                    ),

                    const SizedBox(height: 20),

                    // Team Selection
                    const Text(
                      "Choose Your Team",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),

                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ChoiceChip(
                            label: const Text("Team A"),
                            selected: bet.selectedTeam.value == "Team A",
                            selectedColor: Colors.purple,
                            onSelected: (_) =>
                                controller.selectTeam(index, "Team A"),
                            labelStyle: TextStyle(
                              color: bet.selectedTeam.value == "Team A"
                                  ? Colors.white
                                  : Colors.purple,
                            ),
                          ),
                          ChoiceChip(
                            label: const Text("Team B"),
                            selected: bet.selectedTeam.value == "Team B",
                            selectedColor: Colors.purple,
                            onSelected: (_) =>
                                controller.selectTeam(index, "Team B"),
                            labelStyle: TextStyle(
                              color: bet.selectedTeam.value == "Team B"
                                  ? Colors.white
                                  : Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Place Bet Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () => controller.placeBet(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Place Bet",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Result Message
                    Center(
                      child: Obx(
                        () => Text(
                          bet.resultMessage.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: bet.resultMessage.value.contains("Win")
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.addBet,
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
