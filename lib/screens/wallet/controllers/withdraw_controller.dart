import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawController extends GetxController {
  // --- State Variables ---

  // Use .obs to make the balance reactive. The UI will update automatically when it changes.
  final RxDouble balance = 1250.75.obs;

  // Controller for the text field to get its value.
  final TextEditingController amountController = TextEditingController();

  // --- Logic / Methods ---

  void submitWithdrawal() {
    // Basic validation
    if (amountController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter an amount.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final amount = double.tryParse(amountController.text) ?? 0.0;

    if (amount <= 0) {
      Get.snackbar(
        "Error",
        "Amount must be greater than zero.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (amount > balance.value) {
      Get.snackbar(
        "Insufficient Balance",
        "The requested amount exceeds your withdrawable balance.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    // --- If all checks pass, proceed with withdrawal logic ---
    // (e.g., call an API, update the state)
    
    Get.dialog(
      AlertDialog(
        title: const Text("Success"),
        content: Text("Withdrawal request for \$$amount has been submitted."),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("OK"),
          ),
        ],
      ),
    );

    // You might want to update the balance or clear the field after submission
    // balance.value -= amount;
    // amountController.clear();
  }

  // It's crucial to dispose of controllers to prevent memory leaks.
  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}