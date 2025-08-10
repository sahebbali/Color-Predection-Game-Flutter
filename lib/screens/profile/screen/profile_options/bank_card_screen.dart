import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankCardController extends GetxController {
  var accountType = ''.obs;
  var bankName = ''.obs;
  var accountNumber = ''.obs;
  var ifscCode = ''.obs;
  var branchName = ''.obs;

  var history = <Map<String, String>>[].obs;

  void saveBankDetails() {
    if (accountType.isEmpty ||
        bankName.isEmpty ||
        accountNumber.isEmpty ||
        ifscCode.isEmpty ||
        branchName.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    history.insert(0, {
      "Account Type": accountType.value,
      "Bank Name": bankName.value,
      "Account Number": accountNumber.value,
      "IFSC Code": ifscCode.value,
      "Branch Name": branchName.value,
    });

    Get.snackbar(
      "Success",
      "Bank details saved",
      snackPosition: SnackPosition.BOTTOM,
    );

    accountType.value = "";
    bankName.value = "";
    accountNumber.value = "";
    ifscCode.value = "";
    branchName.value = "";
  }
}

class BankCardScreen extends StatelessWidget {
  BankCardScreen({super.key});
  final BankCardController controller = Get.put(BankCardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Bank Details"),
        backgroundColor: Colors.purple.shade600,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildTextField(
                      "Account Type",
                      Icons.account_balance,
                      onChanged: (v) => controller.accountType.value = v,
                    ),
                    const SizedBox(height: 12),

                    _buildTextField(
                      "Bank Name",
                      Icons.account_balance_wallet,
                      onChanged: (v) => controller.bankName.value = v,
                    ),
                    const SizedBox(height: 12),

                    _buildTextField(
                      "Account Number",
                      Icons.numbers,
                      keyboardType: TextInputType.number,
                      onChanged: (v) => controller.accountNumber.value = v,
                    ),
                    const SizedBox(height: 12),

                    _buildTextField(
                      "IFSC Code",
                      Icons.code,
                      onChanged: (v) => controller.ifscCode.value = v,
                    ),
                    const SizedBox(height: 12),

                    _buildTextField(
                      "Branch Name",
                      Icons.location_city,
                      onChanged: (v) => controller.branchName.value = v,
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: controller.saveBankDetails,
                        child: const Text(
                          "Save",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // History Section
            Expanded(
              flex: 1,
              child: Obx(() {
                if (controller.history.isEmpty) {
                  return const Center(child: Text("No history yet"));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.history.length,
                  itemBuilder: (context, index) {
                    final item = controller.history[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: item.entries.map((e) {
                            return Text(
                              "${e.key}: ${e.value}",
                              style: const TextStyle(fontSize: 14),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon, {
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
  }) {
    return TextField(
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: onChanged,
    );
  }
}
