import 'dart:convert';
import 'package:color_predection_game/commonWidgets/app_snackbar.dart';
import 'package:color_predection_game/navigation_menu.dart';
import 'package:color_predection_game/utils/constants/base_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  final _surl = Surl();
  final formKey = GlobalKey<FormState>();

  // Form Fields
  var sponsorId = ''.obs;
  var fullName = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var otpCode = ''.obs;
  var acceptTerms = false.obs;

  // UI State Management
  var isOtpSent = false.obs;
  var isOtpLoading = false.obs;
  var isRegisterLoading = false.obs;

  /// Handles the first step: Validates email/sponsor and requests an OTP from the server.
  Future<void> createOtp() async {
    // Manually validate only the fields required for OTP generation
    if (sponsorId.value.isEmpty || !GetUtils.isEmail(email.value)) {
      AppSnackbar.show(
          title: "Error",
          message: "Please enter a valid Sponsor ID and Email to get an OTP.",
          isError: true);
      return;
    }

    isOtpLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('${_surl.pubBaseUrl}/create_otp'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'sponsorId': sponsorId.value, 'email': email.value}),
      );

      if (response.statusCode == 200) {
        AppSnackbar.show(
            title: "Success",
            message: "OTP sent to your email!",
            isError: false);
        isOtpSent.value =
            true; // IMPORTANT: This triggers the UI to show the OTP field
      } else {
        final responseData = json.decode(response.body);
        AppSnackbar.show(
            title: "Error",
            message: responseData['message'] ?? "Failed to send OTP.",
            isError: true);
      }
    } catch (e) {
      AppSnackbar.show(
          title: "Error", message: "An error occurred: $e", isError: true);
    } finally {
      isOtpLoading.value = false;
    }
  }

  /// Handles the second step: Validates all fields (including OTP) and registers the user.
  Future<void> _performRegistration() async {
    if (formKey.currentState!.validate() && acceptTerms.value) {
      isRegisterLoading.value = true;
      try {
        final response = await http.post(
          Uri.parse('${_surl.pubBaseUrl}/register'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'fullName': fullName.value,
            'email': email.value,
            'password': password.value,
            'confirmPassword': confirmPassword.value,
            'mobile': phone.value,
            'sponsorId': sponsorId.value,
            'sponsorName':
                '', // Assuming sponsorName is not required from the UI
            'otpCode': otpCode.value,
            'role': 'user',
          }),
        );

        if (response.statusCode == 201 || response.statusCode == 200) {
          AppSnackbar.show(
              title: "Success",
              message: "Account created successfully!",
              isError: false);
          Get.offAll(() => const NavigationMenu());
        } else {
          final responseData = json.decode(response.body);
          AppSnackbar.show(
              title: "Error",
              message: responseData['message'] ?? "Registration failed.",
              isError: true);
        }
      } catch (e) {
        AppSnackbar.show(
            title: "Error", message: "An error occurred: $e", isError: true);
      } finally {
        isRegisterLoading.value = false;
      }
    } else if (!acceptTerms.value) {
      AppSnackbar.show(
          title: "Error",
          message: "Please accept the Terms & Conditions.",
          isError: true);
    }
  }

  /// Public method called by the main button. It decides which action to perform.
  void handleSubmit() {
    if (isOtpSent.value) {
      _performRegistration();
    } else {
      createOtp();
    }
  }
}
