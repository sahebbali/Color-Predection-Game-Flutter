import 'package:color_predection_game/commonWidgets/app_snackbar.dart';
import 'package:color_predection_game/navigation_menu.dart';
import 'package:color_predection_game/screens/auth/signup/terms_and_conditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  var sponsorId = ''.obs;
  var fullName = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var acceptTerms = false.obs;
  var isLoading = false.obs;

  void register() async {
    if (sponsorId.value.isEmpty ||
        fullName.value.isEmpty ||
        email.value.isEmpty ||
        phone.value.isEmpty ||
        password.value.isEmpty ||
        confirmPassword.value.isEmpty) {
      AppSnackbar.show(
          title: "Error", message: "Please fill all fields", isError: true);
      return;
    }

    if (password.value != confirmPassword.value) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (!acceptTerms.value) {
      Get.snackbar(
        "Error",
        "Please accept Terms & Conditions",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call
    isLoading.value = false;
    print(
      "Registered with email: ${email.value} and password: ${password.value} and phone: ${phone.value} and sponsor ID: ${sponsorId.value}",
    );
    Get.snackbar(
      "Success",
      "Account created successfully!",
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.to(() => NavigationMenu());
  }
}

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});
  final RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Icon(Icons.color_lens, size: 80, color: Colors.purple.shade400),
              const SizedBox(height: 10),
              Text(
                "Create Your Account",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade700,
                ),
              ),
              const SizedBox(height: 20),

              _buildTextField(
                "Sponsor ID",
                Icons.card_membership,
                onChanged: (v) => controller.sponsorId.value = v,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                "Full Name",
                Icons.person,
                onChanged: (v) => controller.fullName.value = v,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                "Email",
                Icons.email,
                onChanged: (v) => controller.email.value = v,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                "Phone Number",
                Icons.phone,
                keyboardType: TextInputType.phone,
                onChanged: (v) => controller.phone.value = v,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                "Password",
                Icons.lock,
                isPassword: true,
                onChanged: (v) => controller.password.value = v,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                "Confirm Password",
                Icons.lock_outline,
                isPassword: true,
                onChanged: (v) => controller.confirmPassword.value = v,
              ),
              const SizedBox(height: 16),

              // Terms & Conditions Checkbox
              Obx(
                () => Row(
                  children: [
                    Checkbox(
                      value: controller.acceptTerms.value,
                      activeColor: Colors.purple.shade600,
                      onChanged: (val) =>
                          controller.acceptTerms.value = val ?? false,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          var accepted = await Get.to(
                            () => TermsAndConditionsPage(),
                          );
                          if (accepted == true) {
                            controller.acceptTerms.value = true;
                          }
                        },
                        child: const Text(
                          "I accept the Terms & Conditions",
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Sign Up Button
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed:
                        controller.isLoading.value ? null : controller.register,
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Already have an account? Sign In",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Input Field
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
