import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DepositController extends GetxController {
  final amountController = TextEditingController();
  final txnIdController = TextEditingController();

  final Rx<File?> proofImage = Rx<File?>(null);

  /// Pick image from gallery
  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      proofImage.value = File(pickedFile.path);
    }
  }

  void submitDeposit() {
    final amount = amountController.text.trim();
    final txnId = txnIdController.text.trim();

    if (amount.isEmpty || txnId.isEmpty || proofImage.value == null) {
      Get.snackbar("Error", "Please fill all fields and upload proof",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // TODO: Handle deposit API call here
    Get.snackbar("Success", "Deposit request submitted",
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  @override
  void onClose() {
    amountController.dispose();
    txnIdController.dispose();
    super.onClose();
  }
}
