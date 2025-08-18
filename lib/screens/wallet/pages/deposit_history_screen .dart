import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/deposit_history_controller.dart';

class DepositHistoryScreen extends StatelessWidget {
  DepositHistoryScreen({super.key});

  final DepositHistoryController controller =
      Get.put(DepositHistoryController());

  // A helper to get status properties (color and icon)
  ({Color color, IconData icon}) getStatusProperties(String status) {
    switch (status) {
      case "Approved":
        return (color: Colors.green, icon: Icons.check_circle);
      case "Rejected":
        return (color: Colors.red, icon: Icons.cancel);
      default:
        return (color: Colors.orange, icon: Icons.hourglass_empty);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F5F5), // A slightly off-white background
      appBar: AppBar(
        title: const Text(
          "Deposit History",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple, // A deeper purple shade
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (controller.deposits.isEmpty) {
          return const Center(
            child: Text(
              "No deposit history found.",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          itemCount: controller.deposits.length,
          itemBuilder: (context, index) {
            final item = controller.deposits[index];
            final statusProps = getStatusProperties(item["status"]!);

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.1),
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Proof Image with a nice circular border
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(item["proof"]!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Details Section - Expanded to prevent overflow
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Amount: \$${item["amount"]}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "ID: ${item["transactionId"]}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item["date"]!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Status Chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: statusProps.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(statusProps.icon,
                              color: statusProps.color, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            item["status"]!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: statusProps.color,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
