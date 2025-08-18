import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/withdraw_history_controller.dart';
import '../models/withdrawal_model.dart';

class WithdrawHistoryScreen extends StatelessWidget {
  const WithdrawHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller. GetX handles the lifecycle automatically.
    final WithdrawHistoryController controller =
        Get.put(WithdrawHistoryController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Withdrawal History",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 10,
        shadowColor: Colors.purple.withOpacity(0.5),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        // Show a loading spinner while fetching data
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
          );
        }

        // Show a message if there's no history
        if (controller.withdrawalHistory.isEmpty) {
          return const Center(
            child: Text(
              "No withdrawal history found.",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        // Build the list once data is available
        return ListView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: controller.withdrawalHistory.length,
          itemBuilder: (context, index) {
            final withdrawal = controller.withdrawalHistory[index];
            return HistoryListItem(withdrawal: withdrawal);
          },
        );
      }),
    );
  }
}

// A dedicated widget for the list item for better code organization.
class HistoryListItem extends StatelessWidget {
  final Withdrawal withdrawal;
  const HistoryListItem({super.key, required this.withdrawal});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.black.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${withdrawal.amount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                StatusChip(status: withdrawal.status),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.black12),
            const SizedBox(height: 12),
            _buildInfoRow("Transaction ID", withdrawal.transactionId),
            const SizedBox(height: 8),
            _buildInfoRow("Payment Method", withdrawal.paymentMethod),
            const SizedBox(height: 8),
            _buildInfoRow("Date", withdrawal.date),
          ],
        ),
      ),
    );
  }

  // Helper widget to create consistent info rows
  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

// A dedicated widget for the status chip.
class StatusChip extends StatelessWidget {
  final String status;
  const StatusChip({super.key, required this.status});

  // Helper function to get color and icon based on the status string
  ({Color color, IconData icon}) getStatusProperties() {
    switch (status) {
      case "Completed":
        return (color: Colors.green, icon: Icons.check_circle);
      case "Pending":
        return (color: Colors.orange, icon: Icons.hourglass_top_rounded);
      case "Failed":
        return (color: Colors.red, icon: Icons.cancel);
      default:
        return (color: Colors.grey, icon: Icons.help_outline);
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusProps = getStatusProperties();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: statusProps.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusProps.icon, color: statusProps.color, size: 14),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              color: statusProps.color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
