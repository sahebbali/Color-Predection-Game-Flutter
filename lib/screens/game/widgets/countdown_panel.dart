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
          _buildInfoColumn('Period', controller.currentPeriod),
          _buildInfoColumn('Count Down', controller.formattedTime, isTimer: true),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String title, RxString value, {bool isTimer = false}) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
        const SizedBox(height: 8),
        Obx(() => Text(
          isTimer ? controller.formattedTime : value.value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        )),
      ],
    );
  }
}