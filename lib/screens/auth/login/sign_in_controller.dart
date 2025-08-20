import 'dart:convert';
import 'package:color_predection_game/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignInController extends GetxController {
  // Use TextEditingController for better form management
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  // The base URL for your backend API
  // Use 10.0.2.2 for Android Emulator to connect to local machine's localhost
  final String _baseUrl = "http://10.0.2.2:3000/api/v1";

  // Clean up controllers when the widget is disposed
  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void signIn() async {
    // Get values from controllers
    final String username = usernameController.text.trim();
    final String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {
          'Content-Type': 'application/json; charset=UTF--8',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      // Decode the response body
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // --- SUCCESS ---
        // Assuming your backend returns a success message and maybe a token
        // e.g., { "success": true, "message": "Login successful", "token": "..." }
        
        print("Login successful: $responseBody");

        Get.snackbar(
          "Success",
          responseBody['message'] ?? "Signed in successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // TODO: Save the user token/session securely
        // Example: final token = responseBody['token'];
        // await saveToken(token);

        // Navigate to the main app screen
        Get.offAll(() => NavigationMenu()); // Use offAll to clear the auth stack
      } else {
        // --- ERROR FROM BACKEND ---
        // Assuming your backend returns an error message
        // e.g., { "success": false, "message": "Invalid credentials" }
        Get.snackbar(
          "Login Failed",
          responseBody['message'] ?? "An unknown error occurred",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // --- CATCHING EXCEPTIONS (e.g., network error, server down) ---
      print("An error occurred: $e");
      Get.snackbar(
        "Error",
        "Could not connect to the server. Please try again later.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      // Always set isLoading to false at the end
      isLoading.value = false;
    }
  }
}