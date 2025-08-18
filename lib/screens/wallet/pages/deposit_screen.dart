import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/deposit_controller.dart';
import '../widgets/deposit_text_field.dart';
import '../widgets/deposit_button.dart';

class DepositScreen extends StatelessWidget {
  DepositScreen({super.key});

  final DepositController controller = Get.put(DepositController());
  final Color purple = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      appBar: AppBar(
        backgroundColor: purple, // Purple AppBar
        elevation: 0,
        title: const Text("Deposit",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Amount input
              const Text("Amount",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
              const SizedBox(height: 8),
              DepositTextField(
                controller: controller.amountController,
                hint: "Enter amount",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              /// Transaction ID input
              const Text("Transaction ID",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
              const SizedBox(height: 8),
              DepositTextField(
                controller: controller.txnIdController,
                hint: "Enter transaction ID",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),

              /// Proof image upload
              const Text("Proof (Upload Screenshot)",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
              const SizedBox(height: 8),
              Obx(() {
                return GestureDetector(
                  onTap: controller.pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade100,
                    ),
                    child: controller.proofImage.value != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              controller.proofImage.value!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                        : const Center(
                            child: Text(
                              "Tap to upload proof image",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                  ),
                );
              }),
              const SizedBox(height: 30),

              /// Submit button
              DepositButton(
                text: "Submit",
                onPressed: controller.submitDeposit,
                color: purple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
