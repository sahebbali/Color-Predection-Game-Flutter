import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/withdraw_controller.dart';

class AmountInputField extends StatelessWidget {
  const AmountInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final WithdrawController controller = Get.put(WithdrawController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Enter Amount",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller.amountController, // Use controller from GetX
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.attach_money,
              color: Colors.purple.shade800,
            ),
            hintText: "0.00",
            filled: true,
            fillColor: Colors.purple.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.deepPurple,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
