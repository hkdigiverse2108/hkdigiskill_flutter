import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/routes/routes.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  void validateForm() {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.toNamed(Routes.otpVerify, arguments: {'email': emailController.text});
    }
  }

  void onSendOtpTap() {
    validateForm();
  }

  void onSignUpTap() {
    Get.toNamed(Routes.register);
  }

  void onForgotEmailTap() {
    //
  }

  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
