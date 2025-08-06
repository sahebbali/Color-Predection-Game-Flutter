import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../controllers/game_controller.dart';

class TopHeader extends GetView<GameController> {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppColors.primaryRed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Text(
            'Available balance: ₹ ${controller.balance.value.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildButton('Recharge', Colors.blue.shade700),
              const SizedBox(width: 16),
              _buildButton('Trend', Colors.white, textColor: Colors.black),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: () { /* Refresh logic */ },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color, {Color textColor = Colors.white}) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.symmetric(horizontal: 24),
      ),
      child: Text(text, style: TextStyle(color: textColor)),
    );
  }
}