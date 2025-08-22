import 'package:color_predection_game/screens/auth/controllers/registration_controller.dart';
import 'package:color_predection_game/screens/auth/signup/terms_and_conditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});
  final RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Icon(Icons.color_lens, size: 80, color: Colors.purple.shade400),
              const SizedBox(height: 10),
              Text(
                "Create Your Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      _buildTextFormField(
                        label: "Sponsor ID",
                        icon: Icons.card_membership,
                        onChanged: (v) => controller.sponsorId.value = v,
                        validator: (v) =>
                            v!.isEmpty ? "Sponsor ID is required" : null,
                      ),
                      const SizedBox(height: 16),
                      _buildTextFormField(
                        label: "Full Name",
                        icon: Icons.person,
                        onChanged: (v) => controller.fullName.value = v,
                        validator: (v) =>
                            v!.isEmpty ? "Full Name is required" : null,
                      ),
                      const SizedBox(height: 16),
                      _buildTextFormField(
                        label: "Email",
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (v) => controller.email.value = v,
                        validator: (v) => !GetUtils.isEmail(v!)
                            ? "Enter a valid email"
                            : null,
                      ),
                      const SizedBox(height: 16),
                      _buildTextFormField(
                        label: "Phone Number",
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        onChanged: (v) => controller.phone.value = v,
                        validator: (v) =>
                            v!.isEmpty ? "Phone number is required" : null,
                      ),
                      const SizedBox(height: 16),
                      _buildTextFormField(
                        label: "Password",
                        icon: Icons.lock,
                        isPassword: true,
                        onChanged: (v) => controller.password.value = v,
                        validator: (v) => v!.length < 6
                            ? "Password must be at least 6 characters"
                            : null,
                      ),
                      const SizedBox(height: 16),
                      _buildTextFormField(
                        label: "Confirm Password",
                        icon: Icons.lock_outline,
                        isPassword: true,
                        onChanged: (v) => controller.confirmPassword.value = v,
                        validator: (v) => v! != controller.password.value
                            ? "Passwords do not match"
                            : null,
                      ),

                      // -- Conditional OTP Field and Resend Button --
                      Obx(() {
                        if (!controller.isOtpSent.value) {
                          return const SizedBox.shrink(); // Hidden initially
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: _buildTextFormField(
                                  label: "OTP",
                                  icon: Icons.pin,
                                  keyboardType: TextInputType.number,
                                  onChanged: (v) =>
                                      controller.otpCode.value = v,
                                  validator: (v) {
                                    if (controller.isOtpSent.value &&
                                        v!.isEmpty) {
                                      return "OTP is required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Obx(() => TextButton(
                                    onPressed: controller.isOtpLoading.value
                                        ? null
                                        : controller.createOtp,
                                    child: controller.isOtpLoading.value
                                        ? const SizedBox(
                                            height: 18,
                                            width: 18,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2),
                                          )
                                        : const Text("Resend OTP"),
                                  )),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildTermsAndConditions(),
              const SizedBox(height: 24),
              _buildSignUpButton(),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text(
                  "Already have an account? Sign In",
                  style: TextStyle(fontSize: 14, color: Colors.purple),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.purple.shade300),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.purple.shade400, width: 2),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildTermsAndConditions() {
    return Obx(
      () => Row(
        children: [
          Checkbox(
            value: controller.acceptTerms.value,
            activeColor: Colors.purple.shade600,
            onChanged: (val) => controller.acceptTerms.value = val ?? false,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                var accepted =
                    await Get.to(() => const TermsAndConditionsPage());
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
    );
  }

  Widget _buildSignUpButton() {
    return Obx(() {
      final isFirstStep = !controller.isOtpSent.value;
      final isLoading = isFirstStep
          ? controller.isOtpLoading.value
          : controller.isRegisterLoading.value;

      return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple.shade600,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: isLoading ? null : controller.handleSubmit,
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  isFirstStep ? "Get OTP" : "Sign Up",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
        ),
      );
    });
  }
}
