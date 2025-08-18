import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import '../widgets/balance_card.dart';
import '../widgets/amount_input_field.dart';
import '../widgets/submit_button.dart';
// import '../controllers/withdraw_controller.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller. GetX will manage its lifecycle.
    // This controller is now available to all child widgets (the components).
    // final WithdrawController controller = Get.put(WithdrawController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Withdraw Funds",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const BalanceCard(),
              const SizedBox(height: 40),
              const AmountInputField(),
              const SizedBox(height: 40),
              const SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
