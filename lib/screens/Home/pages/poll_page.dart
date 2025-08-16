import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/poll_controller.dart';

class PollPage extends StatelessWidget {
  final PollController controller = Get.put(PollController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Poll Game"),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Obx(() => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.polls.length,
            itemBuilder: (context, pollIndex) {
              final poll = controller.polls[pollIndex];
              return Card(
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        poll["question"],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      ...List.generate(poll["options"].length, (optionIndex) {
                        String option = poll["options"][optionIndex];
                        bool isSelected = poll["selected"] == optionIndex;
                        return Card(
                          color: isSelected
                              ? Colors.purple.shade100
                              : Colors.white,
                          child: ListTile(
                            title: Text(option),
                            trailing: isSelected
                                ? const Icon(Icons.check_circle,
                                    color: Colors.purple)
                                : const Icon(Icons.circle_outlined),
                            onTap: () =>
                                controller.selectOption(pollIndex, optionIndex),
                          ),
                        );
                      }),
                      const SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => controller.submitPoll(pollIndex),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Submit Vote",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
