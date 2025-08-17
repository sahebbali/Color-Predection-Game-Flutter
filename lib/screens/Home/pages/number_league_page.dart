import 'package:flutter/material.dart' hide CarouselController;
import 'package:get/get.dart';
import '../controllers/number_league_controller.dart';

class NumberLeaguePage extends StatelessWidget {
  const NumberLeaguePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NumberLeagueController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Number League"),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white, // text & icons white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Pick a Number (1–10)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Number selection grid
            Obx(
              () => Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(10, (index) {
                  int number = index + 1;
                  return ChoiceChip(
                    label: Text(
                      "$number",
                      style: TextStyle(
                        color: controller.selectedNumber.value == number
                            ? Colors.white
                            : Colors.purple,
                      ),
                    ),
                    selected: controller.selectedNumber.value == number,
                    selectedColor: Colors.purple,
                    onSelected: (_) => controller.setNumber(number),
                    backgroundColor: Colors.grey.shade200,
                  );
                }),
              ),
            ),

            const SizedBox(height: 30),

            // Play Button
            ElevatedButton(
              onPressed: controller.playGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Play",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),

            const SizedBox(height: 30),

            // Result message
            Obx(
              () => Text(
                controller.resultMessage.value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: controller.resultMessage.value.contains("Win")
                      ? Colors.green
                      : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
