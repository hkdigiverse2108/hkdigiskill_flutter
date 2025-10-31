import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/services/storage_service.dart';
import 'package:hkdigiskill/routes/routes.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final storage = StorageService();

  void onLoginTap() {
    validateForm();
  }

  void onSignUpTap() {
    Get.toNamed(Routes.register);
  }

  void onForgotPasswordTap() {
    Get.toNamed(Routes.forgotPassword);
  }

  void validateForm() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.toNamed(
        Routes.otpVerify,
        arguments: {'isLogin': true, 'email': emailController.text},
      );
    }
  }
}
