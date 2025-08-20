import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/interest_history_controller.dart';
import '../widgets/filter_bar.dart';
import '../widgets/interest_header.dart';
import '../widgets/interest_list_tile.dart';

class InterestHistoryScreen extends StatelessWidget {
  const InterestHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final InterestHistoryController controller = Get.put(InterestHistoryController());

    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5), // Light Purple Background
      appBar: AppBar(
        title: const Text('Interest History', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          const InterestHeader(),
          FilterBar(controller: controller),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.interestHistory.length,
                itemBuilder: (context, index) {
                  final item = controller.interestHistory[index];
                  return InterestListTile(item: item);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}