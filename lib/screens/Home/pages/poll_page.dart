import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/poll_controller.dart';

class PollPage extends StatelessWidget {
  PollPage({super.key});
  final PollController controller = Get.put(PollController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Poll Game"), backgroundColor: Colors.purple),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text(
                  controller.question.value,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 20),

            // Options
            Obx(() => Column(
                  children: controller.options.asMap().entries.map((entry) {
                    int idx = entry.key;
                    String option = entry.value;
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      color: controller.selectedIndex.value == idx
                          ? Colors.purple.shade100
                          : Colors.white,
                      child: ListTile(
                        title: Text(option),
                        trailing: controller.selectedIndex.value == idx
                            ? const Icon(Icons.check_circle,
                                color: Colors.purple)
                            : const Icon(Icons.circle_outlined),
                        onTap: () => controller.selectOption(idx),
                      ),
                    );
                  }).toList(),
                )),

            const Spacer(),

            // Submit button
            Center(
              child: ElevatedButton(
                onPressed: () => controller.submitPoll(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Submit Vote",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
