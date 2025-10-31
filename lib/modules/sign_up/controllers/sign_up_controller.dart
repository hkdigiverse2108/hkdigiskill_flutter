import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/routes/routes.dart';

class SignUpController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final designationController = TextEditingController();
  final referralCodeController = TextEditingController();

  var isAgree = false.obs;

  void onAgreeChanged(bool value) {
    isAgree.value = value;
  }

  void onSignUpTap() {
    validateForm();
  }

  void onSignInTap() {
    Get.back();
  }

  void onTermsTap() {
    // Get.toNamed(Routes.terms);
  }

  void validateForm() {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        designationController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    designationController.dispose();
    referralCodeController.dispose();
    super.onClose();
  }
}
