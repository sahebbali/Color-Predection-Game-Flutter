import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';

class CountdownPanel extends GetView<GameController> {
  const CountdownPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // We wrap this in Obx so it rebuilds when controller.currentPeriod changes
          Obx(
            () => _buildInfoColumn(
              'Period',
              controller.currentPeriod.value.toString(),
            ),
          ),

          // We wrap this in Obx so it rebuilds when controller.formattedTime changes
          Obx(() => _buildInfoColumn('Count Down', controller.formattedTime)),
        ],
      ),
    );
  }

  // CHANGE #1: The second parameter is now a plain String, not RxString.
  Widget _buildInfoColumn(String title, String value) {
    // print("CountdownPanel: $title - $value");
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 8),

        // CHANGE #2: The Text widget now just displays the value directly.
        // The Obx in the parent `build` method handles the rebuilding.
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
