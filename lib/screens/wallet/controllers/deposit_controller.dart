import 'dart:io';
import 'package:color_predection_game/commonWidgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DepositController extends GetxController {
  final amountController = TextEditingController();
  final txnIdController = TextEditingController();

  final Rx<File?> proofImage = Rx<File?>(null);

  /// Pick image from gallery
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      proofImage.value = File(pickedFile.path);
    }
  }

  void submitDeposit() {
    final amount = amountController.text.trim();
    final txnId = txnIdController.text.trim();

    if (amount.isEmpty || txnId.isEmpty || proofImage.value == null) {
      AppSnackbar.show(
        title: "Error",
        message: "Please fill all fields and upload proof",
        isError: true,
      );

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
