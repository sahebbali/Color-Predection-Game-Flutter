import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditionsPage extends StatelessWidget {
  final String termsText = """
Welcome to Color Prediction Game!

**Company Policy:**
1. Users must provide accurate and truthful information during registration.
2. We do not store or share your private data with third parties without consent.
3. Your account may be suspended if any fraudulent activity is detected.

**Game Conditions:**
1. All predictions must be made before the round timer ends.
2. Points or rewards will be credited only after result verification.
3. Any attempt to manipulate the game results will result in account ban.
4. The company reserves the right to change rules at any time without notice.

By using our services, you agree to follow all policies and game rules.
""";

  TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
        backgroundColor: Colors.purple.shade600,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Text(
                  termsText,
                  style: const TextStyle(fontSize: 15, height: 1.4),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Get.back(result: true); // Send "accepted" result
                  },
                  child: const Text(
                    "I Agree",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
